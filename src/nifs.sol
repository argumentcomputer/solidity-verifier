// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "src/pasta/Pallas.sol";
import "src/pasta/Vesta.sol";
import "src/verifier/step2/Step2Data.sol";
import "src/poseidon/Sponge.sol";

library NIFSPallas {
    uint256 constant private MOD = Pallas.P_MOD;
    uint256 constant private NUM_FE_FOR_RO = 24; // <-- This seems strange, I'm only counting 15...

    struct NIFS {
        uint8[] compressed_comm_T;
    }

    struct R1CSInstance {
        Pallas.PallasAffinePoint comm_W;
        uint256[] X;
    }

    struct RelaxedR1CSInstance {
        Pallas.PallasAffinePoint comm_W;
        Pallas.PallasAffinePoint comm_E;
        uint256[] X;
        uint256 u;
    }

    function verify(
        NIFS memory nifs,
        PoseidonConstants.Pallas calldata ro_consts,
        uint256 pp_digest,
        RelaxedR1CSInstance calldata U1,
        R1CSInstance calldata U2
    ) public view returns (RelaxedR1CSInstance memory) {
        require(NovaSpongePallasLib.constantsAreEqual(ro_consts.mixConstants, ro_consts.addRoundConstants), "[verifySecondary] WrongPallasPoseidonConstantsError");

        uint256 counter = 0;

        uint256[] memory elementsToHash = new uint256[](NUM_FE_FOR_RO + U1.X.length + U2.X.length);

        elementsToHash[counter] = pp_digest;
        counter++;

        //U1.absorb_in_ro
        // Absorb comm_W
        elementsToHash[counter] = U1.comm_W.x;
        counter++;
        elementsToHash[counter] = U1.comm_W.y;
        counter++;
        if (Pallas.isInfinity(U1.comm_W)) {
            elementsToHash[counter] = 1;
        }
        else {
            elementsToHash[counter] = 0;
        }
        counter++;

        // Absorb comm_E
        elementsToHash[counter] = U1.comm_E.x;
        counter++;
        elementsToHash[counter] = U1.comm_E.y;
        counter++;
        if (Pallas.isInfinity(U1.comm_E)) {
            elementsToHash[counter] = 1;
        }
        else {
            elementsToHash[counter] = 0;
        }
        counter++;

        // Abosrb u
        elementsToHash[counter] = U1.u;
        counter++;

        // Absorb X
        for (uint256 i = 0; i < U1.X.length; i++) {
            elementsToHash[counter] = U1.X[i];
            counter++;
        }

        //U2.absorb_in_ro
        // Absorb comm_W
        elementsToHash[counter] = U2.comm_W.x;
        counter++;
        elementsToHash[counter] = U2.comm_W.y;
        counter++;
        if (Pallas.isInfinity(U2.comm_W)) {
            elementsToHash[counter] = 1;
        }
        else {
            elementsToHash[counter] = 0;
        }
        counter++;

        // Absorb X
        for (uint256 i = 0; i < U2.X.length; i++) {
            elementsToHash[counter] = U2.X[i];
            counter++;
        }

        // Absorb comm_T
        Pallas.PallasAffinePoint memory comm_T = Pallas.decompress(nifs.compressed_comm_T);
        elementsToHash[counter] = comm_T.x;
        counter++;
        elementsToHash[counter] = comm_T.y;
        counter++;
        if (Pallas.isInfinity(comm_T)) {
            elementsToHash[counter] = 1;
        }
        else {
            elementsToHash[counter] = 0;
        }
        counter++;

        // uint32 absorbLen = uint32(counter);
        // uint32 squeezeLen = 1;
        // uint32 domainSeparator = 0;

        SpongeOpLib.SpongeOp memory absorb = SpongeOpLib.SpongeOp(SpongeOpLib.SpongeOpType.Absorb, uint32(counter));
        SpongeOpLib.SpongeOp memory squeeze = SpongeOpLib.SpongeOp(SpongeOpLib.SpongeOpType.Squeeze, 1);
        SpongeOpLib.SpongeOp[] memory pattern = new SpongeOpLib.SpongeOp[](2);
        pattern[0] = absorb;
        pattern[1] = squeeze;
        IOPatternLib.IOPattern memory p = IOPatternLib.IOPattern(pattern);

        NovaSpongePallasLib.SpongeU24Pallas memory sponge = NovaSpongePallasLib.start(p, 0);

        sponge = NovaSpongePallasLib.absorb(sponge, elementsToHash);

        (, uint256[] memory output) = NovaSpongePallasLib.squeeze(sponge, 1);
        sponge = NovaSpongePallasLib.finishNoFinalIOCounterCheck(sponge);

        // uint256 r = output[0] & 0x07ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff;

        RelaxedR1CSInstance memory result = foldInstance(U1, U2, comm_T, output[0] & 0x07ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff);

        return result;
    }

    function foldInstance(
        RelaxedR1CSInstance calldata U1,
        R1CSInstance calldata u2,
        Pallas.PallasAffinePoint memory comm_T,
        uint256 r
    ) public view returns (RelaxedR1CSInstance memory) {
        // uint256[] memory x1 = U1.X;
        // Pallas.PallasAffinePoint memory comm_W_1 = U1.comm_W;
        // Pallas.PallasAffinePoint memory comm_E_1 = U1.comm_E;
        // uint256 u1 = U1.u;

        uint256[] memory x2 = u2.X;
        Pallas.PallasAffinePoint memory comm_W_2 = u2.comm_W;

        require(U1.X.length == x2.length, "Witness vectors do not match length");

        uint256[] memory X = new uint256[](U1.X.length);

        for (uint256 i = 0; i < x2.length; i++) {
            X[i] = U1.X[i] + r * x2[i];
        }

        // Pallas.PallasAffinePoint memory comm_W = Pallas.add(comm_W_1, Pallas.scalarMul(comm_W_2, r));

        // Pallas.PallasAffinePoint memory comm_E = Pallas.add(comm_E_1, Pallas.scalarMul(comm_T, r));

        // uint256 u = u1 + r;

        return RelaxedR1CSInstance(Pallas.add(U1.comm_E, Pallas.scalarMul(comm_T, r)) , Pallas.add(U1.comm_W, Pallas.scalarMul(comm_W_2, r)) , X, U1.u + r);
    }
}

library NIFSVesta {
    uint256 constant private MOD = Vesta.P_MOD;
    uint256 constant private NUM_FE_FOR_RO = 24; // <--- Same here

    struct NIFS {
        uint8[] compressed_comm_T;
    }

    struct R1CSInstance {
        Vesta.VestaAffinePoint comm_W;
        uint256[] X;
    }

    struct RelaxedR1CSInstance {
        Vesta.VestaAffinePoint comm_W;
        Vesta.VestaAffinePoint comm_E;
        uint256[] X;
        uint256 u;
    }

    function verify(
        NIFS memory nifs,
        PoseidonConstants.Vesta calldata ro_consts,
        uint256 pp_digest,
        RelaxedR1CSInstance calldata U1,
        R1CSInstance calldata U2
    ) public view returns (RelaxedR1CSInstance memory) {
        require(NovaSpongeVestaLib.constantsAreEqual(ro_consts.mixConstants, ro_consts.addRoundConstants), "[verifySecondary] WrongVestaPoseidonConstantsError");

        uint256 counter = 0;

        uint256[] memory elementsToHash = new uint256[](NUM_FE_FOR_RO + U1.X.length + U2.X.length);

        elementsToHash[counter] = pp_digest;
        counter++;

        //U1.absorb_in_ro
        // Absorb comm_W
        elementsToHash[counter] = U1.comm_W.x;
        counter++;
        elementsToHash[counter] = U1.comm_W.y;
        counter++;
        if (Vesta.isInfinity(U1.comm_W)) {
            elementsToHash[counter] = 1;
        }
        else {
            elementsToHash[counter] = 0;
        }
        counter++;

        // Absorb comm_E
        elementsToHash[counter] = U1.comm_E.x;
        counter++;
        elementsToHash[counter] = U1.comm_E.y;
        counter++;
        if (Vesta.isInfinity(U1.comm_E)) {
            elementsToHash[counter] = 1;
        }
        else {
            elementsToHash[counter] = 0;
        }
        counter++;

        // Abosrb u
        elementsToHash[counter] = U1.u;
        counter++;

        // Absorb X
        for (uint256 i = 0; i < U1.X.length; i++) {
            elementsToHash[counter] = U1.X[i];
            counter++;
        }

        //U2.absorb_in_ro
        // Absorb comm_W
        elementsToHash[counter] = U2.comm_W.x;
        counter++;
        elementsToHash[counter] = U2.comm_W.y;
        counter++;
        if (Vesta.isInfinity(U2.comm_W)) {
            elementsToHash[counter] = 1;
        }
        else {
            elementsToHash[counter] = 0;
        }
        counter++;

        // Absorb X
        for (uint256 i = 0; i < U2.X.length; i++) {
            elementsToHash[counter] = U2.X[i];
            counter++;
        }

        // Absorb comm_T
        Vesta.VestaAffinePoint memory comm_T = Vesta.decompress(nifs.compressed_comm_T);
        elementsToHash[counter] = comm_T.x;
        counter++;
        elementsToHash[counter] = comm_T.y;
        counter++;
        if (Vesta.isInfinity(comm_T)) {
            elementsToHash[counter] = 1;
        }
        else {
            elementsToHash[counter] = 0;
        }
        counter++;

        // uint32 absorbLen = uint32(counter);
        // uint32 squeezeLen = 1;
        // uint32 domainSeparator = 0;

        SpongeOpLib.SpongeOp memory absorb = SpongeOpLib.SpongeOp(SpongeOpLib.SpongeOpType.Absorb, uint32(counter));
        SpongeOpLib.SpongeOp memory squeeze = SpongeOpLib.SpongeOp(SpongeOpLib.SpongeOpType.Squeeze, 1);
        SpongeOpLib.SpongeOp[] memory pattern = new SpongeOpLib.SpongeOp[](2);
        pattern[0] = absorb;
        pattern[1] = squeeze;
        IOPatternLib.IOPattern memory p = IOPatternLib.IOPattern(pattern);

        NovaSpongeVestaLib.SpongeU24Vesta memory sponge = NovaSpongeVestaLib.start(p, 0);

        sponge = NovaSpongeVestaLib.absorb(sponge, elementsToHash);

        (, uint256[] memory output) = NovaSpongeVestaLib.squeeze(sponge, 1);
        sponge = NovaSpongeVestaLib.finishNoFinalIOCounterCheck(sponge);

        uint256 r = output[0] & 0x07ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff;

        RelaxedR1CSInstance memory result = foldInstance(U1, U2, comm_T, r);

        return result;
    }

    function foldInstance(
        RelaxedR1CSInstance calldata U1,
        R1CSInstance calldata u2,
        Vesta.VestaAffinePoint memory comm_T,
        uint256 r
    ) public view returns (RelaxedR1CSInstance memory) {
        uint256[] memory x1 = U1.X;
        Vesta.VestaAffinePoint memory comm_W_1 = U1.comm_W;
        Vesta.VestaAffinePoint memory comm_E_1 = U1.comm_E;
        uint256 u1 = U1.u;

        uint256[] memory x2 = u2.X;
        Vesta.VestaAffinePoint memory comm_W_2 = u2.comm_W;

        require(x1.length == x2.length, "Witness vectors do not match length");

        uint256[] memory X = new uint256[](x1.length);

        for (uint256 i = 0; i < x1.length; i++) {
            X[i] = x1[i] + r * x2[i];
        }

        Vesta.VestaAffinePoint memory comm_W = Vesta.add(comm_W_1, Vesta.scalarMul(comm_W_2, r));

        Vesta.VestaAffinePoint memory comm_E = Vesta.add(comm_E_1, Vesta.scalarMul(comm_T, r));

        uint256 u = u1 + r;

        return RelaxedR1CSInstance(comm_E, comm_W, X, u);
    }
}