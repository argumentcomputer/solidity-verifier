from collections import namedtuple
import json
import os
import sys

def step1DataContractGen(data):
    o = ""
    o = o + "pragma solidity ^0.8.0;\n"
    o = o + "library NovaVerifierStep1DataLib {\n"

    # get_r_u_primary_X
    o = o + "function get_r_u_primary_X() public pure returns (uint256[] memory) {\n"
    o = o + "uint256[] memory r_u_primary_X = new uint256[](" + str(len(data.r_u_primary_X)) + ");\n"
    index = 0
    for x in data.r_u_primary_X:
        o = o + "r_u_primary_X[" + str(index) + "] = 0x" + str(x) + ";\n"
        index = index + 1

    o = o + "return r_u_primary_X;"
    o = o + "\n}\n"

    # get_l_u_primary_X
    o = o + "function get_l_u_primary_X() public pure returns (uint256[] memory) {\n"
    o = o + "uint256[] memory l_u_primary_X = new uint256[](" + str(len(data.l_u_primary_X)) + ");\n"
    index = 0
    for x in data.l_u_primary_X:
        o = o + "l_u_primary_X[" + str(index) + "] = 0x" + str(x) + ";\n"
        index = index + 1

    o = o + "return l_u_primary_X;"
    o = o + "\n}\n"

    # get_r_u_secondary_X
    o = o + "function get_r_u_secondary_X() public pure returns (uint256[] memory) {\n"
    o = o + "uint256[] memory r_u_secondary_X = new uint256[](" + str(len(data.r_u_secondary_X)) + ");\n"
    index = 0
    for x in data.r_u_secondary_X:
        o = o + "r_u_secondary_X[" + str(index) + "] = 0x" + str(x) + ";\n"
        index = index + 1

    o = o + "return r_u_secondary_X;"
    o = o + "\n}\n"

    # get_l_u_secondary_X
    o = o + "function get_l_u_secondary_X() public pure returns (uint256[] memory) {\n"
    o = o + "uint256[] memory l_u_secondary_X = new uint256[](" + str(len(data.l_u_secondary_X)) + ");\n"
    index = 0
    for x in data.l_u_secondary_X:
        o = o + "l_u_secondary_X[" + str(index) + "] = 0x" + str(x) + ";\n"
        index = index + 1

    o = o + "return l_u_secondary_X;"
    o = o + "\n}"

    o = o + "\n}"

    return o

fn = sys.argv[1]
if not os.path.exists(fn):
    print("constants (json) input file is missing")
    exit(1)

f = open(os.path.basename(fn))
data = json.load(f)

r_u_primary = data['r_U_primary']
X1 = r_u_primary['X']

l_u_primary = data['l_u_primary']
X2 = l_u_primary['X']

r_u_secondary = data['r_U_secondary']
X3 = r_u_secondary['X']

l_u_secondary = data['l_u_secondary']
X4 = l_u_secondary['X']

Step1VerifierData = namedtuple('_Step1VerifierData', ('r_u_primary_X', 'l_u_primary_X', 'r_u_secondary_X', 'l_u_secondary_X'))

X1234 = Step1VerifierData(X1, X2, X3, X4)

data = step1DataContractGen(X1234)
print(data)
