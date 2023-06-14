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
        return (0, 0, 0)

    # compute x^3 + 5 and take sqrt of it in order to get y
    x2 = (x * x) % modulus
    x3 = (x2 * x) % modulus
    x3 = (x3 + 5) % modulus
    y = modular_sqrt(x3, modulus)

    sign = ((y & 0xff) & 1)

    if ((ysign ^ sign) == 1):
        y = (modulus - y) % modulus

    return (x, y, 1)

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


def multiEvaluationDataPrimary(data):
    o = ""
    o += "pragma solidity ^0.8.0;\n"
    o += "\n"
    o += "import \"src/pasta/Pallas.sol\";\n"
    o += "import \"src/pasta/Vesta.sol\";\n"
    o += "\n"
    o += "library PrimaryCksLib {\n"
    o += "function loadData() public view returns (Pallas.PallasAffinePoint[] memory){\n"
    o += "Pallas.PallasAffinePoint[] memory cks_primary = new Pallas.PallasAffinePoint[](" + str(len(data.ck_s_primary)) + ");\n"

    index = 0
    for ck_s_primary_item in data.ck_s_primary:
        (x, y, z) = uncompressPoint(ck_s_primary_item, PALLAS_MODULUS)
        o += "cks_primary[" + str(index) + "] = Pallas.IntoAffine(Pallas.PallasProjectivePoint(0x" + '{0:0{1}x}'.format(x, 64) + ", 0x" + '{0:0{1}x}'.format(y, 64) + ", 0x" + '{0:0{1}x}'.format(z, 64) + "));\n"
        index = index + 1

    o += "return cks_primary;\n"
    o += "}\n"
    o += "}\n"

    o += "library CkvPrimaryLib {\n"
    o += "function loadData() public view returns (Pallas.PallasAffinePoint[] memory){\n"
    o += "Pallas.PallasAffinePoint[] memory ck_v_primary = new Pallas.PallasAffinePoint[](" + str(len(data.ck_v_primary)) + ");\n"
    index = 0
    # TODO investigate uncompression failing that occurs for rest of the data
    for ck_v_primary_item in data.ck_v_primary[:50000]:
        (x, y, z) = uncompressPoint(ck_v_primary_item, PALLAS_MODULUS)
        o += "ck_v_primary[" + str(index) + "] = Pallas.IntoAffine(Pallas.PallasProjectivePoint(0x" + '{0:0{1}x}'.format(x, 64) + ", 0x" + '{0:0{1}x}'.format(y, 64) + ", 0x" + '{0:0{1}x}'.format(z, 64) + "));\n"
        index = index + 1

    o += "return ck_v_primary;\n"

    o += "}\n"
    o += "}\n"
    return o

def multiEvaluationDataSecondary(data):
    print("multiEvaluationDataSecondaryCks")
    o = ""
    return o




vk_file = sys.argv[1]
if not os.path.exists(vk_file):
    print("verifier-key (json) input file is missing")
    exit(1)

vk_f = open(os.path.basename(vk_file))
vk_data = json.load(vk_f)

vk_primary = vk_data['vk_primary']
vk_ee_primary = vk_primary['vk_ee']
ck_v_primary = vk_ee_primary['ck_v']
ck_v_ck_primary = ck_v_primary['ck']

ck_s_primary = vk_ee_primary['ck_s']
ck_s_ck_primary = ck_s_primary['ck']

vk_secondary = vk_data['vk_secondary']
vk_ee_secondary = vk_secondary['vk_ee']
ck_v_secondary = vk_ee_secondary['ck_v']
ck_v_ck_secondary = ck_v_secondary['ck']

ck_s_secondary = vk_ee_secondary['ck_s']
ck_s_ck_secondary = ck_s_secondary['ck']

InnerProductArgumentData = namedtuple(
    '_InnerProductArgumentData', (
        'ck_s_primary',
        'ck_v_primary',

        'ck_s_secondary',
        'ck_v_secondary',
    )
)

parsedData = InnerProductArgumentData(
    ck_s_ck_primary,
    ck_v_ck_primary,
    ck_s_ck_secondary,
    ck_v_ck_secondary,
)

print("// Do not change manually. This contract has been auto-generated by", sys.argv[0])
primary = sys.argv[2]
if primary == 'primary' :
    data = multiEvaluationDataPrimary(parsedData)
    print(data)
elif primary == 'secondary' :
    data = multiEvaluationDataSecondary(parsedData)
    print(data)
else :
    print("Unsupported type of data! Use either 'primary' or 'secondary'")