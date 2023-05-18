import json
import os
import sys

fn = sys.argv[1]
if not os.path.exists(fn):
    print("constants (json) input file is missing")
    exit(1)

f = open(os.path.basename(fn))
data = json.load(f)

# F_arity_primary
print("F_arity_primary: " + str(data['F_arity_primary']))
# F_arity_secondary
print("F_arity_secondary: " + str(data['F_arity_secondary']))

# ro_const_primary
ro_consts_primary = data['ro_consts_primary']
mds = ro_consts_primary['mds']
m = mds['m']
constants_M = []
for matrix in m:
    constants_M.append(matrix)

print("length of 'm': " + str(len(constants_M)))
print("length of 'm[0]': " + str(len(constants_M[0])))
print("m[0][0]: ")
print(constants_M[0][0])

m_inv = mds['m_inv']
constants_M_inv = []
for matrix_inv in m_inv:
    constants_M_inv.append(matrix_inv)

print("length of 'm_inv': " + str(len(constants_M_inv)))
print("length of 'm_inv[0]': " + str(len(constants_M_inv[0])))
print("m_inv[0][0]: ")
print(constants_M_inv[0][0])

m_hat = mds['m_hat']
constants_M_hat = []
for matrix_hat in m_hat:
    constants_M_hat.append(matrix_hat)

print("length of 'm_hat': " + str(len(constants_M_hat)))
print("length of 'm_hat[0]': " + str(len(constants_M_hat[0])))
print("m_hat[0][0]: ")
print(constants_M_hat[0][0])

m_hat_inv = mds['m_hat_inv']
constants_M_hat_inv = []
for matrix_hat_inv in m_hat_inv:
    constants_M_hat_inv.append(matrix_hat_inv)

print("length of 'm_hat_inv': " + str(len(constants_M_hat_inv)))
print("length of 'm_hat_inv[0]': " + str(len(constants_M_hat_inv[0])))
print("m_hat_inv[0][0]: ")
print(constants_M_hat_inv[0][0])

m_prime = mds['m_prime']
constants_M_prime = []
for matrix_prime in m_prime:
    constants_M_prime.append(matrix_prime)

print("length of 'm_prime': " + str(len(constants_M_prime)))
print("length of 'm_prime[0]': " + str(len(constants_M_prime[0])))
print("m_prime[0][0]: ")
print(constants_M_prime[0][0])

m_double_prime = mds['m_double_prime']
constants_M_double_prime = []
for matrix_double_prime in m_double_prime:
    constants_M_double_prime.append(matrix_double_prime)

print("length of 'm_double_prime': " + str(len(constants_M_double_prime)))
print("length of 'm_double_prime[0]': " + str(len(constants_M_double_prime[0])))
print("m_double_prime[0][0]: ")
print(constants_M_double_prime[0][0])

print("crc (primary)")
crc = ro_consts_primary['crc']
print("length of 'crc': " + str(len(crc)))
print(crc[0])

print("psm")
psm = ro_consts_primary['psm']
psm_list = []
for psm_unit in psm:
    psm_list.append(psm_unit)

print("length of 'psm_list': " + str(len(psm_list)))
print("length of 'psm_list[0]': " + str(len(psm_list[0])))
print("psm_list[0][0]: ")
print(psm_list[0][0])


print("sm")
sm = ro_consts_primary['sm']
sm_list = []
for sm_unit in sm:
    sm_list.append(sm_unit)

print("length of 'sm_list': " + str(len(sm_list)))
sm_unit = sm_list[0]
print("length of 'sm[0].w_hat': " + str(len(sm_unit['w_hat'])))
print("length of 'sm[0].v_rest': " + str(len(sm_unit['v_rest'])))
print("sm[0].w_hat[0]: " + str(sm_unit['w_hat'][0]))
print("sm[0].v_rest[0]: " + str(sm_unit['v_rest'][0]))

print("s: " + ro_consts_primary['s'])
print("rf: " + str(ro_consts_primary['rf']))
print("rp: " + str(ro_consts_primary['rp']))
print("ht: " + ro_consts_primary['ht'])

# ro_const_secondary
print("ro_consts_secondary")
ro_consts_secondary = data['ro_consts_secondary']
mds = ro_consts_secondary['mds']
m = mds['m']
constants_M = []
for matrix in m:
    constants_M.append(matrix)

print("length of 'm': " + str(len(constants_M)))
print("length of 'm[0]': " + str(len(constants_M[0])))
print("m[0][0]: ")
print(constants_M[0][0])

m_inv = mds['m_inv']
constants_M_inv = []
for matrix_inv in m_inv:
    constants_M_inv.append(matrix_inv)

print("length of 'm_inv': " + str(len(constants_M_inv)))
print("length of 'm_inv[0]': " + str(len(constants_M_inv[0])))
print("m_inv[0][0]: ")
print(constants_M_inv[0][0])

m_hat = mds['m_hat']
constants_M_hat = []
for matrix_hat in m_hat:
    constants_M_hat.append(matrix_hat)

print("length of 'm_hat': " + str(len(constants_M_hat)))
print("length of 'm_hat[0]': " + str(len(constants_M_hat[0])))
print("m_hat[0][0]: ")
print(constants_M_hat[0][0])

m_hat_inv = mds['m_hat_inv']
constants_M_hat_inv = []
for matrix_hat_inv in m_hat_inv:
    constants_M_hat_inv.append(matrix_hat_inv)

print("length of 'm_hat_inv': " + str(len(constants_M_hat_inv)))
print("length of 'm_hat_inv[0]': " + str(len(constants_M_hat_inv[0])))
print("m_hat_inv[0][0]: ")
print(constants_M_hat_inv[0][0])

m_prime = mds['m_prime']
constants_M_prime = []
for matrix_prime in m_prime:
    constants_M_prime.append(matrix_prime)

print("length of 'm_prime': " + str(len(constants_M_prime)))
print("length of 'm_prime[0]': " + str(len(constants_M_prime[0])))
print("m_prime[0][0]: ")
print(constants_M_prime[0][0])

m_double_prime = mds['m_double_prime']
constants_M_double_prime = []
for matrix_double_prime in m_double_prime:
    constants_M_double_prime.append(matrix_double_prime)

print("length of 'm_double_prime': " + str(len(constants_M_double_prime)))
print("length of 'm_double_prime[0]': " + str(len(constants_M_double_prime[0])))
print("m_double_prime[0][0]: ")
print(constants_M_double_prime[0][0])

print("crc (secondary)")
crc = ro_consts_secondary['crc']
print("length of 'crc': " + str(len(crc)))
print(crc[0])

print("psm")
psm = ro_consts_secondary['psm']
psm_list = []
for psm_unit in psm:
    psm_list.append(psm_unit)

print("length of 'psm_list': " + str(len(psm_list)))
print("length of 'psm_list[0]': " + str(len(psm_list[0])))
print("psm_list[0][0]: ")
print(psm_list[0][0])


print("sm")
sm = ro_consts_secondary['sm']
sm_list = []
for sm_unit in sm:
    sm_list.append(sm_unit)

print("length of 'sm_list': " + str(len(sm_list)))
sm_unit = sm_list[0]
print("length of 'sm[0].w_hat': " + str(len(sm_unit['w_hat'])))
print("length of 'sm[0].v_rest': " + str(len(sm_unit['v_rest'])))
print("sm[0].w_hat[0]: " + str(sm_unit['w_hat'][0]))
print("sm[0].v_rest[0]: " + str(sm_unit['v_rest'][0]))

print("s: " + ro_consts_secondary['s'])
print("rf: " + str(ro_consts_secondary['rf']))
print("rp: " + str(ro_consts_secondary['rp']))
print("ht: " + ro_consts_secondary['ht'])

# r1cs_shape_primary_digest
print("r1cs_shape_primary_digest: " + data['r1cs_shape_primary_digest'])
# r1cs_shape_secondary_digest
print("r1cs_shape_secondary_digest: " + data['r1cs_shape_secondary_digest'])

# vk_primary
vk_primary = data['vk_primary']
print("vk_primary")
print("num_cons: " + str(vk_primary['num_cons']))
print("num_vars: " + str(vk_primary['num_vars']))

vk_ee = vk_primary['vk_ee']

ck_v = vk_ee['ck_v']
ck = ck_v['ck']
print("length of 'ck': ", str(len(ck)))
print("last ck[131071]: " + ck[131071])

ck_s = vk_ee['ck_s']
print("ck_s.ck: ", ck_s['ck'])

comm = vk_primary['comm']
S = comm['S']
print("comm.S.num_cons: ", str(S['num_cons']))
print("comm.S.num_vars: ", str(S['num_vars']))
print("comm.S.num_io: ", str(S['num_io']))
A = S['A']
print("length of 'comm.S.A': ", str(len(A)))
print("length of 'comm.S.A[0]': ", str(len(A[0])))
print("'comm.S.A[0][0]': ", str(A[0][0]))
print("'comm.S.A[0][1]': ", str(A[0][1]))
print("'comm.S.A[0][2]': ", A[0][2])
print("'comm.S.A[70502][0]': ", A[70502][0])
print("'comm.S.A[70502][1]': ", A[70502][1])
print("'comm.S.A[70502][2]': ", A[70502][2])

B = S['B']
print("length of 'comm.S.B': ", str(len(B)))
print("length of 'comm.S.B[0]': ", str(len(B[0])))
print("'comm.S.B[0][0]': ", str(B[0][0]))
print("'comm.S.B[0][1]': ", str(B[0][1]))
print("'comm.S.B[0][2]': ", B[0][2])
print("'comm.S.B[43589][0]': ", B[43589][0])
print("'comm.S.B[43589][1]': ", B[43589][1])
print("'comm.S.B[43589][2]': ", B[43589][2])

C = S['C']
print("length of 'comm.S.C': ", str(len(C)))
print("length of 'comm.S.C[0]': ", str(len(C[0])))
print("'comm.S.C[0][0]': ", str(C[0][0]))
print("'comm.S.C[0][1]': ", str(C[0][1]))
print("'comm.S.C[0][2]': ", C[0][2])
print("'comm.S.C[10068][0]': ", C[10068][0])
print("'comm.S.C[10068][1]': ", C[10068][1])
print("'comm.S.C[10068][2]': ", C[10068][2])

digest = S['digest']
print("digest': ", digest)


# vk_secondary
vk_secondary = data['vk_secondary']
print("vk_secondary")
print("num_cons: " + str(vk_secondary['num_cons']))
print("num_vars: " + str(vk_secondary['num_vars']))

vk_ee = vk_secondary['vk_ee']

ck_v = vk_ee['ck_v']
ck = ck_v['ck']
print("length of 'ck': ", str(len(ck)))
print("last ck[131071]: " + ck[131071])

ck_s = vk_ee['ck_s']
print("ck_s.ck: ", ck_s['ck'])

comm = vk_secondary['comm']
S = comm['S']
print("comm.S.num_cons: ", str(S['num_cons']))
print("comm.S.num_vars: ", str(S['num_vars']))
print("comm.S.num_io: ", str(S['num_io']))

A = S['A']
print("length of 'comm.S.A': ", str(len(A)))
print("length of 'comm.S.A[0]': ", str(len(A[0])))
print("'comm.S.A[0][0]': ", str(A[0][0]))
print("'comm.S.A[0][1]': ", str(A[0][1]))
print("'comm.S.A[0][2]': ", A[0][2])
print("'comm.S.A[72566][0]': ", A[72566][0])
print("'comm.S.A[72566][1]': ", A[72566][1])
print("'comm.S.A[72566][2]': ", A[72566][2])

B = S['B']
print("length of 'comm.S.B': ", str(len(B)))
print("length of 'comm.S.B[0]': ", str(len(B[0])))
print("'comm.S.B[0][0]': ", str(B[0][0]))
print("'comm.S.B[0][1]': ", str(B[0][1]))
print("'comm.S.B[0][2]': ", B[0][2])
print("'comm.S.B[44124][0]': ", B[44124][0])
print("'comm.S.B[44124][1]': ", B[44124][1])
print("'comm.S.B[44124][2]': ", B[44124][2])

C = S['C']
print("length of 'comm.S.C': ", str(len(C)))
print("length of 'comm.S.C[0]': ", str(len(C[0])))
print("'comm.S.C[0][0]': ", str(C[0][0]))
print("'comm.S.C[0][1]': ", str(C[0][1]))
print("'comm.S.C[0][2]': ", C[0][2])
print("'comm.S.C[10081][0]': ", C[10081][0])
print("'comm.S.C[10081][1]': ", C[10081][1])
print("'comm.S.C[10081][2]': ", C[10081][2])

digest = S['digest']
print("digest': ", digest)