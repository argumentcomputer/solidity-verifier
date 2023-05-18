from collections import namedtuple
import json
import os
import sys
import binascii

PALLAS_MODULUS = 28948022309329048855892746252171976963363056481941560715954676764349967630337
VESTA_MODULUS = 28948022309329048855892746252171976963363056481941647379679742748393362948097

def uncompressPoint(xCoordinate, modulus):
    x = bytearray.fromhex(xCoordinate)
    ysign = x[31] >> 7
    x[31] &= 0x7f
    x.reverse()
    x = int(binascii.hexlify(x), 16)

    if ((x == 0) & (ysign == 0)):
        return (0, 0, 1)

    # compute x^3 + 5 and take sqrt of it in order to get y
    x2 = (x * x) % modulus
    x3 = (x2 * x) % modulus
    x3 = (x3 + 5) % modulus
    y = modular_sqrt(x3, modulus)

    sign = ((y & 0xff) & 1)

    if ((ysign ^ sign) == 1):
        y = (modulus - y) % modulus

    return (x, y, 0)

def modular_sqrt(a, p):

    def legendre_symbol(a, p):
        """ Compute the Legendre symbol a|p using
            Euler's criterion. p is a prime, a is
            relatively prime to p (if p divides
            a, then a|p = 0)
            Returns 1 if a has a square root modulo
            p, -1 otherwise.
        """
        ls = pow(a, (p - 1) // 2, p)
        return -1 if ls == p - 1 else ls

    """ Find a quadratic residue (mod p) of 'a'. p
        must be an odd prime.
        Solve the congruence of the form:
            x^2 = a (mod p)
        And returns x. Note that p - x is also a root.
        0 is returned is no square root exists for
        these a and p.
        The Tonelli-Shanks algorithm is used (except
        for some simple cases in which the solution
        is known from an identity). This algorithm
        runs in polynomial time (unless the
        generalized Riemann hypothesis is false).
    """
    # Simple cases
    #
    if legendre_symbol(a, p) != 1:
        return 0
    elif a == 0:
        return 0
    elif p == 2:
        return p
    elif p % 4 == 3:
        return pow(a, (p + 1) // 4, p)

    # Partition p-1 to s * 2^e for an odd s (i.e.
    # reduce all the powers of 2 from p-1)
    #
    s = p - 1
    e = 0
    while s % 2 == 0:
        s //= 2
        e += 1

    # Find some 'n' with a legendre symbol n|p = -1.
    # Shouldn't take long.
    #
    n = 2
    while legendre_symbol(n, p) != -1:
        n += 1

    # Here be dragons!
    # Read the paper "Square roots from 1; 24, 51,
    # 10 to Dan Shanks" by Ezra Brown for more
    # information
    #

    # x is a guess of the square root that gets better
    # with each iteration.
    # b is the "fudge factor" - by how much we're off
    # with the guess. The invariant x^2 = ab (mod p)
    # is maintained throughout the loop.
    # g is used for successive powers of n to update
    # both a and b
    # r is the exponent - decreases with each update
    #
    x = pow(a, (s + 1) // 2, p)
    b = pow(a, s, p)
    g = pow(n, s, p)
    r = e

    while True:
        t = b
        m = 0
        for m in range(r):
            if t == 1:
                break
            t = pow(t, 2, p)

        if m == 0:
            return x

        gs = pow(g, 2 ** (r - m - 1), p)
        g = (gs * gs) % p
        x = (x * gs) % p
        b = (b * g) % p
        r = m

def getLimbs(input):
    val = int(input, 16)
    limb3 = reverseLimb(val & 0x000000000000000000000000000000000000000000000000ffffffffffffffff)
    limb2 = reverseLimb((val & 0x00000000000000000000000000000000ffffffffffffffff0000000000000000) >> 64)
    limb1 = reverseLimb((val & 0x0000000000000000ffffffffffffffff00000000000000000000000000000000) >> 128)
    limb0 = reverseLimb(((val & 0xffffffffffffffff000000000000000000000000000000000000000000000000) >> 192))
    return (limb0, limb1, limb2, limb3)

def reverseLimb(input):
    hex = bytearray.fromhex(format(input, 'x'))
    hex.reverse()
    return int(binascii.hexlify(hex), 16)

def step2DataContractGen(data):
    o = ""
    o = o + "pragma solidity ^0.8.0;\n"

    o = o + "library PoseidonConstants {\n"
    o = o + "struct Pallas {\n"
    o = o + "uint256[] mixConstants;\n"
    o = o + "uint256[] addRoundConstants;\n"
    o = o + "}\n"
    o = o + "struct Vesta {\n"
    o = o + "uint256[] mixConstants;\n"
    o = o + "uint256[] addRoundConstants;\n"
    o = o + "}\n"
    o = o + "function loadPallasConstants(uint256[] memory mixConstants, uint256[] memory addRoundConstants) internal pure returns (Pallas memory) {\n"
    o = o + "return Pallas(mixConstants, addRoundConstants);\n"
    o = o + "}\n"
    o = o + "function loadVestaConstants(uint256[] memory mixConstants, uint256[] memory addRoundConstants) internal pure returns (Vesta memory) {\n"
    o = o + "return Vesta(mixConstants, addRoundConstants);\n"
    o = o + "}\n"
    o = o + "function getPoseidonConstantsForBasicComparison() public pure returns (Pallas memory, Vesta memory){\n"

    # primary constants
    o = o + "uint256[] memory mixConstantsPallas = new uint256[](" + str(len(data.constants_mixConstantsPrimary[0])) + ");\n"
    index = 0
    for mixConstant in data.constants_mixConstantsPrimary[0]:
        val = bytearray.fromhex(('{0:0{1}x}'.format(int(mixConstant, 16), 64)))
        val.reverse()
        o = o + "mixConstantsPallas[" + str(index) + "] = 0x" + "{0:0{1}x}".format(int(binascii.hexlify(val), 16), 64) + ";\n"
        index = index + 1

    o = o + "uint256[] memory addRoundConstantsPallas = new uint256[](" + str(len(data.constants_addRoundConstantsPrimary)) + ");\n"
    index = 0
    for addRoundConstant in data.constants_addRoundConstantsPrimary:
        val = bytearray.fromhex(('{0:0{1}x}'.format(int(addRoundConstant, 16), 64)))
        val.reverse()
        o = o + "addRoundConstantsPallas[" + str(index) + "] = 0x" + "{0:0{1}x}".format(int(binascii.hexlify(val), 16), 64) + ";\n"
        index = index + 1

    o = o + "Pallas memory pallas = loadPallasConstants(mixConstantsPallas, addRoundConstantsPallas);\n"

    # secondary constants
    o = o + "uint256[] memory mixConstantsVesta = new uint256[](" + str(len(data.constants_mixConstantsSecondary[0])) + ");\n"
    index = 0
    for mixConstant in data.constants_mixConstantsSecondary[0]:
        val = bytearray.fromhex(('{0:0{1}x}'.format(int(mixConstant, 16), 64)))
        val.reverse()
        o = o + "mixConstantsVesta[" + str(index) + "] = 0x" + "{0:0{1}x}".format(int(binascii.hexlify(val), 16), 64) + ";\n"
        index = index + 1

    o = o + "uint256[] memory addRoundConstantsVesta = new uint256[](" + str(len(data.constants_addRoundConstantsSecondary)) + ");\n"
    index = 0
    for addRoundConstant in data.constants_addRoundConstantsSecondary:
        val = bytearray.fromhex(('{0:0{1}x}'.format(int(addRoundConstant, 16), 64)))
        val.reverse()
        o = o + "addRoundConstantsVesta[" + str(index) + "] = 0x" + "{0:0{1}x}".format(int(binascii.hexlify(val), 16), 64) + ";\n"
        index = index + 1

    o = o + "Vesta memory vesta = loadVestaConstants(mixConstantsVesta, addRoundConstantsVesta);\n"
    o = o + "return (pallas, vesta);\n"
    o = o + "}\n"
    o = o + "}\n"

    o = o + "library CommitmentLib {\n"
    o = o + "struct Commitment {\n"
    o = o + "uint256 X;\n"
    o = o + "uint256 Y;\n"
    o = o + "uint256 Z;\n"
    o = o + "}\n"
    o = o + "function loadCommitment(uint256 x, uint256 y, uint256 z) public pure returns (Commitment memory) {\n"
    o = o + "return Commitment(x, y, z);\n"
    o = o + "}\n"
    o = o + "}\n"

    o = o + "library RelaxedR1CSInstanceLib {\n"
    o = o + "struct RelaxedR1CSInstance {\n"
    o = o + "CommitmentLib.Commitment comm_W;\n"
    o = o + "CommitmentLib.Commitment comm_E;\n"
    o = o + "uint256[] X;\n"
    o = o + "uint256 u;\n"
    o = o + "}\n"
    o = o + "function loadRelaxedR1CSInstance(CommitmentLib.Commitment memory comm_W,CommitmentLib.Commitment memory comm_E, uint256[] memory X, uint256 u) public pure returns (RelaxedR1CSInstance memory) {\n"
    o = o + "return RelaxedR1CSInstance(comm_W, comm_E, X, u);\n"
    o = o + "}\n"
    o = o + "}\n"

    o = o + "library NovaVerifierStep2DataLib {\n"
    o = o + "struct CompressedSnarkStep2Primary {\n"
    o = o + "uint256[] zn_primary;\n"
    o = o + "RelaxedR1CSInstanceLib.RelaxedR1CSInstance r_U_secondary;\n"
    o = o + "uint256 expected_l_u_primary_X_1;\n"
    o = o + "}\n"

    o = o + "struct CompressedSnarkStep2Secondary {\n"
    o = o + "uint256[] zn_secondary;\n"
    o = o + "RelaxedR1CSInstanceLib.RelaxedR1CSInstance r_U_primary;\n"
    o = o + "uint256 expected_l_u_secondary_X_1;\n"
    o = o + "}\n"

    o = o + "struct VerifierKeyStep2 {\n"
    o = o + "uint256 f_arity_primary;\n"
    o = o + "uint256 f_arity_secondary;\n"
    o = o + "uint256 r1cs_shape_primary_digest;\n"
    o = o + "uint256 r1cs_shape_secondary_digest;\n"
    o = o + "}\n"

    # getCompressedSnarkStep2Primary
    o = o + "function getCompressedSnarkStep2Primary() public pure returns (CompressedSnarkStep2Primary memory) {\n"
    zn_primary_len = len(data.zn_primary)
    o = o + "uint256[] memory zn_primary = new uint256[](" + str(zn_primary_len) + ");\n"
    index = 0
    for zn_primary_item in data.zn_primary:
        val = bytearray.fromhex(('{0:0{1}x}'.format(int(zn_primary_item, 16), 64)))
        val.reverse()
        o = o + "zn_primary[" + str(index) + "] = 0x" + "{0:0{1}x}".format(int(binascii.hexlify(val), 16), 64) + ";\n"
        index = index + 1

    (comm_W_X, comm_W_Y, comm_W_Z) = uncompressPoint(data.r_u_secondary_comm_W_comm, VESTA_MODULUS)
    o = o + "uint256 comm_W_X = 0x" + '{0:0{1}x}'.format(comm_W_X, 64) + ";\n"
    o = o + "uint256 comm_W_Y = 0x" + '{0:0{1}x}'.format(comm_W_Y, 64) + ";\n"
    o = o + "uint256 comm_W_Z = 0x" + '{0:0{1}x}'.format(comm_W_Z, 64) + ";\n"
    o = o + "CommitmentLib.Commitment memory comm_W = CommitmentLib.loadCommitment(comm_W_X, comm_W_Y, comm_W_Z);\n"

    (comm_E_X, comm_E_Y, comm_E_Z) = uncompressPoint(data.r_u_secondary_comm_E_comm, VESTA_MODULUS)
    o = o + "uint256 comm_E_X = 0x" + '{0:0{1}x}'.format(comm_E_X, 64) + ";\n"
    o = o + "uint256 comm_E_Y = 0x" + '{0:0{1}x}'.format(comm_E_Y, 64) + ";\n"
    o = o + "uint256 comm_E_Z = 0x" + '{0:0{1}x}'.format(comm_E_Z, 64) + ";\n"
    o = o + "CommitmentLib.Commitment memory comm_E = CommitmentLib.loadCommitment(comm_E_X, comm_E_Y, comm_E_Z);\n"

    o = o + "uint256[] memory X = new uint256[](" + str(len(data.r_u_secondary_X)) + " * 4);\n"
    index = 0
    for X in data.r_u_secondary_X:
        # every field element has 4 limbs
        (limb0, limb1, limb2, limb3) = getLimbs(X)
        o = o + "X[" + str(index) + "] = 0x" + '{0:0{1}x}'.format(limb0, 64) + ";\n"
        o = o + "X[" + str(index + 1) + "] = 0x" + '{0:0{1}x}'.format(limb1, 64) + ";\n"
        o = o + "X[" + str(index + 2) + "] = 0x" + '{0:0{1}x}'.format(limb2, 64) + ";\n"
        o = o + "X[" + str(index + 3) + "] = 0x" + '{0:0{1}x}'.format(limb3, 64) + ";\n"
        index = index + 4

    u = bytearray.fromhex(('{0:0{1}x}'.format(int(data.r_u_secondary_u, 16), 64)))
    u.reverse()
    o = o + "uint256 u = 0x" + "{0:0{1}x}".format(int(binascii.hexlify(u), 16), 64) + ";\n"
    o = o + "RelaxedR1CSInstanceLib.RelaxedR1CSInstance memory relaxedR1csInstance = RelaxedR1CSInstanceLib.loadRelaxedR1CSInstance(comm_W, comm_E, X, u);\n"
    expected_l_u_primary_X_1 = bytearray.fromhex(('{0:0{1}x}'.format(int(data.l_u_primary_x[1], 16), 64)))
    expected_l_u_primary_X_1.reverse()
    o = o + "uint256 expected_l_u_primary_X_1 = 0x" + "{0:0{1}x}".format(int(binascii.hexlify(expected_l_u_primary_X_1), 16), 64)  + ";\n"
    o = o + "return CompressedSnarkStep2Primary(zn_primary, relaxedR1csInstance, expected_l_u_primary_X_1);\n"
    o = o + "}\n"

    # getCompressedSnarkStep2Secondary
    o = o + "function getCompressedSnarkStep2Secondary() public pure returns (CompressedSnarkStep2Secondary memory) {\n"
    zn_secondary_len = len(data.zn_secondary)
    o = o + "uint256[] memory zn_secondary = new uint256[](" + str(zn_secondary_len) + ");\n"
    index = 0
    for zn_secondary_item in data.zn_secondary:
        val = bytearray.fromhex(('{0:0{1}x}'.format(int(zn_secondary_item, 16), 64)))
        val.reverse()
        o = o + "zn_secondary[" + str(index) + "] = 0x" + "{0:0{1}x}".format(int(binascii.hexlify(val), 16), 64) + ";\n"
        index = index + 1


    (comm_W_X, comm_W_Y, comm_W_Z) = uncompressPoint(data.r_u_primary_comm_W_comm, PALLAS_MODULUS)
    o = o + "uint256 comm_W_X = 0x" + '{0:0{1}x}'.format(comm_W_X, 64) + ";\n"
    o = o + "uint256 comm_W_Y = 0x" + '{0:0{1}x}'.format(comm_W_Y, 64) + ";\n"
    o = o + "uint256 comm_W_Z = 0x" + '{0:0{1}x}'.format(comm_W_Z, 64) + ";\n"
    o = o + "CommitmentLib.Commitment memory comm_W = CommitmentLib.loadCommitment(comm_W_X, comm_W_Y, comm_W_Z);\n"

    (comm_E_X, comm_E_Y, comm_E_Z) = uncompressPoint(data.r_u_primary_comm_E_comm, PALLAS_MODULUS)
    o = o + "uint256 comm_E_X = 0x" + '{0:0{1}x}'.format(comm_E_X, 64) + ";\n"
    o = o + "uint256 comm_E_Y = 0x" + '{0:0{1}x}'.format(comm_E_Y, 64) + ";\n"
    o = o + "uint256 comm_E_Z = 0x" + '{0:0{1}x}'.format(comm_E_Z, 64) + ";\n"
    o = o + "CommitmentLib.Commitment memory comm_E = CommitmentLib.loadCommitment(comm_E_X, comm_E_Y, comm_E_Z);\n"

    o = o + "uint256[] memory X = new uint256[](" + str(len(data.r_u_primary_X)) + " * 4);\n"
    index = 0
    for X in data.r_u_primary_X:
        # every field element has 4 limbs
        (limb0, limb1, limb2, limb3) = getLimbs(X)
        o = o + "X[" + str(index) + "] = 0x" + '{0:0{1}x}'.format(limb0, 64) + ";\n"
        o = o + "X[" + str(index + 1) + "] = 0x" + '{0:0{1}x}'.format(limb1, 64) + ";\n"
        o = o + "X[" + str(index + 2) + "] = 0x" + '{0:0{1}x}'.format(limb2, 64) + ";\n"
        o = o + "X[" + str(index + 3) + "] = 0x" + '{0:0{1}x}'.format(limb3, 64) + ";\n"
        index = index + 4


    u = bytearray.fromhex(('{0:0{1}x}'.format(int(data.r_u_primary_u, 16), 64)))
    u.reverse()
    o = o + "uint256 u = 0x" + "{0:0{1}x}".format(int(binascii.hexlify(u), 16), 64) + ";\n"
    o = o + "RelaxedR1CSInstanceLib.RelaxedR1CSInstance memory relaxedR1csInstance = RelaxedR1CSInstanceLib.loadRelaxedR1CSInstance(comm_W, comm_E, X, u);\n"

    expected_l_u_secondary_X_1 = bytearray.fromhex(('{0:0{1}x}'.format(int(data.l_u_secondary_x[1], 16), 64)))
    expected_l_u_secondary_X_1.reverse()
    o = o + "uint256 expected_l_u_secondary_X_1 = 0x" + "{0:0{1}x}".format(int(binascii.hexlify(expected_l_u_secondary_X_1), 16), 64)  + ";\n"
    o = o + "return CompressedSnarkStep2Secondary(zn_secondary, relaxedR1csInstance, expected_l_u_secondary_X_1);\n"
    o = o + "}\n"

    # getVerifierKeyStep2
    o = o + "function getVerifierKeyStep2() public pure returns (VerifierKeyStep2 memory) {\n"
    o = o + "uint256 f_arity_primary = " + str(data.f_arity_primary) + ";\n"
    o = o + "uint256 f_arity_secondary = " + str(data.f_arity_secondary) + ";\n"

    r1cs_shape_secondary_digest = bytearray.fromhex(('{0:0{1}x}'.format(int(data.r1cs_shape_secondary_digest, 16), 64)))
    r1cs_shape_secondary_digest.reverse()
    o = o + "uint256 r1cs_shape_secondary_digest = 0x" + "{0:0{1}x}".format(int(binascii.hexlify(r1cs_shape_secondary_digest), 16), 64) + ";\n"

    r1cs_shape_primary_digest = bytearray.fromhex(('{0:0{1}x}'.format(int(data.r1cs_shape_primary_digest, 16), 64)))
    r1cs_shape_primary_digest.reverse()
    o = o + "uint256 r1cs_shape_primary_digest = 0x" + "{0:0{1}x}".format(int(binascii.hexlify(r1cs_shape_primary_digest), 16), 64) + ";\n"

    o = o + "return VerifierKeyStep2(f_arity_primary, f_arity_secondary, r1cs_shape_primary_digest, r1cs_shape_secondary_digest);\n"
    o = o + "}\n"

    o = o + "}\n"

    return o

vk_file = sys.argv[1]
if not os.path.exists(vk_file):
    print("verifier-key (json) input file is missing")
    exit(1)

vk_f = open(os.path.basename(vk_file))
vk_data = json.load(vk_f)

# Parse VerifyingKey
f_arity_primary = vk_data['F_arity_primary']
f_arity_secondary = vk_data['F_arity_secondary']
r1cs_shape_primary_digest = vk_data['r1cs_shape_primary_digest']
r1cs_shape_secondary_digest = vk_data['r1cs_shape_secondary_digest']

ro_consts_primary = vk_data['ro_consts_primary']
mds = ro_consts_primary['mds']
constants_mixConstantsPrimary = mds['m']
constants_addRoundConstantsPrimary = ro_consts_primary['crc']

ro_consts_secondary = vk_data['ro_consts_secondary']
mds = ro_consts_secondary['mds']
constants_mixConstantsSecondary = mds['m']
constants_addRoundConstantsSecondary = ro_consts_secondary['crc']

proof_file = sys.argv[2]
if not os.path.exists(proof_file):
    print("compressed snark (json) input file is missing")
    exit(1)

proof_f = open(os.path.basename(proof_file))
proof_data = json.load(proof_f)

# Parse CompressedSnark

# zn_primary
zn_primary = proof_data['zn_primary']

# zn_secondary
zn_secondary = proof_data['zn_secondary']

# l_u_primary
l_u_primary = proof_data['l_u_primary']
l_u_primary_x = l_u_primary['X']

# l_u_secondary
l_u_secondary = proof_data['l_u_secondary']
l_u_secondary_x = l_u_secondary['X']

# r_u_secondary
r_u_secondary = proof_data['r_U_secondary']
r_u_secondary_u = r_u_secondary['u']

r_u_secondary_X = r_u_secondary['X']

r_u_secondary_comm_E = r_u_secondary['comm_E']
r_u_secondary_comm_E_comm = r_u_secondary_comm_E['comm']

r_u_secondary_comm_W = r_u_secondary['comm_W']
r_u_secondary_comm_W_comm = r_u_secondary_comm_W['comm']

# r_u_primary
r_u_primary = proof_data['r_U_primary']
r_u_primary_u = r_u_primary['u']

r_u_primary_X = r_u_primary['X']

r_u_primary_comm_E = r_u_primary['comm_E']
r_u_primary_comm_E_comm = r_u_primary_comm_E['comm']

r_u_primary_comm_W = r_u_primary['comm_W']
r_u_primary_comm_W_comm = r_u_primary_comm_W['comm']

Step2VerifierData = namedtuple(
    '_Step2VerifierData', (
        'constants_mixConstantsPrimary',
        'constants_addRoundConstantsPrimary',
        'constants_mixConstantsSecondary',
        'constants_addRoundConstantsSecondary',

        'f_arity_primary',
        'r1cs_shape_secondary_digest',
        'zn_primary',
        'l_u_primary_x',
        'r_u_secondary_u',
        'r_u_secondary_X',
        'r_u_secondary_comm_E_comm',
        'r_u_secondary_comm_W_comm',

        'f_arity_secondary',
        'r1cs_shape_primary_digest',
        'zn_secondary',
        'l_u_secondary_x',
        'r_u_primary_u',
        'r_u_primary_X',
        'r_u_primary_comm_E_comm',
        'r_u_primary_comm_W_comm'
    )
)

parsedData = Step2VerifierData(
    constants_mixConstantsPrimary,
    constants_addRoundConstantsPrimary,
    constants_mixConstantsSecondary,
    constants_addRoundConstantsSecondary,

    f_arity_primary,
    r1cs_shape_secondary_digest,
    zn_primary,
    l_u_primary_x,
    r_u_secondary_u,
    r_u_secondary_X,
    r_u_secondary_comm_E_comm,
    r_u_secondary_comm_W_comm,

    f_arity_secondary,
    r1cs_shape_primary_digest,
    zn_secondary,
    l_u_secondary_x,
    r_u_primary_u,
    r_u_primary_X,
    r_u_primary_comm_E_comm,
    r_u_primary_comm_W_comm,
)

data = step2DataContractGen(parsedData)

print(data)
