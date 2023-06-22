import json
import sys
import os

def h(s):
    """
    Hexify a string
    """
    return "0x" + s

def step3DataContractGen(digest, nifs_secondary, r_U_secondary, l_u_secondary):
    # Unpack nifs_secondary
    nifs_secondary_repr = nifs_secondary["comm_T"]["comm"]["repr"]
    output = f"\t\tuint8[32] memory nifs_array;\n"
    for idx, val in enumerate(nifs_secondary_repr):
        output += f"\t\tnifs_array[{idx}] = {val};\n"

    output += "\t\tbytes32 nifs = Field.uint8ArrayToBytes32(nifs_array);\n"
    # Unpack r_U_secondary
    comm_W = r_U_secondary["comm_W"]["comm"]
    output += f"\t\tuint256 r_U_comm_W = {h(comm_W)};\n"
    comm_E = r_U_secondary["comm_E"]["comm"]
    output += f"\t\tuint256 r_U_comm_E = {h(comm_E)};\n"
    r_X = r_U_secondary["X"]
    output += f"\t\tuint256[] memory r_U_X = new uint256[]({len(r_X)});\n"
    for idx, val in enumerate(r_X):
        output += f"\t\tr_U_X[{idx}] = {h(val)};\n"
    r_U_u = r_U_secondary["u"]
    output += f"\t\tuint256 r_U_u = {h(r_U_u)};\n"

    # Unpack l_U_secondary
    comm_W = l_u_secondary["comm_W"]["comm"]
    output += f"\t\tuint256 l_u_comm_W = {h(comm_W)};\n"
    l_X = l_u_secondary["X"]
    output += f"\t\tuint256[] memory l_u_X = new uint256[]({len(l_X)});\n"
    for idx, val in enumerate(l_X):
        output += f"\t\tl_u_X[{idx}] = {h(val)};\n"

    output += f"\t\treturn ({h(digest)}, nifs, r_U_comm_W, r_U_comm_E, r_U_X, r_U_u, l_u_comm_W, l_u_X);\n"

    return output

vk_file = sys.argv[1]
if not os.path.exists(vk_file):
    print("verifier-key (json) input file is missing")
    exit(1)

vk_f = open(os.path.basename(vk_file))
vk_data = json.load(vk_f)
digest_primary = vk_data["r1cs_shape_primary_digest"]
digest_secondary = vk_data["r1cs_shape_secondary_digest"]

proof_file = sys.argv[2]
if not os.path.exists(proof_file):
    print("compressed snark (json) input file is missing")
    exit(1)

proof_f = open(os.path.basename(proof_file))
proof_data = json.load(proof_f)
nifs_primary = proof_data["nifs_primary"]
r_U_primary = proof_data["r_U_primary"]
l_u_primary = proof_data["l_u_primary"]
nifs_secondary = proof_data["nifs_secondary"]
r_U_secondary = proof_data["r_U_secondary"]
l_u_secondary = proof_data["l_u_secondary"]

header = "// SPDX-License-Identifier: Apache-2.0\n"
header += f"// Do not change manually. This contract has been auto-generated by {sys.argv[0]}\n"
header += "pragma solidity ^0.8.0;\n"
header += 'import "src/Field.sol";\n'

function_doc = "\t/* This function returns the following results in order:\n"
function_doc += "\t* pp_digest, NIFS instance, r_U comm_W, r_U comm_E, r_U X, r_U u\n"
function_doc += "\t* l_u comm_W, l_u X\n"
function_doc += "\t*/\n"

primary_data_function_def = function_doc
primary_data_function_def += "\tfunction returnPrimaryData()\n"
primary_data_function_def += "\t\tpublic\n"
primary_data_function_def += "\t\tpure\n"
primary_data_function_def += "\t\treturns (uint256, bytes32, uint256, uint256, uint256[] memory, uint256, uint256, uint256[] memory)\n"
primary_data_function_def += "\t{\n"
primary_data_function_def += step3DataContractGen(digest_primary, nifs_primary, r_U_primary, l_u_primary) 
primary_data_function_def += "\t}\n\n"

secondary_data_function_def = function_doc
secondary_data_function_def += "\tfunction returnSecondaryData()\n"
secondary_data_function_def += "\t\tpublic\n"
secondary_data_function_def += "\t\tpure\n"
secondary_data_function_def += "\t\treturns (uint256, bytes32, uint256, uint256, uint256[] memory, uint256, uint256, uint256[] memory)\n"
secondary_data_function_def += "\t{\n"
secondary_data_function_def += step3DataContractGen(digest_secondary, nifs_secondary, r_U_secondary, l_u_secondary) 
secondary_data_function_def += "}\n\n"

data_contract_body = "library Step3Data {\n"
data_contract_body += primary_data_function_def
data_contract_body += secondary_data_function_def
data_contract_body += "}"

print(header)
print(data_contract_body)