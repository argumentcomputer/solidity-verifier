from collections import namedtuple
import json
import os
import sys
import binascii

def formatNumber(num):
    val = bytearray.fromhex(('{0:0{1}x}'.format(int(num, 16), 64)))
    val.reverse()
    return str(int("0x" + "{0:0{1}x}".format(int(binascii.hexlify(val), 16), 64), 0))

vk_file = sys.argv[1]
if not os.path.exists(vk_file):
    print("verifier-key (json) input file is missing")
    exit(1)

vk_f = open(os.path.basename(vk_file))
vk_data = json.load(vk_f)

ro_consts_primary = vk_data['ro_consts_primary']
mds = ro_consts_primary['mds']
# uint256[]
constants_mixConstantsPrimary = mds['m']
#print("mix")
#for item in constants_mixConstantsPrimary[0]:
#    print(item, formatNumber(item))

# uint256[]
constants_addRoundConstantsPrimary = ro_consts_primary['crc']
#print("arc")
#for item in constants_addRoundConstantsPrimary[0:25]:
#    print(item, formatNumber(item))


ro_consts_secondary = vk_data['ro_consts_secondary']
mds = ro_consts_secondary['mds']
# uint256[]
constants_mixConstantsSecondary = mds['m']
# uint256[]
constants_addRoundConstantsSecondary = ro_consts_secondary['crc']
# uint256
f_arity_primary = vk_data['F_arity_primary']
#print("f_arity_primary: ", f_arity_primary)
# uint256
f_arity_secondary = vk_data['F_arity_secondary']
#print("f_arity_secondary: ", f_arity_secondary)
# uint256
digest = vk_data['digest']
#print("digest: ", digest)

compressed_snark_file = sys.argv[2]
if not os.path.exists(compressed_snark_file):
    print("compressed-snark (json) input file is missing")
    exit(1)

proof_f = open(os.path.basename(compressed_snark_file))
proof_data = json.load(proof_f)

l_u_secondary = proof_data['l_u_secondary']
l_u_secondary_comm_W = l_u_secondary['comm_W']

r_u_primary = proof_data['r_U_primary']
r_u_primary_comm_W = r_u_primary['comm_W']
r_u_primary_comm_E = r_u_primary['comm_E']

r_u_secondary = proof_data['r_U_secondary']
r_u_secondary_comm_W = r_u_secondary['comm_W']
r_u_secondary_comm_E = r_u_secondary['comm_E']


# uint256
l_u_secondary_comm_W_comm = l_u_secondary_comm_W['comm']
#print("l_u_secondary_comm_W_comm: ", l_u_secondary_comm_W_comm, formatNumber(l_u_secondary_comm_W_comm))
# uint256[]
l_u_secondary_X = l_u_secondary['X']
#print("l_u_secondary_X")
#for item in l_u_secondary_X:
#    print(item, formatNumber(item))

# uint256
r_u_primary_comm_W_comm = r_u_primary_comm_W['comm']
#print("r_u_primary_comm_W_comm: ", r_u_primary_comm_W_comm, formatNumber(r_u_primary_comm_W_comm))
# uint256
r_u_primary_comm_E_comm = r_u_primary_comm_E['comm']
#print("r_u_primary_comm_E_comm: ", r_u_primary_comm_E_comm, formatNumber(r_u_primary_comm_E_comm))
# uint256[]
r_u_primary_X = r_u_primary['X']
#print("r_u_primary_X")
#for item in r_u_primary_X:
#    print(item, formatNumber(item))
# uint256
r_u_primary_u = r_u_primary['u']
#print("r_u_primary_u: ", r_u_primary_u, formatNumber(r_u_primary_u))

# uint256
r_u_secondary_comm_W_comm = r_u_secondary_comm_W['comm']
#print("r_u_secondary_comm_W_comm: ", r_u_secondary_comm_W_comm, formatNumber(r_u_secondary_comm_W_comm))
# uint256
r_u_secondary_comm_E_comm = r_u_secondary_comm_E['comm']
#print("r_u_secondary_comm_E_comm: ", r_u_secondary_comm_E_comm, formatNumber(r_u_secondary_comm_E_comm))
# uint256[]
r_u_secondary_X = r_u_secondary['X']
#print("r_u_secondary_X")
#for item in r_u_secondary_X:
#    print(item, formatNumber(item))
# uint256
r_u_secondary_u = r_u_secondary['u']
#print("r_u_secondary_u: ", r_u_secondary_u, formatNumber(r_u_secondary_u))


# uint256
zn_primary = proof_data['zn_primary']
#print("zn_primary")
#for item in zn_primary:
#    print(item, formatNumber(item))

# uint256
zn_secondary = proof_data['zn_secondary']
#print("zn_secondary")
#for item in zn_secondary:
#    print(item, formatNumber(item))


ProofData = namedtuple(
    '_ProofData', (
        'l_u_secondary_comm_W_comm',
        'l_u_secondary_X',

        'r_u_primary_comm_W_comm',
        'r_u_primary_comm_E_comm',
        'r_u_primary_X',
        'r_u_primary_u',

        'r_u_secondary_comm_W_comm',
        'r_u_secondary_comm_E_comm',
        'r_u_secondary_X',
        'r_u_secondary_u',

        'zn_primary',
        'zn_secondary',
    )
)

parsedProof = ProofData(
    l_u_secondary_comm_W_comm,
    l_u_secondary_X,

    r_u_primary_comm_W_comm,
    r_u_primary_comm_E_comm,
    r_u_primary_X,
    r_u_primary_u,

    r_u_secondary_comm_W_comm,
    r_u_secondary_comm_E_comm,
    r_u_secondary_X,
    r_u_secondary_u,

    zn_primary,
    zn_secondary,
)

VerifierKey = namedtuple (
    '_VerifierKey', (
        'constants_mixConstantsPrimary',
        'constants_addRoundConstantsPrimary',
        'constants_mixConstantsSecondary',
        'constants_addRoundConstantsSecondary',

        'f_arity_primary',
        'f_arity_secondary',
        'digest',
    )
)

parsedVk = VerifierKey(
    constants_mixConstantsPrimary,
    constants_addRoundConstantsPrimary,
    constants_mixConstantsSecondary,
    constants_addRoundConstantsSecondary,

    f_arity_primary,
    f_arity_secondary,
    digest,
)

PRIVATE_KEY = "0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80"
CONTRACT_ADDRESS = "0x610178da211fef7d417bc0e6fed39f05609ad788"
PUSH_TO_PROOF_FUNC_SIG = "pushToProof(((uint256,uint256[]),(uint256,uint256,uint256[],uint256),(uint256,uint256,uint256[],uint256),uint256[],uint256[]))"
PUSH_TO_VK_FUNC_SIG = "pushToVk((uint256,uint256,uint256,(uint256[],uint256[]),(uint256[],uint256[])))"

# expects hex number as string without '0x'
def addNumber(number, useReversing):
    num = bytearray.fromhex(('{0:0{1}x}'.format(int(number, 16), 64)))
    if useReversing:
        num.reverse()
    return str(int("0x" + "{0:0{1}x}".format(int(binascii.hexlify(num), 16), 64), 0))

def addNumbersArray(numbers, useReversing):
    nums = '['
    # add body
    for num in numbers[:len(numbers) - 1]:
        nums = nums + addNumber(num, useReversing) + ','
    # add tail
    nums = nums + addNumber(numbers[len(numbers) - 1], useReversing)
    return nums + ']'

def pushToProof(data):
    command = 'cast send' + ' '
    command = command + CONTRACT_ADDRESS + ' \"'
    command = command + PUSH_TO_PROOF_FUNC_SIG + '\" \"(('
    command = command + addNumber(data.l_u_secondary_comm_W_comm, False) + ','
    command = command + addNumbersArray(data.l_u_secondary_X, True) + '),('
    command = command + addNumber(data.r_u_primary_comm_W_comm, False) + ','
    command = command + addNumber(data.r_u_primary_comm_E_comm, False) + ','
    command = command + addNumbersArray(data.r_u_primary_X, True) + ','
    command = command + addNumber(data.r_u_primary_u, True) + '),('
    command = command + addNumber(data.r_u_secondary_comm_W_comm, False) + ','
    command = command + addNumber(data.r_u_secondary_comm_E_comm, False) + ','
    command = command + addNumbersArray(data.r_u_secondary_X, True) + ','
    command = command + addNumber(data.r_u_secondary_u, True) + '),'
    command = command + addNumbersArray(data.zn_primary, True) + ','
    command = command + addNumbersArray(data.zn_secondary, True) + ')\" '
    command = command + '--private-key ' + PRIVATE_KEY
    os.system(command)



# TODO currently it pushes only constants for a single round of Poseidon just for comparison with hardcoded ones in Poseidon Solidity contract
def pushToVk(data):
    command = 'cast send' + ' '
    command = command + CONTRACT_ADDRESS + ' \"'
    command = command + PUSH_TO_VK_FUNC_SIG + '\" \"('
    command = command + addNumber(hex(data.f_arity_primary), False) + ','
    command = command + addNumber(hex(data.f_arity_secondary), False) + ','
    command = command + addNumber(data.digest, True) + ',('
    command = command + addNumbersArray(data.constants_mixConstantsPrimary[0], True) + ','
    command = command + addNumbersArray(data.constants_addRoundConstantsPrimary, True) + '),('
    command = command + addNumbersArray(data.constants_mixConstantsSecondary[0], True) + ','
    command = command + addNumbersArray(data.constants_addRoundConstantsSecondary, True) + '))\" '
    command = command + '--private-key ' + PRIVATE_KEY
    os.system(command)

pushToProof(parsedProof)
pushToVk(parsedVk)
