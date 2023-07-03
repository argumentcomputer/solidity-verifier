// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.0;

import "src/pasta/Vesta.sol";
import "src/pasta/Pallas.sol";
import "src/verifier/step4/EqPolynomial.sol";
import "src/verifier/step4/spark/SparkMultiEvaluationDataPrimary.sol";
import "src/verifier/step4/spark/SparkMultiEvaluationDataSecondary.sol";

// Port of Nova' Spark multi-evaluation (https://github.com/lurk-lab/Nova/blob/solidity-verifier/src/spartan/spark/sparse.rs#L159)
library SparkMultiEvaluationLib {
    function multiEvaluateSecondaryInner(
        R1CSShapeLibSecondary.Triple[] memory input,
        uint256[] memory T_x,
        uint256[] memory T_y
    ) private pure returns (uint256) {
        uint256 modulusPallas = Pallas.P_MOD;

        uint256 result = 0;
        uint256 val = 0;
        uint256 T_row = 0;
        uint256 T_col = 0;

        for (uint256 i = 0; i < input.length; i++) {
            T_row = T_x[input[i].index1];
            T_col = T_y[input[i].index2];
            val = input[i].scalar;

            assembly {
                val := mulmod(T_row, val, modulusPallas)
                val := mulmod(T_col, val, modulusPallas)
                result := addmod(result, val, modulusPallas)
            }
        }

        return result;
    }

    function multiEvaluatePrimaryInner(
        R1CSShapeLibPrimary.Triple[] memory input,
        uint256[] memory T_x,
        uint256[] memory T_y
    ) private pure returns (uint256) {
        uint256 modulusVesta = Vesta.P_MOD;

        uint256 result = 0;
        uint256 val = 0;
        uint256 T_row = 0;
        uint256 T_col = 0;

        for (uint256 i = 0; i < input.length; i++) {
            T_row = T_x[input[i].index1];
            T_col = T_y[input[i].index2];
            val = input[i].scalar;

            assembly {
                val := mulmod(T_row, val, modulusVesta)
                val := mulmod(T_col, val, modulusVesta)
                result := addmod(result, val, modulusVesta)
            }
        }

        return result;
    }

    function multiEvaluateSecondary(uint256[] memory r_x, uint256[] memory r_y)
        public
        pure
        returns (uint256, uint256, uint256)
    {
        uint256[] memory T_x = EqPolinomialLib.evalsPallas(r_x);
        uint256[] memory T_y = EqPolinomialLib.evalsPallas(r_y);

        // TODO: this should be somehow replaced with fetching the proof data from blockchain/IPFS
        R1CSShapeLibSecondary.Triple[] memory A = R1CSShapeLibSecondary.loadCommASecondary();

        R1CSShapeLibSecondary.Triple[] memory B = R1CSShapeLibSecondary.loadCommBSecondary();

        R1CSShapeLibSecondary.Triple[] memory C = R1CSShapeLibSecondary.loadCommCSecondary();

        uint256 result_C = multiEvaluateSecondaryInner(C, T_x, T_y);

        uint256 result_B = multiEvaluateSecondaryInner(B, T_x, T_y);

        uint256 result_A = multiEvaluateSecondaryInner(A, T_x, T_y);

        return (result_A, result_B, result_C);

        // EqPolynomialLib.evalsPallas twice. Gas usage: 74983688
        // Just loading A, B, C. Gas usage: 3057603089 + 74983688 (in theory)
        // Load only C and compute evals for it. Gas usage: 143474229
        // Load B and C and compute evals for both of them. Gas usage: 966410180
        // Load A, B and C and compute evals for all of them. Gas usage: 3533684529
    }

    function multiEvaluatePrimary(uint256[] memory r_x, uint256[] memory r_y)
        public
        pure
        returns (uint256, uint256, uint256)
    {
        uint256[] memory T_x = EqPolinomialLib.evalsVesta(r_x);
        uint256[] memory T_y = EqPolinomialLib.evalsVesta(r_y);

        // TODO: this should be somehow replaced with fetching the proof data from blockchain/IPFS
        R1CSShapeLibPrimary.Triple[] memory A = R1CSShapeLibPrimary.loadCommAPrimary();

        R1CSShapeLibPrimary.Triple[] memory B = R1CSShapeLibPrimary.loadCommBPrimary();

        R1CSShapeLibPrimary.Triple[] memory C = R1CSShapeLibPrimary.loadCommCPrimary();

        uint256 result_C = multiEvaluatePrimaryInner(C, T_x, T_y);

        uint256 result_B = multiEvaluatePrimaryInner(B, T_x, T_y);

        uint256 result_A = multiEvaluatePrimaryInner(A, T_x, T_y);

        return (result_A, result_B, result_C);
    }
}
