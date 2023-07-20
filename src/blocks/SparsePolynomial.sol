// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.16;

import "src/blocks/pasta/Vesta.sol";
import "src/blocks/pasta/Pallas.sol";

// Port of Nova' SparsePolynomial (https://github.com/microsoft/Nova/blob/main/src/spartan/polynomial.rs#L121)
library SparsePolynomialLib {
    struct Z {
        uint256 index;
        uint256 scalar;
    }

    function setupPoly_X(
        SparsePolynomialLib.Z memory z0,
        SparsePolynomialLib.Z memory z1,
        SparsePolynomialLib.Z memory z2
    ) public pure returns (SparsePolynomialLib.Z[] memory) {
        SparsePolynomialLib.Z[] memory poly_X = new SparsePolynomialLib.Z[](3);
        poly_X[0] = z0;
        poly_X[1] = z1;
        poly_X[2] = z2;

        return poly_X;
    }

    function evaluate(
        uint256 num_vars,
        Z[] memory poly_X,
        uint256[] memory r_y,
        uint256 modulus,
        function (uint256) pure returns (uint256) negateBase
    ) internal pure returns (uint256) {
        require(num_vars == r_y.length, "[SparsePolynomialLib.evaluate] num_vars != r_y.length");

        uint256 chi = 1;
        uint256 z = 0;
        uint256 r_y_index = 0;
        uint256 result = 0;
        for (uint256 j = 0; j < poly_X.length; j++) {
            z = poly_X[j].index;
            for (uint256 index = 0; index < num_vars; index++) {
                if (((z >> num_vars - index - 1) & 1) == 1) {
                    r_y_index = r_y[index];
                    assembly {
                        chi := mulmod(chi, r_y_index, modulus)
                    }
                } else {
                    r_y_index = negateBase(r_y[index]);
                    assembly {
                        let tmp := addmod(1, r_y_index, modulus)
                        chi := mulmod(chi, tmp, modulus)
                    }
                }
            }
            // accumulate result
            z = poly_X[j].scalar;
            assembly {
                chi := mulmod(chi, z, modulus)
                result := addmod(result, chi, modulus)
            }
            chi = 1;
        }
        return result;
    }
}
