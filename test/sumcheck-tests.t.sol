// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.16;

import "@std/Test.sol";
import "src/blocks/Sumcheck.sol";

contract SumcheckTests is Test {
    function loadSumcheckProofBn256() private pure returns (SumcheckUtilities.SumcheckProof memory) {
        SumcheckUtilities.CompressedUniPoly[] memory polys = new SumcheckUtilities.CompressedUniPoly[](17);

        uint256[] memory poly = new uint256[](2);
        poly[0] = 0x2cb88cda7074d0e915b861660233a7eaad557e0a1c27d7292a5250efea90f15f;
        poly[1] = 0x2fc3a5740ac106a718c73133b9812001c7f657668dc5670e48b71604e8c3e02f;
        polys[0] = SumcheckUtilities.CompressedUniPoly(poly);

        poly = new uint256[](2);
        poly[0] = 0x0162bb804c9e73cceee63639e4f219e33ae7883282b81284db8d80c721b98901;
        poly[1] = 0x2e5db754eb7d8246e5b47a3474445fc185f27da84c67e453596cfed7b2c3261b;
        polys[1] = SumcheckUtilities.CompressedUniPoly(poly);

        poly = new uint256[](2);
        poly[0] = 0x10f4a94f31f2ad9682125790c43c241d9e9f775fa5c4ee3aec76102695f569c4;
        poly[1] = 0x189ee7fe38df1170a65100c43a015fcf0099aeb64d7dcf5b2b5af6cbdf1f5750;
        polys[2] = SumcheckUtilities.CompressedUniPoly(poly);

        poly = new uint256[](2);
        poly[0] = 0x12432bb579b1692186d94f679a32670a15c4469f7106e5dca3d708fc37bad595;
        poly[1] = 0x04e1397a0bba33062b31baf1e4a4193e5fa1b950f3308a4114cd3fd3efd59742;
        polys[3] = SumcheckUtilities.CompressedUniPoly(poly);

        poly = new uint256[](2);
        poly[0] = 0x1b316418f58ed9f85c8a0902a4fb4d48842c7be16c0c77b35e01ec19bfb2e530;
        poly[1] = 0x0e6a6ef6915183f625d3800c329761966b1cd46fdb77e5190ead705018da051d;
        polys[4] = SumcheckUtilities.CompressedUniPoly(poly);

        poly = new uint256[](2);
        poly[0] = 0x27ee77987bd8b8295390bd3d53357b19362f41831dded50c646d16a2a60eded7;
        poly[1] = 0x09c4ff7810ace3bf6e624f4f2f37d5bde560d4eddcfc6c4c50bef949a8dcc8d9;
        polys[5] = SumcheckUtilities.CompressedUniPoly(poly);

        poly = new uint256[](2);
        poly[0] = 0x08e4ec681129eeafe3a7a5b05920c3d70b5c060bfef228e2104cd5919473d1ff;
        poly[1] = 0x16fef613a97b009941a36f7b2bd2dccecfcdd675011c938f530d99d988a1c665;
        polys[6] = SumcheckUtilities.CompressedUniPoly(poly);

        poly = new uint256[](2);
        poly[0] = 0x2ee0540eeeea51f7ed0f9994dc7722e7677ba1d0c5b61cc480cb446e10c53d1b;
        poly[1] = 0x0b8f7a6b7ea7a31c1fd866bf619ec45c42347cbae46d13d32b8ab874b4a4c2f6;
        polys[7] = SumcheckUtilities.CompressedUniPoly(poly);

        poly = new uint256[](2);
        poly[0] = 0x0417843133a94addb6e41868992f778d0c8301d1cb3c3345126865760b1d0326;
        poly[1] = 0x0cbc0dfe6ac3745c9f5a9eb90d4faabf5cacb461d0e181ca9a92e7dd5ecc3630;
        polys[8] = SumcheckUtilities.CompressedUniPoly(poly);

        poly = new uint256[](2);
        poly[0] = 0x101ce79b8dd349bb192d8f9116ef309fdda02b0249f621ce23b963bb3a4e5564;
        poly[1] = 0x15ab3dd82b53832d167d427c7e5246fd539bb1a0a15bf3c1b4430c01180e82b9;
        polys[9] = SumcheckUtilities.CompressedUniPoly(poly);

        poly = new uint256[](2);
        poly[0] = 0x1da34f6eee4c35777ea6b1e0a348e2425fa9a80b7a31304b2dcf97414951403a;
        poly[1] = 0x0726ed95b29ecd536dee4faff0b5fc028f849df10a9ef90e55fcf208b3e8992f;
        polys[10] = SumcheckUtilities.CompressedUniPoly(poly);

        poly = new uint256[](2);
        poly[0] = 0x15d0e3e94e435d5dda30a788cd7488eb1854918cba412a7c86f91aea4421647d;
        poly[1] = 0x28ca7be78b6a09f6fc240f731a885271290dcabea59f880e1aeb4db1346dbe52;
        polys[11] = SumcheckUtilities.CompressedUniPoly(poly);

        poly = new uint256[](2);
        poly[0] = 0x151c25c9221de5fea2cf4a3a806f65f63876c58a790ea501242b486621c96c24;
        poly[1] = 0x1a23357373d56f16f5b9c27ddea7230596fa452547c6048a4a00c55849dc8b63;
        polys[12] = SumcheckUtilities.CompressedUniPoly(poly);

        poly = new uint256[](2);
        poly[0] = 0x1889cdce52633016f199554932439c40b6c44a63c3da9b9f79345cc089d5a8b7;
        poly[1] = 0x0687d7529a88e6db2307d3ee089dee043099c0a4ad7aea91f9952a9ff5fddd39;
        polys[13] = SumcheckUtilities.CompressedUniPoly(poly);

        poly = new uint256[](2);
        poly[0] = 0x271946107ddc4f905b2883a81d69cc96770bc08c47b9d2989226542d08374f7e;
        poly[1] = 0x135f9e6a420f4a4c89fd407f51fec5715f212d758c56cf5dff6b56be512d885c;
        polys[14] = SumcheckUtilities.CompressedUniPoly(poly);

        poly = new uint256[](2);
        poly[0] = 0x23b96a78557bbacecbf603a43ef94661f9e94b142d3978929b4712719778f62d;
        poly[1] = 0x2947b44b5ccf14180b9e9a9f99d18467c7efd734075d2bbe3d80ba201084f41c;
        polys[15] = SumcheckUtilities.CompressedUniPoly(poly);

        poly = new uint256[](2);
        poly[0] = 0x203c906ff3d09060c38c150e18b380bd6241a9bf7ea209d30db068aba3078ccc;
        poly[1] = 0x011cb30cc0b34d4823f704981977c4bdc3a12016ead11edd5287fbf075928633;
        polys[16] = SumcheckUtilities.CompressedUniPoly(poly);

        return SumcheckUtilities.SumcheckProof(polys);
    }

    function testSumcheckBn256() public {
        SumcheckUtilities.SumcheckProof memory proof = loadSumcheckProofBn256();
        uint256 claim_batch_joint = 0x17327cf20e588d94a8d1a34b607a09a6c74188d43fe6294b670ea76383009bc2;

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
        uint256 num_rounds_z = 17;

        uint256 claim_batch_joint_actual;
        uint256[] memory r_z_actual;
        (claim_batch_joint_actual, r_z_actual, transcript) =
            SumcheckBn256.verify(proof, claim_batch_joint, num_rounds_z, 2, transcript);

        uint256 claim_batch_final_expected = 0x28bc08980839fb81ec831e4a21f7d8d8cc8ba78585567cf218dad86d74a8096e;
        uint256[] memory r_z_expected = new uint256[](num_rounds_z);
        r_z_expected[0] = 0x2da4b53547feb62d12c90ecefd3e94bbc93c1d0f159cf24ae6eb7867fed3e7a3;
        r_z_expected[1] = 0x02ee3b9ead045a852a6b19c976ae565103f1ed542ffb4f22888a8e4aa7a147c6;
        r_z_expected[2] = 0x210748dfc7f2d6bc5c00e524b0d8e8ab5a7306248d0f9e36ef09f2fdde902866;
        r_z_expected[3] = 0x1fbd61038d37831706ba4b60c82946fa2a8c4faacd9449f0016683897542bf7d;
        r_z_expected[4] = 0x25d4afe853d20274f20f8353babf3abb477bc7d294408d7cd7f1c738b615cb13;
        r_z_expected[5] = 0x2ca3277c2b6c6673eed164f0d17171307b96416a2839ab11049d6d3ea7d866b3;
        r_z_expected[6] = 0x0b0f8f2421dffef34434e1e1338972882085f06de43e953e00f2f33986cf2430;
        r_z_expected[7] = 0x0d193c111348687b6160f7d561f1a54b1dfb6b68e6efd22ae4d98f6f7fa493a2;
        r_z_expected[8] = 0x04d614a5037317b11c8ea380b134594e310ff5829149b3dcf84f4f3625ecb355;
        r_z_expected[9] = 0x2d00f949d0c462df8217916d04845fa75bad178242836a3db4b880c14263910b;
        r_z_expected[10] = 0x15a3fc8508c10f84c1ddccf93d1b5f610eb3f775ba26b45e0b2a22faf384528f;
        r_z_expected[11] = 0x2b8a8b4fd8b329e2abdac02a5d473449506e25b6ca0d5e60924d5e0ee03fbbf8;
        r_z_expected[12] = 0x1fbe657c6fd4880b49b6809d57a7fec9d262b21ea43dc73858b5144d1bc957d1;
        r_z_expected[13] = 0x10611b30d9f8551b6a98fdf44ebe7a416f5f1f72309a22bafdb93b48b8d224ef;
        r_z_expected[14] = 0x0a888620997f3d3e5bcc0e8da2977428266271156408b21cff65b5d4ee2061b7;
        r_z_expected[15] = 0x18b05f8b35616fa97ab95e762ceb95008646ebff02d098772d33977d1595bb65;
        r_z_expected[16] = 0x05468de5d19365e6861cda8682f5be36e2ed4ff855554273f6e68a71fe630c40;

        assertEq(claim_batch_joint_actual, claim_batch_final_expected);
        assertEq(r_z_actual.length, r_z_expected.length);
        for (uint256 index = 0; index < num_rounds_z; index++) {
            assertEq(r_z_expected[index], r_z_actual[index]);
        }
    }

    function loadSumcheckProofGrumpkin() private pure returns (SumcheckUtilities.SumcheckProof memory) {
        SumcheckUtilities.CompressedUniPoly[] memory polys = new SumcheckUtilities.CompressedUniPoly[](17);

        uint256[] memory poly = new uint256[](2);
        poly[0] = 0x1b0d37af60e28b1596ec77275cba184fa6a27dff7c347d44d98d19d5a3f3bd3d;
        poly[1] = 0x19802e5ea9dafb11f743eb43716e79f37c789b57b1b00ea449dbdc6f04ab9b6b;
        polys[0] = SumcheckUtilities.CompressedUniPoly(poly);

        poly = new uint256[](2);
        poly[0] = 0x2d378e9b49f5f4860100f40327789d686238bd8810f179bbbae815fd25c9ef43;
        poly[1] = 0x18a845dd111372c0119e8d1fc6aac66042cf93ba5879a3c95fc245e3dcefa230;
        polys[1] = SumcheckUtilities.CompressedUniPoly(poly);

        poly = new uint256[](2);
        poly[0] = 0x2364646dd2dbfcce18c0c763d9cab23d94f3250991d1c8cccb6845590d77896c;
        poly[1] = 0x2ade6948a404b8c4664c31ccded25d4663babe51c5645629452c7df3648d0321;
        polys[2] = SumcheckUtilities.CompressedUniPoly(poly);

        poly = new uint256[](2);
        poly[0] = 0x0847fae886949c3213a3d28b2c001990f477611026038d43eda53ddbc39c9521;
        poly[1] = 0x2d045e7db376b31ff268396361ca58f115a3239b223a2b9e86b9eb2ec33af377;
        polys[3] = SumcheckUtilities.CompressedUniPoly(poly);

        poly = new uint256[](2);
        poly[0] = 0x1e114defaee4634772d44605960c69774c391901e87d05fbb482a878d5b828cd;
        poly[1] = 0x1da41dc7c237eea3fb05b5338888b50dca059c8d390dbee25ddf462b9299cb2d;
        polys[4] = SumcheckUtilities.CompressedUniPoly(poly);

        poly = new uint256[](2);
        poly[0] = 0x1021e441635b8647624cfffbaec46a004035aaa93bf27252b5e58f64954f7a4a;
        poly[1] = 0x1fb4b0bc6b92850061649d216c8fd20ab14852ff91ad442f0a9ce0b41f6ae8e8;
        polys[5] = SumcheckUtilities.CompressedUniPoly(poly);

        poly = new uint256[](2);
        poly[0] = 0x1d91b866179a441cd23c7286907d829b78b1c9d9450df2b82d0d1d989e411826;
        poly[1] = 0x0936bf1de7143e7377b0ff33a6a7a6b0ec885ca377ab6ab405745a7b8e5cab1a;
        polys[6] = SumcheckUtilities.CompressedUniPoly(poly);

        poly = new uint256[](2);
        poly[0] = 0x16fd96f5262a2f4e8a94e0519fc362651e23f8de99b3caf796890c9f9549fd4a;
        poly[1] = 0x0a0a854fc54c00bfe91f9e46598f90d232df5b6ba9fabe40b305ead9127aa0e5;
        polys[7] = SumcheckUtilities.CompressedUniPoly(poly);

        poly = new uint256[](2);
        poly[0] = 0x10c096a88e501c982a43e06bf915a00f83c222d75a0e25fcad57343d85a9a275;
        poly[1] = 0x136c07c92d8654af68f51d7a96ca1c8fdd12ff03044514d8bffdb87c304910db;
        polys[8] = SumcheckUtilities.CompressedUniPoly(poly);

        poly = new uint256[](2);
        poly[0] = 0x0a41b82351e4fc1bf2d771f3b5b583dfa8ade85688488af9ae35cf61b00a1ebe;
        poly[1] = 0x2fbaa3e27f21d957e2e6569259e0be9bfcb6da9d4f402cf3d3bbaf600cc261bf;
        polys[9] = SumcheckUtilities.CompressedUniPoly(poly);

        poly = new uint256[](2);
        poly[0] = 0x0bc68776b8fc9d9d4d2d5065127045d035fcd5560d9b618d600ece28c38f0b14;
        poly[1] = 0x0560bd07837f382632e4e6beb6de58c4947bd4ce18aed19ec7bed7ab02165bcd;
        polys[10] = SumcheckUtilities.CompressedUniPoly(poly);

        poly = new uint256[](2);
        poly[0] = 0x1bfc9f59708386db1ed2c5b4c744fe82a077012bcf6018bfc5c7d51d4de52bf6;
        poly[1] = 0x016f2f418e5e7faaddf505f19a74bc5fdbfd27b7e807875040dafca22cbfdf55;
        polys[11] = SumcheckUtilities.CompressedUniPoly(poly);

        poly = new uint256[](2);
        poly[0] = 0x12ac31e13a35825d0ff3aa960049591c68dd7a23b7003ffe5f6d22d3dbf3dd8f;
        poly[1] = 0x20498768f0ccbb348ffe954acab72b7f931843b55419461efd64aadbd39a632b;
        polys[12] = SumcheckUtilities.CompressedUniPoly(poly);

        poly = new uint256[](2);
        poly[0] = 0x1aa5e9c768e90fdaedc6c334e0fa6509f880a8afdcbada154fa7d6c2868e700d;
        poly[1] = 0x21afb8283733c31b406c456bd694be932df60865aaa4b90ea096e27166737f92;
        polys[13] = SumcheckUtilities.CompressedUniPoly(poly);

        poly = new uint256[](2);
        poly[0] = 0x1071fc4bd92ca1c137aa89d0910cba1ea548b26fed0604d3f071076fa69bf74e;
        poly[1] = 0x1966d30b0205d6de5e20f710553c750e7172fb52b92a32731870401f75956b71;
        polys[14] = SumcheckUtilities.CompressedUniPoly(poly);

        poly = new uint256[](2);
        poly[0] = 0x14ad6e0b46d9b59b342aac46c8d1148962729df2f879f67e118be2f0928c03ba;
        poly[1] = 0x206ada83c370d6c75b9e0f1c29d8ae87c066eec223b0a5214351658dc8ef82d3;
        polys[15] = SumcheckUtilities.CompressedUniPoly(poly);

        poly = new uint256[](2);
        poly[0] = 0x072c3bc6f8332a63f263549220d394a84fcef27341f3408c109c599f07d97e43;
        poly[1] = 0x134cb4270f78e101fac442a000eabb3771bdd50dd4d276b9d6980599fd015804;
        polys[16] = SumcheckUtilities.CompressedUniPoly(poly);

        return SumcheckUtilities.SumcheckProof(polys);
    }

    function testSumcheckGrumpkin() public {
        SumcheckUtilities.SumcheckProof memory proof = loadSumcheckProofGrumpkin();
        uint256 claim_batch_joint = 0x14172dd27cbf1b2e93412a545e1948697533ef38539aa340bf476019bb6ecf6a;

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
        uint256 num_rounds_z = 17;

        uint256 claim_batch_joint_actual;
        uint256[] memory r_z_actual;
        (claim_batch_joint_actual, r_z_actual, transcript) =
            SumcheckGrumpkin.verify(proof, claim_batch_joint, num_rounds_z, 2, transcript);

        uint256 claim_batch_final_expected = 0x1d01f142d5005e21f5ea6976a02b7f27ec4220f6c6437af44102099d82042bf4;
        uint256[] memory r_z_expected = new uint256[](num_rounds_z);
        r_z_expected[0] = 0x212329f6462c4d3d4f55b683c4c11a46c67256b9858b95c77c4b168e17388429;
        r_z_expected[1] = 0x21dfc25a981fd369e19088e8b49ad309cc313820865b2e1417f952dbb5ee9641;
        r_z_expected[2] = 0x273561b6235f8c4fc11611a7b98d8e79cd6e9d1cd17d5ef9d64810ade3ab9faf;
        r_z_expected[3] = 0x0eb446efa9d3d67aaf4d934007ccc391eb8b625d79ec431687944848ae4f1b15;
        r_z_expected[4] = 0x0806aeeb3c99719384c162a2baa1e246a2f0acedbc6587e90ae23528415a728b;
        r_z_expected[5] = 0x0f0b6acbe5159a78eb79787b0a66a30eb93d4cc8af3b186bc294aab0366f089a;
        r_z_expected[6] = 0x26cfe04f93d95279500732655810ab241cd6528598740b1d8f26cf9b50c61852;
        r_z_expected[7] = 0x07142170b23263cd61979e619d76ae0e798597b2d98c2e15dd9d564d3dcccd19;
        r_z_expected[8] = 0x27f3f2b4802274bc60c6ad244651cee35c90456aa92be7f00312dca8027d5d1f;
        r_z_expected[9] = 0x22751a37e3c6910427c6ea662144f35b5abdd0eb6e0b695eecfa734ab38fa4f5;
        r_z_expected[10] = 0x254e42a15ad6a9e0ca3c2a57c8c0de3257476e2fd9ebb905151501a01fe6fe1b;
        r_z_expected[11] = 0x1eccda56960d3be98801ad1b9353b61c839b5d7750349fe88ad54c3359af5efc;
        r_z_expected[12] = 0x2c267c6dcb97a97a8b7546ac4f50b7228acd93bd98c2f439948ffe2496994feb;
        r_z_expected[13] = 0x288378d51fbd1d9a33ef19d19dd210d626f11b34faf5f35b6f223c36916546f2;
        r_z_expected[14] = 0x2245068b115bfddbada3fd3b489aced772f48290a43273987c59fd577177ef9d;
        r_z_expected[15] = 0x302c7f4b52e3378bfc76422ede556c4903162bda34195e7568ec097a6fcb0384;
        r_z_expected[16] = 0x0de92231a46fb2c6eb97cd5565125775ff3151b4ae69acd99a0c25189fb06e70;

        assertEq(claim_batch_joint_actual, claim_batch_final_expected);
        assertEq(r_z_actual.length, r_z_expected.length);
        for (uint256 index = 0; index < num_rounds_z; index++) {
            assertEq(r_z_expected[index], r_z_actual[index]);
        }
    }

    function testSumcheckGrumpkinAssembly() public {
        SumcheckUtilities.SumcheckProof memory proof = loadSumcheckProofGrumpkin();
        uint256 claim_batch_joint = 0x14172dd27cbf1b2e93412a545e1948697533ef38539aa340bf476019bb6ecf6a;

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
        uint256 num_rounds_z = 17;

        uint256 claim_batch_joint_expected;
        uint256[] memory r_z_expected;

        uint256 gasCost = gasleft();
        (claim_batch_joint_expected, r_z_expected, transcript) =
            SumcheckGrumpkin.verify(proof, claim_batch_joint, num_rounds_z, 2, transcript);
        console.log("gas cost: ", gasCost - uint256(gasleft()));

        gasCost = gasleft();
        (uint256 claim_batch_joint_actual, uint256[] memory r_z_actual) = sumcheck_verify_assembly(
            proof,
            claim_batch_joint,
            num_rounds_z,
            2,
            rounds,
            0x80a41dfcf069595ae322d0cc67d90ad67a7934ab84e4c3b1d2ab6345198a1fdc,
            0x077ce9c99e2791c893f1e11248bb1c964178e7f6862b6a3a5429051f7ae0e281,
            GRUMPKIN_P_MOD
        );
        console.log("gas cost (assembly): ", gasCost - uint256(gasleft()));

        assertEq(claim_batch_joint_actual, claim_batch_joint_expected);
        assertEq(r_z_actual.length, r_z_expected.length);
        for (uint256 index = 0; index < num_rounds_z; index++) {
            assertEq(r_z_expected[index], r_z_actual[index]);
        }
    }

    function testSumcheckBn256Assembly() public {
        SumcheckUtilities.SumcheckProof memory proof = loadSumcheckProofBn256();
        uint256 claim_batch_joint = 0x17327cf20e588d94a8d1a34b607a09a6c74188d43fe6294b670ea76383009bc2;

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
        uint256 num_rounds_z = 17;

        uint256 claim_batch_joint_expected;
        uint256[] memory r_z_expected;

        uint256 gasCost = gasleft();
        (claim_batch_joint_expected, r_z_expected, transcript) =
            SumcheckBn256.verify(proof, claim_batch_joint, num_rounds_z, 2, transcript);
        console.log("gas cost: ", gasCost - uint256(gasleft()));

        gasCost = gasleft();
        (uint256 claim_batch_joint_actual, uint256[] memory r_z_actual) = sumcheck_verify_assembly(
            proof,
            claim_batch_joint,
            num_rounds_z,
            2,
            rounds,
            0xa77b23e11c3b95d79eeedd4e75db66dbfec22f0de96a3e19323b676136907194,
            0xf1e1899f4a2e330a19d1da1d30f11c2a05a4d4bb0f4ff5aa38c82c933986dfc8,
            BN256_P_MOD
        );
        console.log("gas cost (assembly): ", gasCost - uint256(gasleft()));

        assertEq(claim_batch_joint_actual, claim_batch_joint_expected);
        assertEq(r_z_actual.length, r_z_expected.length);
        for (uint256 index = 0; index < num_rounds_z; index++) {
            assertEq(r_z_expected[index], r_z_actual[index]);
        }
    }

    // Constants
    uint256 private constant GRUMPKIN_P_MOD = 0x30644e72e131a029b85045b68181585d97816a916871ca8d3c208c16d87cfd47;
    uint256 private constant GRUMPKIN_INV = 0x87d20782e4866389;
    uint256 private constant GRUMPKIN_MODULUS_0 = 0x3c208c16d87cfd47;
    uint256 private constant GRUMPKIN_MODULUS_1 = 0x97816a916871ca8d;
    uint256 private constant GRUMPKIN_MODULUS_2 = 0xb85045b68181585d;
    uint256 private constant GRUMPKIN_MODULUS_3 = 0x30644e72e131a029;
    uint256 public constant GRUMPKIN_R2 = 0x0e0a77c19a07df2f666ea36f7879462c0a78eb28f5c70b3dd35d438dc58f0d9d;
    uint256 public constant GRUMPKIN_R3 = 0x06d89f71cab8351f47ab1eff0a417ff6b5e71911d44501fbf32cfc5b538afa89;
    uint256 private constant BN256_P_MOD = 0x30644e72e131a029b85045b68181585d2833e84879b9709143e1f593f0000001;
    uint256 private constant BN256_INV = 0xc2e1f593efffffff;
    uint256 private constant BN256_MODULUS_0 = 0x43e1f593f0000001;
    uint256 private constant BN256_MODULUS_1 = 0x2833e84879b97091;
    uint256 private constant BN256_MODULUS_2 = 0xb85045b68181585d;
    uint256 private constant BN256_MODULUS_3 = 0x30644e72e131a029;
    uint256 public constant BN256_R2 = 0x0e0a77c19a07df2f666ea36f7879462e36fc76959f60cd29ac96341c4ffffffb;
    uint256 public constant BN256_R3 = 0x0216d0b17f4e44a58c49833d53bb808553fe3ab1e35c59e31bb8e645ae216da7;
    uint256 private constant SCALAR_UNIFORM_BYTE_SIZE = 64;
    uint256 private constant PERSONA_TAG = 0x4e6f5452;
    uint256 private constant DOM_SEP_TAG = 0x4e6f4453;
    uint256 private constant KECCAK256_PREFIX_CHALLENGE_LO = 0x00;
    uint256 private constant KECCAK256_PREFIX_CHALLENGE_HI = 0x01;
    uint256 public constant KECCAK_TRANSCRIPT_STATE_BYTE_LEN = 64;

    // Errors
    bytes4 internal constant ABSORB_INPUTS_LABELS_SIZE_MISMATCH = 0x2f94e9a8;
    bytes4 internal constant ABSORB_INPUTS_LABELS_OUT_OF_BOUND_INDEX = 0x6ce876d0;
    bytes4 internal constant ROUND_OVERFLOW = 0x9ab982d5;
    bytes4 internal constant WRONG_CURVE_MODULUS_HAS_BEEN_USED = 0x49a7f6ee;
    bytes4 internal constant NUM_ROUNDS_SUMCHECK_POLYS_LENGTH_ERROR = 0x6c62aed8;
    bytes4 internal constant UNI_POLY_DEGREE_BOUND_MISMATCH = 0x090abb27;
    bytes4 internal constant ZERO_ONE_EVALS_SUM_E_MISMATCH = 0x71dffba2;

    // Storage pointers
    uint256 internal constant ROUND = 0x200 + 0x12c0 + 0x00;
    uint256 internal constant STATE_LO = 0x200 + 0x12c0 + 0x20;
    uint256 internal constant STATE_HI = 0x200 + 0x12c0 + 0x40;
    uint256 internal constant TRANSCRIPT = 0x200 + 0x12c0 + 0x60;

    function sumcheck_verify_assembly(
        SumcheckUtilities.SumcheckProof memory proof,
        uint256 claim,
        uint256 num_rounds,
        uint256 degree_bound,
        uint256 round_input,
        uint256 stateLo_input,
        uint256 stateHi_input,
        uint256 curve_p_mod
    ) private returns (uint256 e, uint256[] memory r) {
        r = new uint256[](proof.compressed_polys.length);
        assembly {
            function mac(a, b, c, carry) -> ret1, ret2 {
                let bc := mulmod(b, c, 0xffffffffffffffffffffffffffffffff)
                let a_add_bc :=
                    addmod(a, mulmod(b, c, 0xffffffffffffffffffffffffffffffff), 0xffffffffffffffffffffffffffffffff)
                let a_add_bc_add_carry :=
                    addmod(
                        addmod(a, mulmod(b, c, 0xffffffffffffffffffffffffffffffff), 0xffffffffffffffffffffffffffffffff),
                        carry,
                        0xffffffffffffffffffffffffffffffff
                    )
                // cast ret1 from uint128 to uint64
                ret1 := and(a_add_bc_add_carry, 0xffffffffffffffff)
                ret2 := shr(64, a_add_bc_add_carry)
            }

            function adc(a, b, carry) -> ret1, ret2 {
                let a_add_b := addmod(a, b, 0xffffffffffffffffffffffffffffffff)
                let a_add_b_add_carry :=
                    addmod(addmod(a, b, 0xffffffffffffffffffffffffffffffff), carry, 0xffffffffffffffffffffffffffffffff)
                // cast ret1 from uint128 to uint64
                ret1 := and(a_add_b_add_carry, 0xffffffffffffffff)
                ret2 := shr(64, a_add_b_add_carry)
            }

            function sbb(a, b, borrow) -> ret1, ret2 {
                let shift := shr(63, borrow)
                let b_add_borrow_shifted := addmod(b, shift, 0xffffffffffffffffffffffffffffffff)
                let a_minus := sub(a, b_add_borrow_shifted)
                a_minus := and(a_minus, 0xffffffffffffffffffffffffffffffff)

                ret1 := and(a_minus, 0xffffffffffffffff)
                ret2 := shr(64, a_minus)
            }

            function reverse(_input) -> _output {
                _output := _input
                _output :=
                    or(
                        shr(8, and(_output, 0xFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00)),
                        shl(8, and(_output, 0x00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF))
                    )
                _output :=
                    or(
                        shr(16, and(_output, 0xFFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000)),
                        shl(16, and(_output, 0x0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF))
                    )
                _output :=
                    or(
                        shr(32, and(_output, 0xFFFFFFFF00000000FFFFFFFF00000000FFFFFFFF00000000FFFFFFFF00000000)),
                        shl(32, and(_output, 0x00000000FFFFFFFF00000000FFFFFFFF00000000FFFFFFFF00000000FFFFFFFF))
                    )
                _output :=
                    or(
                        shr(64, and(_output, 0xFFFFFFFFFFFFFFFF0000000000000000FFFFFFFFFFFFFFFF0000000000000000)),
                        shl(64, and(_output, 0x0000000000000000FFFFFFFFFFFFFFFF0000000000000000FFFFFFFFFFFFFFFF))
                    )
                _output := or(shr(128, _output), shl(128, _output))
            }

            function montgomeryReduceGrumpkin(_r0, _r1, _r2, _r3) -> _d {
                let r0 := _r0
                let r1 := _r1
                let r2 := _r2
                let r3 := _r3
                let r4 := 0
                let r5 := 0
                let r6 := 0
                let r7 := 0

                let k := mulmod(r0, GRUMPKIN_INV, 0x10000000000000000) // wrapping_mul over u64 (Rust)
                let carry := 0
                let carry2 := 0

                carry2, carry := mac(r0, k, GRUMPKIN_MODULUS_0, 0) // carry2 is used as a stub
                r1, carry := mac(r1, k, GRUMPKIN_MODULUS_1, carry)
                r2, carry := mac(r2, k, GRUMPKIN_MODULUS_2, carry)
                r3, carry := mac(r3, k, GRUMPKIN_MODULUS_3, carry)
                r4, carry2 := adc(r4, 0, carry)

                k := mulmod(r1, GRUMPKIN_INV, 0x10000000000000000) // wrapping_mul over u64 (Rust)
                r0, carry := mac(r1, k, GRUMPKIN_MODULUS_0, 0) // r0 used as a stub
                r2, carry := mac(r2, k, GRUMPKIN_MODULUS_1, carry)
                r3, carry := mac(r3, k, GRUMPKIN_MODULUS_2, carry)
                r4, carry := mac(r4, k, GRUMPKIN_MODULUS_3, carry)
                r5, carry2 := adc(r5, carry2, carry)

                k := mulmod(r2, GRUMPKIN_INV, 0x10000000000000000) // wrapping_mul over u64 (Rust)
                r0, carry := mac(r2, k, GRUMPKIN_MODULUS_0, 0) // r0 used as a stub
                r3, carry := mac(r3, k, GRUMPKIN_MODULUS_1, carry)
                r4, carry := mac(r4, k, GRUMPKIN_MODULUS_2, carry)
                r5, carry := mac(r5, k, GRUMPKIN_MODULUS_3, carry)
                r6, carry2 := adc(r6, carry2, carry)

                k := mulmod(r3, GRUMPKIN_INV, 0x10000000000000000) // wrapping_mul over u64 (Rust)
                r0, carry := mac(r3, k, GRUMPKIN_MODULUS_0, 0) // r0 used as a stub
                r4, carry := mac(r4, k, GRUMPKIN_MODULUS_1, carry)
                r5, carry := mac(r5, k, GRUMPKIN_MODULUS_2, carry)
                r6, carry := mac(r6, k, GRUMPKIN_MODULUS_3, carry)
                r7, r0 := adc(r7, carry2, carry) // r0 used as a stub

                // Result may be within MODULUS of the correct value

                // use carry as borrow; r0 as d0, r1 as d1, r2 as d2, r3 as d3
                carry2 := 0
                r0, carry2 := sbb(r4, GRUMPKIN_MODULUS_0, carry2)
                r1, carry2 := sbb(r5, GRUMPKIN_MODULUS_1, carry2)
                r2, carry2 := sbb(r6, GRUMPKIN_MODULUS_2, carry2)
                r3, carry2 := sbb(r7, GRUMPKIN_MODULUS_3, carry2)

                // If underflow occurred on the final limb, borrow = 0xfff...fff, otherwise
                // borrow = 0x000...000. Thus, we use it as a mask to conditionally add the modulus.
                carry := 0
                r0, carry := adc(r0, and(GRUMPKIN_MODULUS_0, carry2), carry)
                r1, carry := adc(r1, and(GRUMPKIN_MODULUS_1, carry2), carry)
                r2, carry := adc(r2, and(GRUMPKIN_MODULUS_2, carry2), carry)
                r3, carry := adc(r3, and(GRUMPKIN_MODULUS_3, carry2), carry)

                _d := r0
                _d := xor(shl(64, r1), _d)
                _d := xor(shl(128, r2), _d)
                _d := xor(shl(192, r3), _d)
            }

            function montgomeryReduceBn256(_r0, _r1, _r2, _r3) -> _d {
                let r0 := _r0
                let r1 := _r1
                let r2 := _r2
                let r3 := _r3
                let r4 := 0
                let r5 := 0
                let r6 := 0
                let r7 := 0

                let k := mulmod(r0, BN256_INV, 0x10000000000000000) // wrapping_mul over u64 (Rust)
                let carry := 0
                let carry2 := 0

                carry2, carry := mac(r0, k, BN256_MODULUS_0, 0) // carry2 is used as a stub
                r1, carry := mac(r1, k, BN256_MODULUS_1, carry)
                r2, carry := mac(r2, k, BN256_MODULUS_2, carry)
                r3, carry := mac(r3, k, BN256_MODULUS_3, carry)
                r4, carry2 := adc(r4, 0, carry)

                k := mulmod(r1, BN256_INV, 0x10000000000000000) // wrapping_mul over u64 (Rust)
                r0, carry := mac(r1, k, BN256_MODULUS_0, 0) // r0 used as a stub
                r2, carry := mac(r2, k, BN256_MODULUS_1, carry)
                r3, carry := mac(r3, k, BN256_MODULUS_2, carry)
                r4, carry := mac(r4, k, BN256_MODULUS_3, carry)
                r5, carry2 := adc(r5, carry2, carry)

                k := mulmod(r2, BN256_INV, 0x10000000000000000) // wrapping_mul over u64 (Rust)
                r0, carry := mac(r2, k, BN256_MODULUS_0, 0) // r0 used as a stub
                r3, carry := mac(r3, k, BN256_MODULUS_1, carry)
                r4, carry := mac(r4, k, BN256_MODULUS_2, carry)
                r5, carry := mac(r5, k, BN256_MODULUS_3, carry)
                r6, carry2 := adc(r6, carry2, carry)

                k := mulmod(r3, BN256_INV, 0x10000000000000000) // wrapping_mul over u64 (Rust)
                r0, carry := mac(r3, k, BN256_MODULUS_0, 0) // r0 used as a stub
                r4, carry := mac(r4, k, BN256_MODULUS_1, carry)
                r5, carry := mac(r5, k, BN256_MODULUS_2, carry)
                r6, carry := mac(r6, k, BN256_MODULUS_3, carry)
                r7, r0 := adc(r7, carry2, carry) // r0 used as a stub

                // Result may be within MODULUS of the correct value

                // use carry as borrow; r0 as d0, r1 as d1, r2 as d2, r3 as d3
                carry2 := 0
                r0, carry2 := sbb(r4, BN256_MODULUS_0, carry2)
                r1, carry2 := sbb(r5, BN256_MODULUS_1, carry2)
                r2, carry2 := sbb(r6, BN256_MODULUS_2, carry2)
                r3, carry2 := sbb(r7, BN256_MODULUS_3, carry2)

                // If underflow occurred on the final limb, borrow = 0xfff...fff, otherwise
                // borrow = 0x000...000. Thus, we use it as a mask to conditionally add the modulus.
                carry := 0
                r0, carry := adc(r0, and(BN256_MODULUS_0, carry2), carry)
                r1, carry := adc(r1, and(BN256_MODULUS_1, carry2), carry)
                r2, carry := adc(r2, and(BN256_MODULUS_2, carry2), carry)
                r3, carry := adc(r3, and(BN256_MODULUS_3, carry2), carry)

                _d := r0
                _d := xor(shl(64, r1), _d)
                _d := xor(shl(128, r2), _d)
                _d := xor(shl(192, r3), _d)
            }

            function fromUniform(_d0, _d1, _p_mod) -> result {
                let d0 := _d0
                let d1 := _d1
                let modulus := _p_mod

                let d0_limb1 := and(d0, 0x000000000000000000000000000000000000000000000000ffffffffffffffff)
                let d0_limb2 := and(shr(64, d0), 0x000000000000000000000000000000000000000000000000ffffffffffffffff)
                let d0_limb3 := and(shr(128, d0), 0x000000000000000000000000000000000000000000000000ffffffffffffffff)
                let d0_limb4 := and(shr(192, d0), 0x000000000000000000000000000000000000000000000000ffffffffffffffff)

                let d1_limb1 := and(d1, 0x000000000000000000000000000000000000000000000000ffffffffffffffff)
                let d1_limb2 := and(shr(64, d1), 0x000000000000000000000000000000000000000000000000ffffffffffffffff)
                let d1_limb3 := and(shr(128, d1), 0x000000000000000000000000000000000000000000000000ffffffffffffffff)
                let d1_limb4 := and(shr(192, d1), 0x000000000000000000000000000000000000000000000000ffffffffffffffff)

                let r2 := 0
                let r3 := 0

                if eq(modulus, GRUMPKIN_P_MOD) {
                    r2 := GRUMPKIN_R2
                    r3 := GRUMPKIN_R3
                    d0 := montgomeryReduceGrumpkin(d0_limb1, d0_limb2, d0_limb3, d0_limb4)
                    d1 := montgomeryReduceGrumpkin(d1_limb1, d1_limb2, d1_limb3, d1_limb4)
                }
                if eq(modulus, BN256_P_MOD) {
                    r2 := BN256_R2
                    r3 := BN256_R3
                    d0 := montgomeryReduceBn256(d0_limb1, d0_limb2, d0_limb3, d0_limb4)
                    d1 := montgomeryReduceBn256(d1_limb1, d1_limb2, d1_limb3, d1_limb4)
                }

                // if r2 is not set, it means that neither Grumpkin nor BN256 modulus is used which is not supported
                if eq(r2, 0) {
                    mstore(0x00, WRONG_CURVE_MODULUS_HAS_BEEN_USED)
                    revert(0x00, 0x04)
                }

                d0 := mulmod(d0, r2, modulus)
                d1 := mulmod(d1, r3, modulus)
                result := addmod(d0, d1, modulus)
            }

            function compute_total_transcript_length(_input_length) -> _len {
                _len := add(_len, 4) // 4 bytes of DOM_SEP_TAG
                _len := add(_len, 2) // 2 bytes of round variable
                _len := add(_len, 32) // 32 bytes of STATE_LO
                _len := add(_len, 32) // 32 bytes of STATE_HI
                _len := add(_len, 1) // 1 bytes of absorb label
                _len := add(_len, 1) // 1 byte of squeeze label
                _len := add(_len, _input_length) // input length in bytes
                _len := add(_len, 1) // 1 byte of LO/HI prefix
            }

            function squeeze(_transcript_address, offset_, _squeeze_label_byte) -> _offset_ {
                _offset_ := offset_

                // copy DOM_SEP_TAG
                mstore8(add(_transcript_address, _offset_), and(0xff, shr(24, DOM_SEP_TAG)))
                mstore8(add(_transcript_address, add(_offset_, 1)), and(0xff, shr(16, DOM_SEP_TAG)))
                mstore8(add(_transcript_address, add(_offset_, 2)), and(0xff, shr(8, DOM_SEP_TAG)))
                mstore8(add(_transcript_address, add(_offset_, 3)), and(0xff, DOM_SEP_TAG))
                _offset_ := add(_offset_, 4)

                // append round
                mstore8(add(_transcript_address, _offset_), and(0xff, mload(ROUND)))
                mstore8(add(_transcript_address, add(_offset_, 1)), and(0xff, shr(8, mload(ROUND))))
                _offset_ := add(_offset_, 2)

                // append state
                mstore(add(_transcript_address, _offset_), mload(STATE_LO))
                mstore(add(_transcript_address, add(_offset_, 32)), mload(STATE_HI))
                _offset_ := add(_offset_, 64)

                // append squeeze label (in reference implementation we know it is a single byte)
                mstore8(add(_transcript_address, _offset_), _squeeze_label_byte)
                _offset_ := add(_offset_, 1)

                // increment round
                let round := mload(ROUND)
                if eq(round, 0xffff) {
                    mstore(0x00, ROUND_OVERFLOW)
                    revert(0x00, 0x04)
                }
                mstore(ROUND, add(round, 1))

                // update state
                mstore8(add(_transcript_address, _offset_), KECCAK256_PREFIX_CHALLENGE_LO)
                mstore(STATE_LO, keccak256(add(TRANSCRIPT, 32), mload(TRANSCRIPT)))

                mstore8(add(_transcript_address, _offset_), KECCAK256_PREFIX_CHALLENGE_HI)
                mstore(STATE_HI, keccak256(add(TRANSCRIPT, 32), mload(TRANSCRIPT)))
            }

            function eval_at_one(_poly, _linear_term, _modulus) -> output {
                let poly_length := mload(_poly)
                let index := 1
                let mPtr := mload(0x40)
                mstore(mPtr, add(1, poly_length))
                mstore(add(mPtr, 32), mload(add(_poly, 32)))
                mstore(add(mPtr, 64), _linear_term)

                index := 1
                for {} lt(index, poly_length) {} {
                    mstore(add(mPtr, add(64, mul(32, index))), mload(add(_poly, add(32, mul(32, index)))))
                    index := add(index, 1)
                }

                index := 0
                for {} lt(index, mload(mPtr)) {} {
                    output := addmod(output, mload(add(add(mPtr, 32), mul(32, index))), _modulus)
                    index := add(index, 1)
                }
            }
            function eval_at_zero(_poly) -> output {
                output := mload(add(_poly, 32))
            }

            function degree(_poly) -> output {
                output := mload(_poly)
            }

            function evaluate(_poly, _linear_term, _r, _modulus) -> _output {
                let poly_length := mload(_poly)
                let index := 1
                let mPtr := mload(0x40)
                mstore(mPtr, add(1, poly_length))
                mstore(add(mPtr, 32), mload(add(_poly, 32)))
                mstore(add(mPtr, 64), _linear_term)

                index := 1
                for {} lt(index, poly_length) {} {
                    mstore(add(mPtr, add(64, mul(32, index))), mload(add(_poly, add(32, mul(32, index)))))
                    index := add(index, 1)
                }

                index := 1
                let power := _r
                _output := mload(add(mPtr, 32))
                for {} lt(index, mload(mPtr)) {} {
                    _output :=
                        addmod(_output, mulmod(power, mload(add(add(mPtr, 32), mul(32, index))), _modulus), _modulus)
                    power := mulmod(power, _r, _modulus)
                    index := add(index, 1)
                }
            }

            function compute_linear_term(_proof_poly, _e, _modulus) -> _linear_term {
                let poly_length := mload(_proof_poly)
                let temp := addmod(mload(add(_proof_poly, 32)), mload(add(_proof_poly, 32)), _modulus)
                _linear_term := addmod(_e, sub(_modulus, mod(temp, _modulus)), _modulus)

                let j := 1
                for {} lt(j, poly_length) {} {
                    _linear_term :=
                        addmod(
                            _linear_term,
                            sub(_modulus, mod(mload(add(_proof_poly, add(32, mul(32, j)))), _modulus)),
                            _modulus
                        )
                    j := add(j, 1)
                }
            }

            e := claim

            let pointer := mload(proof)
            let length := mload(pointer)

            if iszero(eq(length, num_rounds)) {
                mstore(0x00, NUM_ROUNDS_SUMCHECK_POLYS_LENGTH_ERROR)
                revert(0x00, 0x04)
            }

            // initialize transcript with the given stateLo / stateHi and rounds number
            mstore(ROUND, round_input)
            mstore(STATE_LO, stateLo_input)
            mstore(STATE_HI, stateHi_input)

            let i := 0
            let proof_poly := 0
            let linear_term := 0
            for {} lt(i, length) {} {
                // decompress //////
                proof_poly := mload(add(pointer, add(32, mul(32, i))))
                proof_poly := mload(proof_poly)
                linear_term := compute_linear_term(proof_poly, e, curve_p_mod)
                //////////////////////////////////////////////////////

                if iszero(eq(degree(proof_poly), degree_bound)) {
                    mstore(0x00, UNI_POLY_DEGREE_BOUND_MISMATCH)
                    revert(0x00, 0x04)
                }

                if iszero(
                    eq(
                        addmod(eval_at_zero(proof_poly), eval_at_one(proof_poly, linear_term, curve_p_mod), curve_p_mod),
                        e
                    )
                ) {
                    mstore(0x00, ZERO_ONE_EVALS_SUM_E_MISMATCH)
                    revert(0x00, 0x04)
                }

                // compute r[i] (using transcript)
                let offset := 0
                let total_transcript_length := compute_total_transcript_length(mul(32, mload(proof_poly)))
                mstore(TRANSCRIPT, total_transcript_length)
                offset := add(offset, 32)

                // absorb label (0x70)
                mstore8(add(TRANSCRIPT, offset), 0x70)
                offset := add(offset, 1)

                // absorb input
                let j := 0
                let proof_poly_coeff := mload(add(proof_poly, 32))
                for {} lt(j, 32) {} {
                    mstore8(add(add(TRANSCRIPT, offset), j), byte(sub(31, j), proof_poly_coeff))
                    j := add(j, 1)
                }
                offset := add(offset, 32)

                j := 0
                proof_poly_coeff := mload(add(proof_poly, 64))
                for {} lt(j, 32) {} {
                    mstore8(add(add(TRANSCRIPT, offset), j), byte(sub(31, j), proof_poly_coeff))
                    j := add(j, 1)
                }
                offset := add(offset, 32)

                // squeeze label (0x63)
                offset := squeeze(TRANSCRIPT, offset, 0x63)

                // r[i] computing
                mstore(
                    add(r, add(32, mul(32, i))),
                    fromUniform(reverse(mload(STATE_LO)), reverse(mload(STATE_HI)), curve_p_mod)
                )
                //////////////////////////////////////////////////////

                // evaluate
                e := evaluate(proof_poly, linear_term, mload(add(r, add(32, mul(32, i)))), curve_p_mod)
                //////////////////////////////////////////////////////

                i := add(i, 1)
            }
        }
    }

    function testSumcheckUtilitiesEvaluate() public {
        uint256[] memory _poly = new uint256[](2);
        _poly[0] = 0x1b0d37af60e28b1596ec77275cba184fa6a27dff7c347d44d98d19d5a3f3bd3d;
        _poly[1] = 0x25452cfad3824a44dec4dc2f36394e91da792d047a652f2d3a92682d1fd5b413;
        SumcheckUtilities.UniPoly memory poly = SumcheckUtilities.UniPoly(_poly);
        uint256 r = 0x212329f6462c4d3d4f55b683c4c11a46c67256b9858b95c77c4b168e17388429;

        uint256 expected = SumcheckUtilities.evaluate(poly, r, Grumpkin.P_MOD);
        uint256 actual = evaluate_assembly(poly, r, Grumpkin.P_MOD);
        assertEq(expected, actual);
    }

    function evaluate_assembly(SumcheckUtilities.UniPoly memory poly, uint256 r, uint256 modulus)
        public
        returns (uint256 output)
    {
        assembly {
            let index := 1
            let pointer := mload(poly)
            let length := mload(pointer)
            let power := r
            output := mload(add(pointer, 32))
            for {} lt(index, length) {} {
                output := addmod(output, mulmod(power, mload(add(add(pointer, 32), mul(32, index))), modulus), modulus)
                power := mulmod(power, r, modulus)
                index := add(index, 1)
            }
        }
    }

    function testEvalAtZero() public {
        uint256[] memory _poly = new uint256[](2);
        _poly[0] = 0x1b0d37af60e28b1596ec77275cba184fa6a27dff7c347d44d98d19d5a3f3bd3d;
        _poly[1] = 0x25452cfad3824a44dec4dc2f36394e91da792d047a652f2d3a92682d1fd5b413;
        SumcheckUtilities.UniPoly memory poly = SumcheckUtilities.UniPoly(_poly);

        assertEq(SumcheckUtilities.evalAtZero(poly), eval_at_zero_assembly(poly));
    }

    function eval_at_zero_assembly(SumcheckUtilities.UniPoly memory poly) public returns (uint256 output) {
        assembly {
            output := mload(poly)
            output := mload(add(output, 32))
        }
    }

    function testEvalAtOne() public {
        uint256[] memory _poly = new uint256[](2);
        _poly[0] = 0x1b0d37af60e28b1596ec77275cba184fa6a27dff7c347d44d98d19d5a3f3bd3d;
        _poly[1] = 0x25452cfad3824a44dec4dc2f36394e91da792d047a652f2d3a92682d1fd5b413;
        SumcheckUtilities.UniPoly memory poly = SumcheckUtilities.UniPoly(_poly);

        assertEq(SumcheckUtilities.evalAtOne(poly, Grumpkin.P_MOD), eval_at_one_assembly(poly, Grumpkin.P_MOD));
    }

    function eval_at_one_assembly(SumcheckUtilities.UniPoly memory poly, uint256 modulus)
        public
        returns (uint256 output)
    {
        assembly {
            let index := 0
            let pointer := mload(poly)
            let length := mload(pointer)
            for {} lt(index, length) {} {
                output := addmod(output, mload(add(add(pointer, 32), mul(32, index))), modulus)
                index := add(index, 1)
            }
        }
    }

    function testDegree() public {
        uint256[] memory _poly = new uint256[](2);
        _poly[0] = 0x1b0d37af60e28b1596ec77275cba184fa6a27dff7c347d44d98d19d5a3f3bd3d;
        _poly[1] = 0x25452cfad3824a44dec4dc2f36394e91da792d047a652f2d3a92682d1fd5b413;
        SumcheckUtilities.UniPoly memory poly = SumcheckUtilities.UniPoly(_poly);

        assertEq(SumcheckUtilities.degree(poly), degree_assembly(poly));
    }

    function degree_assembly(SumcheckUtilities.UniPoly memory poly) public returns (uint256 output) {
        assembly {
            output := mload(poly)
            output := mload(output)
            output := sub(output, 1)
        }
    }

    function testDecompress() public {
        SumcheckUtilities.SumcheckProof memory proof = loadSumcheckProofGrumpkin();
        uint256 e = 0x14172dd27cbf1b2e93412a545e1948697533ef38539aa340bf476019bb6ecf6a;
        SumcheckUtilities.UniPoly memory expected =
            SumcheckUtilities.decompress(proof.compressed_polys[0], e, Grumpkin.P_MOD, Grumpkin.negateBase);
        SumcheckUtilities.UniPoly memory actual = decompress_assembly(proof.compressed_polys[0], e, Grumpkin.P_MOD);

        assertEq(expected.coeffs.length, actual.coeffs.length);
        for (uint256 index = 0; index < expected.coeffs.length; index++) {
            assertEq(expected.coeffs[index], actual.coeffs[index]);
        }
    }

    function decompress_assembly(SumcheckUtilities.CompressedUniPoly memory poly, uint256 hint, uint256 modulus)
        internal
        returns (SumcheckUtilities.UniPoly memory)
    {
        uint256[] memory result_ = new uint256[](poly.coeffs_except_linear_term.length + 1);
        SumcheckUtilities.UniPoly memory result = SumcheckUtilities.UniPoly(result_);

        assembly {
            let pointer := mload(poly)
            let length := mload(pointer)
            let temp := addmod(mload(add(pointer, 32)), mload(add(pointer, 32)), modulus)

            let linear_term := addmod(hint, sub(modulus, mod(temp, modulus)), modulus)

            let index := 1
            for {} lt(index, length) {} {
                linear_term :=
                    addmod(linear_term, sub(modulus, mod(mload(add(pointer, add(32, mul(32, index)))), modulus)), modulus)
                index := add(index, 1)
            }

            mstore(add(result_, 32), mload(add(pointer, 32)))
            mstore(add(result_, 64), linear_term)

            index := 1
            for {} lt(index, length) {} {
                mstore(add(result_, add(64, mul(32, index))), mload(add(pointer, add(32, mul(32, index)))))
                index := add(index, 1)
            }
        }
        return result;
    }
}
