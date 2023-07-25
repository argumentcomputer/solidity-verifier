// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.0;

import "@std/Test.sol";
import "src/blocks/EqPolynomial.sol";
import "src/blocks/IdentityPolynomial.sol";
import "src/blocks/KeccakTranscript.sol";
import "src/NovaVerifierAbstractions.sol";

contract PpSpartanStep5Computations is Test {
    function loadDataForFinalVerification()
        private
        returns (uint256, uint256, uint256, uint256, uint256, uint256, uint256, uint256)
    {
        uint256 self_eval_input_arr_0 = 0x259ca7141dabcc8b8fe1f99033c3864ecdda5ce134960487fb6ad829750c178b;
        uint256 self_eval_input_arr_1 = 0x083137f43c3726a174e87fdabcec43994274ea1ffeac02d8330e8174c640a96f;
        uint256 self_eval_input_arr_2 = 0x241bf41c6233722c9371ca1c93ef310d58dd79475248d37e6f1636c9e0491245;
        uint256 self_eval_input_arr_3 = 0x20f5df63a58afefba6020ac0a7d7b188ba3909e3098b4ddd83277190d9d3c942;

        uint256 claim_init_expected_row = 0x259ca7141dabcc8b8fe1f99033c3864ecdda5ce134960487fb6ad829750c178b;
        uint256 claim_read_expected_row = 0x083137f43c3726a174e87fdabcec43994274ea1ffeac02d8330e8174c640a96f;
        uint256 claim_write_expected_row = 0x241bf41c6233722c9371ca1c93ef310d58dd79475248d37e6f1636c9e0491245;
        uint256 claim_audit_expected_row = 0x20f5df63a58afefba6020ac0a7d7b188ba3909e3098b4ddd83277190d9d3c942;

        return (
            self_eval_input_arr_0,
            self_eval_input_arr_1,
            self_eval_input_arr_2,
            self_eval_input_arr_3,
            claim_init_expected_row,
            claim_read_expected_row,
            claim_write_expected_row,
            claim_audit_expected_row
        );
    }

    function finalVerification(
        uint256 claim_init_expected_row,
        uint256 claim_read_expected_row,
        uint256 claim_write_expected_row,
        uint256 claim_audit_expected_row
    ) private returns (bool) {
        uint256 self_eval_input_arr_0;
        uint256 self_eval_input_arr_1;
        uint256 self_eval_input_arr_2;
        uint256 self_eval_input_arr_3;
        (self_eval_input_arr_0, self_eval_input_arr_1, self_eval_input_arr_2, self_eval_input_arr_3,,,,) =
            loadDataForFinalVerification();

        if (claim_init_expected_row != self_eval_input_arr_0) {
            return false;
        }

        if (claim_read_expected_row != self_eval_input_arr_1) {
            return false;
        }

        if (claim_write_expected_row != self_eval_input_arr_2) {
            return false;
        }

        if (claim_audit_expected_row != self_eval_input_arr_3) {
            return false;
        }

        return true;
    }

    function testFinalVerification() public {
        // primary

        uint256 claim_init_expected_row;
        uint256 claim_read_expected_row;
        uint256 claim_write_expected_row;
        uint256 claim_audit_expected_row;

        (,,,, claim_init_expected_row, claim_read_expected_row, claim_write_expected_row, claim_audit_expected_row) =
            loadDataForFinalVerification();

        assert(
            finalVerification(
                claim_init_expected_row, claim_read_expected_row, claim_write_expected_row, claim_audit_expected_row
            )
        );
    }

    function loadDataForClaimsInitAudit()
        private
        returns (uint256[] memory, uint256[] memory, uint256, uint256, uint256)
    {
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

        uint256[] memory tau = new uint256[](17);
        tau[0] = 0x15f5e9f471c313af5c8190c109c3a1fe9cee73d035bcd08a204898e795d8e497;
        tau[1] = 0x026bc743ada824501ac59409a022aeaba83ebe9c6fe153969c47d3dbcba1be20;
        tau[2] = 0x0235a660a3f8c7aa923e90ef914634b078bec35cd1b1ed8d763735655f16c86b;
        tau[3] = 0x06b9cd3880fe5f9881f9fd2b0f15eaa134f0271faa129290886932018371f6a4;
        tau[4] = 0x369f08f9d3a1b649e724e2ded5d88ae935ee5128bfc966a33b09fd298ce1f4f9;
        tau[5] = 0x17c2194712668c76ac2ac0d4ddc7ae50995905fa689a153b3a46b539a40a0cb8;
        tau[6] = 0x0416682dc67529249a90de425db7b2f08a44eefa18ff9a42dae68dd77e001d23;
        tau[7] = 0x08414bd36fb4ec48989f9922cd0fa9ab1e1414d9bc3e7be4dd87166124351a6c;
        tau[8] = 0x3714b73daef1dd873e79a9b670c7f403a506aaec54666f2a9daa8805ce3fa7df;
        tau[9] = 0x3c23643dd2a5d6b64ba3f86d6ea4c347db24e45163421b450b20dc44e502da77;
        tau[10] = 0x219bd827a1a9cfcbacb2d66370f8ab9af8449f0e779eeb441b0cc3e46ac24408;
        tau[11] = 0x2a99b7d2d92e7ce4b1a5bb9893a58c94525afcc43ca64c9579217d5db1980289;
        tau[12] = 0x244902bf184af91659be921be063244f4d9aacf94e19fd121446104850f2b1d9;
        tau[13] = 0x1594eeac26b85866f2cf09dea1c5ee8920e8b4bfde8edba325f5e89ac9995ab6;
        tau[14] = 0x2e6dee8a44ef6d3058da01d7e90582d1f5d6b2fd8f05eea54540fe77a8444f12;
        tau[15] = 0x17798e8f0e66b1d6e1f53871eeaaabb28f680fda97a9ae07eb833be231310035;
        tau[16] = 0x2a7e0ec4192134bc0102de30940d4fd26bb0cd60e11f74519f9d9a90bebeaf5f;

        uint256 gamma1 = 0x208210b1790f70ee67ac7d528b3a4916f9779bc476ac48421c3b0d5500a59b34;
        uint256 gamma2 = 0x380407a49ddc0c535ec44bf588822f1b7bf5234336e228cc0f62e801ba9f88ce;
        uint256 self_eval_row_audit_ts = 0x0cabb1e9be4fc653ad4bfb1608369affff01d0f506ec30b417e0a5745dd316c4;

        return (r_prod, tau, self_eval_row_audit_ts, gamma1, gamma2);
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
        uint256 eval_row_audit_ts,
        uint256[] memory r_prod,
        uint256[] memory tau,
        uint256 modulus,
        function (uint256) returns (uint256) negate
    ) private returns (uint256, uint256) {
        uint256 addr = IdentityPolynomialLib.evaluate(r_prod, modulus);
        uint256 val = EqPolinomialLib.evaluate(tau, r_prod, modulus, negate);

        uint256 claim_init = hash_func(gamma1, gamma2, addr, val, 0, modulus, negate);
        uint256 claim_audit = hash_func(gamma1, gamma2, addr, val, eval_row_audit_ts, modulus, negate);

        return (claim_init, claim_audit);
    }

    function test_compute_claims_init_audit() public {
        // primary
        uint256 claim_init_expected;
        uint256 claim_audit_expected;
        (,,,, claim_init_expected,,, claim_audit_expected) = loadDataForFinalVerification();

        uint256[] memory r_prod;
        uint256[] memory tau;
        uint256 eval_row_audit_ts;
        uint256 gamma1;
        uint256 gamma2;
        (r_prod, tau, eval_row_audit_ts, gamma1, gamma2) = loadDataForClaimsInitAudit();

        (uint256 claim_init_actual, uint256 claim_audit_actual) =
            compute_claims_init_audit(gamma1, gamma2, eval_row_audit_ts, r_prod, tau, Vesta.P_MOD, Vesta.negateBase);

        assertEq(claim_audit_actual, claim_audit_expected);
        assertEq(claim_init_actual, claim_init_expected);
    }

    function compute_claims_read_write(
        uint256 gamma1,
        uint256 gamma2,
        uint256 eval_row,
        uint256 eval_E_row_at_r_prod,
        uint256 eval_row_read_ts,
        uint256 modulus,
        function (uint256) returns (uint256) negateBase
    ) private returns (uint256, uint256) {
        uint256 claim_read =
            hash_func(gamma1, gamma2, eval_row, eval_E_row_at_r_prod, eval_row_read_ts, modulus, negateBase);

        uint256 ts_write = addmod(eval_row_read_ts, 1, modulus);
        uint256 claim_write = hash_func(gamma1, gamma2, eval_row, eval_E_row_at_r_prod, ts_write, modulus, negateBase);

        return (claim_read, claim_write);
    }

    function loadDataForClaimsReadWrite() private returns (uint256, uint256, uint256, uint256, uint256) {
        uint256 eval_row = 0x01c4e19f9061888370440ee422429adaad35d48103b8feacab8aa189f35307a9;
        uint256 eval_E_row_at_r_prod = 0x33a9e536648e6e70892b52cb92f77b3fba23983fe3f051b0167b883906ef8e2c;
        uint256 eval_row_read_ts = 0x1f028067c1a3091aa323ab801432abdabe174d2a7182ece2a4adf33dbaec9dcb;
        uint256 gamma1 = 0x208210b1790f70ee67ac7d528b3a4916f9779bc476ac48421c3b0d5500a59b34;
        uint256 gamma2 = 0x380407a49ddc0c535ec44bf588822f1b7bf5234336e228cc0f62e801ba9f88ce;

        return (eval_row, eval_E_row_at_r_prod, eval_row_read_ts, gamma1, gamma2);
    }

    function test_compute_claims_read_write() public {
        // primary
        uint256 claim_read_expected;
        uint256 claim_write_expected;
        (,,,,, claim_read_expected, claim_write_expected,) = loadDataForFinalVerification();

        uint256 eval_row;
        uint256 eval_E_row_at_r_prod;
        uint256 eval_row_read_ts;
        uint256 gamma1;
        uint256 gamma2;
        (eval_row, eval_E_row_at_r_prod, eval_row_read_ts, gamma1, gamma2) = loadDataForClaimsReadWrite();

        (uint256 claim_read, uint256 claim_write) = compute_claims_read_write(
            gamma1, gamma2, eval_row, eval_E_row_at_r_prod, eval_row_read_ts, Vesta.P_MOD, Vesta.negateBase
        );

        assertEq(claim_read_expected, claim_read);
        assertEq(claim_write_expected, claim_write);
    }

    function loadDataForRProd() private returns (uint256, uint256[] memory, uint256[] memory) {
        uint256 c = 0x1741b54a11d0633c0349b0e317ced512a59ef40b772fbe94415e42af34a25c99;
        uint256[] memory r_sat = new uint256[](17);
        r_sat[0] = 0x066b998f211c11d58f5c4ce0eb59a7ba543bdab2c99b5061c097723eb0ed8ff9;
        r_sat[1] = 0x1e525e8eb5732494ab1aebe43df1d2a0150badb04db05681409c612429cea8ac;
        r_sat[2] = 0x317b05d9d1941be2116f250a8aad1932d009cec690d12ef463fe64c5efadc978;
        r_sat[3] = 0x13493a5dc4e2513470e1749fdb37b41e3836364d77d7eb8b5a81b985bfe7333a;
        r_sat[4] = 0x05499a9b11713b3371978cf62676fc88bbd1784df341575d88c183fe7d2baec2;
        r_sat[5] = 0x304fd43c6453b62cfe98bc726e458208edf3754b58a1b96b48baedb08dc231b6;
        r_sat[6] = 0x2d5ce24c1355a2428de1d5411ecebd98b1328b5b6f87dcc9ecb573252d6cf30d;
        r_sat[7] = 0x2d6762046fc5ca62b436c758321b1844ac5cf096e30085cb81ddd076138d7163;
        r_sat[8] = 0x3ec3a1be092aa81390fb585c46fd3774b20febd739904f20c99ab2c9d0f3ef46;
        r_sat[9] = 0x382b206460e5706009787007b6e484e80423783762ebac703d3cbb9c2615e7b2;
        r_sat[10] = 0x1c9118d02c7792a8728fa7a879687962ae5a1b5aa9942420d239ada6cef57149;
        r_sat[11] = 0x39672312a3af1dadc7dd77703cef7487ae0f27634ce37faba6e81f0b7eae3d25;
        r_sat[12] = 0x0ec9a8b069eed91e089a03c0f47615fe04742b8c1159a10dde4129b71fc65687;
        r_sat[13] = 0x3998456c5125913b2489869938b5b0d98e7f5c87327af98b9dc619fe54fd26c1;
        r_sat[14] = 0x08a01a276934627dad600b53978bd5d64de6090ecb2bef2b73c3d6e346e5c096;
        r_sat[15] = 0x394edaa7014bdeed61ad362a7d9ec5877ad82777dd131489152c96b848a05d78;
        r_sat[16] = 0x0ede18a94d3bdf5f9ee7a7ae19c34315d98847bc4086c9d81f5264b1e127ec78;

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

        return (c, r_sat, r_prod_expected);
    }

    function compute_r_prod(uint256 c, uint256[] memory r_sat) private returns (uint256[] memory) {
        uint256[] memory rand_ext = new uint256[](r_sat.length + 1);
        for (uint256 index = 0; index < r_sat.length; index++) {
            rand_ext[index] = r_sat[index];
        }

        rand_ext[r_sat.length] = c;

        uint256[] memory r_prod = new uint256[](rand_ext.length - 1);
        for (uint256 index = 1; index < rand_ext.length; index++) {
            r_prod[index - 1] = rand_ext[index];
        }

        return r_prod;
    }

    function test_compute_r_prod() public {
        (uint256 c, uint256[] memory r_sat, uint256[] memory r_prod_expected) = loadDataForRProd();

        uint256[] memory r_prod = compute_r_prod(c, r_sat);

        assertEq(r_prod.length, r_prod_expected.length);
        for (uint256 index = 0; index < r_prod_expected.length; index++) {
            assertEq(r_prod[index], r_prod_expected[index]);
        }
    }

    function loadTranscript() private returns (KeccakTranscriptLib.KeccakTranscript memory) {
        uint16 rounds = 55;
        uint8[] memory state = new uint8[](64);
        state[0] = 0xf9;
        state[8] = 0xbf;
        state[16] = 0xa6;
        state[24] = 0xa1;
        state[32] = 0x41;
        state[40] = 0xe3;
        state[48] = 0xce;
        state[56] = 0x0c;
        state[1] = 0x27;
        state[9] = 0xd2;
        state[17] = 0xd5;
        state[25] = 0xe9;
        state[33] = 0xe7;
        state[41] = 0xb0;
        state[49] = 0x53;
        state[57] = 0xf6;
        state[2] = 0xae;
        state[10] = 0xaf;
        state[18] = 0xbf;
        state[26] = 0xbe;
        state[34] = 0xc9;
        state[42] = 0x0d;
        state[50] = 0x8a;
        state[58] = 0x23;
        state[3] = 0x2b;
        state[11] = 0x8f;
        state[19] = 0xb7;
        state[27] = 0x8d;
        state[35] = 0x3a;
        state[43] = 0x86;
        state[51] = 0xab;
        state[59] = 0x5a;
        state[4] = 0x69;
        state[12] = 0x95;
        state[20] = 0x57;
        state[28] = 0x78;
        state[36] = 0xe8;
        state[44] = 0x70;
        state[52] = 0x7c;
        state[60] = 0xf4;
        state[5] = 0x54;
        state[13] = 0x07;
        state[21] = 0xb4;
        state[29] = 0xfa;
        state[37] = 0xae;
        state[45] = 0x4c;
        state[53] = 0xb2;
        state[61] = 0x71;
        state[6] = 0x9d;
        state[14] = 0xf2;
        state[22] = 0x20;
        state[30] = 0xc9;
        state[38] = 0xb1;
        state[46] = 0x1e;
        state[54] = 0x27;
        state[62] = 0x75;
        state[7] = 0x5c;
        state[15] = 0x90;
        state[23] = 0x4e;
        state[31] = 0xce;
        state[39] = 0x5b;
        state[47] = 0x6c;
        state[55] = 0x9b;
        state[63] = 0xbc;

        uint8[] memory transcript = new uint8[](0);

        return KeccakTranscriptLib.KeccakTranscript(rounds, state, transcript);
    }

    function loadDataForC()
        private
        returns (
            uint256[] memory,
            uint256[] memory,
            uint256[] memory,
            uint256[] memory,
            uint256[] memory,
            uint256[] memory
        )
    {
        uint256[] memory eval_A_B_C_z = new uint256[](3);
        eval_A_B_C_z[0] = 0x040472c4f10b22a2743de027827847e9f1e21e7e523f133b8adaa4da8c95be98;
        eval_A_B_C_z[1] = 0x3214bea2fc2c1a5b398af55ecbb96fecec912c00a4bab43a9d9e3509c3a3f83f;
        eval_A_B_C_z[2] = 0x0143a288d31527e4844c85c488b954daa941db5db11b9ca5be82ceb8343e0464;

        uint256[] memory evals_E = new uint256[](3);
        evals_E[0] = 0x384918480ef2f4adc3d8ffe130fb26003e83d997de344cefec47680cc014e2a7;
        evals_E[1] = 0x0ae4efa04fe7b3aabb07a164ae2329c6cb11d76b19cfe1e8e3b165a2a2e4958d;
        evals_E[2] = 0x3a6ada7aa60646269cb376ab6881116450b75feeb1a4dbeb4f03c2943d8cf0bc;

        uint256[] memory evals_val = new uint256[](3);
        evals_val[0] = 0x2da7601269ec68bbbbf62ad60c435c569ff2a9fe7fc5d5f607b251524ec0cedd;
        evals_val[1] = 0x02e55245edda3017d3cf133264ad42a2acfe8c829d269aa694db1e0b80b53119;
        evals_val[2] = 0x22eff8048b72e6536edd0e678c0158596e1414e66d133e9436b921254dcb33f3;

        uint256[] memory eval_left_arr = new uint256[](8);
        eval_left_arr[0] = 0x2e5cf27144dfdf0431339298cf6e81481d612ed8068480e2b32b7fcbfd2c5e47;
        eval_left_arr[1] = 0x080707b42fa7177958b31c59d1d7192a26be4b38ee8dc8f163470c7a6ce01c73;
        eval_left_arr[2] = 0x29e9f39010e917f5e83cac6dd7739746cb5daca8e81f2e462314435419fdabf1;
        eval_left_arr[3] = 0x02628c6c664a6945499fafae1638cded555df82472eeaa448c3793717f7fe153;
        eval_left_arr[4] = 0x20fa1abd1e7e8e50ca7f3cb81766a732f3d2bf09fcb7ee060f555d02eb30708c;
        eval_left_arr[5] = 0x239321224bf533ce5001123833f5ddd0a3030d7a32a79da9e8a684d48ac96392;
        eval_left_arr[6] = 0x310874f6e54e4cfcc8dc13049bb9d726e9416a028e9a8b1ef11517c4932b23d7;
        eval_left_arr[7] = 0x1ced10b2a28453894c1df54792683fcd5f3ddde626a8a894abf9884be2c25b1a;

        uint256[] memory eval_right_arr = new uint256[](8);
        eval_right_arr[0] = 0x369a3760735a11c4fad4bf4ec54f70e3ded6a45ff57bc8d645e641483731dccd;
        eval_right_arr[1] = 0x234fb6b3e6fb3ec8437e8adf43da41e269b86c4ba310886af9be24f2e7ad4c0a;
        eval_right_arr[2] = 0x129d6024808dbb8f3584cc4001c7f57ee36910196befd344e8bf9834a63c9dd2;
        eval_right_arr[3] = 0x0dc722a1d5943df4cb23096dbe74ae75312a05c046f19b2ee938a794a782ec5b;
        eval_right_arr[4] = 0x170593e4b5c0befa79e15b6af59381a756347affffcbdf37857a458fc7ee105d;
        eval_right_arr[5] = 0x27d1763d1a4b6f50bc6d617d9a8a4af41cc1eafb0e3948c33192d3642833de38;
        eval_right_arr[6] = 0x27268c600ccfde1e3e609ee1ab443e70f20977db2d82b9a4bbc816e5f997d357;
        eval_right_arr[7] = 0x226e242d5173df1fea0661ef67241b48d920858bcec8cf1e2d5dc19913120198;

        uint256[] memory eval_output_arr = new uint256[](8);
        eval_output_arr[0] = 0x3bcb8feffaa1cc6e40035915f2938e5e9db68fd8e832db46d08f2ab84df8c3dd;
        eval_output_arr[1] = 0x2bf19d305594985d501b8ad9c3f2ed61f9914b65f6fd9c57b7a457c93bdd7ff7;
        eval_output_arr[2] = 0x32315a287a4d4a4677a213448fc5652e416e57b4f950bd08044b12850be3135d;
        eval_output_arr[3] = 0x011381e4c96b793d1ada7ab5665e9bb79237dbf6de3ec315224a90c22f774d46;
        eval_output_arr[4] = 0x3f88f5f858cc155c5699c9aa250f062701d1dd0c5891d318ce647b1480ad78d0;
        eval_output_arr[5] = 0x10f3c5428f7099faf754569621575fc7c7a5dabbfa06f56435c6cbb7a25daec8;
        eval_output_arr[6] = 0x24b53ad2dca0387fec0faccebe17880781ee0c31e4bedcfedb64e1c651e43acf;
        eval_output_arr[7] = 0x3f6c5db8e978aab7609c37f35184aa107c0f797bba5f8ae2edfd01107cf2b7d1;

        return (eval_A_B_C_z, evals_E, evals_val, eval_left_arr, eval_right_arr, eval_output_arr);
    }

    function compute_eval_vec(
        uint256[] memory eval_A_B_C_z,
        uint256[] memory evals_E,
        uint256[] memory evals_val,
        uint256[] memory eval_left_arr,
        uint256[] memory eval_right_arr,
        uint256[] memory eval_output_arr
    ) private returns (uint256[] memory) {
        uint256 index = 0;
        uint256[] memory eval_vec =
        new uint256[](eval_left_arr.length + eval_right_arr.length + eval_output_arr.length + eval_A_B_C_z.length + evals_E.length + evals_val.length);

        for (uint256 i = 0; i < eval_A_B_C_z.length; i++) {
            eval_vec[index] = eval_A_B_C_z[i];
            index++;
        }
        for (uint256 i = 0; i < evals_E.length; i++) {
            eval_vec[index] = evals_E[i];
            index++;
        }
        for (uint256 i = 0; i < evals_val.length; i++) {
            eval_vec[index] = evals_val[i];
            index++;
        }

        for (uint256 i = 0; i < eval_left_arr.length; i++) {
            eval_vec[index] = eval_left_arr[i];
            index++;
        }
        for (uint256 i = 0; i < eval_right_arr.length; i++) {
            eval_vec[index] = eval_right_arr[i];
            index++;
        }
        for (uint256 i = 0; i < eval_output_arr.length; i++) {
            eval_vec[index] = eval_output_arr[i];
            index++;
        }

        return eval_vec;
    }

    function test_compute_c() public {
        KeccakTranscriptLib.KeccakTranscript memory transcript = loadTranscript();

        uint256[] memory eval_vec;
        {
            (
                uint256[] memory eval_A_B_C_z,
                uint256[] memory evals_E,
                uint256[] memory evals_val,
                uint256[] memory eval_left_arr,
                uint256[] memory eval_right_arr,
                uint256[] memory eval_output_arr
            ) = loadDataForC();

            eval_vec =
                compute_eval_vec(eval_A_B_C_z, evals_E, evals_val, eval_left_arr, eval_right_arr, eval_output_arr);
        }

        uint8[] memory input = Abstractions.toTranscriptBytes(eval_vec);

        uint8[] memory label = new uint8[](1);
        label[0] = 0x65; // Rust's b"e"

        transcript = KeccakTranscriptLib.absorb(transcript, label, input);

        label[0] = 0x63; // Rust's b"c"

        uint256 output;
        (transcript, output) = KeccakTranscriptLib.squeeze(transcript, ScalarFromUniformLib.curveVesta(), label);
        output = Field.reverse256(output);

        uint256 expected = 0x1741b54a11d0633c0349b0e317ced512a59ef40b772fbe94415e42af34a25c99;
        assertEq(output, expected);
    }
}
