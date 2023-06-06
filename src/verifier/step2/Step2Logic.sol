// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.0;

import "src/verifier/step2/Step2Data.sol";
import "src/poseidon/Sponge.sol";
import "@std/Test.sol";

library NovaVerifierStep2Lib {

    uint256 private constant NUM_FE_WITHOUT_IO_FOR_CRHF = 17;

    // uses Pallas-based Poseidon
    function verifySecondary(PoseidonConstants.Pallas memory constants, NovaVerifierStep2DataLib.CompressedSnarkStep2Secondary memory proofDataStep2Secondary, NovaVerifierStep2DataLib.VerifierKeyStep2 memory vkStep2, uint32 numSteps, uint256[] memory z0_secondary) public pure {
        // Compare first 25 mix / arc Poseidon constants from verifier key with expected ones
        require(NovaSpongePallasLib.constantsAreEqual(constants.mixConstants, constants.addRoundConstants), "[verifySecondary] WrongPallasPoseidonConstantsError");

        // check if the output secondary hash in R1CS instances point to the right running instance
        uint256 elementsToHashLength = NUM_FE_WITHOUT_IO_FOR_CRHF + 2 * vkStep2.f_arity_secondary;
        uint256 counter = 0;

        uint256[] memory elementsToHash = new uint256[](elementsToHashLength);
        elementsToHash[counter] = vkStep2.r1cs_shape_primary_digest;
        counter++;

        elementsToHash[counter] = uint256(numSteps);
        counter++;

        for (uint256 i = 0; i < z0_secondary.length; i++) {
            elementsToHash[counter] = z0_secondary[i];
            counter++;
        }

        for (uint256 i = 0; i < proofDataStep2Secondary.zn_secondary.length; i++) {
            elementsToHash[counter] = proofDataStep2Secondary.zn_secondary[i];
            counter++;
        }

        elementsToHash[counter] = proofDataStep2Secondary.r_U_primary.comm_W.X;
        counter++;

        elementsToHash[counter] = proofDataStep2Secondary.r_U_primary.comm_W.Y;
        counter++;

        elementsToHash[counter] = proofDataStep2Secondary.r_U_primary.comm_W.Z;
        counter++;

        elementsToHash[counter] = proofDataStep2Secondary.r_U_primary.comm_E.X;
        counter++;

        elementsToHash[counter] = proofDataStep2Secondary.r_U_primary.comm_E.Y;
        counter++;

        elementsToHash[counter] = proofDataStep2Secondary.r_U_primary.comm_E.Z;
        counter++;

        elementsToHash[counter] = proofDataStep2Secondary.r_U_primary.u;
        counter++;

        for (uint256 i = 0; i < proofDataStep2Secondary.r_U_primary.X.length; i++) {
            elementsToHash[counter] = proofDataStep2Secondary.r_U_primary.X[i];
            counter++;
        }

        // Step2 execution (compare Pallas-based Poseidon hashes)
        uint32 absorbLen = uint32(counter);
        uint32 sqeezeLen = 1;
        uint32 domainSeparator = 0;

        SpongeOpLib.SpongeOp memory absorb = SpongeOpLib.SpongeOp(SpongeOpLib.SpongeOpType.Absorb, absorbLen);
        SpongeOpLib.SpongeOp memory squeeze = SpongeOpLib.SpongeOp(SpongeOpLib.SpongeOpType.Squeeze, sqeezeLen);
        SpongeOpLib.SpongeOp[] memory pattern = new SpongeOpLib.SpongeOp[](2);
        pattern[0] = absorb;
        pattern[1] = squeeze;
        IOPatternLib.IOPattern memory p = IOPatternLib.IOPattern(pattern);

        NovaSpongePallasLib.SpongeU24Pallas memory sponge = NovaSpongePallasLib.start(p, domainSeparator);

        sponge = NovaSpongePallasLib.absorb(sponge, elementsToHash);

        (, uint256[] memory output) = NovaSpongePallasLib.squeeze(sponge, sqeezeLen);
        sponge = NovaSpongePallasLib.finishNoFinalIOCounterCheck(sponge);

        // in Nova only 250 bits of output hash are significant
        require((output[0] & 0x07ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) == proofDataStep2Secondary.expected_l_u_secondary_X_1, "[Pallas Poseidon hash mismatch (verifySecondary)] ProofVerifyError");
    }

    // uses Vesta-based Poseidon
    function verifyPrimary(PoseidonConstants.Vesta memory constants, NovaVerifierStep2DataLib.CompressedSnarkStep2Primary memory proofDataStep2Primary, NovaVerifierStep2DataLib.VerifierKeyStep2 memory vkStep2, uint32 numSteps, uint256[] memory z0_primary) public view {
        // Compare first 25 mix / arc Poseidon constants from verifier key with expected ones
        require(NovaSpongeVestaLib.constantsAreEqual(constants.mixConstants, constants.addRoundConstants), "[verifyPrimary] WrongVestaPoseidonConstantsError");

        // check if the output primary hash in R1CS instances point to the right running instance
        uint256 elementsToHashLength = NUM_FE_WITHOUT_IO_FOR_CRHF + 2 * vkStep2.f_arity_primary;
        uint256 counter = 0;

        uint256[] memory elementsToHash = new uint256[](elementsToHashLength);
        elementsToHash[counter] = vkStep2.r1cs_shape_secondary_digest;
        counter++;

        elementsToHash[counter] = uint256(numSteps);
        counter++;

        for (uint256 i = 0; i < z0_primary.length; i++) {
            elementsToHash[counter] = z0_primary[i];
            counter++;
        }

        for (uint256 i = 0; i < proofDataStep2Primary.zn_primary.length; i++) {
            elementsToHash[counter] = proofDataStep2Primary.zn_primary[i];
            counter++;
        }

        elementsToHash[counter] = proofDataStep2Primary.r_U_secondary.comm_W.X;
        counter++;

        elementsToHash[counter] = proofDataStep2Primary.r_U_secondary.comm_W.Y;
        counter++;

        elementsToHash[counter] = proofDataStep2Primary.r_U_secondary.comm_W.Z;
        counter++;

        elementsToHash[counter] = proofDataStep2Primary.r_U_secondary.comm_E.X;
        counter++;

        elementsToHash[counter] = proofDataStep2Primary.r_U_secondary.comm_E.Y;
        counter++;

        elementsToHash[counter] = proofDataStep2Primary.r_U_secondary.comm_E.Z;
        counter++;

        elementsToHash[counter] = proofDataStep2Primary.r_U_secondary.u;
        counter++;

        for (uint256 i = 0; i < proofDataStep2Primary.r_U_secondary.X.length; i++) {
            elementsToHash[counter] = proofDataStep2Primary.r_U_secondary.X[i];
            counter++;
        }

        // Step2 execution (compare Vesta-based Poseidon hashes)
        uint32 absorbLen = uint32(counter);
        uint32 sqeezeLen = 1;
        uint32 domainSeparator = 0;

        SpongeOpLib.SpongeOp memory absorb = SpongeOpLib.SpongeOp(SpongeOpLib.SpongeOpType.Absorb, absorbLen);
        SpongeOpLib.SpongeOp memory squeeze = SpongeOpLib.SpongeOp(SpongeOpLib.SpongeOpType.Squeeze, sqeezeLen);
        SpongeOpLib.SpongeOp[] memory pattern = new SpongeOpLib.SpongeOp[](2);
        pattern[0] = absorb;
        pattern[1] = squeeze;
        IOPatternLib.IOPattern memory p = IOPatternLib.IOPattern(pattern);

        NovaSpongeVestaLib.SpongeU24Vesta memory sponge = NovaSpongeVestaLib.start(p, domainSeparator);


        sponge = NovaSpongeVestaLib.absorb(sponge, elementsToHash);

        (, uint256[] memory output) = NovaSpongeVestaLib.squeeze(sponge, sqeezeLen);
        sponge = NovaSpongeVestaLib.finishNoFinalIOCounterCheck(sponge);

        // in Nova only 250 bits of output hash are significant
        require((output[0] & 0x07ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) == proofDataStep2Primary.expected_l_u_primary_X_1, "[Vesta Poseidon hash mismatch (verifyPrimary)] ProofVerifyError");
    }
}
