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
