// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.16;

import "@std/Test.sol";
import "src/blocks/pasta/Vesta.sol";
import "src/blocks/pasta/Pallas.sol";
import "src/Utilities.sol";

/**
 * @title PolyEvalInstance Library
 * @notice Library for polynomial evaluations.
 * @dev Provides functionality to handle polynomial evaluation instances in cryptographic contexts.
 */
library PolyEvalInstanceLib {
    struct PolyEvalInstance {
        // c is an affine point
        uint256 c_x;
        uint256 c_y;
        uint256[] x;
        uint256 e;
    }

    /**
     * @notice Pads polynomial evaluation instances to have uniform length.
     * @dev Extends the length of each instance's `x` array to match the maximum length found in `p`.
     * @param p Array of PolyEvalInstance to be padded.
     * @return Array of padded PolyEvalInstance.
     */
    function pad(PolyEvalInstance[] memory p) public pure returns (PolyEvalInstance[] memory) {
        uint256 j;
        uint256 i;
        uint256 x_length_max;
        for (i = 0; i < p.length; i++) {
            if (p[i].x.length > x_length_max) {
                x_length_max = p[i].x.length;
            }
        }

        uint256[] memory x = new uint256[](x_length_max);
        for (i = 0; i < p.length; i++) {
            if (p[i].x.length < x_length_max) {
                x = new uint256[](x_length_max);
                for (j = x_length_max - p[i].x.length; j < x_length_max; j++) {
                    x[j] = p[i].x[j - (x_length_max - p[i].x.length)];
                }
                p[i].x = x;
            }
        }

        return p;
    }

    /**
     * @notice Batch computes primary polynomial evaluations.
     * @dev Uses Pallas curve for polynomial evaluation.
     * @param comm_vec Array of affine points for computation.
     * @param x Array of x values for each evaluation.
     * @param eval_vec Array of values to be evaluated.
     * @param s Scalar value used in evaluations.
     * @return PolyEvalInstance representing the result of the batch evaluation.
     */
    function batchPrimary(
        Pallas.PallasAffinePoint[] memory comm_vec,
        uint256[] memory x,
        uint256[] memory eval_vec,
        uint256 s
    ) public view returns (PolyEvalInstance memory) {
        require(
            comm_vec.length == eval_vec.length, "[PolyEvalInstanceLib.batchPrimary]: comm_vec.length != eval_vec.length"
        );

        uint256[] memory powers_of_s = CommonUtilities.powers(s, comm_vec.length, Pallas.R_MOD);
        uint256 e;
        for (uint256 index = 0; index < eval_vec.length; index++) {
            e = addmod(e, mulmod(powers_of_s[index], eval_vec[index], Pallas.R_MOD), Pallas.R_MOD);
        }

        Pallas.PallasAffinePoint memory c_out = Pallas.PallasAffinePoint(0, 0);
        Pallas.PallasAffinePoint memory temp = Pallas.PallasAffinePoint(0, 0);
        for (uint256 index = 0; index < comm_vec.length; index++) {
            temp = Pallas.scalarMul(comm_vec[index], powers_of_s[index]);

            c_out = Pallas.add(temp, c_out);
        }
        // x is just a copy of input
        return PolyEvalInstance(c_out.x, c_out.y, x, e);
    }

    /**
     * @notice Batch computes secondary polynomial evaluations.
     * @dev Uses Vesta curve for polynomial evaluation.
     * @param comm_vec Array of affine points for computation.
     * @param x Array of x values for each evaluation.
     * @param eval_vec Array of values to be evaluated.
     * @param s Scalar value used in evaluations.
     * @return PolyEvalInstance representing the result of the batch evaluation.
     */
    function batchSecondary(
        Vesta.VestaAffinePoint[] memory comm_vec,
        uint256[] memory x,
        uint256[] memory eval_vec,
        uint256 s
    ) public view returns (PolyEvalInstance memory) {
        require(
            comm_vec.length == eval_vec.length,
            "[PolyEvalInstanceLib.batchSecondary]: comm_vec.length != eval_vec.length"
        );

        uint256[] memory powers_of_s = CommonUtilities.powers(s, comm_vec.length, Vesta.R_MOD);

        uint256 e;
        for (uint256 index = 0; index < eval_vec.length; index++) {
            e = addmod(e, mulmod(powers_of_s[index], eval_vec[index], Vesta.R_MOD), Vesta.R_MOD);
        }

        Vesta.VestaAffinePoint memory c_out = Vesta.VestaAffinePoint(0, 0);
        Vesta.VestaAffinePoint memory temp = Vesta.VestaAffinePoint(0, 0);
        for (uint256 index = 0; index < comm_vec.length; index++) {
            temp = Vesta.scalarMul(comm_vec[index], powers_of_s[index]);

            c_out = Vesta.add(temp, c_out);
        }

        // x is just a copy of input
        return PolyEvalInstance(c_out.x, c_out.y, x, e);
    }
}
