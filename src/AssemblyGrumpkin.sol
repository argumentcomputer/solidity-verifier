// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.16;

import "@std/Test.sol";

contract AssemblyGrumpkinContract {
    uint64 internal constant L_U_SECONDARY_X_LENGTH_OFFSET = 32;
    uint64 internal constant R_U_PRIMARY_X_LENGTH_OFFSET = 192;
    uint64 internal constant R_U_SECONDARY_X_LENGTH_OFFSET = 384;

    bytes4 internal constant NUM_STEPS_IS_ZERO = 0xeba9f4a6;
    bytes4 internal constant L_U_SECONDARY_X_LENGHT_IS_NOT_TWO = 0xfe712642;
    bytes4 internal constant R_U_PRIMARY_X_LENGHT_IS_NOT_TWO = 0xeac6982d;
    bytes4 internal constant R_U_SECONDARY_X_LENGHT_IS_NOT_TWO = 0x246ba7de;

    function verify(
        bytes calldata proof,
        uint32 numSteps,
        uint256[] calldata z0_primary,
        uint256[] calldata z0_secondary
    ) public returns (bool result) {
        uint256 gasLeftCounter = gasleft();

        assembly {
            // Step 1 (checking if the (relaxed) R1CS instances have two public outputs)
            if iszero(numSteps) {
                mstore(0x00, NUM_STEPS_IS_ZERO)
                revert(0x00, 0x04)
            }
            let l_u_secondary_x_length := calldataload(add(proof.offset, L_U_SECONDARY_X_LENGTH_OFFSET))
            if iszero(eq(l_u_secondary_x_length, 2)) {
                mstore(0x00, L_U_SECONDARY_X_LENGHT_IS_NOT_TWO)
                revert(0x00, 0x04)
            }

            let r_U_primary_x_length := calldataload(add(proof.offset, R_U_PRIMARY_X_LENGTH_OFFSET))
            if iszero(eq(r_U_primary_x_length, 2)) {
                mstore(0x00, R_U_PRIMARY_X_LENGHT_IS_NOT_TWO)
                revert(0x00, 0x04)
            }

            let r_U_secondary_x_length := calldataload(add(proof.offset, R_U_SECONDARY_X_LENGTH_OFFSET))
            if iszero(eq(r_U_secondary_x_length, 2)) {
                mstore(0x00, R_U_PRIMARY_X_LENGHT_IS_NOT_TWO)
                revert(0x00, 0x04)
            }

            result := 0x01
        }

        uint256 tmp = gasleft();
        console.log("gas cost: ", gasLeftCounter - tmp);
    }
}
