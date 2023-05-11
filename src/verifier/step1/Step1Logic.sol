// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

library NovaVerifierStep1Lib {
    // relevant part of CompressedSnark
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
    ) public returns (CompressedSnarkStep1 memory) {
        return CompressedSnarkStep1(l_u_primary_X, l_u_secondary_X, r_U_primary_X, r_U_secondary_X);
    }

    function loadVerifierKeyStep1() public returns (VerifierKeyStep1 memory) {
        return VerifierKeyStep1(0);
    }

    function verify(CompressedSnarkStep1 memory proofDataStep1, VerifierKeyStep1 memory vkStep1, uint32 numSteps) public {
        // check if number of steps is not zero
        require(numSteps != 0, "ProofVerifyError");

        // check if the (relaxed) R1CS instances have two public outputs
        require(proofDataStep1.l_u_primary_X.length == 2, "ProofVerifyError");
        require(proofDataStep1.l_u_secondary_X.length == 2, "ProofVerifyError");
        require(proofDataStep1.r_U_primary_X.length == 2, "ProofVerifyError");
        require(proofDataStep1.r_U_secondary_X.length == 2, "ProofVerifyError");
    }
}
