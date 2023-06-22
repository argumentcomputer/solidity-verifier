// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.0;

import "src/pasta/Vesta.sol";
import "src/pasta/Pallas.sol";

// Port of Nova' SparsePolynomial (https://github.com/microsoft/Nova/blob/main/src/spartan/polynomial.rs#L121)
library SparsePolynomialLib {
    struct Z {
        uint256 index;
        uint256 scalar;
    }

    function evaluateVesta(uint256 num_vars, Z[] memory poly_X, uint256[] memory r_y) public pure returns (uint256) {
        require(num_vars == r_y.length, "[SparsePolynomialLib.evaluate] num_vars != r_y.length");

        uint256 modulusVesta = Vesta.P_MOD;

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
                        chi := mulmod(chi, r_y_index, modulusVesta) // Vesta
                    }
                } else {
                    r_y_index = Vesta.negateBase(r_y[index]); // Vesta
                    assembly {
                        let tmp := addmod(1, r_y_index, modulusVesta)
                        chi := mulmod(chi, tmp, modulusVesta) // Vesta
                    }
                }
            }
            // accumulate result
            z = poly_X[j].scalar;
            assembly {
                chi := mulmod(chi, z, modulusVesta) // Vesta
                result := addmod(result, chi, modulusVesta) // Vesta
            }
            chi = 1;
        }
        return result;
    }

    function evaluatePallas(uint256 num_vars, Z[] memory poly_X, uint256[] memory r_y) public pure returns (uint256) {
        require(num_vars == r_y.length, "[SparsePolynomialLib.evaluate] num_vars != r_y.length");

        uint256 modulusPallas = Pallas.P_MOD;

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
                        chi := mulmod(chi, r_y_index, modulusPallas) // Pallas
                    }
                } else {
                    r_y_index = Pallas.negateBase(r_y[index]); // Pallas
                    assembly {
                        let tmp := addmod(1, r_y_index, modulusPallas) // Pallas
                        chi := mulmod(chi, tmp, modulusPallas) // Pallas
                    }
                }
            }
            // accumulate result
            z = poly_X[j].scalar;
            assembly {
                chi := mulmod(chi, z, modulusPallas) // Pallas
                result := addmod(result, chi, modulusPallas) // Pallas
            }
            chi = 1;
        }
        return result;
    }
}
