from collections import namedtuple
import json
import os
import sys
import binascii

def multiEvaluationDataSecondary(data):
    o = ""
    o = o + "pragma solidity ^0.8.0;\n\n"
    o = o + "library R1CSShapeLibSecondary {\n"
    o = o + "struct Triple {\n"
    o = o + "uint256 index1;\n"
    o = o + "uint256 index2;\n"
    o = o + "uint256 scalar;\n"
    o = o + "}\n"

    #o = o + "struct R1CSShape {\n"
    #o = o + "uint256 num_cons;\n"
    #o = o + "uint256 num_vars;\n"
    #o = o + "uint256 num_io;\n"
    #o = o + "Triple[] A;\n"
    #o = o + "Triple[] B;\n"
    #o = o + "Triple[] C;\n"
    #o = o + "uint256 digest;\n"
    #o = o + "}\n"

    o = o + "function loadDigestSecondary() public pure returns (uint256) {\n"
    digest = bytearray.fromhex(('{0:0{1}x}'.format(int(data.digest_secondary, 16), 64)))
    digest.reverse()
    o = o + "return 0x" + "{0:0{1}x}".format(int(binascii.hexlify(digest), 16), 64) + ";\n"
    o = o + "}\n"

    o = o + "function loadNumConsSecondary() public pure returns (uint256) {\n"
    o = o + "return " + str(data.num_cons_secondary) + ";\n"
    o = o + "}\n"

    o = o + "function loadNumVarsSecondary() public pure returns (uint256) {\n"
    o = o + "return " + str(data.num_vars_secondary) + ";\n"
    o = o + "}\n"

    o = o + "function loadNumIoSecondary() public pure returns (uint256) {\n"
    o = o + "return " + str(data.num_io_secondary) + ";\n"
    o = o + "}\n"

    o = o + "function loadCommASecondary() public pure returns (Triple[] memory){\n"
    o = o + "Triple[] memory A = new Triple[](" + str(len(data.A_secondary)) + ");\n"
    index = 0
    for itemA in data.A_secondary:
        itemA2 = bytearray.fromhex(('{0:0{1}x}'.format(int(itemA[2], 16), 64)))
        itemA2.reverse()
        o = o + "A[" + str(index) + "] = Triple(" + str(itemA[0]) + ", " + str(itemA[1]) + ", 0x" + "{0:0{1}x}".format(int(binascii.hexlify(itemA2), 16), 64) + ");\n"
        index = index + 1

    o = o + "return A;\n"
    o = o + "}\n"


    o = o + "function loadCommBSecondary() public pure returns (Triple[] memory){\n"
    o = o + "Triple[] memory B = new Triple[](" + str(len(data.B_secondary)) + ");\n"
    index = 0
    for itemB in data.B_secondary:
        itemB2 = bytearray.fromhex(('{0:0{1}x}'.format(int(itemB[2], 16), 64)))
        itemB2.reverse()
        o = o + "B[" + str(index) + "] = Triple(" + str(itemB[0]) + ", " + str(itemB[1]) + ", 0x" + "{0:0{1}x}".format(int(binascii.hexlify(itemB2), 16), 64) + ");\n"
        index = index + 1

    o = o + "return B;\n"
    o = o + "}\n"


    o = o + "function loadCommCSecondary() public pure returns (Triple[] memory){\n"
    o = o + "Triple[] memory C = new Triple[](" + str(len(data.C_secondary)) + ");\n"
    index = 0
    for itemC in data.C_secondary:
        itemC2 = bytearray.fromhex(('{0:0{1}x}'.format(int(itemC[2], 16), 64)))
        itemC2.reverse()
        o = o + "C[" + str(index) + "] = Triple(" + str(itemC[0]) + ", " + str(itemC[1]) + ", 0x" + "{0:0{1}x}".format(int(binascii.hexlify(itemC2), 16), 64) + ");\n"
        index = index + 1

    o = o + "return C;\n"
    o = o + "}\n"
    o = o + "}\n"

    return o

def multiEvaluationDataPrimary(data):
    o = ""
    o = o + "pragma solidity ^0.8.0;\n\n"
    o = o + "library R1CSShapeLibPrimary {\n"
    o = o + "struct Triple {\n"
    o = o + "uint256 index1;\n"
    o = o + "uint256 index2;\n"
    o = o + "uint256 scalar;\n"
    o = o + "}\n"

    o = o + "function loadDigestPrimary() public pure returns (uint256) {\n"
    digest = bytearray.fromhex(('{0:0{1}x}'.format(int(data.digest_primary, 16), 64)))
    digest.reverse()
    o = o + "return 0x" + "{0:0{1}x}".format(int(binascii.hexlify(digest), 16), 64) + ";\n"
    o = o + "}\n"

    o = o + "function loadNumConsPrimary() public pure returns (uint256) {\n"
    o = o + "return " + str(data.num_cons_primary) + ";\n"
    o = o + "}\n"

    o = o + "function loadNumVarsPrimary() public pure returns (uint256) {\n"
    o = o + "return " + str(data.num_vars_primary) + ";\n"
    o = o + "}\n"

    o = o + "function loadNumIoPrimary() public pure returns (uint256) {\n"
    o = o + "return " + str(data.num_io_primary) + ";\n"
    o = o + "}\n"

    o = o + "function loadCommAPrimary() public pure returns (Triple[] memory){\n"
    o = o + "Triple[] memory A = new Triple[](" + str(len(data.A_primary)) + ");\n"
    index = 0
    for itemA in data.A_primary:
        itemA2 = bytearray.fromhex(('{0:0{1}x}'.format(int(itemA[2], 16), 64)))
        itemA2.reverse()
        o = o + "A[" + str(index) + "] = Triple(" + str(itemA[0]) + ", " + str(itemA[1]) + ", 0x" + "{0:0{1}x}".format(int(binascii.hexlify(itemA2), 16), 64) + ");\n"
        index = index + 1

    o = o + "return A;\n"
    o = o + "}\n"


    o = o + "function loadCommBPrimary() public pure returns (Triple[] memory){\n"
    o = o + "Triple[] memory B = new Triple[](" + str(len(data.B_primary)) + ");\n"
    index = 0
    for itemB in data.B_primary:
        itemB2 = bytearray.fromhex(('{0:0{1}x}'.format(int(itemB[2], 16), 64)))
        itemB2.reverse()
        o = o + "B[" + str(index) + "] = Triple(" + str(itemB[0]) + ", " + str(itemB[1]) + ", 0x" + "{0:0{1}x}".format(int(binascii.hexlify(itemB2), 16), 64) + ");\n"
        index = index + 1

    o = o + "return B;\n"
    o = o + "}\n"


    o = o + "function loadCommCPrimary() public pure returns (Triple[] memory){\n"
    o = o + "Triple[] memory C = new Triple[](" + str(len(data.C_primary)) + ");\n"
    index = 0
    for itemC in data.C_primary:
        itemC2 = bytearray.fromhex(('{0:0{1}x}'.format(int(itemC[2], 16), 64)))
        itemC2.reverse()
        o = o + "C[" + str(index) + "] = Triple(" + str(itemC[0]) + ", " + str(itemC[1]) + ", 0x" + "{0:0{1}x}".format(int(binascii.hexlify(itemC2), 16), 64) + ");\n"
        index = index + 1

    o = o + "return C;\n"
    o = o + "}\n"
    o = o + "}\n"

    return o



vk_file = sys.argv[1]
if not os.path.exists(vk_file):
    print("verifier-key (json) input file is missing")
    exit(1)

vk_f = open(os.path.basename(vk_file))
vk_data = json.load(vk_f)

vk_secondary = vk_data['vk_secondary']
comm_secondary = vk_secondary['comm']
S_secondary = comm_secondary['S']

num_cons_secondary = S_secondary['num_cons']
num_vars_secondary = S_secondary['num_vars']
num_io_secondary = S_secondary['num_io']
digest_secondary = S_secondary['digest']

A_secondary = S_secondary['A']
B_secondary = S_secondary['B']
C_secondary = S_secondary['C']

vk_primary = vk_data['vk_primary']
comm_primary = vk_primary['comm']
S_primary = comm_primary['S']

num_cons_primary = S_primary['num_cons']
num_vars_primary = S_primary['num_vars']
num_io_primary = S_primary['num_io']
digest_primary = S_primary['digest']

A_primary = S_primary['A']
B_primary = S_primary['B']
C_primary = S_primary['C']

SparkMultiEvaluationData = namedtuple(
    '_SparkMultiEvaluationData', (
        'num_cons_secondary',
        'num_vars_secondary',
        'num_io_secondary',
        'A_secondary',
        'B_secondary',
        'C_secondary',
        'digest_secondary',

        'num_cons_primary',
        'num_vars_primary',
        'num_io_primary',
        'A_primary',
        'B_primary',
        'C_primary',
        'digest_primary',
    )
)

parsedData = SparkMultiEvaluationData(
    num_cons_secondary,
    num_vars_secondary,
    num_io_secondary,
    A_secondary,
    B_secondary,
    C_secondary,
    digest_secondary,

    num_cons_primary,
    num_vars_primary,
    num_io_primary,
    A_primary,
    B_primary,
    C_primary,
    digest_primary,
)

def chunks(lst, n):
    """Yield successive n-sized chunks from lst."""
    for i in range(0, len(lst), n):
        yield lst[i:i + n]

def constructInputArgumentsString(items):
    itemsString = "["
    for itemA in items:
        itemA2 = bytearray.fromhex(('{0:0{1}x}'.format(int(itemA[2], 16), 64)))
        itemA2.reverse()

        if itemA != items[len(items) - 1]:
            itemsString = itemsString + "(" + str(itemA[0]) + "," + str(itemA[1]) + "," + str(int("0x" + "{0:0{1}x}".format(int(binascii.hexlify(itemA2), 16), 64), 0)) + "),"
        else:
            # handle last item (no comma in the end)
            itemsString = itemsString + "(" + str(itemA[0]) + "," + str(itemA[1]) + "," + str(int("0x" + "{0:0{1}x}".format(int(binascii.hexlify(itemA2), 16), 64), 0)) + ")"
    itemsString = itemsString + "]"
    return itemsString

def sendTransactions(data, funcSig):
    itemsPerSingleTransaction = 10000
    itemsToPass = list(chunks(data, itemsPerSingleTransaction))

    # pass main body (multiple of 'itemsPerSingleTransaction')
    for chunk in itemsToPass[:len(itemsToPass) - 1]:
        itemsString = constructInputArgumentsString(chunk)
        A_loading_command = 'cast send ' + CONTRACT_ADDRESS + ' \"' + funcSig + '\" \"' + itemsString + '\" --private-key ' + PRIVATE_KEY
        os.system(A_loading_command)

    # pass tail
    itemsToPassTail = itemsToPass[len(itemsToPass) - 1:][0]
    itemsString = constructInputArgumentsString(itemsToPassTail)
    A_loading_command = 'cast send ' + CONTRACT_ADDRESS + ' \"' + funcSig + '\" \"' + itemsString + '\" --private-key ' + PRIVATE_KEY
    os.system(A_loading_command)

PRIVATE_KEY = "0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80"
CONTRACT_ADDRESS = "0xe7f1725e7734ce288f8367e1bb143e90bb3f0512"

PUSH_TO_A_FUNC_SIG = "pushToA((uint256,uint256,uint256)[])"
PUSH_TO_B_FUNC_SIG = "pushToB((uint256,uint256,uint256)[])"
PUSH_TO_C_FUNC_SIG = "pushToC((uint256,uint256,uint256)[])"
PUSH_TO_RX_FUNC_SIG = "pushToRx(uint256)"
PUSH_TO_RY_FUNC_SIG = "pushToRy(uint256)"

sendTransactions(parsedData.A_primary, PUSH_TO_A_FUNC_SIG)
sendTransactions(parsedData.B_primary, PUSH_TO_B_FUNC_SIG)
sendTransactions(parsedData.C_primary, PUSH_TO_C_FUNC_SIG)

# TODO make uploading r_x and r_y arrays via two transactions

# Should come from sumcheck procotols execution (sc_proof_inner; sc_proof_outer)
r_x = [
    "0x265e1d73ee4ce9a23d98bf74a9807abd1c0bedf6368e8db884c05bd9336549bd",
    "0x3a009bec1c4dc776ba75c643de9e61b3070a4a6b3865b5751a3d6f517e483a4a",
    "0x3932891c1f17ba15d07baba47d6599058812a73225d11a554ced25ad00fd78dd",
    "0x140622b73b006b8470ed724172721f7d25f3efb2208f42c73e0658fbc493579b",
    "0x2516f6f6ccf854843d9319fad46a0dff2729c608af31c143590c347d0f0805c6",
    "0x28942f6ecc7b89c49bfaa569687a9b6902ace63343300e808e86d608eca3f9dc",
    "0x1ae6542e6085a0c42ae6e947813a6f701329263a1a59f823cb544e83dce0b9cf",
    "0x39979cf05d7d96da05aba4dd24e9f072d52e8efbf4740f1a857680a096193f8b",
    "0x2d887fae3954bcb89f20051c96f6812eb841ccc29c8b56e2879e445f74cb4331",
    "0x29fb4b14d5d53616b881719c4986e5aad92f7320fc1e6c89f301b8a81ab72896",
    "0x2d69fc2f360b3328cb723687589b065ff4250c414c817bd4f6b187583e103270",
    "0x06dc812740949078bc2487f020274042e7400e44f7a95d26c2cf6de8b7ba5099",
    "0x39ade5abede093bbb12d81f27c28cbc7149d1b1ad6e43c49424687fb4c29ae31",
    "0x3d764ae71118a8a3c653b58c534db9fae607dd9c316cdd3675de0d62e0882bf1"
]

for item in r_x:
    r_x_loading_command = 'cast send --cast-async ' + CONTRACT_ADDRESS + ' \"' + PUSH_TO_RX_FUNC_SIG + '\" \"' + item + '\" --private-key ' + PRIVATE_KEY
    os.system(r_x_loading_command)

r_y = [
    "0x08012c1590c5127d3c6b4fe392b59fb476e4a480929e986393183a712bf11df9",
    "0x08c4915bf1a1341472a82d0d29d9ed43f72c93b7812e34466494145af762fc6c",
    "0x36d00685cf2a969330dbdf6a4533d7cb248def77ec139ad13ccdab2eb281993a",
    "0x0204fd7c7c131b857af8d9c1fe84a8b35685d45bbae8b51ac47af2c0c080363f",
    "0x1625b26a45ce9c1b46081ed7f0658e80bebe85a069357b39833b74e9be67113c",
    "0x138f29758140496f766af34905ccbfff72cde5c6fb88374ebb0d5bd4f7102d82",
    "0x0cab6796b99d03113e2f263ebb7ac9e49c0eba24c2537e78c4c332c7bedb695c",
    "0x2c32a9b732efeb9657c4f8d08310b314c5092bc6d246be6a8c0d828f858af4ac",
    "0x1de39d206f4df4fe1b745fe51c04b7405f6f4c371ceb6fb3817b1e4f3b70095b",
    "0x330de47a606ded4033291e9c612abdfb0b2a7d3dd830cb7b9713eebf89705cdb",
    "0x1d88a34c65d9cc8f8e009d7e5bfe03e0f01af93065873d5ac133fb5efa73b8df",
    "0x2b2163f1db7afd6856c760a247fa961d8d623f331975ddc32d35a90218728434",
    "0x0c2e1ba6d2908afa207a54f11f351dfee8c6ca8d55c032c248e92aa5f15ccd99",
    "0x17634a890278ae48651f7fa7cea00884f17ccd04365ada8c6e4405a39478212e",
    "0x0d2d8f8c26d30b56b526ddf9b803f597db14b25fe78fe4dba4ce487d9fb4fcb4"
]

for item in r_y:
    r_y_loading_command = 'cast send --cast-async ' + CONTRACT_ADDRESS + ' \"' + PUSH_TO_RY_FUNC_SIG + '\" \"' + item + '\" --private-key ' + PRIVATE_KEY
    os.system(r_y_loading_command)

print(len(A_primary))
print(len(B_primary))
print(len(C_primary))

print(len(r_x))
print(len(r_y))
