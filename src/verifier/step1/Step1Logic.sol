// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.0;

import "src/verifier/step1/Step1Data.sol";

library NovaVerifierStep1Lib {
    function verify(NovaVerifierStep1DataLib.CompressedSnarkStep1 memory proofDataStep1, uint256 numSteps)
        public
        pure
    {
        // check if number of steps is not zero
        require(numSteps != 0, "[numSteps != 0] ProofVerifyError");

        // check if the (relaxed) R1CS instances have two public outputs
        require(proofDataStep1.l_u_primary_X.length == 2, "[l_u_primary_X.length != 2] ProofVerifyError");
        require(proofDataStep1.l_u_secondary_X.length == 2, "[l_u_secondary_X.length != 2] ProofVerifyError");
        require(proofDataStep1.r_U_primary_X.length == 2, "[r_U_primary_X.length != 2] ProofVerifyError");
        require(proofDataStep1.r_U_secondary_X.length == 2, "[r_U_secondary_X.length != 2] ProofVerifyError");
    }
}
