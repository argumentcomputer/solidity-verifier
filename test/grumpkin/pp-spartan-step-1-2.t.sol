// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.16;

import "@std/Test.sol";
import "src/NovaVerifierAbstractions.sol";
import "src/verifier/Step1.sol";
import "src/verifier/Step2Grumpkin.sol";
import "test/utils.t.sol";

contract PpSpartanStep1Step2Computations is Test {
    function testStep1() public view {
        Abstractions.CompressedSnark memory proof = TestUtilities.loadProof();
        uint32 numSteps = 3;
        assert(Step1Lib.verify(proof, numSteps)); // can be reused
    }

    function testStep2() public view {
        Abstractions.CompressedSnark memory proof = TestUtilities.loadProof();
        Abstractions.VerifierKey memory vk = TestUtilities.loadPublicParameters();
        uint32 numSteps = 3;
        uint256[] memory z0_primary = new uint256[](1);
        z0_primary[0] = 0x0000000000000000000000000000000000000000000000000000000000000001;

        uint256[] memory z0_secondary = new uint256[](1);
        z0_secondary[0] = 0x0000000000000000000000000000000000000000000000000000000000000000;

        assert(Step2GrumpkinLib.verify(proof, vk, numSteps, z0_primary, z0_secondary));
    }
}
