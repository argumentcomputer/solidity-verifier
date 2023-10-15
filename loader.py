from collections import namedtuple
import json
import os
import sys
import binascii

if len(sys.argv) != 6:
    print("Correct loader's invocation should contain 5 parameters:\n1) Path to verifier key JSON\n2) Path to proof JSON\n3) Deployed contract address\n4) URL of RPC endpoint\n5) Private key\n\nFor example:\npython loader.py verifier-key.json compressed-snark.json 0x720472c8ce72c2a2d711333e064abd3e6bbeadd3 http://127.0.0.1:8545 0x0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80")
    os.exit(1)

# Parsing JSON with public parameters
vk_file = sys.argv[1]
if not os.path.exists(vk_file):
    print("verifier-key (json) input file is missing")
    exit(1)

vk_f = open(os.path.basename(vk_file))
vk_data = json.load(vk_f)

ro_consts_primary = vk_data['ro_consts_primary']
mds = ro_consts_primary['mds']
constants_mixConstantsPrimary = mds['m']
constants_addRoundConstantsPrimary = ro_consts_primary['crc']
ro_consts_secondary = vk_data['ro_consts_secondary']
mds = ro_consts_secondary['mds']
constants_mixConstantsSecondary = mds['m']
constants_addRoundConstantsSecondary = ro_consts_secondary['crc']
f_arity_primary = vk_data['F_arity_primary']
f_arity_secondary = vk_data['F_arity_secondary']
digest = vk_data['digest']

vk_secondary = vk_data['vk_secondary']
S_comm = vk_secondary['S_comm']
vk_secondary_S_comm_N = S_comm['N']
vk_secondary_S_comm_comm_val_A = S_comm['comm_val_A']['comm']
vk_secondary_S_comm_comm_val_B = S_comm['comm_val_B']['comm']
vk_secondary_S_comm_comm_val_C = S_comm['comm_val_C']['comm']
vk_secondary_S_comm_comm_row = S_comm['comm_row']['comm']
vk_secondary_S_comm_comm_row_read_ts = S_comm['comm_row_read_ts']['comm']
vk_secondary_S_comm_comm_row_audit_ts = S_comm['comm_row_audit_ts']['comm']
vk_secondary_S_comm_comm_col = S_comm['comm_col']['comm']
vk_secondary_S_comm_comm_col_read_ts = S_comm['comm_col_read_ts']['comm']
vk_secondary_S_comm_comm_col_audit_ts = S_comm['comm_col_audit_ts']['comm']
vk_secondary_digest = vk_secondary['digest']

vk_primary = vk_data['vk_primary']
vk_primary_num_cons = vk_primary['num_cons']
vk_primary_num_vars = vk_primary['num_vars']
S_comm = vk_primary['S_comm']
vk_primary_S_comm_N = S_comm['N']
vk_primary_S_comm_comm_val_A = S_comm['comm_val_A']['comm']
vk_primary_S_comm_comm_val_B = S_comm['comm_val_B']['comm']
vk_primary_S_comm_comm_val_C = S_comm['comm_val_C']['comm']
vk_primary_S_comm_comm_row = S_comm['comm_row']['comm']
vk_primary_S_comm_comm_row_read_ts = S_comm['comm_row_read_ts']['comm']
vk_primary_S_comm_comm_row_audit_ts = S_comm['comm_row_audit_ts']['comm']
vk_primary_S_comm_comm_col = S_comm['comm_col']['comm']
vk_primary_S_comm_comm_col_read_ts = S_comm['comm_col_read_ts']['comm']
vk_primary_S_comm_comm_col_audit_ts = S_comm['comm_col_audit_ts']['comm']
vk_primary_digest = vk_primary['digest']

# Parsing JSON with proof
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
l_u_secondary_comm_W_comm = l_u_secondary_comm_W['comm']
l_u_secondary_X = l_u_secondary['X']
r_u_primary_comm_W_comm = r_u_primary_comm_W['comm']
r_u_primary_comm_E_comm = r_u_primary_comm_E['comm']
r_u_primary_X = r_u_primary['X']
r_u_primary_u = r_u_primary['u']
r_u_secondary_comm_W_comm = r_u_secondary_comm_W['comm']
r_u_secondary_comm_E_comm = r_u_secondary_comm_E['comm']
r_u_secondary_X = r_u_secondary['X']
r_u_secondary_u = r_u_secondary['u']
zn_primary = proof_data['zn_primary']
zn_secondary = proof_data['zn_secondary']
nifs_secondary = proof_data['nifs_secondary']
nifs_secondary_comm_T = nifs_secondary['comm_T']
nifs_secondary_comm_T_comm = nifs_secondary_comm_T['comm']
nifs_compressed_comm_T = nifs_secondary_comm_T_comm['repr']
hex_string = ""
for byteVal in nifs_compressed_comm_T:
    hex_string = hex_string + f'{byteVal:02x}'
nifs_compressed_comm_T = '0x' + hex_string
f_W_snark_secondary = proof_data['f_W_snark_secondary']
f_W_snark_secondary_comm_Az = f_W_snark_secondary['comm_Az']['comm']['repr']
hex_string = ""
for byteVal in f_W_snark_secondary_comm_Az:
    hex_string = hex_string + f'{byteVal:02x}'
f_W_snark_secondary_comm_Az = '0x' + hex_string
f_W_snark_secondary_comm_Bz = f_W_snark_secondary['comm_Bz']['comm']['repr']
hex_string = ""
for byteVal in f_W_snark_secondary_comm_Bz:
    hex_string = hex_string + f'{byteVal:02x}'
f_W_snark_secondary_comm_Bz = '0x' + hex_string
f_W_snark_secondary_comm_Cz = f_W_snark_secondary['comm_Cz']['comm']['repr']
hex_string = ""
for byteVal in f_W_snark_secondary_comm_Cz:
    hex_string = hex_string + f'{byteVal:02x}'
f_W_snark_secondary_comm_Cz = '0x' + hex_string
f_W_snark_secondary_comm_E_row = f_W_snark_secondary['comm_E_row']['comm']['repr']
hex_string = ""
for byteVal in f_W_snark_secondary_comm_E_row:
    hex_string = hex_string + f'{byteVal:02x}'
f_W_snark_secondary_comm_E_row = '0x' + hex_string
f_W_snark_secondary_comm_E_col = f_W_snark_secondary['comm_E_col']['comm']['repr']
hex_string = ""
for byteVal in f_W_snark_secondary_comm_E_col:
    hex_string = hex_string + f'{byteVal:02x}'
f_W_snark_secondary_comm_E_col = '0x' + hex_string
f_W_snark_secondary_eval_Az_at_tau = f_W_snark_secondary['eval_Az_at_tau']
f_W_snark_secondary_eval_Bz_at_tau = f_W_snark_secondary['eval_Bz_at_tau']
f_W_snark_secondary_eval_Cz_at_tau = f_W_snark_secondary['eval_Cz_at_tau']
f_W_snark_secondary_comm_output_arr = f_W_snark_secondary['comm_output_arr']
tmp = []
for item in f_W_snark_secondary_comm_output_arr:
    hex_string = ""
    for byteVal in item['comm']['repr']:
        hex_string = hex_string + f'{byteVal:02x}'
    tmp.append('0x' + hex_string)
f_W_snark_secondary_comm_output_arr = tmp
f_W_snark_secondary_claims_product_arr = f_W_snark_secondary['claims_product_arr']
sc_sat = f_W_snark_secondary['sc_sat']
compressed_polys = sc_sat['compressed_polys']
tmp = []
for item in compressed_polys:
    val = item['coeffs_except_linear_term']
    tmp.append(val)
f_W_snark_secondary_sc_sat = tmp
f_W_snark_secondary_eval_left_arr = f_W_snark_secondary['eval_left_arr']
f_W_snark_secondary_eval_right_arr = f_W_snark_secondary['eval_right_arr']
f_W_snark_secondary_eval_output_arr = f_W_snark_secondary['eval_output_arr']
f_W_snark_secondary_eval_Az = f_W_snark_secondary['eval_Az']
f_W_snark_secondary_eval_Bz = f_W_snark_secondary['eval_Bz']
f_W_snark_secondary_eval_Cz = f_W_snark_secondary['eval_Cz']
f_W_snark_secondary_eval_E = f_W_snark_secondary['eval_E']
f_W_snark_secondary_eval_val_A = f_W_snark_secondary['eval_val_A']
f_W_snark_secondary_eval_val_B = f_W_snark_secondary['eval_val_B']
f_W_snark_secondary_eval_val_C = f_W_snark_secondary['eval_val_C']
f_W_snark_secondary_eval_E_row = f_W_snark_secondary['eval_E_row']
f_W_snark_secondary_eval_E_col = f_W_snark_secondary['eval_E_col']
f_W_snark_secondary_eval_input_arr = f_W_snark_secondary['eval_input_arr']
f_W_snark_secondary_eval_row_audit_ts = f_W_snark_secondary['eval_row_audit_ts']
f_W_snark_secondary_eval_row = f_W_snark_secondary['eval_row']
f_W_snark_secondary_eval_E_row_at_r_prod = f_W_snark_secondary['eval_E_row_at_r_prod']
f_W_snark_secondary_eval_row_read_ts = f_W_snark_secondary['eval_row_read_ts']
f_W_snark_secondary_eval_col_audit_ts = f_W_snark_secondary['eval_col_audit_ts']
f_W_snark_secondary_eval_col = f_W_snark_secondary['eval_col']
f_W_snark_secondary_eval_E_col_at_r_prod = f_W_snark_secondary['eval_E_col_at_r_prod']
f_W_snark_secondary_eval_col_read_ts = f_W_snark_secondary['eval_col_read_ts']
f_W_snark_secondary_eval_W = f_W_snark_secondary['eval_W']
f_W_snark_secondary_evals_batch_arr = f_W_snark_secondary['evals_batch_arr']
sc_proof_batch = f_W_snark_secondary['sc_proof_batch']
compressed_polys = sc_proof_batch['compressed_polys']
tmp = []
for item in compressed_polys:
    val = item['coeffs_except_linear_term']
    tmp.append(val)
f_W_snark_secondary_sc_proof_batch = tmp
f_W_snark_secondary_eval_output2_arr = f_W_snark_secondary['eval_output2_arr']
r_W_snark_primary = proof_data['r_W_snark_primary']
r_W_snark_primary_comm_Az = r_W_snark_primary['comm_Az']['comm']['repr']
hex_string = ""
for byteVal in r_W_snark_primary_comm_Az:
    hex_string = hex_string + f'{byteVal:02x}'
r_W_snark_primary_comm_Az = '0x' + hex_string
r_W_snark_primary_comm_Bz = r_W_snark_primary['comm_Bz']['comm']['repr']
hex_string = ""
for byteVal in r_W_snark_primary_comm_Bz:
    hex_string = hex_string + f'{byteVal:02x}'
r_W_snark_primary_comm_Bz = '0x' + hex_string
r_W_snark_primary_comm_Cz = r_W_snark_primary['comm_Cz']['comm']['repr']
hex_string = ""
for byteVal in r_W_snark_primary_comm_Cz:
    hex_string = hex_string + f'{byteVal:02x}'
r_W_snark_primary_comm_Cz = '0x' + hex_string
r_W_snark_primary_comm_E_row = r_W_snark_primary['comm_E_row']['comm']['repr']
hex_string = ""
for byteVal in r_W_snark_primary_comm_E_row:
    hex_string = hex_string + f'{byteVal:02x}'
r_W_snark_primary_comm_E_row = '0x' + hex_string
r_W_snark_primary_comm_E_col = r_W_snark_primary['comm_E_col']['comm']['repr']
hex_string = ""
for byteVal in r_W_snark_primary_comm_E_col:
    hex_string = hex_string + f'{byteVal:02x}'
r_W_snark_primary_comm_E_col = '0x' + hex_string
r_W_snark_primary_eval_Az_at_tau = r_W_snark_primary['eval_Az_at_tau']
r_W_snark_primary_eval_Bz_at_tau = r_W_snark_primary['eval_Bz_at_tau']
r_W_snark_primary_eval_Cz_at_tau = r_W_snark_primary['eval_Cz_at_tau']
r_W_snark_primary_comm_output_arr = r_W_snark_primary['comm_output_arr']
tmp = []
for item in r_W_snark_primary_comm_output_arr:
    hex_string = ""
    for byteVal in item['comm']['repr']:
        hex_string = hex_string + f'{byteVal:02x}'
    tmp.append('0x' + hex_string)
r_W_snark_primary_comm_output_arr = tmp
r_W_snark_primary_claims_product_arr = r_W_snark_primary['claims_product_arr']
sc_sat = r_W_snark_primary['sc_sat']
compressed_polys = sc_sat['compressed_polys']
tmp = []
for item in compressed_polys:
    val = item['coeffs_except_linear_term']
    tmp.append(val)
r_W_snark_primary_sc_sat = tmp
r_W_snark_primary_eval_left_arr = r_W_snark_primary['eval_left_arr']
r_W_snark_primary_eval_right_arr = r_W_snark_primary['eval_right_arr']
r_W_snark_primary_eval_output_arr = r_W_snark_primary['eval_output_arr']
r_W_snark_primary_eval_Az = r_W_snark_primary['eval_Az']
r_W_snark_primary_eval_Bz = r_W_snark_primary['eval_Bz']
r_W_snark_primary_eval_Cz = r_W_snark_primary['eval_Cz']
r_W_snark_primary_eval_E = r_W_snark_primary['eval_E']
r_W_snark_primary_eval_val_A = r_W_snark_primary['eval_val_A']
r_W_snark_primary_eval_val_B = r_W_snark_primary['eval_val_B']
r_W_snark_primary_eval_val_C = r_W_snark_primary['eval_val_C']
r_W_snark_primary_eval_E_row = r_W_snark_primary['eval_E_row']
r_W_snark_primary_eval_E_col = r_W_snark_primary['eval_E_col']
r_W_snark_primary_eval_input_arr = r_W_snark_primary['eval_input_arr']
r_W_snark_primary_eval_row_audit_ts = r_W_snark_primary['eval_row_audit_ts']
r_W_snark_primary_eval_row = r_W_snark_primary['eval_row']
r_W_snark_primary_eval_E_row_at_r_prod = r_W_snark_primary['eval_E_row_at_r_prod']
r_W_snark_primary_eval_row_read_ts = r_W_snark_primary['eval_row_read_ts']
r_W_snark_primary_eval_col_audit_ts = r_W_snark_primary['eval_col_audit_ts']
r_W_snark_primary_eval_col = r_W_snark_primary['eval_col']
r_W_snark_primary_eval_E_col_at_r_prod = r_W_snark_primary['eval_E_col_at_r_prod']
r_W_snark_primary_eval_col_read_ts = r_W_snark_primary['eval_col_read_ts']
r_W_snark_primary_eval_W = r_W_snark_primary['eval_W']
r_W_snark_primary_evals_batch_arr = r_W_snark_primary['evals_batch_arr']
sc_proof_batch = r_W_snark_primary['sc_proof_batch']
compressed_polys = sc_proof_batch['compressed_polys']
tmp = []
for item in compressed_polys:
    val = item['coeffs_except_linear_term']
    tmp.append(val)
r_W_snark_primary_sc_proof_batch = tmp
r_W_snark_primary_eval_output2_arr = r_W_snark_primary['eval_output2_arr']

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
        'nifs_compressed_comm_T',
        'f_W_snark_secondary_comm_Az',
        'f_W_snark_secondary_comm_Bz',
        'f_W_snark_secondary_comm_Cz',
        'f_W_snark_secondary_comm_E_row',
        'f_W_snark_secondary_comm_E_col',
        'f_W_snark_secondary_eval_Az_at_tau',
        'f_W_snark_secondary_eval_Bz_at_tau',
        'f_W_snark_secondary_eval_Cz_at_tau',
        'f_W_snark_secondary_comm_output_arr',
        'f_W_snark_secondary_claims_product_arr',
        'f_W_snark_secondary_sc_sat',
        'f_W_snark_secondary_eval_left_arr',
        'f_W_snark_secondary_eval_right_arr',
        'f_W_snark_secondary_eval_output_arr',
        'f_W_snark_secondary_eval_Az',
        'f_W_snark_secondary_eval_Bz',
        'f_W_snark_secondary_eval_Cz',
        'f_W_snark_secondary_eval_E',
        'f_W_snark_secondary_eval_val_A',
        'f_W_snark_secondary_eval_val_B',
        'f_W_snark_secondary_eval_val_C',
        'f_W_snark_secondary_eval_E_row',
        'f_W_snark_secondary_eval_E_col',
        'f_W_snark_secondary_eval_input_arr',
        'f_W_snark_secondary_eval_row_audit_ts',
        'f_W_snark_secondary_eval_row',
        'f_W_snark_secondary_eval_E_row_at_r_prod',
        'f_W_snark_secondary_eval_row_read_ts',
        'f_W_snark_secondary_eval_col_audit_ts',
        'f_W_snark_secondary_eval_col',
        'f_W_snark_secondary_eval_E_col_at_r_prod',
        'f_W_snark_secondary_eval_col_read_ts',
        'f_W_snark_secondary_eval_W',
        'f_W_snark_secondary_evals_batch_arr',
        'f_W_snark_secondary_sc_proof_batch',
        'f_W_snark_secondary_eval_output2_arr',
        'r_W_snark_primary_comm_Az',
        'r_W_snark_primary_comm_Bz',
        'r_W_snark_primary_comm_Cz',
        'r_W_snark_primary_comm_E_row',
        'r_W_snark_primary_comm_E_col',
        'r_W_snark_primary_eval_Az_at_tau',
        'r_W_snark_primary_eval_Bz_at_tau',
        'r_W_snark_primary_eval_Cz_at_tau',
        'r_W_snark_primary_comm_output_arr',
        'r_W_snark_primary_claims_product_arr',
        'r_W_snark_primary_sc_sat',
        'r_W_snark_primary_eval_left_arr',
        'r_W_snark_primary_eval_right_arr',
        'r_W_snark_primary_eval_output_arr',
        'r_W_snark_primary_eval_Az',
        'r_W_snark_primary_eval_Bz',
        'r_W_snark_primary_eval_Cz',
        'r_W_snark_primary_eval_E',
        'r_W_snark_primary_eval_val_A',
        'r_W_snark_primary_eval_val_B',
        'r_W_snark_primary_eval_val_C',
        'r_W_snark_primary_eval_E_row',
        'r_W_snark_primary_eval_E_col',
        'r_W_snark_primary_eval_input_arr',
        'r_W_snark_primary_eval_row_audit_ts',
        'r_W_snark_primary_eval_row',
        'r_W_snark_primary_eval_E_row_at_r_prod',
        'r_W_snark_primary_eval_row_read_ts',
        'r_W_snark_primary_eval_col_audit_ts',
        'r_W_snark_primary_eval_col',
        'r_W_snark_primary_eval_E_col_at_r_prod',
        'r_W_snark_primary_eval_col_read_ts',
        'r_W_snark_primary_eval_W',
        'r_W_snark_primary_evals_batch_arr',
        'r_W_snark_primary_sc_proof_batch',
        'r_W_snark_primary_eval_output2_arr',
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
    nifs_compressed_comm_T,
    f_W_snark_secondary_comm_Az,
    f_W_snark_secondary_comm_Bz,
    f_W_snark_secondary_comm_Cz,
    f_W_snark_secondary_comm_E_row,
    f_W_snark_secondary_comm_E_col,
    f_W_snark_secondary_eval_Az_at_tau,
    f_W_snark_secondary_eval_Bz_at_tau,
    f_W_snark_secondary_eval_Cz_at_tau,
    f_W_snark_secondary_comm_output_arr,
    f_W_snark_secondary_claims_product_arr,
    f_W_snark_secondary_sc_sat,
    f_W_snark_secondary_eval_left_arr,
    f_W_snark_secondary_eval_right_arr,
    f_W_snark_secondary_eval_output_arr,
    f_W_snark_secondary_eval_Az,
    f_W_snark_secondary_eval_Bz,
    f_W_snark_secondary_eval_Cz,
    f_W_snark_secondary_eval_E,
    f_W_snark_secondary_eval_val_A,
    f_W_snark_secondary_eval_val_B,
    f_W_snark_secondary_eval_val_C,
    f_W_snark_secondary_eval_E_row,
    f_W_snark_secondary_eval_E_col,
    f_W_snark_secondary_eval_input_arr,
    f_W_snark_secondary_eval_row_audit_ts,
    f_W_snark_secondary_eval_row,
    f_W_snark_secondary_eval_E_row_at_r_prod,
    f_W_snark_secondary_eval_row_read_ts,
    f_W_snark_secondary_eval_col_audit_ts,
    f_W_snark_secondary_eval_col,
    f_W_snark_secondary_eval_E_col_at_r_prod,
    f_W_snark_secondary_eval_col_read_ts,
    f_W_snark_secondary_eval_W,
    f_W_snark_secondary_evals_batch_arr,
    f_W_snark_secondary_sc_proof_batch,
    f_W_snark_secondary_eval_output2_arr,
    r_W_snark_primary_comm_Az,
    r_W_snark_primary_comm_Bz,
    r_W_snark_primary_comm_Cz,
    r_W_snark_primary_comm_E_row,
    r_W_snark_primary_comm_E_col,
    r_W_snark_primary_eval_Az_at_tau,
    r_W_snark_primary_eval_Bz_at_tau,
    r_W_snark_primary_eval_Cz_at_tau,
    r_W_snark_primary_comm_output_arr,
    r_W_snark_primary_claims_product_arr,
    r_W_snark_primary_sc_sat,
    r_W_snark_primary_eval_left_arr,
    r_W_snark_primary_eval_right_arr,
    r_W_snark_primary_eval_output_arr,
    r_W_snark_primary_eval_Az,
    r_W_snark_primary_eval_Bz,
    r_W_snark_primary_eval_Cz,
    r_W_snark_primary_eval_E,
    r_W_snark_primary_eval_val_A,
    r_W_snark_primary_eval_val_B,
    r_W_snark_primary_eval_val_C,
    r_W_snark_primary_eval_E_row,
    r_W_snark_primary_eval_E_col,
    r_W_snark_primary_eval_input_arr,
    r_W_snark_primary_eval_row_audit_ts,
    r_W_snark_primary_eval_row,
    r_W_snark_primary_eval_E_row_at_r_prod,
    r_W_snark_primary_eval_row_read_ts,
    r_W_snark_primary_eval_col_audit_ts,
    r_W_snark_primary_eval_col,
    r_W_snark_primary_eval_E_col_at_r_prod,
    r_W_snark_primary_eval_col_read_ts,
    r_W_snark_primary_eval_W,
    r_W_snark_primary_evals_batch_arr,
    r_W_snark_primary_sc_proof_batch,
    r_W_snark_primary_eval_output2_arr,
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
        'vk_secondary_S_comm_N',
        'vk_secondary_S_comm_comm_val_A',
        'vk_secondary_S_comm_comm_val_B',
        'vk_secondary_S_comm_comm_val_C',
        'vk_secondary_S_comm_comm_row',
        'vk_secondary_S_comm_comm_row_read_ts',
        'vk_secondary_S_comm_comm_row_audit_ts',
        'vk_secondary_S_comm_comm_col',
        'vk_secondary_S_comm_comm_col_read_ts',
        'vk_secondary_S_comm_comm_col_audit_ts',
        'vk_secondary_digest',
        'vk_primary_num_cons',
        'vk_primary_num_vars',
        'vk_primary_S_comm_N',
        'vk_primary_S_comm_comm_val_A',
        'vk_primary_S_comm_comm_val_B',
        'vk_primary_S_comm_comm_val_C',
        'vk_primary_S_comm_comm_row',
        'vk_primary_S_comm_comm_row_read_ts',
        'vk_primary_S_comm_comm_row_audit_ts',
        'vk_primary_S_comm_comm_col',
        'vk_primary_S_comm_comm_col_read_ts',
        'vk_primary_S_comm_comm_col_audit_ts',
        'vk_primary_digest',
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
    vk_secondary_S_comm_N,
    vk_secondary_S_comm_comm_val_A,
    vk_secondary_S_comm_comm_val_B,
    vk_secondary_S_comm_comm_val_C,
    vk_secondary_S_comm_comm_row,
    vk_secondary_S_comm_comm_row_read_ts,
    vk_secondary_S_comm_comm_row_audit_ts,
    vk_secondary_S_comm_comm_col,
    vk_secondary_S_comm_comm_col_read_ts,
    vk_secondary_S_comm_comm_col_audit_ts,
    vk_secondary_digest,
    vk_primary_num_cons,
    vk_primary_num_vars,
    vk_primary_S_comm_N,
    vk_primary_S_comm_comm_val_A,
    vk_primary_S_comm_comm_val_B,
    vk_primary_S_comm_comm_val_C,
    vk_primary_S_comm_comm_row,
    vk_primary_S_comm_comm_row_read_ts,
    vk_primary_S_comm_comm_row_audit_ts,
    vk_primary_S_comm_comm_col,
    vk_primary_S_comm_comm_col_read_ts,
    vk_primary_S_comm_comm_col_audit_ts,
    vk_primary_digest,
)

CONTRACT_ADDRESS = sys.argv[3]
RPC_URL = sys.argv[4]
PRIVATE_KEY = sys.argv[5]

PUSH_TO_PROOF_FUNC_SIG = "pushToProof((" \
                         "(uint256,uint256[])," \
                         "(uint256,uint256,uint256[],uint256)," \
                         "(uint256,uint256,uint256[],uint256)," \
                         "uint256[]," \
                         "uint256[]," \
                         "uint256," \
                         "(uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256[],uint256[],((uint256[])[]),uint256[],uint256[],uint256[],uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256[],uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256[],((uint256[])[]),uint256[])," \
                         "(uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256[],uint256[],((uint256[])[]),uint256[],uint256[],uint256[],uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256[],uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256[],((uint256[])[]),uint256[])" \
                         "))"
PUSH_TO_VK_FUNC_SIG = "pushToVk((uint256,uint256,uint256,(uint256[],uint256[]),(uint256[],uint256[]),((uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256),uint256),(uint256,uint256,(uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256),uint256)))"

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


# Input should be represented as : [['x', 'y', 'z'], ['x1', 'y1'], ['y2, 'z2']]
# Output should be represented as : ([(['x', 'y', 'z']),(['x1', 'y1']),(['y2, 'z2'])])
def addSumcheckProof(scSat, useReversing):
    scSatString = '(['
    # add body
    for item in scSat[:len(scSat) - 1]:
        scSatString = scSatString + '('
        scSatString = scSatString + addNumbersArray(item, useReversing)
        scSatString = scSatString + '),'
    # add tail
    scSatString = scSatString + '('
    scSatString = scSatString + addNumbersArray(scSat[len(scSat) - 1], useReversing)
    scSatString = scSatString + ')'
    return scSatString + '])'

# Constructing 'cast send' string for sending transaction with the proof to the deployed Anvil node
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
    command = command + addNumbersArray(data.zn_secondary, True) + ','
    command = command + addNumber(data.nifs_compressed_comm_T, False) + ',('
    command = command + addNumber(data.f_W_snark_secondary_comm_Az, False) + ','
    command = command + addNumber(data.f_W_snark_secondary_comm_Bz, False) + ','
    command = command + addNumber(data.f_W_snark_secondary_comm_Cz, False) + ','
    command = command + addNumber(data.f_W_snark_secondary_comm_E_row, False) + ','
    command = command + addNumber(data.f_W_snark_secondary_comm_E_col, False) + ','
    command = command + addNumber(data.f_W_snark_secondary_eval_Az_at_tau, True) + ','
    command = command + addNumber(data.f_W_snark_secondary_eval_Bz_at_tau, True) + ','
    command = command + addNumber(data.f_W_snark_secondary_eval_Cz_at_tau, True) + ','
    command = command + addNumbersArray(data.f_W_snark_secondary_comm_output_arr, False) + ','
    command = command + addNumbersArray(data.f_W_snark_secondary_claims_product_arr, True) + ','
    command = command + addSumcheckProof(data.f_W_snark_secondary_sc_sat, True) + ','
    command = command + addNumbersArray(data.f_W_snark_secondary_eval_left_arr, True) + ','
    command = command + addNumbersArray(data.f_W_snark_secondary_eval_right_arr, True) + ','
    command = command + addNumbersArray(data.f_W_snark_secondary_eval_output_arr, True) + ','
    command = command + addNumber(data.f_W_snark_secondary_eval_Az, True) + ','
    command = command + addNumber(data.f_W_snark_secondary_eval_Bz, True) + ','
    command = command + addNumber(data.f_W_snark_secondary_eval_Cz, True) + ','
    command = command + addNumber(data.f_W_snark_secondary_eval_E, True) + ','
    command = command + addNumber(data.f_W_snark_secondary_eval_val_A, True) + ','
    command = command + addNumber(data.f_W_snark_secondary_eval_val_B, True) + ','
    command = command + addNumber(data.f_W_snark_secondary_eval_val_C, True) + ','
    command = command + addNumber(data.f_W_snark_secondary_eval_E_row, True) + ','
    command = command + addNumber(data.f_W_snark_secondary_eval_E_col, True) + ','
    command = command + addNumbersArray(data.f_W_snark_secondary_eval_input_arr, True) + ','
    command = command + addNumber(data.f_W_snark_secondary_eval_row_audit_ts, True) + ','
    command = command + addNumber(data.f_W_snark_secondary_eval_row, True) + ','
    command = command + addNumber(data.f_W_snark_secondary_eval_E_row_at_r_prod, True) + ','
    command = command + addNumber(data.f_W_snark_secondary_eval_row_read_ts, True) + ','
    command = command + addNumber(data.f_W_snark_secondary_eval_col_audit_ts, True) + ','
    command = command + addNumber(data.f_W_snark_secondary_eval_col, True) + ','
    command = command + addNumber(data.f_W_snark_secondary_eval_E_col_at_r_prod, True) + ','
    command = command + addNumber(data.f_W_snark_secondary_eval_col_read_ts, True) + ','
    command = command + addNumber(data.f_W_snark_secondary_eval_W, True) + ','
    command = command + addNumbersArray(data.f_W_snark_secondary_evals_batch_arr, True) + ','
    command = command + addSumcheckProof(data.f_W_snark_secondary_sc_proof_batch, True) + ','
    command = command + addNumbersArray(data.f_W_snark_secondary_eval_output2_arr, True) + '),('
    command = command + addNumber(data.r_W_snark_primary_comm_Az, False) + ','
    command = command + addNumber(data.r_W_snark_primary_comm_Bz, False) + ','
    command = command + addNumber(data.r_W_snark_primary_comm_Cz, False) + ','
    command = command + addNumber(data.r_W_snark_primary_comm_E_row, False) + ','
    command = command + addNumber(data.r_W_snark_primary_comm_E_col, False) + ','
    command = command + addNumber(data.r_W_snark_primary_eval_Az_at_tau, True) + ','
    command = command + addNumber(data.r_W_snark_primary_eval_Bz_at_tau, True) + ','
    command = command + addNumber(data.r_W_snark_primary_eval_Cz_at_tau, True) + ','
    command = command + addNumbersArray(data.r_W_snark_primary_comm_output_arr, False) + ','
    command = command + addNumbersArray(data.r_W_snark_primary_claims_product_arr, True) + ','
    command = command + addSumcheckProof(data.r_W_snark_primary_sc_sat, True) + ','
    command = command + addNumbersArray(data.r_W_snark_primary_eval_left_arr, True) + ','
    command = command + addNumbersArray(data.r_W_snark_primary_eval_right_arr, True) + ','
    command = command + addNumbersArray(data.r_W_snark_primary_eval_output_arr, True) + ','
    command = command + addNumber(data.r_W_snark_primary_eval_Az, True) + ','
    command = command + addNumber(data.r_W_snark_primary_eval_Bz, True) + ','
    command = command + addNumber(data.r_W_snark_primary_eval_Cz, True) + ','
    command = command + addNumber(data.r_W_snark_primary_eval_E, True) + ','
    command = command + addNumber(data.r_W_snark_primary_eval_val_A, True) + ','
    command = command + addNumber(data.r_W_snark_primary_eval_val_B, True) + ','
    command = command + addNumber(data.r_W_snark_primary_eval_val_C, True) + ','
    command = command + addNumber(data.r_W_snark_primary_eval_E_row, True) + ','
    command = command + addNumber(data.r_W_snark_primary_eval_E_col, True) + ','
    command = command + addNumbersArray(data.r_W_snark_primary_eval_input_arr, True) + ','
    command = command + addNumber(data.r_W_snark_primary_eval_row_audit_ts, True) + ','
    command = command + addNumber(data.r_W_snark_primary_eval_row, True) + ','
    command = command + addNumber(data.r_W_snark_primary_eval_E_row_at_r_prod, True) + ','
    command = command + addNumber(data.r_W_snark_primary_eval_row_read_ts, True) + ','
    command = command + addNumber(data.r_W_snark_primary_eval_col_audit_ts, True) + ','
    command = command + addNumber(data.r_W_snark_primary_eval_col, True) + ','
    command = command + addNumber(data.r_W_snark_primary_eval_E_col_at_r_prod, True) + ','
    command = command + addNumber(data.r_W_snark_primary_eval_col_read_ts, True) + ','
    command = command + addNumber(data.r_W_snark_primary_eval_W, True) + ','
    command = command + addNumbersArray(data.r_W_snark_primary_evals_batch_arr, True) + ','
    command = command + addSumcheckProof(data.r_W_snark_primary_sc_proof_batch, True) + ','
    command = command + addNumbersArray(data.r_W_snark_primary_eval_output2_arr, True) + ')'
    command = command + ')\" --private-key ' + PRIVATE_KEY
    command = command + ' --rpc-url ' + RPC_URL
    if os.system(command) != 0:
        print("pushToProof failed")
        exit(1)

# TODO currently it pushes only constants for a single round of Poseidon just for comparison with hardcoded ones in Poseidon Solidity contract
# Constructing 'cast send' string for sending transaction with the public parameters to the deployed Anvil node
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
    command = command + addNumbersArray(data.constants_addRoundConstantsSecondary, True) + '),(('
    command = command + addNumber(hex(data.vk_secondary_S_comm_N), False) + ','
    command = command + addNumber(data.vk_secondary_S_comm_comm_val_A, False) + ','
    command = command + addNumber(data.vk_secondary_S_comm_comm_val_B, False) + ','
    command = command + addNumber(data.vk_secondary_S_comm_comm_val_C, False) + ','
    command = command + addNumber(data.vk_secondary_S_comm_comm_row, False) + ','
    command = command + addNumber(data.vk_secondary_S_comm_comm_row_read_ts, False) + ','
    command = command + addNumber(data.vk_secondary_S_comm_comm_row_audit_ts, False) + ','
    command = command + addNumber(data.vk_secondary_S_comm_comm_col, False) + ','
    command = command + addNumber(data.vk_secondary_S_comm_comm_col_read_ts, False) + ','
    command = command + addNumber(data.vk_secondary_S_comm_comm_col_audit_ts, False) + '),'
    command = command + addNumber(data.vk_secondary_digest, True) + '),('
    command = command + addNumber(hex(data.vk_primary_num_cons), False) + ','
    command = command + addNumber(hex(data.vk_primary_num_vars), False) + ',('
    command = command + addNumber(hex(data.vk_primary_S_comm_N), False) + ','
    command = command + addNumber(data.vk_primary_S_comm_comm_val_A, False) + ','
    command = command + addNumber(data.vk_primary_S_comm_comm_val_B, False) + ','
    command = command + addNumber(data.vk_primary_S_comm_comm_val_C, False) + ','
    command = command + addNumber(data.vk_primary_S_comm_comm_row, False) + ','
    command = command + addNumber(data.vk_primary_S_comm_comm_row_read_ts, False) + ','
    command = command + addNumber(data.vk_primary_S_comm_comm_row_audit_ts, False) + ','
    command = command + addNumber(data.vk_primary_S_comm_comm_col, False) + ','
    command = command + addNumber(data.vk_primary_S_comm_comm_col_read_ts, False) + ','
    command = command + addNumber(data.vk_primary_S_comm_comm_col_audit_ts, False) + '),'
    command = command + addNumber(data.vk_primary_digest, True) + ')'
    command = command + ')\" --private-key ' + PRIVATE_KEY
    command = command + ' --rpc-url ' + RPC_URL
    if os.system(command) != 0:
        print("pushToVk failed")
        exit(1)

pushToProof(parsedProof)
pushToVk(parsedVk)
