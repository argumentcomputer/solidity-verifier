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

# ....

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
for item in l_u_secondary_X:
    print(item, formatNumber(item))

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
    )
)

parsedData = ProofData(
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
)

PRIVATE_KEY = "0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80"
CONTRACT_ADDRESS = "0xe7f1725e7734ce288f8367e1bb143e90bb3f0512"
PUSH_TO_PROOF_FUNC_SIG = "pushToProof(((uint256,uint256[]),(uint256,uint256,uint256[],uint256),(uint256,uint256,uint256[],uint256)))"

# expects hex number as string without '0x'
def addNumber(number):
    num = bytearray.fromhex(('{0:0{1}x}'.format(int(number, 16), 64)))
    num.reverse()
    return str(int("0x" + "{0:0{1}x}".format(int(binascii.hexlify(num), 16), 64), 0))

def addNumbersArray(numbers):
    nums = '['
    # add body
    for num in numbers[:len(numbers) - 1]:
        nums = nums + addNumber(num) + ','
    # add tail
    nums = nums + addNumber(numbers[len(numbers) - 1])
    return nums + ']'

def pushToProof(data):
    command = 'cast send' + ' '
    command = command + CONTRACT_ADDRESS + ' \"'
    command = command + PUSH_TO_PROOF_FUNC_SIG + '\" \"(('
    command = command + addNumber(data.l_u_secondary_comm_W_comm) + ','
    command = command + addNumbersArray(data.l_u_secondary_X) + '),('
    command = command + addNumber(data.r_u_primary_comm_W_comm) + ','
    command = command + addNumber(data.r_u_primary_comm_E_comm) + ','
    command = command + addNumbersArray(data.r_u_primary_X) + ','
    command = command + addNumber(data.r_u_primary_u) + '),('
    command = command + addNumber(data.r_u_secondary_comm_W_comm) + ','
    command = command + addNumber(data.r_u_secondary_comm_E_comm) + ','
    command = command + addNumbersArray(data.r_u_secondary_X) + ','
    command = command + addNumber(data.r_u_secondary_u) + '))\" '
    command = command + '--private-key ' + PRIVATE_KEY
    #print(command)
    os.system(command)


pushToProof(parsedData)