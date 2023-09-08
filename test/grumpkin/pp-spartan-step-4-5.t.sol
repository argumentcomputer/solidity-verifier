// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.16;

import "@std/Test.sol";
import "src/NovaVerifierAbstractions.sol";
import "src/verifier/Step4.sol";
import "src/verifier/Step5Grumpkin.sol";

import "test/utils.t.sol";

contract PpSpartanStep4Step5Computations is Test {
    function testStep4Verify() public {
        Abstractions.CompressedSnark memory proof = TestUtilities.loadProof();
        assert(Step4Lib.verify(proof, Bn256.R_MOD, Grumpkin.P_MOD));
    }

    function test_compute_c_primary() public {
        uint16 rounds = 55;
        uint8[] memory state = new uint8[](64);
        state[0] = 0x19;
        state[1] = 0x96;
        state[2] = 0xba;
        state[3] = 0x19;
        state[4] = 0xf4;
        state[5] = 0x00;
        state[6] = 0x10;
        state[7] = 0x3c;
        state[8] = 0x1b;
        state[9] = 0x13;
        state[10] = 0x1b;
        state[11] = 0xe0;
        state[12] = 0x6c;
        state[13] = 0x56;
        state[14] = 0x75;
        state[15] = 0x96;
        state[16] = 0xca;
        state[17] = 0x24;
        state[18] = 0xe9;
        state[19] = 0xaf;
        state[20] = 0xb0;
        state[21] = 0xaf;
        state[22] = 0xaf;
        state[23] = 0x94;
        state[24] = 0x03;
        state[25] = 0x8a;
        state[26] = 0x88;
        state[27] = 0x84;
        state[28] = 0x0c;
        state[29] = 0x59;
        state[30] = 0xbb;
        state[31] = 0xe4;
        state[32] = 0x73;
        state[33] = 0xe3;
        state[34] = 0xca;
        state[35] = 0xd5;
        state[36] = 0xd7;
        state[37] = 0x1e;
        state[38] = 0x81;
        state[39] = 0x32;
        state[40] = 0xbb;
        state[41] = 0x15;
        state[42] = 0xc1;
        state[43] = 0xd1;
        state[44] = 0xc5;
        state[45] = 0x38;
        state[46] = 0x5a;
        state[47] = 0x4b;
        state[48] = 0xd5;
        state[49] = 0x86;
        state[50] = 0x87;
        state[51] = 0x61;
        state[52] = 0xdf;
        state[53] = 0xf8;
        state[54] = 0x71;
        state[55] = 0x1c;
        state[56] = 0xc2;
        state[57] = 0xc3;
        state[58] = 0x14;
        state[59] = 0xfa;
        state[60] = 0x4f;
        state[61] = 0x7b;
        state[62] = 0xf6;
        state[63] = 0x4d;

        KeccakTranscriptLib.KeccakTranscript memory transcript =
            KeccakTranscriptLib.KeccakTranscript(rounds, state, new uint8[](0));

        Abstractions.CompressedSnark memory proof = TestUtilities.loadProof();

        (, uint256 expected) = Step5GrumpkinLib.compute_c_primary(proof.r_W_snark_primary, transcript);
        assertEq(expected, 0x0780ddd1b7bae1a8aff7cf5a352412e2956c573041e9ec3557bca02d7a2e78a1);
    }

    function test_compute_c_secondary() public {
        uint16 rounds = 55;
        uint8[] memory state = new uint8[](64);
        state[0] = 0x9e;
        state[1] = 0x2f;
        state[2] = 0x61;
        state[3] = 0x27;
        state[4] = 0xca;
        state[5] = 0xe4;
        state[6] = 0x64;
        state[7] = 0x8c;
        state[8] = 0xe6;
        state[9] = 0xf6;
        state[10] = 0xfb;
        state[11] = 0x4c;
        state[12] = 0x07;
        state[13] = 0x1a;
        state[14] = 0xea;
        state[15] = 0x06;
        state[16] = 0x49;
        state[17] = 0xdf;
        state[18] = 0x85;
        state[19] = 0x20;
        state[20] = 0x98;
        state[21] = 0xa0;
        state[22] = 0x59;
        state[23] = 0x63;
        state[24] = 0x60;
        state[25] = 0xcc;
        state[26] = 0xef;
        state[27] = 0x7f;
        state[28] = 0xd8;
        state[29] = 0xf1;
        state[30] = 0x54;
        state[31] = 0x63;
        state[32] = 0x8d;
        state[33] = 0x4b;
        state[34] = 0x87;
        state[35] = 0x23;
        state[36] = 0x6b;
        state[37] = 0x1e;
        state[38] = 0xaa;
        state[39] = 0x33;
        state[40] = 0xea;
        state[41] = 0xb1;
        state[42] = 0xde;
        state[43] = 0x64;
        state[44] = 0xbb;
        state[45] = 0x63;
        state[46] = 0xb0;
        state[47] = 0x45;
        state[48] = 0x55;
        state[49] = 0xd6;
        state[50] = 0xea;
        state[51] = 0xad;
        state[52] = 0xc5;
        state[53] = 0x04;
        state[54] = 0x34;
        state[55] = 0x5b;
        state[56] = 0x44;
        state[57] = 0x16;
        state[58] = 0x58;
        state[59] = 0xdc;
        state[60] = 0x51;
        state[61] = 0xfd;
        state[62] = 0x33;
        state[63] = 0xc4;

        KeccakTranscriptLib.KeccakTranscript memory transcript =
            KeccakTranscriptLib.KeccakTranscript(rounds, state, new uint8[](0));

        Abstractions.CompressedSnark memory proof = TestUtilities.loadProof();

        (, uint256 expected) = Step5GrumpkinLib.compute_c_secondary(proof.f_W_snark_secondary, transcript);
        assertEq(expected, 0x053328f9153fa2d3455c13a25004acd66102e6596877a4952854ee2401233022);
    }

    function test_compute_r_prod_secondary() public {
        uint256 c = 0x053328f9153fa2d3455c13a25004acd66102e6596877a4952854ee2401233022;
        uint256[] memory r_sat = new uint256[](17);
        r_sat[0] = 0x25172cbbd1289dde3d5a3ec6806b7408475968df10e71565ca1ba3579b950bab;
        r_sat[1] = 0x1725a070098a94cf768334d9b0c3ac4a261682687b39c8e6db7ad3c2901d5e24;
        r_sat[2] = 0x26b72d7895ccf170139a9a71e7da7431d81afd3cd5223969d4794ca8b1366241;
        r_sat[3] = 0x2c9493e9d5b214b3cad4bb621544e6001cb1dc10421ede559fb937d89568cd01;
        r_sat[4] = 0x1334cd36b6c002cd14bd1ac0e19bfca3b7fe600634fa22ac5d6fc6b271c50ea1;
        r_sat[5] = 0x24e56409afcdd7500f2608d82db8f7a607cb1c5246aaa03cb30fdab50e6b0131;
        r_sat[6] = 0x27ee3e707f58a066bd5c0c4078fc690de3d108a7f759884c0d890dcf9c71d0ae;
        r_sat[7] = 0x12060dfdd8c1fceaba38ac16288cd391e1bd33e08476edde5dafa859d2bc20c3;
        r_sat[8] = 0x1715421e99f5091ab24230608160f638748e685707ded14d8df5e502eff1c726;
        r_sat[9] = 0x21225c719bfbac3279313676bb52f31d166432319612381d19e29680a23a9e54;
        r_sat[10] = 0x1f5f277e7a112badb02d8cd4794afac553a48acec6eb4895fd4ac287309e0766;
        r_sat[11] = 0x01c6ef7072eae3366e9bac92954116f78dba97d93b34943cdbca7473e03c303c;
        r_sat[12] = 0x2d724a66a4244a6a493bbf6f10e9a1aefce0702e21bc3d1995f4741e0d20e0b6;
        r_sat[13] = 0x287e29cb6788fd94d01ef493dbff1e658619a05ce4fdd1541726bff3cbe8b33b;
        r_sat[14] = 0x106e96134b2e80dc2b4691a8c3ecfc2ea1ef0ab294c5f708cd6774bfeb403009;
        r_sat[15] = 0x2fe84884f541263540ef28f6f103eeccb2413af5378e27d63469466568f56e84;
        r_sat[16] = 0x19a2ee861704322444687829379a8303142709c02feb0f0d56de44c5ab0540e2;

        uint256[] memory r_prod = Step5Lib.compute_r_prod(c, r_sat);
        assertEq(r_prod[0], 0x1725a070098a94cf768334d9b0c3ac4a261682687b39c8e6db7ad3c2901d5e24);
        assertEq(r_prod[1], 0x26b72d7895ccf170139a9a71e7da7431d81afd3cd5223969d4794ca8b1366241);
        assertEq(r_prod[2], 0x2c9493e9d5b214b3cad4bb621544e6001cb1dc10421ede559fb937d89568cd01);
        assertEq(r_prod[3], 0x1334cd36b6c002cd14bd1ac0e19bfca3b7fe600634fa22ac5d6fc6b271c50ea1);
        assertEq(r_prod[4], 0x24e56409afcdd7500f2608d82db8f7a607cb1c5246aaa03cb30fdab50e6b0131);
        assertEq(r_prod[5], 0x27ee3e707f58a066bd5c0c4078fc690de3d108a7f759884c0d890dcf9c71d0ae);
        assertEq(r_prod[6], 0x12060dfdd8c1fceaba38ac16288cd391e1bd33e08476edde5dafa859d2bc20c3);
        assertEq(r_prod[7], 0x1715421e99f5091ab24230608160f638748e685707ded14d8df5e502eff1c726);
        assertEq(r_prod[8], 0x21225c719bfbac3279313676bb52f31d166432319612381d19e29680a23a9e54);
        assertEq(r_prod[9], 0x1f5f277e7a112badb02d8cd4794afac553a48acec6eb4895fd4ac287309e0766);
        assertEq(r_prod[10], 0x01c6ef7072eae3366e9bac92954116f78dba97d93b34943cdbca7473e03c303c);
        assertEq(r_prod[11], 0x2d724a66a4244a6a493bbf6f10e9a1aefce0702e21bc3d1995f4741e0d20e0b6);
        assertEq(r_prod[12], 0x287e29cb6788fd94d01ef493dbff1e658619a05ce4fdd1541726bff3cbe8b33b);
        assertEq(r_prod[13], 0x106e96134b2e80dc2b4691a8c3ecfc2ea1ef0ab294c5f708cd6774bfeb403009);
        assertEq(r_prod[14], 0x2fe84884f541263540ef28f6f103eeccb2413af5378e27d63469466568f56e84);
        assertEq(r_prod[15], 0x19a2ee861704322444687829379a8303142709c02feb0f0d56de44c5ab0540e2);
        assertEq(r_prod[16], 0x053328f9153fa2d3455c13a25004acd66102e6596877a4952854ee2401233022);
    }

    function test_compute_r_prod_primary() public {
        uint256 c = 0x0780ddd1b7bae1a8aff7cf5a352412e2956c573041e9ec3557bca02d7a2e78a1;
        uint256[] memory r_sat = new uint256[](17);
        r_sat[0] = 0x144454412fd8764e4aaf2cec1546f1a9f1f154e7de160d033a632ecdfdd5964d;
        r_sat[1] = 0x05837413e5049a37ef21bc91fd21fcce3f89e80202ec70aa01872cc9221d95cd;
        r_sat[2] = 0x17430b827b82e51b14fcdf9511b6a8061d1392d4589b8221dafbae759dd6e070;
        r_sat[3] = 0x0256f4d5674a529ec39e0afba3738d0263cb1d385a563ce608edad719f47d5fd;
        r_sat[4] = 0x00f87554a6caed435bb9e714a355fa73cfd359d5dd8b31fc172ada8cecd7ee30;
        r_sat[5] = 0x29b4dbb7be87a4961e21fe447b03125469077ba2bad896ac2c374aa55be358ab;
        r_sat[6] = 0x1493591a52ded39471fbcd9937537aae9023e77080708f790798671aaa268fc9;
        r_sat[7] = 0x046d5e95bee7ea383f29e0ffa2a6e2816d5b82a75283265e2bc17e63d6ecaeee;
        r_sat[8] = 0x0ea46d83cda8cac4084d937137ab451e89d3fef4b6e25ec00e80fcb8bf8a5308;
        r_sat[9] = 0x26d16ee1e12b5e781327f54a2b89bb7f397e500ec503066b4e37c5e59c372aa1;
        r_sat[10] = 0x2826c37882e6cec0184d476e6e14ac3cb48aee6e233a1ee085c174d53cf1f419;
        r_sat[11] = 0x1b054f124db95f87ec662a5b8ddf47f2b0264e97ef866a05e2a3e0335bce3b16;
        r_sat[12] = 0x0fd296132bf7fc749c44059331d68c735b05f8f746c26e0bf25c3e0a0e6b17b1;
        r_sat[13] = 0x2aede350fab3723fb2ed55ed281f40e4a718f43237901e99264cb09a586661ef;
        r_sat[14] = 0x1a99798029810bbe8a2a5e0d738e8a7c54c010acf84892178463c3222d08b351;
        r_sat[15] = 0x01611bd374a32895d454f4fbe32f051f82e1fef13242ee7951dc6df7848cef97;
        r_sat[16] = 0x019b91a9d375fe46af22a415a0cba65d78d7a605eecf99b3eff27cd508e6282c;

        uint256[] memory r_prod = Step5Lib.compute_r_prod(c, r_sat);
        assertEq(r_prod[0], 0x05837413e5049a37ef21bc91fd21fcce3f89e80202ec70aa01872cc9221d95cd);
        assertEq(r_prod[1], 0x17430b827b82e51b14fcdf9511b6a8061d1392d4589b8221dafbae759dd6e070);
        assertEq(r_prod[2], 0x0256f4d5674a529ec39e0afba3738d0263cb1d385a563ce608edad719f47d5fd);
        assertEq(r_prod[3], 0x00f87554a6caed435bb9e714a355fa73cfd359d5dd8b31fc172ada8cecd7ee30);
        assertEq(r_prod[4], 0x29b4dbb7be87a4961e21fe447b03125469077ba2bad896ac2c374aa55be358ab);
        assertEq(r_prod[5], 0x1493591a52ded39471fbcd9937537aae9023e77080708f790798671aaa268fc9);
        assertEq(r_prod[6], 0x046d5e95bee7ea383f29e0ffa2a6e2816d5b82a75283265e2bc17e63d6ecaeee);
        assertEq(r_prod[7], 0x0ea46d83cda8cac4084d937137ab451e89d3fef4b6e25ec00e80fcb8bf8a5308);
        assertEq(r_prod[8], 0x26d16ee1e12b5e781327f54a2b89bb7f397e500ec503066b4e37c5e59c372aa1);
        assertEq(r_prod[9], 0x2826c37882e6cec0184d476e6e14ac3cb48aee6e233a1ee085c174d53cf1f419);
        assertEq(r_prod[10], 0x1b054f124db95f87ec662a5b8ddf47f2b0264e97ef866a05e2a3e0335bce3b16);
        assertEq(r_prod[11], 0x0fd296132bf7fc749c44059331d68c735b05f8f746c26e0bf25c3e0a0e6b17b1);
        assertEq(r_prod[12], 0x2aede350fab3723fb2ed55ed281f40e4a718f43237901e99264cb09a586661ef);
        assertEq(r_prod[13], 0x1a99798029810bbe8a2a5e0d738e8a7c54c010acf84892178463c3222d08b351);
        assertEq(r_prod[14], 0x01611bd374a32895d454f4fbe32f051f82e1fef13242ee7951dc6df7848cef97);
        assertEq(r_prod[15], 0x019b91a9d375fe46af22a415a0cba65d78d7a605eecf99b3eff27cd508e6282c);
        assertEq(r_prod[16], 0x0780ddd1b7bae1a8aff7cf5a352412e2956c573041e9ec3557bca02d7a2e78a1);
    }

    function test_compute_claims_init_audit_primary() public {
        Abstractions.CompressedSnark memory proof = TestUtilities.loadProof();

        uint256 gamma1 = 0x03d5af9141c819677a8e1a3da3e2eefa429ccd3a8dda73108b90adc0de8ae3ff;
        uint256 gamma2 = 0x2439af69afca5c5c4c76eadebc767d89c5eb001f41245d65cd232643ed497998;

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

        uint256[] memory tau = new uint256[](17);
        tau[0] = 0x1695fc0c0698b7e920d417e58174c018754f581f9044cd68c11cc2363005e185;
        tau[1] = 0x0a6ccda86e557ab8b5e59b7a8c7846f5f0566f3400abec27642881fda5081265;
        tau[2] = 0x0460b24e8674040141696541a62f2b6dfcfbaa97708ab547bc07f32ba186024e;
        tau[3] = 0x04109fec011ecc9677d7a3e349b785743fa0b1dc96b97781ae2ac8627a37f083;
        tau[4] = 0x200ab93f588f3912d94a4553e9c2ae6ee35996c33c41d12d37b387121a2be6d1;
        tau[5] = 0x263c8dc77149bdd56e11eb6fc11eeea047eebeb8be056e1b160004160808af65;
        tau[6] = 0x0cf3a930fcc8e93caad2c5eec517ff5006d4be7254221fff85c58c97f6d35ee5;
        tau[7] = 0x2ba2ec16f6cce727119850fd8b058382a31c326105fe1063f4736b11062df644;
        tau[8] = 0x140bedef3716eff22e6e35591c5a54c6cd7aae70c800183ec559a2ce7302fd6a;
        tau[9] = 0x033f543b39164994196e6186c8dd6ff338eaa9f4fde0da6f969502a75399299f;
        tau[10] = 0x2a6e10ef6ab883dc64c45ebcc6efd99ea862f508b121b1f0ceecf1c77e181769;
        tau[11] = 0x19cce4de222eb81d4dd537befeab6e42d32f810b3360cd3247e39d82c6cf37a2;
        tau[12] = 0x1f12d996682184b2b8df7e855cab2231e22613b95ca3f2fdc0650809e22350df;
        tau[13] = 0x220fe2f07d75e0cc580cf11dc16611f583cc5384842904a98e45cef3b7f409b9;
        tau[14] = 0x2612eb3431d63727a69d698bb7278ddff6214191d842de7d6558a6637cd0efcb;
        tau[15] = 0x05b94d437287ba864fe667b76b45342b7a01de764d49bd8cb3d4c37ceb9ed6f6;
        tau[16] = 0x2e986437477a974632e0ffcd780ddc863a63d78f83c5c9666ebc792ade06dc85;

        (uint256 expected1, uint256 expected2) = Step5Lib.compute_claims_init_audit(
            proof.r_W_snark_primary.eval_row_audit_ts, gamma1, gamma2, r_prod, tau, Bn256.R_MOD, Bn256.negateScalar
        );

        assertEq(expected1, 0x19c2f01a63cb542f8d5d5aa14a6b76ec0ea16fe2829246f35b484f92787a859c);
        assertEq(expected2, 0x2e1cacaf0887f41128120963484ce4bdc618c822db17c929a055218fa56a516d);
    }

    function test_compute_claims_init_audit_secondary() public {
        Abstractions.CompressedSnark memory proof = TestUtilities.loadProof();

        uint256 gamma1 = 0x0cfd566d496cc7d7a714981ac92b8c30666f85ebb8cf92eb25893379a45997f6;
        uint256 gamma2 = 0x157291f097a16f6b025a7a880f2439d50fb9b6aee03fb40b07ef1471f848fce5;

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

        uint256[] memory tau = new uint256[](17);
        tau[0] = 0x1267f50e1d36c3869b23a88ba2e3e6b8046ecaf4c97466284b1acea3d12e40ae;
        tau[1] = 0x20eeca082ad550aceb4ea48aff07fca4b18f2c9b07f8abb6dcfa18a7a68b2177;
        tau[2] = 0x2ff410e0edb1b52f1a525739674ff462a429b63de86ef9f0aba7ea5a1d8edbbd;
        tau[3] = 0x3049f9d9d6a7edead836c0d8b2ec18cfa6c32cf04d6b86c3ba69c9f8fea1030e;
        tau[4] = 0x27fb4d075a305bfb22f2a17235e73c60f8eb90674ef6e730929951a60d4ff29d;
        tau[5] = 0x304ef556679ef95f89b46285aea3c488a9dbd3f883be0c862288032e38f56740;
        tau[6] = 0x0e13a25d86fd10b0c116bad0fe5c8fe093a85e0d5c412d775632729c750e0f4f;
        tau[7] = 0x0832f12f3d7e019a82d6b57317269a584dcca3577311aa8855aa09721f4414da;
        tau[8] = 0x13d5c871aa4865f1ddf690d34c2e7d83c3e026b2b2c00ad280c8dd91849464aa;
        tau[9] = 0x2453c440114ddc0ad7eead8672c14b26da7d3e86a1689c97a49944f12d57ec83;
        tau[10] = 0x2bb71aafb19142aabb9c8a0085e55e6d6f8ba9fc04a9d77cbd03fe65bbad339e;
        tau[11] = 0x0592b27c6e3e7a59ad6701ed27bc4285115098237dbd65b2cf18b1beb42a7b89;
        tau[12] = 0x12cb49defc02cb1fb4eac54d852b139a1a4b4f409e9a02c3fcfce5315039908f;
        tau[13] = 0x112ac9a6d39dbe3e98ddbdcbe35eb8fe014c245513f98074c1e34f8ed1d8c16b;
        tau[14] = 0x1888112a08ecbc29f7d3212e52cff7b57a08ed945ada88c35738b7824c08272d;
        tau[15] = 0x227a2b43ee513e8e880741190db9f37d801cd332f59d5a08a06cb4ede201d589;
        tau[16] = 0x2c363a743c3118e6486e7a66a8dd4c02a904051fe0241bb01df569c10015a8dd;

        (uint256 expected1, uint256 expected2) = Step5Lib.compute_claims_init_audit(
            proof.f_W_snark_secondary.eval_row_audit_ts,
            gamma1,
            gamma2,
            r_prod,
            tau,
            Grumpkin.P_MOD,
            Grumpkin.negateBase
        );

        assertEq(expected1, 0x1e7009e7b41c1625e52ac027343774098d66be46008ca88136d6c9631863baff);
        assertEq(expected2, 0x0cb434af546a90d27937ec66b5953f110919165d2efad3b4fbd013a11f0f34d9);
    }

    function test_compute_claims_read_write_primary() public {
        Abstractions.CompressedSnark memory proof = TestUtilities.loadProof();

        uint256 gamma1 = 0x03d5af9141c819677a8e1a3da3e2eefa429ccd3a8dda73108b90adc0de8ae3ff;
        uint256 gamma2 = 0x2439af69afca5c5c4c76eadebc767d89c5eb001f41245d65cd232643ed497998;

        (uint256 expected1, uint256 expected2) = Step5GrumpkinLib.compute_claims_read_write(
            proof.r_W_snark_primary, gamma1, gamma2, Bn256.R_MOD, Bn256.negateScalar
        );

        assertEq(expected1, 0x0f4e4c4378589a21c2e9ee6f122fee33ca4402ab91cb971b3def236a0557b88a);
        assertEq(expected2, 0x1186d85d6411ee608d84323fd36949f6a20de7469e055147588d05e6412ad69e);
    }

    function test_compute_claims_read_write_secondary() public {
        Abstractions.CompressedSnark memory proof = TestUtilities.loadProof();

        uint256 gamma1 = 0x0cfd566d496cc7d7a714981ac92b8c30666f85ebb8cf92eb25893379a45997f6;
        uint256 gamma2 = 0x157291f097a16f6b025a7a880f2439d50fb9b6aee03fb40b07ef1471f848fce5;

        (uint256 expected1, uint256 expected2) = Step5GrumpkinLib.compute_claims_read_write(
            proof.f_W_snark_secondary, gamma1, gamma2, Grumpkin.P_MOD, Grumpkin.negateBase
        );

        assertEq(expected1, 0x0e49070ab4ba2873cf3a15431f2c619ebc041689f9e58350451f190485afdd32);
        assertEq(expected2, 0x0b56db251c4ce9ae4218311b1dd4dbea2e3bdd2ebb5f5e826148a8babac970af);
    }

    function test_compute_u_vec_items_primary() public {
        Abstractions.CompressedSnark memory proof = TestUtilities.loadProof();
        Abstractions.VerifierKey memory public_parameters = TestUtilities.loadPublicParameters();

        uint16 rounds = 56;
        uint8[] memory state = new uint8[](64);
        state[0] = 0xc4;
        state[1] = 0x8d;
        state[2] = 0x2d;
        state[3] = 0x52;
        state[4] = 0xb1;
        state[5] = 0xea;
        state[6] = 0xc4;
        state[7] = 0x23;
        state[8] = 0xcc;
        state[9] = 0x91;
        state[10] = 0xa5;
        state[11] = 0x3d;
        state[12] = 0x58;
        state[13] = 0x9c;
        state[14] = 0xe7;
        state[15] = 0x71;
        state[16] = 0x70;
        state[17] = 0x17;
        state[18] = 0x41;
        state[19] = 0x3c;
        state[20] = 0x53;
        state[21] = 0xa7;
        state[22] = 0x10;
        state[23] = 0xe7;
        state[24] = 0x61;
        state[25] = 0x0e;
        state[26] = 0x37;
        state[27] = 0x1b;
        state[28] = 0x63;
        state[29] = 0xc4;
        state[30] = 0xe6;
        state[31] = 0xa6;
        state[32] = 0x62;
        state[33] = 0x02;
        state[34] = 0x91;
        state[35] = 0xc1;
        state[36] = 0xe7;
        state[37] = 0x8d;
        state[38] = 0x3f;
        state[39] = 0x6d;
        state[40] = 0xbc;
        state[41] = 0x92;
        state[42] = 0x8b;
        state[43] = 0x61;
        state[44] = 0xbc;
        state[45] = 0x7c;
        state[46] = 0x6e;
        state[47] = 0x2b;
        state[48] = 0xfe;
        state[49] = 0x29;
        state[50] = 0x9b;
        state[51] = 0x42;
        state[52] = 0xd5;
        state[53] = 0x59;
        state[54] = 0x62;
        state[55] = 0xdf;
        state[56] = 0xec;
        state[57] = 0x30;
        state[58] = 0x0b;
        state[59] = 0x69;
        state[60] = 0xe0;
        state[61] = 0x41;
        state[62] = 0xcf;
        state[63] = 0x54;

        KeccakTranscriptLib.KeccakTranscript memory transcript =
            KeccakTranscriptLib.KeccakTranscript(rounds, state, new uint8[](0));

        uint256[] memory r_sat = new uint256[](17);
        r_sat[0] = 0x144454412fd8764e4aaf2cec1546f1a9f1f154e7de160d033a632ecdfdd5964d;
        r_sat[1] = 0x05837413e5049a37ef21bc91fd21fcce3f89e80202ec70aa01872cc9221d95cd;
        r_sat[2] = 0x17430b827b82e51b14fcdf9511b6a8061d1392d4589b8221dafbae759dd6e070;
        r_sat[3] = 0x0256f4d5674a529ec39e0afba3738d0263cb1d385a563ce608edad719f47d5fd;
        r_sat[4] = 0x00f87554a6caed435bb9e714a355fa73cfd359d5dd8b31fc172ada8cecd7ee30;
        r_sat[5] = 0x29b4dbb7be87a4961e21fe447b03125469077ba2bad896ac2c374aa55be358ab;
        r_sat[6] = 0x1493591a52ded39471fbcd9937537aae9023e77080708f790798671aaa268fc9;
        r_sat[7] = 0x046d5e95bee7ea383f29e0ffa2a6e2816d5b82a75283265e2bc17e63d6ecaeee;
        r_sat[8] = 0x0ea46d83cda8cac4084d937137ab451e89d3fef4b6e25ec00e80fcb8bf8a5308;
        r_sat[9] = 0x26d16ee1e12b5e781327f54a2b89bb7f397e500ec503066b4e37c5e59c372aa1;
        r_sat[10] = 0x2826c37882e6cec0184d476e6e14ac3cb48aee6e233a1ee085c174d53cf1f419;
        r_sat[11] = 0x1b054f124db95f87ec662a5b8ddf47f2b0264e97ef866a05e2a3e0335bce3b16;
        r_sat[12] = 0x0fd296132bf7fc749c44059331d68c735b05f8f746c26e0bf25c3e0a0e6b17b1;
        r_sat[13] = 0x2aede350fab3723fb2ed55ed281f40e4a718f43237901e99264cb09a586661ef;
        r_sat[14] = 0x1a99798029810bbe8a2a5e0d738e8a7c54c010acf84892178463c3222d08b351;
        r_sat[15] = 0x01611bd374a32895d454f4fbe32f051f82e1fef13242ee7951dc6df7848cef97;
        r_sat[16] = 0x019b91a9d375fe46af22a415a0cba65d78d7a605eecf99b3eff27cd508e6282c;

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

        (, PolyEvalInstanceLib.PolyEvalInstance[] memory expected) = Step5GrumpkinLib.compute_u_vec_items_primary(
            proof.r_W_snark_primary, public_parameters.vk_primary, transcript, r_sat, r_prod
        );

        assertEq(expected[0].c_x, 0x225b5ed62a6252b52c48074ea887026ad925357d7bbd259875cecc0db9d6ecc7);
        assertEq(expected[0].c_y, 0x05eca5f09c13e5b373b5a9ceaf2414845d8f52392ae90f41de6eb41b08387356);
        assertEq(expected[0].e, 0x186f7f961e265c88569e4360b15d71d9fba3a61e3dce74c3096756292fd35a9f);
        assertEq(expected[1].c_x, 0x225b5ed62a6252b52c48074ea887026ad925357d7bbd259875cecc0db9d6ecc7);
        assertEq(expected[1].c_y, 0x05eca5f09c13e5b373b5a9ceaf2414845d8f52392ae90f41de6eb41b08387356);
        assertEq(expected[1].e, 0x2038e67614a1ff8e6b4aa9fec97740b2c146a88103dbac18372455d76aa81b87);
        assertEq(expected[2].c_x, 0x225b5ed62a6252b52c48074ea887026ad925357d7bbd259875cecc0db9d6ecc7);
        assertEq(expected[2].c_y, 0x05eca5f09c13e5b373b5a9ceaf2414845d8f52392ae90f41de6eb41b08387356);
        assertEq(expected[2].e, 0x173fdc325f99a0801ed6a4e396d176ba6080c6e83f0898242abaef64108d108f);
        assertEq(expected[3].c_x, 0x22850dc71b502bc6c23a442a7ce89c26942624aec88aecd46297c3a1ae7a93ce);
        assertEq(expected[3].c_y, 0x1eb65c6e2178b3ded9d6b2cc8e755fc062d6a34fe5fc4dc5920dfd4588e4357a);
        assertEq(expected[3].e, 0x0998a56ce3fe9f0fe8e1fcbc2f2d4f8c003fd6444fa20870a0061201ea13b2f5);
    }

    function test_compute_u_vec_items_secondary() public {
        Abstractions.CompressedSnark memory proof = TestUtilities.loadProof();
        Abstractions.VerifierKey memory public_parameters = TestUtilities.loadPublicParameters();

        uint16 rounds = 56;
        uint8[] memory state = new uint8[](64);
        state[0] = 0x27;
        state[1] = 0x3d;
        state[2] = 0x9e;
        state[3] = 0xc3;
        state[4] = 0xde;
        state[5] = 0x90;
        state[6] = 0x09;
        state[7] = 0xbf;
        state[8] = 0xd3;
        state[9] = 0x61;
        state[10] = 0x90;
        state[11] = 0xbb;
        state[12] = 0x78;
        state[13] = 0xeb;
        state[14] = 0x0a;
        state[15] = 0xb4;
        state[16] = 0xae;
        state[17] = 0x40;
        state[18] = 0x8e;
        state[19] = 0xd7;
        state[20] = 0x58;
        state[21] = 0xd0;
        state[22] = 0x4a;
        state[23] = 0x78;
        state[24] = 0xd8;
        state[25] = 0x54;
        state[26] = 0x94;
        state[27] = 0x80;
        state[28] = 0x8e;
        state[29] = 0x08;
        state[30] = 0xa8;
        state[31] = 0x89;
        state[32] = 0x53;
        state[33] = 0xeb;
        state[34] = 0x05;
        state[35] = 0x29;
        state[36] = 0x51;
        state[37] = 0xec;
        state[38] = 0xda;
        state[39] = 0x1f;
        state[40] = 0x59;
        state[41] = 0xe6;
        state[42] = 0xf4;
        state[43] = 0xda;
        state[44] = 0xec;
        state[45] = 0x99;
        state[46] = 0x4a;
        state[47] = 0x6b;
        state[48] = 0x52;
        state[49] = 0xb2;
        state[50] = 0xd6;
        state[51] = 0x15;
        state[52] = 0xf4;
        state[53] = 0x1f;
        state[54] = 0xd6;
        state[55] = 0xef;
        state[56] = 0xf4;
        state[57] = 0x76;
        state[58] = 0xea;
        state[59] = 0x29;
        state[60] = 0xdf;
        state[61] = 0x59;
        state[62] = 0xba;
        state[63] = 0x53;

        KeccakTranscriptLib.KeccakTranscript memory transcript =
            KeccakTranscriptLib.KeccakTranscript(rounds, state, new uint8[](0));

        uint256[] memory r_sat = new uint256[](17);
        r_sat[0] = 0x25172cbbd1289dde3d5a3ec6806b7408475968df10e71565ca1ba3579b950bab;
        r_sat[1] = 0x1725a070098a94cf768334d9b0c3ac4a261682687b39c8e6db7ad3c2901d5e24;
        r_sat[2] = 0x26b72d7895ccf170139a9a71e7da7431d81afd3cd5223969d4794ca8b1366241;
        r_sat[3] = 0x2c9493e9d5b214b3cad4bb621544e6001cb1dc10421ede559fb937d89568cd01;
        r_sat[4] = 0x1334cd36b6c002cd14bd1ac0e19bfca3b7fe600634fa22ac5d6fc6b271c50ea1;
        r_sat[5] = 0x24e56409afcdd7500f2608d82db8f7a607cb1c5246aaa03cb30fdab50e6b0131;
        r_sat[6] = 0x27ee3e707f58a066bd5c0c4078fc690de3d108a7f759884c0d890dcf9c71d0ae;
        r_sat[7] = 0x12060dfdd8c1fceaba38ac16288cd391e1bd33e08476edde5dafa859d2bc20c3;
        r_sat[8] = 0x1715421e99f5091ab24230608160f638748e685707ded14d8df5e502eff1c726;
        r_sat[9] = 0x21225c719bfbac3279313676bb52f31d166432319612381d19e29680a23a9e54;
        r_sat[10] = 0x1f5f277e7a112badb02d8cd4794afac553a48acec6eb4895fd4ac287309e0766;
        r_sat[11] = 0x01c6ef7072eae3366e9bac92954116f78dba97d93b34943cdbca7473e03c303c;
        r_sat[12] = 0x2d724a66a4244a6a493bbf6f10e9a1aefce0702e21bc3d1995f4741e0d20e0b6;
        r_sat[13] = 0x287e29cb6788fd94d01ef493dbff1e658619a05ce4fdd1541726bff3cbe8b33b;
        r_sat[14] = 0x106e96134b2e80dc2b4691a8c3ecfc2ea1ef0ab294c5f708cd6774bfeb403009;
        r_sat[15] = 0x2fe84884f541263540ef28f6f103eeccb2413af5378e27d63469466568f56e84;
        r_sat[16] = 0x19a2ee861704322444687829379a8303142709c02feb0f0d56de44c5ab0540e2;

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

        (, PolyEvalInstanceLib.PolyEvalInstance[] memory expected) = Step5GrumpkinLib.compute_u_vec_items_secondary(
            proof.f_W_snark_secondary, public_parameters.vk_secondary, transcript, r_sat, r_prod
        );

        assertEq(expected[0].c_x, 0x2d55fc82ceddb996f78b7b30aec725b7ff7c9487a1c419c451483c964ca4f758);
        assertEq(expected[0].c_y, 0x3006ae25186226af4f8ca0586a7e3cd80cee52efd4d5ca162652da31e0030db9);
        assertEq(expected[0].e, 0x226815ad4c481c399fdc2ddfa7c916769aeb5d6e39bd30ea2676b738ff7db9d5);
        assertEq(expected[1].c_x, 0x2d55fc82ceddb996f78b7b30aec725b7ff7c9487a1c419c451483c964ca4f758);
        assertEq(expected[1].c_y, 0x3006ae25186226af4f8ca0586a7e3cd80cee52efd4d5ca162652da31e0030db9);
        assertEq(expected[1].e, 0x20f9914f54e7717576fa749ff16aecd487863ff1c11162499f43c793e44c0a22);
        assertEq(expected[2].c_x, 0x2d55fc82ceddb996f78b7b30aec725b7ff7c9487a1c419c451483c964ca4f758);
        assertEq(expected[2].c_y, 0x3006ae25186226af4f8ca0586a7e3cd80cee52efd4d5ca162652da31e0030db9);
        assertEq(expected[2].e, 0x20a26a182fc955d93811ab4e54caeb2de5e66193342ae5e35347c776c47836a9);
        assertEq(expected[3].c_x, 0x1ec29657919b0f194b6a69c8265a59633793a45893b7a2b674c6f68e58825c74);
        assertEq(expected[3].c_y, 0x0b3d096f0d640f6dec627235a3dc9f3f8e9f5ca0650e42eb3c16b45252512c5c);
        assertEq(expected[3].e, 0x2513125d4fbe8e638298ed83b477b0b40b06cd1e0fa867700bd0544596a73991);
    }
}
