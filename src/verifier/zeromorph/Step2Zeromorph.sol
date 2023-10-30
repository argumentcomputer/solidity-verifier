// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.16;

import "@std/Test.sol";
import "src/NovaVerifierAbstractions.sol";
import "src/blocks/poseidon/Sponge.sol";
import "src/blocks/grumpkin/Bn256.sol";
import "src/blocks/grumpkin/Grumpkin.sol";

import "test/utils.t.sol";

library Step2GrumpkinZeromorphLib {
    uint256 private constant NUM_FE_WITHOUT_IO_FOR_CRHF = 17;
    uint32 private constant DOMAIN_SEPARATOR = 0;
    uint32 private constant SQUEEZE_NUM = 1;

    function verify(
        Abstractions.CompressedSnark calldata proof,
        Abstractions.VerifierKeyZeromorph calldata vk,
        Abstractions.ROConstants calldata ro_consts_primary,
        Abstractions.ROConstants calldata ro_consts_secondary,
        uint32 numSteps,
        uint256[] calldata z0_primary,
        uint256[] calldata z0_secondary
    ) public view returns (bool) {
        PoseidonU24Optimized.PoseidonConstantsU24 memory constantsSecondary =
            PoseidonU24Optimized.newConstants(ro_consts_secondary);
        PoseidonU24Optimized.PoseidonConstantsU24 memory constantsPrimary =
            PoseidonU24Optimized.newConstants(ro_consts_primary);

        // Primary hasher uses secondary constants and vice versa according to Rust reference:
        // https://github.com/lurk-lab/arecibo/blob/dev/src/lib.rs#L553
        if (!verifyPrimaryStep2(proof, vk, constantsSecondary, numSteps, z0_primary)) {
            console.log("[Step2 primary] false");
            return false;
        }
        if (!verifySecondaryStep2(proof, vk, constantsPrimary, numSteps, z0_secondary)) {
            console.log("[Step2 secondary] false");
            return false;
        }
        return true;
    }

    function verifyPrimaryStep2(
        Abstractions.CompressedSnark calldata proof,
        Abstractions.VerifierKeyZeromorph calldata vk,
        PoseidonU24Optimized.PoseidonConstantsU24 memory constantsSecondary,
        uint32 numSteps,
        uint256[] calldata z0_primary
    ) public view returns (bool) {
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

        Grumpkin.GrumpkinAffinePoint memory point;

        // decompress commW
        point = Grumpkin.decompress(proof.r_U_secondary.comm_W); // Grumpkin

        elementsToHash[counter] = point.x;
        counter++;

        elementsToHash[counter] = point.y;
        counter++;

        elementsToHash[counter] = 0; // z coordinate is expected to be zero after uncompressing
        counter++;

        // decompress commE
        point = Grumpkin.decompress(proof.r_U_secondary.comm_E); // Grumpkin
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

        require(
            counter == elementsToHash.length, "[Poseidon:Optimized verifyPrimaryStep2] counter != elementsToHash.length"
        );

        uint256 output = hash(elementsToHash.length, elementsToHash, constantsSecondary, Bn256.R_MOD); // Bn256.R_MOD

        // in Nova only 250 bits of output hash are significant
        if ((output & 0x03ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) != proof.l_u_secondary.X[0]) {
            console.log("[Poseidon hash mismatch (verifyPrimary)] ProofVerifyError");
            return false;
        }
        return true;
    }

    function verifySecondaryStep2(
        Abstractions.CompressedSnark calldata proof,
        Abstractions.VerifierKeyZeromorph calldata vk,
        PoseidonU24Optimized.PoseidonConstantsU24 memory constantsPrimary,
        uint32 numSteps,
        uint256[] calldata z0_secondary
    ) public view returns (bool) {
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

        Bn256.Bn256AffinePoint memory point;
        // decompress commW
        point = Bn256.decompress(proof.r_U_primary.comm_W);

        elementsToHash[counter] = point.x;
        counter++;

        elementsToHash[counter] = point.y;
        counter++;

        elementsToHash[counter] = 0; // z coordinate is expected to be zero if after uncompressing
        counter++;

        // decompress commE
        point = Bn256.decompress(proof.r_U_primary.comm_E);

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

        require(
            counter == elementsToHash.length,
            "[Poseidon:Optimized verifySecondaryStep2] counter != elementsToHash.length"
        );

        uint256 output = hash(elementsToHash.length, elementsToHash, constantsPrimary, Grumpkin.P_MOD); // Grumpkin.P_MOD

        // in Nova only 250 bits of output hash are significant
        if ((output & 0x03ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) != proof.l_u_secondary.X[1]) {
            console.log("[Poseidon hash mismatch (verifySecondary)] ProofVerifyError");
            return false;
        }
        return true;
    }

    function hash(
        uint256 absorbLen,
        uint256[] memory elementsToHash,
        PoseidonU24Optimized.PoseidonConstantsU24 memory constants,
        uint256 modulus
    ) private pure returns (uint256) {
        SpongeOpLib.SpongeOp memory absorb = SpongeOpLib.SpongeOp(SpongeOpLib.SpongeOpType.Absorb, uint32(absorbLen));
        SpongeOpLib.SpongeOp memory squeeze = SpongeOpLib.SpongeOp(SpongeOpLib.SpongeOpType.Squeeze, SQUEEZE_NUM);
        SpongeOpLib.SpongeOp[] memory pattern = new SpongeOpLib.SpongeOp[](2);
        pattern[0] = absorb;
        pattern[1] = squeeze;

        NovaSpongeLib.SpongeU24 memory sponge =
            NovaSpongeLib.start(IOPatternLib.IOPattern(pattern), DOMAIN_SEPARATOR, constants);
        sponge = NovaSpongeLib.absorb(sponge, elementsToHash, modulus);

        uint256[] memory output;
        (sponge, output) = NovaSpongeLib.squeeze(sponge, SQUEEZE_NUM, modulus);

        return output[0];
    }
}
