// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@std/Test.sol";
import "src/verifier/step4/KeccakTranscript.sol";
import "src/verifier/step4/inner-product-argument/InnerProductArgument.sol";
import "src/verifier/step2/Step2Data.sol";
import "src/verifier/step4/inner-product-argument/CksPrimary.sol";

contract InnerProductArgumentEvaluation is Test {
    function testIpaPrimaryPart1() public {
        uint16 rounds = 60;
        uint8[] memory state = new uint8[](KeccakTranscriptLib.KECCAK_TRANSCRIPT_STATE_BYTE_LEN);
        state[0] = 0x3a; state[1] = 0x4f; state[2] = 0x4d; state[3] = 0xc4; state[4] = 0x36; state[5] = 0x84; state[6] = 0xbd; state[7] = 0x21;
        state[8] = 0xc7; state[9] = 0x7e; state[10] = 0x40; state[11] = 0xa4; state[12] = 0xd1; state[13] = 0xb9; state[14] = 0xc2; state[15] = 0x55;
        state[16] = 0x9f; state[17] = 0xa6; state[18] = 0x38; state[19] = 0x39; state[20] = 0x8b; state[21] = 0x6e; state[22] = 0x98; state[23] = 0xaa;
        state[24] = 0x94; state[25] = 0xd3; state[26] = 0xde; state[27] = 0x64; state[28] = 0x66; state[29] = 0x2f; state[30] = 0x28; state[31] = 0x8f;
        state[32] = 0x91; state[33] = 0x55; state[34] = 0xc3; state[35] = 0xb0; state[36] = 0x12; state[37] = 0xc4; state[38] = 0x2b; state[39] = 0xaf;
        state[40] = 0x41; state[41] = 0x2d; state[42] = 0xe1; state[43] = 0xc4; state[44] = 0x9d; state[45] = 0x37; state[46] = 0x59; state[47] = 0x9c;
        state[48] = 0xcb; state[49] = 0xdb; state[50] = 0x92; state[51] = 0xeb; state[52] = 0x19; state[53] = 0x32; state[54] = 0x85; state[55] = 0x86;
        state[56] = 0xea; state[57] = 0x7e; state[58] = 0x55; state[59] = 0xb3; state[60] = 0xf8; state[61] = 0xa2; state[62] = 0x26; state[63] = 0x7c;

        uint8[] memory transcriptField = new uint8[](0);

        KeccakTranscriptLib.KeccakTranscript memory transcript = KeccakTranscriptLib.KeccakTranscript(rounds, state, transcriptField);

        uint256[] memory point = new uint256[](14);
        point[0] = 0x3900c2e0deca23f4261cf2b1fe25f55af15923fef096beb075597dc4484bdab4;
        point[1] = 0x19e64de64844ab77589ff14fe0d6aca79619e6ac8bb5e023355bdfbec1314299;
        point[2] = 0x023fc05d9c0afe68dee83dd08e45a162b2f9ec0008919c9bb6b74fd973c51e6e;
        point[3] = 0x15ba95ba2f4526812a66b6e929046889148f89ba98ed0955b5e1ef591196b617;
        point[4] = 0x2066410ddf6e0e8ee798b299ce080d37def2d64c7be907169deb62a939761ed2;
        point[5] = 0x001b94cfc1f4b004e1e50c1aff284d0f679402e4e8c741e6e63f6c159b53eb85;
        point[6] = 0x0b95f517c6afa96f9f7a6f38c881586cd55fffd7c8ccf5242bddb08f1ddf6224;
        point[7] = 0x191b78b4877a497460a9315e98b81468001c2b1efa033998a42bff8aa8522dba;
        point[8] = 0x1e672c36421ca2d681987997ffd76f5f2e8fe4793e87c691105160a257dbfac3;
        point[9] = 0x2f2f07e78df3c7658f5a66187821f9af743a1925c1a1d83af6b0dd33d1d8f0e8;
        point[10] = 0x0044b6fa5582115839d186d62373ccef34252fac77680e4626cc0d02130714a6;
        point[11] = 0x0b9b8c6e8dfdee36ee28b4db606180747d182379fcada2bc01047d3a714c6f62;
        point[12] = 0x2d38d3d07e03b3c211a22c63ba0c70986775fba207afb1b6c11e1b978ba4af8d;
        point[13] = 0x12a8ad443674d792661c7b457eec3d0583b4f493b9218ca57c9231c7d379c5f2;

        uint256 comm_X = 0x2b2fa56fd3898c55f5f4e3f9e9a5cc392fb893f80fb3af409f0f1a4ab081f008;
        uint256 comm_Y = 0x14a1b19a679f2e4864c4b4fb94cfdb477af27150a50b2817b260a22d301d655b;
        uint256 comm_Z = 0x288e9249fbaa51a5c16ddae7e054f8dfa2cce3a015f27f14916acd64e7afdd6f;
        CommitmentLib.Commitment memory comm = CommitmentLib.Commitment(comm_X, comm_Y, comm_Z);

        uint256 eval = 0x2788f05348aaeeda8148e6ced6b56610c7875bd5ba4beb36295a761929c85a09;

        Pallas.PallasAffinePoint[] memory ck_c = new Pallas.PallasAffinePoint[](1);
        ck_c[0] = Pallas.PallasAffinePoint(0x34991a1bf54a8ce4de76e5419972931af90acca00c8df563758b76e277e11ea2, 0x25fef079b4c7a147b29b08de1cd3499f320c6a879f4b7035217fded82142183a);

        Pallas.PallasAffinePoint memory tmpP;
        (transcript, tmpP) = InnerProductArgumentLib.verifyPrimaryPart1(transcript, point, comm, eval, ck_c);

        uint256 expectedRounds = 61;
        uint256 PxExpected = 0x02bb7ae2962528a4766d564cf780cfea3623c0b2b982055b2604eabd999d69aa;
        uint256 PyExpected = 0x3f0c0086da4d6bfddec956be5186e35d0a9d8814764e67ce4a0d8b88ed2fc230;
        uint8[] memory stateExpected = new uint8[](KeccakTranscriptLib.KECCAK_TRANSCRIPT_STATE_BYTE_LEN);
        stateExpected[0] = 0xa0; stateExpected[1] = 0x74; stateExpected[2] = 0x0c; stateExpected[3] = 0x92; stateExpected[4] = 0x69; stateExpected[5] = 0x6c; stateExpected[6] = 0x82; stateExpected[7] = 0xda;
        stateExpected[8] = 0x60; stateExpected[9] = 0x04; stateExpected[10] = 0x8e; stateExpected[11] = 0x59; stateExpected[12] = 0x10; stateExpected[13] = 0x33; stateExpected[14] = 0xdc; stateExpected[15] = 0xb3;
        stateExpected[16] = 0x36; stateExpected[17] = 0x99; stateExpected[18] = 0x04; stateExpected[19] = 0x72; stateExpected[20] = 0x41; stateExpected[21] = 0x66; stateExpected[22] = 0xdf; stateExpected[23] = 0x22;
        stateExpected[24] = 0xa3; stateExpected[25] = 0xc0; stateExpected[26] = 0x74; stateExpected[27] = 0x76; stateExpected[28] = 0x14; stateExpected[29] = 0x9a; stateExpected[30] = 0x0f; stateExpected[31] = 0xc8;
        stateExpected[32] = 0x5b; stateExpected[33] = 0xa2; stateExpected[34] = 0xc5; stateExpected[35] = 0x47; stateExpected[36] = 0x8f; stateExpected[37] = 0xa1; stateExpected[38] = 0xda; stateExpected[39] = 0xef;
        stateExpected[40] = 0x4c; stateExpected[41] = 0xff; stateExpected[42] = 0x82; stateExpected[43] = 0xe7; stateExpected[44] = 0x34; stateExpected[45] = 0xd5; stateExpected[46] = 0x61; stateExpected[47] = 0x36;
        stateExpected[48] = 0x77; stateExpected[49] = 0x51; stateExpected[50] = 0x3e; stateExpected[51] = 0x05; stateExpected[52] = 0x33; stateExpected[53] = 0x1d; stateExpected[54] = 0xcd; stateExpected[55] = 0xb9;
        stateExpected[56] = 0x64; stateExpected[57] = 0x83; stateExpected[58] = 0x6b; stateExpected[59] = 0x21; stateExpected[60] = 0x09; stateExpected[61] = 0xd5; stateExpected[62] = 0x54; stateExpected[63] = 0xfc;

        assertEq(tmpP.x, PxExpected);
        assertEq(tmpP.y, PyExpected);
        assertEq(transcript.transcript.length, 0);
        assertEq(expectedRounds, transcript.round);
        for (uint256 i = 0; i < transcript.state.length; i++) {
            assertEq(transcript.state[i], stateExpected[i]);
        }
    }

    function testIpaPrimaryPart2() public {
        uint256 pointLength = 14;

        uint256[] memory L_vec = new uint256[](14);
        L_vec[0] = 0xcb80d53dae10b6f77728411bd1ccab9f99674333168dc870a0dd8c2d6258101d;
        L_vec[1] = 0x7d99828914155672485c740c019bc0df4cff6641d5e85fe3357902bdfaf9e2b7;
        L_vec[2] = 0xc712a2f9e99e313746ae7e652ae6dc1b4e8173b5534704f9395e47b6ebd291ae;
        L_vec[3] = 0x593bed706cd580064b4e7151dc5ffe5160ed2309e1a917b86921fdb53fc36510;
        L_vec[4] = 0x4f429a8a010172facb892e3560498dc48039e0ecaf9dc4320670ba8ef6d1811b;
        L_vec[5] = 0xddcddd632faed2063a2ec54c7e1bedd4981185b3c944e1e36a2674914a95963d;
        L_vec[6] = 0x34498787480ede5d844c2ac31eceb1076b00bc6d8e206f7731b1ac1b6b084c1e;
        L_vec[7] = 0x5eae7bcfbb3770b11892f8843a0bba99c82e9764b6a917dafd5388048a64c2b3;
        L_vec[8] = 0x8939a6664414f8ea9fc60583f3cde95bda3abdb62aaa394d17dee28dc857fc96;
        L_vec[9] = 0x8591ac70ff417e20e3be7ec54c2e99bc8cb887eaa7b927f674ff01fe050aa482;
        L_vec[10] = 0xe1387711a2fa0d2251a0c306c51999431bd44415e64adc22da5c773247d34015;
        L_vec[11] = 0xf33e8885415a3a3bf10d4b87e7f6ddd73ec2073914d235a6b5e8e3e7628f210c;
        L_vec[12] = 0xd65fbb10b046abc565cd2907fca296bfd2408c590862bc89542f456f939ea804;
        L_vec[13] = 0xc4101de3bec37f996bbea4bba2075039b281d82d0953383a2332eccde304561d;

        uint256[] memory R_vec = new uint256[](14);
        R_vec[0] = 0x0b2ed0f5a73abf974d366f38da23dd01e4f62c222c90cb0a5dfa8d1381c6e497;
        R_vec[1] = 0xde0ffaa2b8bec1ce879660629753d2a4a063788eea25d0c03c4169a192b6d930;
        R_vec[2] = 0x41ca8d6c927f1705e78d0c85eeb7116174a654a5b02cb519105aaf65deddc230;
        R_vec[3] = 0x93a9a059dd9307543607ab9cf1dc86e61e107aac24a6e1285562ca3081c23501;
        R_vec[4] = 0x0387f0cde8aa6f5202abf8b384bd9ea22c097740d8a935754159a9ba51f3f486;
        R_vec[5] = 0xba57256f4aece2d009e152fe4ce62790f70fb71e6a6bd26fdba83ccd8de50e17;
        R_vec[6] = 0x3334786ee74efec2394fecf919070e75c268f329d69ab043825cbaceed9413ad;
        R_vec[7] = 0x6979d8f41d3ac76ccc293a9845b95491bad0aa03a433ea4aea06a03b27d141bb;
        R_vec[8] = 0x48822ab783b31994cb952608c97c19215c424b136376b8571cb3b4e47d4a0d22;
        R_vec[9] = 0x9d45056e78cf45140937d01957ca4c79ef81daab778501fd991c6a786d31d52b;
        R_vec[10] = 0x4f00dd5a1553ed52b6a302eb3d32386ef8e8d2fae53a938b79d8f032f15c3124;
        R_vec[11] = 0x0dc1259c30e3032002fb2d4c42f31ab153a1613dd9fd41ac7b1dc4881bcb8e8d;
        R_vec[12] = 0x2521d83b6bbbf2e9fb4f8d67d3383b80a156f78602ec04a4cde4b89ae2311dac;
        R_vec[13] = 0x4b5d75dcd9edc7958ef2faabd2f1529bb7238c4e992daf3ab8852a90160e8d92;

        uint8[] memory state = new uint8[](KeccakTranscriptLib.KECCAK_TRANSCRIPT_STATE_BYTE_LEN);
        state[0] = 0xa0; state[1] = 0x74; state[2] = 0x0c; state[3] = 0x92; state[4] = 0x69; state[5] = 0x6c; state[6] = 0x82; state[7] = 0xda;
        state[8] = 0x60; state[9] = 0x04; state[10] = 0x8e; state[11] = 0x59; state[12] = 0x10; state[13] = 0x33; state[14] = 0xdc; state[15] = 0xb3;
        state[16] = 0x36; state[17] = 0x99; state[18] = 0x04; state[19] = 0x72; state[20] = 0x41; state[21] = 0x66; state[22] = 0xdf; state[23] = 0x22;
        state[24] = 0xa3; state[25] = 0xc0; state[26] = 0x74; state[27] = 0x76; state[28] = 0x14; state[29] = 0x9a; state[30] = 0x0f; state[31] = 0xc8;
        state[32] = 0x5b; state[33] = 0xa2; state[34] = 0xc5; state[35] = 0x47; state[36] = 0x8f; state[37] = 0xa1; state[38] = 0xda; state[39] = 0xef;
        state[40] = 0x4c; state[41] = 0xff; state[42] = 0x82; state[43] = 0xe7; state[44] = 0x34; state[45] = 0xd5; state[46] = 0x61; state[47] = 0x36;
        state[48] = 0x77; state[49] = 0x51; state[50] = 0x3e; state[51] = 0x05; state[52] = 0x33; state[53] = 0x1d; state[54] = 0xcd; state[55] = 0xb9;
        state[56] = 0x64; state[57] = 0x83; state[58] = 0x6b; state[59] = 0x21; state[60] = 0x09; state[61] = 0xd5; state[62] = 0x54; state[63] = 0xfc;

        uint16 rounds = 61;
        uint8[] memory transcriptField = new uint8[](0);

        KeccakTranscriptLib.KeccakTranscript memory transcript = KeccakTranscriptLib.KeccakTranscript(rounds, state, transcriptField);

        Pallas.PallasAffinePoint[] memory ck = CkvPrimaryLib.loadData();

        Pallas.PallasAffinePoint memory ck_hat;
        uint256[] memory s;
        uint256[] memory r_squared;
        uint256[] memory r_inverted_squared;
        (transcript, s, r_squared, r_inverted_squared, ck_hat) = InnerProductArgumentLib.verifyPrimaryPart2(transcript, pointLength, L_vec, R_vec, ck);

        assertEq(s.length, 2 ** pointLength);
        assertEq(s[0], 0x2a710a4626f20706bc4fa73243c14c57afdfb788c3db3f7591b099c3c035c645);
        assertEq(s[18], 0x3f08fb39874efb42c0f7376bade048d084eb5f78c0e17916a3c751dfc471108e);
        assertEq(s[149], 0x221ee0a585b40b23cd93df494bcb1a50a2571808c5760ee21202db3e33fde60f);
        assertEq(s[1912], 0x06914328cc1ecefd96c79e3c33c0cc3cb0bbb47bc1bac1a3b931a0d22094ddf8);
        assertEq(s[10050], 0x2959519898d82f3dc82a3a1a909ced8571523e64ffcc57daebc0e28eab915893);
        assertEq(s[16000], 0x13d3c5b6539d1b7a947dc4436bc31891fbc84028bcb61ce6df0cf6e1f0794291);
        // those assertions do not work, due to OutOfGas exception that occurs while 'ck_hat' computing
        //assertEq(ck_hat.x, 0x28eb5074894b7d5eac05f3aa85f40489d2160a2beb6f9a62464f24c410f9e6ca);
        //assertEq(ck_hat.y, 0x3fa0824a3a35daa5cce2a8f4acacf7abb3677bdbc448b8fed4630c680114ae50);
    }

    function testIpaPrimaryPart3() public {
        uint256[] memory point = new uint256[](14);
        point[0] = 0x3900c2e0deca23f4261cf2b1fe25f55af15923fef096beb075597dc4484bdab4;
        point[1] = 0x19e64de64844ab77589ff14fe0d6aca79619e6ac8bb5e023355bdfbec1314299;
        point[2] = 0x023fc05d9c0afe68dee83dd08e45a162b2f9ec0008919c9bb6b74fd973c51e6e;
        point[3] = 0x15ba95ba2f4526812a66b6e929046889148f89ba98ed0955b5e1ef591196b617;
        point[4] = 0x2066410ddf6e0e8ee798b299ce080d37def2d64c7be907169deb62a939761ed2;
        point[5] = 0x001b94cfc1f4b004e1e50c1aff284d0f679402e4e8c741e6e63f6c159b53eb85;
        point[6] = 0x0b95f517c6afa96f9f7a6f38c881586cd55fffd7c8ccf5242bddb08f1ddf6224;
        point[7] = 0x191b78b4877a497460a9315e98b81468001c2b1efa033998a42bff8aa8522dba;
        point[8] = 0x1e672c36421ca2d681987997ffd76f5f2e8fe4793e87c691105160a257dbfac3;
        point[9] = 0x2f2f07e78df3c7658f5a66187821f9af743a1925c1a1d83af6b0dd33d1d8f0e8;
        point[10] = 0x0044b6fa5582115839d186d62373ccef34252fac77680e4626cc0d02130714a6;
        point[11] = 0x0b9b8c6e8dfdee36ee28b4db606180747d182379fcada2bc01047d3a714c6f62;
        point[12] = 0x2d38d3d07e03b3c211a22c63ba0c70986775fba207afb1b6c11e1b978ba4af8d;
        point[13] = 0x12a8ad443674d792661c7b457eec3d0583b4f493b9218ca57c9231c7d379c5f2;

        uint256[] memory r = new uint256[](14);
        r[0] = 0x0ed9834139033b01fd56bb5c9568eb43f30a5a71c8c336d17cbdf09932706928;
        r[1] = 0x320e79db7daf7db4f634ca13fa84f9073b46a719e38346bec9f32210cfdab22f;
        r[2] = 0x2597d78f7e06b92129e359abc01df1e21dc3bdc661cff68004410ca1c650a90a;
        r[3] = 0x2610f6ff38454863548afb491c4ff8264a6118587ec1350592c1da5df4653588;
        r[4] = 0x22c0716acc0f7646756e2e6579631246731fcbd0953331a45877ed4a5cc80e3a;
        r[5] = 0x2d3a2708e3fd7cb3b12167350c468cc4065413a0885460275407626a3bcf0765;
        r[6] = 0x16c58717e4694326ef6d9a0b8e5cfb1577bebe97e45e8b7f3ee289bcc88e7379;
        r[7] = 0x24ac237b07f99973f135b1c6b985076b6a5111540b6cdb5c50290123098bb0e5;
        r[8] = 0x3e8937940aa8ce488aba195e919c9a7010566504ee7e21b2d2374ec6b68af41e;
        r[9] = 0x11f084f7349d6243b7e796c95aef191a48f9826a1248821613162f64c36d1278;
        r[10] = 0x1891ce38f91c371df01655d17644981489b8fd508ca69615b104b1ce40ee883c;
        r[11] = 0x012f54f90c810dc0d5ec01c56319d154293b5444358fe30491e2983317486e2f;
        r[12] = 0x2cc39922aa14b6e0c6e0fb6cd2446a9058b80c337ccc56e3514f8441bddb208b;
        r[13] = 0x0cce59e882837290e01b5393acadc139b8ef01e3a9d476084b30d844ac5b0984;

        uint256[] memory L_vec = new uint256[](14);
        L_vec[0] = 0xcb80d53dae10b6f77728411bd1ccab9f99674333168dc870a0dd8c2d6258101d;
        L_vec[1] = 0x7d99828914155672485c740c019bc0df4cff6641d5e85fe3357902bdfaf9e2b7;
        L_vec[2] = 0xc712a2f9e99e313746ae7e652ae6dc1b4e8173b5534704f9395e47b6ebd291ae;
        L_vec[3] = 0x593bed706cd580064b4e7151dc5ffe5160ed2309e1a917b86921fdb53fc36510;
        L_vec[4] = 0x4f429a8a010172facb892e3560498dc48039e0ecaf9dc4320670ba8ef6d1811b;
        L_vec[5] = 0xddcddd632faed2063a2ec54c7e1bedd4981185b3c944e1e36a2674914a95963d;
        L_vec[6] = 0x34498787480ede5d844c2ac31eceb1076b00bc6d8e206f7731b1ac1b6b084c1e;
        L_vec[7] = 0x5eae7bcfbb3770b11892f8843a0bba99c82e9764b6a917dafd5388048a64c2b3;
        L_vec[8] = 0x8939a6664414f8ea9fc60583f3cde95bda3abdb62aaa394d17dee28dc857fc96;
        L_vec[9] = 0x8591ac70ff417e20e3be7ec54c2e99bc8cb887eaa7b927f674ff01fe050aa482;
        L_vec[10] = 0xe1387711a2fa0d2251a0c306c51999431bd44415e64adc22da5c773247d34015;
        L_vec[11] = 0xf33e8885415a3a3bf10d4b87e7f6ddd73ec2073914d235a6b5e8e3e7628f210c;
        L_vec[12] = 0xd65fbb10b046abc565cd2907fca296bfd2408c590862bc89542f456f939ea804;
        L_vec[13] = 0xc4101de3bec37f996bbea4bba2075039b281d82d0953383a2332eccde304561d;

        uint256[] memory R_vec = new uint256[](14);
        R_vec[0] = 0x0b2ed0f5a73abf974d366f38da23dd01e4f62c222c90cb0a5dfa8d1381c6e497;
        R_vec[1] = 0xde0ffaa2b8bec1ce879660629753d2a4a063788eea25d0c03c4169a192b6d930;
        R_vec[2] = 0x41ca8d6c927f1705e78d0c85eeb7116174a654a5b02cb519105aaf65deddc230;
        R_vec[3] = 0x93a9a059dd9307543607ab9cf1dc86e61e107aac24a6e1285562ca3081c23501;
        R_vec[4] = 0x0387f0cde8aa6f5202abf8b384bd9ea22c097740d8a935754159a9ba51f3f486;
        R_vec[5] = 0xba57256f4aece2d009e152fe4ce62790f70fb71e6a6bd26fdba83ccd8de50e17;
        R_vec[6] = 0x3334786ee74efec2394fecf919070e75c268f329d69ab043825cbaceed9413ad;
        R_vec[7] = 0x6979d8f41d3ac76ccc293a9845b95491bad0aa03a433ea4aea06a03b27d141bb;
        R_vec[8] = 0x48822ab783b31994cb952608c97c19215c424b136376b8571cb3b4e47d4a0d22;
        R_vec[9] = 0x9d45056e78cf45140937d01957ca4c79ef81daab778501fd991c6a786d31d52b;
        R_vec[10] = 0x4f00dd5a1553ed52b6a302eb3d32386ef8e8d2fae53a938b79d8f032f15c3124;
        R_vec[11] = 0x0dc1259c30e3032002fb2d4c42f31ab153a1613dd9fd41ac7b1dc4881bcb8e8d;
        R_vec[12] = 0x2521d83b6bbbf2e9fb4f8d67d3383b80a156f78602ec04a4cde4b89ae2311dac;
        R_vec[13] = 0x4b5d75dcd9edc7958ef2faabd2f1529bb7238c4e992daf3ab8852a90160e8d92;

        Pallas.PallasAffinePoint memory P = Pallas.PallasAffinePoint(0x02bb7ae2962528a4766d564cf780cfea3623c0b2b982055b2604eabd999d69aa, 0x3f0c0086da4d6bfddec956be5186e35d0a9d8814764e67ce4a0d8b88ed2fc230);

        (uint256 b_hat, Pallas.PallasAffinePoint memory P_hat) = InnerProductArgumentLib.verifyPrimaryPart3(point, r, L_vec, R_vec, P);

        assertEq(b_hat, 0x1f7583e6e7a483a5ffac72026218e08874c869b26f3fd300aaedaee9e0a29f8c);
        assertEq(P_hat.x, 0x11ca9f8a2b6f70520df43e7e07a0eeb63946756c668371b3be7f55b1269343be);
        assertEq(P_hat.y, 0x18031334a5fc123804b4575637d6920bc3fbe7f5fa77225031e9dcc7ea44b02e);
    }

    function testIpaPrimaryPart4() public view {
        Pallas.PallasAffinePoint memory P_hat = Pallas.PallasAffinePoint(0x11ca9f8a2b6f70520df43e7e07a0eeb63946756c668371b3be7f55b1269343be, 0x18031334a5fc123804b4575637d6920bc3fbe7f5fa77225031e9dcc7ea44b02e);
        Pallas.PallasAffinePoint memory ck_hat = Pallas.PallasAffinePoint(0x28eb5074894b7d5eac05f3aa85f40489d2160a2beb6f9a62464f24c410f9e6ca, 0x3fa0824a3a35daa5cce2a8f4acacf7abb3677bdbc448b8fed4630c680114ae50);
        Pallas.PallasAffinePoint memory ck_c = Pallas.PallasAffinePoint(0x0ad824db4789bdc0e7761d978c7618788d022e97712c9b440373a7b0d9a353d3, 0x3335a6c5e1afa5f8c191490ccc0f0f3fd353c8f07ac80264d7d89d62fc6eae39);

        uint256 a_hat = 0x0df77121ec228dfa5ef52f064dcc534aff2a91edf0db8511d4318540f601b224;
        uint256 b_hat = 0x1f7583e6e7a483a5ffac72026218e08874c869b26f3fd300aaedaee9e0a29f8c;

        InnerProductArgumentLib.verifyPrimaryPart4(P_hat, ck_hat, ck_c, a_hat, b_hat);
    }
}
