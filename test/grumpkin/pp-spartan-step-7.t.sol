// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.16;

import "@std/Test.sol";
import "src/NovaVerifierAbstractions.sol";
import "src/verifier/Step7.sol";
import "src/verifier/Step7Grumpkin.sol";
import "src/blocks/PolyEvalInstance.sol";

import "test/utils.t.sol";

contract PpSpartanStep7Computations is Test {
    function test_compute_c_primary() public {
        Abstractions.CompressedSnark memory proof = TestUtilities.loadProof();

        uint16 rounds = 58;
        uint8[] memory state = new uint8[](64);
        state[0] = 0x1e;
        state[1] = 0xdc;
        state[2] = 0xa8;
        state[3] = 0x8a;
        state[4] = 0x9d;
        state[5] = 0xfd;
        state[6] = 0xda;
        state[7] = 0x18;
        state[8] = 0x15;
        state[9] = 0xff;
        state[10] = 0xd0;
        state[11] = 0x26;
        state[12] = 0x14;
        state[13] = 0xb6;
        state[14] = 0xa0;
        state[15] = 0x03;
        state[16] = 0xc6;
        state[17] = 0xa3;
        state[18] = 0x2d;
        state[19] = 0xaf;
        state[20] = 0x26;
        state[21] = 0x8c;
        state[22] = 0x10;
        state[23] = 0xee;
        state[24] = 0x4d;
        state[25] = 0x93;
        state[26] = 0x3e;
        state[27] = 0xec;
        state[28] = 0xa2;
        state[29] = 0x39;
        state[30] = 0xb6;
        state[31] = 0x72;
        state[32] = 0x63;
        state[33] = 0xdb;
        state[34] = 0x6e;
        state[35] = 0xff;
        state[36] = 0x15;
        state[37] = 0x14;
        state[38] = 0xb4;
        state[39] = 0x07;
        state[40] = 0xfe;
        state[41] = 0x11;
        state[42] = 0x86;
        state[43] = 0xe9;
        state[44] = 0x7e;
        state[45] = 0x6c;
        state[46] = 0x98;
        state[47] = 0xc5;
        state[48] = 0x80;
        state[49] = 0x07;
        state[50] = 0xbc;
        state[51] = 0xa5;
        state[52] = 0xea;
        state[53] = 0x90;
        state[54] = 0x1f;
        state[55] = 0xe0;
        state[56] = 0xd2;
        state[57] = 0x3f;
        state[58] = 0x6c;
        state[59] = 0xb2;
        state[60] = 0xaa;
        state[61] = 0xfa;
        state[62] = 0x16;
        state[63] = 0xc0;

        KeccakTranscriptLib.KeccakTranscript memory transcript =
            KeccakTranscriptLib.KeccakTranscript(rounds, state, new uint8[](0));

        (, uint256 expected) = Step7GrumpkinLib.compute_c_primary(proof.r_W_snark_primary, transcript);

        assertEq(expected, 0x1acafdcb84c47d71973e472fff62b7c5c9ab8ef5c4a6198c582d7d99427cef9b);
    }

    function test_compute_c_secondary() public {
        Abstractions.CompressedSnark memory proof = TestUtilities.loadProof();

        uint16 rounds = 58;
        uint8[] memory state = new uint8[](64);
        state[0] = 0x57;
        state[1] = 0x1b;
        state[2] = 0x7f;
        state[3] = 0xd9;
        state[4] = 0x5b;
        state[5] = 0x58;
        state[6] = 0xd5;
        state[7] = 0x28;
        state[8] = 0x45;
        state[9] = 0x24;
        state[10] = 0x1c;
        state[11] = 0x3a;
        state[12] = 0x65;
        state[13] = 0xf9;
        state[14] = 0xed;
        state[15] = 0x84;
        state[16] = 0xff;
        state[17] = 0x54;
        state[18] = 0xf2;
        state[19] = 0x0f;
        state[20] = 0x90;
        state[21] = 0xae;
        state[22] = 0x6c;
        state[23] = 0xa4;
        state[24] = 0xa5;
        state[25] = 0xd1;
        state[26] = 0xe3;
        state[27] = 0x86;
        state[28] = 0xa1;
        state[29] = 0x31;
        state[30] = 0xef;
        state[31] = 0xaa;
        state[32] = 0x87;
        state[33] = 0x0e;
        state[34] = 0xe2;
        state[35] = 0x31;
        state[36] = 0xe7;
        state[37] = 0xc3;
        state[38] = 0x86;
        state[39] = 0x41;
        state[40] = 0x7d;
        state[41] = 0x9d;
        state[42] = 0x38;
        state[43] = 0xcf;
        state[44] = 0x0e;
        state[45] = 0x22;
        state[46] = 0x90;
        state[47] = 0x2d;
        state[48] = 0x84;
        state[49] = 0x1f;
        state[50] = 0x2f;
        state[51] = 0x03;
        state[52] = 0x9e;
        state[53] = 0x9f;
        state[54] = 0xe2;
        state[55] = 0xc2;
        state[56] = 0xfd;
        state[57] = 0xd3;
        state[58] = 0xab;
        state[59] = 0x35;
        state[60] = 0xa0;
        state[61] = 0xf7;
        state[62] = 0x00;
        state[63] = 0x3a;

        KeccakTranscriptLib.KeccakTranscript memory transcript =
            KeccakTranscriptLib.KeccakTranscript(rounds, state, new uint8[](0));

        (, uint256 expected) = Step7GrumpkinLib.compute_c_secondary(proof.f_W_snark_secondary, transcript);

        assertEq(expected, 0x2e8f8a893be2cb407f2ab721fb17adce6170f3c4b5f9817b5afff03046c1afce);
    }

    function test_compute_u_secondary() public {
        Abstractions.CompressedSnark memory proof = TestUtilities.loadProof();
        (Abstractions.VerifierKey memory vk,,) = TestUtilities.loadPublicParameters();

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

        uint256 u_comm_e_x = 0x1a36a923eb54c2958c1d8f71a8c0a5cbf23fd14b97171736c92de181a2c2271a;
        uint256 u_comm_e_y = 0x2c00e3ae72c8f5121351cbc7059eeb7e8f98e93c74812429cdcac2397b51843d;

        uint256 c = 0x2e8f8a893be2cb407f2ab721fb17adce6170f3c4b5f9817b5afff03046c1afce;

        PolyEvalInstanceLib.PolyEvalInstance memory expected = Step7GrumpkinLib.compute_u_secondary(
            proof.f_W_snark_secondary, vk.vk_secondary, u_comm_e_x, u_comm_e_y, r_sat, c
        );
        assertEq(expected.e, 0x0088669e792dcb64cc9598dbed28620719bebd0129650d26e886bc06dc43d852);
        assertEq(expected.c_x, 0x27f88af1eec0500e566c3e25d6147661e7456b52b2f023f91f421270873d2f92);
        assertEq(expected.c_y, 0x03de91147588dfc46735f07ff26fbb05e680de5ee4aa35cd9af42d75e8eee4f7);
    }

    function test_compute_u_primary() public {
        Abstractions.CompressedSnark memory proof = TestUtilities.loadProof();
        (Abstractions.VerifierKey memory vk,,) = TestUtilities.loadPublicParameters();

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

        uint256 u_comm_e_x = 0x0dc7ac106c12a5f7a8b2fdc5a066bc3b31e263b1b0b0578e46700a2ad7836257;
        uint256 u_comm_e_y = 0x21b2f712c2fc970c0a6802243982f8efa9041bd4ca2d53134a1664703c554c3b;

        uint256 c = 0x1acafdcb84c47d71973e472fff62b7c5c9ab8ef5c4a6198c582d7d99427cef9b;

        PolyEvalInstanceLib.PolyEvalInstance memory expected =
            Step7GrumpkinLib.compute_u_primary(proof.r_W_snark_primary, vk.vk_primary, u_comm_e_x, u_comm_e_y, r_sat, c);
        assertEq(expected.e, 0x101e200bd035b257fe90e8d2d1c0df37860d3f49effed18058414ff5ec3d465c);
        assertEq(expected.c_x, 0x2829fe3f56f139c48a22a3ae7c35a777425e3f578cc81038c7cb0ec519839f6e);
        assertEq(expected.c_y, 0x27a0a9319530016b2f890c1cb0d8e956e715477366e11cef729c4aff9a969cfc);
    }

    function test_compute_rho_primary() public {
        uint16 rounds = 59;
        uint8[] memory state = new uint8[](64);
        state[0] = 0xf6;
        state[1] = 0x45;
        state[2] = 0x42;
        state[3] = 0x53;
        state[4] = 0xc3;
        state[5] = 0x26;
        state[6] = 0x05;
        state[7] = 0xf2;
        state[8] = 0x39;
        state[9] = 0xb0;
        state[10] = 0xf9;
        state[11] = 0x53;
        state[12] = 0xe5;
        state[13] = 0x01;
        state[14] = 0x33;
        state[15] = 0x74;
        state[16] = 0x71;
        state[17] = 0xd2;
        state[18] = 0x99;
        state[19] = 0x5a;
        state[20] = 0x44;
        state[21] = 0x67;
        state[22] = 0x6d;
        state[23] = 0x0d;
        state[24] = 0xd1;
        state[25] = 0xba;
        state[26] = 0x49;
        state[27] = 0x05;
        state[28] = 0xe7;
        state[29] = 0xe2;
        state[30] = 0xa5;
        state[31] = 0x1c;
        state[32] = 0x5c;
        state[33] = 0x71;
        state[34] = 0xb5;
        state[35] = 0x8b;
        state[36] = 0x82;
        state[37] = 0x50;
        state[38] = 0xb9;
        state[39] = 0x41;
        state[40] = 0x14;
        state[41] = 0x17;
        state[42] = 0xfa;
        state[43] = 0xee;
        state[44] = 0x86;
        state[45] = 0xa9;
        state[46] = 0x39;
        state[47] = 0x81;
        state[48] = 0x3e;
        state[49] = 0x67;
        state[50] = 0x8f;
        state[51] = 0x4a;
        state[52] = 0xe7;
        state[53] = 0xf8;
        state[54] = 0xe9;
        state[55] = 0x9d;
        state[56] = 0xd3;
        state[57] = 0x90;
        state[58] = 0x13;
        state[59] = 0x0e;
        state[60] = 0x3f;
        state[61] = 0xd6;
        state[62] = 0xf6;
        state[63] = 0x53;

        KeccakTranscriptLib.KeccakTranscript memory transcript =
            KeccakTranscriptLib.KeccakTranscript(rounds, state, new uint8[](0));

        (, uint256 rho) = Step7GrumpkinLib.compute_rho_primary(transcript);
        assertEq(rho, 0x1dbb16d7c99fa0c175099f6cd1bcbf9565e9d388c5c94a277eeef3d51df045cc);
    }

    function test_compute_rho_secondary() public {
        uint16 rounds = 59;
        uint8[] memory state = new uint8[](64);
        state[0] = 0x4e;
        state[1] = 0x36;
        state[2] = 0xee;
        state[3] = 0xe3;
        state[4] = 0xa1;
        state[5] = 0x1a;
        state[6] = 0x73;
        state[7] = 0xf9;
        state[8] = 0x24;
        state[9] = 0x5e;
        state[10] = 0x70;
        state[11] = 0xb6;
        state[12] = 0xf4;
        state[13] = 0xa6;
        state[14] = 0x5c;
        state[15] = 0x31;
        state[16] = 0xdd;
        state[17] = 0xd9;
        state[18] = 0x06;
        state[19] = 0x03;
        state[20] = 0x72;
        state[21] = 0x20;
        state[22] = 0xad;
        state[23] = 0xc5;
        state[24] = 0x72;
        state[25] = 0xc6;
        state[26] = 0x00;
        state[27] = 0x40;
        state[28] = 0x83;
        state[29] = 0xa1;
        state[30] = 0x29;
        state[31] = 0x12;
        state[32] = 0xe3;
        state[33] = 0xe5;
        state[34] = 0xdf;
        state[35] = 0x07;
        state[36] = 0x3a;
        state[37] = 0x26;
        state[38] = 0x51;
        state[39] = 0xc1;
        state[40] = 0x65;
        state[41] = 0x7e;
        state[42] = 0x52;
        state[43] = 0x14;
        state[44] = 0x6c;
        state[45] = 0x77;
        state[46] = 0xf0;
        state[47] = 0x64;
        state[48] = 0x8b;
        state[49] = 0xf6;
        state[50] = 0x84;
        state[51] = 0x25;
        state[52] = 0xf3;
        state[53] = 0x44;
        state[54] = 0x4f;
        state[55] = 0x40;
        state[56] = 0x51;
        state[57] = 0xf3;
        state[58] = 0xf1;
        state[59] = 0xd4;
        state[60] = 0xef;
        state[61] = 0xf3;
        state[62] = 0xd1;
        state[63] = 0xec;

        KeccakTranscriptLib.KeccakTranscript memory transcript =
            KeccakTranscriptLib.KeccakTranscript(rounds, state, new uint8[](0));

        (, uint256 rho) = Step7GrumpkinLib.compute_rho_secondary(transcript);
        assertEq(rho, 0x151a9a94b2adc8bc8a39f87e2dc5e3978ee1ec7f2f77e575c858b509faf672b6);
    }

    function test_compute_sc_proof_batch_verification_input_secondary() public {
        PolyEvalInstanceLib.PolyEvalInstance[] memory u_vec = new PolyEvalInstanceLib.PolyEvalInstance[](7);

        uint256[] memory X = new uint256[](17);
        X[0] = 0x1267f50e1d36c3869b23a88ba2e3e6b8046ecaf4c97466284b1acea3d12e40ae;
        X[1] = 0x20eeca082ad550aceb4ea48aff07fca4b18f2c9b07f8abb6dcfa18a7a68b2177;
        X[2] = 0x2ff410e0edb1b52f1a525739674ff462a429b63de86ef9f0aba7ea5a1d8edbbd;
        X[3] = 0x3049f9d9d6a7edead836c0d8b2ec18cfa6c32cf04d6b86c3ba69c9f8fea1030e;
        X[4] = 0x27fb4d075a305bfb22f2a17235e73c60f8eb90674ef6e730929951a60d4ff29d;
        X[5] = 0x304ef556679ef95f89b46285aea3c488a9dbd3f883be0c862288032e38f56740;
        X[6] = 0x0e13a25d86fd10b0c116bad0fe5c8fe093a85e0d5c412d775632729c750e0f4f;
        X[7] = 0x0832f12f3d7e019a82d6b57317269a584dcca3577311aa8855aa09721f4414da;
        X[8] = 0x13d5c871aa4865f1ddf690d34c2e7d83c3e026b2b2c00ad280c8dd91849464aa;
        X[9] = 0x2453c440114ddc0ad7eead8672c14b26da7d3e86a1689c97a49944f12d57ec83;
        X[10] = 0x2bb71aafb19142aabb9c8a0085e55e6d6f8ba9fc04a9d77cbd03fe65bbad339e;
        X[11] = 0x0592b27c6e3e7a59ad6701ed27bc4285115098237dbd65b2cf18b1beb42a7b89;
        X[12] = 0x12cb49defc02cb1fb4eac54d852b139a1a4b4f409e9a02c3fcfce5315039908f;
        X[13] = 0x112ac9a6d39dbe3e98ddbdcbe35eb8fe014c245513f98074c1e34f8ed1d8c16b;
        X[14] = 0x1888112a08ecbc29f7d3212e52cff7b57a08ed945ada88c35738b7824c08272d;
        X[15] = 0x227a2b43ee513e8e880741190db9f37d801cd332f59d5a08a06cb4ede201d589;
        X[16] = 0x2c363a743c3118e6486e7a66a8dd4c02a904051fe0241bb01df569c10015a8dd;
        u_vec[0] = PolyEvalInstanceLib.PolyEvalInstance(
            0x0e8422ef20e671749e06a46ae15ba1e703b55a1d8737c5e6a8f5dd216e3a6822,
            0x275b128cdcaba9c86c30fc720bd10824cc932b8d3a1020d4f04ecafa5d3280d5,
            X,
            0x208f3bc09df6f6eb01595a7d7708a2f7d8dafff813f123a4abdd99dfef2ff3aa
        );

        X = new uint256[](17);
        X[0] = 0x25172cbbd1289dde3d5a3ec6806b7408475968df10e71565ca1ba3579b950bab;
        X[1] = 0x1725a070098a94cf768334d9b0c3ac4a261682687b39c8e6db7ad3c2901d5e24;
        X[2] = 0x26b72d7895ccf170139a9a71e7da7431d81afd3cd5223969d4794ca8b1366241;
        X[3] = 0x2c9493e9d5b214b3cad4bb621544e6001cb1dc10421ede559fb937d89568cd01;
        X[4] = 0x1334cd36b6c002cd14bd1ac0e19bfca3b7fe600634fa22ac5d6fc6b271c50ea1;
        X[5] = 0x24e56409afcdd7500f2608d82db8f7a607cb1c5246aaa03cb30fdab50e6b0131;
        X[6] = 0x27ee3e707f58a066bd5c0c4078fc690de3d108a7f759884c0d890dcf9c71d0ae;
        X[7] = 0x12060dfdd8c1fceaba38ac16288cd391e1bd33e08476edde5dafa859d2bc20c3;
        X[8] = 0x1715421e99f5091ab24230608160f638748e685707ded14d8df5e502eff1c726;
        X[9] = 0x21225c719bfbac3279313676bb52f31d166432319612381d19e29680a23a9e54;
        X[10] = 0x1f5f277e7a112badb02d8cd4794afac553a48acec6eb4895fd4ac287309e0766;
        X[11] = 0x01c6ef7072eae3366e9bac92954116f78dba97d93b34943cdbca7473e03c303c;
        X[12] = 0x2d724a66a4244a6a493bbf6f10e9a1aefce0702e21bc3d1995f4741e0d20e0b6;
        X[13] = 0x287e29cb6788fd94d01ef493dbff1e658619a05ce4fdd1541726bff3cbe8b33b;
        X[14] = 0x106e96134b2e80dc2b4691a8c3ecfc2ea1ef0ab294c5f708cd6774bfeb403009;
        X[15] = 0x2fe84884f541263540ef28f6f103eeccb2413af5378e27d63469466568f56e84;
        X[16] = 0x19a2ee861704322444687829379a8303142709c02feb0f0d56de44c5ab0540e2;
        u_vec[1] = PolyEvalInstanceLib.PolyEvalInstance(
            0x2d55fc82ceddb996f78b7b30aec725b7ff7c9487a1c419c451483c964ca4f758,
            0x3006ae25186226af4f8ca0586a7e3cd80cee52efd4d5ca162652da31e0030db9,
            X,
            0x226815ad4c481c399fdc2ddfa7c916769aeb5d6e39bd30ea2676b738ff7db9d5
        );

        X = new uint256[](17);
        X[0] = 1;
        X[1] = 1;
        X[2] = 1;
        X[3] = 1;
        X[4] = 1;
        X[5] = 1;
        X[6] = 1;
        X[7] = 1;
        X[8] = 1;
        X[9] = 1;
        X[10] = 1;
        X[11] = 1;
        X[12] = 1;
        X[13] = 1;
        X[14] = 1;
        X[15] = 1;
        X[16] = 0;
        u_vec[2] = PolyEvalInstanceLib.PolyEvalInstance(
            0x2d55fc82ceddb996f78b7b30aec725b7ff7c9487a1c419c451483c964ca4f758,
            0x3006ae25186226af4f8ca0586a7e3cd80cee52efd4d5ca162652da31e0030db9,
            X,
            0x20f9914f54e7717576fa749ff16aecd487863ff1c11162499f43c793e44c0a22
        );

        X = new uint256[](17);
        X[0] = 0x1725a070098a94cf768334d9b0c3ac4a261682687b39c8e6db7ad3c2901d5e24;
        X[1] = 0x26b72d7895ccf170139a9a71e7da7431d81afd3cd5223969d4794ca8b1366241;
        X[2] = 0x2c9493e9d5b214b3cad4bb621544e6001cb1dc10421ede559fb937d89568cd01;
        X[3] = 0x1334cd36b6c002cd14bd1ac0e19bfca3b7fe600634fa22ac5d6fc6b271c50ea1;
        X[4] = 0x24e56409afcdd7500f2608d82db8f7a607cb1c5246aaa03cb30fdab50e6b0131;
        X[5] = 0x27ee3e707f58a066bd5c0c4078fc690de3d108a7f759884c0d890dcf9c71d0ae;
        X[6] = 0x12060dfdd8c1fceaba38ac16288cd391e1bd33e08476edde5dafa859d2bc20c3;
        X[7] = 0x1715421e99f5091ab24230608160f638748e685707ded14d8df5e502eff1c726;
        X[8] = 0x21225c719bfbac3279313676bb52f31d166432319612381d19e29680a23a9e54;
        X[9] = 0x1f5f277e7a112badb02d8cd4794afac553a48acec6eb4895fd4ac287309e0766;
        X[10] = 0x01c6ef7072eae3366e9bac92954116f78dba97d93b34943cdbca7473e03c303c;
        X[11] = 0x2d724a66a4244a6a493bbf6f10e9a1aefce0702e21bc3d1995f4741e0d20e0b6;
        X[12] = 0x287e29cb6788fd94d01ef493dbff1e658619a05ce4fdd1541726bff3cbe8b33b;
        X[13] = 0x106e96134b2e80dc2b4691a8c3ecfc2ea1ef0ab294c5f708cd6774bfeb403009;
        X[14] = 0x2fe84884f541263540ef28f6f103eeccb2413af5378e27d63469466568f56e84;
        X[15] = 0x19a2ee861704322444687829379a8303142709c02feb0f0d56de44c5ab0540e2;
        X[16] = 0x053328f9153fa2d3455c13a25004acd66102e6596877a4952854ee2401233022;
        u_vec[3] = PolyEvalInstanceLib.PolyEvalInstance(
            0x2d55fc82ceddb996f78b7b30aec725b7ff7c9487a1c419c451483c964ca4f758,
            0x3006ae25186226af4f8ca0586a7e3cd80cee52efd4d5ca162652da31e0030db9,
            X,
            0x20a26a182fc955d93811ab4e54caeb2de5e66193342ae5e35347c776c47836a9
        );

        X = new uint256[](17);
        X[0] = 0x1725a070098a94cf768334d9b0c3ac4a261682687b39c8e6db7ad3c2901d5e24;
        X[1] = 0x26b72d7895ccf170139a9a71e7da7431d81afd3cd5223969d4794ca8b1366241;
        X[2] = 0x2c9493e9d5b214b3cad4bb621544e6001cb1dc10421ede559fb937d89568cd01;
        X[3] = 0x1334cd36b6c002cd14bd1ac0e19bfca3b7fe600634fa22ac5d6fc6b271c50ea1;
        X[4] = 0x24e56409afcdd7500f2608d82db8f7a607cb1c5246aaa03cb30fdab50e6b0131;
        X[5] = 0x27ee3e707f58a066bd5c0c4078fc690de3d108a7f759884c0d890dcf9c71d0ae;
        X[6] = 0x12060dfdd8c1fceaba38ac16288cd391e1bd33e08476edde5dafa859d2bc20c3;
        X[7] = 0x1715421e99f5091ab24230608160f638748e685707ded14d8df5e502eff1c726;
        X[8] = 0x21225c719bfbac3279313676bb52f31d166432319612381d19e29680a23a9e54;
        X[9] = 0x1f5f277e7a112badb02d8cd4794afac553a48acec6eb4895fd4ac287309e0766;
        X[10] = 0x01c6ef7072eae3366e9bac92954116f78dba97d93b34943cdbca7473e03c303c;
        X[11] = 0x2d724a66a4244a6a493bbf6f10e9a1aefce0702e21bc3d1995f4741e0d20e0b6;
        X[12] = 0x287e29cb6788fd94d01ef493dbff1e658619a05ce4fdd1541726bff3cbe8b33b;
        X[13] = 0x106e96134b2e80dc2b4691a8c3ecfc2ea1ef0ab294c5f708cd6774bfeb403009;
        X[14] = 0x2fe84884f541263540ef28f6f103eeccb2413af5378e27d63469466568f56e84;
        X[15] = 0x19a2ee861704322444687829379a8303142709c02feb0f0d56de44c5ab0540e2;
        X[16] = 0x053328f9153fa2d3455c13a25004acd66102e6596877a4952854ee2401233022;
        u_vec[4] = PolyEvalInstanceLib.PolyEvalInstance(
            0x1ec29657919b0f194b6a69c8265a59633793a45893b7a2b674c6f68e58825c74,
            0x0b3d096f0d640f6dec627235a3dc9f3f8e9f5ca0650e42eb3c16b45252512c5c,
            X,
            0x2513125d4fbe8e638298ed83b477b0b40b06cd1e0fa867700bd0544596a73991
        );

        X = new uint256[](14);
        X[0] = 0x1334cd36b6c002cd14bd1ac0e19bfca3b7fe600634fa22ac5d6fc6b271c50ea1;
        X[1] = 0x24e56409afcdd7500f2608d82db8f7a607cb1c5246aaa03cb30fdab50e6b0131;
        X[2] = 0x27ee3e707f58a066bd5c0c4078fc690de3d108a7f759884c0d890dcf9c71d0ae;
        X[3] = 0x12060dfdd8c1fceaba38ac16288cd391e1bd33e08476edde5dafa859d2bc20c3;
        X[4] = 0x1715421e99f5091ab24230608160f638748e685707ded14d8df5e502eff1c726;
        X[5] = 0x21225c719bfbac3279313676bb52f31d166432319612381d19e29680a23a9e54;
        X[6] = 0x1f5f277e7a112badb02d8cd4794afac553a48acec6eb4895fd4ac287309e0766;
        X[7] = 0x01c6ef7072eae3366e9bac92954116f78dba97d93b34943cdbca7473e03c303c;
        X[8] = 0x2d724a66a4244a6a493bbf6f10e9a1aefce0702e21bc3d1995f4741e0d20e0b6;
        X[9] = 0x287e29cb6788fd94d01ef493dbff1e658619a05ce4fdd1541726bff3cbe8b33b;
        X[10] = 0x106e96134b2e80dc2b4691a8c3ecfc2ea1ef0ab294c5f708cd6774bfeb403009;
        X[11] = 0x2fe84884f541263540ef28f6f103eeccb2413af5378e27d63469466568f56e84;
        X[12] = 0x19a2ee861704322444687829379a8303142709c02feb0f0d56de44c5ab0540e2;
        X[13] = 0x053328f9153fa2d3455c13a25004acd66102e6596877a4952854ee2401233022;
        u_vec[5] = PolyEvalInstanceLib.PolyEvalInstance(
            0x3019a8c784334c0aaf50696e207ffd698bd60a364038a76ac3399250f56d8b54,
            0x26b53798d836b6632563da0058df951fc3b5b282876347560145fdc00331c7e1,
            X,
            0x08d04ce171cf7c61087f116638d0f64e32c8c60d0f084bcc06365d87ed89e142
        );

        X = new uint256[](17);
        X[0] = 0x25172cbbd1289dde3d5a3ec6806b7408475968df10e71565ca1ba3579b950bab;
        X[1] = 0x1725a070098a94cf768334d9b0c3ac4a261682687b39c8e6db7ad3c2901d5e24;
        X[2] = 0x26b72d7895ccf170139a9a71e7da7431d81afd3cd5223969d4794ca8b1366241;
        X[3] = 0x2c9493e9d5b214b3cad4bb621544e6001cb1dc10421ede559fb937d89568cd01;
        X[4] = 0x1334cd36b6c002cd14bd1ac0e19bfca3b7fe600634fa22ac5d6fc6b271c50ea1;
        X[5] = 0x24e56409afcdd7500f2608d82db8f7a607cb1c5246aaa03cb30fdab50e6b0131;
        X[6] = 0x27ee3e707f58a066bd5c0c4078fc690de3d108a7f759884c0d890dcf9c71d0ae;
        X[7] = 0x12060dfdd8c1fceaba38ac16288cd391e1bd33e08476edde5dafa859d2bc20c3;
        X[8] = 0x1715421e99f5091ab24230608160f638748e685707ded14d8df5e502eff1c726;
        X[9] = 0x21225c719bfbac3279313676bb52f31d166432319612381d19e29680a23a9e54;
        X[10] = 0x1f5f277e7a112badb02d8cd4794afac553a48acec6eb4895fd4ac287309e0766;
        X[11] = 0x01c6ef7072eae3366e9bac92954116f78dba97d93b34943cdbca7473e03c303c;
        X[12] = 0x2d724a66a4244a6a493bbf6f10e9a1aefce0702e21bc3d1995f4741e0d20e0b6;
        X[13] = 0x287e29cb6788fd94d01ef493dbff1e658619a05ce4fdd1541726bff3cbe8b33b;
        X[14] = 0x106e96134b2e80dc2b4691a8c3ecfc2ea1ef0ab294c5f708cd6774bfeb403009;
        X[15] = 0x2fe84884f541263540ef28f6f103eeccb2413af5378e27d63469466568f56e84;
        X[16] = 0x19a2ee861704322444687829379a8303142709c02feb0f0d56de44c5ab0540e2;
        u_vec[6] = PolyEvalInstanceLib.PolyEvalInstance(
            0x27f88af1eec0500e566c3e25d6147661e7456b52b2f023f91f421270873d2f92,
            0x03de91147588dfc46735f07ff26fbb05e680de5ee4aa35cd9af42d75e8eee4f7,
            X,
            0x0088669e792dcb64cc9598dbed28620719bebd0129650d26e886bc06dc43d852
        );

        uint256 rho = 0x151a9a94b2adc8bc8a39f87e2dc5e3978ee1ec7f2f77e575c858b509faf672b6;

        (uint256 claim_batch_joint, uint256 num_rounds_z, uint256[] memory powers_of_rho) =
            Step7Lib.compute_sc_proof_batch_verification_input(u_vec, rho, Grumpkin.P_MOD);

        assertEq(claim_batch_joint, 0x14172dd27cbf1b2e93412a545e1948697533ef38539aa340bf476019bb6ecf6a);
        assertEq(num_rounds_z, 17);
        assertEq(powers_of_rho[0], 0x0000000000000000000000000000000000000000000000000000000000000001);
        assertEq(powers_of_rho[1], 0x151a9a94b2adc8bc8a39f87e2dc5e3978ee1ec7f2f77e575c858b509faf672b6);
        assertEq(powers_of_rho[2], 0x2b904fe0e0e620791a47036a03d37050ac5ec038b55511bac4d0791b05afcb53);
        assertEq(powers_of_rho[3], 0x041837e28142baf2c5f23e3200df40eef6072649557aaf32b483d14d8e5832e4);
        assertEq(powers_of_rho[4], 0x21fdeac92b0716f8d52ccfec7d4162a665f2e538039d493a43f716b8cc4247b2);
        assertEq(powers_of_rho[5], 0x0cd6721a606d1ea112a70eca1fd01a63a57029a9dd5e9181525b2dfe6a159c87);
        assertEq(powers_of_rho[6], 0x2bcd16852ef2c9e1530cb8fc0d82ec88154db8f92a2a56f397369679abdf56b9);
    }

    function test_compute_sc_proof_batch_verification_input_primary() public {
        PolyEvalInstanceLib.PolyEvalInstance[] memory u_vec = new PolyEvalInstanceLib.PolyEvalInstance[](7);

        uint256[] memory X = new uint256[](17);
        X[0] = 0x1695fc0c0698b7e920d417e58174c018754f581f9044cd68c11cc2363005e185;
        X[1] = 0x0a6ccda86e557ab8b5e59b7a8c7846f5f0566f3400abec27642881fda5081265;
        X[2] = 0x0460b24e8674040141696541a62f2b6dfcfbaa97708ab547bc07f32ba186024e;
        X[3] = 0x04109fec011ecc9677d7a3e349b785743fa0b1dc96b97781ae2ac8627a37f083;
        X[4] = 0x200ab93f588f3912d94a4553e9c2ae6ee35996c33c41d12d37b387121a2be6d1;
        X[5] = 0x263c8dc77149bdd56e11eb6fc11eeea047eebeb8be056e1b160004160808af65;
        X[6] = 0x0cf3a930fcc8e93caad2c5eec517ff5006d4be7254221fff85c58c97f6d35ee5;
        X[7] = 0x2ba2ec16f6cce727119850fd8b058382a31c326105fe1063f4736b11062df644;
        X[8] = 0x140bedef3716eff22e6e35591c5a54c6cd7aae70c800183ec559a2ce7302fd6a;
        X[9] = 0x033f543b39164994196e6186c8dd6ff338eaa9f4fde0da6f969502a75399299f;
        X[10] = 0x2a6e10ef6ab883dc64c45ebcc6efd99ea862f508b121b1f0ceecf1c77e181769;
        X[11] = 0x19cce4de222eb81d4dd537befeab6e42d32f810b3360cd3247e39d82c6cf37a2;
        X[12] = 0x1f12d996682184b2b8df7e855cab2231e22613b95ca3f2fdc0650809e22350df;
        X[13] = 0x220fe2f07d75e0cc580cf11dc16611f583cc5384842904a98e45cef3b7f409b9;
        X[14] = 0x2612eb3431d63727a69d698bb7278ddff6214191d842de7d6558a6637cd0efcb;
        X[15] = 0x05b94d437287ba864fe667b76b45342b7a01de764d49bd8cb3d4c37ceb9ed6f6;
        X[16] = 0x2e986437477a974632e0ffcd780ddc863a63d78f83c5c9666ebc792ade06dc85;
        u_vec[0] = PolyEvalInstanceLib.PolyEvalInstance(
            0x0de07d3056f2ec32860a2e01306327438a0da14baef711eb336692e4e2a57cfb,
            0x133f96cda3cacff0d041d21ffdd96763158f0cdbe4779c71fccba5e02071de01,
            X,
            0x08353df9bb3663c3258222e99684ee10f83abc2931f0c4e1918a49e75498fc1d
        );

        X = new uint256[](17);
        X[0] = 0x144454412fd8764e4aaf2cec1546f1a9f1f154e7de160d033a632ecdfdd5964d;
        X[1] = 0x05837413e5049a37ef21bc91fd21fcce3f89e80202ec70aa01872cc9221d95cd;
        X[2] = 0x17430b827b82e51b14fcdf9511b6a8061d1392d4589b8221dafbae759dd6e070;
        X[3] = 0x0256f4d5674a529ec39e0afba3738d0263cb1d385a563ce608edad719f47d5fd;
        X[4] = 0x00f87554a6caed435bb9e714a355fa73cfd359d5dd8b31fc172ada8cecd7ee30;
        X[5] = 0x29b4dbb7be87a4961e21fe447b03125469077ba2bad896ac2c374aa55be358ab;
        X[6] = 0x1493591a52ded39471fbcd9937537aae9023e77080708f790798671aaa268fc9;
        X[7] = 0x046d5e95bee7ea383f29e0ffa2a6e2816d5b82a75283265e2bc17e63d6ecaeee;
        X[8] = 0x0ea46d83cda8cac4084d937137ab451e89d3fef4b6e25ec00e80fcb8bf8a5308;
        X[9] = 0x26d16ee1e12b5e781327f54a2b89bb7f397e500ec503066b4e37c5e59c372aa1;
        X[10] = 0x2826c37882e6cec0184d476e6e14ac3cb48aee6e233a1ee085c174d53cf1f419;
        X[11] = 0x1b054f124db95f87ec662a5b8ddf47f2b0264e97ef866a05e2a3e0335bce3b16;
        X[12] = 0x0fd296132bf7fc749c44059331d68c735b05f8f746c26e0bf25c3e0a0e6b17b1;
        X[13] = 0x2aede350fab3723fb2ed55ed281f40e4a718f43237901e99264cb09a586661ef;
        X[14] = 0x1a99798029810bbe8a2a5e0d738e8a7c54c010acf84892178463c3222d08b351;
        X[15] = 0x01611bd374a32895d454f4fbe32f051f82e1fef13242ee7951dc6df7848cef97;
        X[16] = 0x019b91a9d375fe46af22a415a0cba65d78d7a605eecf99b3eff27cd508e6282c;
        u_vec[1] = PolyEvalInstanceLib.PolyEvalInstance(
            0x225b5ed62a6252b52c48074ea887026ad925357d7bbd259875cecc0db9d6ecc7,
            0x05eca5f09c13e5b373b5a9ceaf2414845d8f52392ae90f41de6eb41b08387356,
            X,
            0x186f7f961e265c88569e4360b15d71d9fba3a61e3dce74c3096756292fd35a9f
        );

        X = new uint256[](17);
        X[0] = 1;
        X[1] = 1;
        X[2] = 1;
        X[3] = 1;
        X[4] = 1;
        X[5] = 1;
        X[6] = 1;
        X[7] = 1;
        X[8] = 1;
        X[9] = 1;
        X[10] = 1;
        X[11] = 1;
        X[12] = 1;
        X[13] = 1;
        X[14] = 1;
        X[15] = 1;
        X[16] = 0;
        u_vec[2] = PolyEvalInstanceLib.PolyEvalInstance(
            0x225b5ed62a6252b52c48074ea887026ad925357d7bbd259875cecc0db9d6ecc7,
            0x05eca5f09c13e5b373b5a9ceaf2414845d8f52392ae90f41de6eb41b08387356,
            X,
            0x2038e67614a1ff8e6b4aa9fec97740b2c146a88103dbac18372455d76aa81b87
        );

        X = new uint256[](17);
        X[0] = 0x05837413e5049a37ef21bc91fd21fcce3f89e80202ec70aa01872cc9221d95cd;
        X[1] = 0x17430b827b82e51b14fcdf9511b6a8061d1392d4589b8221dafbae759dd6e070;
        X[2] = 0x0256f4d5674a529ec39e0afba3738d0263cb1d385a563ce608edad719f47d5fd;
        X[3] = 0x00f87554a6caed435bb9e714a355fa73cfd359d5dd8b31fc172ada8cecd7ee30;
        X[4] = 0x29b4dbb7be87a4961e21fe447b03125469077ba2bad896ac2c374aa55be358ab;
        X[5] = 0x1493591a52ded39471fbcd9937537aae9023e77080708f790798671aaa268fc9;
        X[6] = 0x046d5e95bee7ea383f29e0ffa2a6e2816d5b82a75283265e2bc17e63d6ecaeee;
        X[7] = 0x0ea46d83cda8cac4084d937137ab451e89d3fef4b6e25ec00e80fcb8bf8a5308;
        X[8] = 0x26d16ee1e12b5e781327f54a2b89bb7f397e500ec503066b4e37c5e59c372aa1;
        X[9] = 0x2826c37882e6cec0184d476e6e14ac3cb48aee6e233a1ee085c174d53cf1f419;
        X[10] = 0x1b054f124db95f87ec662a5b8ddf47f2b0264e97ef866a05e2a3e0335bce3b16;
        X[11] = 0x0fd296132bf7fc749c44059331d68c735b05f8f746c26e0bf25c3e0a0e6b17b1;
        X[12] = 0x2aede350fab3723fb2ed55ed281f40e4a718f43237901e99264cb09a586661ef;
        X[13] = 0x1a99798029810bbe8a2a5e0d738e8a7c54c010acf84892178463c3222d08b351;
        X[14] = 0x01611bd374a32895d454f4fbe32f051f82e1fef13242ee7951dc6df7848cef97;
        X[15] = 0x019b91a9d375fe46af22a415a0cba65d78d7a605eecf99b3eff27cd508e6282c;
        X[16] = 0x0780ddd1b7bae1a8aff7cf5a352412e2956c573041e9ec3557bca02d7a2e78a1;
        u_vec[3] = PolyEvalInstanceLib.PolyEvalInstance(
            0x225b5ed62a6252b52c48074ea887026ad925357d7bbd259875cecc0db9d6ecc7,
            0x05eca5f09c13e5b373b5a9ceaf2414845d8f52392ae90f41de6eb41b08387356,
            X,
            0x173fdc325f99a0801ed6a4e396d176ba6080c6e83f0898242abaef64108d108f
        );

        X = new uint256[](17);
        X[0] = 0x05837413e5049a37ef21bc91fd21fcce3f89e80202ec70aa01872cc9221d95cd;
        X[1] = 0x17430b827b82e51b14fcdf9511b6a8061d1392d4589b8221dafbae759dd6e070;
        X[2] = 0x0256f4d5674a529ec39e0afba3738d0263cb1d385a563ce608edad719f47d5fd;
        X[3] = 0x00f87554a6caed435bb9e714a355fa73cfd359d5dd8b31fc172ada8cecd7ee30;
        X[4] = 0x29b4dbb7be87a4961e21fe447b03125469077ba2bad896ac2c374aa55be358ab;
        X[5] = 0x1493591a52ded39471fbcd9937537aae9023e77080708f790798671aaa268fc9;
        X[6] = 0x046d5e95bee7ea383f29e0ffa2a6e2816d5b82a75283265e2bc17e63d6ecaeee;
        X[7] = 0x0ea46d83cda8cac4084d937137ab451e89d3fef4b6e25ec00e80fcb8bf8a5308;
        X[8] = 0x26d16ee1e12b5e781327f54a2b89bb7f397e500ec503066b4e37c5e59c372aa1;
        X[9] = 0x2826c37882e6cec0184d476e6e14ac3cb48aee6e233a1ee085c174d53cf1f419;
        X[10] = 0x1b054f124db95f87ec662a5b8ddf47f2b0264e97ef866a05e2a3e0335bce3b16;
        X[11] = 0x0fd296132bf7fc749c44059331d68c735b05f8f746c26e0bf25c3e0a0e6b17b1;
        X[12] = 0x2aede350fab3723fb2ed55ed281f40e4a718f43237901e99264cb09a586661ef;
        X[13] = 0x1a99798029810bbe8a2a5e0d738e8a7c54c010acf84892178463c3222d08b351;
        X[14] = 0x01611bd374a32895d454f4fbe32f051f82e1fef13242ee7951dc6df7848cef97;
        X[15] = 0x019b91a9d375fe46af22a415a0cba65d78d7a605eecf99b3eff27cd508e6282c;
        X[16] = 0x0780ddd1b7bae1a8aff7cf5a352412e2956c573041e9ec3557bca02d7a2e78a1;
        u_vec[4] = PolyEvalInstanceLib.PolyEvalInstance(
            0x22850dc71b502bc6c23a442a7ce89c26942624aec88aecd46297c3a1ae7a93ce,
            0x1eb65c6e2178b3ded9d6b2cc8e755fc062d6a34fe5fc4dc5920dfd4588e4357a,
            X,
            0x0998a56ce3fe9f0fe8e1fcbc2f2d4f8c003fd6444fa20870a0061201ea13b2f5
        );

        X = new uint256[](14);
        X[0] = 0x00f87554a6caed435bb9e714a355fa73cfd359d5dd8b31fc172ada8cecd7ee30;
        X[1] = 0x29b4dbb7be87a4961e21fe447b03125469077ba2bad896ac2c374aa55be358ab;
        X[2] = 0x1493591a52ded39471fbcd9937537aae9023e77080708f790798671aaa268fc9;
        X[3] = 0x046d5e95bee7ea383f29e0ffa2a6e2816d5b82a75283265e2bc17e63d6ecaeee;
        X[4] = 0x0ea46d83cda8cac4084d937137ab451e89d3fef4b6e25ec00e80fcb8bf8a5308;
        X[5] = 0x26d16ee1e12b5e781327f54a2b89bb7f397e500ec503066b4e37c5e59c372aa1;
        X[6] = 0x2826c37882e6cec0184d476e6e14ac3cb48aee6e233a1ee085c174d53cf1f419;
        X[7] = 0x1b054f124db95f87ec662a5b8ddf47f2b0264e97ef866a05e2a3e0335bce3b16;
        X[8] = 0x0fd296132bf7fc749c44059331d68c735b05f8f746c26e0bf25c3e0a0e6b17b1;
        X[9] = 0x2aede350fab3723fb2ed55ed281f40e4a718f43237901e99264cb09a586661ef;
        X[10] = 0x1a99798029810bbe8a2a5e0d738e8a7c54c010acf84892178463c3222d08b351;
        X[11] = 0x01611bd374a32895d454f4fbe32f051f82e1fef13242ee7951dc6df7848cef97;
        X[12] = 0x019b91a9d375fe46af22a415a0cba65d78d7a605eecf99b3eff27cd508e6282c;
        X[13] = 0x0780ddd1b7bae1a8aff7cf5a352412e2956c573041e9ec3557bca02d7a2e78a1;
        u_vec[5] = PolyEvalInstanceLib.PolyEvalInstance(
            0x07fa0663f8e8193e5e4f7e22f873f918f14ce92989e931bbfba951968a111525,
            0x0d3b315227a6a2494ce5c0f81e84fde0d387091a5389f293e06d0834045fb52e,
            X,
            0x07ce63dd203a606986287f23b89f5b68b30d11f0055e12d1f67152d6bf0f6019
        );

        X = new uint256[](17);
        X[0] = 0x144454412fd8764e4aaf2cec1546f1a9f1f154e7de160d033a632ecdfdd5964d;
        X[1] = 0x05837413e5049a37ef21bc91fd21fcce3f89e80202ec70aa01872cc9221d95cd;
        X[2] = 0x17430b827b82e51b14fcdf9511b6a8061d1392d4589b8221dafbae759dd6e070;
        X[3] = 0x0256f4d5674a529ec39e0afba3738d0263cb1d385a563ce608edad719f47d5fd;
        X[4] = 0x00f87554a6caed435bb9e714a355fa73cfd359d5dd8b31fc172ada8cecd7ee30;
        X[5] = 0x29b4dbb7be87a4961e21fe447b03125469077ba2bad896ac2c374aa55be358ab;
        X[6] = 0x1493591a52ded39471fbcd9937537aae9023e77080708f790798671aaa268fc9;
        X[7] = 0x046d5e95bee7ea383f29e0ffa2a6e2816d5b82a75283265e2bc17e63d6ecaeee;
        X[8] = 0x0ea46d83cda8cac4084d937137ab451e89d3fef4b6e25ec00e80fcb8bf8a5308;
        X[9] = 0x26d16ee1e12b5e781327f54a2b89bb7f397e500ec503066b4e37c5e59c372aa1;
        X[10] = 0x2826c37882e6cec0184d476e6e14ac3cb48aee6e233a1ee085c174d53cf1f419;
        X[11] = 0x1b054f124db95f87ec662a5b8ddf47f2b0264e97ef866a05e2a3e0335bce3b16;
        X[12] = 0x0fd296132bf7fc749c44059331d68c735b05f8f746c26e0bf25c3e0a0e6b17b1;
        X[13] = 0x2aede350fab3723fb2ed55ed281f40e4a718f43237901e99264cb09a586661ef;
        X[14] = 0x1a99798029810bbe8a2a5e0d738e8a7c54c010acf84892178463c3222d08b351;
        X[15] = 0x01611bd374a32895d454f4fbe32f051f82e1fef13242ee7951dc6df7848cef97;
        X[16] = 0x019b91a9d375fe46af22a415a0cba65d78d7a605eecf99b3eff27cd508e6282c;
        u_vec[6] = PolyEvalInstanceLib.PolyEvalInstance(
            0x2829fe3f56f139c48a22a3ae7c35a777425e3f578cc81038c7cb0ec519839f6e,
            0x27a0a9319530016b2f890c1cb0d8e956e715477366e11cef729c4aff9a969cfc,
            X,
            0x101e200bd035b257fe90e8d2d1c0df37860d3f49effed18058414ff5ec3d465c
        );

        uint256 rho = 0x1dbb16d7c99fa0c175099f6cd1bcbf9565e9d388c5c94a277eeef3d51df045cc;

        (uint256 claim_batch_joint, uint256 num_rounds_z, uint256[] memory powers_of_rho) =
            Step7Lib.compute_sc_proof_batch_verification_input(Step7Lib.compute_u_vec_padded(u_vec), rho, Bn256.R_MOD);

        assertEq(claim_batch_joint, 0x17327cf20e588d94a8d1a34b607a09a6c74188d43fe6294b670ea76383009bc2);
        assertEq(num_rounds_z, 17);
        assertEq(powers_of_rho[0], 0x0000000000000000000000000000000000000000000000000000000000000001);
        assertEq(powers_of_rho[1], 0x1dbb16d7c99fa0c175099f6cd1bcbf9565e9d388c5c94a277eeef3d51df045cc);
        assertEq(powers_of_rho[2], 0x0f7d64af2e39a15de68d96113a33d887a40dfdaef37121405a0238b2ce3e4968);
        assertEq(powers_of_rho[3], 0x0e9d3027ba7e5cc8d86993ead7b2271175434ff805c5da74be476701fc15920f);
        assertEq(powers_of_rho[4], 0x1f57da2dd386acff47043972adbd1b1463ca21830fc85264d83f34d5e9e091ba);
        assertEq(powers_of_rho[5], 0x0b1699ba7b6ba28b7b5abdd3f34adbcbf240958dca860b105863d78feac70d6c);
        assertEq(powers_of_rho[6], 0x0811de85d7bd8bb07b0856440f3d8fe2712aecacfa3959ec8f2e584a4236c481);
    }

    function test_compute_claim_batch_final_left_primary() public {
        Abstractions.CompressedSnark memory proof = TestUtilities.loadProof();

        uint16 rounds = 60;
        uint8[] memory state = new uint8[](64);
        state[0] = 0xa7;
        state[1] = 0x7b;
        state[2] = 0x23;
        state[3] = 0xe1;
        state[4] = 0x1c;
        state[5] = 0x3b;
        state[6] = 0x95;
        state[7] = 0xd7;
        state[8] = 0x9e;
        state[9] = 0xee;
        state[10] = 0xdd;
        state[11] = 0x4e;
        state[12] = 0x75;
        state[13] = 0xdb;
        state[14] = 0x66;
        state[15] = 0xdb;
        state[16] = 0xfe;
        state[17] = 0xc2;
        state[18] = 0x2f;
        state[19] = 0x0d;
        state[20] = 0xe9;
        state[21] = 0x6a;
        state[22] = 0x3e;
        state[23] = 0x19;
        state[24] = 0x32;
        state[25] = 0x3b;
        state[26] = 0x67;
        state[27] = 0x61;
        state[28] = 0x36;
        state[29] = 0x90;
        state[30] = 0x71;
        state[31] = 0x94;
        state[32] = 0xf1;
        state[33] = 0xe1;
        state[34] = 0x89;
        state[35] = 0x9f;
        state[36] = 0x4a;
        state[37] = 0x2e;
        state[38] = 0x33;
        state[39] = 0x0a;
        state[40] = 0x19;
        state[41] = 0xd1;
        state[42] = 0xda;
        state[43] = 0x1d;
        state[44] = 0x30;
        state[45] = 0xf1;
        state[46] = 0x1c;
        state[47] = 0x2a;
        state[48] = 0x05;
        state[49] = 0xa4;
        state[50] = 0xd4;
        state[51] = 0xbb;
        state[52] = 0x0f;
        state[53] = 0x4f;
        state[54] = 0xf5;
        state[55] = 0xaa;
        state[56] = 0x38;
        state[57] = 0xc8;
        state[58] = 0x2c;
        state[59] = 0x93;
        state[60] = 0x39;
        state[61] = 0x86;
        state[62] = 0xdf;
        state[63] = 0xc8;

        KeccakTranscriptLib.KeccakTranscript memory transcript =
            KeccakTranscriptLib.KeccakTranscript(rounds, state, new uint8[](0));

        uint256 claim_batch_joint = 0x17327cf20e588d94a8d1a34b607a09a6c74188d43fe6294b670ea76383009bc2;
        uint256 num_rounds_z = 17;

        (, uint256 expected1, uint256[] memory expected2) = Step7GrumpkinLib.compute_claim_batch_final_left_primary(
            proof.r_W_snark_primary.sc_proof_batch, transcript, claim_batch_joint, num_rounds_z
        );
        assertEq(expected1, 0x28bc08980839fb81ec831e4a21f7d8d8cc8ba78585567cf218dad86d74a8096e);
        assertEq(expected2[0], 0x2da4b53547feb62d12c90ecefd3e94bbc93c1d0f159cf24ae6eb7867fed3e7a3);
        assertEq(expected2[1], 0x02ee3b9ead045a852a6b19c976ae565103f1ed542ffb4f22888a8e4aa7a147c6);
        assertEq(expected2[2], 0x210748dfc7f2d6bc5c00e524b0d8e8ab5a7306248d0f9e36ef09f2fdde902866);
        assertEq(expected2[3], 0x1fbd61038d37831706ba4b60c82946fa2a8c4faacd9449f0016683897542bf7d);
        assertEq(expected2[4], 0x25d4afe853d20274f20f8353babf3abb477bc7d294408d7cd7f1c738b615cb13);
        assertEq(expected2[5], 0x2ca3277c2b6c6673eed164f0d17171307b96416a2839ab11049d6d3ea7d866b3);
        assertEq(expected2[6], 0x0b0f8f2421dffef34434e1e1338972882085f06de43e953e00f2f33986cf2430);
        assertEq(expected2[7], 0x0d193c111348687b6160f7d561f1a54b1dfb6b68e6efd22ae4d98f6f7fa493a2);
        assertEq(expected2[8], 0x04d614a5037317b11c8ea380b134594e310ff5829149b3dcf84f4f3625ecb355);
        assertEq(expected2[9], 0x2d00f949d0c462df8217916d04845fa75bad178242836a3db4b880c14263910b);
        assertEq(expected2[10], 0x15a3fc8508c10f84c1ddccf93d1b5f610eb3f775ba26b45e0b2a22faf384528f);
        assertEq(expected2[11], 0x2b8a8b4fd8b329e2abdac02a5d473449506e25b6ca0d5e60924d5e0ee03fbbf8);
        assertEq(expected2[12], 0x1fbe657c6fd4880b49b6809d57a7fec9d262b21ea43dc73858b5144d1bc957d1);
        assertEq(expected2[13], 0x10611b30d9f8551b6a98fdf44ebe7a416f5f1f72309a22bafdb93b48b8d224ef);
        assertEq(expected2[14], 0x0a888620997f3d3e5bcc0e8da2977428266271156408b21cff65b5d4ee2061b7);
        assertEq(expected2[15], 0x18b05f8b35616fa97ab95e762ceb95008646ebff02d098772d33977d1595bb65);
        assertEq(expected2[16], 0x05468de5d19365e6861cda8682f5be36e2ed4ff855554273f6e68a71fe630c40);
    }

    function test_compute_claim_batch_final_left_secondary() public {
        Abstractions.CompressedSnark memory proof = TestUtilities.loadProof();

        uint16 rounds = 60;
        uint8[] memory state = new uint8[](64);
        state[0] = 0x80;
        state[1] = 0xa4;
        state[2] = 0x1d;
        state[3] = 0xfc;
        state[4] = 0xf0;
        state[5] = 0x69;
        state[6] = 0x59;
        state[7] = 0x5a;
        state[8] = 0xe3;
        state[9] = 0x22;
        state[10] = 0xd0;
        state[11] = 0xcc;
        state[12] = 0x67;
        state[13] = 0xd9;
        state[14] = 0x0a;
        state[15] = 0xd6;
        state[16] = 0x7a;
        state[17] = 0x79;
        state[18] = 0x34;
        state[19] = 0xab;
        state[20] = 0x84;
        state[21] = 0xe4;
        state[22] = 0xc3;
        state[23] = 0xb1;
        state[24] = 0xd2;
        state[25] = 0xab;
        state[26] = 0x63;
        state[27] = 0x45;
        state[28] = 0x19;
        state[29] = 0x8a;
        state[30] = 0x1f;
        state[31] = 0xdc;
        state[32] = 0x07;
        state[33] = 0x7c;
        state[34] = 0xe9;
        state[35] = 0xc9;
        state[36] = 0x9e;
        state[37] = 0x27;
        state[38] = 0x91;
        state[39] = 0xc8;
        state[40] = 0x93;
        state[41] = 0xf1;
        state[42] = 0xe1;
        state[43] = 0x12;
        state[44] = 0x48;
        state[45] = 0xbb;
        state[46] = 0x1c;
        state[47] = 0x96;
        state[48] = 0x41;
        state[49] = 0x78;
        state[50] = 0xe7;
        state[51] = 0xf6;
        state[52] = 0x86;
        state[53] = 0x2b;
        state[54] = 0x6a;
        state[55] = 0x3a;
        state[56] = 0x54;
        state[57] = 0x29;
        state[58] = 0x05;
        state[59] = 0x1f;
        state[60] = 0x7a;
        state[61] = 0xe0;
        state[62] = 0xe2;
        state[63] = 0x81;

        KeccakTranscriptLib.KeccakTranscript memory transcript =
            KeccakTranscriptLib.KeccakTranscript(rounds, state, new uint8[](0));

        uint256 claim_batch_joint = 0x14172dd27cbf1b2e93412a545e1948697533ef38539aa340bf476019bb6ecf6a;
        uint256 num_rounds_z = 17;

        (, uint256 expected1, uint256[] memory expected2) = Step7GrumpkinLib.compute_claim_batch_final_left_secondary(
            proof.f_W_snark_secondary.sc_proof_batch, transcript, claim_batch_joint, num_rounds_z
        );
        assertEq(expected1, 0x1d01f142d5005e21f5ea6976a02b7f27ec4220f6c6437af44102099d82042bf4);
        assertEq(expected2[0], 0x212329f6462c4d3d4f55b683c4c11a46c67256b9858b95c77c4b168e17388429);
        assertEq(expected2[1], 0x21dfc25a981fd369e19088e8b49ad309cc313820865b2e1417f952dbb5ee9641);
        assertEq(expected2[2], 0x273561b6235f8c4fc11611a7b98d8e79cd6e9d1cd17d5ef9d64810ade3ab9faf);
        assertEq(expected2[3], 0x0eb446efa9d3d67aaf4d934007ccc391eb8b625d79ec431687944848ae4f1b15);
        assertEq(expected2[4], 0x0806aeeb3c99719384c162a2baa1e246a2f0acedbc6587e90ae23528415a728b);
        assertEq(expected2[5], 0x0f0b6acbe5159a78eb79787b0a66a30eb93d4cc8af3b186bc294aab0366f089a);
        assertEq(expected2[6], 0x26cfe04f93d95279500732655810ab241cd6528598740b1d8f26cf9b50c61852);
        assertEq(expected2[7], 0x07142170b23263cd61979e619d76ae0e798597b2d98c2e15dd9d564d3dcccd19);
        assertEq(expected2[8], 0x27f3f2b4802274bc60c6ad244651cee35c90456aa92be7f00312dca8027d5d1f);
        assertEq(expected2[9], 0x22751a37e3c6910427c6ea662144f35b5abdd0eb6e0b695eecfa734ab38fa4f5);
        assertEq(expected2[10], 0x254e42a15ad6a9e0ca3c2a57c8c0de3257476e2fd9ebb905151501a01fe6fe1b);
        assertEq(expected2[11], 0x1eccda56960d3be98801ad1b9353b61c839b5d7750349fe88ad54c3359af5efc);
        assertEq(expected2[12], 0x2c267c6dcb97a97a8b7546ac4f50b7228acd93bd98c2f439948ffe2496994feb);
        assertEq(expected2[13], 0x288378d51fbd1d9a33ef19d19dd210d626f11b34faf5f35b6f223c36916546f2);
        assertEq(expected2[14], 0x2245068b115bfddbada3fd3b489aced772f48290a43273987c59fd577177ef9d);
        assertEq(expected2[15], 0x302c7f4b52e3378bfc76422ede556c4903162bda34195e7568ec097a6fcb0384);
        assertEq(expected2[16], 0x0de92231a46fb2c6eb97cd5565125775ff3151b4ae69acd99a0c25189fb06e70);
    }

    function test_compute_claim_batch_final_right_secondary() public {
        uint256[] memory r_z = new uint256[](17);
        r_z[0] = 0x212329f6462c4d3d4f55b683c4c11a46c67256b9858b95c77c4b168e17388429;
        r_z[1] = 0x21dfc25a981fd369e19088e8b49ad309cc313820865b2e1417f952dbb5ee9641;
        r_z[2] = 0x273561b6235f8c4fc11611a7b98d8e79cd6e9d1cd17d5ef9d64810ade3ab9faf;
        r_z[3] = 0x0eb446efa9d3d67aaf4d934007ccc391eb8b625d79ec431687944848ae4f1b15;
        r_z[4] = 0x0806aeeb3c99719384c162a2baa1e246a2f0acedbc6587e90ae23528415a728b;
        r_z[5] = 0x0f0b6acbe5159a78eb79787b0a66a30eb93d4cc8af3b186bc294aab0366f089a;
        r_z[6] = 0x26cfe04f93d95279500732655810ab241cd6528598740b1d8f26cf9b50c61852;
        r_z[7] = 0x07142170b23263cd61979e619d76ae0e798597b2d98c2e15dd9d564d3dcccd19;
        r_z[8] = 0x27f3f2b4802274bc60c6ad244651cee35c90456aa92be7f00312dca8027d5d1f;
        r_z[9] = 0x22751a37e3c6910427c6ea662144f35b5abdd0eb6e0b695eecfa734ab38fa4f5;
        r_z[10] = 0x254e42a15ad6a9e0ca3c2a57c8c0de3257476e2fd9ebb905151501a01fe6fe1b;
        r_z[11] = 0x1eccda56960d3be98801ad1b9353b61c839b5d7750349fe88ad54c3359af5efc;
        r_z[12] = 0x2c267c6dcb97a97a8b7546ac4f50b7228acd93bd98c2f439948ffe2496994feb;
        r_z[13] = 0x288378d51fbd1d9a33ef19d19dd210d626f11b34faf5f35b6f223c36916546f2;
        r_z[14] = 0x2245068b115bfddbada3fd3b489aced772f48290a43273987c59fd577177ef9d;
        r_z[15] = 0x302c7f4b52e3378bfc76422ede556c4903162bda34195e7568ec097a6fcb0384;
        r_z[16] = 0x0de92231a46fb2c6eb97cd5565125775ff3151b4ae69acd99a0c25189fb06e70;

        PolyEvalInstanceLib.PolyEvalInstance[] memory u_vec = new PolyEvalInstanceLib.PolyEvalInstance[](7);

        uint256[] memory X = new uint256[](17);
        X[0] = 0x1267f50e1d36c3869b23a88ba2e3e6b8046ecaf4c97466284b1acea3d12e40ae;
        X[1] = 0x20eeca082ad550aceb4ea48aff07fca4b18f2c9b07f8abb6dcfa18a7a68b2177;
        X[2] = 0x2ff410e0edb1b52f1a525739674ff462a429b63de86ef9f0aba7ea5a1d8edbbd;
        X[3] = 0x3049f9d9d6a7edead836c0d8b2ec18cfa6c32cf04d6b86c3ba69c9f8fea1030e;
        X[4] = 0x27fb4d075a305bfb22f2a17235e73c60f8eb90674ef6e730929951a60d4ff29d;
        X[5] = 0x304ef556679ef95f89b46285aea3c488a9dbd3f883be0c862288032e38f56740;
        X[6] = 0x0e13a25d86fd10b0c116bad0fe5c8fe093a85e0d5c412d775632729c750e0f4f;
        X[7] = 0x0832f12f3d7e019a82d6b57317269a584dcca3577311aa8855aa09721f4414da;
        X[8] = 0x13d5c871aa4865f1ddf690d34c2e7d83c3e026b2b2c00ad280c8dd91849464aa;
        X[9] = 0x2453c440114ddc0ad7eead8672c14b26da7d3e86a1689c97a49944f12d57ec83;
        X[10] = 0x2bb71aafb19142aabb9c8a0085e55e6d6f8ba9fc04a9d77cbd03fe65bbad339e;
        X[11] = 0x0592b27c6e3e7a59ad6701ed27bc4285115098237dbd65b2cf18b1beb42a7b89;
        X[12] = 0x12cb49defc02cb1fb4eac54d852b139a1a4b4f409e9a02c3fcfce5315039908f;
        X[13] = 0x112ac9a6d39dbe3e98ddbdcbe35eb8fe014c245513f98074c1e34f8ed1d8c16b;
        X[14] = 0x1888112a08ecbc29f7d3212e52cff7b57a08ed945ada88c35738b7824c08272d;
        X[15] = 0x227a2b43ee513e8e880741190db9f37d801cd332f59d5a08a06cb4ede201d589;
        X[16] = 0x2c363a743c3118e6486e7a66a8dd4c02a904051fe0241bb01df569c10015a8dd;
        u_vec[0] = PolyEvalInstanceLib.PolyEvalInstance(
            0x0e8422ef20e671749e06a46ae15ba1e703b55a1d8737c5e6a8f5dd216e3a6822,
            0x275b128cdcaba9c86c30fc720bd10824cc932b8d3a1020d4f04ecafa5d3280d5,
            X,
            0x208f3bc09df6f6eb01595a7d7708a2f7d8dafff813f123a4abdd99dfef2ff3aa
        );

        X = new uint256[](17);
        X[0] = 0x25172cbbd1289dde3d5a3ec6806b7408475968df10e71565ca1ba3579b950bab;
        X[1] = 0x1725a070098a94cf768334d9b0c3ac4a261682687b39c8e6db7ad3c2901d5e24;
        X[2] = 0x26b72d7895ccf170139a9a71e7da7431d81afd3cd5223969d4794ca8b1366241;
        X[3] = 0x2c9493e9d5b214b3cad4bb621544e6001cb1dc10421ede559fb937d89568cd01;
        X[4] = 0x1334cd36b6c002cd14bd1ac0e19bfca3b7fe600634fa22ac5d6fc6b271c50ea1;
        X[5] = 0x24e56409afcdd7500f2608d82db8f7a607cb1c5246aaa03cb30fdab50e6b0131;
        X[6] = 0x27ee3e707f58a066bd5c0c4078fc690de3d108a7f759884c0d890dcf9c71d0ae;
        X[7] = 0x12060dfdd8c1fceaba38ac16288cd391e1bd33e08476edde5dafa859d2bc20c3;
        X[8] = 0x1715421e99f5091ab24230608160f638748e685707ded14d8df5e502eff1c726;
        X[9] = 0x21225c719bfbac3279313676bb52f31d166432319612381d19e29680a23a9e54;
        X[10] = 0x1f5f277e7a112badb02d8cd4794afac553a48acec6eb4895fd4ac287309e0766;
        X[11] = 0x01c6ef7072eae3366e9bac92954116f78dba97d93b34943cdbca7473e03c303c;
        X[12] = 0x2d724a66a4244a6a493bbf6f10e9a1aefce0702e21bc3d1995f4741e0d20e0b6;
        X[13] = 0x287e29cb6788fd94d01ef493dbff1e658619a05ce4fdd1541726bff3cbe8b33b;
        X[14] = 0x106e96134b2e80dc2b4691a8c3ecfc2ea1ef0ab294c5f708cd6774bfeb403009;
        X[15] = 0x2fe84884f541263540ef28f6f103eeccb2413af5378e27d63469466568f56e84;
        X[16] = 0x19a2ee861704322444687829379a8303142709c02feb0f0d56de44c5ab0540e2;
        u_vec[1] = PolyEvalInstanceLib.PolyEvalInstance(
            0x2d55fc82ceddb996f78b7b30aec725b7ff7c9487a1c419c451483c964ca4f758,
            0x3006ae25186226af4f8ca0586a7e3cd80cee52efd4d5ca162652da31e0030db9,
            X,
            0x226815ad4c481c399fdc2ddfa7c916769aeb5d6e39bd30ea2676b738ff7db9d5
        );

        X = new uint256[](17);
        X[0] = 1;
        X[1] = 1;
        X[2] = 1;
        X[3] = 1;
        X[4] = 1;
        X[5] = 1;
        X[6] = 1;
        X[7] = 1;
        X[8] = 1;
        X[9] = 1;
        X[10] = 1;
        X[11] = 1;
        X[12] = 1;
        X[13] = 1;
        X[14] = 1;
        X[15] = 1;
        X[16] = 0;
        u_vec[2] = PolyEvalInstanceLib.PolyEvalInstance(
            0x2d55fc82ceddb996f78b7b30aec725b7ff7c9487a1c419c451483c964ca4f758,
            0x3006ae25186226af4f8ca0586a7e3cd80cee52efd4d5ca162652da31e0030db9,
            X,
            0x20f9914f54e7717576fa749ff16aecd487863ff1c11162499f43c793e44c0a22
        );

        X = new uint256[](17);
        X[0] = 0x1725a070098a94cf768334d9b0c3ac4a261682687b39c8e6db7ad3c2901d5e24;
        X[1] = 0x26b72d7895ccf170139a9a71e7da7431d81afd3cd5223969d4794ca8b1366241;
        X[2] = 0x2c9493e9d5b214b3cad4bb621544e6001cb1dc10421ede559fb937d89568cd01;
        X[3] = 0x1334cd36b6c002cd14bd1ac0e19bfca3b7fe600634fa22ac5d6fc6b271c50ea1;
        X[4] = 0x24e56409afcdd7500f2608d82db8f7a607cb1c5246aaa03cb30fdab50e6b0131;
        X[5] = 0x27ee3e707f58a066bd5c0c4078fc690de3d108a7f759884c0d890dcf9c71d0ae;
        X[6] = 0x12060dfdd8c1fceaba38ac16288cd391e1bd33e08476edde5dafa859d2bc20c3;
        X[7] = 0x1715421e99f5091ab24230608160f638748e685707ded14d8df5e502eff1c726;
        X[8] = 0x21225c719bfbac3279313676bb52f31d166432319612381d19e29680a23a9e54;
        X[9] = 0x1f5f277e7a112badb02d8cd4794afac553a48acec6eb4895fd4ac287309e0766;
        X[10] = 0x01c6ef7072eae3366e9bac92954116f78dba97d93b34943cdbca7473e03c303c;
        X[11] = 0x2d724a66a4244a6a493bbf6f10e9a1aefce0702e21bc3d1995f4741e0d20e0b6;
        X[12] = 0x287e29cb6788fd94d01ef493dbff1e658619a05ce4fdd1541726bff3cbe8b33b;
        X[13] = 0x106e96134b2e80dc2b4691a8c3ecfc2ea1ef0ab294c5f708cd6774bfeb403009;
        X[14] = 0x2fe84884f541263540ef28f6f103eeccb2413af5378e27d63469466568f56e84;
        X[15] = 0x19a2ee861704322444687829379a8303142709c02feb0f0d56de44c5ab0540e2;
        X[16] = 0x053328f9153fa2d3455c13a25004acd66102e6596877a4952854ee2401233022;
        u_vec[3] = PolyEvalInstanceLib.PolyEvalInstance(
            0x2d55fc82ceddb996f78b7b30aec725b7ff7c9487a1c419c451483c964ca4f758,
            0x3006ae25186226af4f8ca0586a7e3cd80cee52efd4d5ca162652da31e0030db9,
            X,
            0x20a26a182fc955d93811ab4e54caeb2de5e66193342ae5e35347c776c47836a9
        );

        X = new uint256[](17);
        X[0] = 0x1725a070098a94cf768334d9b0c3ac4a261682687b39c8e6db7ad3c2901d5e24;
        X[1] = 0x26b72d7895ccf170139a9a71e7da7431d81afd3cd5223969d4794ca8b1366241;
        X[2] = 0x2c9493e9d5b214b3cad4bb621544e6001cb1dc10421ede559fb937d89568cd01;
        X[3] = 0x1334cd36b6c002cd14bd1ac0e19bfca3b7fe600634fa22ac5d6fc6b271c50ea1;
        X[4] = 0x24e56409afcdd7500f2608d82db8f7a607cb1c5246aaa03cb30fdab50e6b0131;
        X[5] = 0x27ee3e707f58a066bd5c0c4078fc690de3d108a7f759884c0d890dcf9c71d0ae;
        X[6] = 0x12060dfdd8c1fceaba38ac16288cd391e1bd33e08476edde5dafa859d2bc20c3;
        X[7] = 0x1715421e99f5091ab24230608160f638748e685707ded14d8df5e502eff1c726;
        X[8] = 0x21225c719bfbac3279313676bb52f31d166432319612381d19e29680a23a9e54;
        X[9] = 0x1f5f277e7a112badb02d8cd4794afac553a48acec6eb4895fd4ac287309e0766;
        X[10] = 0x01c6ef7072eae3366e9bac92954116f78dba97d93b34943cdbca7473e03c303c;
        X[11] = 0x2d724a66a4244a6a493bbf6f10e9a1aefce0702e21bc3d1995f4741e0d20e0b6;
        X[12] = 0x287e29cb6788fd94d01ef493dbff1e658619a05ce4fdd1541726bff3cbe8b33b;
        X[13] = 0x106e96134b2e80dc2b4691a8c3ecfc2ea1ef0ab294c5f708cd6774bfeb403009;
        X[14] = 0x2fe84884f541263540ef28f6f103eeccb2413af5378e27d63469466568f56e84;
        X[15] = 0x19a2ee861704322444687829379a8303142709c02feb0f0d56de44c5ab0540e2;
        X[16] = 0x053328f9153fa2d3455c13a25004acd66102e6596877a4952854ee2401233022;
        u_vec[4] = PolyEvalInstanceLib.PolyEvalInstance(
            0x1ec29657919b0f194b6a69c8265a59633793a45893b7a2b674c6f68e58825c74,
            0x0b3d096f0d640f6dec627235a3dc9f3f8e9f5ca0650e42eb3c16b45252512c5c,
            X,
            0x2513125d4fbe8e638298ed83b477b0b40b06cd1e0fa867700bd0544596a73991
        );

        X = new uint256[](14);
        X[0] = 0x1334cd36b6c002cd14bd1ac0e19bfca3b7fe600634fa22ac5d6fc6b271c50ea1;
        X[1] = 0x24e56409afcdd7500f2608d82db8f7a607cb1c5246aaa03cb30fdab50e6b0131;
        X[2] = 0x27ee3e707f58a066bd5c0c4078fc690de3d108a7f759884c0d890dcf9c71d0ae;
        X[3] = 0x12060dfdd8c1fceaba38ac16288cd391e1bd33e08476edde5dafa859d2bc20c3;
        X[4] = 0x1715421e99f5091ab24230608160f638748e685707ded14d8df5e502eff1c726;
        X[5] = 0x21225c719bfbac3279313676bb52f31d166432319612381d19e29680a23a9e54;
        X[6] = 0x1f5f277e7a112badb02d8cd4794afac553a48acec6eb4895fd4ac287309e0766;
        X[7] = 0x01c6ef7072eae3366e9bac92954116f78dba97d93b34943cdbca7473e03c303c;
        X[8] = 0x2d724a66a4244a6a493bbf6f10e9a1aefce0702e21bc3d1995f4741e0d20e0b6;
        X[9] = 0x287e29cb6788fd94d01ef493dbff1e658619a05ce4fdd1541726bff3cbe8b33b;
        X[10] = 0x106e96134b2e80dc2b4691a8c3ecfc2ea1ef0ab294c5f708cd6774bfeb403009;
        X[11] = 0x2fe84884f541263540ef28f6f103eeccb2413af5378e27d63469466568f56e84;
        X[12] = 0x19a2ee861704322444687829379a8303142709c02feb0f0d56de44c5ab0540e2;
        X[13] = 0x053328f9153fa2d3455c13a25004acd66102e6596877a4952854ee2401233022;
        u_vec[5] = PolyEvalInstanceLib.PolyEvalInstance(
            0x3019a8c784334c0aaf50696e207ffd698bd60a364038a76ac3399250f56d8b54,
            0x26b53798d836b6632563da0058df951fc3b5b282876347560145fdc00331c7e1,
            X,
            0x08d04ce171cf7c61087f116638d0f64e32c8c60d0f084bcc06365d87ed89e142
        );

        X = new uint256[](17);
        X[0] = 0x25172cbbd1289dde3d5a3ec6806b7408475968df10e71565ca1ba3579b950bab;
        X[1] = 0x1725a070098a94cf768334d9b0c3ac4a261682687b39c8e6db7ad3c2901d5e24;
        X[2] = 0x26b72d7895ccf170139a9a71e7da7431d81afd3cd5223969d4794ca8b1366241;
        X[3] = 0x2c9493e9d5b214b3cad4bb621544e6001cb1dc10421ede559fb937d89568cd01;
        X[4] = 0x1334cd36b6c002cd14bd1ac0e19bfca3b7fe600634fa22ac5d6fc6b271c50ea1;
        X[5] = 0x24e56409afcdd7500f2608d82db8f7a607cb1c5246aaa03cb30fdab50e6b0131;
        X[6] = 0x27ee3e707f58a066bd5c0c4078fc690de3d108a7f759884c0d890dcf9c71d0ae;
        X[7] = 0x12060dfdd8c1fceaba38ac16288cd391e1bd33e08476edde5dafa859d2bc20c3;
        X[8] = 0x1715421e99f5091ab24230608160f638748e685707ded14d8df5e502eff1c726;
        X[9] = 0x21225c719bfbac3279313676bb52f31d166432319612381d19e29680a23a9e54;
        X[10] = 0x1f5f277e7a112badb02d8cd4794afac553a48acec6eb4895fd4ac287309e0766;
        X[11] = 0x01c6ef7072eae3366e9bac92954116f78dba97d93b34943cdbca7473e03c303c;
        X[12] = 0x2d724a66a4244a6a493bbf6f10e9a1aefce0702e21bc3d1995f4741e0d20e0b6;
        X[13] = 0x287e29cb6788fd94d01ef493dbff1e658619a05ce4fdd1541726bff3cbe8b33b;
        X[14] = 0x106e96134b2e80dc2b4691a8c3ecfc2ea1ef0ab294c5f708cd6774bfeb403009;
        X[15] = 0x2fe84884f541263540ef28f6f103eeccb2413af5378e27d63469466568f56e84;
        X[16] = 0x19a2ee861704322444687829379a8303142709c02feb0f0d56de44c5ab0540e2;
        u_vec[6] = PolyEvalInstanceLib.PolyEvalInstance(
            0x27f88af1eec0500e566c3e25d6147661e7456b52b2f023f91f421270873d2f92,
            0x03de91147588dfc46735f07ff26fbb05e680de5ee4aa35cd9af42d75e8eee4f7,
            X,
            0x0088669e792dcb64cc9598dbed28620719bebd0129650d26e886bc06dc43d852
        );

        u_vec = Step7Lib.compute_u_vec_padded(u_vec);

        uint256[] memory powers_of_rho = new uint256[](7);
        powers_of_rho[0] = 0x0000000000000000000000000000000000000000000000000000000000000001;
        powers_of_rho[1] = 0x151a9a94b2adc8bc8a39f87e2dc5e3978ee1ec7f2f77e575c858b509faf672b6;
        powers_of_rho[2] = 0x2b904fe0e0e620791a47036a03d37050ac5ec038b55511bac4d0791b05afcb53;
        powers_of_rho[3] = 0x041837e28142baf2c5f23e3200df40eef6072649557aaf32b483d14d8e5832e4;
        powers_of_rho[4] = 0x21fdeac92b0716f8d52ccfec7d4162a665f2e538039d493a43f716b8cc4247b2;
        powers_of_rho[5] = 0x0cd6721a606d1ea112a70eca1fd01a63a57029a9dd5e9181525b2dfe6a159c87;
        powers_of_rho[6] = 0x2bcd16852ef2c9e1530cb8fc0d82ec88154db8f92a2a56f397369679abdf56b9;

        Abstractions.CompressedSnark memory proof = TestUtilities.loadProof();

        uint256 expected = Step7GrumpkinLib.compute_claim_batch_final_right(
            proof.f_W_snark_secondary, r_z, u_vec, powers_of_rho, Grumpkin.P_MOD, Grumpkin.negateBase
        );

        assertEq(expected, 0x1d01f142d5005e21f5ea6976a02b7f27ec4220f6c6437af44102099d82042bf4);
    }

    function test_compute_claim_batch_final_right_primary() public {
        uint256[] memory r_z = new uint256[](17);
        r_z[0] = 0x2da4b53547feb62d12c90ecefd3e94bbc93c1d0f159cf24ae6eb7867fed3e7a3;
        r_z[1] = 0x02ee3b9ead045a852a6b19c976ae565103f1ed542ffb4f22888a8e4aa7a147c6;
        r_z[2] = 0x210748dfc7f2d6bc5c00e524b0d8e8ab5a7306248d0f9e36ef09f2fdde902866;
        r_z[3] = 0x1fbd61038d37831706ba4b60c82946fa2a8c4faacd9449f0016683897542bf7d;
        r_z[4] = 0x25d4afe853d20274f20f8353babf3abb477bc7d294408d7cd7f1c738b615cb13;
        r_z[5] = 0x2ca3277c2b6c6673eed164f0d17171307b96416a2839ab11049d6d3ea7d866b3;
        r_z[6] = 0x0b0f8f2421dffef34434e1e1338972882085f06de43e953e00f2f33986cf2430;
        r_z[7] = 0x0d193c111348687b6160f7d561f1a54b1dfb6b68e6efd22ae4d98f6f7fa493a2;
        r_z[8] = 0x04d614a5037317b11c8ea380b134594e310ff5829149b3dcf84f4f3625ecb355;
        r_z[9] = 0x2d00f949d0c462df8217916d04845fa75bad178242836a3db4b880c14263910b;
        r_z[10] = 0x15a3fc8508c10f84c1ddccf93d1b5f610eb3f775ba26b45e0b2a22faf384528f;
        r_z[11] = 0x2b8a8b4fd8b329e2abdac02a5d473449506e25b6ca0d5e60924d5e0ee03fbbf8;
        r_z[12] = 0x1fbe657c6fd4880b49b6809d57a7fec9d262b21ea43dc73858b5144d1bc957d1;
        r_z[13] = 0x10611b30d9f8551b6a98fdf44ebe7a416f5f1f72309a22bafdb93b48b8d224ef;
        r_z[14] = 0x0a888620997f3d3e5bcc0e8da2977428266271156408b21cff65b5d4ee2061b7;
        r_z[15] = 0x18b05f8b35616fa97ab95e762ceb95008646ebff02d098772d33977d1595bb65;
        r_z[16] = 0x05468de5d19365e6861cda8682f5be36e2ed4ff855554273f6e68a71fe630c40;

        PolyEvalInstanceLib.PolyEvalInstance[] memory u_vec = new PolyEvalInstanceLib.PolyEvalInstance[](7);

        uint256[] memory X = new uint256[](17);
        X[0] = 0x1695fc0c0698b7e920d417e58174c018754f581f9044cd68c11cc2363005e185;
        X[1] = 0x0a6ccda86e557ab8b5e59b7a8c7846f5f0566f3400abec27642881fda5081265;
        X[2] = 0x0460b24e8674040141696541a62f2b6dfcfbaa97708ab547bc07f32ba186024e;
        X[3] = 0x04109fec011ecc9677d7a3e349b785743fa0b1dc96b97781ae2ac8627a37f083;
        X[4] = 0x200ab93f588f3912d94a4553e9c2ae6ee35996c33c41d12d37b387121a2be6d1;
        X[5] = 0x263c8dc77149bdd56e11eb6fc11eeea047eebeb8be056e1b160004160808af65;
        X[6] = 0x0cf3a930fcc8e93caad2c5eec517ff5006d4be7254221fff85c58c97f6d35ee5;
        X[7] = 0x2ba2ec16f6cce727119850fd8b058382a31c326105fe1063f4736b11062df644;
        X[8] = 0x140bedef3716eff22e6e35591c5a54c6cd7aae70c800183ec559a2ce7302fd6a;
        X[9] = 0x033f543b39164994196e6186c8dd6ff338eaa9f4fde0da6f969502a75399299f;
        X[10] = 0x2a6e10ef6ab883dc64c45ebcc6efd99ea862f508b121b1f0ceecf1c77e181769;
        X[11] = 0x19cce4de222eb81d4dd537befeab6e42d32f810b3360cd3247e39d82c6cf37a2;
        X[12] = 0x1f12d996682184b2b8df7e855cab2231e22613b95ca3f2fdc0650809e22350df;
        X[13] = 0x220fe2f07d75e0cc580cf11dc16611f583cc5384842904a98e45cef3b7f409b9;
        X[14] = 0x2612eb3431d63727a69d698bb7278ddff6214191d842de7d6558a6637cd0efcb;
        X[15] = 0x05b94d437287ba864fe667b76b45342b7a01de764d49bd8cb3d4c37ceb9ed6f6;
        X[16] = 0x2e986437477a974632e0ffcd780ddc863a63d78f83c5c9666ebc792ade06dc85;
        u_vec[0] = PolyEvalInstanceLib.PolyEvalInstance(
            0x0de07d3056f2ec32860a2e01306327438a0da14baef711eb336692e4e2a57cfb,
            0x133f96cda3cacff0d041d21ffdd96763158f0cdbe4779c71fccba5e02071de01,
            X,
            0x08353df9bb3663c3258222e99684ee10f83abc2931f0c4e1918a49e75498fc1d
        );

        X = new uint256[](17);
        X[0] = 0x144454412fd8764e4aaf2cec1546f1a9f1f154e7de160d033a632ecdfdd5964d;
        X[1] = 0x05837413e5049a37ef21bc91fd21fcce3f89e80202ec70aa01872cc9221d95cd;
        X[2] = 0x17430b827b82e51b14fcdf9511b6a8061d1392d4589b8221dafbae759dd6e070;
        X[3] = 0x0256f4d5674a529ec39e0afba3738d0263cb1d385a563ce608edad719f47d5fd;
        X[4] = 0x00f87554a6caed435bb9e714a355fa73cfd359d5dd8b31fc172ada8cecd7ee30;
        X[5] = 0x29b4dbb7be87a4961e21fe447b03125469077ba2bad896ac2c374aa55be358ab;
        X[6] = 0x1493591a52ded39471fbcd9937537aae9023e77080708f790798671aaa268fc9;
        X[7] = 0x046d5e95bee7ea383f29e0ffa2a6e2816d5b82a75283265e2bc17e63d6ecaeee;
        X[8] = 0x0ea46d83cda8cac4084d937137ab451e89d3fef4b6e25ec00e80fcb8bf8a5308;
        X[9] = 0x26d16ee1e12b5e781327f54a2b89bb7f397e500ec503066b4e37c5e59c372aa1;
        X[10] = 0x2826c37882e6cec0184d476e6e14ac3cb48aee6e233a1ee085c174d53cf1f419;
        X[11] = 0x1b054f124db95f87ec662a5b8ddf47f2b0264e97ef866a05e2a3e0335bce3b16;
        X[12] = 0x0fd296132bf7fc749c44059331d68c735b05f8f746c26e0bf25c3e0a0e6b17b1;
        X[13] = 0x2aede350fab3723fb2ed55ed281f40e4a718f43237901e99264cb09a586661ef;
        X[14] = 0x1a99798029810bbe8a2a5e0d738e8a7c54c010acf84892178463c3222d08b351;
        X[15] = 0x01611bd374a32895d454f4fbe32f051f82e1fef13242ee7951dc6df7848cef97;
        X[16] = 0x019b91a9d375fe46af22a415a0cba65d78d7a605eecf99b3eff27cd508e6282c;
        u_vec[1] = PolyEvalInstanceLib.PolyEvalInstance(
            0x225b5ed62a6252b52c48074ea887026ad925357d7bbd259875cecc0db9d6ecc7,
            0x05eca5f09c13e5b373b5a9ceaf2414845d8f52392ae90f41de6eb41b08387356,
            X,
            0x186f7f961e265c88569e4360b15d71d9fba3a61e3dce74c3096756292fd35a9f
        );

        X = new uint256[](17);
        X[0] = 1;
        X[1] = 1;
        X[2] = 1;
        X[3] = 1;
        X[4] = 1;
        X[5] = 1;
        X[6] = 1;
        X[7] = 1;
        X[8] = 1;
        X[9] = 1;
        X[10] = 1;
        X[11] = 1;
        X[12] = 1;
        X[13] = 1;
        X[14] = 1;
        X[15] = 1;
        X[16] = 0;
        u_vec[2] = PolyEvalInstanceLib.PolyEvalInstance(
            0x225b5ed62a6252b52c48074ea887026ad925357d7bbd259875cecc0db9d6ecc7,
            0x05eca5f09c13e5b373b5a9ceaf2414845d8f52392ae90f41de6eb41b08387356,
            X,
            0x2038e67614a1ff8e6b4aa9fec97740b2c146a88103dbac18372455d76aa81b87
        );

        X = new uint256[](17);
        X[0] = 0x05837413e5049a37ef21bc91fd21fcce3f89e80202ec70aa01872cc9221d95cd;
        X[1] = 0x17430b827b82e51b14fcdf9511b6a8061d1392d4589b8221dafbae759dd6e070;
        X[2] = 0x0256f4d5674a529ec39e0afba3738d0263cb1d385a563ce608edad719f47d5fd;
        X[3] = 0x00f87554a6caed435bb9e714a355fa73cfd359d5dd8b31fc172ada8cecd7ee30;
        X[4] = 0x29b4dbb7be87a4961e21fe447b03125469077ba2bad896ac2c374aa55be358ab;
        X[5] = 0x1493591a52ded39471fbcd9937537aae9023e77080708f790798671aaa268fc9;
        X[6] = 0x046d5e95bee7ea383f29e0ffa2a6e2816d5b82a75283265e2bc17e63d6ecaeee;
        X[7] = 0x0ea46d83cda8cac4084d937137ab451e89d3fef4b6e25ec00e80fcb8bf8a5308;
        X[8] = 0x26d16ee1e12b5e781327f54a2b89bb7f397e500ec503066b4e37c5e59c372aa1;
        X[9] = 0x2826c37882e6cec0184d476e6e14ac3cb48aee6e233a1ee085c174d53cf1f419;
        X[10] = 0x1b054f124db95f87ec662a5b8ddf47f2b0264e97ef866a05e2a3e0335bce3b16;
        X[11] = 0x0fd296132bf7fc749c44059331d68c735b05f8f746c26e0bf25c3e0a0e6b17b1;
        X[12] = 0x2aede350fab3723fb2ed55ed281f40e4a718f43237901e99264cb09a586661ef;
        X[13] = 0x1a99798029810bbe8a2a5e0d738e8a7c54c010acf84892178463c3222d08b351;
        X[14] = 0x01611bd374a32895d454f4fbe32f051f82e1fef13242ee7951dc6df7848cef97;
        X[15] = 0x019b91a9d375fe46af22a415a0cba65d78d7a605eecf99b3eff27cd508e6282c;
        X[16] = 0x0780ddd1b7bae1a8aff7cf5a352412e2956c573041e9ec3557bca02d7a2e78a1;
        u_vec[3] = PolyEvalInstanceLib.PolyEvalInstance(
            0x225b5ed62a6252b52c48074ea887026ad925357d7bbd259875cecc0db9d6ecc7,
            0x05eca5f09c13e5b373b5a9ceaf2414845d8f52392ae90f41de6eb41b08387356,
            X,
            0x173fdc325f99a0801ed6a4e396d176ba6080c6e83f0898242abaef64108d108f
        );

        X = new uint256[](17);
        X[0] = 0x05837413e5049a37ef21bc91fd21fcce3f89e80202ec70aa01872cc9221d95cd;
        X[1] = 0x17430b827b82e51b14fcdf9511b6a8061d1392d4589b8221dafbae759dd6e070;
        X[2] = 0x0256f4d5674a529ec39e0afba3738d0263cb1d385a563ce608edad719f47d5fd;
        X[3] = 0x00f87554a6caed435bb9e714a355fa73cfd359d5dd8b31fc172ada8cecd7ee30;
        X[4] = 0x29b4dbb7be87a4961e21fe447b03125469077ba2bad896ac2c374aa55be358ab;
        X[5] = 0x1493591a52ded39471fbcd9937537aae9023e77080708f790798671aaa268fc9;
        X[6] = 0x046d5e95bee7ea383f29e0ffa2a6e2816d5b82a75283265e2bc17e63d6ecaeee;
        X[7] = 0x0ea46d83cda8cac4084d937137ab451e89d3fef4b6e25ec00e80fcb8bf8a5308;
        X[8] = 0x26d16ee1e12b5e781327f54a2b89bb7f397e500ec503066b4e37c5e59c372aa1;
        X[9] = 0x2826c37882e6cec0184d476e6e14ac3cb48aee6e233a1ee085c174d53cf1f419;
        X[10] = 0x1b054f124db95f87ec662a5b8ddf47f2b0264e97ef866a05e2a3e0335bce3b16;
        X[11] = 0x0fd296132bf7fc749c44059331d68c735b05f8f746c26e0bf25c3e0a0e6b17b1;
        X[12] = 0x2aede350fab3723fb2ed55ed281f40e4a718f43237901e99264cb09a586661ef;
        X[13] = 0x1a99798029810bbe8a2a5e0d738e8a7c54c010acf84892178463c3222d08b351;
        X[14] = 0x01611bd374a32895d454f4fbe32f051f82e1fef13242ee7951dc6df7848cef97;
        X[15] = 0x019b91a9d375fe46af22a415a0cba65d78d7a605eecf99b3eff27cd508e6282c;
        X[16] = 0x0780ddd1b7bae1a8aff7cf5a352412e2956c573041e9ec3557bca02d7a2e78a1;
        u_vec[4] = PolyEvalInstanceLib.PolyEvalInstance(
            0x22850dc71b502bc6c23a442a7ce89c26942624aec88aecd46297c3a1ae7a93ce,
            0x1eb65c6e2178b3ded9d6b2cc8e755fc062d6a34fe5fc4dc5920dfd4588e4357a,
            X,
            0x0998a56ce3fe9f0fe8e1fcbc2f2d4f8c003fd6444fa20870a0061201ea13b2f5
        );

        X = new uint256[](14);
        X[0] = 0x00f87554a6caed435bb9e714a355fa73cfd359d5dd8b31fc172ada8cecd7ee30;
        X[1] = 0x29b4dbb7be87a4961e21fe447b03125469077ba2bad896ac2c374aa55be358ab;
        X[2] = 0x1493591a52ded39471fbcd9937537aae9023e77080708f790798671aaa268fc9;
        X[3] = 0x046d5e95bee7ea383f29e0ffa2a6e2816d5b82a75283265e2bc17e63d6ecaeee;
        X[4] = 0x0ea46d83cda8cac4084d937137ab451e89d3fef4b6e25ec00e80fcb8bf8a5308;
        X[5] = 0x26d16ee1e12b5e781327f54a2b89bb7f397e500ec503066b4e37c5e59c372aa1;
        X[6] = 0x2826c37882e6cec0184d476e6e14ac3cb48aee6e233a1ee085c174d53cf1f419;
        X[7] = 0x1b054f124db95f87ec662a5b8ddf47f2b0264e97ef866a05e2a3e0335bce3b16;
        X[8] = 0x0fd296132bf7fc749c44059331d68c735b05f8f746c26e0bf25c3e0a0e6b17b1;
        X[9] = 0x2aede350fab3723fb2ed55ed281f40e4a718f43237901e99264cb09a586661ef;
        X[10] = 0x1a99798029810bbe8a2a5e0d738e8a7c54c010acf84892178463c3222d08b351;
        X[11] = 0x01611bd374a32895d454f4fbe32f051f82e1fef13242ee7951dc6df7848cef97;
        X[12] = 0x019b91a9d375fe46af22a415a0cba65d78d7a605eecf99b3eff27cd508e6282c;
        X[13] = 0x0780ddd1b7bae1a8aff7cf5a352412e2956c573041e9ec3557bca02d7a2e78a1;
        u_vec[5] = PolyEvalInstanceLib.PolyEvalInstance(
            0x07fa0663f8e8193e5e4f7e22f873f918f14ce92989e931bbfba951968a111525,
            0x0d3b315227a6a2494ce5c0f81e84fde0d387091a5389f293e06d0834045fb52e,
            X,
            0x07ce63dd203a606986287f23b89f5b68b30d11f0055e12d1f67152d6bf0f6019
        );

        X = new uint256[](17);
        X[0] = 0x144454412fd8764e4aaf2cec1546f1a9f1f154e7de160d033a632ecdfdd5964d;
        X[1] = 0x05837413e5049a37ef21bc91fd21fcce3f89e80202ec70aa01872cc9221d95cd;
        X[2] = 0x17430b827b82e51b14fcdf9511b6a8061d1392d4589b8221dafbae759dd6e070;
        X[3] = 0x0256f4d5674a529ec39e0afba3738d0263cb1d385a563ce608edad719f47d5fd;
        X[4] = 0x00f87554a6caed435bb9e714a355fa73cfd359d5dd8b31fc172ada8cecd7ee30;
        X[5] = 0x29b4dbb7be87a4961e21fe447b03125469077ba2bad896ac2c374aa55be358ab;
        X[6] = 0x1493591a52ded39471fbcd9937537aae9023e77080708f790798671aaa268fc9;
        X[7] = 0x046d5e95bee7ea383f29e0ffa2a6e2816d5b82a75283265e2bc17e63d6ecaeee;
        X[8] = 0x0ea46d83cda8cac4084d937137ab451e89d3fef4b6e25ec00e80fcb8bf8a5308;
        X[9] = 0x26d16ee1e12b5e781327f54a2b89bb7f397e500ec503066b4e37c5e59c372aa1;
        X[10] = 0x2826c37882e6cec0184d476e6e14ac3cb48aee6e233a1ee085c174d53cf1f419;
        X[11] = 0x1b054f124db95f87ec662a5b8ddf47f2b0264e97ef866a05e2a3e0335bce3b16;
        X[12] = 0x0fd296132bf7fc749c44059331d68c735b05f8f746c26e0bf25c3e0a0e6b17b1;
        X[13] = 0x2aede350fab3723fb2ed55ed281f40e4a718f43237901e99264cb09a586661ef;
        X[14] = 0x1a99798029810bbe8a2a5e0d738e8a7c54c010acf84892178463c3222d08b351;
        X[15] = 0x01611bd374a32895d454f4fbe32f051f82e1fef13242ee7951dc6df7848cef97;
        X[16] = 0x019b91a9d375fe46af22a415a0cba65d78d7a605eecf99b3eff27cd508e6282c;
        u_vec[6] = PolyEvalInstanceLib.PolyEvalInstance(
            0x2829fe3f56f139c48a22a3ae7c35a777425e3f578cc81038c7cb0ec519839f6e,
            0x27a0a9319530016b2f890c1cb0d8e956e715477366e11cef729c4aff9a969cfc,
            X,
            0x101e200bd035b257fe90e8d2d1c0df37860d3f49effed18058414ff5ec3d465c
        );

        u_vec = Step7Lib.compute_u_vec_padded(u_vec);

        uint256[] memory powers_of_rho = new uint256[](7);
        powers_of_rho[0] = 0x0000000000000000000000000000000000000000000000000000000000000001;
        powers_of_rho[1] = 0x1dbb16d7c99fa0c175099f6cd1bcbf9565e9d388c5c94a277eeef3d51df045cc;
        powers_of_rho[2] = 0x0f7d64af2e39a15de68d96113a33d887a40dfdaef37121405a0238b2ce3e4968;
        powers_of_rho[3] = 0x0e9d3027ba7e5cc8d86993ead7b2271175434ff805c5da74be476701fc15920f;
        powers_of_rho[4] = 0x1f57da2dd386acff47043972adbd1b1463ca21830fc85264d83f34d5e9e091ba;
        powers_of_rho[5] = 0x0b1699ba7b6ba28b7b5abdd3f34adbcbf240958dca860b105863d78feac70d6c;
        powers_of_rho[6] = 0x0811de85d7bd8bb07b0856440f3d8fe2712aecacfa3959ec8f2e584a4236c481;

        Abstractions.CompressedSnark memory proof = TestUtilities.loadProof();

        uint256 expected = Step7GrumpkinLib.compute_claim_batch_final_right(
            proof.r_W_snark_primary, r_z, u_vec, powers_of_rho, Bn256.R_MOD, Bn256.negateScalar
        );

        assertEq(expected, 0x28bc08980839fb81ec831e4a21f7d8d8cc8ba78585567cf218dad86d74a8096e);
    }
}
