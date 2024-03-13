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

    function testKeccakTranscriptIPAGrumpkin3varComputations() public {
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

        Grumpkin.GrumpkinAffinePoint memory commitment = Grumpkin.GrumpkinAffinePoint(
            0x05761e8168395518effb6191ca6315def59beaeb766682188e649908011d9fcd,
            0x018180ce00e30e9873b2a7420b5e64d8fabe7d0644a7b26ce8a0e80f24f8043e
        );

        uint256[] memory b_vec = new uint256[](8);
        b_vec[0] = 0x05b322aa937a781cec574903649a10e6f8f99b62bbbfbcf2d4800abfdd2ab88b;
        b_vec[1] = 0x0628d577156fed33480196c7a0af00f2fa4370d7a30a846e0bc9835c42764d6f;
        b_vec[2] = 0x21189ff55063834a2b2298000044a241cea1f1bae7acafec03683abcd8da9cf2;
        b_vec[3] = 0x1945b00ee8f84aac5d30df7a58902b2418f016536a89f3efb45a8d93256ed826;
        b_vec[4] = 0x1369fd4b6b257d31d8cfe272f34172660a2e222fdef8c640d7780e717e47300c;
        b_vec[5] = 0x06e2b7834a4648b74e219c655efc67a36860867bd090feffd775a250d6b03dbf;
        b_vec[6] = 0x1f52f509b0be148cec62fbe669188d7bbed991174497c07fa035a60627c7cf9f;
        b_vec[7] = 0x1152f95a5b24d2c058efff1f6b0fc253ba4cf1a89432f4aacd31f70feecd3f5a;

        transcript = KeccakTranscriptLib.absorb(
            transcript,
            label,
            InnerProductArgument.InstanceGrumpkin(
                commitment, b_vec, 0x1f057ef7b42d1590fd90a0c6cebc777b3e080079c6215e8ded00109107055b7e
            )
        );

        // b"r" in Rust
        label = new uint8[](1);
        label[0] = 0x72;
        uint256 r;
        (transcript, r) = KeccakTranscriptLib.squeeze(transcript, ScalarFromUniformLib.curveGrumpkin(), label);

        // b"L" in Rust
        label = new uint8[](1);
        label[0] = 0x4c;
        transcript = KeccakTranscriptLib.absorb(
            transcript, label, 0x1ed4bae9714e4e28fc63fdcc1b54b1f4ac8ec079aca2cca4b92b7e45d63b1395
        );

        // b"R" in Rust
        label = new uint8[](1);
        label[0] = 0x52;
        transcript = KeccakTranscriptLib.absorb(
            transcript, label, 0x1b32544e236d677739086e7725aa4ae01f1a664092225af076a4fb72f1002e75
        );

        // b"r" in Rust
        label = new uint8[](1);
        label[0] = 0x72;
        (transcript, r) = KeccakTranscriptLib.squeeze(transcript, ScalarFromUniformLib.curveGrumpkin(), label);
        assertEq(r, 0x033f2da016bf9248bcefaf0a99d533df518a40729fb72f27e0b68b228df22583);

        // b"L" in Rust
        label = new uint8[](1);
        label[0] = 0x4c;
        transcript = KeccakTranscriptLib.absorb(
            transcript, label, 0x1cb0ba55ddf67148f5fa7a8ef3f9c8cafdfe56bea23b1d5a6253e0857e56ad82
        );

        // b"R" in Rust
        label = new uint8[](1);
        label[0] = 0x52;
        transcript = KeccakTranscriptLib.absorb(
            transcript, label, 0x5325e7f1c0e1bf320bc2649d3b5764d8795abcf137d8325b3fbf3198774085e1
        );

        // b"r" in Rust
        label = new uint8[](1);
        label[0] = 0x72;
        (transcript, r) = KeccakTranscriptLib.squeeze(transcript, ScalarFromUniformLib.curveGrumpkin(), label);
        assertEq(r, 0x1744e670b565ff687a3d35ddb3bd3c800b65d3297f59747846e2076f2da92655);
    }

    function testKeccakTranscriptHyperKzgComputations() public {
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

        // b"c" in Rust
        label = new uint8[](1);
        label[0] = 0x63;

        uint8[] memory pi_comms_bytes = new uint8[](130);
        pi_comms_bytes[0] = 0x80;
        pi_comms_bytes[1] = 0xb5;
        pi_comms_bytes[2] = 0x65;
        pi_comms_bytes[3] = 0xcd;
        pi_comms_bytes[4] = 0x09;
        pi_comms_bytes[5] = 0x6a;
        pi_comms_bytes[6] = 0x5b;
        pi_comms_bytes[7] = 0x5f;
        pi_comms_bytes[8] = 0xf3;
        pi_comms_bytes[9] = 0x60;
        pi_comms_bytes[10] = 0x4f;
        pi_comms_bytes[11] = 0xbe;
        pi_comms_bytes[12] = 0x96;
        pi_comms_bytes[13] = 0x64;
        pi_comms_bytes[14] = 0x9c;
        pi_comms_bytes[15] = 0x7c;
        pi_comms_bytes[16] = 0x6e;
        pi_comms_bytes[17] = 0x42;
        pi_comms_bytes[18] = 0x56;
        pi_comms_bytes[19] = 0xa7;
        pi_comms_bytes[20] = 0x6a;
        pi_comms_bytes[21] = 0x37;
        pi_comms_bytes[22] = 0xf9;
        pi_comms_bytes[23] = 0xfb;
        pi_comms_bytes[24] = 0xb3;
        pi_comms_bytes[25] = 0x12;
        pi_comms_bytes[26] = 0x7d;
        pi_comms_bytes[27] = 0xf7;
        pi_comms_bytes[28] = 0x82;
        pi_comms_bytes[29] = 0x25;
        pi_comms_bytes[30] = 0x25;
        pi_comms_bytes[31] = 0x1e;
        pi_comms_bytes[32] = 0x06;
        pi_comms_bytes[33] = 0x0e;
        pi_comms_bytes[34] = 0xb8;
        pi_comms_bytes[35] = 0xd0;
        pi_comms_bytes[36] = 0x94;
        pi_comms_bytes[37] = 0xbe;
        pi_comms_bytes[38] = 0x50;
        pi_comms_bytes[39] = 0x8e;
        pi_comms_bytes[40] = 0x67;
        pi_comms_bytes[41] = 0xb6;
        pi_comms_bytes[42] = 0x52;
        pi_comms_bytes[43] = 0x19;
        pi_comms_bytes[44] = 0x8c;
        pi_comms_bytes[45] = 0xb8;
        pi_comms_bytes[46] = 0x4f;
        pi_comms_bytes[47] = 0x11;
        pi_comms_bytes[48] = 0xb2;
        pi_comms_bytes[49] = 0x18;
        pi_comms_bytes[50] = 0x3a;
        pi_comms_bytes[51] = 0x4a;
        pi_comms_bytes[52] = 0x78;
        pi_comms_bytes[53] = 0x43;
        pi_comms_bytes[54] = 0x20;
        pi_comms_bytes[55] = 0x3d;
        pi_comms_bytes[56] = 0x86;
        pi_comms_bytes[57] = 0x11;
        pi_comms_bytes[58] = 0x0b;
        pi_comms_bytes[59] = 0xa2;
        pi_comms_bytes[60] = 0x3f;
        pi_comms_bytes[61] = 0x96;
        pi_comms_bytes[62] = 0x57;
        pi_comms_bytes[63] = 0x1f;
        pi_comms_bytes[64] = 0x00;
        pi_comms_bytes[65] = 0xe2;
        pi_comms_bytes[66] = 0xac;
        pi_comms_bytes[67] = 0x44;
        pi_comms_bytes[68] = 0x1b;
        pi_comms_bytes[69] = 0xfa;
        pi_comms_bytes[70] = 0x0a;
        pi_comms_bytes[71] = 0xdb;
        pi_comms_bytes[72] = 0xeb;
        pi_comms_bytes[73] = 0xe1;
        pi_comms_bytes[74] = 0x66;
        pi_comms_bytes[75] = 0x17;
        pi_comms_bytes[76] = 0x56;
        pi_comms_bytes[77] = 0x03;
        pi_comms_bytes[78] = 0xed;
        pi_comms_bytes[79] = 0xa3;
        pi_comms_bytes[80] = 0xfd;
        pi_comms_bytes[81] = 0x3e;
        pi_comms_bytes[82] = 0x56;
        pi_comms_bytes[83] = 0xe7;
        pi_comms_bytes[84] = 0xc8;
        pi_comms_bytes[85] = 0x26;
        pi_comms_bytes[86] = 0xdb;
        pi_comms_bytes[87] = 0x1d;
        pi_comms_bytes[88] = 0xda;
        pi_comms_bytes[89] = 0x27;
        pi_comms_bytes[90] = 0x32;
        pi_comms_bytes[91] = 0xb7;
        pi_comms_bytes[92] = 0xbd;
        pi_comms_bytes[93] = 0x4b;
        pi_comms_bytes[94] = 0x38;
        pi_comms_bytes[95] = 0xa9;
        pi_comms_bytes[96] = 0x25;
        pi_comms_bytes[97] = 0x44;
        pi_comms_bytes[98] = 0xbe;
        pi_comms_bytes[99] = 0xdf;
        pi_comms_bytes[100] = 0x22;
        pi_comms_bytes[101] = 0xe0;
        pi_comms_bytes[102] = 0xe0;
        pi_comms_bytes[103] = 0x26;
        pi_comms_bytes[104] = 0x7a;
        pi_comms_bytes[105] = 0xe2;
        pi_comms_bytes[106] = 0x65;
        pi_comms_bytes[107] = 0xde;
        pi_comms_bytes[108] = 0xee;
        pi_comms_bytes[109] = 0x86;
        pi_comms_bytes[110] = 0xab;
        pi_comms_bytes[111] = 0xcf;
        pi_comms_bytes[112] = 0xbd;
        pi_comms_bytes[113] = 0x7c;
        pi_comms_bytes[114] = 0x04;
        pi_comms_bytes[115] = 0x03;
        pi_comms_bytes[116] = 0x8f;
        pi_comms_bytes[117] = 0xd8;
        pi_comms_bytes[118] = 0x6b;
        pi_comms_bytes[119] = 0x12;
        pi_comms_bytes[120] = 0x00;
        pi_comms_bytes[121] = 0xef;
        pi_comms_bytes[122] = 0xbc;
        pi_comms_bytes[123] = 0x2a;
        pi_comms_bytes[124] = 0xcd;
        pi_comms_bytes[125] = 0x83;
        pi_comms_bytes[126] = 0x7a;
        pi_comms_bytes[127] = 0x16;
        pi_comms_bytes[128] = 0x2c;
        pi_comms_bytes[129] = 0x00;

        transcript = KeccakTranscriptLib.absorb(transcript, label, pi_comms_bytes);

        uint256 r;
        (transcript, r) = KeccakTranscriptLib.squeeze(transcript, ScalarFromUniformLib.curveBn256(), label);

        uint256 r_expected = 0x16773788bb333f3d56ea6fd6e4446170588c0f1bf5ff49802c0fa3e47e8f101a;
        assertEq(r_expected, r);

        // b"v" in Rust
        label[0] = 0x76;

        uint8[] memory pi_evals_bytes = new uint8[](288);
        pi_evals_bytes[0] = 0x5a;
        pi_evals_bytes[1] = 0xad;
        pi_evals_bytes[2] = 0x53;
        pi_evals_bytes[3] = 0x02;
        pi_evals_bytes[4] = 0x60;
        pi_evals_bytes[5] = 0x50;
        pi_evals_bytes[6] = 0x97;
        pi_evals_bytes[7] = 0xed;
        pi_evals_bytes[8] = 0xd5;
        pi_evals_bytes[9] = 0xa2;
        pi_evals_bytes[10] = 0x7f;
        pi_evals_bytes[11] = 0xb8;
        pi_evals_bytes[12] = 0xff;
        pi_evals_bytes[13] = 0x99;
        pi_evals_bytes[14] = 0xaf;
        pi_evals_bytes[15] = 0x01;
        pi_evals_bytes[16] = 0xed;
        pi_evals_bytes[17] = 0x72;
        pi_evals_bytes[18] = 0xd0;
        pi_evals_bytes[19] = 0x40;
        pi_evals_bytes[20] = 0xac;
        pi_evals_bytes[21] = 0xa3;
        pi_evals_bytes[22] = 0xe7;
        pi_evals_bytes[23] = 0x08;
        pi_evals_bytes[24] = 0xb1;
        pi_evals_bytes[25] = 0x01;
        pi_evals_bytes[26] = 0x10;
        pi_evals_bytes[27] = 0x3a;
        pi_evals_bytes[28] = 0xe3;
        pi_evals_bytes[29] = 0x36;
        pi_evals_bytes[30] = 0x77;
        pi_evals_bytes[31] = 0x0c;
        pi_evals_bytes[32] = 0xdf;
        pi_evals_bytes[33] = 0x61;
        pi_evals_bytes[34] = 0x72;
        pi_evals_bytes[35] = 0x3c;
        pi_evals_bytes[36] = 0x93;
        pi_evals_bytes[37] = 0x9d;
        pi_evals_bytes[38] = 0x33;
        pi_evals_bytes[39] = 0x74;
        pi_evals_bytes[40] = 0x6a;
        pi_evals_bytes[41] = 0x96;
        pi_evals_bytes[42] = 0x0c;
        pi_evals_bytes[43] = 0xc1;
        pi_evals_bytes[44] = 0x03;
        pi_evals_bytes[45] = 0x66;
        pi_evals_bytes[46] = 0x63;
        pi_evals_bytes[47] = 0x68;
        pi_evals_bytes[48] = 0x32;
        pi_evals_bytes[49] = 0xc6;
        pi_evals_bytes[50] = 0xdd;
        pi_evals_bytes[51] = 0xb6;
        pi_evals_bytes[52] = 0x55;
        pi_evals_bytes[53] = 0x6f;
        pi_evals_bytes[54] = 0x02;
        pi_evals_bytes[55] = 0x30;
        pi_evals_bytes[56] = 0x21;
        pi_evals_bytes[57] = 0x47;
        pi_evals_bytes[58] = 0x08;
        pi_evals_bytes[59] = 0x90;
        pi_evals_bytes[60] = 0x18;
        pi_evals_bytes[61] = 0x64;
        pi_evals_bytes[62] = 0x4b;
        pi_evals_bytes[63] = 0x12;
        pi_evals_bytes[64] = 0xe9;
        pi_evals_bytes[65] = 0x95;
        pi_evals_bytes[66] = 0xda;
        pi_evals_bytes[67] = 0xcd;
        pi_evals_bytes[68] = 0xd9;
        pi_evals_bytes[69] = 0x8c;
        pi_evals_bytes[70] = 0x88;
        pi_evals_bytes[71] = 0xea;
        pi_evals_bytes[72] = 0xc8;
        pi_evals_bytes[73] = 0xee;
        pi_evals_bytes[74] = 0x01;
        pi_evals_bytes[75] = 0x69;
        pi_evals_bytes[76] = 0xdd;
        pi_evals_bytes[77] = 0xc5;
        pi_evals_bytes[78] = 0xe9;
        pi_evals_bytes[79] = 0xa1;
        pi_evals_bytes[80] = 0x8d;
        pi_evals_bytes[81] = 0xb8;
        pi_evals_bytes[82] = 0x16;
        pi_evals_bytes[83] = 0xac;
        pi_evals_bytes[84] = 0x4f;
        pi_evals_bytes[85] = 0xd2;
        pi_evals_bytes[86] = 0x0b;
        pi_evals_bytes[87] = 0xa2;
        pi_evals_bytes[88] = 0x6b;
        pi_evals_bytes[89] = 0xd0;
        pi_evals_bytes[90] = 0x5e;
        pi_evals_bytes[91] = 0xcf;
        pi_evals_bytes[92] = 0xc6;
        pi_evals_bytes[93] = 0x65;
        pi_evals_bytes[94] = 0x5b;
        pi_evals_bytes[95] = 0x16;
        pi_evals_bytes[96] = 0x00;
        pi_evals_bytes[97] = 0x03;
        pi_evals_bytes[98] = 0x7f;
        pi_evals_bytes[99] = 0x18;
        pi_evals_bytes[100] = 0xfa;
        pi_evals_bytes[101] = 0x1c;
        pi_evals_bytes[102] = 0xdf;
        pi_evals_bytes[103] = 0xd7;
        pi_evals_bytes[104] = 0x0b;
        pi_evals_bytes[105] = 0xcf;
        pi_evals_bytes[106] = 0xd5;
        pi_evals_bytes[107] = 0x33;
        pi_evals_bytes[108] = 0xbe;
        pi_evals_bytes[109] = 0x63;
        pi_evals_bytes[110] = 0x98;
        pi_evals_bytes[111] = 0x54;
        pi_evals_bytes[112] = 0xe1;
        pi_evals_bytes[113] = 0x73;
        pi_evals_bytes[114] = 0xb0;
        pi_evals_bytes[115] = 0x94;
        pi_evals_bytes[116] = 0x46;
        pi_evals_bytes[117] = 0x54;
        pi_evals_bytes[118] = 0x28;
        pi_evals_bytes[119] = 0x6c;
        pi_evals_bytes[120] = 0x1e;
        pi_evals_bytes[121] = 0x3d;
        pi_evals_bytes[122] = 0x2e;
        pi_evals_bytes[123] = 0xd3;
        pi_evals_bytes[124] = 0x0f;
        pi_evals_bytes[125] = 0x36;
        pi_evals_bytes[126] = 0x43;
        pi_evals_bytes[127] = 0x11;
        pi_evals_bytes[128] = 0xcc;
        pi_evals_bytes[129] = 0xcb;
        pi_evals_bytes[130] = 0xe7;
        pi_evals_bytes[131] = 0x12;
        pi_evals_bytes[132] = 0xa9;
        pi_evals_bytes[133] = 0x46;
        pi_evals_bytes[134] = 0x07;
        pi_evals_bytes[135] = 0x61;
        pi_evals_bytes[136] = 0x7a;
        pi_evals_bytes[137] = 0x52;
        pi_evals_bytes[138] = 0xc1;
        pi_evals_bytes[139] = 0x7f;
        pi_evals_bytes[140] = 0x33;
        pi_evals_bytes[141] = 0xab;
        pi_evals_bytes[142] = 0x03;
        pi_evals_bytes[143] = 0xd8;
        pi_evals_bytes[144] = 0x25;
        pi_evals_bytes[145] = 0x73;
        pi_evals_bytes[146] = 0x59;
        pi_evals_bytes[147] = 0x43;
        pi_evals_bytes[148] = 0xf1;
        pi_evals_bytes[149] = 0xda;
        pi_evals_bytes[150] = 0xf6;
        pi_evals_bytes[151] = 0x86;
        pi_evals_bytes[152] = 0xb2;
        pi_evals_bytes[153] = 0xc2;
        pi_evals_bytes[154] = 0x0c;
        pi_evals_bytes[155] = 0xff;
        pi_evals_bytes[156] = 0x19;
        pi_evals_bytes[157] = 0xf0;
        pi_evals_bytes[158] = 0xee;
        pi_evals_bytes[159] = 0x0e;
        pi_evals_bytes[160] = 0x8a;
        pi_evals_bytes[161] = 0x6a;
        pi_evals_bytes[162] = 0x25;
        pi_evals_bytes[163] = 0x22;
        pi_evals_bytes[164] = 0xba;
        pi_evals_bytes[165] = 0x68;
        pi_evals_bytes[166] = 0x59;
        pi_evals_bytes[167] = 0x59;
        pi_evals_bytes[168] = 0xc8;
        pi_evals_bytes[169] = 0x81;
        pi_evals_bytes[170] = 0xb7;
        pi_evals_bytes[171] = 0x10;
        pi_evals_bytes[172] = 0x6b;
        pi_evals_bytes[173] = 0x22;
        pi_evals_bytes[174] = 0x4a;
        pi_evals_bytes[175] = 0x86;
        pi_evals_bytes[176] = 0xcf;
        pi_evals_bytes[177] = 0x9f;
        pi_evals_bytes[178] = 0x6a;
        pi_evals_bytes[179] = 0xd5;
        pi_evals_bytes[180] = 0x66;
        pi_evals_bytes[181] = 0x73;
        pi_evals_bytes[182] = 0x44;
        pi_evals_bytes[183] = 0x16;
        pi_evals_bytes[184] = 0xbe;
        pi_evals_bytes[185] = 0xcf;
        pi_evals_bytes[186] = 0xd2;
        pi_evals_bytes[187] = 0x11;
        pi_evals_bytes[188] = 0xac;
        pi_evals_bytes[189] = 0xe8;
        pi_evals_bytes[190] = 0x08;
        pi_evals_bytes[191] = 0x1a;
        pi_evals_bytes[192] = 0x8c;
        pi_evals_bytes[193] = 0xa9;
        pi_evals_bytes[194] = 0xdf;
        pi_evals_bytes[195] = 0xdf;
        pi_evals_bytes[196] = 0x59;
        pi_evals_bytes[197] = 0x97;
        pi_evals_bytes[198] = 0xde;
        pi_evals_bytes[199] = 0x84;
        pi_evals_bytes[200] = 0x1e;
        pi_evals_bytes[201] = 0x81;
        pi_evals_bytes[202] = 0x5b;
        pi_evals_bytes[203] = 0x4f;
        pi_evals_bytes[204] = 0x30;
        pi_evals_bytes[205] = 0x0b;
        pi_evals_bytes[206] = 0xa2;
        pi_evals_bytes[207] = 0xb9;
        pi_evals_bytes[208] = 0x37;
        pi_evals_bytes[209] = 0x99;
        pi_evals_bytes[210] = 0x91;
        pi_evals_bytes[211] = 0x20;
        pi_evals_bytes[212] = 0x92;
        pi_evals_bytes[213] = 0x41;
        pi_evals_bytes[214] = 0x6f;
        pi_evals_bytes[215] = 0xdd;
        pi_evals_bytes[216] = 0x5b;
        pi_evals_bytes[217] = 0xb2;
        pi_evals_bytes[218] = 0xae;
        pi_evals_bytes[219] = 0x95;
        pi_evals_bytes[220] = 0xed;
        pi_evals_bytes[221] = 0xe8;
        pi_evals_bytes[222] = 0x37;
        pi_evals_bytes[223] = 0x01;
        pi_evals_bytes[224] = 0x93;
        pi_evals_bytes[225] = 0x9a;
        pi_evals_bytes[226] = 0xe3;
        pi_evals_bytes[227] = 0xfa;
        pi_evals_bytes[228] = 0x2c;
        pi_evals_bytes[229] = 0x84;
        pi_evals_bytes[230] = 0x57;
        pi_evals_bytes[231] = 0x35;
        pi_evals_bytes[232] = 0x5c;
        pi_evals_bytes[233] = 0xa1;
        pi_evals_bytes[234] = 0xe2;
        pi_evals_bytes[235] = 0xe8;
        pi_evals_bytes[236] = 0xed;
        pi_evals_bytes[237] = 0x88;
        pi_evals_bytes[238] = 0x9e;
        pi_evals_bytes[239] = 0x9a;
        pi_evals_bytes[240] = 0xb8;
        pi_evals_bytes[241] = 0xcd;
        pi_evals_bytes[242] = 0x45;
        pi_evals_bytes[243] = 0x26;
        pi_evals_bytes[244] = 0x82;
        pi_evals_bytes[245] = 0x7a;
        pi_evals_bytes[246] = 0x9a;
        pi_evals_bytes[247] = 0x65;
        pi_evals_bytes[248] = 0xa7;
        pi_evals_bytes[249] = 0x80;
        pi_evals_bytes[250] = 0xc8;
        pi_evals_bytes[251] = 0x98;
        pi_evals_bytes[252] = 0x16;
        pi_evals_bytes[253] = 0xe9;
        pi_evals_bytes[254] = 0x2e;
        pi_evals_bytes[255] = 0x1e;
        pi_evals_bytes[256] = 0x9c;
        pi_evals_bytes[257] = 0x90;
        pi_evals_bytes[258] = 0x9d;
        pi_evals_bytes[259] = 0x68;
        pi_evals_bytes[260] = 0xb6;
        pi_evals_bytes[261] = 0x37;
        pi_evals_bytes[262] = 0x12;
        pi_evals_bytes[263] = 0x68;
        pi_evals_bytes[264] = 0xa5;
        pi_evals_bytes[265] = 0x38;
        pi_evals_bytes[266] = 0x4b;
        pi_evals_bytes[267] = 0x41;
        pi_evals_bytes[268] = 0xc2;
        pi_evals_bytes[269] = 0x84;
        pi_evals_bytes[270] = 0xf8;
        pi_evals_bytes[271] = 0x64;
        pi_evals_bytes[272] = 0xb6;
        pi_evals_bytes[273] = 0xdb;
        pi_evals_bytes[274] = 0x6c;
        pi_evals_bytes[275] = 0xab;
        pi_evals_bytes[276] = 0xf9;
        pi_evals_bytes[277] = 0x57;
        pi_evals_bytes[278] = 0xf2;
        pi_evals_bytes[279] = 0x2e;
        pi_evals_bytes[280] = 0x35;
        pi_evals_bytes[281] = 0x84;
        pi_evals_bytes[282] = 0x4d;
        pi_evals_bytes[283] = 0x73;
        pi_evals_bytes[284] = 0x9e;
        pi_evals_bytes[285] = 0x3f;
        pi_evals_bytes[286] = 0xa2;
        pi_evals_bytes[287] = 0x20;

        transcript = KeccakTranscriptLib.absorb(transcript, label, pi_evals_bytes);

        // b"r" in Rust
        label[0] = 0x72;
        uint256 q;
        (transcript, q) = KeccakTranscriptLib.squeeze(transcript, ScalarFromUniformLib.curveBn256(), label);

        uint256 q_expected = 0x273c998898d8b87c2df1925e91b2ac91abb5f3c933fdd6817b08c13a97c05148;
        assertEq(q_expected, q);
    }
}
