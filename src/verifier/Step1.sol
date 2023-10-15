// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.0;

import "@std/Test.sol";
import "src/NovaVerifierAbstractions.sol";

library Step1Lib {
    function verify(Abstractions.CompressedSnark calldata proof, uint32 numSteps) public view returns (bool) {
        if (numSteps == 0) {
            console.log("[NovaError::ProofVerifyError] numSteps == 0");
            return false;
        }

        if (proof.l_u_secondary.X.length != 2) {
            console.log(
                "[NovaError::ProofVerifyError] proof.l_u_secondary.X.length != 2, actual: ",
                proof.l_u_secondary.X.length
            );
            return false;
        }

        if (proof.r_U_primary.X.length != 2) {
            console.log(
                "[NovaError::ProofVerifyError] proof.r_U_primary.X.length != 2, actual: ", proof.r_U_primary.X.length
            );
            return false;
        }

        if (proof.r_U_secondary.X.length != 2) {
            console.log(
                "[NovaError::ProofVerifyError] proof.r_U_secondary.X.length != 2, actual: ",
                proof.r_U_secondary.X.length
            );
            return false;
        }
        return true;
    }
}
