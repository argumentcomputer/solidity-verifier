// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.16;

import "@std/Test.sol";
import "src/verifier/Step1.sol";
import "src/verifier/Step2.sol";
import "src/NovaVerifierAbstractions.sol";

contract NovaVerifierContract {
    Abstractions.VerifierKey public vk;
    Abstractions.CompressedSnark public proof;

    function pushToProof(Abstractions.CompressedSnark calldata input) public {
        proof = input;
    }

    function pushToVk(Abstractions.VerifierKey calldata input) public {
        vk = input;
    }

    function verify(uint32 numSteps, uint256[] calldata z0_primary, uint256[] calldata z0_secondary)
        public
        view
        returns (bool)
    {
        // Step 1:
        // - checks that number of steps cannot be zero (https://github.com/lurk-lab/Nova/blob/solidity-verifier-pp-spartan/src/lib.rs#L680)
        // - checks if the (relaxed) R1CS instances have two public outputs (https://github.com/lurk-lab/Nova/blob/solidity-verifier-pp-spartan/src/lib.rs#L688)
        if (!Step1Lib.verify(proof, numSteps)) {
            console.log("[Step1] false");
            return false;
        }

        // Step 2:
        // - checks if the output hashes in R1CS instances point to the right running instances (https://github.com/lurk-lab/Nova/blob/solidity-verifier-pp-spartan/src/lib.rs#L730)
        if (!Step2Lib.verify(proof, vk, numSteps, z0_primary, z0_secondary)) {
            console.log("[Step2] false");
            return false;
        }
        return true;
    }
}
