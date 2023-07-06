// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.0;

import "@std/Test.sol";
import "src/pasta/Pallas.sol";
import "src/pasta/Vesta.sol";
import "src/verifier/step4/EqPolynomial.sol";

contract StorageContract {
    struct Triple {
        uint256 index1;
        uint256 index2;
        uint256 scalar;
    }

    uint256[] public r_x;
    uint256[] public r_y;

    Triple[] public A;
    Triple[] public B;
    Triple[] public C;

    function pushToRx(uint256 input) public {
        r_x.push(input);
    }

    function pushToRy(uint256 input) public {
        r_y.push(input);
    }

    function pushToA(Triple[] calldata input) public {
        for (uint256 index = 0; index < input.length; index++) {
            A.push(input[index]);
        }
    }

    function pushToB(Triple[] calldata input) public {
        for (uint256 index = 0; index < input.length; index++) {
            B.push(input[index]);
        }
    }

    function pushToC(Triple[] calldata input) public {
        for (uint256 index = 0; index < input.length; index++) {
            C.push(input[index]);
        }
    }

    function verifyLengths(
        uint32 expectedLengthA,
        uint32 expectedLengthB,
        uint32 expectedLengthC,
        uint32 expectedLengthRx,
        uint32 expectedLengthRy
    ) public view returns (bool) {
        if (expectedLengthA != A.length) {
            return false;
        }
        if (expectedLengthB != B.length) {
            return false;
        }
        if (expectedLengthC != C.length) {
            return false;
        }
        if (expectedLengthC != C.length) {
            return false;
        }
        if (expectedLengthRx != r_x.length) {
            return false;
        }
        if (expectedLengthRy != r_y.length) {
            return false;
        }
        return true;
    }

    function verify(uint256 expectedA, uint256 expectedB, uint256 expectedC) public view returns (bool) {
        console.log("expected:");
        console.logBytes32(bytes32(expectedA));
        console.logBytes32(bytes32(expectedB));
        console.logBytes32(bytes32(expectedC));

        (uint256 evalsA, uint256 evalsB, uint256 evalsC) = multiEvaluatePrimary();

        console.log("actual:");
        console.logBytes32(bytes32(evalsA));
        console.logBytes32(bytes32(evalsB));
        console.logBytes32(bytes32(evalsC));

        if (evalsA != expectedA) {
            return false;
        }

        if (evalsB != expectedB) {
            return false;
        }

        if (evalsC != expectedC) {
            return false;
        }

        return true;
    }

    function multiEvaluatePrimary() private view returns (uint256, uint256, uint256) {
        uint256[] memory T_x = EqPolinomialLib.evalsVesta(r_x);
        uint256[] memory T_y = EqPolinomialLib.evalsVesta(r_y);

        console.log("[multiEvaluatePrimary] Tx, Ty, C hashes:");
        console.logBytes32(bytes32(keccak256(abi.encodePacked(T_x))));
        console.logBytes32(bytes32(keccak256(abi.encodePacked(T_y))));

        uint256 cumulativeCDataIndex = 0;
        uint256[] memory cumulativeCData = new uint256[](3 * C.length);
        console.log("##############################");
        for (uint256 index = C.length / 16; index < C.length / 8; index++) {
            //if (index < 10) {
            console.logBytes32(bytes32(C[index].scalar));
            //}
            cumulativeCData[cumulativeCDataIndex] = C[index].index1;
            cumulativeCDataIndex++;
            cumulativeCData[cumulativeCDataIndex] = C[index].index2;
            cumulativeCDataIndex++;
            cumulativeCData[cumulativeCDataIndex] = C[index].scalar;
            cumulativeCDataIndex++;
        }
        console.log("##############################");
        console.logBytes32(bytes32(keccak256(abi.encodePacked(cumulativeCData))));



        uint256 result_C = multiEvaluatePrimaryInner(C, T_x, T_y);

        uint256 result_B = multiEvaluatePrimaryInner(B, T_x, T_y);

        uint256 result_A = multiEvaluatePrimaryInner(A, T_x, T_y);

        return (result_A, result_B, result_C);
    }

    function multiEvaluatePrimaryInner(Triple[] memory input, uint256[] memory T_x, uint256[] memory T_y)
        private
        pure
        returns (uint256)
    {
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
}
