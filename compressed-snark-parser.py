import json
import os
import sys

fn = sys.argv[1]
if not os.path.exists(fn):
    print("constants (json) input file is missing")
    exit(1)

f = open(os.path.basename(fn))
data = json.load(f)

r_U_primary = data['r_U_primary']

# r_U_primary
print("r_U_primary")
comm_W = r_U_primary['comm_W']
print("r_U_primary.comm_W.comm: " + comm_W['comm'])
comm_E = r_U_primary['comm_E']
print("r_U_primary.comm_E.comm: " + comm_E['comm'])
X = r_U_primary['X']
print("length of 'r_U_primary.X': " + str(len(X)))
print("r_U_primary.X[0]: " + X[0])
print("r_U_primary.X[1]: " + X[1])
print("r_U_primary.u: " + r_U_primary['u'])

l_u_primary = data['l_u_primary']
# l_U_primary
print("l_U_primary")
comm_W = l_u_primary['comm_W']
print("l_U_primary.comm_W.comm: " + comm_W['comm'])
X = l_u_primary['X']
print("length of 'l_u_primary.X': " + str(len(X)))
print("l_u_primary.X[0]: " + X[0])
print("l_u_primary.X[1]: " + X[1])

# nifs_primary
print("nifs_primary")
nifs_primary = data['nifs_primary']
comm_T = nifs_primary['comm_T']
comm = comm_T['comm']
print("nifs_primary.comm_T.comm.repr", comm['repr'])

# f_W_snark_primary
print("f_W_snark_primary")
f_W_snark_primary = data['f_W_snark_primary']
sc_proof_outer = f_W_snark_primary['sc_proof_outer']
compressed_polys = sc_proof_outer['compressed_polys']
print("length of 'f_W_snark_primary.sc_proof_outer.compressed_polys': ", len(compressed_polys))
for compressed_poly in compressed_polys:
    coeffs_except_linear_term = compressed_poly['coeffs_except_linear_term']
    print("coeffs_except_linear_term[0]': ", coeffs_except_linear_term[0], "'coeffs_except_linear_term' len: ", len(coeffs_except_linear_term))

claims_outer = f_W_snark_primary['claims_outer']
print("length of 'f_W_snark_primary.claims_outer' ", len(claims_outer))
print("f_W_snark_primary.claims_outer[2]", claims_outer[2])

eval_E = f_W_snark_primary['eval_E']
print("f_W_snark_primary.eval_E ", eval_E)

sc_proof_inner = f_W_snark_primary['sc_proof_inner']
compressed_polys = sc_proof_inner['compressed_polys']
print("length of 'f_W_snark_primary.sc_proof_inner.compressed_polys': ", len(compressed_polys))
for compressed_poly in compressed_polys:
    coeffs_except_linear_term = compressed_poly['coeffs_except_linear_term']
    print("coeffs_except_linear_term[0]': ", coeffs_except_linear_term[0], "'coeffs_except_linear_term' len: ", len(coeffs_except_linear_term))

eval_W = f_W_snark_primary['eval_W']
print("f_W_snark_primary.eval_W ", eval_W)

sc_proof_batch = f_W_snark_primary['sc_proof_batch']
compressed_polys = sc_proof_batch['compressed_polys']
print("length of 'f_W_snark_primary.sc_proof_batch.compressed_polys': ", len(compressed_polys))
for compressed_poly in compressed_polys:
    coeffs_except_linear_term = compressed_poly['coeffs_except_linear_term']
    print("coeffs_except_linear_term[0]': ", coeffs_except_linear_term[0], "'coeffs_except_linear_term' len: ", len(coeffs_except_linear_term))

eval_E_prime = f_W_snark_primary['eval_E_prime']
print("f_W_snark_primary.eval_E_prime ", eval_E_prime)

eval_W_prime = f_W_snark_primary['eval_W_prime']
print("f_W_snark_primary.eval_W_prime ", eval_W_prime)

eval_arg = f_W_snark_primary['eval_arg']
ipa = eval_arg['ipa']
L_vec = ipa['L_vec']
print("length of 'f_W_snark_primary.eval_arg.ipa.L_vec' ", len(L_vec))
for L in L_vec:
    comm = L['comm']
    repr = comm['repr']
    print(repr)

R_vec = ipa['R_vec']
print("length of 'f_W_snark_primary.eval_arg.ipa.R_vec' ", len(R_vec))
for R in R_vec:
    comm = R['comm']
    repr = comm['repr']
    print(repr)

a_hat = ipa['a_hat']
print("f_W_snark_primary.eval_arg.ipa.a_hat: ", a_hat)

# r_U_secondary
print("r_U_secondary")
r_U_secondary = data['r_U_secondary']
comm_W = r_U_secondary['comm_W']
print("r_U_secondary.comm_W.comm ", comm_W['comm'])

comm_E = r_U_secondary['comm_E']
print("r_U_secondary.comm_E.comm ", comm_E['comm'])

X = r_U_secondary['X']
print("length of r_U_secondary.X ", len(X))
print("X last: ", X[len(X) - 1])

u = r_U_secondary['u']
print("u: ", u)

# l_U_secondary
print("l_u_secondary")
l_U_secondary = data['l_u_secondary']
comm_W = l_U_secondary['comm_W']
print("l_u_secondary.comm_W.comm ", comm_W['comm'])

X = l_U_secondary['X']
print("length of l_U_secondary.X ", len(X))
print("X last: ", X[len(X) - 1])

# nifs_secondary
print("nifs_secondary")
nifs_secondary = data['nifs_secondary']
comm_T = nifs_secondary['comm_T']
comm = comm_T['comm']
print("nifs_secondary.comm_T.comm.repr: ", comm['repr'])

# f_W_snark_secondary
f_W_snark_secondary = data['f_W_snark_secondary']
sc_proof_outer = f_W_snark_secondary['sc_proof_outer']
compressed_polys = sc_proof_outer['compressed_polys']
print("length of 'f_W_snark_secondary.sc_proof_outer.compressed_polys': ", len(compressed_polys))
for compressed_poly in compressed_polys:
    coeffs_except_linear_term = compressed_poly['coeffs_except_linear_term']
    print("coeffs_except_linear_term[0]': ", coeffs_except_linear_term[0], "'coeffs_except_linear_term' len: ", len(coeffs_except_linear_term))

claims_outer = f_W_snark_secondary['claims_outer']
print("length of 'f_W_snark_secondary.claims_outer' ", len(claims_outer))
print("f_W_snark_secondary.claims_outer[2]", claims_outer[2])

eval_E = f_W_snark_secondary['eval_E']
print("f_W_snark_secondary.eval_E ", eval_E)

sc_proof_inner = f_W_snark_secondary['sc_proof_inner']
compressed_polys = sc_proof_inner['compressed_polys']
print("length of 'f_W_snark_secondary.sc_proof_inner.compressed_polys': ", len(compressed_polys))
for compressed_poly in compressed_polys:
    coeffs_except_linear_term = compressed_poly['coeffs_except_linear_term']
    print("coeffs_except_linear_term[0]': ", coeffs_except_linear_term[0], "'coeffs_except_linear_term' len: ", len(coeffs_except_linear_term))

eval_W = f_W_snark_secondary['eval_W']
print("f_W_snark_secondary.eval_W ", eval_W)

sc_proof_batch = f_W_snark_secondary['sc_proof_batch']
compressed_polys = sc_proof_batch['compressed_polys']
print("length of 'f_W_snark_secondary.sc_proof_batch.compressed_polys': ", len(compressed_polys))
for compressed_poly in compressed_polys:
    coeffs_except_linear_term = compressed_poly['coeffs_except_linear_term']
    print("coeffs_except_linear_term[0]': ", coeffs_except_linear_term[0], "'coeffs_except_linear_term' len: ", len(coeffs_except_linear_term))

eval_E_prime = f_W_snark_secondary['eval_E_prime']
print("f_W_snark_secondary.eval_E_prime ", eval_E_prime)

eval_W_prime = f_W_snark_secondary['eval_W_prime']
print("f_W_snark_secondary.eval_W_prime ", eval_W_prime)

eval_arg = f_W_snark_secondary['eval_arg']
ipa = eval_arg['ipa']
L_vec = ipa['L_vec']
print("length of 'f_W_snark_secondary.eval_arg.ipa.L_vec' ", len(L_vec))
for L in L_vec:
    comm = L['comm']
    repr = comm['repr']
    print(repr)

R_vec = ipa['R_vec']
print("length of 'f_W_snark_secondary.eval_arg.ipa.R_vec' ", len(R_vec))
for R in R_vec:
    comm = R['comm']
    repr = comm['repr']
    print(repr)

a_hat = ipa['a_hat']
print("f_W_snark_secondary.eval_arg.ipa.a_hat: ", a_hat)

zn_primary = data['zn_primary']
zn_secondary = data['zn_secondary']
print('zn_primary: ', zn_primary)
print('zn_secondary: ', zn_secondary)
