// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.16;

library PoseidonU24Optimized {
    struct SparseMatrixU24 {
        uint256[] w_hat;
        uint256[] v_rest;
    }

    struct PoseidonConstantsU24 {
        uint256[][] m;
        uint256[][] psm;
        SparseMatrixU24[] sparseMatrices;
        uint256[] round_constants;
        uint256 fullRounds;
        uint256 partialRounds;
    }

    function newConstants(
        uint256[][] memory m,
        uint256[][] memory psm,
        uint256[][] memory w_hats,
        uint256[][] memory v_rests,
        uint256[] memory round_constants,
        uint256 fullRounds,
        uint256 partialRounds
    ) internal pure returns (PoseidonConstantsU24 memory) {
        uint256 index;
        require(m.length == 25, "[Poseidon::newConstants] m.length != 25");
        for (index = 0; index < 25; index++) {
            require(m[index].length == 25, "[Poseidon::newConstants] m[index].length != 25");
        }
        require(psm.length == 25, "[Poseidon::newConstants] psm.length != 25");
        require(w_hats.length == partialRounds, "[Poseidon::newConstants] w_hats.length != partialRounds");
        require(v_rests.length == partialRounds, "[Poseidon::newConstants] v_rests.length != partialRounds");

        uint256[][] memory psm_ = new uint256[][](25);
        for (uint256 i = 0; i < 25; i++) {
            psm_[i] = new uint256[](25);
            for (uint256 j = 0; j < 25; j++) {
                psm_[i][j] = psm[j][i];
            }
        }

        SparseMatrixU24[] memory sparseMatrices = new SparseMatrixU24[](w_hats.length);
        for (uint256 i = 0; i < sparseMatrices.length; i++) {
            sparseMatrices[i] = SparseMatrixU24(w_hats[i], v_rests[i]);
        }

        return PoseidonConstantsU24(m, psm_, sparseMatrices, round_constants, fullRounds, partialRounds);
    }

    struct HashInputs25 {
        uint256 t0;
        uint256 t1;
        uint256 t2;
        uint256 t3;
        uint256 t4;
        uint256 t5;
        uint256 t6;
        uint256 t7;
        uint256 t8;
        uint256 t9;
        uint256 t10;
        uint256 t11;
        uint256 t12;
        uint256 t13;
        uint256 t14;
        uint256 t15;
        uint256 t16;
        uint256 t17;
        uint256 t18;
        uint256 t19;
        uint256 t20;
        uint256 t21;
        uint256 t22;
        uint256 t23;
        uint256 t24;
    }

    function ark(HashInputs25 memory i, uint256 q, HashInputs25 memory c) internal pure {
        HashInputs25 memory o;

        o.t0 = addmod(i.t0, c.t0, q);
        o.t1 = addmod(i.t1, c.t1, q);
        o.t2 = addmod(i.t2, c.t2, q);
        o.t3 = addmod(i.t3, c.t3, q);
        o.t4 = addmod(i.t4, c.t4, q);
        o.t5 = addmod(i.t5, c.t5, q);
        o.t6 = addmod(i.t6, c.t6, q);
        o.t7 = addmod(i.t7, c.t7, q);
        o.t8 = addmod(i.t8, c.t8, q);
        o.t9 = addmod(i.t9, c.t9, q);
        o.t10 = addmod(i.t10, c.t10, q);
        o.t11 = addmod(i.t11, c.t11, q);
        o.t12 = addmod(i.t12, c.t12, q);
        o.t13 = addmod(i.t13, c.t13, q);
        o.t14 = addmod(i.t14, c.t14, q);
        o.t15 = addmod(i.t15, c.t15, q);
        o.t16 = addmod(i.t16, c.t16, q);
        o.t17 = addmod(i.t17, c.t17, q);
        o.t18 = addmod(i.t18, c.t18, q);
        o.t19 = addmod(i.t19, c.t19, q);
        o.t20 = addmod(i.t20, c.t20, q);
        o.t21 = addmod(i.t21, c.t21, q);
        o.t22 = addmod(i.t22, c.t22, q);
        o.t23 = addmod(i.t23, c.t23, q);
        o.t24 = addmod(i.t24, c.t24, q);

        i.t0 = o.t0;
        i.t1 = o.t1;
        i.t2 = o.t2;
        i.t3 = o.t3;
        i.t4 = o.t4;
        i.t5 = o.t5;
        i.t6 = o.t6;
        i.t7 = o.t7;
        i.t8 = o.t8;
        i.t9 = o.t9;
        i.t10 = o.t10;
        i.t11 = o.t11;
        i.t12 = o.t12;
        i.t13 = o.t13;
        i.t14 = o.t14;
        i.t15 = o.t15;
        i.t16 = o.t16;
        i.t17 = o.t17;
        i.t18 = o.t18;
        i.t19 = o.t19;
        i.t20 = o.t20;
        i.t21 = o.t21;
        i.t22 = o.t22;
        i.t23 = o.t23;
        i.t24 = o.t24;
    }

    function sbox_full(HashInputs25 memory i, uint256 q) internal pure {
        HashInputs25 memory o;

        o.t0 = mulmod(i.t0, i.t0, q);
        o.t0 = mulmod(o.t0, o.t0, q);
        o.t0 = mulmod(i.t0, o.t0, q);
        o.t1 = mulmod(i.t1, i.t1, q);
        o.t1 = mulmod(o.t1, o.t1, q);
        o.t1 = mulmod(i.t1, o.t1, q);
        o.t2 = mulmod(i.t2, i.t2, q);
        o.t2 = mulmod(o.t2, o.t2, q);
        o.t2 = mulmod(i.t2, o.t2, q);
        o.t3 = mulmod(i.t3, i.t3, q);
        o.t3 = mulmod(o.t3, o.t3, q);
        o.t3 = mulmod(i.t3, o.t3, q);
        o.t4 = mulmod(i.t4, i.t4, q);
        o.t4 = mulmod(o.t4, o.t4, q);
        o.t4 = mulmod(i.t4, o.t4, q);
        o.t5 = mulmod(i.t5, i.t5, q);
        o.t5 = mulmod(o.t5, o.t5, q);
        o.t5 = mulmod(i.t5, o.t5, q);
        o.t6 = mulmod(i.t6, i.t6, q);
        o.t6 = mulmod(o.t6, o.t6, q);
        o.t6 = mulmod(i.t6, o.t6, q);
        o.t7 = mulmod(i.t7, i.t7, q);
        o.t7 = mulmod(o.t7, o.t7, q);
        o.t7 = mulmod(i.t7, o.t7, q);
        o.t8 = mulmod(i.t8, i.t8, q);
        o.t8 = mulmod(o.t8, o.t8, q);
        o.t8 = mulmod(i.t8, o.t8, q);
        o.t9 = mulmod(i.t9, i.t9, q);
        o.t9 = mulmod(o.t9, o.t9, q);
        o.t9 = mulmod(i.t9, o.t9, q);
        o.t10 = mulmod(i.t10, i.t10, q);
        o.t10 = mulmod(o.t10, o.t10, q);
        o.t10 = mulmod(i.t10, o.t10, q);
        o.t11 = mulmod(i.t11, i.t11, q);
        o.t11 = mulmod(o.t11, o.t11, q);
        o.t11 = mulmod(i.t11, o.t11, q);
        o.t12 = mulmod(i.t12, i.t12, q);
        o.t12 = mulmod(o.t12, o.t12, q);
        o.t12 = mulmod(i.t12, o.t12, q);
        o.t13 = mulmod(i.t13, i.t13, q);
        o.t13 = mulmod(o.t13, o.t13, q);
        o.t13 = mulmod(i.t13, o.t13, q);
        o.t14 = mulmod(i.t14, i.t14, q);
        o.t14 = mulmod(o.t14, o.t14, q);
        o.t14 = mulmod(i.t14, o.t14, q);
        o.t15 = mulmod(i.t15, i.t15, q);
        o.t15 = mulmod(o.t15, o.t15, q);
        o.t15 = mulmod(i.t15, o.t15, q);
        o.t16 = mulmod(i.t16, i.t16, q);
        o.t16 = mulmod(o.t16, o.t16, q);
        o.t16 = mulmod(i.t16, o.t16, q);
        o.t17 = mulmod(i.t17, i.t17, q);
        o.t17 = mulmod(o.t17, o.t17, q);
        o.t17 = mulmod(i.t17, o.t17, q);
        o.t18 = mulmod(i.t18, i.t18, q);
        o.t18 = mulmod(o.t18, o.t18, q);
        o.t18 = mulmod(i.t18, o.t18, q);
        o.t19 = mulmod(i.t19, i.t19, q);
        o.t19 = mulmod(o.t19, o.t19, q);
        o.t19 = mulmod(i.t19, o.t19, q);
        o.t20 = mulmod(i.t20, i.t20, q);
        o.t20 = mulmod(o.t20, o.t20, q);
        o.t20 = mulmod(i.t20, o.t20, q);
        o.t21 = mulmod(i.t21, i.t21, q);
        o.t21 = mulmod(o.t21, o.t21, q);
        o.t21 = mulmod(i.t21, o.t21, q);
        o.t22 = mulmod(i.t22, i.t22, q);
        o.t22 = mulmod(o.t22, o.t22, q);
        o.t22 = mulmod(i.t22, o.t22, q);
        o.t23 = mulmod(i.t23, i.t23, q);
        o.t23 = mulmod(o.t23, o.t23, q);
        o.t23 = mulmod(i.t23, o.t23, q);
        o.t24 = mulmod(i.t24, i.t24, q);
        o.t24 = mulmod(o.t24, o.t24, q);
        o.t24 = mulmod(i.t24, o.t24, q);

        i.t0 = o.t0;
        i.t1 = o.t1;
        i.t2 = o.t2;
        i.t3 = o.t3;
        i.t4 = o.t4;
        i.t5 = o.t5;
        i.t6 = o.t6;
        i.t7 = o.t7;
        i.t8 = o.t8;
        i.t9 = o.t9;
        i.t10 = o.t10;
        i.t11 = o.t11;
        i.t12 = o.t12;
        i.t13 = o.t13;
        i.t14 = o.t14;
        i.t15 = o.t15;
        i.t16 = o.t16;
        i.t17 = o.t17;
        i.t18 = o.t18;
        i.t19 = o.t19;
        i.t20 = o.t20;
        i.t21 = o.t21;
        i.t22 = o.t22;
        i.t23 = o.t23;
        i.t24 = o.t24;
    }

    function mix_sparse(HashInputs25 memory i, SparseMatrixU24 memory sparseMatrix, uint256 q) internal pure {
        HashInputs25 memory o;
        uint256 tmp;

        tmp = mulmod(i.t0, sparseMatrix.w_hat[0], q);
        o.t0 = addmod(o.t0, tmp, q);

        tmp = mulmod(i.t1, sparseMatrix.w_hat[1], q);
        o.t0 = addmod(o.t0, tmp, q);

        tmp = mulmod(i.t2, sparseMatrix.w_hat[2], q);
        o.t0 = addmod(o.t0, tmp, q);

        tmp = mulmod(i.t3, sparseMatrix.w_hat[3], q);
        o.t0 = addmod(o.t0, tmp, q);

        tmp = mulmod(i.t4, sparseMatrix.w_hat[4], q);
        o.t0 = addmod(o.t0, tmp, q);

        tmp = mulmod(i.t5, sparseMatrix.w_hat[5], q);
        o.t0 = addmod(o.t0, tmp, q);

        tmp = mulmod(i.t6, sparseMatrix.w_hat[6], q);
        o.t0 = addmod(o.t0, tmp, q);

        tmp = mulmod(i.t7, sparseMatrix.w_hat[7], q);
        o.t0 = addmod(o.t0, tmp, q);

        tmp = mulmod(i.t8, sparseMatrix.w_hat[8], q);
        o.t0 = addmod(o.t0, tmp, q);

        tmp = mulmod(i.t9, sparseMatrix.w_hat[9], q);
        o.t0 = addmod(o.t0, tmp, q);

        tmp = mulmod(i.t10, sparseMatrix.w_hat[10], q);
        o.t0 = addmod(o.t0, tmp, q);

        tmp = mulmod(i.t11, sparseMatrix.w_hat[11], q);
        o.t0 = addmod(o.t0, tmp, q);

        tmp = mulmod(i.t12, sparseMatrix.w_hat[12], q);
        o.t0 = addmod(o.t0, tmp, q);

        tmp = mulmod(i.t13, sparseMatrix.w_hat[13], q);
        o.t0 = addmod(o.t0, tmp, q);

        tmp = mulmod(i.t14, sparseMatrix.w_hat[14], q);
        o.t0 = addmod(o.t0, tmp, q);

        tmp = mulmod(i.t15, sparseMatrix.w_hat[15], q);
        o.t0 = addmod(o.t0, tmp, q);

        tmp = mulmod(i.t16, sparseMatrix.w_hat[16], q);
        o.t0 = addmod(o.t0, tmp, q);

        tmp = mulmod(i.t17, sparseMatrix.w_hat[17], q);
        o.t0 = addmod(o.t0, tmp, q);

        tmp = mulmod(i.t18, sparseMatrix.w_hat[18], q);
        o.t0 = addmod(o.t0, tmp, q);

        tmp = mulmod(i.t19, sparseMatrix.w_hat[19], q);
        o.t0 = addmod(o.t0, tmp, q);

        tmp = mulmod(i.t20, sparseMatrix.w_hat[20], q);
        o.t0 = addmod(o.t0, tmp, q);

        tmp = mulmod(i.t21, sparseMatrix.w_hat[21], q);
        o.t0 = addmod(o.t0, tmp, q);

        tmp = mulmod(i.t22, sparseMatrix.w_hat[22], q);
        o.t0 = addmod(o.t0, tmp, q);

        tmp = mulmod(i.t23, sparseMatrix.w_hat[23], q);
        o.t0 = addmod(o.t0, tmp, q);

        tmp = mulmod(i.t24, sparseMatrix.w_hat[24], q);
        o.t0 = addmod(o.t0, tmp, q);

        uint256 val;
        val = i.t1;
        tmp = sparseMatrix.v_rest[0];
        tmp = mulmod(tmp, i.t0, q);
        o.t1 = addmod(val, tmp, q);

        val = i.t2;
        tmp = sparseMatrix.v_rest[1];
        tmp = mulmod(tmp, i.t0, q);
        o.t2 = addmod(val, tmp, q);

        val = i.t3;
        tmp = sparseMatrix.v_rest[2];
        tmp = mulmod(tmp, i.t0, q);
        o.t3 = addmod(val, tmp, q);

        val = i.t4;
        tmp = sparseMatrix.v_rest[3];
        tmp = mulmod(tmp, i.t0, q);
        o.t4 = addmod(val, tmp, q);

        val = i.t5;
        tmp = sparseMatrix.v_rest[4];
        tmp = mulmod(tmp, i.t0, q);
        o.t5 = addmod(val, tmp, q);

        val = i.t6;
        tmp = sparseMatrix.v_rest[5];
        tmp = mulmod(tmp, i.t0, q);
        o.t6 = addmod(val, tmp, q);

        val = i.t7;
        tmp = sparseMatrix.v_rest[6];
        tmp = mulmod(tmp, i.t0, q);
        o.t7 = addmod(val, tmp, q);

        val = i.t8;
        tmp = sparseMatrix.v_rest[7];
        tmp = mulmod(tmp, i.t0, q);
        o.t8 = addmod(val, tmp, q);

        val = i.t9;
        tmp = sparseMatrix.v_rest[8];
        tmp = mulmod(tmp, i.t0, q);
        o.t9 = addmod(val, tmp, q);

        val = i.t10;
        tmp = sparseMatrix.v_rest[9];
        tmp = mulmod(tmp, i.t0, q);
        o.t10 = addmod(val, tmp, q);

        val = i.t11;
        tmp = sparseMatrix.v_rest[10];
        tmp = mulmod(tmp, i.t0, q);
        o.t11 = addmod(val, tmp, q);

        val = i.t12;
        tmp = sparseMatrix.v_rest[11];
        tmp = mulmod(tmp, i.t0, q);
        o.t12 = addmod(val, tmp, q);

        val = i.t13;
        tmp = sparseMatrix.v_rest[12];
        tmp = mulmod(tmp, i.t0, q);
        o.t13 = addmod(val, tmp, q);

        val = i.t14;
        tmp = sparseMatrix.v_rest[13];
        tmp = mulmod(tmp, i.t0, q);
        o.t14 = addmod(val, tmp, q);

        val = i.t15;
        tmp = sparseMatrix.v_rest[14];
        tmp = mulmod(tmp, i.t0, q);
        o.t15 = addmod(val, tmp, q);

        val = i.t16;
        tmp = sparseMatrix.v_rest[15];
        tmp = mulmod(tmp, i.t0, q);
        o.t16 = addmod(val, tmp, q);

        val = i.t17;
        tmp = sparseMatrix.v_rest[16];
        tmp = mulmod(tmp, i.t0, q);
        o.t17 = addmod(val, tmp, q);

        val = i.t18;
        tmp = sparseMatrix.v_rest[17];
        tmp = mulmod(tmp, i.t0, q);
        o.t18 = addmod(val, tmp, q);

        val = i.t19;
        tmp = sparseMatrix.v_rest[18];
        tmp = mulmod(tmp, i.t0, q);
        o.t19 = addmod(val, tmp, q);

        val = i.t20;
        tmp = sparseMatrix.v_rest[19];
        tmp = mulmod(tmp, i.t0, q);
        o.t20 = addmod(val, tmp, q);

        val = i.t21;
        tmp = sparseMatrix.v_rest[20];
        tmp = mulmod(tmp, i.t0, q);
        o.t21 = addmod(val, tmp, q);

        val = i.t22;
        tmp = sparseMatrix.v_rest[21];
        tmp = mulmod(tmp, i.t0, q);
        o.t22 = addmod(val, tmp, q);

        val = i.t23;
        tmp = sparseMatrix.v_rest[22];
        tmp = mulmod(tmp, i.t0, q);
        o.t23 = addmod(val, tmp, q);

        val = i.t24;
        tmp = sparseMatrix.v_rest[23];
        tmp = mulmod(tmp, i.t0, q);
        o.t24 = addmod(val, tmp, q);

        i.t0 = o.t0;
        i.t1 = o.t1;
        i.t2 = o.t2;
        i.t3 = o.t3;
        i.t4 = o.t4;
        i.t5 = o.t5;
        i.t6 = o.t6;
        i.t7 = o.t7;
        i.t8 = o.t8;
        i.t9 = o.t9;
        i.t10 = o.t10;
        i.t11 = o.t11;
        i.t12 = o.t12;
        i.t13 = o.t13;
        i.t14 = o.t14;
        i.t15 = o.t15;
        i.t16 = o.t16;
        i.t17 = o.t17;
        i.t18 = o.t18;
        i.t19 = o.t19;
        i.t20 = o.t20;
        i.t21 = o.t21;
        i.t22 = o.t22;
        i.t23 = o.t23;
        i.t24 = o.t24;
    }

    function mix(HashInputs25 memory i, uint256[][] memory m, uint256 q) internal pure {
        HashInputs25 memory o;

        o.t0 = 0;
        o.t0 = addmod(o.t0, mulmod(i.t0, m[0][0], q), q);
        o.t0 = addmod(o.t0, mulmod(i.t1, m[0][1], q), q);
        o.t0 = addmod(o.t0, mulmod(i.t2, m[0][2], q), q);
        o.t0 = addmod(o.t0, mulmod(i.t3, m[0][3], q), q);
        o.t0 = addmod(o.t0, mulmod(i.t4, m[0][4], q), q);
        o.t0 = addmod(o.t0, mulmod(i.t5, m[0][5], q), q);
        o.t0 = addmod(o.t0, mulmod(i.t6, m[0][6], q), q);
        o.t0 = addmod(o.t0, mulmod(i.t7, m[0][7], q), q);
        o.t0 = addmod(o.t0, mulmod(i.t8, m[0][8], q), q);
        o.t0 = addmod(o.t0, mulmod(i.t9, m[0][9], q), q);
        o.t0 = addmod(o.t0, mulmod(i.t10, m[0][10], q), q);
        o.t0 = addmod(o.t0, mulmod(i.t11, m[0][11], q), q);
        o.t0 = addmod(o.t0, mulmod(i.t12, m[0][12], q), q);
        o.t0 = addmod(o.t0, mulmod(i.t13, m[0][13], q), q);
        o.t0 = addmod(o.t0, mulmod(i.t14, m[0][14], q), q);
        o.t0 = addmod(o.t0, mulmod(i.t15, m[0][15], q), q);
        o.t0 = addmod(o.t0, mulmod(i.t16, m[0][16], q), q);
        o.t0 = addmod(o.t0, mulmod(i.t17, m[0][17], q), q);
        o.t0 = addmod(o.t0, mulmod(i.t18, m[0][18], q), q);
        o.t0 = addmod(o.t0, mulmod(i.t19, m[0][19], q), q);
        o.t0 = addmod(o.t0, mulmod(i.t20, m[0][20], q), q);
        o.t0 = addmod(o.t0, mulmod(i.t21, m[0][21], q), q);
        o.t0 = addmod(o.t0, mulmod(i.t22, m[0][22], q), q);
        o.t0 = addmod(o.t0, mulmod(i.t23, m[0][23], q), q);
        o.t0 = addmod(o.t0, mulmod(i.t24, m[0][24], q), q);

        o.t1 = 0;
        o.t1 = addmod(o.t1, mulmod(i.t0, m[1][0], q), q);
        o.t1 = addmod(o.t1, mulmod(i.t1, m[1][1], q), q);
        o.t1 = addmod(o.t1, mulmod(i.t2, m[1][2], q), q);
        o.t1 = addmod(o.t1, mulmod(i.t3, m[1][3], q), q);
        o.t1 = addmod(o.t1, mulmod(i.t4, m[1][4], q), q);
        o.t1 = addmod(o.t1, mulmod(i.t5, m[1][5], q), q);
        o.t1 = addmod(o.t1, mulmod(i.t6, m[1][6], q), q);
        o.t1 = addmod(o.t1, mulmod(i.t7, m[1][7], q), q);
        o.t1 = addmod(o.t1, mulmod(i.t8, m[1][8], q), q);
        o.t1 = addmod(o.t1, mulmod(i.t9, m[1][9], q), q);
        o.t1 = addmod(o.t1, mulmod(i.t10, m[1][10], q), q);
        o.t1 = addmod(o.t1, mulmod(i.t11, m[1][11], q), q);
        o.t1 = addmod(o.t1, mulmod(i.t12, m[1][12], q), q);
        o.t1 = addmod(o.t1, mulmod(i.t13, m[1][13], q), q);
        o.t1 = addmod(o.t1, mulmod(i.t14, m[1][14], q), q);
        o.t1 = addmod(o.t1, mulmod(i.t15, m[1][15], q), q);
        o.t1 = addmod(o.t1, mulmod(i.t16, m[1][16], q), q);
        o.t1 = addmod(o.t1, mulmod(i.t17, m[1][17], q), q);
        o.t1 = addmod(o.t1, mulmod(i.t18, m[1][18], q), q);
        o.t1 = addmod(o.t1, mulmod(i.t19, m[1][19], q), q);
        o.t1 = addmod(o.t1, mulmod(i.t20, m[1][20], q), q);
        o.t1 = addmod(o.t1, mulmod(i.t21, m[1][21], q), q);
        o.t1 = addmod(o.t1, mulmod(i.t22, m[1][22], q), q);
        o.t1 = addmod(o.t1, mulmod(i.t23, m[1][23], q), q);
        o.t1 = addmod(o.t1, mulmod(i.t24, m[1][24], q), q);

        o.t2 = 0;
        o.t2 = addmod(o.t2, mulmod(i.t0, m[2][0], q), q);
        o.t2 = addmod(o.t2, mulmod(i.t1, m[2][1], q), q);
        o.t2 = addmod(o.t2, mulmod(i.t2, m[2][2], q), q);
        o.t2 = addmod(o.t2, mulmod(i.t3, m[2][3], q), q);
        o.t2 = addmod(o.t2, mulmod(i.t4, m[2][4], q), q);
        o.t2 = addmod(o.t2, mulmod(i.t5, m[2][5], q), q);
        o.t2 = addmod(o.t2, mulmod(i.t6, m[2][6], q), q);
        o.t2 = addmod(o.t2, mulmod(i.t7, m[2][7], q), q);
        o.t2 = addmod(o.t2, mulmod(i.t8, m[2][8], q), q);
        o.t2 = addmod(o.t2, mulmod(i.t9, m[2][9], q), q);
        o.t2 = addmod(o.t2, mulmod(i.t10, m[2][10], q), q);
        o.t2 = addmod(o.t2, mulmod(i.t11, m[2][11], q), q);
        o.t2 = addmod(o.t2, mulmod(i.t12, m[2][12], q), q);
        o.t2 = addmod(o.t2, mulmod(i.t13, m[2][13], q), q);
        o.t2 = addmod(o.t2, mulmod(i.t14, m[2][14], q), q);
        o.t2 = addmod(o.t2, mulmod(i.t15, m[2][15], q), q);
        o.t2 = addmod(o.t2, mulmod(i.t16, m[2][16], q), q);
        o.t2 = addmod(o.t2, mulmod(i.t17, m[2][17], q), q);
        o.t2 = addmod(o.t2, mulmod(i.t18, m[2][18], q), q);
        o.t2 = addmod(o.t2, mulmod(i.t19, m[2][19], q), q);
        o.t2 = addmod(o.t2, mulmod(i.t20, m[2][20], q), q);
        o.t2 = addmod(o.t2, mulmod(i.t21, m[2][21], q), q);
        o.t2 = addmod(o.t2, mulmod(i.t22, m[2][22], q), q);
        o.t2 = addmod(o.t2, mulmod(i.t23, m[2][23], q), q);
        o.t2 = addmod(o.t2, mulmod(i.t24, m[2][24], q), q);

        o.t3 = 0;
        o.t3 = addmod(o.t3, mulmod(i.t0, m[3][0], q), q);
        o.t3 = addmod(o.t3, mulmod(i.t1, m[3][1], q), q);
        o.t3 = addmod(o.t3, mulmod(i.t2, m[3][2], q), q);
        o.t3 = addmod(o.t3, mulmod(i.t3, m[3][3], q), q);
        o.t3 = addmod(o.t3, mulmod(i.t4, m[3][4], q), q);
        o.t3 = addmod(o.t3, mulmod(i.t5, m[3][5], q), q);
        o.t3 = addmod(o.t3, mulmod(i.t6, m[3][6], q), q);
        o.t3 = addmod(o.t3, mulmod(i.t7, m[3][7], q), q);
        o.t3 = addmod(o.t3, mulmod(i.t8, m[3][8], q), q);
        o.t3 = addmod(o.t3, mulmod(i.t9, m[3][9], q), q);
        o.t3 = addmod(o.t3, mulmod(i.t10, m[3][10], q), q);
        o.t3 = addmod(o.t3, mulmod(i.t11, m[3][11], q), q);
        o.t3 = addmod(o.t3, mulmod(i.t12, m[3][12], q), q);
        o.t3 = addmod(o.t3, mulmod(i.t13, m[3][13], q), q);
        o.t3 = addmod(o.t3, mulmod(i.t14, m[3][14], q), q);
        o.t3 = addmod(o.t3, mulmod(i.t15, m[3][15], q), q);
        o.t3 = addmod(o.t3, mulmod(i.t16, m[3][16], q), q);
        o.t3 = addmod(o.t3, mulmod(i.t17, m[3][17], q), q);
        o.t3 = addmod(o.t3, mulmod(i.t18, m[3][18], q), q);
        o.t3 = addmod(o.t3, mulmod(i.t19, m[3][19], q), q);
        o.t3 = addmod(o.t3, mulmod(i.t20, m[3][20], q), q);
        o.t3 = addmod(o.t3, mulmod(i.t21, m[3][21], q), q);
        o.t3 = addmod(o.t3, mulmod(i.t22, m[3][22], q), q);
        o.t3 = addmod(o.t3, mulmod(i.t23, m[3][23], q), q);
        o.t3 = addmod(o.t3, mulmod(i.t24, m[3][24], q), q);

        o.t4 = 0;
        o.t4 = addmod(o.t4, mulmod(i.t0, m[4][0], q), q);
        o.t4 = addmod(o.t4, mulmod(i.t1, m[4][1], q), q);
        o.t4 = addmod(o.t4, mulmod(i.t2, m[4][2], q), q);
        o.t4 = addmod(o.t4, mulmod(i.t3, m[4][3], q), q);
        o.t4 = addmod(o.t4, mulmod(i.t4, m[4][4], q), q);
        o.t4 = addmod(o.t4, mulmod(i.t5, m[4][5], q), q);
        o.t4 = addmod(o.t4, mulmod(i.t6, m[4][6], q), q);
        o.t4 = addmod(o.t4, mulmod(i.t7, m[4][7], q), q);
        o.t4 = addmod(o.t4, mulmod(i.t8, m[4][8], q), q);
        o.t4 = addmod(o.t4, mulmod(i.t9, m[4][9], q), q);
        o.t4 = addmod(o.t4, mulmod(i.t10, m[4][10], q), q);
        o.t4 = addmod(o.t4, mulmod(i.t11, m[4][11], q), q);
        o.t4 = addmod(o.t4, mulmod(i.t12, m[4][12], q), q);
        o.t4 = addmod(o.t4, mulmod(i.t13, m[4][13], q), q);
        o.t4 = addmod(o.t4, mulmod(i.t14, m[4][14], q), q);
        o.t4 = addmod(o.t4, mulmod(i.t15, m[4][15], q), q);
        o.t4 = addmod(o.t4, mulmod(i.t16, m[4][16], q), q);
        o.t4 = addmod(o.t4, mulmod(i.t17, m[4][17], q), q);
        o.t4 = addmod(o.t4, mulmod(i.t18, m[4][18], q), q);
        o.t4 = addmod(o.t4, mulmod(i.t19, m[4][19], q), q);
        o.t4 = addmod(o.t4, mulmod(i.t20, m[4][20], q), q);
        o.t4 = addmod(o.t4, mulmod(i.t21, m[4][21], q), q);
        o.t4 = addmod(o.t4, mulmod(i.t22, m[4][22], q), q);
        o.t4 = addmod(o.t4, mulmod(i.t23, m[4][23], q), q);
        o.t4 = addmod(o.t4, mulmod(i.t24, m[4][24], q), q);

        o.t5 = 0;
        o.t5 = addmod(o.t5, mulmod(i.t0, m[5][0], q), q);
        o.t5 = addmod(o.t5, mulmod(i.t1, m[5][1], q), q);
        o.t5 = addmod(o.t5, mulmod(i.t2, m[5][2], q), q);
        o.t5 = addmod(o.t5, mulmod(i.t3, m[5][3], q), q);
        o.t5 = addmod(o.t5, mulmod(i.t4, m[5][4], q), q);
        o.t5 = addmod(o.t5, mulmod(i.t5, m[5][5], q), q);
        o.t5 = addmod(o.t5, mulmod(i.t6, m[5][6], q), q);
        o.t5 = addmod(o.t5, mulmod(i.t7, m[5][7], q), q);
        o.t5 = addmod(o.t5, mulmod(i.t8, m[5][8], q), q);
        o.t5 = addmod(o.t5, mulmod(i.t9, m[5][9], q), q);
        o.t5 = addmod(o.t5, mulmod(i.t10, m[5][10], q), q);
        o.t5 = addmod(o.t5, mulmod(i.t11, m[5][11], q), q);
        o.t5 = addmod(o.t5, mulmod(i.t12, m[5][12], q), q);
        o.t5 = addmod(o.t5, mulmod(i.t13, m[5][13], q), q);
        o.t5 = addmod(o.t5, mulmod(i.t14, m[5][14], q), q);
        o.t5 = addmod(o.t5, mulmod(i.t15, m[5][15], q), q);
        o.t5 = addmod(o.t5, mulmod(i.t16, m[5][16], q), q);
        o.t5 = addmod(o.t5, mulmod(i.t17, m[5][17], q), q);
        o.t5 = addmod(o.t5, mulmod(i.t18, m[5][18], q), q);
        o.t5 = addmod(o.t5, mulmod(i.t19, m[5][19], q), q);
        o.t5 = addmod(o.t5, mulmod(i.t20, m[5][20], q), q);
        o.t5 = addmod(o.t5, mulmod(i.t21, m[5][21], q), q);
        o.t5 = addmod(o.t5, mulmod(i.t22, m[5][22], q), q);
        o.t5 = addmod(o.t5, mulmod(i.t23, m[5][23], q), q);
        o.t5 = addmod(o.t5, mulmod(i.t24, m[5][24], q), q);

        o.t6 = 0;
        o.t6 = addmod(o.t6, mulmod(i.t0, m[6][0], q), q);
        o.t6 = addmod(o.t6, mulmod(i.t1, m[6][1], q), q);
        o.t6 = addmod(o.t6, mulmod(i.t2, m[6][2], q), q);
        o.t6 = addmod(o.t6, mulmod(i.t3, m[6][3], q), q);
        o.t6 = addmod(o.t6, mulmod(i.t4, m[6][4], q), q);
        o.t6 = addmod(o.t6, mulmod(i.t5, m[6][5], q), q);
        o.t6 = addmod(o.t6, mulmod(i.t6, m[6][6], q), q);
        o.t6 = addmod(o.t6, mulmod(i.t7, m[6][7], q), q);
        o.t6 = addmod(o.t6, mulmod(i.t8, m[6][8], q), q);
        o.t6 = addmod(o.t6, mulmod(i.t9, m[6][9], q), q);
        o.t6 = addmod(o.t6, mulmod(i.t10, m[6][10], q), q);
        o.t6 = addmod(o.t6, mulmod(i.t11, m[6][11], q), q);
        o.t6 = addmod(o.t6, mulmod(i.t12, m[6][12], q), q);
        o.t6 = addmod(o.t6, mulmod(i.t13, m[6][13], q), q);
        o.t6 = addmod(o.t6, mulmod(i.t14, m[6][14], q), q);
        o.t6 = addmod(o.t6, mulmod(i.t15, m[6][15], q), q);
        o.t6 = addmod(o.t6, mulmod(i.t16, m[6][16], q), q);
        o.t6 = addmod(o.t6, mulmod(i.t17, m[6][17], q), q);
        o.t6 = addmod(o.t6, mulmod(i.t18, m[6][18], q), q);
        o.t6 = addmod(o.t6, mulmod(i.t19, m[6][19], q), q);
        o.t6 = addmod(o.t6, mulmod(i.t20, m[6][20], q), q);
        o.t6 = addmod(o.t6, mulmod(i.t21, m[6][21], q), q);
        o.t6 = addmod(o.t6, mulmod(i.t22, m[6][22], q), q);
        o.t6 = addmod(o.t6, mulmod(i.t23, m[6][23], q), q);
        o.t6 = addmod(o.t6, mulmod(i.t24, m[6][24], q), q);

        o.t7 = 0;
        o.t7 = addmod(o.t7, mulmod(i.t0, m[7][0], q), q);
        o.t7 = addmod(o.t7, mulmod(i.t1, m[7][1], q), q);
        o.t7 = addmod(o.t7, mulmod(i.t2, m[7][2], q), q);
        o.t7 = addmod(o.t7, mulmod(i.t3, m[7][3], q), q);
        o.t7 = addmod(o.t7, mulmod(i.t4, m[7][4], q), q);
        o.t7 = addmod(o.t7, mulmod(i.t5, m[7][5], q), q);
        o.t7 = addmod(o.t7, mulmod(i.t6, m[7][6], q), q);
        o.t7 = addmod(o.t7, mulmod(i.t7, m[7][7], q), q);
        o.t7 = addmod(o.t7, mulmod(i.t8, m[7][8], q), q);
        o.t7 = addmod(o.t7, mulmod(i.t9, m[7][9], q), q);
        o.t7 = addmod(o.t7, mulmod(i.t10, m[7][10], q), q);
        o.t7 = addmod(o.t7, mulmod(i.t11, m[7][11], q), q);
        o.t7 = addmod(o.t7, mulmod(i.t12, m[7][12], q), q);
        o.t7 = addmod(o.t7, mulmod(i.t13, m[7][13], q), q);
        o.t7 = addmod(o.t7, mulmod(i.t14, m[7][14], q), q);
        o.t7 = addmod(o.t7, mulmod(i.t15, m[7][15], q), q);
        o.t7 = addmod(o.t7, mulmod(i.t16, m[7][16], q), q);
        o.t7 = addmod(o.t7, mulmod(i.t17, m[7][17], q), q);
        o.t7 = addmod(o.t7, mulmod(i.t18, m[7][18], q), q);
        o.t7 = addmod(o.t7, mulmod(i.t19, m[7][19], q), q);
        o.t7 = addmod(o.t7, mulmod(i.t20, m[7][20], q), q);
        o.t7 = addmod(o.t7, mulmod(i.t21, m[7][21], q), q);
        o.t7 = addmod(o.t7, mulmod(i.t22, m[7][22], q), q);
        o.t7 = addmod(o.t7, mulmod(i.t23, m[7][23], q), q);
        o.t7 = addmod(o.t7, mulmod(i.t24, m[7][24], q), q);

        o.t8 = 0;
        o.t8 = addmod(o.t8, mulmod(i.t0, m[8][0], q), q);
        o.t8 = addmod(o.t8, mulmod(i.t1, m[8][1], q), q);
        o.t8 = addmod(o.t8, mulmod(i.t2, m[8][2], q), q);
        o.t8 = addmod(o.t8, mulmod(i.t3, m[8][3], q), q);
        o.t8 = addmod(o.t8, mulmod(i.t4, m[8][4], q), q);
        o.t8 = addmod(o.t8, mulmod(i.t5, m[8][5], q), q);
        o.t8 = addmod(o.t8, mulmod(i.t6, m[8][6], q), q);
        o.t8 = addmod(o.t8, mulmod(i.t7, m[8][7], q), q);
        o.t8 = addmod(o.t8, mulmod(i.t8, m[8][8], q), q);
        o.t8 = addmod(o.t8, mulmod(i.t9, m[8][9], q), q);
        o.t8 = addmod(o.t8, mulmod(i.t10, m[8][10], q), q);
        o.t8 = addmod(o.t8, mulmod(i.t11, m[8][11], q), q);
        o.t8 = addmod(o.t8, mulmod(i.t12, m[8][12], q), q);
        o.t8 = addmod(o.t8, mulmod(i.t13, m[8][13], q), q);
        o.t8 = addmod(o.t8, mulmod(i.t14, m[8][14], q), q);
        o.t8 = addmod(o.t8, mulmod(i.t15, m[8][15], q), q);
        o.t8 = addmod(o.t8, mulmod(i.t16, m[8][16], q), q);
        o.t8 = addmod(o.t8, mulmod(i.t17, m[8][17], q), q);
        o.t8 = addmod(o.t8, mulmod(i.t18, m[8][18], q), q);
        o.t8 = addmod(o.t8, mulmod(i.t19, m[8][19], q), q);
        o.t8 = addmod(o.t8, mulmod(i.t20, m[8][20], q), q);
        o.t8 = addmod(o.t8, mulmod(i.t21, m[8][21], q), q);
        o.t8 = addmod(o.t8, mulmod(i.t22, m[8][22], q), q);
        o.t8 = addmod(o.t8, mulmod(i.t23, m[8][23], q), q);
        o.t8 = addmod(o.t8, mulmod(i.t24, m[8][24], q), q);

        o.t9 = 0;
        o.t9 = addmod(o.t9, mulmod(i.t0, m[9][0], q), q);
        o.t9 = addmod(o.t9, mulmod(i.t1, m[9][1], q), q);
        o.t9 = addmod(o.t9, mulmod(i.t2, m[9][2], q), q);
        o.t9 = addmod(o.t9, mulmod(i.t3, m[9][3], q), q);
        o.t9 = addmod(o.t9, mulmod(i.t4, m[9][4], q), q);
        o.t9 = addmod(o.t9, mulmod(i.t5, m[9][5], q), q);
        o.t9 = addmod(o.t9, mulmod(i.t6, m[9][6], q), q);
        o.t9 = addmod(o.t9, mulmod(i.t7, m[9][7], q), q);
        o.t9 = addmod(o.t9, mulmod(i.t8, m[9][8], q), q);
        o.t9 = addmod(o.t9, mulmod(i.t9, m[9][9], q), q);
        o.t9 = addmod(o.t9, mulmod(i.t10, m[9][10], q), q);
        o.t9 = addmod(o.t9, mulmod(i.t11, m[9][11], q), q);
        o.t9 = addmod(o.t9, mulmod(i.t12, m[9][12], q), q);
        o.t9 = addmod(o.t9, mulmod(i.t13, m[9][13], q), q);
        o.t9 = addmod(o.t9, mulmod(i.t14, m[9][14], q), q);
        o.t9 = addmod(o.t9, mulmod(i.t15, m[9][15], q), q);
        o.t9 = addmod(o.t9, mulmod(i.t16, m[9][16], q), q);
        o.t9 = addmod(o.t9, mulmod(i.t17, m[9][17], q), q);
        o.t9 = addmod(o.t9, mulmod(i.t18, m[9][18], q), q);
        o.t9 = addmod(o.t9, mulmod(i.t19, m[9][19], q), q);
        o.t9 = addmod(o.t9, mulmod(i.t20, m[9][20], q), q);
        o.t9 = addmod(o.t9, mulmod(i.t21, m[9][21], q), q);
        o.t9 = addmod(o.t9, mulmod(i.t22, m[9][22], q), q);
        o.t9 = addmod(o.t9, mulmod(i.t23, m[9][23], q), q);
        o.t9 = addmod(o.t9, mulmod(i.t24, m[9][24], q), q);

        o.t10 = 0;
        o.t10 = addmod(o.t10, mulmod(i.t0, m[10][0], q), q);
        o.t10 = addmod(o.t10, mulmod(i.t1, m[10][1], q), q);
        o.t10 = addmod(o.t10, mulmod(i.t2, m[10][2], q), q);
        o.t10 = addmod(o.t10, mulmod(i.t3, m[10][3], q), q);
        o.t10 = addmod(o.t10, mulmod(i.t4, m[10][4], q), q);
        o.t10 = addmod(o.t10, mulmod(i.t5, m[10][5], q), q);
        o.t10 = addmod(o.t10, mulmod(i.t6, m[10][6], q), q);
        o.t10 = addmod(o.t10, mulmod(i.t7, m[10][7], q), q);
        o.t10 = addmod(o.t10, mulmod(i.t8, m[10][8], q), q);
        o.t10 = addmod(o.t10, mulmod(i.t9, m[10][9], q), q);
        o.t10 = addmod(o.t10, mulmod(i.t10, m[10][10], q), q);
        o.t10 = addmod(o.t10, mulmod(i.t11, m[10][11], q), q);
        o.t10 = addmod(o.t10, mulmod(i.t12, m[10][12], q), q);
        o.t10 = addmod(o.t10, mulmod(i.t13, m[10][13], q), q);
        o.t10 = addmod(o.t10, mulmod(i.t14, m[10][14], q), q);
        o.t10 = addmod(o.t10, mulmod(i.t15, m[10][15], q), q);
        o.t10 = addmod(o.t10, mulmod(i.t16, m[10][16], q), q);
        o.t10 = addmod(o.t10, mulmod(i.t17, m[10][17], q), q);
        o.t10 = addmod(o.t10, mulmod(i.t18, m[10][18], q), q);
        o.t10 = addmod(o.t10, mulmod(i.t19, m[10][19], q), q);
        o.t10 = addmod(o.t10, mulmod(i.t20, m[10][20], q), q);
        o.t10 = addmod(o.t10, mulmod(i.t21, m[10][21], q), q);
        o.t10 = addmod(o.t10, mulmod(i.t22, m[10][22], q), q);
        o.t10 = addmod(o.t10, mulmod(i.t23, m[10][23], q), q);
        o.t10 = addmod(o.t10, mulmod(i.t24, m[10][24], q), q);

        o.t11 = 0;
        o.t11 = addmod(o.t11, mulmod(i.t0, m[11][0], q), q);
        o.t11 = addmod(o.t11, mulmod(i.t1, m[11][1], q), q);
        o.t11 = addmod(o.t11, mulmod(i.t2, m[11][2], q), q);
        o.t11 = addmod(o.t11, mulmod(i.t3, m[11][3], q), q);
        o.t11 = addmod(o.t11, mulmod(i.t4, m[11][4], q), q);
        o.t11 = addmod(o.t11, mulmod(i.t5, m[11][5], q), q);
        o.t11 = addmod(o.t11, mulmod(i.t6, m[11][6], q), q);
        o.t11 = addmod(o.t11, mulmod(i.t7, m[11][7], q), q);
        o.t11 = addmod(o.t11, mulmod(i.t8, m[11][8], q), q);
        o.t11 = addmod(o.t11, mulmod(i.t9, m[11][9], q), q);
        o.t11 = addmod(o.t11, mulmod(i.t10, m[11][10], q), q);
        o.t11 = addmod(o.t11, mulmod(i.t11, m[11][11], q), q);
        o.t11 = addmod(o.t11, mulmod(i.t12, m[11][12], q), q);
        o.t11 = addmod(o.t11, mulmod(i.t13, m[11][13], q), q);
        o.t11 = addmod(o.t11, mulmod(i.t14, m[11][14], q), q);
        o.t11 = addmod(o.t11, mulmod(i.t15, m[11][15], q), q);
        o.t11 = addmod(o.t11, mulmod(i.t16, m[11][16], q), q);
        o.t11 = addmod(o.t11, mulmod(i.t17, m[11][17], q), q);
        o.t11 = addmod(o.t11, mulmod(i.t18, m[11][18], q), q);
        o.t11 = addmod(o.t11, mulmod(i.t19, m[11][19], q), q);
        o.t11 = addmod(o.t11, mulmod(i.t20, m[11][20], q), q);
        o.t11 = addmod(o.t11, mulmod(i.t21, m[11][21], q), q);
        o.t11 = addmod(o.t11, mulmod(i.t22, m[11][22], q), q);
        o.t11 = addmod(o.t11, mulmod(i.t23, m[11][23], q), q);
        o.t11 = addmod(o.t11, mulmod(i.t24, m[11][24], q), q);

        o.t12 = 0;
        o.t12 = addmod(o.t12, mulmod(i.t0, m[12][0], q), q);
        o.t12 = addmod(o.t12, mulmod(i.t1, m[12][1], q), q);
        o.t12 = addmod(o.t12, mulmod(i.t2, m[12][2], q), q);
        o.t12 = addmod(o.t12, mulmod(i.t3, m[12][3], q), q);
        o.t12 = addmod(o.t12, mulmod(i.t4, m[12][4], q), q);
        o.t12 = addmod(o.t12, mulmod(i.t5, m[12][5], q), q);
        o.t12 = addmod(o.t12, mulmod(i.t6, m[12][6], q), q);
        o.t12 = addmod(o.t12, mulmod(i.t7, m[12][7], q), q);
        o.t12 = addmod(o.t12, mulmod(i.t8, m[12][8], q), q);
        o.t12 = addmod(o.t12, mulmod(i.t9, m[12][9], q), q);
        o.t12 = addmod(o.t12, mulmod(i.t10, m[12][10], q), q);
        o.t12 = addmod(o.t12, mulmod(i.t11, m[12][11], q), q);
        o.t12 = addmod(o.t12, mulmod(i.t12, m[12][12], q), q);
        o.t12 = addmod(o.t12, mulmod(i.t13, m[12][13], q), q);
        o.t12 = addmod(o.t12, mulmod(i.t14, m[12][14], q), q);
        o.t12 = addmod(o.t12, mulmod(i.t15, m[12][15], q), q);
        o.t12 = addmod(o.t12, mulmod(i.t16, m[12][16], q), q);
        o.t12 = addmod(o.t12, mulmod(i.t17, m[12][17], q), q);
        o.t12 = addmod(o.t12, mulmod(i.t18, m[12][18], q), q);
        o.t12 = addmod(o.t12, mulmod(i.t19, m[12][19], q), q);
        o.t12 = addmod(o.t12, mulmod(i.t20, m[12][20], q), q);
        o.t12 = addmod(o.t12, mulmod(i.t21, m[12][21], q), q);
        o.t12 = addmod(o.t12, mulmod(i.t22, m[12][22], q), q);
        o.t12 = addmod(o.t12, mulmod(i.t23, m[12][23], q), q);
        o.t12 = addmod(o.t12, mulmod(i.t24, m[12][24], q), q);

        o.t13 = 0;
        o.t13 = addmod(o.t13, mulmod(i.t0, m[13][0], q), q);
        o.t13 = addmod(o.t13, mulmod(i.t1, m[13][1], q), q);
        o.t13 = addmod(o.t13, mulmod(i.t2, m[13][2], q), q);
        o.t13 = addmod(o.t13, mulmod(i.t3, m[13][3], q), q);
        o.t13 = addmod(o.t13, mulmod(i.t4, m[13][4], q), q);
        o.t13 = addmod(o.t13, mulmod(i.t5, m[13][5], q), q);
        o.t13 = addmod(o.t13, mulmod(i.t6, m[13][6], q), q);
        o.t13 = addmod(o.t13, mulmod(i.t7, m[13][7], q), q);
        o.t13 = addmod(o.t13, mulmod(i.t8, m[13][8], q), q);
        o.t13 = addmod(o.t13, mulmod(i.t9, m[13][9], q), q);
        o.t13 = addmod(o.t13, mulmod(i.t10, m[13][10], q), q);
        o.t13 = addmod(o.t13, mulmod(i.t11, m[13][11], q), q);
        o.t13 = addmod(o.t13, mulmod(i.t12, m[13][12], q), q);
        o.t13 = addmod(o.t13, mulmod(i.t13, m[13][13], q), q);
        o.t13 = addmod(o.t13, mulmod(i.t14, m[13][14], q), q);
        o.t13 = addmod(o.t13, mulmod(i.t15, m[13][15], q), q);
        o.t13 = addmod(o.t13, mulmod(i.t16, m[13][16], q), q);
        o.t13 = addmod(o.t13, mulmod(i.t17, m[13][17], q), q);
        o.t13 = addmod(o.t13, mulmod(i.t18, m[13][18], q), q);
        o.t13 = addmod(o.t13, mulmod(i.t19, m[13][19], q), q);
        o.t13 = addmod(o.t13, mulmod(i.t20, m[13][20], q), q);
        o.t13 = addmod(o.t13, mulmod(i.t21, m[13][21], q), q);
        o.t13 = addmod(o.t13, mulmod(i.t22, m[13][22], q), q);
        o.t13 = addmod(o.t13, mulmod(i.t23, m[13][23], q), q);
        o.t13 = addmod(o.t13, mulmod(i.t24, m[13][24], q), q);

        o.t14 = 0;
        o.t14 = addmod(o.t14, mulmod(i.t0, m[14][0], q), q);
        o.t14 = addmod(o.t14, mulmod(i.t1, m[14][1], q), q);
        o.t14 = addmod(o.t14, mulmod(i.t2, m[14][2], q), q);
        o.t14 = addmod(o.t14, mulmod(i.t3, m[14][3], q), q);
        o.t14 = addmod(o.t14, mulmod(i.t4, m[14][4], q), q);
        o.t14 = addmod(o.t14, mulmod(i.t5, m[14][5], q), q);
        o.t14 = addmod(o.t14, mulmod(i.t6, m[14][6], q), q);
        o.t14 = addmod(o.t14, mulmod(i.t7, m[14][7], q), q);
        o.t14 = addmod(o.t14, mulmod(i.t8, m[14][8], q), q);
        o.t14 = addmod(o.t14, mulmod(i.t9, m[14][9], q), q);
        o.t14 = addmod(o.t14, mulmod(i.t10, m[14][10], q), q);
        o.t14 = addmod(o.t14, mulmod(i.t11, m[14][11], q), q);
        o.t14 = addmod(o.t14, mulmod(i.t12, m[14][12], q), q);
        o.t14 = addmod(o.t14, mulmod(i.t13, m[14][13], q), q);
        o.t14 = addmod(o.t14, mulmod(i.t14, m[14][14], q), q);
        o.t14 = addmod(o.t14, mulmod(i.t15, m[14][15], q), q);
        o.t14 = addmod(o.t14, mulmod(i.t16, m[14][16], q), q);
        o.t14 = addmod(o.t14, mulmod(i.t17, m[14][17], q), q);
        o.t14 = addmod(o.t14, mulmod(i.t18, m[14][18], q), q);
        o.t14 = addmod(o.t14, mulmod(i.t19, m[14][19], q), q);
        o.t14 = addmod(o.t14, mulmod(i.t20, m[14][20], q), q);
        o.t14 = addmod(o.t14, mulmod(i.t21, m[14][21], q), q);
        o.t14 = addmod(o.t14, mulmod(i.t22, m[14][22], q), q);
        o.t14 = addmod(o.t14, mulmod(i.t23, m[14][23], q), q);
        o.t14 = addmod(o.t14, mulmod(i.t24, m[14][24], q), q);

        o.t15 = 0;
        o.t15 = addmod(o.t15, mulmod(i.t0, m[15][0], q), q);
        o.t15 = addmod(o.t15, mulmod(i.t1, m[15][1], q), q);
        o.t15 = addmod(o.t15, mulmod(i.t2, m[15][2], q), q);
        o.t15 = addmod(o.t15, mulmod(i.t3, m[15][3], q), q);
        o.t15 = addmod(o.t15, mulmod(i.t4, m[15][4], q), q);
        o.t15 = addmod(o.t15, mulmod(i.t5, m[15][5], q), q);
        o.t15 = addmod(o.t15, mulmod(i.t6, m[15][6], q), q);
        o.t15 = addmod(o.t15, mulmod(i.t7, m[15][7], q), q);
        o.t15 = addmod(o.t15, mulmod(i.t8, m[15][8], q), q);
        o.t15 = addmod(o.t15, mulmod(i.t9, m[15][9], q), q);
        o.t15 = addmod(o.t15, mulmod(i.t10, m[15][10], q), q);
        o.t15 = addmod(o.t15, mulmod(i.t11, m[15][11], q), q);
        o.t15 = addmod(o.t15, mulmod(i.t12, m[15][12], q), q);
        o.t15 = addmod(o.t15, mulmod(i.t13, m[15][13], q), q);
        o.t15 = addmod(o.t15, mulmod(i.t14, m[15][14], q), q);
        o.t15 = addmod(o.t15, mulmod(i.t15, m[15][15], q), q);
        o.t15 = addmod(o.t15, mulmod(i.t16, m[15][16], q), q);
        o.t15 = addmod(o.t15, mulmod(i.t17, m[15][17], q), q);
        o.t15 = addmod(o.t15, mulmod(i.t18, m[15][18], q), q);
        o.t15 = addmod(o.t15, mulmod(i.t19, m[15][19], q), q);
        o.t15 = addmod(o.t15, mulmod(i.t20, m[15][20], q), q);
        o.t15 = addmod(o.t15, mulmod(i.t21, m[15][21], q), q);
        o.t15 = addmod(o.t15, mulmod(i.t22, m[15][22], q), q);
        o.t15 = addmod(o.t15, mulmod(i.t23, m[15][23], q), q);
        o.t15 = addmod(o.t15, mulmod(i.t24, m[15][24], q), q);

        o.t16 = 0;
        o.t16 = addmod(o.t16, mulmod(i.t0, m[16][0], q), q);
        o.t16 = addmod(o.t16, mulmod(i.t1, m[16][1], q), q);
        o.t16 = addmod(o.t16, mulmod(i.t2, m[16][2], q), q);
        o.t16 = addmod(o.t16, mulmod(i.t3, m[16][3], q), q);
        o.t16 = addmod(o.t16, mulmod(i.t4, m[16][4], q), q);
        o.t16 = addmod(o.t16, mulmod(i.t5, m[16][5], q), q);
        o.t16 = addmod(o.t16, mulmod(i.t6, m[16][6], q), q);
        o.t16 = addmod(o.t16, mulmod(i.t7, m[16][7], q), q);
        o.t16 = addmod(o.t16, mulmod(i.t8, m[16][8], q), q);
        o.t16 = addmod(o.t16, mulmod(i.t9, m[16][9], q), q);
        o.t16 = addmod(o.t16, mulmod(i.t10, m[16][10], q), q);
        o.t16 = addmod(o.t16, mulmod(i.t11, m[16][11], q), q);
        o.t16 = addmod(o.t16, mulmod(i.t12, m[16][12], q), q);
        o.t16 = addmod(o.t16, mulmod(i.t13, m[16][13], q), q);
        o.t16 = addmod(o.t16, mulmod(i.t14, m[16][14], q), q);
        o.t16 = addmod(o.t16, mulmod(i.t15, m[16][15], q), q);
        o.t16 = addmod(o.t16, mulmod(i.t16, m[16][16], q), q);
        o.t16 = addmod(o.t16, mulmod(i.t17, m[16][17], q), q);
        o.t16 = addmod(o.t16, mulmod(i.t18, m[16][18], q), q);
        o.t16 = addmod(o.t16, mulmod(i.t19, m[16][19], q), q);
        o.t16 = addmod(o.t16, mulmod(i.t20, m[16][20], q), q);
        o.t16 = addmod(o.t16, mulmod(i.t21, m[16][21], q), q);
        o.t16 = addmod(o.t16, mulmod(i.t22, m[16][22], q), q);
        o.t16 = addmod(o.t16, mulmod(i.t23, m[16][23], q), q);
        o.t16 = addmod(o.t16, mulmod(i.t24, m[16][24], q), q);

        o.t17 = 0;
        o.t17 = addmod(o.t17, mulmod(i.t0, m[17][0], q), q);
        o.t17 = addmod(o.t17, mulmod(i.t1, m[17][1], q), q);
        o.t17 = addmod(o.t17, mulmod(i.t2, m[17][2], q), q);
        o.t17 = addmod(o.t17, mulmod(i.t3, m[17][3], q), q);
        o.t17 = addmod(o.t17, mulmod(i.t4, m[17][4], q), q);
        o.t17 = addmod(o.t17, mulmod(i.t5, m[17][5], q), q);
        o.t17 = addmod(o.t17, mulmod(i.t6, m[17][6], q), q);
        o.t17 = addmod(o.t17, mulmod(i.t7, m[17][7], q), q);
        o.t17 = addmod(o.t17, mulmod(i.t8, m[17][8], q), q);
        o.t17 = addmod(o.t17, mulmod(i.t9, m[17][9], q), q);
        o.t17 = addmod(o.t17, mulmod(i.t10, m[17][10], q), q);
        o.t17 = addmod(o.t17, mulmod(i.t11, m[17][11], q), q);
        o.t17 = addmod(o.t17, mulmod(i.t12, m[17][12], q), q);
        o.t17 = addmod(o.t17, mulmod(i.t13, m[17][13], q), q);
        o.t17 = addmod(o.t17, mulmod(i.t14, m[17][14], q), q);
        o.t17 = addmod(o.t17, mulmod(i.t15, m[17][15], q), q);
        o.t17 = addmod(o.t17, mulmod(i.t16, m[17][16], q), q);
        o.t17 = addmod(o.t17, mulmod(i.t17, m[17][17], q), q);
        o.t17 = addmod(o.t17, mulmod(i.t18, m[17][18], q), q);
        o.t17 = addmod(o.t17, mulmod(i.t19, m[17][19], q), q);
        o.t17 = addmod(o.t17, mulmod(i.t20, m[17][20], q), q);
        o.t17 = addmod(o.t17, mulmod(i.t21, m[17][21], q), q);
        o.t17 = addmod(o.t17, mulmod(i.t22, m[17][22], q), q);
        o.t17 = addmod(o.t17, mulmod(i.t23, m[17][23], q), q);
        o.t17 = addmod(o.t17, mulmod(i.t24, m[17][24], q), q);

        o.t18 = 0;
        o.t18 = addmod(o.t18, mulmod(i.t0, m[18][0], q), q);
        o.t18 = addmod(o.t18, mulmod(i.t1, m[18][1], q), q);
        o.t18 = addmod(o.t18, mulmod(i.t2, m[18][2], q), q);
        o.t18 = addmod(o.t18, mulmod(i.t3, m[18][3], q), q);
        o.t18 = addmod(o.t18, mulmod(i.t4, m[18][4], q), q);
        o.t18 = addmod(o.t18, mulmod(i.t5, m[18][5], q), q);
        o.t18 = addmod(o.t18, mulmod(i.t6, m[18][6], q), q);
        o.t18 = addmod(o.t18, mulmod(i.t7, m[18][7], q), q);
        o.t18 = addmod(o.t18, mulmod(i.t8, m[18][8], q), q);
        o.t18 = addmod(o.t18, mulmod(i.t9, m[18][9], q), q);
        o.t18 = addmod(o.t18, mulmod(i.t10, m[18][10], q), q);
        o.t18 = addmod(o.t18, mulmod(i.t11, m[18][11], q), q);
        o.t18 = addmod(o.t18, mulmod(i.t12, m[18][12], q), q);
        o.t18 = addmod(o.t18, mulmod(i.t13, m[18][13], q), q);
        o.t18 = addmod(o.t18, mulmod(i.t14, m[18][14], q), q);
        o.t18 = addmod(o.t18, mulmod(i.t15, m[18][15], q), q);
        o.t18 = addmod(o.t18, mulmod(i.t16, m[18][16], q), q);
        o.t18 = addmod(o.t18, mulmod(i.t17, m[18][17], q), q);
        o.t18 = addmod(o.t18, mulmod(i.t18, m[18][18], q), q);
        o.t18 = addmod(o.t18, mulmod(i.t19, m[18][19], q), q);
        o.t18 = addmod(o.t18, mulmod(i.t20, m[18][20], q), q);
        o.t18 = addmod(o.t18, mulmod(i.t21, m[18][21], q), q);
        o.t18 = addmod(o.t18, mulmod(i.t22, m[18][22], q), q);
        o.t18 = addmod(o.t18, mulmod(i.t23, m[18][23], q), q);
        o.t18 = addmod(o.t18, mulmod(i.t24, m[18][24], q), q);

        o.t19 = 0;
        o.t19 = addmod(o.t19, mulmod(i.t0, m[19][0], q), q);
        o.t19 = addmod(o.t19, mulmod(i.t1, m[19][1], q), q);
        o.t19 = addmod(o.t19, mulmod(i.t2, m[19][2], q), q);
        o.t19 = addmod(o.t19, mulmod(i.t3, m[19][3], q), q);
        o.t19 = addmod(o.t19, mulmod(i.t4, m[19][4], q), q);
        o.t19 = addmod(o.t19, mulmod(i.t5, m[19][5], q), q);
        o.t19 = addmod(o.t19, mulmod(i.t6, m[19][6], q), q);
        o.t19 = addmod(o.t19, mulmod(i.t7, m[19][7], q), q);
        o.t19 = addmod(o.t19, mulmod(i.t8, m[19][8], q), q);
        o.t19 = addmod(o.t19, mulmod(i.t9, m[19][9], q), q);
        o.t19 = addmod(o.t19, mulmod(i.t10, m[19][10], q), q);
        o.t19 = addmod(o.t19, mulmod(i.t11, m[19][11], q), q);
        o.t19 = addmod(o.t19, mulmod(i.t12, m[19][12], q), q);
        o.t19 = addmod(o.t19, mulmod(i.t13, m[19][13], q), q);
        o.t19 = addmod(o.t19, mulmod(i.t14, m[19][14], q), q);
        o.t19 = addmod(o.t19, mulmod(i.t15, m[19][15], q), q);
        o.t19 = addmod(o.t19, mulmod(i.t16, m[19][16], q), q);
        o.t19 = addmod(o.t19, mulmod(i.t17, m[19][17], q), q);
        o.t19 = addmod(o.t19, mulmod(i.t18, m[19][18], q), q);
        o.t19 = addmod(o.t19, mulmod(i.t19, m[19][19], q), q);
        o.t19 = addmod(o.t19, mulmod(i.t20, m[19][20], q), q);
        o.t19 = addmod(o.t19, mulmod(i.t21, m[19][21], q), q);
        o.t19 = addmod(o.t19, mulmod(i.t22, m[19][22], q), q);
        o.t19 = addmod(o.t19, mulmod(i.t23, m[19][23], q), q);
        o.t19 = addmod(o.t19, mulmod(i.t24, m[19][24], q), q);

        o.t20 = 0;
        o.t20 = addmod(o.t20, mulmod(i.t0, m[20][0], q), q);
        o.t20 = addmod(o.t20, mulmod(i.t1, m[20][1], q), q);
        o.t20 = addmod(o.t20, mulmod(i.t2, m[20][2], q), q);
        o.t20 = addmod(o.t20, mulmod(i.t3, m[20][3], q), q);
        o.t20 = addmod(o.t20, mulmod(i.t4, m[20][4], q), q);
        o.t20 = addmod(o.t20, mulmod(i.t5, m[20][5], q), q);
        o.t20 = addmod(o.t20, mulmod(i.t6, m[20][6], q), q);
        o.t20 = addmod(o.t20, mulmod(i.t7, m[20][7], q), q);
        o.t20 = addmod(o.t20, mulmod(i.t8, m[20][8], q), q);
        o.t20 = addmod(o.t20, mulmod(i.t9, m[20][9], q), q);
        o.t20 = addmod(o.t20, mulmod(i.t10, m[20][10], q), q);
        o.t20 = addmod(o.t20, mulmod(i.t11, m[20][11], q), q);
        o.t20 = addmod(o.t20, mulmod(i.t12, m[20][12], q), q);
        o.t20 = addmod(o.t20, mulmod(i.t13, m[20][13], q), q);
        o.t20 = addmod(o.t20, mulmod(i.t14, m[20][14], q), q);
        o.t20 = addmod(o.t20, mulmod(i.t15, m[20][15], q), q);
        o.t20 = addmod(o.t20, mulmod(i.t16, m[20][16], q), q);
        o.t20 = addmod(o.t20, mulmod(i.t17, m[20][17], q), q);
        o.t20 = addmod(o.t20, mulmod(i.t18, m[20][18], q), q);
        o.t20 = addmod(o.t20, mulmod(i.t19, m[20][19], q), q);
        o.t20 = addmod(o.t20, mulmod(i.t20, m[20][20], q), q);
        o.t20 = addmod(o.t20, mulmod(i.t21, m[20][21], q), q);
        o.t20 = addmod(o.t20, mulmod(i.t22, m[20][22], q), q);
        o.t20 = addmod(o.t20, mulmod(i.t23, m[20][23], q), q);
        o.t20 = addmod(o.t20, mulmod(i.t24, m[20][24], q), q);

        o.t21 = 0;
        o.t21 = addmod(o.t21, mulmod(i.t0, m[21][0], q), q);
        o.t21 = addmod(o.t21, mulmod(i.t1, m[21][1], q), q);
        o.t21 = addmod(o.t21, mulmod(i.t2, m[21][2], q), q);
        o.t21 = addmod(o.t21, mulmod(i.t3, m[21][3], q), q);
        o.t21 = addmod(o.t21, mulmod(i.t4, m[21][4], q), q);
        o.t21 = addmod(o.t21, mulmod(i.t5, m[21][5], q), q);
        o.t21 = addmod(o.t21, mulmod(i.t6, m[21][6], q), q);
        o.t21 = addmod(o.t21, mulmod(i.t7, m[21][7], q), q);
        o.t21 = addmod(o.t21, mulmod(i.t8, m[21][8], q), q);
        o.t21 = addmod(o.t21, mulmod(i.t9, m[21][9], q), q);
        o.t21 = addmod(o.t21, mulmod(i.t10, m[21][10], q), q);
        o.t21 = addmod(o.t21, mulmod(i.t11, m[21][11], q), q);
        o.t21 = addmod(o.t21, mulmod(i.t12, m[21][12], q), q);
        o.t21 = addmod(o.t21, mulmod(i.t13, m[21][13], q), q);
        o.t21 = addmod(o.t21, mulmod(i.t14, m[21][14], q), q);
        o.t21 = addmod(o.t21, mulmod(i.t15, m[21][15], q), q);
        o.t21 = addmod(o.t21, mulmod(i.t16, m[21][16], q), q);
        o.t21 = addmod(o.t21, mulmod(i.t17, m[21][17], q), q);
        o.t21 = addmod(o.t21, mulmod(i.t18, m[21][18], q), q);
        o.t21 = addmod(o.t21, mulmod(i.t19, m[21][19], q), q);
        o.t21 = addmod(o.t21, mulmod(i.t20, m[21][20], q), q);
        o.t21 = addmod(o.t21, mulmod(i.t21, m[21][21], q), q);
        o.t21 = addmod(o.t21, mulmod(i.t22, m[21][22], q), q);
        o.t21 = addmod(o.t21, mulmod(i.t23, m[21][23], q), q);
        o.t21 = addmod(o.t21, mulmod(i.t24, m[21][24], q), q);

        o.t22 = 0;
        o.t22 = addmod(o.t22, mulmod(i.t0, m[22][0], q), q);
        o.t22 = addmod(o.t22, mulmod(i.t1, m[22][1], q), q);
        o.t22 = addmod(o.t22, mulmod(i.t2, m[22][2], q), q);
        o.t22 = addmod(o.t22, mulmod(i.t3, m[22][3], q), q);
        o.t22 = addmod(o.t22, mulmod(i.t4, m[22][4], q), q);
        o.t22 = addmod(o.t22, mulmod(i.t5, m[22][5], q), q);
        o.t22 = addmod(o.t22, mulmod(i.t6, m[22][6], q), q);
        o.t22 = addmod(o.t22, mulmod(i.t7, m[22][7], q), q);
        o.t22 = addmod(o.t22, mulmod(i.t8, m[22][8], q), q);
        o.t22 = addmod(o.t22, mulmod(i.t9, m[22][9], q), q);
        o.t22 = addmod(o.t22, mulmod(i.t10, m[22][10], q), q);
        o.t22 = addmod(o.t22, mulmod(i.t11, m[22][11], q), q);
        o.t22 = addmod(o.t22, mulmod(i.t12, m[22][12], q), q);
        o.t22 = addmod(o.t22, mulmod(i.t13, m[22][13], q), q);
        o.t22 = addmod(o.t22, mulmod(i.t14, m[22][14], q), q);
        o.t22 = addmod(o.t22, mulmod(i.t15, m[22][15], q), q);
        o.t22 = addmod(o.t22, mulmod(i.t16, m[22][16], q), q);
        o.t22 = addmod(o.t22, mulmod(i.t17, m[22][17], q), q);
        o.t22 = addmod(o.t22, mulmod(i.t18, m[22][18], q), q);
        o.t22 = addmod(o.t22, mulmod(i.t19, m[22][19], q), q);
        o.t22 = addmod(o.t22, mulmod(i.t20, m[22][20], q), q);
        o.t22 = addmod(o.t22, mulmod(i.t21, m[22][21], q), q);
        o.t22 = addmod(o.t22, mulmod(i.t22, m[22][22], q), q);
        o.t22 = addmod(o.t22, mulmod(i.t23, m[22][23], q), q);
        o.t22 = addmod(o.t22, mulmod(i.t24, m[22][24], q), q);

        o.t23 = 0;
        o.t23 = addmod(o.t23, mulmod(i.t0, m[23][0], q), q);
        o.t23 = addmod(o.t23, mulmod(i.t1, m[23][1], q), q);
        o.t23 = addmod(o.t23, mulmod(i.t2, m[23][2], q), q);
        o.t23 = addmod(o.t23, mulmod(i.t3, m[23][3], q), q);
        o.t23 = addmod(o.t23, mulmod(i.t4, m[23][4], q), q);
        o.t23 = addmod(o.t23, mulmod(i.t5, m[23][5], q), q);
        o.t23 = addmod(o.t23, mulmod(i.t6, m[23][6], q), q);
        o.t23 = addmod(o.t23, mulmod(i.t7, m[23][7], q), q);
        o.t23 = addmod(o.t23, mulmod(i.t8, m[23][8], q), q);
        o.t23 = addmod(o.t23, mulmod(i.t9, m[23][9], q), q);
        o.t23 = addmod(o.t23, mulmod(i.t10, m[23][10], q), q);
        o.t23 = addmod(o.t23, mulmod(i.t11, m[23][11], q), q);
        o.t23 = addmod(o.t23, mulmod(i.t12, m[23][12], q), q);
        o.t23 = addmod(o.t23, mulmod(i.t13, m[23][13], q), q);
        o.t23 = addmod(o.t23, mulmod(i.t14, m[23][14], q), q);
        o.t23 = addmod(o.t23, mulmod(i.t15, m[23][15], q), q);
        o.t23 = addmod(o.t23, mulmod(i.t16, m[23][16], q), q);
        o.t23 = addmod(o.t23, mulmod(i.t17, m[23][17], q), q);
        o.t23 = addmod(o.t23, mulmod(i.t18, m[23][18], q), q);
        o.t23 = addmod(o.t23, mulmod(i.t19, m[23][19], q), q);
        o.t23 = addmod(o.t23, mulmod(i.t20, m[23][20], q), q);
        o.t23 = addmod(o.t23, mulmod(i.t21, m[23][21], q), q);
        o.t23 = addmod(o.t23, mulmod(i.t22, m[23][22], q), q);
        o.t23 = addmod(o.t23, mulmod(i.t23, m[23][23], q), q);
        o.t23 = addmod(o.t23, mulmod(i.t24, m[23][24], q), q);

        o.t24 = 0;
        o.t24 = addmod(o.t24, mulmod(i.t0, m[24][0], q), q);
        o.t24 = addmod(o.t24, mulmod(i.t1, m[24][1], q), q);
        o.t24 = addmod(o.t24, mulmod(i.t2, m[24][2], q), q);
        o.t24 = addmod(o.t24, mulmod(i.t3, m[24][3], q), q);
        o.t24 = addmod(o.t24, mulmod(i.t4, m[24][4], q), q);
        o.t24 = addmod(o.t24, mulmod(i.t5, m[24][5], q), q);
        o.t24 = addmod(o.t24, mulmod(i.t6, m[24][6], q), q);
        o.t24 = addmod(o.t24, mulmod(i.t7, m[24][7], q), q);
        o.t24 = addmod(o.t24, mulmod(i.t8, m[24][8], q), q);
        o.t24 = addmod(o.t24, mulmod(i.t9, m[24][9], q), q);
        o.t24 = addmod(o.t24, mulmod(i.t10, m[24][10], q), q);
        o.t24 = addmod(o.t24, mulmod(i.t11, m[24][11], q), q);
        o.t24 = addmod(o.t24, mulmod(i.t12, m[24][12], q), q);
        o.t24 = addmod(o.t24, mulmod(i.t13, m[24][13], q), q);
        o.t24 = addmod(o.t24, mulmod(i.t14, m[24][14], q), q);
        o.t24 = addmod(o.t24, mulmod(i.t15, m[24][15], q), q);
        o.t24 = addmod(o.t24, mulmod(i.t16, m[24][16], q), q);
        o.t24 = addmod(o.t24, mulmod(i.t17, m[24][17], q), q);
        o.t24 = addmod(o.t24, mulmod(i.t18, m[24][18], q), q);
        o.t24 = addmod(o.t24, mulmod(i.t19, m[24][19], q), q);
        o.t24 = addmod(o.t24, mulmod(i.t20, m[24][20], q), q);
        o.t24 = addmod(o.t24, mulmod(i.t21, m[24][21], q), q);
        o.t24 = addmod(o.t24, mulmod(i.t22, m[24][22], q), q);
        o.t24 = addmod(o.t24, mulmod(i.t23, m[24][23], q), q);
        o.t24 = addmod(o.t24, mulmod(i.t24, m[24][24], q), q);

        i.t0 = o.t0;
        i.t1 = o.t1;
        i.t2 = o.t2;
        i.t3 = o.t3;
        i.t4 = o.t4;
        i.t5 = o.t5;
        i.t6 = o.t6;
        i.t7 = o.t7;
        i.t8 = o.t8;
        i.t9 = o.t9;
        i.t10 = o.t10;
        i.t11 = o.t11;
        i.t12 = o.t12;
        i.t13 = o.t13;
        i.t14 = o.t14;
        i.t15 = o.t15;
        i.t16 = o.t16;
        i.t17 = o.t17;
        i.t18 = o.t18;
        i.t19 = o.t19;
        i.t20 = o.t20;
        i.t21 = o.t21;
        i.t22 = o.t22;
        i.t23 = o.t23;
        i.t24 = o.t24;
    }

    function sbox_partial(HashInputs25 memory i, uint256 q) internal pure {
        HashInputs25 memory o;

        o.t0 = mulmod(i.t0, i.t0, q);
        o.t0 = mulmod(o.t0, o.t0, q);
        o.t0 = mulmod(i.t0, o.t0, q);

        i.t0 = o.t0;
    }

    function add_round_constants(HashInputs25 memory i, uint256 q, uint256[] memory round_constants, uint256 offset)
        internal
        pure
    {
        return ark(
            i,
            q,
            HashInputs25(
                round_constants[offset],
                round_constants[offset + 1],
                round_constants[offset + 2],
                round_constants[offset + 3],
                round_constants[offset + 4],
                round_constants[offset + 5],
                round_constants[offset + 6],
                round_constants[offset + 7],
                round_constants[offset + 8],
                round_constants[offset + 9],
                round_constants[offset + 10],
                round_constants[offset + 11],
                round_constants[offset + 12],
                round_constants[offset + 13],
                round_constants[offset + 14],
                round_constants[offset + 15],
                round_constants[offset + 16],
                round_constants[offset + 17],
                round_constants[offset + 18],
                round_constants[offset + 19],
                round_constants[offset + 20],
                round_constants[offset + 21],
                round_constants[offset + 22],
                round_constants[offset + 23],
                round_constants[offset + 24]
            )
        );
    }

    function hash(HashInputs25 memory i, PoseidonConstantsU24 memory c, uint256 q) internal pure returns (uint256) {
        uint256 offset = 0;
        uint256 index = 0;
        // initial round constants addition
        add_round_constants(i, q, c.round_constants, offset);

        offset += 25;

        // first half of full rounds
        for (index = 0; index < (c.fullRounds / 2) - 1; index++) {
            sbox_full(i, q);
            add_round_constants(i, q, c.round_constants, offset);
            offset += 25;
            mix(i, c.m, q);
        }

        sbox_full(i, q);
        add_round_constants(i, q, c.round_constants, offset);
        offset += 25;
        mix(i, c.psm, q);

        // partial rounds
        for (index = 0; index < c.partialRounds; index++) {
            sbox_partial(i, q);
            i.t0 = addmod(i.t0, c.round_constants[offset], q);
            offset += 1;
            mix_sparse(i, c.sparseMatrices[index], q);
        }

        // last half of full rounds
        for (index = 0; index < (c.fullRounds / 2) - 1; index++) {
            sbox_full(i, q);
            add_round_constants(i, q, c.round_constants, offset);
            offset += 25;
            mix(i, c.m, q);
        }

        require(offset == c.round_constants.length);

        // final round
        sbox_full(i, q);
        mix(i, c.m, q);

        return i.t1;
    }
}
