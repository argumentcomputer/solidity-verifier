// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.16;

library NovaVerifierStep1Lib {
    struct CompressedSnarkStep1 {
        uint256[] l_u_primary_X;
        uint256[] l_u_secondary_X;
        uint256[] r_U_primary_X;
        uint256[] r_U_secondary_X;
    }

    struct VerifierKeyStep1 {
        uint256 stub;
    }

    function loadCompressedSnarkStep1(
        uint256[] memory l_u_primary_X,
        uint256[] memory l_u_secondary_X,
        uint256[] memory r_U_primary_X,
        uint256[] memory r_U_secondary_X
    ) public pure returns (CompressedSnarkStep1 memory) {
        return CompressedSnarkStep1(l_u_primary_X, l_u_secondary_X, r_U_primary_X, r_U_secondary_X);
    }

    function loadVerifierKeyStep1() public pure returns (VerifierKeyStep1 memory) {
        return VerifierKeyStep1(0);
    }

    function verify(CompressedSnarkStep1 memory proofDataStep1, VerifierKeyStep1 memory, uint32 numSteps) public pure {
        // check if number of steps is not zero
        require(numSteps != 0, "[numSteps != 0] ProofVerifyError");

        // check if the (relaxed) R1CS instances have two public outputs
        require(proofDataStep1.l_u_primary_X.length == 2, "[l_u_primary_X.length != 2] ProofVerifyError");
        require(proofDataStep1.l_u_secondary_X.length == 2, "[l_u_secondary_X.length != 2] ProofVerifyError");
        require(proofDataStep1.r_U_primary_X.length == 2, "[r_U_primary_X.length != 2] ProofVerifyError");
        require(proofDataStep1.r_U_secondary_X.length == 2, "[r_U_secondary_X.length != 2] ProofVerifyError");
    }
}
