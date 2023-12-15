// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.16;

import "src/blocks/pasta/Vesta.sol";
import "src/blocks/pasta/Pallas.sol";

/**
 * @title EqPolynomial Library
 * @dev Provides functions for evaluating equality polynomials in cryptographic protocols..
 */
library EqPolynomialLib {
    /**
     * @notice Evaluates the equation polynomial.
     * @dev This function computes the evaluation of an equation polynomial based on the given parameters. It iteratively computes the polynomial evaluation using assembly for optimized gas efficiency.
     * @param r The array of 'r' values, representing one part of the inputs to the polynomial.
     * @param rx The array of 'rx' values, representing another part of the inputs to the polynomial.
     * @param modulus The modulus to be used for the polynomial computation, ensuring calculations are done in a finite field.
     * @param negateBase A function that negates a base element in the finite field.
     * @return The result of the polynomial evaluation.
     */
    function evaluate(
        uint256[] memory r,
        uint256[] memory rx,
        uint256 modulus,
        function (uint256) returns (uint256) negateBase
    ) internal returns (uint256) {
        require(r.length == rx.length, "[EqPolinomialLib.evaluatePallas] wrong input data length");

        uint256 resultIter = 0;
        uint256 rx_inner = 0;
        uint256 r_inner = 0;
        uint256 tmp1 = 0;
        uint256 tmp2 = 0;
        uint256 tmp3 = 0;
        uint256 tmp4 = 0;
        uint256 minus_rx = 0;
        uint256 minus_r = 0;

        uint256 result = 1;
        for (uint256 i = 0; i < rx.length; i++) {
            rx_inner = rx[i];
            r_inner = r[i];
            minus_rx = negateBase(rx_inner);
            minus_r = negateBase(r_inner);
            assembly {
                // rx[i] * r[i]
                tmp1 := mulmod(rx_inner, r_inner, modulus)
                // 1 - rx[i]
                tmp2 := addmod(1, minus_rx, modulus)
                // 1 - r[i]
                tmp3 := addmod(1, minus_r, modulus)

                // tmp1 + tmp2 * tmp3
                tmp4 := addmod(tmp1, mulmod(tmp2, tmp3, modulus), modulus)

                // accumulate result
                resultIter := mulmod(tmp4, result, modulus)

                result := resultIter
            }
        }

        return result;
    }

    /**
     * @notice Computes evaluations of a polynomial for all combinations of inputs.
     * @dev Iteratively calculates the evaluations for all possible combinations of 'r' values. This function is used to generate a full set of evaluations for a given polynomial.
     * @param r The array of 'r' values, representing the inputs to the polynomial.
     * @param modulus The modulus to be used for polynomial computation.
     * @param negateBase A function that negates a base element in the finite field.
     * @return An array containing the evaluations for all input combinations.
     */
    function evals(uint256[] memory r, uint256 modulus, function (uint256) returns (uint256) negateBase)
        internal
        returns (uint256[] memory)
    {
        uint256[] memory evalsResult = new uint256[](2 ** r.length);
        uint256 size = 1;
        evalsResult[0] = 1;

        uint256 r_i = 0;
        uint256 x = 0;
        uint256 y = 0;
        uint256 minus_y = 0;
        for (uint256 i = 0; i < r.length; i++) {
            r_i = r[r.length - i - 1];
            for (uint256 j = 0; j < size; j++) {
                x = evalsResult[j];
                y = evalsResult[j + size];
                assembly {
                    y := mulmod(x, r_i, modulus)
                }

                minus_y = negateBase(y);

                assembly {
                    x := addmod(x, minus_y, modulus)
                }

                evalsResult[j] = x;
                evalsResult[j + size] = y;
            }
            size *= 2;
        }
        return evalsResult;
    }
}
