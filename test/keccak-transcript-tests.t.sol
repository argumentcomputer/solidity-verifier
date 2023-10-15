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

        uint256 expected = 0x5ddffa8dc091862132788b8976af88b9a2c70594727e611c7217ba4c30c8c70a;
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

        expected = 0x4d4bf42c065870395749fa1c4fb641df1e0d53f05309b03d5b1db7f0be3aa13d;
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

        uint256 expected = 0xc64ec10ff9437f1053c8647b52358f10e59d80e7302a777dfecf8d49f0e29121;
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

        expected = 0xe3585da385704879ec03ef201dbf228e7b227a5af709f83f3ed5f92a5037d633;
        assertEq(output, expected);
    }

    function testKeccakTranscriptBn256() public {
        uint8[] memory input = new uint8[](4); // b"test" in Rust
        input[0] = 0x74;
        input[1] = 0x65;
        input[2] = 0x73;
        input[3] = 0x74;

        uint256 input1 = 2;
        uint8[] memory label1 = new uint8[](2); // b"s1" in Rust
        label1[0] = 0x73;
        label1[1] = 0x31;

        uint256 input2 = 5;
        uint8[] memory label2 = new uint8[](2); // b"s2" in Rust
        label2[0] = 0x73;
        label2[1] = 0x32;

        uint8[] memory squeezeLabel = new uint8[](2); // b"c1" in Rust
        squeezeLabel[0] = 0x63;
        squeezeLabel[1] = 0x31;

        ScalarFromUniformLib.Curve curve = ScalarFromUniformLib.curveBn256();

        uint256 output;

        uint256 gasCost = gasleft();
        KeccakTranscriptLib.KeccakTranscript memory transcript = KeccakTranscriptLib.instantiate(input);
        transcript = KeccakTranscriptLib.absorb(transcript, label1, input1);
        transcript = KeccakTranscriptLib.absorb(transcript, label2, input2);
        (transcript, output) = KeccakTranscriptLib.squeeze(transcript, curve, squeezeLabel);
        console.log("gas cost: ", gasCost - uint256(gasleft()));

        // getting state
        /*
        bytes memory stateLo = new bytes(32);
        bytes memory stateHi = new bytes(32);
        for (uint256 i = 0; i < 32; i++) {
            stateLo[i] = bytes1(transcript.state[i]);
            stateHi[i] = bytes1(transcript.state[i + 32]);
        }

        console.log("rounds: ", transcript.round);
        console.logBytes32(bytes32(stateLo));
        console.logBytes32(bytes32(stateHi));
        */

        uint256 expected = 0x9fb71e3b74bfd0b60d97349849b895595779a240b92a6fae86bd2812692b6b0e;
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

        expected = 0xbfd4c50b7d6317e9267d5d65c985eb455a3561129c0b3beef79bfc8461a84f18;
        assertEq(output, expected);
    }

    function testKeccakTranscriptGrumpkin() public {
        uint8[] memory input = new uint8[](4); // b"test" in Rust
        input[0] = 0x74;
        input[1] = 0x65;
        input[2] = 0x73;
        input[3] = 0x74;

        uint256 input1 = 2;
        uint8[] memory label1 = new uint8[](2); // b"s1" in Rust
        label1[0] = 0x73;
        label1[1] = 0x31;

        uint256 input2 = 5;
        uint8[] memory label2 = new uint8[](2); // b"s2" in Rust
        label2[0] = 0x73;
        label2[1] = 0x32;

        uint8[] memory squeezeLabel = new uint8[](2); // b"c1" in Rust
        squeezeLabel[0] = 0x63;
        squeezeLabel[1] = 0x31;

        ScalarFromUniformLib.Curve curve = ScalarFromUniformLib.curveGrumpkin();

        uint256 gasCost = gasleft();
        KeccakTranscriptLib.KeccakTranscript memory transcript = KeccakTranscriptLib.instantiate(input);
        transcript = KeccakTranscriptLib.absorb(transcript, label1, input1);
        transcript = KeccakTranscriptLib.absorb(transcript, label2, input2);
        uint256 output;
        (transcript, output) = KeccakTranscriptLib.squeeze(transcript, curve, squeezeLabel);
        console.log("gas cost: ", gasCost - uint256(gasleft()));

        // getting state
        /*
        bytes memory stateLo = new bytes(32);
        bytes memory stateHi = new bytes(32);
        for (uint256 i = 0; i < 32; i++) {
            stateLo[i] = bytes1(transcript.state[i]);
            stateHi[i] = bytes1(transcript.state[i + 32]);
        }

        console.log("rounds: ", transcript.round);
        console.logBytes32(bytes32(stateLo));
        console.logBytes32(bytes32(stateHi));
        */

        uint256 expected = 0xd12b7cd39aa2fc3af9bfd4f1dfd8ffa6498f57e35021675f4227d448b5540922;
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

        expected = 0xfb894998c48dd652b32a109d3d2e579a0878f7f5cacfb572dc21666b9cfe221a;
        assertEq(output, expected);
    }

    function testKeccakTranscriptGrumpkinAssembly() public {
        uint8[] memory instantiate_label = new uint8[](4); // b"test" in Rust
        instantiate_label[0] = 0x74;
        instantiate_label[1] = 0x65;
        instantiate_label[2] = 0x73;
        instantiate_label[3] = 0x74;

        uint8[] memory input1 = new uint8[](32);
        input1[0] = 0x02;

        uint8[] memory absorb_label1 = new uint8[](2); // b"s1" in Rust
        absorb_label1[0] = 0x73;
        absorb_label1[1] = 0x31;

        uint8[] memory input2 = new uint8[](32);
        input2[0] = 0x05;

        uint8[][] memory inputs = new uint8[][](2);
        inputs[0] = input1;
        inputs[1] = input2;

        uint8[] memory absorb_label2 = new uint8[](2); // b"s2" in Rust
        absorb_label2[0] = 0x73;
        absorb_label2[1] = 0x32;

        uint8[][] memory absorb_labels = new uint8[][](2);
        absorb_labels[0] = absorb_label1;
        absorb_labels[1] = absorb_label2;

        uint8[] memory squeeze_label = new uint8[](2); // b"c1" in Rust
        squeeze_label[0] = 0x63;
        squeeze_label[1] = 0x31;

        uint256 expected = 0xd12b7cd39aa2fc3af9bfd4f1dfd8ffa6498f57e35021675f4227d448b5540922;

        uint256 gasCost = gasleft();
        uint256 output =
            keccakTranscriptFromInitLabel(instantiate_label, absorb_labels, inputs, squeeze_label, GRUMPKIN_P_MOD);
        console.log("gas cost: ", gasCost - uint256(gasleft()));

        assertEq(Field.reverse256(output), expected);

        // test-vector 2
        input1 = new uint8[](32);
        input1[0] = 0x80; // uint256 s3 = 128;

        inputs = new uint8[][](1);
        inputs[0] = input1;

        absorb_label1 = new uint8[](2); // b"s3" in Rust
        absorb_label1[0] = 0x73;
        absorb_label1[1] = 0x33;
        absorb_labels = new uint8[][](1);
        absorb_labels[0] = absorb_label1;

        // b"c2" in Rust
        squeeze_label = new uint8[](2);
        squeeze_label[0] = 0x63;
        squeeze_label[1] = 0x32;

        uint256 rounds = 1;
        uint256 stateLo = 0x4ab52790b1ba6e3460fe70bbba5d07eb9b153ae612288cbbc115237a49886715;
        uint256 stateHi = 0x5a438956ee1f0b336dd54e258aebe27db38b5c842c62765061737cdb2517e9b0;
        uint256 outputFromGivenState = keccakTranscriptFromGivenState(
            stateLo, stateHi, rounds, absorb_labels, inputs, squeeze_label, GRUMPKIN_P_MOD
        );

        expected = 0xfb894998c48dd652b32a109d3d2e579a0878f7f5cacfb572dc21666b9cfe221a;
        assertEq(expected, Field.reverse256(outputFromGivenState));
    }

    function testKeccakTranscriptBn256Assembly() public {
        // test-vector 1
        uint8[] memory instantiate_label = new uint8[](4); // b"test" in Rust
        instantiate_label[0] = 0x74;
        instantiate_label[1] = 0x65;
        instantiate_label[2] = 0x73;
        instantiate_label[3] = 0x74;

        uint8[] memory input1 = new uint8[](32);
        input1[0] = 0x02;

        uint8[] memory absorb_label1 = new uint8[](2); // b"s1" in Rust
        absorb_label1[0] = 0x73;
        absorb_label1[1] = 0x31;

        uint8[] memory input2 = new uint8[](32);
        input2[0] = 0x05;

        uint8[][] memory inputs = new uint8[][](2);
        inputs[0] = input1;
        inputs[1] = input2;

        uint8[] memory absorb_label2 = new uint8[](2); // b"s2" in Rust
        absorb_label2[0] = 0x73;
        absorb_label2[1] = 0x32;

        uint8[][] memory absorb_labels = new uint8[][](2);
        absorb_labels[0] = absorb_label1;
        absorb_labels[1] = absorb_label2;

        uint8[] memory squeeze_label = new uint8[](2); // b"c1" in Rust
        squeeze_label[0] = 0x63;
        squeeze_label[1] = 0x31;

        uint256 expected = 0x9fb71e3b74bfd0b60d97349849b895595779a240b92a6fae86bd2812692b6b0e;

        uint256 gasCost = gasleft();
        uint256 output =
            keccakTranscriptFromInitLabel(instantiate_label, absorb_labels, inputs, squeeze_label, BN256_P_MOD);
        console.log("gas cost: ", gasCost - uint256(gasleft()));

        assertEq(Field.reverse256(output), expected);

        // test-vector 2
        input1 = new uint8[](32);
        input1[0] = 0x80; // uint256 s3 = 128;

        inputs = new uint8[][](1);
        inputs[0] = input1;

        absorb_label1 = new uint8[](2); // b"s3" in Rust
        absorb_label1[0] = 0x73;
        absorb_label1[1] = 0x33;
        absorb_labels = new uint8[][](1);
        absorb_labels[0] = absorb_label1;

        // b"c2" in Rust
        squeeze_label = new uint8[](2);
        squeeze_label[0] = 0x63;
        squeeze_label[1] = 0x32;

        uint256 rounds = 1;
        uint256 stateLo = 0x4ab52790b1ba6e3460fe70bbba5d07eb9b153ae612288cbbc115237a49886715;
        uint256 stateHi = 0x5a438956ee1f0b336dd54e258aebe27db38b5c842c62765061737cdb2517e9b0;
        uint256 outputFromGivenState =
            keccakTranscriptFromGivenState(stateLo, stateHi, rounds, absorb_labels, inputs, squeeze_label, BN256_P_MOD);

        expected = 0xbfd4c50b7d6317e9267d5d65c985eb455a3561129c0b3beef79bfc8461a84f18;
        assertEq(expected, Field.reverse256(outputFromGivenState));
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

    // Storage pointers
    uint256 internal constant ROUND = 0x200 + 0x960 + 0x00;
    uint256 internal constant STATE_LO = 0x200 + 0x960 + 0x20;
    uint256 internal constant STATE_HI = 0x200 + 0x960 + 0x40;
    uint256 internal constant TRANSCRIPT = 0x200 + 0x960 + 0x60;

    // Errors
    bytes4 internal constant ABSORB_INPUTS_LABELS_SIZE_MISMATCH = 0x2f94e9a8;
    bytes4 internal constant ABSORB_INPUTS_LABELS_OUT_OF_BOUND_INDEX = 0x6ce876d0;
    bytes4 internal constant ROUND_OVERFLOW = 0x9ab982d5;
    bytes4 internal constant WRONG_CURVE_MODULUS_HAS_BEEN_USED = 0x49a7f6ee;

    function keccakTranscriptFromGivenState(
        uint256 stateLo_input,
        uint256 stateHi_input,
        uint256 round_input,
        uint8[][] memory absorb_labels,
        uint8[][] memory inputs,
        uint8[] memory squeeze_label,
        uint256 curve_p_mod
    ) private returns (uint256) {
        uint256 hash;
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

            function compute_total_transcript_length(_absorb_labels, _inputs, _length) -> _len {
                let index := 0
                let pointer := 0
                for {} lt(index, _length) {} {
                    pointer := mload(add(_absorb_labels, add(32, mul(32, index))))
                    _len := add(mload(pointer), _len)

                    pointer := mload(add(_inputs, add(32, mul(32, index))))
                    _len := add(mload(pointer), _len)

                    index := add(index, 1)
                }

                _len := add(_len, 4) // 4 bytes of DOM_SEP_TAG
                _len := add(_len, 2) // 2 bytes of round variable
                _len := add(_len, 32) // 32 bytes of STATE_LO
                _len := add(_len, 32) // 32 bytes of STATE_HI
                _len := add(_len, 2) // 2 bytes of squeeze label
                _len := add(_len, 1) // 1 byte of LO/HI prefix
            }

            function squeeze(_transcript_address, offset_, _squeeze_label) -> _offset_ {
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

                // append squeeze label
                let index := 0
                let length := mload(_squeeze_label)
                for {} lt(index, length) {} {
                    mstore8(add(_transcript_address, _offset_), mload(add(_squeeze_label, add(32, mul(32, index)))))
                    index := add(index, 1)
                    _offset_ := add(_offset_, 1)
                }

                // increment round
                let round := mload(ROUND)
                if eq(round, 0xffff) {
                    mstore(0x00, ROUND_OVERFLOW)
                    revert(0x00, 0x04)
                }
                round := add(round, 1)
                mstore(ROUND, round)

                // update state
                mstore8(add(_transcript_address, _offset_), KECCAK256_PREFIX_CHALLENGE_LO)
                mstore(STATE_LO, keccak256(add(TRANSCRIPT, 32), mload(TRANSCRIPT)))

                mstore8(add(_transcript_address, _offset_), KECCAK256_PREFIX_CHALLENGE_HI)
                mstore(STATE_HI, keccak256(add(TRANSCRIPT, 32), mload(TRANSCRIPT)))
            }

            function absorb(_transcript_address, offset_, _absorb_labels, _inputs, _length, _index) -> _offset_ {
                // if provided index equals or greater than length of inputs/labels, it is IndexOutOfBound
                if eq(_length, _index) {
                    mstore(0x00, ABSORB_INPUTS_LABELS_OUT_OF_BOUND_INDEX)
                    revert(0x00, 0x04)
                }
                if iszero(gt(_length, _index)) {
                    mstore(0x00, ABSORB_INPUTS_LABELS_OUT_OF_BOUND_INDEX)
                    revert(0x00, 0x04)
                }

                _offset_ := offset_
                let _absorb_labels_pointer := mload(add(_absorb_labels, add(32, mul(32, _index))))
                let _inputs_pointer := mload(add(_inputs, add(32, mul(32, _index))))

                // absorb label bytes
                let byte_index := 0
                let length := mload(_absorb_labels_pointer)
                for {} lt(byte_index, length) {} {
                    mstore8(
                        add(_transcript_address, add(_offset_, byte_index)),
                        mload(add(_absorb_labels_pointer, add(32, mul(32, byte_index))))
                    )
                    byte_index := add(byte_index, 1)
                }
                _offset_ := add(_offset_, length)

                // absorb input
                byte_index := 0
                length := mload(_inputs_pointer)
                for {} lt(byte_index, length) {} {
                    mstore8(
                        add(_transcript_address, add(_offset_, byte_index)),
                        mload(add(_inputs_pointer, add(32, mul(32, byte_index))))
                    )
                    byte_index := add(byte_index, 1)
                }
                _offset_ := add(_offset_, length)
            }

            mstore(ROUND, round_input)
            mstore(STATE_LO, stateLo_input)
            mstore(STATE_HI, stateHi_input)

            let inputs_length := mload(inputs)
            if iszero(eq(mload(absorb_labels), inputs_length)) {
                mstore(0x00, ABSORB_INPUTS_LABELS_SIZE_MISMATCH)
                revert(0x00, 0x04)
            }

            // compose transcript
            let total_transcript_length := compute_total_transcript_length(absorb_labels, inputs, inputs_length)
            mstore(TRANSCRIPT, total_transcript_length)
            let transcript_address := add(TRANSCRIPT, 32)

            // absorb
            let offset := 0
            let index := 0
            for {} lt(index, inputs_length) {} {
                offset := absorb(transcript_address, offset, absorb_labels, inputs, inputs_length, index)
                index := add(index, 1)
            }

            // squeeze
            offset := squeeze(transcript_address, offset, squeeze_label)

            hash := fromUniform(reverse(mload(STATE_LO)), reverse(mload(STATE_HI)), curve_p_mod)
        }
        return hash;
    }

    function keccakTranscriptFromInitLabel(
        uint8[] memory instantiate_label,
        uint8[][] memory absorb_labels,
        uint8[][] memory inputs,
        uint8[] memory squeeze_label,
        uint256 curve_p_mod
    ) private returns (uint256) {
        uint256 rounds = 0;
        uint256 stateLo;
        uint256 stateHi;
        assembly {
            function init(_instantiate_label, _length) {
                let offset := 0
                mstore(TRANSCRIPT, add(_length, 5))
                offset := add(offset, 32)

                // copy PERSONA_TAG
                mstore8(add(TRANSCRIPT, 32), and(0xff, shr(24, PERSONA_TAG)))
                mstore8(add(TRANSCRIPT, add(offset, 1)), and(0xff, shr(16, PERSONA_TAG)))
                mstore8(add(TRANSCRIPT, add(offset, 2)), and(0xff, shr(8, PERSONA_TAG)))
                mstore8(add(TRANSCRIPT, add(offset, 3)), and(0xff, PERSONA_TAG))
                offset := add(offset, 3)

                // copy instantiate_label
                let index := 0
                for {} lt(index, _length) {} {
                    mstore8(add(TRANSCRIPT, add(offset, 1)), mload(add(_instantiate_label, add(32, mul(32, index)))))

                    index := add(index, 1)
                    offset := add(offset, 1)
                }

                // compute STATE_LO
                mstore8(add(TRANSCRIPT, add(offset, 1)), KECCAK256_PREFIX_CHALLENGE_LO)
                mstore(STATE_LO, keccak256(add(TRANSCRIPT, 32), mload(TRANSCRIPT)))

                // compute STATE_HI
                mstore8(add(TRANSCRIPT, add(offset, 1)), KECCAK256_PREFIX_CHALLENGE_HI)
                mstore(STATE_HI, keccak256(add(TRANSCRIPT, 32), mload(TRANSCRIPT)))
            }

            init(instantiate_label, mload(instantiate_label))

            stateLo := mload(STATE_LO)
            stateHi := mload(STATE_HI)
        }

        return
            keccakTranscriptFromGivenState(stateLo, stateHi, rounds, absorb_labels, inputs, squeeze_label, curve_p_mod);
    }
}
