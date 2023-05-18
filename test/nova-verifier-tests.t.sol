// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@std/Test.sol";
import "src/verifier/step1/Step1Logic.sol";
import "src/verifier/step1/Step1Data.sol";
import "src/verifier/step2/Step2Logic.sol";
import "src/verifier/step2/Step2Data.sol";
import "src/poseidon/Sponge.sol";


contract NovaVerifierContractTest is Test {
    function testVerificationStep1() public pure {
        NovaVerifierStep1Lib.VerifierKeyStep1 memory verifierKeyStep1 = NovaVerifierStep1Lib.loadVerifierKeyStep1();

        uint256[] memory r_u_primary_X = NovaVerifierStep1DataLib.get_r_u_primary_X();

        uint256[] memory l_u_primary_X = NovaVerifierStep1DataLib.get_l_u_primary_X();

        uint256[] memory r_u_secondary_X = NovaVerifierStep1DataLib.get_r_u_secondary_X();

        uint256[] memory l_u_secondary_X = NovaVerifierStep1DataLib.get_l_u_secondary_X();

        NovaVerifierStep1Lib.CompressedSnarkStep1 memory proofDataStep1 = NovaVerifierStep1Lib.loadCompressedSnarkStep1(l_u_primary_X, l_u_secondary_X, r_u_primary_X, r_u_secondary_X);

        uint32 numSteps = 3;

        NovaVerifierStep1Lib.verify(proofDataStep1, verifierKeyStep1, numSteps);
    }

    function testVerificationStep2() public {
        uint32 numSteps = 3;
        uint256[] memory z0_primary = new uint256[](1);
        z0_primary[0] = 1;

        uint256[] memory z0_secondary = new uint256[](1);
        z0_secondary[0] = 0;

        NovaVerifierStep2DataLib.CompressedSnarkStep2Primary memory proofDataPrimary = NovaVerifierStep2DataLib.getCompressedSnarkStep2Primary();
        NovaVerifierStep2DataLib.CompressedSnarkStep2Secondary memory proofDataSecondary = NovaVerifierStep2DataLib.getCompressedSnarkStep2Secondary();
        NovaVerifierStep2DataLib.VerifierKeyStep2 memory vk = NovaVerifierStep2DataLib.getVerifierKeyStep2();
        (PoseidonConstants.Pallas memory pallasConstants, PoseidonConstants.Vesta memory vestaConstants) = PoseidonConstants.getPoseidonConstantsForBasicComparison();


        NovaVerifierStep2Lib.verifyPrimary(vestaConstants, proofDataPrimary, vk, numSteps, z0_primary);
        NovaVerifierStep2Lib.verifySecondary(pallasConstants, proofDataSecondary, vk, numSteps, z0_secondary);
    }
}
