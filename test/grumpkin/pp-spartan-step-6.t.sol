// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.16;

import "@std/Test.sol";
import "src/NovaVerifierAbstractions.sol";
import "src/verifier/Step6Grumpkin.sol";
import "src/verifier/Step6.sol";

import "test/utils.t.sol";

contract PpSpartanStep6Computations is Test {
    function test_compute_eval_Z_primary() public {
        Abstractions.CompressedSnark memory proof = TestUtilities.loadProof();
        (Abstractions.VerifierKey memory vk,,) = TestUtilities.loadPublicParameters();

        uint256[] memory r_prod = new uint256[](17);
        r_prod[0] = 0x05837413e5049a37ef21bc91fd21fcce3f89e80202ec70aa01872cc9221d95cd;
        r_prod[1] = 0x17430b827b82e51b14fcdf9511b6a8061d1392d4589b8221dafbae759dd6e070;
        r_prod[2] = 0x0256f4d5674a529ec39e0afba3738d0263cb1d385a563ce608edad719f47d5fd;
        r_prod[3] = 0x00f87554a6caed435bb9e714a355fa73cfd359d5dd8b31fc172ada8cecd7ee30;
        r_prod[4] = 0x29b4dbb7be87a4961e21fe447b03125469077ba2bad896ac2c374aa55be358ab;
        r_prod[5] = 0x1493591a52ded39471fbcd9937537aae9023e77080708f790798671aaa268fc9;
        r_prod[6] = 0x046d5e95bee7ea383f29e0ffa2a6e2816d5b82a75283265e2bc17e63d6ecaeee;
        r_prod[7] = 0x0ea46d83cda8cac4084d937137ab451e89d3fef4b6e25ec00e80fcb8bf8a5308;
        r_prod[8] = 0x26d16ee1e12b5e781327f54a2b89bb7f397e500ec503066b4e37c5e59c372aa1;
        r_prod[9] = 0x2826c37882e6cec0184d476e6e14ac3cb48aee6e233a1ee085c174d53cf1f419;
        r_prod[10] = 0x1b054f124db95f87ec662a5b8ddf47f2b0264e97ef866a05e2a3e0335bce3b16;
        r_prod[11] = 0x0fd296132bf7fc749c44059331d68c735b05f8f746c26e0bf25c3e0a0e6b17b1;
        r_prod[12] = 0x2aede350fab3723fb2ed55ed281f40e4a718f43237901e99264cb09a586661ef;
        r_prod[13] = 0x1a99798029810bbe8a2a5e0d738e8a7c54c010acf84892178463c3222d08b351;
        r_prod[14] = 0x01611bd374a32895d454f4fbe32f051f82e1fef13242ee7951dc6df7848cef97;
        r_prod[15] = 0x019b91a9d375fe46af22a415a0cba65d78d7a605eecf99b3eff27cd508e6282c;
        r_prod[16] = 0x0780ddd1b7bae1a8aff7cf5a352412e2956c573041e9ec3557bca02d7a2e78a1;

        uint256[] memory U_X = new uint256[](2);
        U_X[0] = 0x08f230d21087f2e0ea33703b5a0de3b92ff58b09b8bdbcee2016f70d7699cbd9;
        U_X[1] = 0x1e7d17e953a2bee716b7139675a0fc9c1a3d34f00c1c071eac84e21f33841927;

        uint256 U_u = 0x000000000000000000000000000000010a3cb5af114bc6094024d5e8b5817038;

        uint256 eval_Z;
        uint256[] memory r_prod_unpad;
        (eval_Z, r_prod_unpad) = Step6GrumpkinLib.compute_eval_Z(
            proof.r_W_snark_primary,
            U_X,
            U_u,
            vk.vk_primary.S_comm.N,
            vk.vk_primary.num_vars,
            r_prod,
            Bn256.R_MOD,
            Bn256.negateScalar
        );

        assertEq(eval_Z, 0x1e5c2802a0ce24f350f0e77351ba5f77e3b682bf52d55a8df5419662a637f972);
        assertEq(r_prod_unpad[0], 0x0256f4d5674a529ec39e0afba3738d0263cb1d385a563ce608edad719f47d5fd);
        assertEq(r_prod_unpad[1], 0x00f87554a6caed435bb9e714a355fa73cfd359d5dd8b31fc172ada8cecd7ee30);
        assertEq(r_prod_unpad[2], 0x29b4dbb7be87a4961e21fe447b03125469077ba2bad896ac2c374aa55be358ab);
        assertEq(r_prod_unpad[3], 0x1493591a52ded39471fbcd9937537aae9023e77080708f790798671aaa268fc9);
        assertEq(r_prod_unpad[4], 0x046d5e95bee7ea383f29e0ffa2a6e2816d5b82a75283265e2bc17e63d6ecaeee);
        assertEq(r_prod_unpad[5], 0x0ea46d83cda8cac4084d937137ab451e89d3fef4b6e25ec00e80fcb8bf8a5308);
        assertEq(r_prod_unpad[6], 0x26d16ee1e12b5e781327f54a2b89bb7f397e500ec503066b4e37c5e59c372aa1);
        assertEq(r_prod_unpad[7], 0x2826c37882e6cec0184d476e6e14ac3cb48aee6e233a1ee085c174d53cf1f419);
        assertEq(r_prod_unpad[8], 0x1b054f124db95f87ec662a5b8ddf47f2b0264e97ef866a05e2a3e0335bce3b16);
        assertEq(r_prod_unpad[9], 0x0fd296132bf7fc749c44059331d68c735b05f8f746c26e0bf25c3e0a0e6b17b1);
        assertEq(r_prod_unpad[10], 0x2aede350fab3723fb2ed55ed281f40e4a718f43237901e99264cb09a586661ef);
        assertEq(r_prod_unpad[11], 0x1a99798029810bbe8a2a5e0d738e8a7c54c010acf84892178463c3222d08b351);
        assertEq(r_prod_unpad[12], 0x01611bd374a32895d454f4fbe32f051f82e1fef13242ee7951dc6df7848cef97);
        assertEq(r_prod_unpad[13], 0x019b91a9d375fe46af22a415a0cba65d78d7a605eecf99b3eff27cd508e6282c);
        assertEq(r_prod_unpad[14], 0x0780ddd1b7bae1a8aff7cf5a352412e2956c573041e9ec3557bca02d7a2e78a1);
    }

    function test_compute_eval_Z_secondary() public {
        Abstractions.CompressedSnark memory proof = TestUtilities.loadProof();
        (Abstractions.VerifierKey memory vk,,) = TestUtilities.loadPublicParameters();

        uint256[] memory r_prod = new uint256[](17);
        r_prod[0] = 0x1725a070098a94cf768334d9b0c3ac4a261682687b39c8e6db7ad3c2901d5e24;
        r_prod[1] = 0x26b72d7895ccf170139a9a71e7da7431d81afd3cd5223969d4794ca8b1366241;
        r_prod[2] = 0x2c9493e9d5b214b3cad4bb621544e6001cb1dc10421ede559fb937d89568cd01;
        r_prod[3] = 0x1334cd36b6c002cd14bd1ac0e19bfca3b7fe600634fa22ac5d6fc6b271c50ea1;
        r_prod[4] = 0x24e56409afcdd7500f2608d82db8f7a607cb1c5246aaa03cb30fdab50e6b0131;
        r_prod[5] = 0x27ee3e707f58a066bd5c0c4078fc690de3d108a7f759884c0d890dcf9c71d0ae;
        r_prod[6] = 0x12060dfdd8c1fceaba38ac16288cd391e1bd33e08476edde5dafa859d2bc20c3;
        r_prod[7] = 0x1715421e99f5091ab24230608160f638748e685707ded14d8df5e502eff1c726;
        r_prod[8] = 0x21225c719bfbac3279313676bb52f31d166432319612381d19e29680a23a9e54;
        r_prod[9] = 0x1f5f277e7a112badb02d8cd4794afac553a48acec6eb4895fd4ac287309e0766;
        r_prod[10] = 0x01c6ef7072eae3366e9bac92954116f78dba97d93b34943cdbca7473e03c303c;
        r_prod[11] = 0x2d724a66a4244a6a493bbf6f10e9a1aefce0702e21bc3d1995f4741e0d20e0b6;
        r_prod[12] = 0x287e29cb6788fd94d01ef493dbff1e658619a05ce4fdd1541726bff3cbe8b33b;
        r_prod[13] = 0x106e96134b2e80dc2b4691a8c3ecfc2ea1ef0ab294c5f708cd6774bfeb403009;
        r_prod[14] = 0x2fe84884f541263540ef28f6f103eeccb2413af5378e27d63469466568f56e84;
        r_prod[15] = 0x19a2ee861704322444687829379a8303142709c02feb0f0d56de44c5ab0540e2;
        r_prod[16] = 0x053328f9153fa2d3455c13a25004acd66102e6596877a4952854ee2401233022;

        uint256[] memory U_X = new uint256[](2);
        U_X[0] = 0x03b173e20dfa9ec307f5eb55a0f8da20620d9e184dc69395a7d92cc30551728d;
        U_X[1] = 0x25049ad98282284f65ff8435aec45c47f9a39123eb6a33e8499ae079c504507a;

        uint256 U_u = 0x00000000000000000000000000000001d523e9da28bbf206fe50868f52ca6334;

        uint256 eval_Z;
        uint256[] memory r_prod_unpad;
        (eval_Z, r_prod_unpad) = Step6GrumpkinLib.compute_eval_Z(
            proof.f_W_snark_secondary,
            U_X,
            U_u,
            vk.vk_secondary.S_comm.N,
            vk.vk_secondary.num_vars,
            r_prod,
            Grumpkin.P_MOD,
            Grumpkin.negateBase
        );

        assertEq(eval_Z, 0x2aae6003d78455119a847e9248052677d176d254208021a41b61c2bea6228ea5);
        assertEq(r_prod_unpad[0], 0x2c9493e9d5b214b3cad4bb621544e6001cb1dc10421ede559fb937d89568cd01);
        assertEq(r_prod_unpad[1], 0x1334cd36b6c002cd14bd1ac0e19bfca3b7fe600634fa22ac5d6fc6b271c50ea1);
        assertEq(r_prod_unpad[2], 0x24e56409afcdd7500f2608d82db8f7a607cb1c5246aaa03cb30fdab50e6b0131);
        assertEq(r_prod_unpad[3], 0x27ee3e707f58a066bd5c0c4078fc690de3d108a7f759884c0d890dcf9c71d0ae);
        assertEq(r_prod_unpad[4], 0x12060dfdd8c1fceaba38ac16288cd391e1bd33e08476edde5dafa859d2bc20c3);
        assertEq(r_prod_unpad[5], 0x1715421e99f5091ab24230608160f638748e685707ded14d8df5e502eff1c726);
        assertEq(r_prod_unpad[6], 0x21225c719bfbac3279313676bb52f31d166432319612381d19e29680a23a9e54);
        assertEq(r_prod_unpad[7], 0x1f5f277e7a112badb02d8cd4794afac553a48acec6eb4895fd4ac287309e0766);
        assertEq(r_prod_unpad[8], 0x01c6ef7072eae3366e9bac92954116f78dba97d93b34943cdbca7473e03c303c);
        assertEq(r_prod_unpad[9], 0x2d724a66a4244a6a493bbf6f10e9a1aefce0702e21bc3d1995f4741e0d20e0b6);
        assertEq(r_prod_unpad[10], 0x287e29cb6788fd94d01ef493dbff1e658619a05ce4fdd1541726bff3cbe8b33b);
        assertEq(r_prod_unpad[11], 0x106e96134b2e80dc2b4691a8c3ecfc2ea1ef0ab294c5f708cd6774bfeb403009);
        assertEq(r_prod_unpad[12], 0x2fe84884f541263540ef28f6f103eeccb2413af5378e27d63469466568f56e84);
        assertEq(r_prod_unpad[13], 0x19a2ee861704322444687829379a8303142709c02feb0f0d56de44c5ab0540e2);
        assertEq(r_prod_unpad[14], 0x053328f9153fa2d3455c13a25004acd66102e6596877a4952854ee2401233022);
    }

    /* TODO figure out how to combine unit tests with memory data and integration tests with storage data
    function test_compute_claims_init_audit_primary() public {
        Abstractions.CompressedSnark memory proof = TestUtilities.loadProof();
        uint256 gamma1 = 0x03d5af9141c819677a8e1a3da3e2eefa429ccd3a8dda73108b90adc0de8ae3ff;
        uint256 gamma2 = 0x2439af69afca5c5c4c76eadebc767d89c5eb001f41245d65cd232643ed497998;
        uint256 eval_Z = 0x1e5c2802a0ce24f350f0e77351ba5f77e3b682bf52d55a8df5419662a637f972;

        uint256[] memory r_prod = new uint256[](17);
        r_prod[0] = 0x05837413e5049a37ef21bc91fd21fcce3f89e80202ec70aa01872cc9221d95cd;
        r_prod[1] = 0x17430b827b82e51b14fcdf9511b6a8061d1392d4589b8221dafbae759dd6e070;
        r_prod[2] = 0x0256f4d5674a529ec39e0afba3738d0263cb1d385a563ce608edad719f47d5fd;
        r_prod[3] = 0x00f87554a6caed435bb9e714a355fa73cfd359d5dd8b31fc172ada8cecd7ee30;
        r_prod[4] = 0x29b4dbb7be87a4961e21fe447b03125469077ba2bad896ac2c374aa55be358ab;
        r_prod[5] = 0x1493591a52ded39471fbcd9937537aae9023e77080708f790798671aaa268fc9;
        r_prod[6] = 0x046d5e95bee7ea383f29e0ffa2a6e2816d5b82a75283265e2bc17e63d6ecaeee;
        r_prod[7] = 0x0ea46d83cda8cac4084d937137ab451e89d3fef4b6e25ec00e80fcb8bf8a5308;
        r_prod[8] = 0x26d16ee1e12b5e781327f54a2b89bb7f397e500ec503066b4e37c5e59c372aa1;
        r_prod[9] = 0x2826c37882e6cec0184d476e6e14ac3cb48aee6e233a1ee085c174d53cf1f419;
        r_prod[10] = 0x1b054f124db95f87ec662a5b8ddf47f2b0264e97ef866a05e2a3e0335bce3b16;
        r_prod[11] = 0x0fd296132bf7fc749c44059331d68c735b05f8f746c26e0bf25c3e0a0e6b17b1;
        r_prod[12] = 0x2aede350fab3723fb2ed55ed281f40e4a718f43237901e99264cb09a586661ef;
        r_prod[13] = 0x1a99798029810bbe8a2a5e0d738e8a7c54c010acf84892178463c3222d08b351;
        r_prod[14] = 0x01611bd374a32895d454f4fbe32f051f82e1fef13242ee7951dc6df7848cef97;
        r_prod[15] = 0x019b91a9d375fe46af22a415a0cba65d78d7a605eecf99b3eff27cd508e6282c;
        r_prod[16] = 0x0780ddd1b7bae1a8aff7cf5a352412e2956c573041e9ec3557bca02d7a2e78a1;

        (uint256 claim_init_expected_col, uint256 claim_audit_expected_col) = Step6Lib.compute_claims_init_audit(
            proof.r_W_snark_primary, gamma1, gamma2, eval_Z, r_prod, Bn256.R_MOD, Bn256.negateScalar
        );

        assertEq(claim_init_expected_col, 0x2a5dff3dc7c8c78e109f9533518d82f7a636bc7a533f85bff051d02b76da0c69);
        assertEq(claim_audit_expected_col, 0x035a940099f3735249d008c98dcfd66a38cfd22d2165127a3d4cc6e0a6eb9add);
    }
    */

    /*
    function test_compute_claims_init_audit_secondary() public {
        Abstractions.CompressedSnark memory proof = TestUtilities.loadProof();
        uint256 gamma1 = 0x0cfd566d496cc7d7a714981ac92b8c30666f85ebb8cf92eb25893379a45997f6;
        uint256 gamma2 = 0x157291f097a16f6b025a7a880f2439d50fb9b6aee03fb40b07ef1471f848fce5;
        uint256 eval_Z = 0x2aae6003d78455119a847e9248052677d176d254208021a41b61c2bea6228ea5;

        uint256[] memory r_prod = new uint256[](17);
        r_prod[0] = 0x1725a070098a94cf768334d9b0c3ac4a261682687b39c8e6db7ad3c2901d5e24;
        r_prod[1] = 0x26b72d7895ccf170139a9a71e7da7431d81afd3cd5223969d4794ca8b1366241;
        r_prod[2] = 0x2c9493e9d5b214b3cad4bb621544e6001cb1dc10421ede559fb937d89568cd01;
        r_prod[3] = 0x1334cd36b6c002cd14bd1ac0e19bfca3b7fe600634fa22ac5d6fc6b271c50ea1;
        r_prod[4] = 0x24e56409afcdd7500f2608d82db8f7a607cb1c5246aaa03cb30fdab50e6b0131;
        r_prod[5] = 0x27ee3e707f58a066bd5c0c4078fc690de3d108a7f759884c0d890dcf9c71d0ae;
        r_prod[6] = 0x12060dfdd8c1fceaba38ac16288cd391e1bd33e08476edde5dafa859d2bc20c3;
        r_prod[7] = 0x1715421e99f5091ab24230608160f638748e685707ded14d8df5e502eff1c726;
        r_prod[8] = 0x21225c719bfbac3279313676bb52f31d166432319612381d19e29680a23a9e54;
        r_prod[9] = 0x1f5f277e7a112badb02d8cd4794afac553a48acec6eb4895fd4ac287309e0766;
        r_prod[10] = 0x01c6ef7072eae3366e9bac92954116f78dba97d93b34943cdbca7473e03c303c;
        r_prod[11] = 0x2d724a66a4244a6a493bbf6f10e9a1aefce0702e21bc3d1995f4741e0d20e0b6;
        r_prod[12] = 0x287e29cb6788fd94d01ef493dbff1e658619a05ce4fdd1541726bff3cbe8b33b;
        r_prod[13] = 0x106e96134b2e80dc2b4691a8c3ecfc2ea1ef0ab294c5f708cd6774bfeb403009;
        r_prod[14] = 0x2fe84884f541263540ef28f6f103eeccb2413af5378e27d63469466568f56e84;
        r_prod[15] = 0x19a2ee861704322444687829379a8303142709c02feb0f0d56de44c5ab0540e2;
        r_prod[16] = 0x053328f9153fa2d3455c13a25004acd66102e6596877a4952854ee2401233022;

        (uint256 claim_init_expected_col, uint256 claim_audit_expected_col) = Step6Lib.compute_claims_init_audit(
            proof.f_W_snark_secondary, gamma1, gamma2, eval_Z, r_prod, Grumpkin.P_MOD, Grumpkin.negateBase
        );

        assertEq(claim_init_expected_col, 0x02d6491094023bee34d55a516b6595c78401647257df00bc91b82c1e7d0d8407);
        assertEq(claim_audit_expected_col, 0x2dc367b8dc2caea97125104c11baac4a2ebc325a975000a670b4720f7ce8f967);
    }

    function test_compute_claims_read_write_primary() public {
        Abstractions.CompressedSnark memory proof = TestUtilities.loadProof();
        uint256 gamma1 = 0x03d5af9141c819677a8e1a3da3e2eefa429ccd3a8dda73108b90adc0de8ae3ff;
        uint256 gamma2 = 0x2439af69afca5c5c4c76eadebc767d89c5eb001f41245d65cd232643ed497998;

        (uint256 claim_read_expected_col, uint256 claim_write_expected_col) = Step6GrumpkinLib.compute_claims_read_write(
            proof.r_W_snark_primary, gamma1, gamma2, Bn256.R_MOD, Bn256.negateScalar
        );

        assertEq(claim_read_expected_col, 0x0e88cbd2e50ea3fbafbff374f146efcc0c5debb61140fee245f31906d20ed335);
        assertEq(claim_write_expected_col, 0x10c157ecd0c7f83a7a5a3745b2804b8ee427d0511d7ab90e6090fb830de1f149);
    }

    function test_compute_claims_read_write_secondary() public {
        Abstractions.CompressedSnark memory proof = TestUtilities.loadProof();
        uint256 gamma1 = 0x0cfd566d496cc7d7a714981ac92b8c30666f85ebb8cf92eb25893379a45997f6;
        uint256 gamma2 = 0x157291f097a16f6b025a7a880f2439d50fb9b6aee03fb40b07ef1471f848fce5;

        (uint256 claim_read_expected_col, uint256 claim_write_expected_col) = Step6GrumpkinLib.compute_claims_read_write(
            proof.f_W_snark_secondary, gamma1, gamma2, Grumpkin.P_MOD, Grumpkin.negateBase
        );

        assertEq(claim_read_expected_col, 0x00b94096b775bd4d200ebe116295e74d78814a1e53019667e1e10db44b1399b2);
        assertEq(claim_write_expected_col, 0x2e2b6324003a1eb14b3d1f9fe2bfb9f6823a7b547ced3c273a2b298158aa2a76);
    }*/
}
