// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.0;

import "src/verifier/step4/EqPolynomial.sol";

library PolyLib {
    struct UniPoly {
        uint256[] coeffs;
    }

    struct CompressedUniPoly {
        uint256[] coeffs_except_linear_term;
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
        uint256[] memory coeffs = new uint256[](poly.coeffs_except_linear_term.length + 1);
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
