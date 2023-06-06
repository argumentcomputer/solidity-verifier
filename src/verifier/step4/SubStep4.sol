pragma solidity ^0.8.0;

import "@std/Test.sol";
import "src/pasta/Vesta.sol";
import "src/pasta/Pallas.sol";
import "src/verifier/step4/SparsePolynomial.sol";
import "src/verifier/step4/spark-multi-evaluation/SparkMultiEvaluationLogic.sol";

library SpartanVerificationSupStep4Lib {
    function preprocess(uint256 U_u, uint256[] memory U_x, uint256[] memory r_y) private pure returns (SparsePolynomialLib.Z[] memory, uint256[] memory){
        uint256 polyX_index = 0;

        SparsePolynomialLib.Z[] memory poly_X = new SparsePolynomialLib.Z[](1 + U_x.length);
        poly_X[polyX_index] = SparsePolynomialLib.Z(0, U_u);
        polyX_index++;

        for (uint256 index = 0; index < U_x.length; index++) {
            poly_X[polyX_index].index = polyX_index;
            poly_X[polyX_index].scalar = U_x[index];
            polyX_index++;
        }

        uint256[] memory r_y_sparse = new uint256[](r_y.length - 1);
        for (uint256 index = 1; index < r_y.length; index++) {
            r_y_sparse[index - 1] = r_y[index];
        }

        return (poly_X, r_y_sparse);
    }


    function verifyPrimary(uint256 U_u, uint256[] memory U_x, uint256[] memory r_x, uint256[] memory r_y, uint256 eval_W, uint256 r, uint256 claim_inner_final_expected) public pure {
        (SparsePolynomialLib.Z[] memory poly_X, uint256[] memory r_y_sparse) = preprocess(U_u, U_x, r_y);

        uint256 eval_X = SparsePolynomialLib.evaluateVesta(r_y_sparse.length, poly_X, r_y_sparse);

        uint256 eval_Z = Pallas.negate(r_y[0]); // Pallas
        uint256 modulusVesta = Vesta.P_MOD;
        uint256 tmp = r_y[0];
        assembly {
            eval_Z := addmod(1, eval_Z, modulusVesta) // Vesta
            eval_Z := mulmod(eval_Z, eval_W, modulusVesta) // Vesta
            tmp := mulmod(tmp, eval_X, modulusVesta) // Vesta
            eval_Z := addmod(eval_Z, tmp, modulusVesta) // Vesta
        }

        (uint256 eval_A, uint256 eval_B, uint256 eval_C) = SparkMultiEvaluationLib.multiEvaluatePrimary(r_x, r_y);

        assembly {
            tmp := mulmod(eval_B, r, modulusVesta) // Vesta
            tmp := addmod(eval_A, tmp, modulusVesta) // Vesta
            // we can use eval_A as tmp2 since its value is not used anymore
            eval_A := mulmod(r, r, modulusVesta) // Vesta
            eval_C := mulmod(eval_A, eval_C, modulusVesta) // Vesta
            tmp := addmod(tmp, eval_C, modulusVesta) // Vesta
            tmp := mulmod(tmp, eval_Z, modulusVesta) // Vesta
        }

        require(tmp == claim_inner_final_expected, "[SpartanVerificationSupStep4Lib.verifyPrimary] InvalidSumcheckProof");
    }

    function verifySecondary(uint256 U_u, uint256[] memory U_x, uint256[] memory r_x, uint256[] memory r_y, uint256 eval_W, uint256 r, uint256 claim_inner_final_expected) public pure {
        (SparsePolynomialLib.Z[] memory poly_X, uint256[] memory r_y_sparse) = preprocess(U_u, U_x, r_y);

        uint256 eval_X = SparsePolynomialLib.evaluatePallas(r_y_sparse.length, poly_X, r_y_sparse);

        uint256 eval_Z = Vesta.negate(r_y[0]); // Vesta
        uint256 modulusPallas = Pallas.P_MOD;
        uint256 tmp = r_y[0];
        assembly {
            eval_Z := addmod(1, eval_Z, modulusPallas) // Pallas
            eval_Z := mulmod(eval_Z, eval_W, modulusPallas) // Pallas
            tmp := mulmod(tmp, eval_X, modulusPallas) // Pallas
            eval_Z := addmod(eval_Z, tmp, modulusPallas) // Pallas
        }

        (uint256 eval_A, uint256 eval_B, uint256 eval_C) = SparkMultiEvaluationLib.multiEvaluateSecondary(r_x, r_y);

        assembly {
            tmp := mulmod(eval_B, r, modulusPallas) // Pallas
            tmp := addmod(eval_A, tmp, modulusPallas) // Pallas
            // we can use eval_A as tmp2 since its value is not used anymore
            eval_A := mulmod(r, r, modulusPallas) // Pallas
            eval_C := mulmod(eval_A, eval_C, modulusPallas) // Pallas
            tmp := addmod(tmp, eval_C, modulusPallas) // Pallas
            tmp := mulmod(tmp, eval_Z, modulusPallas) // Pallas
        }

        require(tmp == claim_inner_final_expected, "[SpartanVerificationSupStep4Lib.verifySecondary] InvalidSumcheckProof");
    }
}