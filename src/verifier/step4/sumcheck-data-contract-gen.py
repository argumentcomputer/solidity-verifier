import json
import sys
import os
from enum import Enum

class Version(Enum):
    PRIMARY = "Primary"
    SECONDARY = "Secondary"

    def get_curve(self) -> str:
        match self:
            case Version.PRIMARY:
                return "Pallas"
            case Version.SECONDARY:
                return "Vesta"

def h(s):
    """
    Hexify a string
    """
    return "0x" + s

def reverse_bytes(val):
    """
    Reverses the byte order of a hexdecimal number for ingest in Solidity contract
    """
    ba = bytearray.fromhex(val)
    ba.reverse()
    return ba.hex()

def sumcheck_data_contract_gen(data, ver: Version):
    compressed_polynomials = data["compressed_polys"]
    output = f"{ver.get_curve()}PolyLib.CompressedUniPoly[] memory proof_array = new {ver.get_curve()}PolyLib.CompressedUniPoly[]({len(compressed_polynomials)});\n"
    degree = len(compressed_polynomials[0]["coeffs_except_linear_term"])
    output += f"uint256[] memory poly_array = new uint256[]({degree});\n"
    output += f"{ver.get_curve()}PolyLib.CompressedUniPoly memory poly;\n"

    for poly_idx, poly in enumerate(compressed_polynomials):
        coeffs = poly["coeffs_except_linear_term"]
        for coeff_idx, coeff in enumerate(coeffs):
            output += f"poly_array[{coeff_idx}] = {h(coeff)};\n"
        output += f"poly = {ver.get_curve()}PolyLib.CompressedUniPoly(poly_array);\n"
        output += f"proof_array[{poly_idx}] = poly;\n"
    
    output += f"return {ver.value}Sumcheck.SumcheckProof(proof_array);\n"
    return output

def transcript_data_contract_gen(data, ver: Version):
    output = f"uint8[] memory digest = new uint8[](32);\n"
    for idx in range(32):
        output += f"digest[{idx}] = {h(data[2*idx:2*(idx + 1)])};\n"
    
    output += "\nreturn digest;"
    return output

def function_decl(name: str) -> str:
    output = f"function {name}()\n"
    output += "public pure returns\n"
    return output

def sumcheck_function_return(ver: Version) -> str:
    return f"({ver.value}Sumcheck.SumcheckProof memory)" + " {\n"

vk_file = sys.argv[1]
if not os.path.exists(vk_file):
    print("verifier-key (json) input file is missing")
    exit(1)

proof_file = sys.argv[2]
if not os.path.exists(proof_file):
    print("compressed snark (json) input file is missing")
    exit(1)

proof_f = open(os.path.basename(proof_file))
proof_data = json.load(proof_f)

vk_f = open(os.path.basename(vk_file))
vk_data = json.load(vk_f)

header = "// SPDX-License-Identifier: Apache-2.0\n"
header += f"// Do not change manually. This contract has been auto-generated by {sys.argv[0]}\n"
header += "pragma solidity ^0.8.0;\n"
header += 'import "src/verifier/step4/SumcheckLogic.sol";\n'

sumcheck_function_doc = "// This function returns a SumcheckProof for the relevant corresponding field\n"

primary_data = proof_data["f_W_snark_primary"]

primary_outer_data_def = sumcheck_function_doc
primary_outer_data_def += function_decl("returnPrimaryOuterData")
primary_outer_data_def += sumcheck_function_return(Version.PRIMARY)
primary_outer_data_def += sumcheck_data_contract_gen(primary_data["sc_proof_outer"], Version.PRIMARY)
primary_outer_data_def += "}\n\n"

primary_inner_data_def = sumcheck_function_doc
primary_inner_data_def += function_decl("returnPrimaryInnerData")
primary_inner_data_def += sumcheck_function_return(Version.PRIMARY)
primary_inner_data_def += sumcheck_data_contract_gen(primary_data["sc_proof_inner"], Version.PRIMARY)
primary_inner_data_def += "}\n\n"

primary_batch_data_def = sumcheck_function_doc
primary_batch_data_def += function_decl("returnPrimaryBatchData")
primary_batch_data_def += sumcheck_function_return(Version.PRIMARY)
primary_batch_data_def += sumcheck_data_contract_gen(primary_data["sc_proof_batch"], Version.PRIMARY)
primary_batch_data_def += "}\n\n"

secondary_data = proof_data["f_W_snark_secondary"]

secondary_outer_data_def = sumcheck_function_doc
secondary_outer_data_def += function_decl("returnSecondaryOuterData")
secondary_outer_data_def += sumcheck_function_return(Version.SECONDARY)
secondary_outer_data_def += sumcheck_data_contract_gen(secondary_data["sc_proof_outer"], Version.SECONDARY)
secondary_outer_data_def += "}\n\n"

secondary_inner_data_def = sumcheck_function_doc
secondary_inner_data_def += function_decl("returnSecondaryInnerData")
secondary_inner_data_def += sumcheck_function_return(Version.SECONDARY)
secondary_inner_data_def += sumcheck_data_contract_gen(secondary_data["sc_proof_inner"], Version.SECONDARY)
secondary_inner_data_def += "}\n\n"

secondary_batch_data_def = sumcheck_function_doc
secondary_batch_data_def += function_decl("returnSecondaryBatchData")
secondary_batch_data_def += sumcheck_function_return(Version.SECONDARY)
secondary_batch_data_def += sumcheck_data_contract_gen(secondary_data["sc_proof_batch"], Version.SECONDARY)
secondary_batch_data_def += "}\n\n"

transcript_function_doc = "// This function returns R1CS structure digest as a uint8[]\n"

primary_transcript_data = vk_data["vk_primary"]["comm"]["S"]["digest"]

primary_transcript_data_def = transcript_function_doc
primary_transcript_data_def += function_decl("returnPrimaryTranscriptData")
primary_transcript_data_def += "(uint8[] memory) {\n"
primary_transcript_data_def += transcript_data_contract_gen(primary_transcript_data, Version.PRIMARY)
primary_transcript_data_def += "}\n"

secondary_transcript_data = vk_data["vk_secondary"]["comm"]["S"]["digest"]

secondary_transcript_data_def = transcript_function_doc
secondary_transcript_data_def += function_decl("returnSecondaryTranscriptData")
secondary_transcript_data_def += "(uint8[] memory) {\n"
secondary_transcript_data_def += transcript_data_contract_gen(secondary_transcript_data, Version.SECONDARY)
secondary_transcript_data_def += "}\n"

data_contract_body = "library SumcheckData {\n"
data_contract_body += primary_outer_data_def
data_contract_body += primary_inner_data_def
data_contract_body += primary_batch_data_def
data_contract_body += secondary_outer_data_def
data_contract_body += secondary_inner_data_def
data_contract_body += secondary_batch_data_def
data_contract_body += primary_transcript_data_def
data_contract_body += secondary_transcript_data_def

data_contract_body += "}\n"

print(header)
print(data_contract_body)