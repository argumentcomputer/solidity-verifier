// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.16;

import "@std/Test.sol";
import "src/blocks/KeccakTranscript.sol";
import "src/Utilities.sol";
import "src/blocks/Sumcheck.sol";

contract SumcheckTest is Test {
    function testComputeTauPrimary() public {
        uint8[] memory input = new uint8[](16); // b"RelaxedR1CSSNARK" in Rust
        input[0] = 0x52;
        input[1] = 0x65;
        input[2] = 0x6c;
        input[3] = 0x61;
        input[4] = 0x78;
        input[5] = 0x65;
        input[6] = 0x64;
        input[7] = 0x52;
        input[8] = 0x31;
        input[9] = 0x43;
        input[10] = 0x53;
        input[11] = 0x53;
        input[12] = 0x4e;
        input[13] = 0x41;
        input[14] = 0x52;
        input[15] = 0x4b;

        KeccakTranscriptLib.KeccakTranscript memory transcript = KeccakTranscriptLib.instantiate(input);

        uint8[] memory vk_comm = new uint8[](32);
        vk_comm[0] = 0x23;
        vk_comm[1] = 0xa9;
        vk_comm[2] = 0x65;
        vk_comm[3] = 0xae;
        vk_comm[4] = 0xf5;
        vk_comm[5] = 0x44;
        vk_comm[6] = 0x37;
        vk_comm[7] = 0x51;
        vk_comm[8] = 0x77;
        vk_comm[9] = 0xe0;
        vk_comm[10] = 0xae;
        vk_comm[11] = 0x37;
        vk_comm[12] = 0x26;
        vk_comm[13] = 0x8b;
        vk_comm[14] = 0x5b;
        vk_comm[15] = 0x32;
        vk_comm[16] = 0xca;
        vk_comm[17] = 0x91;
        vk_comm[18] = 0x55;
        vk_comm[19] = 0x28;
        vk_comm[20] = 0xac;
        vk_comm[21] = 0x3b;
        vk_comm[22] = 0x12;
        vk_comm[23] = 0x23;
        vk_comm[24] = 0xe5;
        vk_comm[25] = 0x68;
        vk_comm[26] = 0xfb;
        vk_comm[27] = 0x1c;
        vk_comm[28] = 0xef;
        vk_comm[29] = 0x6b;
        vk_comm[30] = 0x41;
        vk_comm[31] = 0x03;

        uint8[] memory vk_comm_label = new uint8[](1); // b"C" in Rust
        vk_comm_label[0] = 0x43;

        uint8[] memory U = new uint8[](226);
        U[0] = 0xab;
        U[1] = 0xf4;
        U[2] = 0xc0;
        U[3] = 0x93;
        U[4] = 0xd7;
        U[5] = 0x1b;
        U[6] = 0xd2;
        U[7] = 0xab;
        U[8] = 0x61;
        U[9] = 0xa2;
        U[10] = 0x84;
        U[11] = 0x16;
        U[12] = 0x3a;
        U[13] = 0x36;
        U[14] = 0xb2;
        U[15] = 0x6c;
        U[16] = 0x75;
        U[17] = 0x42;
        U[18] = 0x9c;
        U[19] = 0x4e;
        U[20] = 0x0a;
        U[21] = 0xbe;
        U[22] = 0x30;
        U[23] = 0x25;
        U[24] = 0x86;
        U[25] = 0xb8;
        U[26] = 0x75;
        U[27] = 0x6f;
        U[28] = 0x56;
        U[29] = 0x1c;
        U[30] = 0x3b;
        U[31] = 0x22;
        U[32] = 0x08;
        U[33] = 0x4e;
        U[34] = 0xc4;
        U[35] = 0x00;
        U[36] = 0xc1;
        U[37] = 0xbc;
        U[38] = 0x28;
        U[39] = 0x22;
        U[40] = 0x6d;
        U[41] = 0xc7;
        U[42] = 0x98;
        U[43] = 0x66;
        U[44] = 0x2a;
        U[45] = 0x67;
        U[46] = 0x8d;
        U[47] = 0x47;
        U[48] = 0xf0;
        U[49] = 0x1e;
        U[50] = 0x0c;
        U[51] = 0x24;
        U[52] = 0xee;
        U[53] = 0xaa;
        U[54] = 0x59;
        U[55] = 0x69;
        U[56] = 0xf7;
        U[57] = 0xaa;
        U[58] = 0xcf;
        U[59] = 0x24;
        U[60] = 0x19;
        U[61] = 0x8c;
        U[62] = 0x21;
        U[63] = 0x05;
        U[64] = 0x01;
        U[65] = 0x94;
        U[66] = 0x18;
        U[67] = 0x0d;
        U[68] = 0x05;
        U[69] = 0x6f;
        U[70] = 0xf8;
        U[71] = 0x6d;
        U[72] = 0xd8;
        U[73] = 0xb2;
        U[74] = 0x99;
        U[75] = 0x7f;
        U[76] = 0x5f;
        U[77] = 0xd7;
        U[78] = 0xe2;
        U[79] = 0x53;
        U[80] = 0xd4;
        U[81] = 0x0d;
        U[82] = 0xfb;
        U[83] = 0xa2;
        U[84] = 0x7a;
        U[85] = 0x8b;
        U[86] = 0x4c;
        U[87] = 0xb9;
        U[88] = 0x74;
        U[89] = 0x62;
        U[90] = 0xe6;
        U[91] = 0xef;
        U[92] = 0x3a;
        U[93] = 0x52;
        U[94] = 0x2b;
        U[95] = 0xf0;
        U[96] = 0x15;
        U[97] = 0x78;
        U[98] = 0x01;
        U[99] = 0x35;
        U[100] = 0x68;
        U[101] = 0xf3;
        U[102] = 0x63;
        U[103] = 0x2c;
        U[104] = 0x36;
        U[105] = 0x67;
        U[106] = 0x02;
        U[107] = 0x01;
        U[108] = 0xea;
        U[109] = 0x3a;
        U[110] = 0x89;
        U[111] = 0x9f;
        U[112] = 0x60;
        U[113] = 0x25;
        U[114] = 0x05;
        U[115] = 0x1e;
        U[116] = 0x74;
        U[117] = 0xd3;
        U[118] = 0x9a;
        U[119] = 0x85;
        U[120] = 0x6c;
        U[121] = 0xf0;
        U[122] = 0x96;
        U[123] = 0x77;
        U[124] = 0xff;
        U[125] = 0xda;
        U[126] = 0xea;
        U[127] = 0x48;
        U[128] = 0x34;
        U[129] = 0x01;
        U[130] = 0x30;
        U[131] = 0x65;
        U[132] = 0xfe;
        U[133] = 0x20;
        U[134] = 0x9d;
        U[135] = 0x44;
        U[136] = 0xbb;
        U[137] = 0x99;
        U[138] = 0x76;
        U[139] = 0x58;
        U[140] = 0x4c;
        U[141] = 0xb4;
        U[142] = 0xea;
        U[143] = 0xd9;
        U[144] = 0x89;
        U[145] = 0xa3;
        U[146] = 0x01;
        U[147] = 0x00;
        U[148] = 0x00;
        U[149] = 0x00;
        U[150] = 0x00;
        U[151] = 0x00;
        U[152] = 0x00;
        U[153] = 0x00;
        U[154] = 0x00;
        U[155] = 0x00;
        U[156] = 0x00;
        U[157] = 0x00;
        U[158] = 0x00;
        U[159] = 0x00;
        U[160] = 0x00;
        U[161] = 0x00;
        U[162] = 0x6a;
        U[163] = 0xf4;
        U[164] = 0x72;
        U[165] = 0xae;
        U[166] = 0x09;
        U[167] = 0xba;
        U[168] = 0x90;
        U[169] = 0x21;
        U[170] = 0xc5;
        U[171] = 0xca;
        U[172] = 0xd4;
        U[173] = 0xa5;
        U[174] = 0x3d;
        U[175] = 0xe0;
        U[176] = 0x18;
        U[177] = 0x1f;
        U[178] = 0x07;
        U[179] = 0xd3;
        U[180] = 0xd7;
        U[181] = 0x18;
        U[182] = 0xf7;
        U[183] = 0x98;
        U[184] = 0x27;
        U[185] = 0xa1;
        U[186] = 0x2b;
        U[187] = 0x6f;
        U[188] = 0xa6;
        U[189] = 0x56;
        U[190] = 0x0a;
        U[191] = 0xd2;
        U[192] = 0x56;
        U[193] = 0x2e;
        U[194] = 0xad;
        U[195] = 0x9f;
        U[196] = 0xa6;
        U[197] = 0x2a;
        U[198] = 0x1a;
        U[199] = 0x9d;
        U[200] = 0x69;
        U[201] = 0x38;
        U[202] = 0xce;
        U[203] = 0x77;
        U[204] = 0xa3;
        U[205] = 0xd0;
        U[206] = 0x4b;
        U[207] = 0x90;
        U[208] = 0xce;
        U[209] = 0xf2;
        U[210] = 0x2b;
        U[211] = 0x0e;
        U[212] = 0x8d;
        U[213] = 0x05;
        U[214] = 0x4b;
        U[215] = 0x68;
        U[216] = 0x8f;
        U[217] = 0x47;
        U[218] = 0x5b;
        U[219] = 0x0c;
        U[220] = 0xa6;
        U[221] = 0xa1;
        U[222] = 0x2b;
        U[223] = 0xf5;
        U[224] = 0x75;
        U[225] = 0x28;

        uint8[] memory U_label = new uint8[](1); // b"U" in Rust
        U_label[0] = 0x55;

        transcript = KeccakTranscriptLib.absorb(transcript, vk_comm_label, vk_comm);
        transcript = KeccakTranscriptLib.absorb(transcript, U_label, U);

        uint256 num_rounds_x = CommonUtilities.log2(16384);
        //uint256 num_rounds_y = log2(16384) + 1;

        uint8[] memory squeezeLabel = new uint8[](1); // b"t" in Rust
        squeezeLabel[0] = 0x74;
        ScalarFromUniformLib.Curve curve = ScalarFromUniformLib.curveVesta();

        uint256[] memory tau = new uint256[](num_rounds_x);
        uint256 keccakOutput;
        for (uint256 index = 0; index < tau.length; index++) {
            (transcript, keccakOutput) = KeccakTranscriptLib.squeeze(transcript, curve, squeezeLabel);
            tau[index] = keccakOutput;
        }

        assertEq(tau[0], Field.reverse256(0xec15c1b59e4d0132159f6f523d6ea12c8cbdbd2c0f02ec9f47cab551a3eba530));
        assertEq(tau[1], Field.reverse256(0x6dc76eb849302b3eb0dacf4f0954fac6c62825621a49a5aa3189d8266711dd0c));
        assertEq(tau[2], Field.reverse256(0xf14fd95e50e62c669756afb51ae048ad61a67146f535a1180239104f71d10310));
        assertEq(tau[3], Field.reverse256(0xe1435c8ac491329906db14b063647f4829819636933e1eba745970e65bcd6408));
        assertEq(tau[4], Field.reverse256(0xe7f81e72eb554cc2d7586759ea3eeaf0c6adb12f8ed7412e8942716006b41625));
        assertEq(tau[5], Field.reverse256(0x352704eceb46a3b8d90d8898d1ed7867e606f791ce5566df6d3954a15fff1e0a));
        assertEq(tau[6], Field.reverse256(0xcfec1aa7ed04102c30cde1449bf855e062782e24e0c3d17d633840f0b5c27224));
        assertEq(tau[7], Field.reverse256(0xdd73e72d775abf5812f25bcd4fe88e7c9960c9486a8e0d0a7c5a1702af406c3e));
        assertEq(tau[8], Field.reverse256(0x1f21b52aae284e7cbe4f10adc93f6da159567295f7009cc0a970f5ebf62c893a));
        assertEq(tau[9], Field.reverse256(0x62c359fb38367fea51324c44f9bf747736ef1f57be5147d2cb2a4e0845309415));
        assertEq(tau[10], Field.reverse256(0xe7610dfab97ee9bf7bbe8c54048e6d33d344e4552f462780943c704c8ef5163b));
        assertEq(tau[11], Field.reverse256(0xa80224715966a0dbd9ef37fc32447c9522988208aec37435f14e2de9c1f82e06));
        assertEq(tau[12], Field.reverse256(0x2232489c8dacb3de64ddf91fa640a6dcffcf8e70c39fde06f374993226190529));
        assertEq(tau[13], Field.reverse256(0x60a7c22598a889a01f92683f05715b048b204a42a0af90a4e2c4ddfb68a66814));
    }

    function testPolyUncompress() public {
        uint256 e = 0;

        uint256[] memory raw_poly;
        PolyLib.CompressedUniPoly memory poly;

        raw_poly = new uint256[](3);
        raw_poly[0] = 0x0000000000000000000000000000000000000000000000000000000000000000;
        raw_poly[1] = 0x3156ab3e1bea772559548817e8d23e4d60a57bc280baf032420e3c6133dd7e2f;
        raw_poly[2] = 0x1dff490409def9717737be07798dad2c3a6bc952eec88937c6076da01f9d9af0;

        poly = PolyLib.CompressedUniPoly(raw_poly);

        PolyLib.UniPoly memory uni_poly = PolyLib.decompress(poly, e, Pallas.R_MOD);

        assertEq(uni_poly.coeffs[0], 0x0000000000000000000000000000000000000000000000000000000000000000);
        assertEq(uni_poly.coeffs[1], 0x30aa0bbdda368f692f73b9e09da01486a97bece2a3a5d85110782c40ac84e6e3);
        assertEq(uni_poly.coeffs[2], 0x3156ab3e1bea772559548817e8d23e4d60a57bc280baf032420e3c6133dd7e2f);
        assertEq(uni_poly.coeffs[3], 0x1dff490409def9717737be07798dad2c3a6bc952eec88937c6076da01f9d9af0);
    }

    function testPolyEvalAtZero() public {
        uint256[] memory coeffs = new uint256[](4);
        coeffs[0] = 0x2a0cd6f39b97ed92a45886a8e80a5944ed373498922050a3745f29c2ec6667ae;
        coeffs[1] = 0x15d1d88908637f82529915e409c52f24dfdd0f088857a2ff9721405cbac93e42;
        coeffs[2] = 0x12fbd521f3fdb45f92e1bc9d045197000c74f40e67292ccac43f9b65f854b955;
        coeffs[3] = 0x0bf922cb074481cf22bfe02c62561af632503238b4198aeb5e2bb5cf8dd0fac3;

        PolyLib.UniPoly memory uni_poly = PolyLib.UniPoly(coeffs);

        assertEq(PolyLib.evalAtZero(uni_poly), 0x2a0cd6f39b97ed92a45886a8e80a5944ed373498922050a3745f29c2ec6667ae);
    }

    function testPolyEvalAtOne1() public {
        uint256[] memory coeffs = new uint256[](4);
        coeffs[0] = 0x0000000000000000000000000000000000000000000000000000000000000000;
        coeffs[1] = 0x30aa0bbdda368f692f73b9e09da01486a97bece2a3a5d85110782c40ac84e6e3;
        coeffs[2] = 0x3156ab3e1bea772559548817e8d23e4d60a57bc280baf032420e3c6133dd7e2f;
        coeffs[3] = 0x1dff490409def9717737be07798dad2c3a6bc952eec88937c6076da01f9d9af0;

        PolyLib.UniPoly memory uni_poly = PolyLib.UniPoly(coeffs);

        assertEq(
            PolyLib.evalAtOne(uni_poly, Pallas.R_MOD),
            0x0000000000000000000000000000000000000000000000000000000000000000
        );
    }

    function testPolyEvalAtOne2() public {
        uint256[] memory coeffs = new uint256[](4);
        coeffs[0] = 0x2a0cd6f39b97ed92a45886a8e80a5944ed373498922050a3745f29c2ec6667ae;
        coeffs[1] = 0x15d1d88908637f82529915e409c52f24dfdd0f088857a2ff9721405cbac93e42;
        coeffs[2] = 0x12fbd521f3fdb45f92e1bc9d045197000c74f40e67292ccac43f9b65f854b955;
        coeffs[3] = 0x0bf922cb074481cf22bfe02c62561af632503238b4198aeb5e2bb5cf8dd0fac3;

        PolyLib.UniPoly memory uni_poly = PolyLib.UniPoly(coeffs);

        assertEq(
            PolyLib.evalAtOne(uni_poly, Pallas.R_MOD),
            0x1ed3a7699f3da343ac93395658773a5fe992d0ec2c26027ba1a4d0342d555a07
        );
    }

    function testPolyEvalAtOne3() public {
        uint256[] memory coeffs = new uint256[](4);
        coeffs[0] = 0x1a7160ebd6e443d51da504fa28e5168868012deaacfc8188014cde90744297bc;
        coeffs[1] = 0x00f74486c14ea32b0c2b2116f5bcb73950d525199ddbca495ad7685e96f22f76;
        coeffs[2] = 0x281222608e87d3d0d154e6621dbe68a181e5e646bbaab420859659a0e042dd4c;
        coeffs[3] = 0x2ae2df351788ef2c603da9501a93ea6ea1080a1742c923a56e0daa7e0599cd1e;

        PolyLib.UniPoly memory uni_poly = PolyLib.UniPoly(coeffs);

        assertEq(
            PolyLib.evalAtOne(uni_poly, Pallas.R_MOD),
            0x2e5da7083e43a9fd5b62b5c356f420d1b97daa663fb77ab9c3815fecf111719b
        );
    }

    function testPolyToTranscriptBytes() public {
        uint256[] memory coeffs = new uint256[](4);
        coeffs[0] = 0x07e180612d7bd63a41bd64c2e6c1b0c5edbe6fa6f318cba353edb77eecd59bac;
        coeffs[1] = 0x3ebba32e8b1eb5338d437e0db1894ab6fb2c14725daeef4c6a361fce880ae0ed;
        coeffs[2] = 0x1785c227874bcb2e816af7d0b1b39d6369dc3017b21cfdaccbbbdf3e9a63c9ca;
        coeffs[3] = 0x3001d35ebe98119d070a55ea1544bcb729493df381bf7c80ffb0203b2956d7c9;

        PolyLib.UniPoly memory uni_poly = PolyLib.UniPoly(coeffs);

        uint8[] memory polyBytes = PolyLib.toTranscriptBytes(uni_poly);

        uint8[] memory expected = new uint8[](96);
        expected[0] = 0xac;
        expected[1] = 0x9b;
        expected[2] = 0xd5;
        expected[3] = 0xec;
        expected[4] = 0x7e;
        expected[5] = 0xb7;
        expected[6] = 0xed;
        expected[7] = 0x53;
        expected[8] = 0xa3;
        expected[9] = 0xcb;
        expected[10] = 0x18;
        expected[11] = 0xf3;
        expected[12] = 0xa6;
        expected[13] = 0x6f;
        expected[14] = 0xbe;
        expected[15] = 0xed;
        expected[16] = 0xc5;
        expected[17] = 0xb0;
        expected[18] = 0xc1;
        expected[19] = 0xe6;
        expected[20] = 0xc2;
        expected[21] = 0x64;
        expected[22] = 0xbd;
        expected[23] = 0x41;
        expected[24] = 0x3a;
        expected[25] = 0xd6;
        expected[26] = 0x7b;
        expected[27] = 0x2d;
        expected[28] = 0x61;
        expected[29] = 0x80;
        expected[30] = 0xe1;
        expected[31] = 0x07;
        expected[32] = 0xca;
        expected[33] = 0xc9;
        expected[34] = 0x63;
        expected[35] = 0x9a;
        expected[36] = 0x3e;
        expected[37] = 0xdf;
        expected[38] = 0xbb;
        expected[39] = 0xcb;
        expected[40] = 0xac;
        expected[41] = 0xfd;
        expected[42] = 0x1c;
        expected[43] = 0xb2;
        expected[44] = 0x17;
        expected[45] = 0x30;
        expected[46] = 0xdc;
        expected[47] = 0x69;
        expected[48] = 0x63;
        expected[49] = 0x9d;
        expected[50] = 0xb3;
        expected[51] = 0xb1;
        expected[52] = 0xd0;
        expected[53] = 0xf7;
        expected[54] = 0x6a;
        expected[55] = 0x81;
        expected[56] = 0x2e;
        expected[57] = 0xcb;
        expected[58] = 0x4b;
        expected[59] = 0x87;
        expected[60] = 0x27;
        expected[61] = 0xc2;
        expected[62] = 0x85;
        expected[63] = 0x17;
        expected[64] = 0xc9;
        expected[65] = 0xd7;
        expected[66] = 0x56;
        expected[67] = 0x29;
        expected[68] = 0x3b;
        expected[69] = 0x20;
        expected[70] = 0xb0;
        expected[71] = 0xff;
        expected[72] = 0x80;
        expected[73] = 0x7c;
        expected[74] = 0xbf;
        expected[75] = 0x81;
        expected[76] = 0xf3;
        expected[77] = 0x3d;
        expected[78] = 0x49;
        expected[79] = 0x29;
        expected[80] = 0xb7;
        expected[81] = 0xbc;
        expected[82] = 0x44;
        expected[83] = 0x15;
        expected[84] = 0xea;
        expected[85] = 0x55;
        expected[86] = 0x0a;
        expected[87] = 0x07;
        expected[88] = 0x9d;
        expected[89] = 0x11;
        expected[90] = 0x98;
        expected[91] = 0xbe;
        expected[92] = 0x5e;
        expected[93] = 0xd3;
        expected[94] = 0x01;
        expected[95] = 0x30;

        assertEq(polyBytes.length, expected.length);
        for (uint256 index = 0; index < polyBytes.length; index++) {
            assertEq(polyBytes[index], expected[index]);
        }
    }
}
