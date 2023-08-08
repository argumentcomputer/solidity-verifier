// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.16;

import "@std/Test.sol";
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

    function verify() public pure returns (bool) {
        return true;
    }
}
