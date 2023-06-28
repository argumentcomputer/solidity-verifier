// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.0;

library Field {
    uint256 constant ZERO = 0;
    uint256 constant ONE = 1;

    /// @dev Compute f^-1 for f \in Fr scalar field
    /// @notice credit: Aztec, Spilsbury Holdings Ltd
    function invert(uint256 _x, uint256 _mod) public view returns (uint256 output) {
        assembly {
            let mPtr := mload(0x40)
            mstore(mPtr, 0x20)
            mstore(add(mPtr, 0x20), 0x20)
            mstore(add(mPtr, 0x40), 0x20)
            mstore(add(mPtr, 0x60), _x)
            mstore(add(mPtr, 0x80), sub(_mod, 2))
            mstore(add(mPtr, 0xa0), _mod)
            if iszero(staticcall(gas(), 0x05, mPtr, 0xc0, 0x00, 0x20)) { revert(0, 0) }
            output := mload(0x00)
        }
    }

    function fieldpow(uint256 _base, uint256 _exp, uint256 _mod) public view returns (uint256 result) {
        assembly {
            // Free memory pointer
            let pointer := mload(0x40)
            // Define length of base, exponent and modulus. 0x20 == 32 bytes
            mstore(pointer, 0x20)
            mstore(add(pointer, 0x20), 0x20)
            mstore(add(pointer, 0x40), 0x20)
            // Define variables base, exponent and modulus
            mstore(add(pointer, 0x60), _base)
            mstore(add(pointer, 0x80), _exp)
            mstore(add(pointer, 0xa0), _mod)
            // Store the result
            let value := mload(0xc0)
            // Call the precompiled contract 0x05 = bigModExp
            if iszero(staticcall(not(0), 0x05, pointer, 0xc0, value, 0x20)) { revert(0, 0) }
            result := mload(value)
        }
    }

    // @dev Perform a modular exponentiation.
    // @return base^exponent (mod modulus)
    // This method is ideal for small exponents (~64 bits or less), as it is cheaper than using the pow precompile
    // @notice credit: credit: Aztec, Spilsbury Holdings Ltd
    function powSmall(uint256 base, uint256 exponent, uint256 modulus) internal pure returns (uint256) {
        uint256 result = 1;
        uint256 input = base;
        uint256 count = 1;

        assembly {
            let endPoint := add(exponent, 0x01)
            for {} lt(count, endPoint) { count := add(count, count) } {
                if and(exponent, count) { result := mulmod(result, input, modulus) }
                input := mulmod(input, input, modulus)
            }
        }

        return result;
    }
    // Implementation of the Tonelli-Shanks square root algorithm
    // NOTE: It is assumed that _mod is a prime for this algorithm to work, and when _mod is congruent to 3 mod 4
    // a direct calculation is used instead.

    function sqrt(uint256 _x, uint256 _mod) public view returns (uint256) {
        assembly {
            function pow_mod(base, exponent, modulus) -> answer {
                let pointer := mload(0x40)
                mstore(pointer, 0x20)
                mstore(add(pointer, 0x20), 0x20)
                mstore(add(pointer, 0x40), 0x20)
                mstore(add(pointer, 0x60), base)
                mstore(add(pointer, 0x80), exponent)
                mstore(add(pointer, 0xa0), modulus)

                let result_ptr := mload(0x40)
                if iszero(staticcall(not(0), 0x05, pointer, 0xc0, result_ptr, 0x20)) { revert(0, 0) }
                answer := mload(result_ptr)
            }

            // This calculates the the Legendre symbol of base modulo modulus. Again, it is assumed modulus is prime.
            function is_square(base, modulus) -> isSquare {
                let exponent := div(sub(modulus, 1), 2)
                let exp_result := pow_mod(base, exponent, modulus)
                isSquare := iszero(sub(exp_result, 1))
            }

            function require(condition) {
                if iszero(condition) { revert(0, 0) }
            }

            require(is_square(_x, _mod))

            if iszero(sub(mod(_mod, 4), 3)) {
                let exponent := div(add(_mod, 1), 4)
                let answer_ptr := mload(0x40)
                mstore(answer_ptr, pow_mod(_x, exponent, _mod))
                return(answer_ptr, 0x20)
            }

            let s := sub(_mod, 1)
            let e := 0
            for {} iszero(mod(s, 2)) {} {
                s := div(s, 2)
                e := add(e, 1)
            }

            let n := 2
            for {} is_square(n, _mod) {} { n := add(n, 1) }

            let x := pow_mod(_x, div(add(s, 1), 2), _mod)
            let b := pow_mod(_x, s, _mod)
            let g := pow_mod(n, s, _mod)
            let r := e

            for {} 1 {} {
                let t := b
                let m := 0
                for {} lt(m, r) { m := add(m, 1) } {
                    if eq(t, 1) { break }
                    t := mulmod(t, t, _mod)
                }

                if iszero(m) {
                    let return_ptr := mload(0x40)
                    mstore(return_ptr, x)
                    return(return_ptr, 0x20)
                }

                let gs := pow_mod(g, exp(2, sub(r, add(m, 1))), _mod)
                g := mulmod(gs, gs, _mod)
                x := mulmod(x, gs, _mod)
                b := mulmod(b, g, _mod)
                r := m
            }
        }
        revert();
    }

    function reverse256(uint256 input) public pure returns (uint256 v) {
        v = input;

        // swap bytes
        v = ((v & 0xFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00) >> 8)
            | ((v & 0x00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF) << 8);

        // swap 2-byte long pairs
        v = ((v & 0xFFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000) >> 16)
            | ((v & 0x0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF) << 16);

        // swap 4-byte long pairs
        v = ((v & 0xFFFFFFFF00000000FFFFFFFF00000000FFFFFFFF00000000FFFFFFFF00000000) >> 32)
            | ((v & 0x00000000FFFFFFFF00000000FFFFFFFF00000000FFFFFFFF00000000FFFFFFFF) << 32);

        // swap 8-byte long pairs
        v = ((v & 0xFFFFFFFFFFFFFFFF0000000000000000FFFFFFFFFFFFFFFF0000000000000000) >> 64)
            | ((v & 0x0000000000000000FFFFFFFFFFFFFFFF0000000000000000FFFFFFFFFFFFFFFF) << 64);

        // swap 16-byte long pairs
        v = (v >> 128) | (v << 128);
    }

    // Returns the 4 limbs in little-endian order of a 256-bit field element.
    function extractLimbs(uint256 x) public pure returns (uint256, uint256, uint256, uint256) {
        uint256 limb1 = (0x000000000000000000000000000000000000000000000000ffffffffffffffff & x);
        uint256 limb2 = (0x00000000000000000000000000000000ffffffffffffffff0000000000000000 & x) >> 64;
        uint256 limb3 = (0x0000000000000000ffffffffffffffff00000000000000000000000000000000 & x) >> 128;
        uint256 limb4 = (0xffffffffffffffff000000000000000000000000000000000000000000000000 & x) >> 192;

        return (limb1, limb2, limb3, limb4);
    }

    function uint8ArrayToBytes32(uint8[32] memory input) public pure returns (bytes32) {
        bytes32 output;

        for (uint256 i = 0; i < input.length; i++) {
            output |= bytes32(bytes1(input[i])) >> (i * 8);
        }

        return output;
    }
}
