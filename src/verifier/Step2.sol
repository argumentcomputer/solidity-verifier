// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.16;

import "@std/Test.sol";
import "src/NovaVerifierAbstractions.sol";
import "src/blocks/poseidon/Sponge.sol";
import "src/blocks/pasta/Pallas.sol";
import "src/blocks/pasta/Vesta.sol";

library Step2Lib {
    uint256 private constant NUM_FE_WITHOUT_IO_FOR_CRHF = 17;
    uint32 private constant DOMAIN_SEPARATOR = 0;
    uint32 private constant SQUEEZE_NUM = 1;

    function verify(
        Abstractions.CompressedSnark calldata proof,
        Abstractions.VerifierKey calldata vk,
        uint32 numSteps,
        uint256[] calldata z0_primary,
        uint256[] calldata z0_secondary
    ) public view returns (bool) {
        if (!verifyPrimaryStep2(proof, vk, numSteps, z0_primary)) {
            console.log("[Step2 primary] false");
            return false;
        }

        if (!verifySecondaryStep2(proof, vk, numSteps, z0_secondary)) {
            console.log("[Step2 secondary] false");
            return false;
        }
        return true;
    }

    function verifyPrimaryStep2(
        Abstractions.CompressedSnark calldata proof,
        Abstractions.VerifierKey calldata vk,
        uint32 numSteps,
        uint256[] calldata z0_primary
    ) public view returns (bool) {
        // Compare first 25 mix / arc Poseidon constants from verifier key with expected ones
        if (
            !NovaSpongeVestaLib.constantsAreEqual(
                vk.ro_consts_secondary.mixConstants, vk.ro_consts_secondary.addRoundConstants
            )
        ) {
            console.log("[verifyPrimary] WrongVestaPoseidonConstantsError");
            return false;
        }

        uint256 counter = 0;
        uint256 i = 0;

        uint256[] memory elementsToHash = new uint256[](NUM_FE_WITHOUT_IO_FOR_CRHF + 2 * vk.f_arity_primary);
        elementsToHash[counter] = vk.digest;
        counter++;

        elementsToHash[counter] = uint256(numSteps);
        counter++;

        for (i = 0; i < z0_primary.length; i++) {
            elementsToHash[counter] = z0_primary[i];
            counter++;
        }

        for (i = 0; i < proof.zn_primary.length; i++) {
            elementsToHash[counter] = proof.zn_primary[i];
            counter++;
        }

        Vesta.VestaAffinePoint memory point;

        // decompress commW
        point = Vesta.decompress(proof.r_U_secondary.comm_W);

        elementsToHash[counter] = point.x;
        counter++;

        elementsToHash[counter] = point.y;
        counter++;

        elementsToHash[counter] = 0; // z coordinate is expected to be zero after uncompressing
        counter++;

        // decompress commE
        point = Vesta.decompress(proof.r_U_secondary.comm_E);

        elementsToHash[counter] = point.x;
        counter++;

        elementsToHash[counter] = point.y;
        counter++;

        elementsToHash[counter] = 0; // z coordinate is expected to be zero after uncompressing
        counter++;

        elementsToHash[counter] = proof.r_U_secondary.u;
        counter++;

        for (i = 0; i < proof.r_U_secondary.X.length; i++) {
            elementsToHash[counter] =
                (0x000000000000000000000000000000000000000000000000ffffffffffffffff & proof.r_U_secondary.X[i]);
            counter++;
            elementsToHash[counter] =
                (0x00000000000000000000000000000000ffffffffffffffff0000000000000000 & proof.r_U_secondary.X[i]) >> 64;
            counter++;
            elementsToHash[counter] =
                (0x0000000000000000ffffffffffffffff00000000000000000000000000000000 & proof.r_U_secondary.X[i]) >> 128;
            counter++;
            elementsToHash[counter] =
                (0xffffffffffffffff000000000000000000000000000000000000000000000000 & proof.r_U_secondary.X[i]) >> 192;
            counter++;
        }

        // Step2 execution (compare Vesta-based Poseidon hashes)
        SpongeOpLib.SpongeOp memory absorb = SpongeOpLib.SpongeOp(SpongeOpLib.SpongeOpType.Absorb, uint32(counter));
        SpongeOpLib.SpongeOp memory squeeze = SpongeOpLib.SpongeOp(SpongeOpLib.SpongeOpType.Squeeze, SQUEEZE_NUM);
        SpongeOpLib.SpongeOp[] memory pattern = new SpongeOpLib.SpongeOp[](2);
        pattern[0] = absorb;
        pattern[1] = squeeze;

        NovaSpongeVestaLib.SpongeU24Vesta memory sponge =
            NovaSpongeVestaLib.start(IOPatternLib.IOPattern(pattern), DOMAIN_SEPARATOR);
        sponge = NovaSpongeVestaLib.absorb(sponge, elementsToHash);
        (, uint256[] memory output) = NovaSpongeVestaLib.squeeze(sponge, SQUEEZE_NUM);
        sponge = NovaSpongeVestaLib.finishNoFinalIOCounterCheck(sponge);

        // in Nova only 250 bits of output hash are significant
        if (
            (output[0] & 0x03ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) != proof.l_u_secondary.X[0]
        ) {
            console.log("[Vesta Poseidon hash mismatch (verifyPrimary)] ProofVerifyError");
            return false;
        }
        return true;
    }

    function verifySecondaryStep2(
        Abstractions.CompressedSnark calldata proof,
        Abstractions.VerifierKey calldata vk,
        uint32 numSteps,
        uint256[] calldata z0_secondary
    ) public view returns (bool) {
        // Compare first 25 mix / arc Poseidon constants from verifier key with expected ones
        if (
            !NovaSpongePallasLib.constantsAreEqual(
                vk.ro_consts_primary.mixConstants, vk.ro_consts_primary.addRoundConstants
            )
        ) {
            console.log("[verifySecondary] WrongPallasPoseidonConstantsError");
            return false;
        }

        uint256 counter = 0;
        uint256 i = 0;

        uint256[] memory elementsToHash = new uint256[](NUM_FE_WITHOUT_IO_FOR_CRHF + 2 * vk.f_arity_secondary);
        elementsToHash[counter] = vk.digest;
        counter++;

        elementsToHash[counter] = uint256(numSteps);
        counter++;

        for (i = 0; i < z0_secondary.length; i++) {
            elementsToHash[counter] = z0_secondary[i];
            counter++;
        }

        for (i = 0; i < proof.zn_secondary.length; i++) {
            elementsToHash[counter] = proof.zn_secondary[i];
            counter++;
        }

        Pallas.PallasAffinePoint memory point;
        // decompress commW
        point = Pallas.decompress(proof.r_U_primary.comm_W);

        elementsToHash[counter] = point.x;
        counter++;

        elementsToHash[counter] = point.y;
        counter++;

        elementsToHash[counter] = 0; // z coordinate is expected to be zero if after uncompressing
        counter++;

        // decompress commE
        point = Pallas.decompress(proof.r_U_primary.comm_E);

        elementsToHash[counter] = point.x;
        counter++;

        elementsToHash[counter] = point.y;
        counter++;

        elementsToHash[counter] = 0; // z coordinate is expected to be zero if after uncompressing
        counter++;

        elementsToHash[counter] = proof.r_U_primary.u;
        counter++;

        for (i = 0; i < proof.r_U_primary.X.length; i++) {
            elementsToHash[counter] =
                (0x000000000000000000000000000000000000000000000000ffffffffffffffff & proof.r_U_primary.X[i]);
            counter++;
            elementsToHash[counter] =
                (0x00000000000000000000000000000000ffffffffffffffff0000000000000000 & proof.r_U_primary.X[i]) >> 64;
            counter++;
            elementsToHash[counter] =
                (0x0000000000000000ffffffffffffffff00000000000000000000000000000000 & proof.r_U_primary.X[i]) >> 128;
            counter++;
            elementsToHash[counter] =
                (0xffffffffffffffff000000000000000000000000000000000000000000000000 & proof.r_U_primary.X[i]) >> 192;
            counter++;
        }

        // Step2 execution (compare Pallas-based Poseidon hashes)
        SpongeOpLib.SpongeOp memory absorb = SpongeOpLib.SpongeOp(SpongeOpLib.SpongeOpType.Absorb, uint32(counter));
        SpongeOpLib.SpongeOp memory squeeze = SpongeOpLib.SpongeOp(SpongeOpLib.SpongeOpType.Squeeze, SQUEEZE_NUM);
        SpongeOpLib.SpongeOp[] memory pattern = new SpongeOpLib.SpongeOp[](2);
        pattern[0] = absorb;
        pattern[1] = squeeze;

        NovaSpongePallasLib.SpongeU24Pallas memory sponge =
            NovaSpongePallasLib.start(IOPatternLib.IOPattern(pattern), DOMAIN_SEPARATOR);

        sponge = NovaSpongePallasLib.absorb(sponge, elementsToHash);

        (, uint256[] memory output) = NovaSpongePallasLib.squeeze(sponge, SQUEEZE_NUM);
        sponge = NovaSpongePallasLib.finishNoFinalIOCounterCheck(sponge);

        // in Nova only 250 bits of output hash are significant
        if (
            (output[0] & 0x03ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) != proof.l_u_secondary.X[1]
        ) {
            console.log("[Pallas Poseidon hash mismatch (verifyPrimary)] ProofVerifyError");
            return false;
        }
        return true;
    }
}
