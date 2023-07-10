// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.0;

import "@std/Test.sol";
import "src/verifier/step1/Step1.sol";
import "src/NovaVerifierAbstractions.sol";

contract NovaVerifierContract {
    //VerifierKey public vk;
    Abstractions.CompressedSnark public proof;

    function pushToProof(Abstractions.CompressedSnark calldata input) public {
        proof = input;
    }

    function verify(uint32 numSteps, uint256[] calldata z0_primary, uint256[] calldata z0_secondary) public view returns (bool) {
        // number of steps cannot be zero
        if (!Step1Lib.verify(proof, numSteps, z0_primary, z0_secondary)) {
            console.log("[Step1] false");
            return false;
        }

        // check if the output hashes in R1CS instances point to the right running instances


        return true;
    }
}
