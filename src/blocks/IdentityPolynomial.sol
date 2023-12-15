// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.16;

import "src/blocks/pasta/Vesta.sol";
import "src/blocks/pasta/Pallas.sol";

/**
 * @title IdentityPolynomial Library
 * @notice Implements the evaluation of the Identity Polynomial.
 * @dev This library is a Solidity port of Nova's IdentityPolynomial (https://github.com/lurk-lab/Nova/blob/solidity-verifier-pp-spartan/src/spartan/ppsnark.rs#L35),
 *      which is used in Spartan-based zero-knowledge proofs. The function calculates the identity polynomial based on a
 *      given array of 'r' values.
 */
library IdentityPolynomialLib {
    /**
     * @notice Evaluate the Identity Polynomial with given 'r' values.
     * @dev Calculates the identity polynomial by iterating over each element of the 'r' array. Each element is scaled by a power of 2 based on its position and then reduced modulo the given modulus.
     * @param r Array of 'r' values, inputs to the polynomial.
     * @param modulus The modulus for performing operations in a finite field.
     * @return The result of the polynomial evaluation.
     */
    function evaluate(uint256[] memory r, uint256 modulus) public pure returns (uint256) {
        uint256 result;
        uint256 tmp;
        for (uint256 index = 0; index < r.length; index++) {
            tmp = uint256(uint64(2 ** (r.length - index - 1)));
            tmp = mulmod(tmp, r[index], modulus);
            result = addmod(tmp, result, modulus);
        }
        return result;
    }
}
