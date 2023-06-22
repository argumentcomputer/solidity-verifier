// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.0;

import "src/pasta/Vesta.sol";
import "src/pasta/Pallas.sol";

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

    enum Curve {
        PALLAS,
        VESTA
    }

    function curvePallas() public pure returns (Curve) {
        return Curve.PALLAS;
    }

    function curveVesta() public pure returns (Curve) {
        return Curve.VESTA;
    }

    // 'from_uniform_bytes' in Rust
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
}

library KeccakTranscriptLib {
    uint32 private constant PERSONA_TAG = 0x4e6f5452;
    uint32 private constant DOM_SEP_TAG = 0x4e6f4453;
    uint8 private constant KECCAK256_PREFIX_CHALLENGE_LO = 0x00;
    uint8 private constant KECCAK256_PREFIX_CHALLENGE_HI = 0x01;
    uint256 private constant KECCAK_TRANSCRIPT_STATE_BYTE_LEN = 64;

    struct KeccakTranscript {
        uint16 round;
        uint8[] state;
        uint8[] transcript;
    }

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

    function absorb(KeccakTranscript memory keccak, uint8[] memory label, uint256 input)
        public
        pure
        returns (KeccakTranscript memory)
    {
        // uint256 input will always take 32 bytes
        uint8[] memory transcript = new uint8[](keccak.transcript.length + label.length + 32);
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
        for (uint256 i = 0; i < 32; i++) {
            transcript[index + i] = uint8(bytes1(bytes32(input)[31 - i]));
        }

        // TODO This should be workarounded by interacting with the blockchain, that holds the state
        return KeccakTranscript(keccak.round, keccak.state, transcript);
    }

    function squeeze(KeccakTranscript memory keccak, ScalarFromUniformLib.Curve curve, uint8[] memory label)
        public
        pure
        returns (KeccakTranscript memory, uint256)
    {
        uint8[] memory input = new uint8[](4 + 2 + keccak.state.length + keccak.transcript.length + label.length);

        uint256 index = 0;

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

        // copy transcript
        for (uint256 i = 0; i < keccak.transcript.length; i++) {
            input[index + i] = keccak.transcript[i];
        }
        index += keccak.transcript.length;

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
