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
}
