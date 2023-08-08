// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.16;

import "@std/Test.sol";
import "src/verifier/Step1.sol";
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

    function verify(uint32 numSteps) public view returns (bool) {
        // Step 1:
        // - checks that number of steps cannot be zero (https://github.com/lurk-lab/Nova/blob/solidity-verifier-pp-spartan/src/lib.rs#L680)
        // - check if the (relaxed) R1CS instances have two public outputs (https://github.com/lurk-lab/Nova/blob/solidity-verifier-pp-spartan/src/lib.rs#L688)
        if (!Step1Lib.verify(proof, numSteps)) {
            console.log("[Step1] false");
            return false;
        }
        return true;
    }
}
