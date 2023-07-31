// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.0;

import "@std/Test.sol";
import "src/blocks/pasta/Vesta.sol";
import "src/blocks/pasta/Pallas.sol";
import "src/blocks/SparsePolynomial.sol";
import "src/blocks/IdentityPolynomial.sol";
import "src/blocks/PolyEvalInstance.sol";
import "src/Utilities.sol";

contract PpSpartanStep6Computations is Test {
    function loadDataForFinalVerification()
        private
        pure
        returns (uint256, uint256, uint256, uint256, uint256, uint256, uint256, uint256)
    {
        uint256 self_eval_input_arr_4 = 0x32e163ca55c8cbcd8832b9e62eb4615f8e0303d3f0972690bf9711a8f6f2638c;
        uint256 self_eval_input_arr_5 = 0x1df44137760761fc7024d964fb569952aacfcf9f66263b91a744023fa9e627d8;
        uint256 self_eval_input_arr_6 = 0x39defd5f9c03ad878eae23a6d25986c6c1385ec6b9c30c37e34bb794c3ee90ae;
        uint256 self_eval_input_arr_7 = 0x2201d18ffbf44a7f25c8379b6c6a58c39184a82aa81c8744a7f01aabefe7f5eb;

        uint256 claim_init_expected_col = 0x32e163ca55c8cbcd8832b9e62eb4615f8e0303d3f0972690bf9711a8f6f2638c;
        uint256 claim_read_expected_col = 0x1df44137760761fc7024d964fb569952aacfcf9f66263b91a744023fa9e627d8;
        uint256 claim_write_expected_col = 0x39defd5f9c03ad878eae23a6d25986c6c1385ec6b9c30c37e34bb794c3ee90ae;
        uint256 claim_audit_expected_col = 0x2201d18ffbf44a7f25c8379b6c6a58c39184a82aa81c8744a7f01aabefe7f5eb;

        return (
            self_eval_input_arr_4,
            self_eval_input_arr_5,
            self_eval_input_arr_6,
            self_eval_input_arr_7,
            claim_init_expected_col,
            claim_read_expected_col,
            claim_write_expected_col,
            claim_audit_expected_col
        );
    }

    function finalVerification(
        uint256 claim_init_expected_col,
        uint256 claim_read_expected_col,
        uint256 claim_write_expected_col,
        uint256 claim_audit_expected_col
    ) private pure returns (bool) {
        uint256 self_eval_input_arr_4;
        uint256 self_eval_input_arr_5;
        uint256 self_eval_input_arr_6;
        uint256 self_eval_input_arr_7;
        (self_eval_input_arr_4, self_eval_input_arr_5, self_eval_input_arr_6, self_eval_input_arr_7,,,,) =
            loadDataForFinalVerification();

        if (claim_init_expected_col != self_eval_input_arr_4) {
            return false;
        }

        if (claim_read_expected_col != self_eval_input_arr_5) {
            return false;
        }

        if (claim_write_expected_col != self_eval_input_arr_6) {
            return false;
        }

        if (claim_audit_expected_col != self_eval_input_arr_7) {
            return false;
        }

        return true;
    }

    function testFinalVerification() public pure {
        // primary

        uint256 claim_init_expected_col;
        uint256 claim_read_expected_col;
        uint256 claim_write_expected_col;
        uint256 claim_audit_expected_col;

        (,,,, claim_init_expected_col, claim_read_expected_col, claim_write_expected_col, claim_audit_expected_col) =
            loadDataForFinalVerification();

        assert(
            finalVerification(
                claim_init_expected_col, claim_read_expected_col, claim_write_expected_col, claim_audit_expected_col
            )
        );
    }

    function loadDataForClaimsInitAudit() private pure returns (uint256[] memory, uint256, uint256, uint256, uint256) {
        uint256[] memory r_prod = new uint256[](17);
        r_prod[0] = 0x1e525e8eb5732494ab1aebe43df1d2a0150badb04db05681409c612429cea8ac;
        r_prod[1] = 0x317b05d9d1941be2116f250a8aad1932d009cec690d12ef463fe64c5efadc978;
        r_prod[2] = 0x13493a5dc4e2513470e1749fdb37b41e3836364d77d7eb8b5a81b985bfe7333a;
        r_prod[3] = 0x05499a9b11713b3371978cf62676fc88bbd1784df341575d88c183fe7d2baec2;
        r_prod[4] = 0x304fd43c6453b62cfe98bc726e458208edf3754b58a1b96b48baedb08dc231b6;
        r_prod[5] = 0x2d5ce24c1355a2428de1d5411ecebd98b1328b5b6f87dcc9ecb573252d6cf30d;
        r_prod[6] = 0x2d6762046fc5ca62b436c758321b1844ac5cf096e30085cb81ddd076138d7163;
        r_prod[7] = 0x3ec3a1be092aa81390fb585c46fd3774b20febd739904f20c99ab2c9d0f3ef46;
        r_prod[8] = 0x382b206460e5706009787007b6e484e80423783762ebac703d3cbb9c2615e7b2;
        r_prod[9] = 0x1c9118d02c7792a8728fa7a879687962ae5a1b5aa9942420d239ada6cef57149;
        r_prod[10] = 0x39672312a3af1dadc7dd77703cef7487ae0f27634ce37faba6e81f0b7eae3d25;
        r_prod[11] = 0x0ec9a8b069eed91e089a03c0f47615fe04742b8c1159a10dde4129b71fc65687;
        r_prod[12] = 0x3998456c5125913b2489869938b5b0d98e7f5c87327af98b9dc619fe54fd26c1;
        r_prod[13] = 0x08a01a276934627dad600b53978bd5d64de6090ecb2bef2b73c3d6e346e5c096;
        r_prod[14] = 0x394edaa7014bdeed61ad362a7d9ec5877ad82777dd131489152c96b848a05d78;
        r_prod[15] = 0x0ede18a94d3bdf5f9ee7a7ae19c34315d98847bc4086c9d81f5264b1e127ec78;
        r_prod[16] = 0x1741b54a11d0633c0349b0e317ced512a59ef40b772fbe94415e42af34a25c99;

        uint256 gamma1 = 0x208210b1790f70ee67ac7d528b3a4916f9779bc476ac48421c3b0d5500a59b34;
        uint256 gamma2 = 0x380407a49ddc0c535ec44bf588822f1b7bf5234336e228cc0f62e801ba9f88ce;
        uint256 self_eval_col_audit_ts = 0x0a9989c75a4a4aabcd6e8c66f0c035513bac66ac12fcbeaf1338712c2d1fde38;
        uint256 eval_Z = 0x0dabf3857ebe01c6e96ed15174352d9cd4a4774fe5e0d9e73464e4feee8176a5;

        return (r_prod, self_eval_col_audit_ts, gamma1, gamma2, eval_Z);
    }

    function hash_func(
        uint256 gamma1,
        uint256 gamma2,
        uint256 addr,
        uint256 val,
        uint256 ts,
        uint256 modulus,
        function (uint256) returns (uint256) negate
    ) private returns (uint256) {
        uint256 result = val;
        uint256 tmp = ts;
        uint256 minus_gamma2 = negate(gamma2);
        assembly {
            tmp := mulmod(tmp, gamma1, modulus)
            tmp := mulmod(tmp, gamma1, modulus)

            result := mulmod(result, gamma1, modulus)
            result := addmod(result, tmp, modulus)
            result := addmod(result, addr, modulus)
            result := addmod(result, minus_gamma2, modulus)
        }

        return result;
    }

    function compute_claims_init_audit(
        uint256 gamma1,
        uint256 gamma2,
        uint256 eval_col_audit_ts,
        uint256 eval_Z,
        uint256[] memory r_prod,
        uint256 modulus,
        function (uint256) returns (uint256) negate
    ) private returns (uint256, uint256) {
        uint256 addr = IdentityPolynomialLib.evaluate(r_prod, modulus);
        uint256 val = eval_Z;

        uint256 claim_init = hash_func(gamma1, gamma2, addr, val, 0, modulus, negate);
        uint256 claim_audit = hash_func(gamma1, gamma2, addr, val, eval_col_audit_ts, modulus, negate);

        return (claim_init, claim_audit);
    }

    function test_compute_claims_init_audit() public {
        // primary
        uint256 claim_init_expected;
        uint256 claim_audit_expected;
        (,,,, claim_init_expected,,, claim_audit_expected) = loadDataForFinalVerification();

        uint256[] memory r_prod;
        uint256 eval_col_audit_ts;
        uint256 gamma1;
        uint256 gamma2;
        uint256 eval_Z;
        (r_prod, eval_col_audit_ts, gamma1, gamma2, eval_Z) = loadDataForClaimsInitAudit();

        (uint256 claim_init_actual, uint256 claim_audit_actual) =
            compute_claims_init_audit(gamma1, gamma2, eval_col_audit_ts, eval_Z, r_prod, Vesta.P_MOD, Vesta.negateBase);

        assertEq(claim_audit_actual, claim_audit_expected);
        assertEq(claim_init_actual, claim_init_expected);
    }

    function compute_claims_read_write(
        uint256 gamma1,
        uint256 gamma2,
        uint256 eval_col,
        uint256 eval_E_col_at_r_prod,
        uint256 eval_col_read_ts,
        uint256 modulus,
        function (uint256) returns (uint256) negateBase
    ) private returns (uint256, uint256) {
        uint256 claim_read =
            hash_func(gamma1, gamma2, eval_col, eval_E_col_at_r_prod, eval_col_read_ts, modulus, negateBase);

        uint256 ts_write = addmod(eval_col_read_ts, 1, modulus);
        uint256 claim_write = hash_func(gamma1, gamma2, eval_col, eval_E_col_at_r_prod, ts_write, modulus, negateBase);

        return (claim_read, claim_write);
    }

    function loadDataForClaimsReadWrite() private pure returns (uint256, uint256, uint256, uint256, uint256) {
        uint256 eval_col = 0x02a59bba81c8b01754912164ee6d44b2f0dfceffb49026b56d381b2c8ad90a47;
        uint256 eval_E_col_at_r_prod = 0x2bd1d000b6fc3a97f16fd0f453737d90bfac43998c396782ddc0f152f70d53af;
        uint256 eval_col_read_ts = 0x3cca4aecdecd11b9d6839796f97b5fb638fbaf87906a2567c1e410d9ce01ef66;
        uint256 gamma1 = 0x208210b1790f70ee67ac7d528b3a4916f9779bc476ac48421c3b0d5500a59b34;
        uint256 gamma2 = 0x380407a49ddc0c535ec44bf588822f1b7bf5234336e228cc0f62e801ba9f88ce;

        return (eval_col, eval_E_col_at_r_prod, eval_col_read_ts, gamma1, gamma2);
    }

    function test_compute_claims_read_write() public {
        // primary
        uint256 claim_read_expected;
        uint256 claim_write_expected;
        (,,,,, claim_read_expected, claim_write_expected,) = loadDataForFinalVerification();

        uint256 eval_col;
        uint256 eval_E_col_at_r_prod;
        uint256 eval_col_read_ts;
        uint256 gamma1;
        uint256 gamma2;
        (eval_col, eval_E_col_at_r_prod, eval_col_read_ts, gamma1, gamma2) = loadDataForClaimsReadWrite();

        (uint256 claim_read, uint256 claim_write) = compute_claims_read_write(
            gamma1, gamma2, eval_col, eval_E_col_at_r_prod, eval_col_read_ts, Vesta.P_MOD, Vesta.negateBase
        );

        assertEq(claim_read_expected, claim_read);
        assertEq(claim_write_expected, claim_write);
    }

    function compute_eval_Z(
        uint256 factor,
        uint256 r_prod_unpad_0,
        uint256 self_eval_W,
        uint256 eval_X,
        uint256 modulus,
        function (uint256) returns (uint256) negateBase
    ) private returns (uint256) {
        uint256 result;
        uint256 tmp = negateBase(r_prod_unpad_0);
        assembly {
            tmp := addmod(tmp, 1, modulus)
            tmp := mulmod(tmp, self_eval_W, modulus)
            result := mulmod(r_prod_unpad_0, eval_X, modulus)
            result := addmod(result, tmp, modulus)
            result := mulmod(result, factor, modulus)
        }
        return result;
    }

    function compute_factor(uint256 vk_s_comm_N, uint256 num_vars) private pure returns (uint256, uint256[] memory) {
        require(vk_s_comm_N >= num_vars, "[Step6::compute_factor] vk_s_comm_N < num_vars");

        uint256[] memory r_prod_expected = new uint256[](17);
        r_prod_expected[0] = 0x1e525e8eb5732494ab1aebe43df1d2a0150badb04db05681409c612429cea8ac;
        r_prod_expected[1] = 0x317b05d9d1941be2116f250a8aad1932d009cec690d12ef463fe64c5efadc978;
        r_prod_expected[2] = 0x13493a5dc4e2513470e1749fdb37b41e3836364d77d7eb8b5a81b985bfe7333a;
        r_prod_expected[3] = 0x05499a9b11713b3371978cf62676fc88bbd1784df341575d88c183fe7d2baec2;
        r_prod_expected[4] = 0x304fd43c6453b62cfe98bc726e458208edf3754b58a1b96b48baedb08dc231b6;
        r_prod_expected[5] = 0x2d5ce24c1355a2428de1d5411ecebd98b1328b5b6f87dcc9ecb573252d6cf30d;
        r_prod_expected[6] = 0x2d6762046fc5ca62b436c758321b1844ac5cf096e30085cb81ddd076138d7163;
        r_prod_expected[7] = 0x3ec3a1be092aa81390fb585c46fd3774b20febd739904f20c99ab2c9d0f3ef46;
        r_prod_expected[8] = 0x382b206460e5706009787007b6e484e80423783762ebac703d3cbb9c2615e7b2;
        r_prod_expected[9] = 0x1c9118d02c7792a8728fa7a879687962ae5a1b5aa9942420d239ada6cef57149;
        r_prod_expected[10] = 0x39672312a3af1dadc7dd77703cef7487ae0f27634ce37faba6e81f0b7eae3d25;
        r_prod_expected[11] = 0x0ec9a8b069eed91e089a03c0f47615fe04742b8c1159a10dde4129b71fc65687;
        r_prod_expected[12] = 0x3998456c5125913b2489869938b5b0d98e7f5c87327af98b9dc619fe54fd26c1;
        r_prod_expected[13] = 0x08a01a276934627dad600b53978bd5d64de6090ecb2bef2b73c3d6e346e5c096;
        r_prod_expected[14] = 0x394edaa7014bdeed61ad362a7d9ec5877ad82777dd131489152c96b848a05d78;
        r_prod_expected[15] = 0x0ede18a94d3bdf5f9ee7a7ae19c34315d98847bc4086c9d81f5264b1e127ec78;
        r_prod_expected[16] = 0x1741b54a11d0633c0349b0e317ced512a59ef40b772fbe94415e42af34a25c99;

        uint256 l = CommonUtilities.log2(vk_s_comm_N) - CommonUtilities.log2(2 * num_vars);

        require(l <= r_prod_expected.length, "[Step6::compute_factor] l > r_prod_expected.length");

        uint256 factor = 1;

        uint256 tmp;
        for (uint256 index = 0; index < l; index++) {
            tmp = Vesta.negateBase(r_prod_expected[index]);
            tmp = addmod(tmp, 1, Vesta.P_MOD);
            factor = mulmod(factor, tmp, Vesta.P_MOD);
        }

        uint256[] memory r_prod_unpad = new uint256[](r_prod_expected.length - l);
        for (uint256 index = 0; index < r_prod_unpad.length; index++) {
            r_prod_unpad[index] = r_prod_expected[index + l];
        }

        return (factor, r_prod_unpad);
    }

    function compute_eval_X(uint256 num_vars, uint256[] memory r_prod_unpad) private returns (uint256) {
        uint256 U_u = 0x00000000000000000000000000000000e0cd65f84e44c9ec91e2884db641d086;
        uint256[] memory U_X = new uint256[](2);
        U_X[0] = 0x1008e89ef900296673cb9c082667db6076520e3823832702a98d82b0abc89337;
        U_X[1] = 0x09426e0ffdfcfabc83cebf36d6ef04f69dc55c775e11d46e10c2d2c17a33d909;

        uint256 index = 0;
        uint256[] memory r_prod_unpad_no_zero_element = new uint256[](r_prod_unpad.length - 1);
        for (index = 0; index < r_prod_unpad_no_zero_element.length; index++) {
            r_prod_unpad_no_zero_element[index] = r_prod_unpad[index + 1];
        }

        index = 0;
        SparsePolynomialLib.Z[] memory poly_X = new SparsePolynomialLib.Z[](U_X.length + 1);
        poly_X[index] = SparsePolynomialLib.Z(index, U_u);
        index++;

        for (uint256 i = 0; i < U_X.length; i++) {
            poly_X[index] = SparsePolynomialLib.Z(index, U_X[i]);
            index++;
        }

        uint256 actual = SparsePolynomialLib.evaluate(
            CommonUtilities.log2(num_vars), poly_X, r_prod_unpad_no_zero_element, Vesta.P_MOD, Vesta.negateBase
        );

        return actual;
    }

    function test_compute_eval_Z() public {
        uint256 self_eval_W = 0x17938b6eba9ed44f2cc8f93d2b529b20c957e8f6e3a043300e304930614b564e;
        uint256 vk_s_comm_N = 131072;
        uint256 num_vars = 16384;

        (uint256 factor, uint256[] memory r_prod_unpad) = compute_factor(vk_s_comm_N, num_vars);

        uint256 eval_X = compute_eval_X(num_vars, r_prod_unpad);

        uint256 actual = compute_eval_Z(factor, r_prod_unpad[0], self_eval_W, eval_X, Vesta.P_MOD, Vesta.negateBase);

        uint256 expected = 0x0dabf3857ebe01c6e96ed15174352d9cd4a4774fe5e0d9e73464e4feee8176a5;
        assertEq(expected, actual);
    }

    function test_compute_u_vec_5() public {
        uint256 self_eval_W = 0x17938b6eba9ed44f2cc8f93d2b529b20c957e8f6e3a043300e304930614b564e;
        uint256 vk_s_comm_N = 131072;
        uint256 num_vars = 16384;

        uint256 U_x = 0x20b8f422ff4d669f6c21a872547e6cc1f456c814128f0cec5ae8c1041308633f;
        uint256 U_y = 0x1c99056155380248020b612dba4012faaebe3b37d695b46d1dd77e5ed6afdbf6;

        (, uint256[] memory r_prod_unpad) = compute_factor(vk_s_comm_N, num_vars);

        uint256[] memory x = new uint256[](r_prod_unpad.length - 1);
        for (uint256 index = 0; index < r_prod_unpad.length - 1; index++) {
            x[index] = r_prod_unpad[index + 1];
        }

        PolyEvalInstanceLib.PolyEvalInstance memory u_vec_5 =
            PolyEvalInstanceLib.PolyEvalInstance(U_x, U_y, x, self_eval_W);

        assertEq(u_vec_5.c_x, 0x20b8f422ff4d669f6c21a872547e6cc1f456c814128f0cec5ae8c1041308633f);
        assertEq(u_vec_5.c_y, 0x1c99056155380248020b612dba4012faaebe3b37d695b46d1dd77e5ed6afdbf6);
        assertEq(u_vec_5.e, 0x17938b6eba9ed44f2cc8f93d2b529b20c957e8f6e3a043300e304930614b564e);
        for (uint256 index = 0; index < u_vec_5.x.length; index++) {
            assertEq(u_vec_5.x[index], r_prod_unpad[index + 1]);
        }
    }
}
