// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.16;

import "src/blocks/pasta/Vesta.sol";
import "src/blocks/pasta/Pallas.sol";
import "src/blocks/grumpkin/Bn256.sol";
import "src/blocks/grumpkin/Grumpkin.sol";
import "src/blocks/IpaPcs.sol";
import "src/Utilities.sol";

/**
 * @title Scalar From Uniform Library
 * @dev This library provides functions to convert uniform random bytes into a scalar in various cryptographic groups.
 */
library ScalarFromUniformLib {
    uint256 private constant SCALAR_UNIFORM_BYTE_SIZE = 64;

    uint64 private constant VESTA_INV = 0x8c46eb20ffffffff;
    uint64 private constant VESTA_MODULUS_0 = 0x8c46eb2100000001;
    uint64 private constant VESTA_MODULUS_1 = 0x224698fc0994a8dd;
    uint64 private constant VESTA_MODULUS_2 = 0x0000000000000000;
    uint64 private constant VESTA_MODULUS_3 = 0x4000000000000000;
    uint256 private constant VESTA_R2 = 0x3fffffffffffffffffffffffffffffff992c350be34205675b2b3e9cfffffffd;
    uint256 private constant VESTA_R3 = 0x096d41af7ccfdaa97fae231004ccf59067bb433d891a16e3fc9678ff0000000f;

    uint64 private constant PALLAS_INV = 0x992d30ecffffffff;
    uint64 private constant PALLAS_MODULUS_0 = 0x992d30ed00000001;
    uint64 private constant PALLAS_MODULUS_1 = 0x224698fc094cf91b;
    uint64 private constant PALLAS_MODULUS_2 = 0x0000000000000000;
    uint64 private constant PALLAS_MODULUS_3 = 0x4000000000000000;

    uint256 public constant PALLAS_R2 = 0x3fffffffffffffffffffffffffffffff992c350be41914ad34786d38fffffffd;
    uint256 public constant PALLAS_R3 = 0x096d41af7b9cb7147797a99bc3c95d18d7d30dbd8b0de0e78c78ecb30000000f;

    uint64 private constant BN256_INV = 0xc2e1f593efffffff;
    uint64 private constant BN256_MODULUS_0 = 0x43e1f593f0000001;
    uint64 private constant BN256_MODULUS_1 = 0x2833e84879b97091;
    uint64 private constant BN256_MODULUS_2 = 0xb85045b68181585d;
    uint64 private constant BN256_MODULUS_3 = 0x30644e72e131a029;
    uint256 public constant BN256_R2 = 0x0e0a77c19a07df2f666ea36f7879462e36fc76959f60cd29ac96341c4ffffffb;
    uint256 public constant BN256_R3 = 0x0216d0b17f4e44a58c49833d53bb808553fe3ab1e35c59e31bb8e645ae216da7;

    uint64 private constant GRUMPKIN_INV = 0x87d20782e4866389;
    uint64 private constant GRUMPKIN_MODULUS_0 = 0x3c208c16d87cfd47;
    uint64 private constant GRUMPKIN_MODULUS_1 = 0x97816a916871ca8d;
    uint64 private constant GRUMPKIN_MODULUS_2 = 0xb85045b68181585d;
    uint64 private constant GRUMPKIN_MODULUS_3 = 0x30644e72e131a029;
    uint256 public constant GRUMPKIN_R2 = 0x0e0a77c19a07df2f666ea36f7879462c0a78eb28f5c70b3dd35d438dc58f0d9d;
    uint256 public constant GRUMPKIN_R3 = 0x06d89f71cab8351f47ab1eff0a417ff6b5e71911d44501fbf32cfc5b538afa89;

    enum Curve {
        PALLAS,
        VESTA,
        BN256,
        GRUMPKIN
    }

    /**
     * @notice Returns the enum value representing the Pallas curve.
     * @dev This function is used to select the Pallas curve for operations requiring a specific curve context.
     * @return Curve Enum value corresponding to the Pallas curve.
     */
    function curvePallas() public pure returns (Curve) {
        return Curve.PALLAS;
    }

    /**
     * @notice Returns the enum value representing the Vesta curve.
     * @dev This function is used to select the Vesta curve for operations requiring a specific curve context.
     * @return Curve Enum value corresponding to the Vesta curve.
     */
    function curveVesta() public pure returns (Curve) {
        return Curve.VESTA;
    }

    /**
     * @notice Returns the enum value representing the BN256 curve.
     * @dev This function is used to select the BN256 curve for operations requiring a specific curve context.
     * @return Curve Enum value corresponding to the BN256 curve.
     */
    function curveBn256() public pure returns (Curve) {
        return Curve.BN256;
    }

    /**
     * @notice Returns the enum value representing the Grumpkin curve.
     * @dev This function is used to select the Grumpkin curve for operations requiring a specific curve context.
     * @return Curve Enum value corresponding to the Grumpkin curve.
     */
    function curveGrumpkin() public pure returns (Curve) {
        return Curve.GRUMPKIN;
    }

    /**
     * @notice Converts uniform bytes into a scalar value within the field of a specified curve.
     * @dev This function takes a sequence of bytes and maps it into the scalar field of the given curve,
     *      ensuring the uniformity and cryptographic security of the scalar value for cryptographic operations. Comes
     *      frpm 'from_uniform_bytes' in Rust.
     * @param scalarUniform An array of uniform bytes.
     * @param curve The cryptographic curve (Pallas, Vesta, BN256, Grumpkin) for which to generate the scalar.
     * @return A scalar value within the field of the specified curve.
     */
    function scalarFromUniform(uint8[] memory scalarUniform, Curve curve) public pure returns (uint256) {
        uint256 modulus;
        uint256 R2;
        uint256 R3;
        uint256 d0;
        uint256 d1;
        if (curve == Curve.PALLAS) {
            modulus = Pallas.P_MOD;
            R2 = PALLAS_R2;
            R3 = PALLAS_R3;
            d0 = montgomeryReducePallas(
                getLimb(scalarUniform, 0, 8),
                getLimb(scalarUniform, 8, 16),
                getLimb(scalarUniform, 16, 24),
                getLimb(scalarUniform, 24, 32),
                0,
                0,
                0,
                0
            );
            d1 = montgomeryReducePallas(
                getLimb(scalarUniform, 32, 40),
                getLimb(scalarUniform, 40, 48),
                getLimb(scalarUniform, 48, 56),
                getLimb(scalarUniform, 56, 64),
                0,
                0,
                0,
                0
            );
        } else if (curve == Curve.VESTA) {
            modulus = Vesta.P_MOD;
            R2 = VESTA_R2;
            R3 = VESTA_R3;
            d0 = montgomeryReduceVesta(
                getLimb(scalarUniform, 0, 8),
                getLimb(scalarUniform, 8, 16),
                getLimb(scalarUniform, 16, 24),
                getLimb(scalarUniform, 24, 32),
                0,
                0,
                0,
                0
            );
            d1 = montgomeryReduceVesta(
                getLimb(scalarUniform, 32, 40),
                getLimb(scalarUniform, 40, 48),
                getLimb(scalarUniform, 48, 56),
                getLimb(scalarUniform, 56, 64),
                0,
                0,
                0,
                0
            );
        } else if (curve == Curve.BN256) {
            modulus = Bn256.R_MOD;
            R2 = BN256_R2;
            R3 = BN256_R3;
            d0 = montgomeryReduceBn256(
                getLimb(scalarUniform, 0, 8),
                getLimb(scalarUniform, 8, 16),
                getLimb(scalarUniform, 16, 24),
                getLimb(scalarUniform, 24, 32),
                0,
                0,
                0,
                0
            );
            d1 = montgomeryReduceBn256(
                getLimb(scalarUniform, 32, 40),
                getLimb(scalarUniform, 40, 48),
                getLimb(scalarUniform, 48, 56),
                getLimb(scalarUniform, 56, 64),
                0,
                0,
                0,
                0
            );
        } else if (curve == Curve.GRUMPKIN) {
            modulus = Grumpkin.P_MOD;
            R2 = GRUMPKIN_R2;
            R3 = GRUMPKIN_R3;
            d0 = montgomeryReduceGrumpkin(
                getLimb(scalarUniform, 0, 8),
                getLimb(scalarUniform, 8, 16),
                getLimb(scalarUniform, 16, 24),
                getLimb(scalarUniform, 24, 32),
                0,
                0,
                0,
                0
            );
            d1 = montgomeryReduceGrumpkin(
                getLimb(scalarUniform, 32, 40),
                getLimb(scalarUniform, 40, 48),
                getLimb(scalarUniform, 48, 56),
                getLimb(scalarUniform, 56, 64),
                0,
                0,
                0,
                0
            );
        } else {
            require(false, "[scalarFromUniform] Unexpected curve");
        }

        uint256 scalar;
        assembly {
            let d0R2 := mulmod(d0, R2, modulus)
            let d1R3 := mulmod(d1, R3, modulus)
            scalar := addmod(d0R2, d1R3, modulus)
        }

        return scalar;
    }

    /**
     * @notice Extracts a 64-bit limb from a byte array starting from a specific index.
     * @dev This function is used to parse a 64-bit integer from a subset of a byte array.
     * @param scalarUniform The byte array from which the limb is extracted.
     * @param startIndex The starting index from which to begin extraction.
     * @param endIndex The ending index (exclusive) where extraction stops.
     * @return A 64-bit integer (limb) extracted from the specified range of the byte array.
     */
    function getLimb(uint8[] memory scalarUniform, uint256 startIndex, uint256 endIndex)
        private
        pure
        returns (uint64)
    {
        require(scalarUniform.length == SCALAR_UNIFORM_BYTE_SIZE, "[getLimb] state.len == SCALAR_UNIFORM_BYTE_SIZE");
        require(startIndex < endIndex, "[getLimb] startIndex < endIndex");
        require(startIndex < SCALAR_UNIFORM_BYTE_SIZE, "[getLimb] startIndex < SCALAR_UNIFORM_BYTE_SIZE");
        require(endIndex <= SCALAR_UNIFORM_BYTE_SIZE, "[getLimb] endIndex < SCALAR_UNIFORM_BYTE_SIZE");

        uint64 limb = 0;
        uint64 shiftIndex = 0;
        for (uint256 i = startIndex; i < endIndex; i++) {
            limb ^= uint64(scalarUniform[i]) << shiftIndex;
            shiftIndex += 8;
        }
        return limb;
    }

    /**
     * @notice Performs Montgomery reduction on a multi-limb integer to obtain a single limb integer in Pallas curve modulus.
     * @dev This function applies the Montgomery reduction algorithm to convert a large integer (represented as multiple
     *      64-bit limbs) into a reduced form modulo the Pallas curve's prime modulus.
     * @param r0-r7 The 64-bit limbs representing the large integer to be reduced.
     * @return The Montgomery reduced result as a single integer modulo the Pallas curve's prime modulus.
     */
    function montgomeryReducePallas(
        uint64 r0,
        uint64 r1,
        uint64 r2,
        uint64 r3,
        uint64 r4,
        uint64 r5,
        uint64 r6,
        uint64 r7
    ) private pure returns (uint256) {
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

            let k := mulmod(r0, PALLAS_INV, 0x10000000000000000) // wrapping_mul over u64 (Rust)
            let carry := 0
            let carry2 := 0

            carry2, carry := mac(r0, k, PALLAS_MODULUS_0, 0) // carry2 is used as a stub
            r1, carry := mac(r1, k, PALLAS_MODULUS_1, carry)
            r2, carry := mac(r2, k, PALLAS_MODULUS_2, carry)
            r3, carry := mac(r3, k, PALLAS_MODULUS_3, carry)
            r4, carry2 := adc(r4, 0, carry)

            k := mulmod(r1, PALLAS_INV, 0x10000000000000000) // wrapping_mul over u64 (Rust)
            r0, carry := mac(r1, k, PALLAS_MODULUS_0, 0) // r0 used as a stub
            r2, carry := mac(r2, k, PALLAS_MODULUS_1, carry)
            r3, carry := mac(r3, k, PALLAS_MODULUS_2, carry)
            r4, carry := mac(r4, k, PALLAS_MODULUS_3, carry)
            r5, carry2 := adc(r5, carry2, carry)

            k := mulmod(r2, PALLAS_INV, 0x10000000000000000) // wrapping_mul over u64 (Rust)
            r0, carry := mac(r2, k, PALLAS_MODULUS_0, 0) // r0 used as a stub
            r3, carry := mac(r3, k, PALLAS_MODULUS_1, carry)
            r4, carry := mac(r4, k, PALLAS_MODULUS_2, carry)
            r5, carry := mac(r5, k, PALLAS_MODULUS_3, carry)
            r6, carry2 := adc(r6, carry2, carry)

            k := mulmod(r3, PALLAS_INV, 0x10000000000000000) // wrapping_mul over u64 (Rust)
            r0, carry := mac(r3, k, PALLAS_MODULUS_0, 0) // r0 used as a stub
            r4, carry := mac(r4, k, PALLAS_MODULUS_1, carry)
            r5, carry := mac(r5, k, PALLAS_MODULUS_2, carry)
            r6, carry := mac(r6, k, PALLAS_MODULUS_3, carry)
            r7, r0 := adc(r7, carry2, carry) // r0 used as a stub

            function sbb(a, b, borrow) -> ret1, ret2 {
                let shift := shr(63, borrow)
                let b_add_borrow_shifted := addmod(b, shift, 0xffffffffffffffffffffffffffffffff)
                let a_minus := sub(a, b_add_borrow_shifted)
                a_minus := and(a_minus, 0xffffffffffffffffffffffffffffffff)

                ret1 := and(a_minus, 0xffffffffffffffff)
                ret2 := shr(64, a_minus)
            }

            // Result may be within MODULUS of the correct value

            // use carry as borrow; r0 as d0, r1 as d1, r2 as d2, r3 as d3
            carry2 := 0
            r0, carry2 := sbb(r4, PALLAS_MODULUS_0, carry2)
            r1, carry2 := sbb(r5, PALLAS_MODULUS_1, carry2)
            r2, carry2 := sbb(r6, PALLAS_MODULUS_2, carry2)
            r3, carry2 := sbb(r7, PALLAS_MODULUS_3, carry2)

            // If underflow occurred on the final limb, borrow = 0xfff...fff, otherwise
            // borrow = 0x000...000. Thus, we use it as a mask to conditionally add the modulus.
            carry := 0
            r0, carry := adc(r0, and(PALLAS_MODULUS_0, carry2), carry)
            r1, carry := adc(r1, and(PALLAS_MODULUS_1, carry2), carry)
            r2, carry := adc(r2, and(PALLAS_MODULUS_2, carry2), carry)
            r3, carry := adc(r3, and(PALLAS_MODULUS_3, carry2), carry)
        }

        return (uint256(r3) << 192) ^ (uint256(r2) << 128) ^ (uint256(r1) << 64) ^ uint256(r0);
    }

    /**
     * @notice Performs Montgomery reduction on a multi-limb integer to obtain a single limb integer in Vesta curve modulus.
     * @dev Similar to montgomeryReducePallas, but specific to the Vesta curve's prime modulus.
     * @param r0-r7 The 64-bit limbs representing the large integer to be reduced.
     * @return The Montgomery reduced result as a single integer modulo the Vesta curve's prime modulus.
     */
    function montgomeryReduceVesta(
        uint64 r0,
        uint64 r1,
        uint64 r2,
        uint64 r3,
        uint64 r4,
        uint64 r5,
        uint64 r6,
        uint64 r7
    ) private pure returns (uint256) {
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

            let k := mulmod(r0, VESTA_INV, 0x10000000000000000) // wrapping_mul over u64 (Rust)
            let carry := 0
            let carry2 := 0

            carry2, carry := mac(r0, k, VESTA_MODULUS_0, 0) // carry2 is used as a stub
            r1, carry := mac(r1, k, VESTA_MODULUS_1, carry)
            r2, carry := mac(r2, k, VESTA_MODULUS_2, carry)
            r3, carry := mac(r3, k, VESTA_MODULUS_3, carry)
            r4, carry2 := adc(r4, 0, carry)

            k := mulmod(r1, VESTA_INV, 0x10000000000000000) // wrapping_mul over u64 (Rust)
            r0, carry := mac(r1, k, VESTA_MODULUS_0, 0) // r0 used as a stub
            r2, carry := mac(r2, k, VESTA_MODULUS_1, carry)
            r3, carry := mac(r3, k, VESTA_MODULUS_2, carry)
            r4, carry := mac(r4, k, VESTA_MODULUS_3, carry)
            r5, carry2 := adc(r5, carry2, carry)

            k := mulmod(r2, VESTA_INV, 0x10000000000000000) // wrapping_mul over u64 (Rust)
            r0, carry := mac(r2, k, VESTA_MODULUS_0, 0) // r0 used as a stub
            r3, carry := mac(r3, k, VESTA_MODULUS_1, carry)
            r4, carry := mac(r4, k, VESTA_MODULUS_2, carry)
            r5, carry := mac(r5, k, VESTA_MODULUS_3, carry)
            r6, carry2 := adc(r6, carry2, carry)

            k := mulmod(r3, VESTA_INV, 0x10000000000000000) // wrapping_mul over u64 (Rust)
            r0, carry := mac(r3, k, VESTA_MODULUS_0, 0) // r0 used as a stub
            r4, carry := mac(r4, k, VESTA_MODULUS_1, carry)
            r5, carry := mac(r5, k, VESTA_MODULUS_2, carry)
            r6, carry := mac(r6, k, VESTA_MODULUS_3, carry)
            r7, r0 := adc(r7, carry2, carry) // r0 used as a stub

            function sbb(a, b, borrow) -> ret1, ret2 {
                let shift := shr(63, borrow)
                let b_add_borrow_shifted := addmod(b, shift, 0xffffffffffffffffffffffffffffffff)
                let a_minus := sub(a, b_add_borrow_shifted)
                a_minus := and(a_minus, 0xffffffffffffffffffffffffffffffff)

                ret1 := and(a_minus, 0xffffffffffffffff)
                ret2 := shr(64, a_minus)
            }

            // Result may be within MODULUS of the correct value

            // use carry as borrow; r0 as d0, r1 as d1, r2 as d2, r3 as d3
            carry2 := 0
            r0, carry2 := sbb(r4, VESTA_MODULUS_0, carry2)
            r1, carry2 := sbb(r5, VESTA_MODULUS_1, carry2)
            r2, carry2 := sbb(r6, VESTA_MODULUS_2, carry2)
            r3, carry2 := sbb(r7, VESTA_MODULUS_3, carry2)

            // If underflow occurred on the final limb, borrow = 0xfff...fff, otherwise
            // borrow = 0x000...000. Thus, we use it as a mask to conditionally add the modulus.
            carry := 0
            r0, carry := adc(r0, and(VESTA_MODULUS_0, carry2), carry)
            r1, carry := adc(r1, and(VESTA_MODULUS_1, carry2), carry)
            r2, carry := adc(r2, and(VESTA_MODULUS_2, carry2), carry)
            r3, carry := adc(r3, and(VESTA_MODULUS_3, carry2), carry)
        }

        return (uint256(r3) << 192) ^ (uint256(r2) << 128) ^ (uint256(r1) << 64) ^ uint256(r0);
    }

    /**
     * @notice Performs Montgomery reduction on a multi-limb integer to obtain a single limb integer in BN256 curve modulus.
     * @dev Similar to montgomeryReducePallas and montgomeryReduceVesta, but specific to the BN256 curve's prime modulus.
     * @param r0-r7 The 64-bit limbs representing the large integer to be reduced.
     * @return The Montgomery reduced result as a single integer modulo the BN256 curve's prime modulus.
     */
    function montgomeryReduceBn256(
        uint64 r0,
        uint64 r1,
        uint64 r2,
        uint64 r3,
        uint64 r4,
        uint64 r5,
        uint64 r6,
        uint64 r7
    ) public pure returns (uint256) {
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

            function sbb(a, b, borrow) -> ret1, ret2 {
                let shift := shr(63, borrow)
                let b_add_borrow_shifted := addmod(b, shift, 0xffffffffffffffffffffffffffffffff)
                let a_minus := sub(a, b_add_borrow_shifted)
                a_minus := and(a_minus, 0xffffffffffffffffffffffffffffffff)

                ret1 := and(a_minus, 0xffffffffffffffff)
                ret2 := shr(64, a_minus)
            }

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
        }

        return (uint256(r3) << 192) ^ (uint256(r2) << 128) ^ (uint256(r1) << 64) ^ uint256(r0);
    }

    /**
     * @notice Performs Montgomery reduction on a multi-limb integer to obtain a single limb integer in Grumpkin curve
     *         modulus.
     * @dev Similar to the other montgomeryReduce functions, but specific to the Grumpkin curve's prime modulus.
     * @param r0-r7 The 64-bit limbs representing the large integer to be reduced.
     * @return The Montgomery reduced result as a single integer modulo the Grumpkin curve's prime modulus.
     */
    function montgomeryReduceGrumpkin(
        uint64 r0,
        uint64 r1,
        uint64 r2,
        uint64 r3,
        uint64 r4,
        uint64 r5,
        uint64 r6,
        uint64 r7
    ) public pure returns (uint256) {
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

            function sbb(a, b, borrow) -> ret1, ret2 {
                let shift := shr(63, borrow)
                let b_add_borrow_shifted := addmod(b, shift, 0xffffffffffffffffffffffffffffffff)
                let a_minus := sub(a, b_add_borrow_shifted)
                a_minus := and(a_minus, 0xffffffffffffffffffffffffffffffff)

                ret1 := and(a_minus, 0xffffffffffffffff)
                ret2 := shr(64, a_minus)
            }

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
        }

        return (uint256(r3) << 192) ^ (uint256(r2) << 128) ^ (uint256(r1) << 64) ^ uint256(r0);
    }
}

/**
 * @title Keccak Transcript Library
 * @notice Provides functions for managing Keccak transcripts in cryptographic protocols.
 * @dev This library handles the generation and manipulation of cryptographic transcripts using Keccak hash function.
 */
library KeccakTranscriptLib {
    uint32 private constant PERSONA_TAG = 0x4e6f5452;
    uint32 private constant DOM_SEP_TAG = 0x4e6f4453;
    uint8 private constant KECCAK256_PREFIX_CHALLENGE_LO = 0x00;
    uint8 private constant KECCAK256_PREFIX_CHALLENGE_HI = 0x01;
    uint256 public constant KECCAK_TRANSCRIPT_STATE_BYTE_LEN = 64;

    struct KeccakTranscript {
        uint16 round;
        uint8[] state;
        uint8[] transcript;
    }

    /**
     * @notice Instantiates a new Keccak transcript.
     * @dev Initializes a new transcript with a given label, which influences the initial state.
     * @param label An array of bytes used as the label for transcript instantiation.
     * @return A new instance of KeccakTranscript.
     */
    function instantiate(uint8[] memory label) public pure returns (KeccakTranscript memory) {
        uint8[] memory input = new uint8[](label.length + 4);

        uint256 index = 0;
        // copy PERSONA_TAG
        input[index] = uint8((PERSONA_TAG >> 24) & 0xFF);
        input[index + 1] = uint8((PERSONA_TAG >> 16) & 0xFF);
        input[index + 2] = uint8((PERSONA_TAG >> 8) & 0xFF);
        input[index + 3] = uint8(PERSONA_TAG & 0xFF);
        index += 4;

        // copy label
        for (uint256 i = 0; i < label.length; i++) {
            input[index + i] = label[i];
        }

        uint8[] memory transcript = new uint8[](0);
        KeccakTranscript memory keccak = KeccakTranscript(0, computeUpdatedState(input), transcript);
        return keccak;
    }
    /**
     * @notice Computes an updated state for the Keccak transcript.
     * @dev Internally used to update the state of the transcript based on the input and current state.
     * @param input The array of bytes to be processed for updating the state.
     * @return updatedState The new state after processing the input.
     */

    function computeUpdatedState(uint8[] memory input) private pure returns (uint8[] memory updatedState) {
        uint8[] memory inputLo = new uint8[](input.length + 1);
        uint8[] memory inputHi = new uint8[](input.length + 1);

        uint256 index = 0;

        // copy input
        for (uint256 i = 0; i < input.length; i++) {
            inputLo[i] = input[i];
            inputHi[i] = input[i];
        }
        index += input.length;

        // add challanges
        inputLo[index] = KECCAK256_PREFIX_CHALLENGE_LO;
        inputHi[index] = KECCAK256_PREFIX_CHALLENGE_HI;

        // prepare bytes input for Keccak
        bytes memory keccakInputLo = new bytes(inputLo.length);
        bytes memory keccakInputHi = new bytes(inputLo.length);
        for (uint256 i = 0; i < inputLo.length; i++) {
            keccakInputLo[i] = bytes1(inputLo[i]);
            keccakInputHi[i] = bytes1(inputHi[i]);
        }

        // perform Keccak hashing
        bytes32 lo = keccak256(keccakInputLo);
        bytes32 hi = keccak256(keccakInputHi);

        // set updatedState variable
        updatedState = new uint8[](KECCAK_TRANSCRIPT_STATE_BYTE_LEN);
        for (uint256 i = 0; i < KECCAK_TRANSCRIPT_STATE_BYTE_LEN / 2; i++) {
            updatedState[i] = uint8(bytes1(lo[i]));
            updatedState[i + KECCAK_TRANSCRIPT_STATE_BYTE_LEN / 2] = uint8(bytes1(hi[i]));
        }

        return updatedState;
    }
    /**
     * @notice Domain separator for the Keccak transcript.
     * @dev Appends a domain separator to the transcript. Useful for separating different parts or stages of a protocol.
     * @param keccak The current state of the Keccak transcript.
     * @param dom_sep_input Input for the domain separator.
     * @return The updated Keccak transcript with the domain separator applied.
     */

    function dom_sep(KeccakTranscript memory keccak, uint8[] memory dom_sep_input)
        public
        pure
        returns (KeccakTranscript memory)
    {
        uint8[] memory transcript = new uint8[](keccak.transcript.length + 4 + dom_sep_input.length);
        uint256 index = 0;
        // copy current transcript
        for (uint256 i = 0; i < keccak.transcript.length; i++) {
            transcript[i] = keccak.transcript[i];
        }
        index += keccak.transcript.length;

        // append DOM_SEP_TAG
        transcript[index] = uint8((DOM_SEP_TAG >> 24) & 0xFF);
        transcript[index + 1] = uint8((DOM_SEP_TAG >> 16) & 0xFF);
        transcript[index + 2] = uint8((DOM_SEP_TAG >> 8) & 0xFF);
        transcript[index + 3] = uint8(DOM_SEP_TAG & 0xFF);
        index += 4;

        // append dom_sep_input
        for (uint256 i = 0; i < dom_sep_input.length; i++) {
            transcript[index + i] = dom_sep_input[i];
        }

        return KeccakTranscript(keccak.round, keccak.state, transcript);
    }
    /**
     * @notice Absorbs additional data into the Keccak transcript.
     * @dev Integrates new data into the transcript, updating its state. Used for adding various protocol-specific values.
     * @param keccak The current state of the Keccak transcript.
     * @param label A label to categorize or identify the data being absorbed.
     * @param input The data to be absorbed into the transcript.
     * @return The updated Keccak transcript with the new data absorbed.
     */

    function absorb(KeccakTranscript memory keccak, uint8[] memory label, uint8[] memory input)
        public
        pure
        returns (KeccakTranscript memory)
    {
        uint8[] memory transcript = new uint8[](keccak.transcript.length + label.length + input.length);
        uint256 index = 0;
        // TODO think how to make it more efficient (without copying current transcript)
        // copy current transcript
        for (uint256 i = 0; i < keccak.transcript.length; i++) {
            transcript[i] = keccak.transcript[i];
        }
        index += keccak.transcript.length;

        // append label
        for (uint256 i = 0; i < label.length; i++) {
            transcript[index + i] = label[i];
        }
        index += label.length;

        // append input
        for (uint256 i = 0; i < input.length; i++) {
            transcript[index + i] = input[i];
        }

        // TODO This should be workarounded by interacting with the blockchain, that holds the state
        return KeccakTranscript(keccak.round, keccak.state, transcript);
    }

    /**
     * @notice Converts a uint256 scalar value into a bytes array.
     * @dev The function splits a 256-bit number into 32 bytes.
     * @param input The uint256 scalar value to be converted.
     * @return The resulting 32-byte array.
     */
    function scalarToBytes(uint256 input) private pure returns (uint8[] memory) {
        uint8[] memory input_bytes = new uint8[](32);

        for (uint256 i = 0; i < 32; i++) {
            input_bytes[i] = uint8(bytes1(bytes32(input)[31 - i]));
        }

        return input_bytes;
    }

    /**
     * @notice Absorbs a uint256 scalar value into the Keccak transcript.
     * @dev Converts the scalar to bytes and then uses the standard `absorb` function.
     * @param keccak The existing Keccak transcript.
     * @param label A byte array label used in the absorption process.
     * @param input The uint256 scalar value to be absorbed.
     * @return The updated Keccak transcript after absorption.
     */
    function absorb(KeccakTranscript memory keccak, uint8[] memory label, uint256 input)
        public
        pure
        returns (KeccakTranscript memory)
    {
        uint8[] memory input_bytes = scalarToBytes(input);
        return absorb(keccak, label, input_bytes);
    }
    /**
     * @notice Absorbs a Pallas affine point into the Keccak transcript.
     * @dev Handles the affine point by converting its coordinates to bytes and handling the infinity case.
     * @param keccak The existing Keccak transcript.
     * @param label A byte array label used in the absorption process.
     * @param point The Pallas affine point to be absorbed.
     * @return The updated Keccak transcript after absorption.
     */

    function absorb(KeccakTranscript memory keccak, uint8[] memory label, Pallas.PallasAffinePoint memory point)
        public
        pure
        returns (KeccakTranscript memory)
    {
        uint8 is_infinity;
        if (Pallas.isInfinity(point)) {
            is_infinity = 0;
        } else {
            is_infinity = 1;
        }

        uint8[] memory x_bytes = scalarToBytes(point.x);
        uint8[] memory y_bytes = scalarToBytes(point.y);

        uint8[] memory input = new uint8[](x_bytes.length + y_bytes.length + 1);

        for (uint256 i = 0; i < x_bytes.length; i++) {
            input[i] = x_bytes[i];
        }
        for (uint256 i = 0; i < y_bytes.length; i++) {
            input[x_bytes.length + i] = y_bytes[i];
        }
        input[x_bytes.length + y_bytes.length] = is_infinity;

        return absorb(keccak, label, input);
    }

    /**
     * @notice Absorbs an array of Pallas affine points into the Keccak transcript.
     * @dev Processes each point and then absorbs the entire array.
     * @param keccak The existing Keccak transcript.
     * @param label A byte array label used in the absorption process.
     * @param points The array of Pallas affine points to be absorbed.
     * @return The updated Keccak transcript after absorption.
     */
    function absorb(KeccakTranscript memory keccak, uint8[] memory label, Pallas.PallasAffinePoint[] memory points)
        public
        pure
        returns (KeccakTranscript memory)
    {
        uint8[] memory output = new uint8[]((32 * 2 + 1) * points.length);
        uint256 index = 0;
        for (uint256 j = 0; j < points.length; j++) {
            // write x coordinate
            for (uint256 i = 0; i < 32; i++) {
                output[index] = uint8(bytes1(bytes32(points[j].x)[31 - i]));
                index++;
            }
            // write y coordinate
            for (uint256 i = 0; i < 32; i++) {
                output[index] = uint8(bytes1(bytes32(points[j].y)[31 - i]));
                index++;
            }

            // write byte indicating whether point is at infinity
            if (Pallas.isInfinity(points[j])) {
                output[index] = 0x00;
            } else {
                output[index] = 0x01;
            }
            index++;
        }

        return absorb(keccak, label, output);
    }

    /**
     * @notice Absorbs a Vesta affine point into the Keccak transcript, similar to the Pallas point absorption.
     * @param keccak The existing Keccak transcript.
     * @param label A byte array label used in the absorption process.
     * @param point The Vesta affine point to be absorbed.
     * @return The updated Keccak transcript after absorption.
     */
    function absorb(KeccakTranscript memory keccak, uint8[] memory label, Vesta.VestaAffinePoint memory point)
        public
        pure
        returns (KeccakTranscript memory)
    {
        uint8 is_infinity;
        if (Vesta.isInfinity(point)) {
            is_infinity = 0;
        } else {
            is_infinity = 1;
        }

        uint8[] memory x_bytes = scalarToBytes(point.x);
        uint8[] memory y_bytes = scalarToBytes(point.y);

        uint8[] memory input = new uint8[](x_bytes.length + y_bytes.length + 1);

        for (uint256 i = 0; i < x_bytes.length; i++) {
            input[i] = x_bytes[i];
        }
        for (uint256 i = 0; i < y_bytes.length; i++) {
            input[x_bytes.length + i] = y_bytes[i];
        }
        input[x_bytes.length + y_bytes.length] = is_infinity;

        return absorb(keccak, label, input);
    }

    /**
     * @notice Absorbs an array of Vesta affine points into the Keccak transcript, similar to the Pallas array absorption.
     * @param keccak The existing Keccak transcript.
     * @param label A byte array label used in the absorption process.
     * @param points The array of Vesta affine points to be absorbed.
     * @return The updated Keccak transcript after absorption.
     */
    function absorb(KeccakTranscript memory keccak, uint8[] memory label, Vesta.VestaAffinePoint[] memory points)
        public
        pure
        returns (KeccakTranscript memory)
    {
        uint8[] memory output = new uint8[]((32 * 2 + 1) * points.length);
        uint256 index = 0;
        for (uint256 j = 0; j < points.length; j++) {
            // write x coordinate
            for (uint256 i = 0; i < 32; i++) {
                output[index] = uint8(bytes1(bytes32(points[j].x)[31 - i]));
                index++;
            }
            // write y coordinate
            for (uint256 i = 0; i < 32; i++) {
                output[index] = uint8(bytes1(bytes32(points[j].y)[31 - i]));
                index++;
            }

            // write byte indicating whether point is at infinity
            if (Vesta.isInfinity(points[j])) {
                output[index] = 0x00;
            } else {
                output[index] = 0x01;
            }
            index++;
        }

        return absorb(keccak, label, output);
    }

    /**
     * @notice Absorbs an array of uint256 scalars into the Keccak transcript.
     * @dev Converts each scalar to bytes and absorbs them collectively.
     * @param keccak The existing Keccak transcript.
     * @param label A byte array label used in the absorption process.
     * @param inputs The array of uint256 scalars to be absorbed.
     * @return The updated Keccak transcript after absorption.
     */
    function absorb(KeccakTranscript memory keccak, uint8[] memory label, uint256[] memory inputs)
        public
        pure
        returns (KeccakTranscript memory)
    {
        uint8[] memory input = new uint8[](32 * inputs.length);

        for (uint256 i = 0; i < inputs.length; i++) {
            uint8[] memory input_bytes = scalarToBytes(inputs[i]);

            for (uint256 j = 0; j < 32; j++) {
                input[32 * i + j] = input_bytes[j];
            }
        }

        return absorb(keccak, label, input);
    }

    function absorb(
        KeccakTranscript memory keccak,
        uint8[] memory label,
        uint256[] memory inputs_0,
        uint256[] memory inputs_1,
        uint256[] memory inputs_2
    ) public returns (KeccakTranscript memory) {
        uint8[] memory input = new uint8[](32 * inputs_0.length + 32 * inputs_1.length + 32 * inputs_2.length);

        uint256 input_index = 0;
        for (uint256 i = 0; i < inputs_0.length; i++) {
            uint8[] memory input_bytes = scalarToBytes(inputs_0[i]);

            for (uint256 j = 0; j < 32; j++) {
                input[input_index] = input_bytes[j];
                input_index++;
            }
        }

        for (uint256 i = 0; i < inputs_1.length; i++) {
            uint8[] memory input_bytes = scalarToBytes(inputs_1[i]);

            for (uint256 j = 0; j < 32; j++) {
                input[input_index] = input_bytes[j];
                input_index++;
            }
        }

        for (uint256 i = 0; i < inputs_2.length; i++) {
            uint8[] memory input_bytes = scalarToBytes(inputs_2[i]);

            for (uint256 j = 0; j < 32; j++) {
                input[input_index] = input_bytes[j];
                input_index++;
            }
        }

        return absorb(keccak, label, input);
    }

    /**
     * @notice Absorbs a univariate polynomial into the Keccak transcript.
     * @dev Converts the polynomial to bytes and uses the standard `absorb` function.
     * @param keccak The existing Keccak transcript.
     * @param label A byte array label used in the absorption process.
     * @param poly The univariate polynomial to be absorbed.
     * @return The updated Keccak transcript after absorption.
     */
    function absorb(KeccakTranscript memory keccak, uint8[] memory label, PolyLib.UniPoly memory poly)
        public
        pure
        returns (KeccakTranscript memory)
    {
        return absorb(keccak, label, PolyLib.toTranscriptBytes(poly));
    }

    /**
     * @notice Absorbs Vesta affine points and additional data into the Keccak transcript.
     * @dev Processes the affine points (comm_W, comm_E) and additional uint256 data (X, u) for absorption.
     * @param keccak The existing Keccak transcript.
     * @param label A byte array label used in the absorption process.
     * @param comm_W The first Vesta affine point to be absorbed.
     * @param comm_E The second Vesta affine point to be absorbed.
     * @param X An array of uint256 values to be absorbed.
     * @param u A uint256 value to be absorbed.
     * @return The updated Keccak transcript after absorption.
     */
    function absorb(
        KeccakTranscript memory keccak,
        uint8[] memory label,
        Vesta.VestaAffinePoint memory comm_W,
        Vesta.VestaAffinePoint memory comm_E,
        uint256[] memory X,
        uint256 u
    ) public pure returns (KeccakTranscript memory) {
        // comm_W: 32 (X) + 32 (Y) + 1 (1 byte indicating whether comm_W is point at infinity)
        // comm_E: 32 (X) + 32 (Y) + 1 (1 byte indicating whether comm_E is point at infinity)
        // u: 32
        // X: 32 * len(X)
        uint8[] memory output = new uint8[](32 * 2 + 1 + 32 * 2 + 1 + 32 * X.length + 32);

        uint256 i = 0;
        uint256 index = 0;
        uint256 val;

        // write comm_W.x
        val = comm_W.x;
        for (i = 0; i < 32; i++) {
            output[index] = uint8(bytes1(bytes32(val)[31 - i]));
            index++;
        }
        // write comm_W.y
        val = comm_W.y;
        for (i = 0; i < 32; i++) {
            output[index] = uint8(bytes1(bytes32(val)[31 - i]));
            index++;
        }
        // write byte indicating whether comm_W is point at infinity
        if (Vesta.isInfinity(comm_W)) {
            output[index] = 0x00;
        } else {
            output[index] = 0x01;
        }
        index++;

        // write comm_E.x
        val = comm_E.x;
        for (i = 0; i < 32; i++) {
            output[index] = uint8(bytes1(bytes32(val)[31 - i]));
            index++;
        }
        // write comm_E.y
        val = comm_E.y;
        for (i = 0; i < 32; i++) {
            output[index] = uint8(bytes1(bytes32(val)[31 - i]));
            index++;
        }

        // write byte indicating whether comm_E is point at infinity
        if (Vesta.isInfinity(comm_E)) {
            output[index] = 0x00;
        } else {
            output[index] = 0x01;
        }
        index++;

        // write u
        val = u;
        for (i = 0; i < 32; i++) {
            output[index] = uint8(bytes1(bytes32(val)[31 - i]));
            index++;
        }

        // write X
        for (i = 0; i < X.length; i++) {
            val = X[i];
            for (uint256 j = 0; j < 32; j++) {
                output[index] = uint8(bytes1(bytes32(val)[31 - j]));
                index++;
            }
        }

        require(index == output.length, "[KeccakTranscript::absorb(RelaxedR1CSInstance, Vesta)] unexpected length");

        return absorb(keccak, label, output);
    }

    /**
     * @notice Absorbs Pallas affine points and additional data into the Keccak transcript.
     * @dev Processes the affine points (comm_W, comm_E) and additional uint256 data (X, u) for absorption.
     * @param keccak The existing Keccak transcript.
     * @param label A byte array label used in the absorption process.
     * @param comm_W The first Pallas affine point to be absorbed.
     * @param comm_E The second Pallas affine point to be absorbed.
     * @param X An array of uint256 values to be absorbed.
     * @param u A uint256 value to be absorbed.
     * @return The updated Keccak transcript after absorption.
     */
    function absorb(
        KeccakTranscript memory keccak,
        uint8[] memory label,
        Pallas.PallasAffinePoint memory comm_W,
        Pallas.PallasAffinePoint memory comm_E,
        uint256[] memory X,
        uint256 u
    ) public pure returns (KeccakTranscript memory) {
        // comm_W: 32 (X) + 32 (Y) + 1 (1 byte indicating whether comm_W is point at infinity)
        // comm_E: 32 (X) + 32 (Y) + 1 (1 byte indicating whether comm_E is point at infinity)
        // u: 32
        // X: 32 * len(X)
        uint8[] memory output = new uint8[](32 * 2 + 1 + 32 * 2 + 1 + 32 * X.length + 32);

        uint256 i = 0;
        uint256 index = 0;
        uint256 val;

        // write comm_W.x
        val = comm_W.x;
        for (i = 0; i < 32; i++) {
            output[index] = uint8(bytes1(bytes32(val)[31 - i]));
            index++;
        }
        // write comm_W.y
        val = comm_W.y;
        for (i = 0; i < 32; i++) {
            output[index] = uint8(bytes1(bytes32(val)[31 - i]));
            index++;
        }
        // write byte indicating whether comm_W is point at infinity
        if (Pallas.isInfinity(comm_W)) {
            output[index] = 0x00;
        } else {
            output[index] = 0x01;
        }
        index++;

        // write comm_E.x
        val = comm_E.x;
        for (i = 0; i < 32; i++) {
            output[index] = uint8(bytes1(bytes32(val)[31 - i]));
            index++;
        }
        // write comm_E.y
        val = comm_E.y;
        for (i = 0; i < 32; i++) {
            output[index] = uint8(bytes1(bytes32(val)[31 - i]));
            index++;
        }

        // write byte indicating whether comm_E is point at infinity
        if (Pallas.isInfinity(comm_E)) {
            output[index] = 0x00;
        } else {
            output[index] = 0x01;
        }
        index++;

        // write u
        val = u;
        for (i = 0; i < 32; i++) {
            output[index] = uint8(bytes1(bytes32(val)[31 - i]));
            index++;
        }

        // write X
        for (i = 0; i < X.length; i++) {
            val = X[i];
            for (uint256 j = 0; j < 32; j++) {
                output[index] = uint8(bytes1(bytes32(val)[31 - j]));
                index++;
            }
        }

        require(index == output.length, "[KeccakTranscript::absorb(RelaxedR1CSInstance, Pallas)] unexpected length");

        return absorb(keccak, label, output);
    }

    /**
     * @notice Absorbs a Bn256 affine point into the Keccak transcript.
     * @dev Converts the affine point's coordinates to bytes and handles the infinity case.
     * @param keccak The existing Keccak transcript.
     * @param label A byte array label used in the absorption process.
     * @param point The Bn256 affine point to be absorbed.
     * @return The updated Keccak transcript after absorption.
     */
    function absorb(KeccakTranscript memory keccak, uint8[] memory label, Bn256.Bn256AffinePoint memory point)
        public
        pure
        returns (KeccakTranscript memory)
    {
        uint8[] memory output = new uint8[](32 * 2 + 1);
        uint256 index = 0;
        // write x coordinate
        for (uint256 i = 0; i < 32; i++) {
            output[index] = uint8(bytes1(bytes32(point.x)[31 - i]));
            index++;
        }
        // write y coordinate
        for (uint256 i = 0; i < 32; i++) {
            output[index] = uint8(bytes1(bytes32(point.y)[31 - i]));
            index++;
        }

        // write byte indicating whether point is at infinity
        if (!Bn256.is_identity(point)) {
            output[index] = 0x00;
        } else {
            output[index] = 0x01;
        }
        return absorb(keccak, label, output);
    }

    /**
     * @notice Absorbs a Grumpkin affine point into the Keccak transcript.
     * @dev Converts the affine point's coordinates to bytes and handles the infinity case.
     * @param keccak The existing Keccak transcript.
     * @param label A byte array label used in the absorption process.
     * @param point The Grumpkin affine point to be absorbed.
     * @return The updated Keccak transcript after absorption.
     */
    function absorb(KeccakTranscript memory keccak, uint8[] memory label, Grumpkin.GrumpkinAffinePoint memory point)
        public
        pure
        returns (KeccakTranscript memory)
    {
        uint8[] memory output = new uint8[](32 * 2 + 1);
        uint256 index = 0;
        // write x coordinate
        for (uint256 i = 0; i < 32; i++) {
            output[index] = uint8(bytes1(bytes32(point.x)[31 - i]));
            index++;
        }
        // write y coordinate
        for (uint256 i = 0; i < 32; i++) {
            output[index] = uint8(bytes1(bytes32(point.y)[31 - i]));
            index++;
        }

        // write byte indicating whether point is at infinity
        if (!Grumpkin.is_identity(point)) {
            output[index] = 0x00;
        } else {
            output[index] = 0x01;
        }

        return absorb(keccak, label, output);
    }

    /**
     * @notice Absorbs an array of Bn256 affine points into the Keccak transcript.
     * @dev Converts each point's coordinates to bytes and handles the infinity case for each point.
     * @param keccak The existing Keccak transcript.
     * @param label A byte array label used in the absorption process.
     * @param points An array of Bn256 affine points to be absorbed.
     * @return The updated Keccak transcript after absorbing the points.
     */
    function absorb(KeccakTranscript memory keccak, uint8[] memory label, Bn256.Bn256AffinePoint[] memory points)
        public
        pure
        returns (KeccakTranscript memory)
    {
        uint8[] memory output = new uint8[]((32 * 2 + 1) * points.length);
        uint256 index = 0;
        for (uint256 j = 0; j < points.length; j++) {
            // write x coordinate
            for (uint256 i = 0; i < 32; i++) {
                output[index] = uint8(bytes1(bytes32(points[j].x)[31 - i]));
                index++;
            }
            // write y coordinate
            for (uint256 i = 0; i < 32; i++) {
                output[index] = uint8(bytes1(bytes32(points[j].y)[31 - i]));
                index++;
            }

            // write byte indicating whether point is at infinity
            if (!Bn256.is_identity(points[j])) {
                output[index] = 0x00;
            } else {
                output[index] = 0x01;
            }
            index++;
        }

        return absorb(keccak, label, output);
    }

    /**
     * @notice Absorbs an instance of InnerProductArgument into the Keccak transcript.
     * @dev Writes 'comm_a_vec', 'c' fields of InnerProductArgument into the transcript
     * @param keccak The existing Keccak transcript.
     * @param label A byte array label used in the absorption process.
     * @param ipa_input An instance of InnerProductArgument to be absorbed.
     * @return The updated Keccak transcript after absorbing the points.
     */
    function absorb(
        KeccakTranscript memory keccak,
        uint8[] memory label,
        InnerProductArgument.InstanceGrumpkin memory ipa_input
    ) public returns (KeccakTranscript memory) {
        uint256 output_length = 0;
        output_length += 32 * 2 + 1; // comm_a_vec
        // we don't write b_vec to transcript according to reference implementation
        output_length += 32; // c

        uint8[] memory output = new uint8[](output_length);
        uint256 index = 0;

        // write x coordinate
        for (uint256 i = 0; i < 32; i++) {
            output[index] = uint8(bytes1(bytes32(ipa_input.comm_a_vec.x)[31 - i]));
            index++;
        }
        // write y coordinate
        for (uint256 i = 0; i < 32; i++) {
            output[index] = uint8(bytes1(bytes32(ipa_input.comm_a_vec.y)[31 - i]));
            index++;
        }

        // write byte indicating whether point is at infinity
        if (Grumpkin.is_identity(ipa_input.comm_a_vec)) {
            output[index] = 0x00;
        } else {
            output[index] = 0x01;
        }
        index++;

        for (uint256 i = 0; i < 32; i++) {
            output[index] = uint8(bytes1(bytes32(ipa_input.c)[31 - i]));
            index++;
        }

        return absorb(keccak, label, output);
    }

    /**
     * @notice Generates a scalar from the Keccak transcript using a specified curve and updates the transcript.
     * @dev Updates the Keccak transcript state and computes a scalar value based on the selected elliptic curve.
     * @param keccak The existing Keccak transcript.
     * @param curve The elliptic curve to be used for generating the scalar.
     * @param label A byte array label used in the squeezing process.
     * @return A tuple containing the updated Keccak transcript and the generated scalar.
     */
    function squeeze(KeccakTranscript memory keccak, ScalarFromUniformLib.Curve curve, uint8[] memory label)
        public
        pure
        returns (KeccakTranscript memory, uint256)
    {
        uint8[] memory input = new uint8[](4 + 2 + keccak.state.length + keccak.transcript.length + label.length);

        uint256 index = 0;

        // copy transcript
        for (uint256 i = 0; i < keccak.transcript.length; i++) {
            input[index + i] = keccak.transcript[i];
        }
        index += keccak.transcript.length;

        // copy DOM_SEP_TAG
        input[index] = uint8((DOM_SEP_TAG >> 24) & 0xFF);
        input[index + 1] = uint8((DOM_SEP_TAG >> 16) & 0xFF);
        input[index + 2] = uint8((DOM_SEP_TAG >> 8) & 0xFF);
        input[index + 3] = uint8(DOM_SEP_TAG & 0xFF);
        index += 4;

        // append round (little-endian)
        input[index] = uint8((keccak.round) & 0xFF);
        input[index + 1] = uint8((keccak.round >> 8) & 0xFF);
        index += 2;

        // copy state
        for (uint256 i = 0; i < keccak.state.length; i++) {
            input[index + i] = keccak.state[i];
        }
        index += keccak.state.length;

        // append label
        for (uint256 i = 0; i < label.length; i++) {
            input[index + i] = label[i];
        }

        uint16 round;
        unchecked {
            round = keccak.round + 1;
        }
        bool overflowed = (round - keccak.round != 1);
        require(!overflowed, "[KeccakTranscript - squeeze] InternalTranscriptError");

        KeccakTranscript memory transcript = KeccakTranscript(round, computeUpdatedState(input), new uint8[](0));

        uint256 scalar = ScalarFromUniformLib.scalarFromUniform(transcript.state, curve);

        // TODO make state transferring through blockchain
        return (transcript, scalar);
    }
}
