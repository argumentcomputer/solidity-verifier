// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.16;

import "src/blocks/EqPolynomial.sol";

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

library CommonUtilities {
    function log2(uint256 x) public pure returns (uint256 y) {
        assembly {
            let arg := x
            x := sub(x, 1)
            x := or(x, div(x, 0x02))
            x := or(x, div(x, 0x04))
            x := or(x, div(x, 0x10))
            x := or(x, div(x, 0x100))
            x := or(x, div(x, 0x10000))
            x := or(x, div(x, 0x100000000))
            x := or(x, div(x, 0x10000000000000000))
            x := or(x, div(x, 0x100000000000000000000000000000000))
            x := add(x, 1)
            let m := mload(0x40)
            mstore(m, 0xf8f9cbfae6cc78fbefe7cdc3a1793dfcf4f0e8bbd8cec470b6a28a7a5a3e1efd)
            mstore(add(m, 0x20), 0xf5ecf1b3e9debc68e1d9cfabc5997135bfb7a7a3938b7b606b5b4b3f2f1f0ffe)
            mstore(add(m, 0x40), 0xf6e4ed9ff2d6b458eadcdf97bd91692de2d4da8fd2d0ac50c6ae9a8272523616)
            mstore(add(m, 0x60), 0xc8c0b887b0a8a4489c948c7f847c6125746c645c544c444038302820181008ff)
            mstore(add(m, 0x80), 0xf7cae577eec2a03cf3bad76fb589591debb2dd67e0aa9834bea6925f6a4a2e0e)
            mstore(add(m, 0xa0), 0xe39ed557db96902cd38ed14fad815115c786af479b7e83247363534337271707)
            mstore(add(m, 0xc0), 0xc976c13bb96e881cb166a933a55e490d9d56952b8d4e801485467d2362422606)
            mstore(add(m, 0xe0), 0x753a6d1b65325d0c552a4d1345224105391a310b29122104190a110309020100)
            mstore(0x40, add(m, 0x100))
            let magic := 0x818283848586878898a8b8c8d8e8f929395969799a9b9d9e9faaeb6bedeeff
            let shift := 0x100000000000000000000000000000000000000000000000000000000000000
            let a := div(mul(x, magic), shift)
            y := div(mload(add(m, sub(255, a))), shift)
            y := add(y, mul(256, gt(arg, 0x8000000000000000000000000000000000000000000000000000000000000000)))
        }
    }

    function powers(uint256 s, uint256 len, uint256 modulus) public pure returns (uint256[] memory) {
        require(len >= 1);
        uint256[] memory result = new uint256[](len);
        result[0] = 1;

        for (uint256 index = 1; index < len; index++) {
            result[index] = mulmod(result[index - 1], s, modulus);
        }

        return result;
    }
}

library PolyLib {
    struct UniPoly {
        uint256[] coeffs;
    }

    struct CompressedUniPoly {
        uint256[] coeffs_except_linear_term;
    }

    struct SumcheckProof {
        PolyLib.CompressedUniPoly[] compressed_polys;
    }

    function degree(UniPoly memory poly) public pure returns (uint256) {
        return poly.coeffs.length - 1;
    }

    function evalAtZero(UniPoly memory poly) public pure returns (uint256) {
        return poly.coeffs[0];
    }

    function evalAtOne(UniPoly memory poly, uint256 mod) public pure returns (uint256 result) {
        for (uint256 i = 0; i < poly.coeffs.length; i++) {
            // result += poly.coeffs[i];
            result = addmod(result, poly.coeffs[i], mod);
        }
    }

    function evaluate(UniPoly memory poly, uint256 r, uint256 mod) public pure returns (uint256) {
        uint256 power = r;
        uint256 result = poly.coeffs[0];
        for (uint256 i = 1; i < poly.coeffs.length; i++) {
            // result += power * poly.coeffs[i];
            result = addmod(result, mulmod(power, poly.coeffs[i], mod), mod);
            // power *= r;
            power = mulmod(power, r, mod);
        }

        return result;
    }

    function negate(uint256 x, uint256 mod) internal pure returns (uint256) {
        return mod - (x % mod);
    }

    function decompress(CompressedUniPoly calldata poly, uint256 hint, uint256 mod)
    public
    pure
    returns (UniPoly memory)
    {
        // uint256 linear_term = hint - poly.coeffs_except_linear_term[0] - poly.coeffs_except_linear_term[0];
        uint256 linear_term = addmod(
            hint, negate(addmod(poly.coeffs_except_linear_term[0], poly.coeffs_except_linear_term[0], mod), mod), mod
        );

        for (uint256 i = 1; i < poly.coeffs_except_linear_term.length; i++) {
            // linear_term -= poly.coeffs_except_linear_term[i];
            linear_term = addmod(linear_term, negate(poly.coeffs_except_linear_term[i], mod), mod);
        }

        uint256 coeff_index = 0;
        uint256[] memory coeffs = new uint256[](
            poly.coeffs_except_linear_term.length + 1
        );
        coeffs[coeff_index] = poly.coeffs_except_linear_term[0];
        coeff_index++;
        coeffs[coeff_index] = linear_term;
        coeff_index++;

        for (uint256 i = 1; i < poly.coeffs_except_linear_term.length; i++) {
            coeffs[coeff_index] = poly.coeffs_except_linear_term[i];
            coeff_index++;
        }

        return UniPoly(coeffs);
    }

    function toUInt8Array(uint256 input) private pure returns (uint8[] memory) {
        uint8[] memory result = new uint8[](32);

        bytes32 input_bytes = bytes32(input);

        for (uint256 i = 0; i < 32; i++) {
            result[i] = uint8(input_bytes[31 - i]);
        }
        return result;
    }

    function toTranscriptBytes(UniPoly memory poly) public pure returns (uint8[] memory) {
        uint8[] memory result = new uint8[](32 * (poly.coeffs.length - 1));

        uint256 offset;
        uint8[] memory coeff_bytes = toUInt8Array(poly.coeffs[0]);
        for (uint256 i = 0; i < 32; i++) {
            result[i] = coeff_bytes[i];
        }
        offset += 32;

        for (uint256 i = 2; i < poly.coeffs.length; i++) {
            coeff_bytes = toUInt8Array(poly.coeffs[i]);
            for (uint256 j = 0; j < 32; j++) {
                result[offset + j] = coeff_bytes[j];
            }
            offset += 32;
        }

        return result;
    }
}
