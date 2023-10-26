// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.16;

import "@std/Test.sol";
import "src/NovaVerifierAbstractions.sol";
import "src/verifier/Step1.sol";
import "src/verifier/Step2Grumpkin.sol";
import "test/utils.t.sol";

contract PpSpartanStep1Step2Computations is Test {
    function testStep1() public view {
        Abstractions.CompressedSnark memory proof = TestUtilities.loadProof();
        uint32 numSteps = 3;
        assert(Step1Lib.verify(proof, numSteps));
    }

    function testStep1Assembly() public {
        Abstractions.CompressedSnark memory proof = TestUtilities.loadProof();
        uint32 numSteps = 3;

        uint256 gasCost = gasleft();
        bool expected = Step1Lib.verify(proof, numSteps);
        console.log("gas cost: ", gasCost - uint256(gasleft()));

        gasCost = gasleft();
        bool actual = step1_assembly(proof, numSteps);
        console.log("gas cost (assembly): ", gasCost - uint256(gasleft()));

        assertEq(expected, actual);
    }

    bytes4 internal constant NUM_STEPS_IS_ZERO = 0xeba9f4a6;
    bytes4 internal constant L_U_SECONDARY_X_LENGTH_IS_NOT_TWO = 0xfe712642;
    bytes4 internal constant R_U_PRIMARY_X_LENGTH_IS_NOT_TWO = 0xeac6982d;
    bytes4 internal constant R_U_SECONDARY_X_LENGTH_IS_NOT_TWO = 0x246ba7de;

    function step1_assembly(Abstractions.CompressedSnark memory proof, uint32 numSteps) private returns (bool result) {
        assembly {
            if iszero(numSteps) {
                mstore(0x00, NUM_STEPS_IS_ZERO)
                revert(0x00, 0x04)
            }

            let proof_pointer := mload(proof)
            let l_u_secondary_X := mload(add(proof_pointer, 32))
            let l_u_secondary_X_length := mload(l_u_secondary_X)
            if iszero(eq(l_u_secondary_X_length, 2)) {
                mstore(0x00, L_U_SECONDARY_X_LENGTH_IS_NOT_TWO)
                revert(0x00, 0x04)
            }

            let r_U_primary_X := mload(add(proof_pointer, 224))
            let r_U_primary_X_length := mload(r_U_primary_X)
            if iszero(eq(r_U_primary_X_length, 2)) {
                mstore(0x00, R_U_PRIMARY_X_LENGTH_IS_NOT_TWO)
                revert(0x00, 0x04)
            }

            let r_U_secondary_X := mload(add(proof_pointer, 448))
            let r_U_secondary_X_length := mload(r_U_secondary_X)
            if iszero(eq(r_U_secondary_X_length, 2)) {
                mstore(0x00, R_U_SECONDARY_X_LENGTH_IS_NOT_TWO)
                revert(0x00, 0x04)
            }

            result := 0x01
        }
    }

    function testStep2() public view {
        Abstractions.CompressedSnark memory proof = TestUtilities.loadProof();
        (
            Abstractions.VerifierKey memory vk,
            Abstractions.ROConstants memory ro_consts_primary,
            Abstractions.ROConstants memory ro_consts_secondary
        ) = TestUtilities.loadPublicParameters();
        uint32 numSteps = 3;
        uint256[] memory z0_primary = new uint256[](1);
        z0_primary[0] = 0x0000000000000000000000000000000000000000000000000000000000000001;

        uint256[] memory z0_secondary = new uint256[](1);
        z0_secondary[0] = 0x0000000000000000000000000000000000000000000000000000000000000000;

        assert(
            Step2GrumpkinLib.verify(
                proof, vk, ro_consts_primary, ro_consts_secondary, numSteps, z0_primary, z0_secondary
            )
        );
    }

    function testStep2Assembly() public {
        Abstractions.CompressedSnark memory proof = TestUtilities.loadProof();
        (
            Abstractions.VerifierKey memory vk,
            Abstractions.ROConstants memory ro_consts_primary,
            Abstractions.ROConstants memory ro_consts_secondary
        ) = TestUtilities.loadPublicParameters();

        uint32 numSteps = 3;
        uint256[] memory z0_primary = new uint256[](1);
        z0_primary[0] = 0x0000000000000000000000000000000000000000000000000000000000000001;

        uint256[] memory z0_secondary = new uint256[](1);
        z0_secondary[0] = 0x0000000000000000000000000000000000000000000000000000000000000000;

        uint256 gasCost = gasleft();
        bool expected = Step2GrumpkinLib.verify(
            proof, vk, ro_consts_primary, ro_consts_secondary, numSteps, z0_primary, z0_secondary
        );
        console.log("gas cost: ", gasCost - uint256(gasleft()));

        gasCost = gasleft();
        bool actual =
            step2_assembly(proof, vk, ro_consts_primary, ro_consts_secondary, z0_primary, z0_secondary, numSteps);
        console.log("gas cost (assembly): ", gasCost - uint256(gasleft()));

        assertEq(expected, actual);
    }

    // Storage
    uint256 internal constant INPUT0 = 0x200 + 0x340 + 0x00;
    uint256 internal constant INPUT1 = 0x200 + 0x340 + 0x20;
    uint256 internal constant INPUT2 = 0x200 + 0x340 + 0x40;
    uint256 internal constant INPUT3 = 0x200 + 0x340 + 0x60;
    uint256 internal constant INPUT4 = 0x200 + 0x340 + 0x80;
    uint256 internal constant INPUT5 = 0x200 + 0x340 + 0xa0;
    uint256 internal constant INPUT6 = 0x200 + 0x340 + 0xc0;
    uint256 internal constant INPUT7 = 0x200 + 0x340 + 0xe0;
    uint256 internal constant INPUT8 = 0x200 + 0x340 + 0x100;
    uint256 internal constant INPUT9 = 0x200 + 0x340 + 0x120;
    uint256 internal constant INPUT10 = 0x200 + 0x340 + 0x140;
    uint256 internal constant INPUT11 = 0x200 + 0x340 + 0x160;
    uint256 internal constant INPUT12 = 0x200 + 0x340 + 0x180;
    uint256 internal constant INPUT13 = 0x200 + 0x340 + 0x1a0;
    uint256 internal constant INPUT14 = 0x200 + 0x340 + 0x1c0;
    uint256 internal constant INPUT15 = 0x200 + 0x340 + 0x1e0;
    uint256 internal constant INPUT16 = 0x200 + 0x340 + 0x200;
    uint256 internal constant INPUT17 = 0x200 + 0x340 + 0x220;
    uint256 internal constant INPUT18 = 0x200 + 0x340 + 0x240;
    uint256 internal constant INPUT19 = 0x200 + 0x340 + 0x260;
    uint256 internal constant INPUT20 = 0x200 + 0x340 + 0x280;
    uint256 internal constant INPUT21 = 0x200 + 0x340 + 0x2a0;
    uint256 internal constant INPUT22 = 0x200 + 0x340 + 0x2c0;
    uint256 internal constant INPUT23 = 0x200 + 0x340 + 0x2e0;
    uint256 internal constant INPUT24 = 0x200 + 0x340 + 0x300;

    uint256 internal constant TMP_0 = 0x200 + 0x340 + 0x320;
    uint256 internal constant TMP_1 = 0x200 + 0x340 + 0x340;
    uint256 internal constant TMP_2 = 0x200 + 0x340 + 0x360;
    uint256 internal constant TMP_3 = 0x200 + 0x340 + 0x380;
    uint256 internal constant TMP_4 = 0x200 + 0x340 + 0x3a0;
    uint256 internal constant TMP_5 = 0x200 + 0x340 + 0x3c0;
    uint256 internal constant TMP_6 = 0x200 + 0x340 + 0x3e0;
    uint256 internal constant TMP_7 = 0x200 + 0x340 + 0x400;
    uint256 internal constant TMP_8 = 0x200 + 0x340 + 0x420;
    uint256 internal constant TMP_9 = 0x200 + 0x340 + 0x440;
    uint256 internal constant TMP_10 = 0x200 + 0x340 + 0x460;
    uint256 internal constant TMP_11 = 0x200 + 0x340 + 0x480;
    uint256 internal constant TMP_12 = 0x200 + 0x340 + 0x4a0;
    uint256 internal constant TMP_13 = 0x200 + 0x340 + 0x4c0;
    uint256 internal constant TMP_14 = 0x200 + 0x340 + 0x4e0;
    uint256 internal constant TMP_15 = 0x200 + 0x340 + 0x500;
    uint256 internal constant TMP_16 = 0x200 + 0x340 + 0x520;
    uint256 internal constant TMP_17 = 0x200 + 0x340 + 0x540;
    uint256 internal constant TMP_18 = 0x200 + 0x340 + 0x560;
    uint256 internal constant TMP_19 = 0x200 + 0x340 + 0x580;
    uint256 internal constant TMP_20 = 0x200 + 0x340 + 0x5a0;
    uint256 internal constant TMP_21 = 0x200 + 0x340 + 0x5c0;
    uint256 internal constant TMP_22 = 0x200 + 0x340 + 0x5e0;
    uint256 internal constant TMP_23 = 0x200 + 0x340 + 0x600;
    uint256 internal constant TMP_24 = 0x200 + 0x340 + 0x620;

    uint256 internal constant PARTIAL_ROUNDS = 0x200 + 0x340 + 0x640;
    uint256 internal constant HALF_OF_FULL_ROUNDS_MINUS_1 = 0x200 + 0x340 + 0x660;
    uint256 internal constant MODULUS = 0x200 + 0x340 + 0x6a0;
    uint256 internal constant ROUND_CONSTANTS = 0x200 + 0x340 + 0x6c0;
    uint256 internal constant C_M = 0x200 + 0x340 + 0x6e0;
    uint256 internal constant C_PSM = 0x200 + 0x340 + 0x700;
    uint256 internal constant W_HATS = 0x200 + 0x340 + 0x720;
    uint256 internal constant V_RESTS = 0x200 + 0x340 + 0x740;

    uint256 internal constant POSEIDON_STATE_P_VALUE = 0x200 + 0x340 + 0x760;
    uint256 internal constant R_U_SECONDARY_COMM_W_DECOMPRESSED_X = 0x200 + 0x340 + 0x780;
    uint256 internal constant R_U_SECONDARY_COMM_W_DECOMPRESSED_Y = 0x200 + 0x340 + 0x7a0;
    uint256 internal constant R_U_SECONDARY_COMM_W_DECOMPRESSED_Z = 0x200 + 0x340 + 0x7c0;
    uint256 internal constant R_U_SECONDARY_COMM_E_DECOMPRESSED_X = 0x200 + 0x340 + 0x7e0;
    uint256 internal constant R_U_SECONDARY_COMM_E_DECOMPRESSED_Y = 0x200 + 0x340 + 0x800;
    uint256 internal constant R_U_SECONDARY_COMM_E_DECOMPRESSED_Z = 0x200 + 0x340 + 0x820;

    uint256 internal constant EXPECTED_HASH = 0x200 + 0x340 + 0x840;

    uint256 internal constant R_U_PRIMARY_COMM_W_DECOMPRESSED_X = 0x200 + 0x340 + 0x860;
    uint256 internal constant R_U_PRIMARY_COMM_W_DECOMPRESSED_Y = 0x200 + 0x340 + 0x880;
    uint256 internal constant R_U_PRIMARY_COMM_W_DECOMPRESSED_Z = 0x200 + 0x340 + 0x8a0;
    uint256 internal constant R_U_PRIMARY_COMM_E_DECOMPRESSED_X = 0x200 + 0x340 + 0x8c0;
    uint256 internal constant R_U_PRIMARY_COMM_E_DECOMPRESSED_Y = 0x200 + 0x340 + 0x8e0;
    uint256 internal constant R_U_PRIMARY_COMM_E_DECOMPRESSED_Z = 0x200 + 0x340 + 0x900;

    // Errors
    bytes4 internal constant Z0_PRIMARY_UNEXPECTED_SIZE = 0x1aefdde0;
    bytes4 internal constant Z0_SECONDARY_UNEXPECTED_SIZE = 0xbcb12875;
    bytes4 internal constant ZN_PRIMARY_UNEXPECTED_SIZE = 0x38a73beb;
    bytes4 internal constant ZN_SECONDARY_UNEXPECTED_SIZE = 0x0274bbbe;

    function get_w_hats(PoseidonU24Optimized.PoseidonConstantsU24 memory c) private pure returns (uint256[][] memory) {
        uint256[][] memory w_hats = new uint256[][](c.sparseMatrices.length);
        for (uint256 index = 0; index < w_hats.length; index++) {
            w_hats[index] = new uint256[](c.sparseMatrices[index].w_hat.length);
            for (uint256 j = 0; j < w_hats[index].length; j++) {
                w_hats[index][j] = c.sparseMatrices[index].w_hat[j];
            }
        }
        return w_hats;
    }

    function get_v_rests(PoseidonU24Optimized.PoseidonConstantsU24 memory c)
        private
        pure
        returns (uint256[][] memory)
    {
        uint256[][] memory v_rests = new uint256[][](c.sparseMatrices.length);
        for (uint256 index = 0; index < v_rests.length; index++) {
            v_rests[index] = new uint256[](c.sparseMatrices[index].v_rest.length);
            for (uint256 j = 0; j < v_rests[index].length; j++) {
                v_rests[index][j] = c.sparseMatrices[index].v_rest[j];
            }
        }
        return v_rests;
    }

    function compute_p_value(uint256 absorbLen) public returns (uint256) {
        uint32 DOMAIN_SEPARATOR = 0;
        uint32 SQUEEZE_NUM = 1;

        SpongeOpLib.SpongeOp memory absorb = SpongeOpLib.SpongeOp(SpongeOpLib.SpongeOpType.Absorb, uint32(absorbLen));
        SpongeOpLib.SpongeOp memory squeeze = SpongeOpLib.SpongeOp(SpongeOpLib.SpongeOpType.Squeeze, SQUEEZE_NUM);
        SpongeOpLib.SpongeOp[] memory pattern = new SpongeOpLib.SpongeOp[](2);
        pattern[0] = absorb;
        pattern[1] = squeeze;

        return IOPatternLib.value(IOPatternLib.IOPattern(pattern), DOMAIN_SEPARATOR);
    }

    /*
        gas cost:  34193872
        gas cost [step2_assembly_1] (decompression):  313157
        gas cost [step2_assembly_1] (constants processing):  4115204
        gas cost [step2_assembly_1] (composing input):  1074
        gas cost [step2_assembly_1] (pure hashing):  534004
        gas cost (step2_assembly_1):  4969850
        gas cost [step2_assembly_2] (decompression):  240372
        gas cost [step2_assembly_2] (constants processing):  5898127
        gas cost [step2_assembly_2] (composing input):  1181
        gas cost [step2_assembly_2] (pure hashing):  534106
        gas cost (step2_assembly_2):  6682326
        gas cost (assembly):  11655891


        gas cost:  34193872
        gas cost [step2_assembly_2] (decompression):  232568
        gas cost [step2_assembly_2] (constants processing):  4115211
        gas cost [step2_assembly_2] (composing input):  1080
        gas cost [step2_assembly_2] (pure hashing):  534004
        gas cost (step2_assembly_2):  4889274
        gas cost [step2_assembly_1] (decompression):  320961
        gas cost [step2_assembly_1] (constants processing):  5898120
        gas cost [step2_assembly_1] (composing input):  1175
        gas cost [step2_assembly_1] (pure hashing):  534106
        gas cost (step2_assembly_1):  6762902
        gas cost (assembly):  11655891

    */
    function step2_assembly(
        Abstractions.CompressedSnark memory proof,
        Abstractions.VerifierKey memory vk,
        Abstractions.ROConstants memory ro_consts_primary,
        Abstractions.ROConstants memory ro_consts_secondary,
        uint256[] memory z0_primary,
        uint256[] memory z0_secondary,
        uint32 numSteps
    ) public returns (bool result) {
        uint256 gasCostPureComputation = gasleft();
        bool result1 =
            step2_assembly_2(proof, vk, ro_consts_primary, ro_consts_secondary, z0_primary, z0_secondary, numSteps);
        console.log("gas cost (step2_assembly_2): ", gasCostPureComputation - uint256(gasleft()));

        gasCostPureComputation = gasleft();
        bool result2 =
            step2_assembly_1(proof, vk, ro_consts_primary, ro_consts_secondary, z0_primary, z0_secondary, numSteps);
        console.log("gas cost (step2_assembly_1): ", gasCostPureComputation - uint256(gasleft()));

        assembly {
            result := and(result1, result2)
        }
    }

    function testComputePValue() public {
        uint256 gasCost = gasleft();
        assertEq(0x00000000000000000000000000000000ffffffffffffffffffffffb0800056f4, compute_p_value(19));
        console.log("gas cost: ", gasCost - uint256(gasleft()));
    }

    function step2_assembly_2(
        Abstractions.CompressedSnark memory proof,
        Abstractions.VerifierKey memory vk,
        Abstractions.ROConstants memory ro_consts_primary,
        Abstractions.ROConstants memory ro_consts_secondary,
        uint256[] memory z0_primary,
        uint256[] memory z0_secondary,
        uint32 numSteps
    ) private returns (bool result) {
        result = false;

        uint256 gasCost = gasleft();
        uint256[25] memory input;
        {
            uint256 NUM_FE_WITHOUT_IO_FOR_CRHF = 17;
            uint256 pValue = compute_p_value(NUM_FE_WITHOUT_IO_FOR_CRHF + vk.f_arity_secondary * 2);
            Bn256.Bn256AffinePoint memory comm_W_decompressed = Bn256.decompress(proof.r_U_primary.comm_W);
            Bn256.Bn256AffinePoint memory comm_E_decompressed = Bn256.decompress(proof.r_U_primary.comm_E);
            assembly {
                mstore(POSEIDON_STATE_P_VALUE, pValue)
                mstore(R_U_PRIMARY_COMM_W_DECOMPRESSED_X, mload(comm_W_decompressed))
                mstore(R_U_PRIMARY_COMM_W_DECOMPRESSED_Y, mload(add(comm_W_decompressed, 32)))
                mstore(R_U_PRIMARY_COMM_W_DECOMPRESSED_Z, 0)
                mstore(R_U_PRIMARY_COMM_E_DECOMPRESSED_X, mload(comm_E_decompressed))
                mstore(R_U_PRIMARY_COMM_E_DECOMPRESSED_Y, mload(add(comm_E_decompressed, 32)))
                mstore(R_U_PRIMARY_COMM_E_DECOMPRESSED_Z, 0)
            }
        }
        console.log("gas cost [step2_assembly_2] (decompression): ", gasCost - uint256(gasleft()));

        gasCost = gasleft();
        {
            uint256 partial_rounds = ro_consts_primary.partial_rounds;
            uint256 half_of_full_rounds_minus_1 = (ro_consts_primary.full_rounds / 2) - 1;
            uint256 modulus = Grumpkin.P_MOD;
            uint256[] memory round_constants = ro_consts_primary.addRoundConstants;

            PoseidonU24Optimized.PoseidonConstantsU24 memory c = PoseidonU24Optimized.newConstants(ro_consts_primary);
            uint256[][] memory c_m = c.m;
            uint256[][] memory c_psm = c.psm;
            uint256[][] memory w_hats = get_w_hats(c);
            uint256[][] memory v_rests = get_v_rests(c);
            assembly {
                mstore(PARTIAL_ROUNDS, partial_rounds)
                mstore(HALF_OF_FULL_ROUNDS_MINUS_1, half_of_full_rounds_minus_1)
                mstore(MODULUS, modulus)
                mstore(ROUND_CONSTANTS, round_constants)
                mstore(C_M, c_m)
                mstore(C_PSM, c_psm)
                mstore(W_HATS, w_hats)
                mstore(V_RESTS, v_rests)
            }
        }
        console.log("gas cost [step2_assembly_2] (constants processing): ", gasCost - uint256(gasleft()));

        gasCost = gasleft();
        assembly {
            // compose input
            {
                // we assume that 'z0_secondary' has exactly 1 element
                let length := mload(z0_secondary)
                if iszero(eq(length, 1)) {
                    mstore(0x00, Z0_SECONDARY_UNEXPECTED_SIZE)
                    revert(0x00, 0x04)
                }
                // we assume that 'proof.zn_secondary' has exactly 1 element
                length := mload(add(proof, 928)) // length of 'zn_secondary'
                if iszero(eq(length, 1)) {
                    mstore(0x00, ZN_SECONDARY_UNEXPECTED_SIZE)
                    revert(0x00, 0x04)
                }

                // Since Step1 guarantees that length of r_U_primary_X is 2, we can use following hardcode
                let r_U_primary_X := mload(add(mload(proof), 224))
                let r_U_primary_X_0 := mload(add(r_U_primary_X, 32))
                let r_U_primary_X_1 := mload(add(r_U_primary_X, 64))

                mstore(add(input, 0), mload(POSEIDON_STATE_P_VALUE)) // pValue, which is computed according to Sponge rules
                mstore(add(input, 32), mload(add(vk, 64))) // vk.digest
                mstore(add(input, 64), numSteps)
                mstore(add(input, 96), mload(add(z0_secondary, 32))) // z0_secondary[0]
                mstore(add(input, 128), mload(add(proof, 960))) // proof.zn_secondary[0]
                mstore(add(input, 160), mload(R_U_PRIMARY_COMM_W_DECOMPRESSED_X))
                mstore(add(input, 192), mload(R_U_PRIMARY_COMM_W_DECOMPRESSED_Y))
                mstore(add(input, 224), mload(R_U_PRIMARY_COMM_W_DECOMPRESSED_Z))
                mstore(add(input, 256), mload(R_U_PRIMARY_COMM_E_DECOMPRESSED_X))
                mstore(add(input, 288), mload(R_U_PRIMARY_COMM_E_DECOMPRESSED_Y))
                mstore(add(input, 320), mload(R_U_PRIMARY_COMM_E_DECOMPRESSED_Z))
                mstore(add(input, 352), mload(add(mload(proof), 256))) // proof.r_U_primary.u
                mstore(
                    add(input, 384),
                    and(0x000000000000000000000000000000000000000000000000ffffffffffffffff, r_U_primary_X_0)
                )
                mstore(
                    add(input, 416),
                    shr(64, and(0x00000000000000000000000000000000ffffffffffffffff0000000000000000, r_U_primary_X_0))
                )
                mstore(
                    add(input, 448),
                    shr(128, and(0x0000000000000000ffffffffffffffff00000000000000000000000000000000, r_U_primary_X_0))
                )
                mstore(
                    add(input, 480),
                    shr(192, and(0xffffffffffffffff000000000000000000000000000000000000000000000000, r_U_primary_X_0))
                )
                mstore(
                    add(input, 512),
                    and(0x000000000000000000000000000000000000000000000000ffffffffffffffff, r_U_primary_X_1)
                )
                mstore(
                    add(input, 544),
                    shr(64, and(0x00000000000000000000000000000000ffffffffffffffff0000000000000000, r_U_primary_X_1))
                )
                mstore(
                    add(input, 576),
                    shr(128, and(0x0000000000000000ffffffffffffffff00000000000000000000000000000000, r_U_primary_X_1))
                )
                mstore(
                    add(input, 608),
                    shr(192, and(0xffffffffffffffff000000000000000000000000000000000000000000000000, r_U_primary_X_1))
                )
                mstore(add(input, 640), 0x0000000000000000000000000000000000000000000000000000000000000000)
                mstore(add(input, 672), 0x0000000000000000000000000000000000000000000000000000000000000000)
                mstore(add(input, 704), 0x0000000000000000000000000000000000000000000000000000000000000000)
                mstore(add(input, 736), 0x0000000000000000000000000000000000000000000000000000000000000000)
                mstore(add(input, 768), 0x0000000000000000000000000000000000000000000000000000000000000000)

                // store expected hash in the memory to compare
                let l_u_secondary_x_1 := mload(add(mload(proof), 128))
                mstore(EXPECTED_HASH, l_u_secondary_x_1)
            }
        }
        console.log("gas cost [step2_assembly_2] (composing input): ", gasCost - uint256(gasleft()));

        gasCost = gasleft();
        result = step2_assembly_inner(input);
        console.log("gas cost [step2_assembly_2] (pure hashing): ", gasCost - uint256(gasleft()));

        assembly {
            mstore(PARTIAL_ROUNDS, 0)
            mstore(HALF_OF_FULL_ROUNDS_MINUS_1, 0)
            mstore(MODULUS, 0)
            mstore(ROUND_CONSTANTS, 0)
            mstore(C_M, 0)
            mstore(C_PSM, 0)
            mstore(W_HATS, 0)
            mstore(V_RESTS, 0)
        }
    }

    function step2_assembly_1(
        Abstractions.CompressedSnark memory proof,
        Abstractions.VerifierKey memory vk,
        Abstractions.ROConstants memory ro_consts_primary,
        Abstractions.ROConstants memory ro_consts_secondary,
        uint256[] memory z0_primary,
        uint256[] memory z0_secondary,
        uint32 numSteps
    ) private returns (bool result) {
        result = false;

        uint256 gasCost = gasleft();
        uint256[25] memory input;
        {
            uint256 NUM_FE_WITHOUT_IO_FOR_CRHF = 17;
            uint256 pValue = compute_p_value(NUM_FE_WITHOUT_IO_FOR_CRHF + vk.f_arity_primary * 2);
            Grumpkin.GrumpkinAffinePoint memory comm_W_decompressed = Grumpkin.decompress(proof.r_U_secondary.comm_W);
            Grumpkin.GrumpkinAffinePoint memory comm_E_decompressed = Grumpkin.decompress(proof.r_U_secondary.comm_E);
            assembly {
                mstore(POSEIDON_STATE_P_VALUE, pValue)
                mstore(R_U_SECONDARY_COMM_W_DECOMPRESSED_X, mload(comm_W_decompressed))
                mstore(R_U_SECONDARY_COMM_W_DECOMPRESSED_Y, mload(add(comm_W_decompressed, 32)))
                mstore(R_U_SECONDARY_COMM_W_DECOMPRESSED_Z, 0)
                mstore(R_U_SECONDARY_COMM_E_DECOMPRESSED_X, mload(comm_E_decompressed))
                mstore(R_U_SECONDARY_COMM_E_DECOMPRESSED_Y, mload(add(comm_E_decompressed, 32)))
                mstore(R_U_SECONDARY_COMM_E_DECOMPRESSED_Z, 0)
            }
        }
        console.log("gas cost [step2_assembly_1] (decompression): ", gasCost - uint256(gasleft()));

        gasCost = gasleft();
        {
            uint256 partial_rounds = ro_consts_secondary.partial_rounds;
            uint256 half_of_full_rounds_minus_1 = (ro_consts_secondary.full_rounds / 2) - 1;
            uint256 modulus = Bn256.R_MOD;
            uint256[] memory round_constants = ro_consts_secondary.addRoundConstants;

            PoseidonU24Optimized.PoseidonConstantsU24 memory c = PoseidonU24Optimized.newConstants(ro_consts_secondary);
            uint256[][] memory c_m = c.m;
            uint256[][] memory c_psm = c.psm;
            uint256[][] memory w_hats = get_w_hats(c);
            uint256[][] memory v_rests = get_v_rests(c);
            assembly {
                mstore(PARTIAL_ROUNDS, partial_rounds)
                mstore(HALF_OF_FULL_ROUNDS_MINUS_1, half_of_full_rounds_minus_1)
                mstore(MODULUS, modulus)
                mstore(ROUND_CONSTANTS, round_constants)
                mstore(C_M, c_m)
                mstore(C_PSM, c_psm)
                mstore(W_HATS, w_hats)
                mstore(V_RESTS, v_rests)
            }
        }
        console.log("gas cost [step2_assembly_1] (constants processing): ", gasCost - uint256(gasleft()));

        gasCost = gasleft();
        assembly {
            // compose input
            {
                // we assume that 'z0_primary' has exactly 1 element
                let length := mload(z0_primary)
                if iszero(eq(length, 1)) {
                    mstore(0x00, Z0_PRIMARY_UNEXPECTED_SIZE)
                    revert(0x00, 0x04)
                }

                // we assume that 'proof.zn_primary' has exactly 1 element
                length := mload(add(proof, 864)) // length of 'zn_primary'
                if iszero(eq(length, 1)) {
                    mstore(0x00, ZN_PRIMARY_UNEXPECTED_SIZE)
                    revert(0x00, 0x04)
                }

                // Since Step1 guarantees that length of r_U_secondary_X is 2, we can use following hardcode
                let r_U_secondary_X := mload(add(proof, 704))
                let r_U_secondary_X_0 := mload(add(r_U_secondary_X, 32))
                let r_U_secondary_X_1 := mload(add(r_U_secondary_X, 64))

                mstore(add(input, 0), mload(POSEIDON_STATE_P_VALUE)) // pValue, which is computed according to Sponge rules
                mstore(add(input, 32), mload(add(vk, 64))) // vk.digest
                mstore(add(input, 64), numSteps)
                mstore(add(input, 96), mload(add(z0_primary, 32))) // z0_primary[0]
                mstore(add(input, 128), mload(add(proof, 896))) // proof.zn_primary[0]
                mstore(add(input, 160), mload(R_U_SECONDARY_COMM_W_DECOMPRESSED_X))
                mstore(add(input, 192), mload(R_U_SECONDARY_COMM_W_DECOMPRESSED_Y))
                mstore(add(input, 224), mload(R_U_SECONDARY_COMM_W_DECOMPRESSED_Z))
                mstore(add(input, 256), mload(R_U_SECONDARY_COMM_E_DECOMPRESSED_X))
                mstore(add(input, 288), mload(R_U_SECONDARY_COMM_E_DECOMPRESSED_Y))
                mstore(add(input, 320), mload(R_U_SECONDARY_COMM_E_DECOMPRESSED_Z))
                mstore(add(input, 352), mload(add(proof, 736))) // proof.r_U_secondary.u
                mstore(
                    add(input, 384),
                    and(0x000000000000000000000000000000000000000000000000ffffffffffffffff, r_U_secondary_X_0)
                )
                mstore(
                    add(input, 416),
                    shr(64, and(0x00000000000000000000000000000000ffffffffffffffff0000000000000000, r_U_secondary_X_0))
                )
                mstore(
                    add(input, 448),
                    shr(128, and(0x0000000000000000ffffffffffffffff00000000000000000000000000000000, r_U_secondary_X_0))
                )
                mstore(
                    add(input, 480),
                    shr(192, and(0xffffffffffffffff000000000000000000000000000000000000000000000000, r_U_secondary_X_0))
                )
                mstore(
                    add(input, 512),
                    and(0x000000000000000000000000000000000000000000000000ffffffffffffffff, r_U_secondary_X_1)
                )
                mstore(
                    add(input, 544),
                    shr(64, and(0x00000000000000000000000000000000ffffffffffffffff0000000000000000, r_U_secondary_X_1))
                )
                mstore(
                    add(input, 576),
                    shr(128, and(0x0000000000000000ffffffffffffffff00000000000000000000000000000000, r_U_secondary_X_1))
                )
                mstore(
                    add(input, 608),
                    shr(192, and(0xffffffffffffffff000000000000000000000000000000000000000000000000, r_U_secondary_X_1))
                )
                mstore(add(input, 640), 0x0000000000000000000000000000000000000000000000000000000000000000)
                mstore(add(input, 672), 0x0000000000000000000000000000000000000000000000000000000000000000)
                mstore(add(input, 704), 0x0000000000000000000000000000000000000000000000000000000000000000)
                mstore(add(input, 736), 0x0000000000000000000000000000000000000000000000000000000000000000)
                mstore(add(input, 768), 0x0000000000000000000000000000000000000000000000000000000000000000)

                // store expected hash in the memory to compare
                let l_u_secondary_x_0 := mload(add(mload(proof), 96))
                mstore(EXPECTED_HASH, l_u_secondary_x_0)
            }
        }
        console.log("gas cost [step2_assembly_1] (composing input): ", gasCost - uint256(gasleft()));

        gasCost = gasleft();
        result = step2_assembly_inner(input);
        console.log("gas cost [step2_assembly_1] (pure hashing): ", gasCost - uint256(gasleft()));

        assembly {
            mstore(PARTIAL_ROUNDS, 0)
            mstore(HALF_OF_FULL_ROUNDS_MINUS_1, 0)
            mstore(MODULUS, 0)
            mstore(ROUND_CONSTANTS, 0)
            mstore(C_M, 0)
            mstore(C_PSM, 0)
            mstore(W_HATS, 0)
            mstore(V_RESTS, 0)
        }
    }

    function step2_assembly_inner(uint256[25] memory input) private returns (bool result) {
        result = false;
        assembly {
            function mix(_c_m, _modulus) {
                mix_inner(TMP_0, mload(add(_c_m, 32)), _modulus)
                mix_inner(TMP_1, mload(add(_c_m, 64)), _modulus)
                mix_inner(TMP_2, mload(add(_c_m, 96)), _modulus)
                mix_inner(TMP_3, mload(add(_c_m, 128)), _modulus)
                mix_inner(TMP_4, mload(add(_c_m, 160)), _modulus)
                mix_inner(TMP_5, mload(add(_c_m, 192)), _modulus)
                mix_inner(TMP_6, mload(add(_c_m, 224)), _modulus)
                mix_inner(TMP_7, mload(add(_c_m, 256)), _modulus)
                mix_inner(TMP_8, mload(add(_c_m, 288)), _modulus)
                mix_inner(TMP_9, mload(add(_c_m, 320)), _modulus)
                mix_inner(TMP_10, mload(add(_c_m, 352)), _modulus)
                mix_inner(TMP_11, mload(add(_c_m, 384)), _modulus)
                mix_inner(TMP_12, mload(add(_c_m, 416)), _modulus)
                mix_inner(TMP_13, mload(add(_c_m, 448)), _modulus)
                mix_inner(TMP_14, mload(add(_c_m, 480)), _modulus)
                mix_inner(TMP_15, mload(add(_c_m, 512)), _modulus)
                mix_inner(TMP_16, mload(add(_c_m, 544)), _modulus)
                mix_inner(TMP_17, mload(add(_c_m, 576)), _modulus)
                mix_inner(TMP_18, mload(add(_c_m, 608)), _modulus)
                mix_inner(TMP_19, mload(add(_c_m, 640)), _modulus)
                mix_inner(TMP_20, mload(add(_c_m, 672)), _modulus)
                mix_inner(TMP_21, mload(add(_c_m, 704)), _modulus)
                mix_inner(TMP_22, mload(add(_c_m, 736)), _modulus)
                mix_inner(TMP_23, mload(add(_c_m, 768)), _modulus)
                mix_inner(TMP_24, mload(add(_c_m, 800)), _modulus)

                mstore(INPUT0, mload(TMP_0))
                mstore(INPUT1, mload(TMP_1))
                mstore(INPUT2, mload(TMP_2))
                mstore(INPUT3, mload(TMP_3))
                mstore(INPUT4, mload(TMP_4))
                mstore(INPUT5, mload(TMP_5))
                mstore(INPUT6, mload(TMP_6))
                mstore(INPUT7, mload(TMP_7))
                mstore(INPUT8, mload(TMP_8))
                mstore(INPUT9, mload(TMP_9))
                mstore(INPUT10, mload(TMP_10))
                mstore(INPUT11, mload(TMP_11))
                mstore(INPUT12, mload(TMP_12))
                mstore(INPUT13, mload(TMP_13))
                mstore(INPUT14, mload(TMP_14))
                mstore(INPUT15, mload(TMP_15))
                mstore(INPUT16, mload(TMP_16))
                mstore(INPUT17, mload(TMP_17))
                mstore(INPUT18, mload(TMP_18))
                mstore(INPUT19, mload(TMP_19))
                mstore(INPUT20, mload(TMP_20))
                mstore(INPUT21, mload(TMP_21))
                mstore(INPUT22, mload(TMP_22))
                mstore(INPUT23, mload(TMP_23))
                mstore(INPUT24, mload(TMP_24))
            }
            function add_round_constants(_round_constants, offset, _modulus) {
                mstore(INPUT0, addmod(mload(INPUT0), mload(add(_round_constants, add(offset, 32))), _modulus))
                mstore(INPUT1, addmod(mload(INPUT1), mload(add(_round_constants, add(offset, 64))), _modulus))
                mstore(INPUT2, addmod(mload(INPUT2), mload(add(_round_constants, add(offset, 96))), _modulus))
                mstore(INPUT3, addmod(mload(INPUT3), mload(add(_round_constants, add(offset, 128))), _modulus))
                mstore(INPUT4, addmod(mload(INPUT4), mload(add(_round_constants, add(offset, 160))), _modulus))
                mstore(INPUT5, addmod(mload(INPUT5), mload(add(_round_constants, add(offset, 192))), _modulus))
                mstore(INPUT6, addmod(mload(INPUT6), mload(add(_round_constants, add(offset, 224))), _modulus))
                mstore(INPUT7, addmod(mload(INPUT7), mload(add(_round_constants, add(offset, 256))), _modulus))
                mstore(INPUT8, addmod(mload(INPUT8), mload(add(_round_constants, add(offset, 288))), _modulus))
                mstore(INPUT9, addmod(mload(INPUT9), mload(add(_round_constants, add(offset, 320))), _modulus))
                mstore(INPUT10, addmod(mload(INPUT10), mload(add(_round_constants, add(offset, 352))), _modulus))
                mstore(INPUT11, addmod(mload(INPUT11), mload(add(_round_constants, add(offset, 384))), _modulus))
                mstore(INPUT12, addmod(mload(INPUT12), mload(add(_round_constants, add(offset, 416))), _modulus))
                mstore(INPUT13, addmod(mload(INPUT13), mload(add(_round_constants, add(offset, 448))), _modulus))
                mstore(INPUT14, addmod(mload(INPUT14), mload(add(_round_constants, add(offset, 480))), _modulus))
                mstore(INPUT15, addmod(mload(INPUT15), mload(add(_round_constants, add(offset, 512))), _modulus))
                mstore(INPUT16, addmod(mload(INPUT16), mload(add(_round_constants, add(offset, 544))), _modulus))
                mstore(INPUT17, addmod(mload(INPUT17), mload(add(_round_constants, add(offset, 576))), _modulus))
                mstore(INPUT18, addmod(mload(INPUT18), mload(add(_round_constants, add(offset, 608))), _modulus))
                mstore(INPUT19, addmod(mload(INPUT19), mload(add(_round_constants, add(offset, 640))), _modulus))
                mstore(INPUT20, addmod(mload(INPUT20), mload(add(_round_constants, add(offset, 672))), _modulus))
                mstore(INPUT21, addmod(mload(INPUT21), mload(add(_round_constants, add(offset, 704))), _modulus))
                mstore(INPUT22, addmod(mload(INPUT22), mload(add(_round_constants, add(offset, 736))), _modulus))
                mstore(INPUT23, addmod(mload(INPUT23), mload(add(_round_constants, add(offset, 768))), _modulus))
                mstore(INPUT24, addmod(mload(INPUT24), mload(add(_round_constants, add(offset, 800))), _modulus))
            }

            function sbox_full(_modulus) {
                mstore(INPUT0, sbox(mload(INPUT0), _modulus))
                mstore(INPUT1, sbox(mload(INPUT1), _modulus))
                mstore(INPUT2, sbox(mload(INPUT2), _modulus))
                mstore(INPUT3, sbox(mload(INPUT3), _modulus))
                mstore(INPUT4, sbox(mload(INPUT4), _modulus))
                mstore(INPUT5, sbox(mload(INPUT5), _modulus))
                mstore(INPUT6, sbox(mload(INPUT6), _modulus))
                mstore(INPUT7, sbox(mload(INPUT7), _modulus))
                mstore(INPUT8, sbox(mload(INPUT8), _modulus))
                mstore(INPUT9, sbox(mload(INPUT9), _modulus))
                mstore(INPUT10, sbox(mload(INPUT10), _modulus))
                mstore(INPUT11, sbox(mload(INPUT11), _modulus))
                mstore(INPUT12, sbox(mload(INPUT12), _modulus))
                mstore(INPUT13, sbox(mload(INPUT13), _modulus))
                mstore(INPUT14, sbox(mload(INPUT14), _modulus))
                mstore(INPUT15, sbox(mload(INPUT15), _modulus))
                mstore(INPUT16, sbox(mload(INPUT16), _modulus))
                mstore(INPUT17, sbox(mload(INPUT17), _modulus))
                mstore(INPUT18, sbox(mload(INPUT18), _modulus))
                mstore(INPUT19, sbox(mload(INPUT19), _modulus))
                mstore(INPUT20, sbox(mload(INPUT20), _modulus))
                mstore(INPUT21, sbox(mload(INPUT21), _modulus))
                mstore(INPUT22, sbox(mload(INPUT22), _modulus))
                mstore(INPUT23, sbox(mload(INPUT23), _modulus))
                mstore(INPUT24, sbox(mload(INPUT24), _modulus))
            }

            function sbox(a, _modulus) -> ret {
                let tmp := 0
                tmp := mulmod(a, a, _modulus)
                tmp := mulmod(tmp, tmp, _modulus)
                ret := mulmod(a, tmp, _modulus)
            }

            function mix_inner(input_pointer, matrix_pointer, _modulus) {
                let tmp := 0

                tmp := addmod(tmp, mulmod(mload(INPUT0), mload(add(matrix_pointer, 32)), _modulus), _modulus)
                tmp := addmod(tmp, mulmod(mload(INPUT1), mload(add(matrix_pointer, 64)), _modulus), _modulus)
                tmp := addmod(tmp, mulmod(mload(INPUT2), mload(add(matrix_pointer, 96)), _modulus), _modulus)
                tmp := addmod(tmp, mulmod(mload(INPUT3), mload(add(matrix_pointer, 128)), _modulus), _modulus)
                tmp := addmod(tmp, mulmod(mload(INPUT4), mload(add(matrix_pointer, 160)), _modulus), _modulus)
                tmp := addmod(tmp, mulmod(mload(INPUT5), mload(add(matrix_pointer, 192)), _modulus), _modulus)
                tmp := addmod(tmp, mulmod(mload(INPUT6), mload(add(matrix_pointer, 224)), _modulus), _modulus)
                tmp := addmod(tmp, mulmod(mload(INPUT7), mload(add(matrix_pointer, 256)), _modulus), _modulus)
                tmp := addmod(tmp, mulmod(mload(INPUT8), mload(add(matrix_pointer, 288)), _modulus), _modulus)
                tmp := addmod(tmp, mulmod(mload(INPUT9), mload(add(matrix_pointer, 320)), _modulus), _modulus)
                tmp := addmod(tmp, mulmod(mload(INPUT10), mload(add(matrix_pointer, 352)), _modulus), _modulus)
                tmp := addmod(tmp, mulmod(mload(INPUT11), mload(add(matrix_pointer, 384)), _modulus), _modulus)
                tmp := addmod(tmp, mulmod(mload(INPUT12), mload(add(matrix_pointer, 416)), _modulus), _modulus)
                tmp := addmod(tmp, mulmod(mload(INPUT13), mload(add(matrix_pointer, 448)), _modulus), _modulus)
                tmp := addmod(tmp, mulmod(mload(INPUT14), mload(add(matrix_pointer, 480)), _modulus), _modulus)
                tmp := addmod(tmp, mulmod(mload(INPUT15), mload(add(matrix_pointer, 512)), _modulus), _modulus)
                tmp := addmod(tmp, mulmod(mload(INPUT16), mload(add(matrix_pointer, 544)), _modulus), _modulus)
                tmp := addmod(tmp, mulmod(mload(INPUT17), mload(add(matrix_pointer, 576)), _modulus), _modulus)
                tmp := addmod(tmp, mulmod(mload(INPUT18), mload(add(matrix_pointer, 608)), _modulus), _modulus)
                tmp := addmod(tmp, mulmod(mload(INPUT19), mload(add(matrix_pointer, 640)), _modulus), _modulus)
                tmp := addmod(tmp, mulmod(mload(INPUT20), mload(add(matrix_pointer, 672)), _modulus), _modulus)
                tmp := addmod(tmp, mulmod(mload(INPUT21), mload(add(matrix_pointer, 704)), _modulus), _modulus)
                tmp := addmod(tmp, mulmod(mload(INPUT22), mload(add(matrix_pointer, 736)), _modulus), _modulus)
                tmp := addmod(tmp, mulmod(mload(INPUT23), mload(add(matrix_pointer, 768)), _modulus), _modulus)
                tmp := addmod(tmp, mulmod(mload(INPUT24), mload(add(matrix_pointer, 800)), _modulus), _modulus)
                mstore(input_pointer, tmp)
            }

            function mix_sparse(_v_rests, _w_hats, _offset_mix, _modulus) {
                mstore(TMP_0, 0)
                mstore(TMP_1, 0)
                mstore(TMP_2, 0)
                mstore(TMP_3, 0)
                mstore(TMP_4, 0)
                mstore(TMP_5, 0)
                mstore(TMP_6, 0)
                mstore(TMP_7, 0)
                mstore(TMP_8, 0)
                mstore(TMP_9, 0)
                mstore(TMP_10, 0)
                mstore(TMP_11, 0)
                mstore(TMP_12, 0)
                mstore(TMP_13, 0)
                mstore(TMP_14, 0)
                mstore(TMP_15, 0)
                mstore(TMP_16, 0)
                mstore(TMP_17, 0)
                mstore(TMP_18, 0)
                mstore(TMP_19, 0)
                mstore(TMP_20, 0)
                mstore(TMP_21, 0)
                mstore(TMP_22, 0)
                mstore(TMP_23, 0)
                mstore(TMP_24, 0)

                // w_hat
                let w_hat_pointer := mload(add(_w_hats, add(_offset_mix, 32)))
                // v_rest
                let v_rest_pointer := mload(add(_v_rests, add(_offset_mix, 32)))

                let tmp := 0

                tmp := mulmod(mload(INPUT0), mload(add(w_hat_pointer, 32)), _modulus)
                mstore(TMP_0, addmod(mload(TMP_0), tmp, _modulus))

                tmp := mulmod(mload(INPUT1), mload(add(w_hat_pointer, 64)), _modulus)
                mstore(TMP_0, addmod(mload(TMP_0), tmp, _modulus))

                tmp := mulmod(mload(INPUT2), mload(add(w_hat_pointer, 96)), _modulus)
                mstore(TMP_0, addmod(mload(TMP_0), tmp, _modulus))

                tmp := mulmod(mload(INPUT3), mload(add(w_hat_pointer, 128)), _modulus)
                mstore(TMP_0, addmod(mload(TMP_0), tmp, _modulus))

                tmp := mulmod(mload(INPUT4), mload(add(w_hat_pointer, 160)), _modulus)
                mstore(TMP_0, addmod(mload(TMP_0), tmp, _modulus))

                tmp := mulmod(mload(INPUT5), mload(add(w_hat_pointer, 192)), _modulus)
                mstore(TMP_0, addmod(mload(TMP_0), tmp, _modulus))

                tmp := mulmod(mload(INPUT6), mload(add(w_hat_pointer, 224)), _modulus)
                mstore(TMP_0, addmod(mload(TMP_0), tmp, _modulus))

                tmp := mulmod(mload(INPUT7), mload(add(w_hat_pointer, 256)), _modulus)
                mstore(TMP_0, addmod(mload(TMP_0), tmp, _modulus))

                tmp := mulmod(mload(INPUT8), mload(add(w_hat_pointer, 288)), _modulus)
                mstore(TMP_0, addmod(mload(TMP_0), tmp, _modulus))

                tmp := mulmod(mload(INPUT9), mload(add(w_hat_pointer, 320)), _modulus)
                mstore(TMP_0, addmod(mload(TMP_0), tmp, _modulus))

                tmp := mulmod(mload(INPUT10), mload(add(w_hat_pointer, 352)), _modulus)
                mstore(TMP_0, addmod(mload(TMP_0), tmp, _modulus))

                tmp := mulmod(mload(INPUT11), mload(add(w_hat_pointer, 384)), _modulus)
                mstore(TMP_0, addmod(mload(TMP_0), tmp, _modulus))

                tmp := mulmod(mload(INPUT12), mload(add(w_hat_pointer, 416)), _modulus)
                mstore(TMP_0, addmod(mload(TMP_0), tmp, _modulus))

                tmp := mulmod(mload(INPUT13), mload(add(w_hat_pointer, 448)), _modulus)
                mstore(TMP_0, addmod(mload(TMP_0), tmp, _modulus))

                tmp := mulmod(mload(INPUT14), mload(add(w_hat_pointer, 480)), _modulus)
                mstore(TMP_0, addmod(mload(TMP_0), tmp, _modulus))

                tmp := mulmod(mload(INPUT15), mload(add(w_hat_pointer, 512)), _modulus)
                mstore(TMP_0, addmod(mload(TMP_0), tmp, _modulus))

                tmp := mulmod(mload(INPUT16), mload(add(w_hat_pointer, 544)), _modulus)
                mstore(TMP_0, addmod(mload(TMP_0), tmp, _modulus))

                tmp := mulmod(mload(INPUT17), mload(add(w_hat_pointer, 576)), _modulus)
                mstore(TMP_0, addmod(mload(TMP_0), tmp, _modulus))

                tmp := mulmod(mload(INPUT18), mload(add(w_hat_pointer, 608)), _modulus)
                mstore(TMP_0, addmod(mload(TMP_0), tmp, _modulus))

                tmp := mulmod(mload(INPUT19), mload(add(w_hat_pointer, 640)), _modulus)
                mstore(TMP_0, addmod(mload(TMP_0), tmp, _modulus))

                tmp := mulmod(mload(INPUT20), mload(add(w_hat_pointer, 672)), _modulus)
                mstore(TMP_0, addmod(mload(TMP_0), tmp, _modulus))

                tmp := mulmod(mload(INPUT21), mload(add(w_hat_pointer, 704)), _modulus)
                mstore(TMP_0, addmod(mload(TMP_0), tmp, _modulus))

                tmp := mulmod(mload(INPUT22), mload(add(w_hat_pointer, 736)), _modulus)
                mstore(TMP_0, addmod(mload(TMP_0), tmp, _modulus))

                tmp := mulmod(mload(INPUT23), mload(add(w_hat_pointer, 768)), _modulus)
                mstore(TMP_0, addmod(mload(TMP_0), tmp, _modulus))

                tmp := mulmod(mload(INPUT24), mload(add(w_hat_pointer, 800)), _modulus)
                mstore(TMP_0, addmod(mload(TMP_0), tmp, _modulus))

                let val := 0

                val := mload(INPUT1)
                tmp := mload(add(v_rest_pointer, 32))
                tmp := mulmod(tmp, mload(INPUT0), _modulus)
                mstore(TMP_1, addmod(val, tmp, _modulus))

                val := mload(INPUT2)
                tmp := mload(add(v_rest_pointer, 64))
                tmp := mulmod(tmp, mload(INPUT0), _modulus)
                mstore(TMP_2, addmod(val, tmp, _modulus))

                val := mload(INPUT3)
                tmp := mload(add(v_rest_pointer, 96))
                tmp := mulmod(tmp, mload(INPUT0), _modulus)
                mstore(TMP_3, addmod(val, tmp, _modulus))

                val := mload(INPUT4)
                tmp := mload(add(v_rest_pointer, 128))
                tmp := mulmod(tmp, mload(INPUT0), _modulus)
                mstore(TMP_4, addmod(val, tmp, _modulus))

                val := mload(INPUT5)
                tmp := mload(add(v_rest_pointer, 160))
                tmp := mulmod(tmp, mload(INPUT0), _modulus)
                mstore(TMP_5, addmod(val, tmp, _modulus))

                val := mload(INPUT6)
                tmp := mload(add(v_rest_pointer, 192))
                tmp := mulmod(tmp, mload(INPUT0), _modulus)
                mstore(TMP_6, addmod(val, tmp, _modulus))

                val := mload(INPUT7)
                tmp := mload(add(v_rest_pointer, 224))
                tmp := mulmod(tmp, mload(INPUT0), _modulus)
                mstore(TMP_7, addmod(val, tmp, _modulus))

                val := mload(INPUT8)
                tmp := mload(add(v_rest_pointer, 256))
                tmp := mulmod(tmp, mload(INPUT0), _modulus)
                mstore(TMP_8, addmod(val, tmp, _modulus))

                val := mload(INPUT9)
                tmp := mload(add(v_rest_pointer, 288))
                tmp := mulmod(tmp, mload(INPUT0), _modulus)
                mstore(TMP_9, addmod(val, tmp, _modulus))

                val := mload(INPUT10)
                tmp := mload(add(v_rest_pointer, 320))
                tmp := mulmod(tmp, mload(INPUT0), _modulus)
                mstore(TMP_10, addmod(val, tmp, _modulus))

                val := mload(INPUT11)
                tmp := mload(add(v_rest_pointer, 352))
                tmp := mulmod(tmp, mload(INPUT0), _modulus)
                mstore(TMP_11, addmod(val, tmp, _modulus))

                val := mload(INPUT12)
                tmp := mload(add(v_rest_pointer, 384))
                tmp := mulmod(tmp, mload(INPUT0), _modulus)
                mstore(TMP_12, addmod(val, tmp, _modulus))

                val := mload(INPUT13)
                tmp := mload(add(v_rest_pointer, 416))
                tmp := mulmod(tmp, mload(INPUT0), _modulus)
                mstore(TMP_13, addmod(val, tmp, _modulus))

                val := mload(INPUT14)
                tmp := mload(add(v_rest_pointer, 448))
                tmp := mulmod(tmp, mload(INPUT0), _modulus)
                mstore(TMP_14, addmod(val, tmp, _modulus))

                val := mload(INPUT15)
                tmp := mload(add(v_rest_pointer, 480))
                tmp := mulmod(tmp, mload(INPUT0), _modulus)
                mstore(TMP_15, addmod(val, tmp, _modulus))

                val := mload(INPUT16)
                tmp := mload(add(v_rest_pointer, 512))
                tmp := mulmod(tmp, mload(INPUT0), _modulus)
                mstore(TMP_16, addmod(val, tmp, _modulus))

                val := mload(INPUT17)
                tmp := mload(add(v_rest_pointer, 544))
                tmp := mulmod(tmp, mload(INPUT0), _modulus)
                mstore(TMP_17, addmod(val, tmp, _modulus))

                val := mload(INPUT18)
                tmp := mload(add(v_rest_pointer, 576))
                tmp := mulmod(tmp, mload(INPUT0), _modulus)
                mstore(TMP_18, addmod(val, tmp, _modulus))

                val := mload(INPUT19)
                tmp := mload(add(v_rest_pointer, 608))
                tmp := mulmod(tmp, mload(INPUT0), _modulus)
                mstore(TMP_19, addmod(val, tmp, _modulus))

                val := mload(INPUT20)
                tmp := mload(add(v_rest_pointer, 640))
                tmp := mulmod(tmp, mload(INPUT0), _modulus)
                mstore(TMP_20, addmod(val, tmp, _modulus))

                val := mload(INPUT21)
                tmp := mload(add(v_rest_pointer, 672))
                tmp := mulmod(tmp, mload(INPUT0), _modulus)
                mstore(TMP_21, addmod(val, tmp, _modulus))

                val := mload(INPUT22)
                tmp := mload(add(v_rest_pointer, 704))
                tmp := mulmod(tmp, mload(INPUT0), _modulus)
                mstore(TMP_22, addmod(val, tmp, _modulus))

                val := mload(INPUT23)
                tmp := mload(add(v_rest_pointer, 736))
                tmp := mulmod(tmp, mload(INPUT0), _modulus)
                mstore(TMP_23, addmod(val, tmp, _modulus))

                val := mload(INPUT24)
                tmp := mload(add(v_rest_pointer, 768))
                tmp := mulmod(tmp, mload(INPUT0), _modulus)
                mstore(TMP_24, addmod(val, tmp, _modulus))

                mstore(INPUT0, mload(TMP_0))
                mstore(INPUT1, mload(TMP_1))
                mstore(INPUT2, mload(TMP_2))
                mstore(INPUT3, mload(TMP_3))
                mstore(INPUT4, mload(TMP_4))
                mstore(INPUT5, mload(TMP_5))
                mstore(INPUT6, mload(TMP_6))
                mstore(INPUT7, mload(TMP_7))
                mstore(INPUT8, mload(TMP_8))
                mstore(INPUT9, mload(TMP_9))
                mstore(INPUT10, mload(TMP_10))
                mstore(INPUT11, mload(TMP_11))
                mstore(INPUT12, mload(TMP_12))
                mstore(INPUT13, mload(TMP_13))
                mstore(INPUT14, mload(TMP_14))
                mstore(INPUT15, mload(TMP_15))
                mstore(INPUT16, mload(TMP_16))
                mstore(INPUT17, mload(TMP_17))
                mstore(INPUT18, mload(TMP_18))
                mstore(INPUT19, mload(TMP_19))
                mstore(INPUT20, mload(TMP_20))
                mstore(INPUT21, mload(TMP_21))
                mstore(INPUT22, mload(TMP_22))
                mstore(INPUT23, mload(TMP_23))
                mstore(INPUT24, mload(TMP_24))
            }

            function compute_hash(
                _input,
                _modulus,
                _round_constants,
                _c_m,
                _c_psm,
                _v_rests,
                _w_hats,
                _partial_rounds,
                _half_of_full_rounds_minus_1
            ) {
                // initial round constants addition
                {
                    mstore(INPUT0, addmod(mload(_input), mload(add(_round_constants, 32)), _modulus))
                    mstore(INPUT1, addmod(mload(add(_input, 32)), mload(add(_round_constants, 64)), _modulus))
                    mstore(INPUT2, addmod(mload(add(_input, 64)), mload(add(_round_constants, 96)), _modulus))
                    mstore(INPUT3, addmod(mload(add(_input, 96)), mload(add(_round_constants, 128)), _modulus))
                    mstore(INPUT4, addmod(mload(add(_input, 128)), mload(add(_round_constants, 160)), _modulus))
                    mstore(INPUT5, addmod(mload(add(_input, 160)), mload(add(_round_constants, 192)), _modulus))
                    mstore(INPUT6, addmod(mload(add(_input, 192)), mload(add(_round_constants, 224)), _modulus))
                    mstore(INPUT7, addmod(mload(add(_input, 224)), mload(add(_round_constants, 256)), _modulus))
                    mstore(INPUT8, addmod(mload(add(_input, 256)), mload(add(_round_constants, 288)), _modulus))
                    mstore(INPUT9, addmod(mload(add(_input, 288)), mload(add(_round_constants, 320)), _modulus))
                    mstore(INPUT10, addmod(mload(add(_input, 320)), mload(add(_round_constants, 352)), _modulus))
                    mstore(INPUT11, addmod(mload(add(_input, 352)), mload(add(_round_constants, 384)), _modulus))
                    mstore(INPUT12, addmod(mload(add(_input, 384)), mload(add(_round_constants, 416)), _modulus))
                    mstore(INPUT13, addmod(mload(add(_input, 416)), mload(add(_round_constants, 448)), _modulus))
                    mstore(INPUT14, addmod(mload(add(_input, 448)), mload(add(_round_constants, 480)), _modulus))
                    mstore(INPUT15, addmod(mload(add(_input, 480)), mload(add(_round_constants, 512)), _modulus))
                    mstore(INPUT16, addmod(mload(add(_input, 512)), mload(add(_round_constants, 544)), _modulus))
                    mstore(INPUT17, addmod(mload(add(_input, 544)), mload(add(_round_constants, 576)), _modulus))
                    mstore(INPUT18, addmod(mload(add(_input, 576)), mload(add(_round_constants, 608)), _modulus))
                    mstore(INPUT19, addmod(mload(add(_input, 608)), mload(add(_round_constants, 640)), _modulus))
                    mstore(INPUT20, addmod(mload(add(_input, 640)), mload(add(_round_constants, 672)), _modulus))
                    mstore(INPUT21, addmod(mload(add(_input, 672)), mload(add(_round_constants, 704)), _modulus))
                    mstore(INPUT22, addmod(mload(add(_input, 704)), mload(add(_round_constants, 736)), _modulus))
                    mstore(INPUT23, addmod(mload(add(_input, 736)), mload(add(_round_constants, 768)), _modulus))
                    mstore(INPUT24, addmod(mload(add(_input, 768)), mload(add(_round_constants, 800)), _modulus))
                }

                let offset_arc := 800

                // first half of full rounds
                let index := 0
                for {} lt(index, _half_of_full_rounds_minus_1) {} {
                    sbox_full(_modulus)
                    add_round_constants(_round_constants, offset_arc, _modulus)
                    offset_arc := add(offset_arc, 800)
                    mix(_c_m, _modulus)

                    index := add(index, 1)
                }

                sbox_full(_modulus)
                add_round_constants(_round_constants, offset_arc, _modulus)
                offset_arc := add(offset_arc, 800)
                mix(_c_psm, _modulus)

                // partial rounds
                let offset_mix := 0
                index := 0
                for {} lt(index, _partial_rounds) {} {
                    mstore(INPUT0, sbox(mload(INPUT0), _modulus))
                    mstore(INPUT0, addmod(mload(INPUT0), mload(add(_round_constants, add(offset_arc, 32))), _modulus))
                    offset_arc := add(offset_arc, 32)

                    mix_sparse(_v_rests, _w_hats, offset_mix, _modulus)
                    offset_mix := add(offset_mix, 32)

                    index := add(index, 1)
                }

                // last half of full rounds
                index := 0
                for {} lt(index, _half_of_full_rounds_minus_1) {} {
                    sbox_full(_modulus)
                    add_round_constants(_round_constants, offset_arc, _modulus)
                    offset_arc := add(offset_arc, 800)
                    mix(_c_m, _modulus)

                    index := add(index, 1)
                }

                // final round
                sbox_full(_modulus)
                mix(_c_m, _modulus)
            }

            {
                compute_hash(
                    input,
                    mload(MODULUS),
                    mload(ROUND_CONSTANTS),
                    mload(C_M),
                    mload(C_PSM),
                    mload(V_RESTS),
                    mload(W_HATS),
                    mload(PARTIAL_ROUNDS),
                    mload(HALF_OF_FULL_ROUNDS_MINUS_1)
                )
            }

            let hash := and(mload(INPUT1), 0x03ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff)
            if eq(hash, mload(EXPECTED_HASH)) { result := 0x01 }
        }
    }
}
