// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.0;

import "src/blocks/pasta/Pallas.sol";
import "src/blocks/pasta/Vesta.sol";
import "src/blocks/EqPolynomial.sol";

contract SparkMultiEvaluationContract {
    struct MatrixData {
        uint32 i;
        uint32 j;
        uint256 scalar;
    }

    uint256[] public r_x_primary;
    uint256[] public r_y_primary;
    uint256[] public r_x_secondary;
    uint256[] public r_y_secondary;

    MatrixData[] public A_primary;
    MatrixData[] public B_primary;
    MatrixData[] public C_primary;
    MatrixData[] public A_secondary;
    MatrixData[] public B_secondary;
    MatrixData[] public C_secondary;

    function pushToRxPrimary(uint256[] calldata input) public {
        for (uint256 index = 0; index < input.length; index++) {
            r_x_primary.push(input[index]);
        }
    }

    function pushToRyPrimary(uint256[] calldata input) public {
        for (uint256 index = 0; index < input.length; index++) {
            r_y_primary.push(input[index]);
        }
    }

    function pushToAprimary(MatrixData[] calldata input) public {
        for (uint256 index = 0; index < input.length; index++) {
            A_primary.push(input[index]);
        }
    }

    function pushToBprimary(MatrixData[] calldata input) public {
        for (uint256 index = 0; index < input.length; index++) {
            B_primary.push(input[index]);
        }
    }

    function pushToCprimary(MatrixData[] calldata input) public {
        for (uint256 index = 0; index < input.length; index++) {
            C_primary.push(input[index]);
        }
    }

    function pushToRxSecondary(uint256[] calldata input) public {
        for (uint256 index = 0; index < input.length; index++) {
            r_x_secondary.push(input[index]);
        }
    }

    function pushToRySecondary(uint256[] calldata input) public {
        for (uint256 index = 0; index < input.length; index++) {
            r_y_secondary.push(input[index]);
        }
    }

    function pushToAsecondary(MatrixData[] calldata input) public {
        for (uint256 index = 0; index < input.length; index++) {
            A_secondary.push(input[index]);
        }
    }

    function pushToBsecondary(MatrixData[] calldata input) public {
        for (uint256 index = 0; index < input.length; index++) {
            B_secondary.push(input[index]);
        }
    }

    function pushToCsecondary(MatrixData[] calldata input) public {
        for (uint256 index = 0; index < input.length; index++) {
            C_secondary.push(input[index]);
        }
    }

    function verifyPrimary(uint256 expectedA, uint256 expectedB, uint256 expectedC) public returns (bool) {
        (uint256 evalsA, uint256 evalsB, uint256 evalsC) = multiEvaluatePrimary();
        return verifyInner(evalsA, evalsB, evalsC, expectedA, expectedB, expectedC);
    }

    function verifySecondary(uint256 expectedA, uint256 expectedB, uint256 expectedC) public returns (bool) {
        (uint256 evalsA, uint256 evalsB, uint256 evalsC) = multiEvaluateSecondary();
        return verifyInner(evalsA, evalsB, evalsC, expectedA, expectedB, expectedC);
    }

    function multiEvaluateSecondary() private returns (uint256, uint256, uint256) {
        uint256[] memory T_x = EqPolinomialLib.evals(r_x_secondary, Pallas.P_MOD, Pallas.negateBase);
        uint256[] memory T_y = EqPolinomialLib.evals(r_y_secondary, Pallas.P_MOD, Pallas.negateBase);

        uint256 result_C_secondary = multiEvaluateInner(C_secondary, T_x, T_y, Pallas.P_MOD);
        uint256 result_B_secondary = multiEvaluateInner(B_secondary, T_x, T_y, Pallas.P_MOD);
        uint256 result_A_secondary = multiEvaluateInner(A_secondary, T_x, T_y, Pallas.P_MOD);

        return (result_A_secondary, result_B_secondary, result_C_secondary);
    }

    function multiEvaluatePrimary() private returns (uint256, uint256, uint256) {
        uint256[] memory T_x = EqPolinomialLib.evals(r_x_primary, Vesta.P_MOD, Vesta.negateBase);
        uint256[] memory T_y = EqPolinomialLib.evals(r_y_primary, Vesta.P_MOD, Vesta.negateBase);

        uint256 result_C_primary = multiEvaluateInner(C_primary, T_x, T_y, Vesta.P_MOD);
        uint256 result_B_primary = multiEvaluateInner(B_primary, T_x, T_y, Vesta.P_MOD);
        uint256 result_A_primary = multiEvaluateInner(A_primary, T_x, T_y, Vesta.P_MOD);

        return (result_A_primary, result_B_primary, result_C_primary);
    }

    function verifyInner(
        uint256 actualA,
        uint256 actualB,
        uint256 actualC,
        uint256 expectedA,
        uint256 expectedB,
        uint256 expectedC
    ) private pure returns (bool) {
        if (actualA != expectedA) {
            return false;
        }
        if (actualB != expectedB) {
            return false;
        }
        if (actualC != expectedC) {
            return false;
        }
        return true;
    }

    function multiEvaluateInner(MatrixData[] memory input, uint256[] memory T_x, uint256[] memory T_y, uint256 modulus)
        private
        pure
        returns (uint256)
    {
        uint256 result = 0;
        uint256 val = 0;
        uint256 T_row = 0;
        uint256 T_col = 0;

        for (uint256 i = 0; i < input.length; i++) {
            T_row = T_x[input[i].i];
            T_col = T_y[input[i].j];
            val = input[i].scalar;

            assembly {
                val := mulmod(T_row, val, modulus)
                val := mulmod(T_col, val, modulus)
                result := addmod(result, val, modulus)
            }
        }

        return result;
    }
}
