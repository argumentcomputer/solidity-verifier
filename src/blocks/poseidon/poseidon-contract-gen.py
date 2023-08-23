# Based on https://github.com/Loopring/protocols/blob/master/packages/loopring_v3/util/generate_poseidon_EVM_code.py

from collections import namedtuple
import json
import os
import sys

def sigma_EVM_asm(o, t):
    it = "i.t" + str(t)
    ot = "o.t" + str(t)
    o = o + ot + " = mulmod(" + it + ", " + it + ", q);\n"
    o = o + ot + " = mulmod(" + ot + ", " + ot + ", q);\n"
    o = o + ot + " = mulmod(" + it + ", " + ot + ", q);\n"
    return o

def poseidon_EVM_asm(params, libName):
    ts = "t0"
    _ts = "_t0"
    nts = "nt0"
    for t in range(1, params.t):
        ts = ts + ", t" + str(t)
        _ts = _ts + ", _t" + str(t)
        nts = nts + ", nt" + str(t)

    struct = "HashInputs" + str(params.t)

    o = ""

    o = o + "pragma solidity ^0.8.16;"
    o = o + "library " + libName + "{\n"
    o = o + "struct " + struct + "{\n"

    for index in range(params.t):
        o = o + "uint t" + str(index) + ";\n"

    o = o + "}\n"

    o = o + "function getConstants() public pure returns (uint256[] memory, uint256[] memory) {\n"
    o = o + "uint256[] memory mixConstantsPallas = new uint256[](" + str(params.t) + ");\n"
    for index in range(params.t):
        o = o + "mixConstantsPallas[" + str(index) + "] = " + str(params.constants_M[0][index]) + ";\n"

    o = o + "uint256[] memory addRoundConstantsPallas = new uint256[](" + str(params.t) + ");\n"
    for index in range(params.t):
        o = o + "addRoundConstantsPallas[" + str(index) + "] = " + str(params.constants_C[index]) + ";\n"

    o = o + "return (mixConstantsPallas, addRoundConstantsPallas);"
    o = o + "}\n"

    o = o + "function mix(" + struct + " memory i, uint q) internal pure \n{\n"
    o = o + struct + " memory o;\n"

    o = o + "(uint256[] memory mixConstants, ) = getConstants();\n"

    for i in range(params.t):
        if i == 0:
            o = o + "\no.t" + str(i) + " = 0;\n"
            for j in range(params.t):
                mulmod = "mulmod(i.t" + str(j) + ", mixConstants[" + str(j) + "], q)"
                o = o + "o.t" + str(i) + " = addmod(o.t" + str(i) + ", " + mulmod + ", q);\n"
        else:
            for j in range(params.t):
                mulmod = "mulmod(i.t" + str(j) + ", " + str(params.constants_M[i][j]) + ", q)"
                if j == 0:
                    o = o + "\no.t" + str(i) + " = 0;\n"
                    o = o + "o.t" + str(i) + " = addmod(o.t" + str(i) + ", " + mulmod + ", q);\n"
                else:
                    o = o + "o.t" + str(i) + " = addmod(o.t" + str(i) + ", " + mulmod + ", q);\n"



    o = o + "\n"
    for i in range(params.t):
        o = o + "i.t" + str(i) + " = o.t" + str(i) + ";\n"
    o = o + "}\n"
    o = o + "\n"

    o = o + "function ark(" + struct + " memory i, uint q, " + struct + " memory c) internal pure \n{\n"
    o = o + struct + " memory o;\n"
    o = o + "\n"
    for t in range(params.t):
        o = o + "o.t" + str(t) + " = addmod(i.t" + str(t) + ", c.t" + str(t) + ", q);\n"

    o = o + "\n"
    for i in range(params.t):
        o = o + "i.t" + str(i) + " = o.t" + str(i) + ";\n"
    o = o + "}\n"
    o = o + "\n"

    o = o + "function sbox_full(" + struct + " memory i, uint q) internal pure \n{\n"
    o = o + struct + " memory o;\n"

    o = o + "\n"
    for j in range(params.t):
        o = sigma_EVM_asm(o, j)

    o = o + "\n"
    for i in range(params.t):
        o = o + "i.t" + str(i) + " = o.t" + str(i) + ";\n"
    o = o + "}\n"
    o = o + "\n"

    o = o + "function sbox_partial(" + struct + " memory i, uint q) internal pure \n{\n"
    o = o + struct + " memory o;\n"
    o = o + "\n"
    o = sigma_EVM_asm(o, 0)
    o = o + "\n"
    for i in range(1):
        o = o + "i.t" + str(i) + " = o.t" + str(i) + ";\n"
    o = o + "}\n"
    o = o + "\n"

    o = o + "function hash(" + struct + " memory i, uint q) internal pure returns (uint)\n{\n"
    o = o + "// validate inputs\n"
    for i in range(params.t):
        o = o + "require(i.t" + str(i) + " < q, \"INVALID_INPUT\");\n"
    o = o + "\n"

    o = o + "(, uint256[] memory arcConstants) = getConstants();\n"

    for i in range(params.nRoundsF + params.nRoundsP):
        o = o + "// round " + str(i) + "\n"
        if i == 0:
            # ark
            arc = ""
            for j in range(params.t):
                if j == params.t - 1:
                    arc = arc + "arcConstants[" + str(j) + "]\n"
                else:
                    arc = arc + "arcConstants[" + str(j) + "],\n"


            o = o + "ark(i, q, " + struct + "(" + arc + ")\n);\n"

            # sbox
            if (i < params.nRoundsF/2) or (i >= params.nRoundsF/2 + params.nRoundsP):
                o = o + "sbox_full(i, q);\n"
            else:
                o = o + "sbox_partial(i, q);\n"
            # mix
            o = o + "mix(i, q);\n"
        else:
            constants_C_for_round = ""
            for j in range(params.t):
                if j != t:
                    constants_C_for_round = constants_C_for_round + str(params.constants_C[i * (t + 1) + j]) + ",\n"
                else:
                    constants_C_for_round = constants_C_for_round + str(params.constants_C[i * (t + 1) + j])

            # ark
            o = o + "ark(i, q, " + struct + "(" + constants_C_for_round + ")\n);\n"
            # sbox
            if (i < params.nRoundsF/2) or (i >= params.nRoundsF/2 + params.nRoundsP):
                o = o + "sbox_full(i, q);\n"
            else:
                o = o + "sbox_partial(i, q);\n"
            # mix
            o = o + "mix(i, q);\n"



    o = o + "\nreturn i.t1;\n"
    o = o + "}\n"
    o = o + "}\n"
    o = o + "\n"

    return o


PoseidonParamsType = namedtuple('_PoseidonParams', ('t', 'nRoundsF', 'nRoundsP', 'constants_C', 'constants_M'))

fn = sys.argv[1]
if not os.path.exists(fn):
    print("constants (json) input file is missing")
    exit(1)

libraryName = sys.argv[2]

f = open(os.path.basename(fn))
data = json.load(f)

t = int(data['state_size_field_elements'])
nRoundsF = int(data['full_rounds'])
nRoundsP = int(data['partial_rounds'])
constants_C = list(data['round_constants'])
matrix_M = data['matrix_M']

constants_M = []
for matrix in matrix_M:
    constants_M.append(matrix)

poseidonParamsEVM = PoseidonParamsType(t, nRoundsF, nRoundsP, constants_C, constants_M)

data = poseidon_EVM_asm(poseidonParamsEVM, libraryName)
print("// SPDX-License-Identifier: Apache-2.0")
print("// Do not change manually. This contract has been auto-generated by", sys.argv[0])
print(data)
