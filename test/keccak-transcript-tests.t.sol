// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.16;

import "@std/Test.sol";
import "src/blocks/KeccakTranscript.sol";

contract KeccakTranscriptContractTest is Test {
    function testScalarFromUniform() public {
        uint8[] memory uniform = new uint8[](64);
        uniform[0] = 0xd9;
        uniform[1] = 0xdc;
        uniform[2] = 0x10;
        uniform[3] = 0x22;
        uniform[4] = 0xc3;
        uniform[5] = 0x2b;
        uniform[6] = 0xd2;
        uniform[7] = 0x6a;
        uniform[8] = 0xcf;
        uniform[9] = 0x18;
        uniform[10] = 0x6e;
        uniform[11] = 0xf2;
        uniform[12] = 0x14;
        uniform[13] = 0x21;
        uniform[14] = 0x49;
        uniform[15] = 0x43;
        uniform[16] = 0xe9;
        uniform[17] = 0xfd;
        uniform[18] = 0xa6;
        uniform[19] = 0xde;
        uniform[20] = 0x45;
        uniform[21] = 0x3d;
        uniform[22] = 0x41;
        uniform[23] = 0x84;
        uniform[24] = 0xf9;
        uniform[25] = 0xcd;
        uniform[26] = 0x3d;
        uniform[27] = 0x97;
        uniform[28] = 0x05;
        uniform[29] = 0xd4;
        uniform[30] = 0x44;
        uniform[31] = 0x68;
        uniform[32] = 0xdc;
        uniform[33] = 0x49;
        uniform[34] = 0xef;
        uniform[35] = 0x4f;
        uniform[36] = 0x2b;
        uniform[37] = 0xc8;
        uniform[38] = 0x1a;
        uniform[39] = 0xf4;
        uniform[40] = 0x50;
        uniform[41] = 0xae;
        uniform[42] = 0x32;
        uniform[43] = 0x73;
        uniform[44] = 0xda;
        uniform[45] = 0xd1;
        uniform[46] = 0xe9;
        uniform[47] = 0xe2;
        uniform[48] = 0xce;
        uniform[49] = 0x0e;
        uniform[50] = 0x16;
        uniform[51] = 0xb7;
        uniform[52] = 0xb5;
        uniform[53] = 0x3f;
        uniform[54] = 0xa2;
        uniform[55] = 0xd1;
        uniform[56] = 0x45;
        uniform[57] = 0x5e;
        uniform[58] = 0x72;
        uniform[59] = 0x7d;
        uniform[60] = 0xba;
        uniform[61] = 0x32;
        uniform[62] = 0xff;
        uniform[63] = 0x15;

        uint256 scalarPallas = ScalarFromUniformLib.scalarFromUniform(uniform, ScalarFromUniformLib.curvePallas());
        uint256 expectedPallas = 0x076a01b2fad03f35458586f926ba83eeebf8c4fa3b7bcfa1573e1464e11f5358;
        assertEq(scalarPallas, expectedPallas);

        uint256 scalarVesta = ScalarFromUniformLib.scalarFromUniform(uniform, ScalarFromUniformLib.curveVesta());
        uint256 expectedVesta = 0x0c34755d6b4566f930b8371afd2e4818ae49878a10527fd4443dbec811582d43;
        assertEq(scalarVesta, expectedVesta);

        uint256 scalarBn256 = ScalarFromUniformLib.scalarFromUniform(uniform, ScalarFromUniformLib.curveBn256());
        uint256 expectedBn256 = 0x02c64acce6367d59e231e9333e02a497b617fe0fffe49e395b8601550d16f993;
        assertEq(scalarBn256, expectedBn256);

        uint256 scalarGrumpkin = ScalarFromUniformLib.scalarFromUniform(uniform, ScalarFromUniformLib.curveGrumpkin());
        uint256 expectedGrumpkin = 0x04876bd2613243de5a5e8cce6f8e3d1e3adbb695c1b596ed476b96711bec2313;
        assertEq(scalarGrumpkin, expectedGrumpkin);
    }

    // Following test has been ported: https://github.com/lurk-lab/Nova/blob/solidity-verifier-pp-spartan/src/provider/keccak.rs#L138
    // TODO: For some reason, test vector passes if using Vesta curve parameters, but in reference implementation type of point is Pallas
    function testKeccakTranscriptVesta() public {
        uint8[] memory input = new uint8[](4); // b"test" in Rust
        input[0] = 0x74;
        input[1] = 0x65;
        input[2] = 0x73;
        input[3] = 0x74;

        KeccakTranscriptLib.KeccakTranscript memory transcript = KeccakTranscriptLib.instantiate(input);

        uint256 input1 = 2;
        uint8[] memory label1 = new uint8[](2); // b"s1" in Rust
        label1[0] = 0x73;
        label1[1] = 0x31;

        uint256 input2 = 5;
        uint8[] memory label2 = new uint8[](2); // b"s2" in Rust
        label2[0] = 0x73;
        label2[1] = 0x32;

        transcript = KeccakTranscriptLib.absorb(transcript, label1, input1);
        transcript = KeccakTranscriptLib.absorb(transcript, label2, input2);

        uint8[] memory squeezeLabel = new uint8[](2); // b"c1" in Rust
        squeezeLabel[0] = 0x63;
        squeezeLabel[1] = 0x31;

        ScalarFromUniformLib.Curve curve = ScalarFromUniformLib.curveVesta();
        uint256 output;
        (transcript, output) = KeccakTranscriptLib.squeeze(transcript, curve, squeezeLabel);

        uint256 expected = Field.reverse256(0x5ddffa8dc091862132788b8976af88b9a2c70594727e611c7217ba4c30c8c70a);
        assertEq(output, expected);

        uint256 s3 = 128;
        uint8[] memory label3 = new uint8[](2); // b"s3" in Rust
        label3[0] = 0x73;
        label3[1] = 0x33;

        transcript = KeccakTranscriptLib.absorb(transcript, label3, s3);

        // b"c2" in Rust
        squeezeLabel[0] = 0x63;
        squeezeLabel[1] = 0x32;
        (, output) = KeccakTranscriptLib.squeeze(transcript, curve, squeezeLabel);

        expected = Field.reverse256(0x4d4bf42c065870395749fa1c4fb641df1e0d53f05309b03d5b1db7f0be3aa13d);
        assertEq(output, expected);
    }

    function testKeccakTranscriptPallas() public {
        uint8[] memory input = new uint8[](4); // b"test" in Rust
        input[0] = 0x74;
        input[1] = 0x65;
        input[2] = 0x73;
        input[3] = 0x74;

        KeccakTranscriptLib.KeccakTranscript memory transcript = KeccakTranscriptLib.instantiate(input);

        uint256 input1 = 2;
        uint8[] memory label1 = new uint8[](2); // b"s1" in Rust
        label1[0] = 0x73;
        label1[1] = 0x31;

        uint256 input2 = 5;
        uint8[] memory label2 = new uint8[](2); // b"s2" in Rust
        label2[0] = 0x73;
        label2[1] = 0x32;

        transcript = KeccakTranscriptLib.absorb(transcript, label1, input1);
        transcript = KeccakTranscriptLib.absorb(transcript, label2, input2);

        uint8[] memory squeezeLabel = new uint8[](2); // b"c1" in Rust
        squeezeLabel[0] = 0x63;
        squeezeLabel[1] = 0x31;

        ScalarFromUniformLib.Curve curve = ScalarFromUniformLib.curvePallas();
        uint256 output;
        (transcript, output) = KeccakTranscriptLib.squeeze(transcript, curve, squeezeLabel);

        uint256 expected = Field.reverse256(0xc64ec10ff9437f1053c8647b52358f10e59d80e7302a777dfecf8d49f0e29121);
        assertEq(output, expected);

        uint256 s3 = 128;
        uint8[] memory label3 = new uint8[](2); // b"s3" in Rust
        label3[0] = 0x73;
        label3[1] = 0x33;

        transcript = KeccakTranscriptLib.absorb(transcript, label3, s3);

        // b"c2" in Rust
        squeezeLabel[0] = 0x63;
        squeezeLabel[1] = 0x32;
        (, output) = KeccakTranscriptLib.squeeze(transcript, curve, squeezeLabel);

        expected = Field.reverse256(0xe3585da385704879ec03ef201dbf228e7b227a5af709f83f3ed5f92a5037d633);
        assertEq(output, expected);
    }

    function testKeccakTranscriptBn256() public {
        uint8[] memory input = new uint8[](4); // b"test" in Rust
        input[0] = 0x74;
        input[1] = 0x65;
        input[2] = 0x73;
        input[3] = 0x74;

        KeccakTranscriptLib.KeccakTranscript memory transcript = KeccakTranscriptLib.instantiate(input);

        uint256 input1 = 2;
        uint8[] memory label1 = new uint8[](2); // b"s1" in Rust
        label1[0] = 0x73;
        label1[1] = 0x31;

        uint256 input2 = 5;
        uint8[] memory label2 = new uint8[](2); // b"s2" in Rust
        label2[0] = 0x73;
        label2[1] = 0x32;

        transcript = KeccakTranscriptLib.absorb(transcript, label1, input1);
        transcript = KeccakTranscriptLib.absorb(transcript, label2, input2);

        uint8[] memory squeezeLabel = new uint8[](2); // b"c1" in Rust
        squeezeLabel[0] = 0x63;
        squeezeLabel[1] = 0x31;

        ScalarFromUniformLib.Curve curve = ScalarFromUniformLib.curveBn256();
        uint256 output;
        (transcript, output) = KeccakTranscriptLib.squeeze(transcript, curve, squeezeLabel);

        uint256 expected = Field.reverse256(0x9fb71e3b74bfd0b60d97349849b895595779a240b92a6fae86bd2812692b6b0e);
        assertEq(output, expected);

        uint256 s3 = 128;
        uint8[] memory label3 = new uint8[](2); // b"s3" in Rust
        label3[0] = 0x73;
        label3[1] = 0x33;

        transcript = KeccakTranscriptLib.absorb(transcript, label3, s3);

        // b"c2" in Rust
        squeezeLabel[0] = 0x63;
        squeezeLabel[1] = 0x32;
        (, output) = KeccakTranscriptLib.squeeze(transcript, curve, squeezeLabel);

        expected = Field.reverse256(0xbfd4c50b7d6317e9267d5d65c985eb455a3561129c0b3beef79bfc8461a84f18);
        assertEq(output, expected);
    }

    function testKeccakTranscriptGrumpkin() public {
        uint8[] memory input = new uint8[](4); // b"test" in Rust
        input[0] = 0x74;
        input[1] = 0x65;
        input[2] = 0x73;
        input[3] = 0x74;

        KeccakTranscriptLib.KeccakTranscript memory transcript = KeccakTranscriptLib.instantiate(input);

        uint256 input1 = 2;
        uint8[] memory label1 = new uint8[](2); // b"s1" in Rust
        label1[0] = 0x73;
        label1[1] = 0x31;

        uint256 input2 = 5;
        uint8[] memory label2 = new uint8[](2); // b"s2" in Rust
        label2[0] = 0x73;
        label2[1] = 0x32;

        transcript = KeccakTranscriptLib.absorb(transcript, label1, input1);
        transcript = KeccakTranscriptLib.absorb(transcript, label2, input2);

        uint8[] memory squeezeLabel = new uint8[](2); // b"c1" in Rust
        squeezeLabel[0] = 0x63;
        squeezeLabel[1] = 0x31;

        ScalarFromUniformLib.Curve curve = ScalarFromUniformLib.curveGrumpkin();
        uint256 output;
        (transcript, output) = KeccakTranscriptLib.squeeze(transcript, curve, squeezeLabel);

        uint256 expected = Field.reverse256(0xd12b7cd39aa2fc3af9bfd4f1dfd8ffa6498f57e35021675f4227d448b5540922);
        assertEq(output, expected);

        uint256 s3 = 128;
        uint8[] memory label3 = new uint8[](2); // b"s3" in Rust
        label3[0] = 0x73;
        label3[1] = 0x33;

        transcript = KeccakTranscriptLib.absorb(transcript, label3, s3);

        // b"c2" in Rust
        squeezeLabel[0] = 0x63;
        squeezeLabel[1] = 0x32;
        (, output) = KeccakTranscriptLib.squeeze(transcript, curve, squeezeLabel);

        expected = Field.reverse256(0xfb894998c48dd652b32a109d3d2e579a0878f7f5cacfb572dc21666b9cfe221a);
        assertEq(output, expected);
    }

    function testKeccakTranscriptIPAGrumpkinComputations() public {
        // b"TestEval" in Rust
        uint8[] memory label = new uint8[](8);
        label[0] = 0x54;
        label[1] = 0x65;
        label[2] = 0x73;
        label[3] = 0x74;
        label[4] = 0x45;
        label[5] = 0x76;
        label[6] = 0x61;
        label[7] = 0x6c;
        KeccakTranscriptLib.KeccakTranscript memory transcript = KeccakTranscriptLib.instantiate(label);

        // b"IPA" in Rust
        label = new uint8[](3);
        label[0] = 0x49;
        label[1] = 0x50;
        label[2] = 0x41;

        transcript = KeccakTranscriptLib.dom_sep(transcript, label);

        // b"U" in Rust
        label = new uint8[](1);
        label[0] = 0x55;

        uint8[] memory U_bytes = new uint8[](97);
        U_bytes[0] = 0x05;
        U_bytes[1] = 0xdf;
        U_bytes[2] = 0xbd;
        U_bytes[3] = 0xc0;
        U_bytes[4] = 0x8a;
        U_bytes[5] = 0x45;
        U_bytes[6] = 0x2d;
        U_bytes[7] = 0x84;
        U_bytes[8] = 0xe9;
        U_bytes[9] = 0x8e;
        U_bytes[10] = 0xa0;
        U_bytes[11] = 0x63;
        U_bytes[12] = 0x21;
        U_bytes[13] = 0x1a;
        U_bytes[14] = 0x16;
        U_bytes[15] = 0xf9;
        U_bytes[16] = 0x00;
        U_bytes[17] = 0x16;
        U_bytes[18] = 0xb3;
        U_bytes[19] = 0x1e;
        U_bytes[20] = 0xfe;
        U_bytes[21] = 0x89;
        U_bytes[22] = 0xf6;
        U_bytes[23] = 0x3f;
        U_bytes[24] = 0xbe;
        U_bytes[25] = 0x38;
        U_bytes[26] = 0x2b;
        U_bytes[27] = 0x1a;
        U_bytes[28] = 0x59;
        U_bytes[29] = 0x68;
        U_bytes[30] = 0x72;
        U_bytes[31] = 0x1e;
        U_bytes[32] = 0x81;
        U_bytes[33] = 0x52;
        U_bytes[34] = 0x6d;
        U_bytes[35] = 0xf9;
        U_bytes[36] = 0xc0;
        U_bytes[37] = 0xf9;
        U_bytes[38] = 0x9b;
        U_bytes[39] = 0x11;
        U_bytes[40] = 0x5b;
        U_bytes[41] = 0x02;
        U_bytes[42] = 0x36;
        U_bytes[43] = 0x95;
        U_bytes[44] = 0x3f;
        U_bytes[45] = 0x02;
        U_bytes[46] = 0x90;
        U_bytes[47] = 0x54;
        U_bytes[48] = 0x78;
        U_bytes[49] = 0x43;
        U_bytes[50] = 0x0d;
        U_bytes[51] = 0x10;
        U_bytes[52] = 0xa5;
        U_bytes[53] = 0xab;
        U_bytes[54] = 0xe1;
        U_bytes[55] = 0x35;
        U_bytes[56] = 0x01;
        U_bytes[57] = 0x3f;
        U_bytes[58] = 0x2c;
        U_bytes[59] = 0x59;
        U_bytes[60] = 0xc0;
        U_bytes[61] = 0x70;
        U_bytes[62] = 0x30;
        U_bytes[63] = 0x1f;
        U_bytes[64] = 0x01;
        U_bytes[65] = 0xbf;
        U_bytes[66] = 0x33;
        U_bytes[67] = 0x6d;
        U_bytes[68] = 0x8e;
        U_bytes[69] = 0xd8;
        U_bytes[70] = 0x20;
        U_bytes[71] = 0x4d;
        U_bytes[72] = 0x26;
        U_bytes[73] = 0xf3;
        U_bytes[74] = 0xe6;
        U_bytes[75] = 0x05;
        U_bytes[76] = 0x51;
        U_bytes[77] = 0xca;
        U_bytes[78] = 0x7f;
        U_bytes[79] = 0xa4;
        U_bytes[80] = 0xe7;
        U_bytes[81] = 0x23;
        U_bytes[82] = 0x34;
        U_bytes[83] = 0x6a;
        U_bytes[84] = 0x8e;
        U_bytes[85] = 0x7c;
        U_bytes[86] = 0xea;
        U_bytes[87] = 0xb7;
        U_bytes[88] = 0x4a;
        U_bytes[89] = 0x7a;
        U_bytes[90] = 0x9a;
        U_bytes[91] = 0x8e;
        U_bytes[92] = 0x7e;
        U_bytes[93] = 0x2a;
        U_bytes[94] = 0x66;
        U_bytes[95] = 0x14;
        U_bytes[96] = 0x25;

        transcript = KeccakTranscriptLib.absorb(transcript, label, U_bytes);

        // b"r" in Rust
        label = new uint8[](1);
        label[0] = 0x72;
        uint256 r;
        (transcript, r) = KeccakTranscriptLib.squeeze(transcript, ScalarFromUniformLib.curveGrumpkin(), label);

        uint256 r_expected = 0x26dbed0c0b99929de85b3c8d4c501f5216b0c3fa951b92afb75b6044c7b6885d;
        assertEq(r_expected, r);
    }
}
