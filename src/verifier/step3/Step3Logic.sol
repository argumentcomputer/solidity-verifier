// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.16;

import "src/blocks/pasta/Pallas.sol";
import "src/blocks/pasta/Vesta.sol";
import "src/verifier/step2/Step2Data.sol";
import "src/poseidon/Sponge.sol";

library NIFSPallas {
    uint256 private constant MOD = Pallas.P_MOD;
    uint256 private constant NUM_FE_FOR_RO = 24;

    struct NIFS {
        bytes32 compressed_comm_T;
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

    function verify(NIFS memory nifs, uint256 pp_digest, RelaxedR1CSInstance calldata U1, R1CSInstance calldata U2)
        public
        view
        returns (RelaxedR1CSInstance memory)
    {
        uint256 counter = 0;

        uint256[] memory elementsToHash = new uint256[](NUM_FE_FOR_RO);

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
        } else {
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
        } else {
            elementsToHash[counter] = 0;
        }
        counter++;

        // Abosrb u
        elementsToHash[counter] = U1.u;
        counter++;

        // Absorb X
        for (uint256 i = 0; i < U1.X.length; i++) {
            uint256 entry = U1.X[i];

            (uint256 limb1, uint256 limb2, uint256 limb3, uint256 limb4) = Field.extractLimbs(entry);
            elementsToHash[counter] = limb1;
            counter++;
            elementsToHash[counter] = limb2;
            counter++;
            elementsToHash[counter] = limb3;
            counter++;
            elementsToHash[counter] = limb4;
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
        } else {
            elementsToHash[counter] = 0;
        }
        counter++;

        // Absorb X
        for (uint256 i = 0; i < U2.X.length; i++) {
            elementsToHash[counter] = U2.X[i];
            counter++;
        }

        // Absorb comm_T
        Pallas.PallasAffinePoint memory comm_T = Pallas.fromBytes(nifs.compressed_comm_T);
        elementsToHash[counter] = comm_T.x;
        counter++;
        elementsToHash[counter] = comm_T.y;
        counter++;
        if (Pallas.isInfinity(comm_T)) {
            elementsToHash[counter] = 1;
        } else {
            elementsToHash[counter] = 0;
        }
        counter++;

        require(counter == NUM_FE_FOR_RO);

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

        RelaxedR1CSInstance memory result =
            foldInstance(U1, U2, comm_T, output[0] & 0x00000000000000000000000000000000ffffffffffffffffffffffffffffffff);

        return result;
    }

    function foldInstance(
        RelaxedR1CSInstance calldata U1,
        R1CSInstance calldata u2,
        Pallas.PallasAffinePoint memory comm_T,
        uint256 r
    ) public view returns (RelaxedR1CSInstance memory) {
        uint256[] memory x2 = u2.X;
        Pallas.PallasAffinePoint memory comm_W_2 = u2.comm_W;

        require(U1.X.length == x2.length, "[NIFSPallas.foldInstance]: Witness vectors do not match length");

        uint256[] memory X = new uint256[](U1.X.length);

        for (uint256 i = 0; i < x2.length; i++) {
            X[i] = addmod(U1.X[i], mulmod(r, x2[i], Pallas.R_MOD), Pallas.R_MOD);
        }

        return RelaxedR1CSInstance(
            Pallas.add(U1.comm_W, Pallas.scalarMul(comm_W_2, r)),
            Pallas.add(U1.comm_E, Pallas.scalarMul(comm_T, r)),
            X,
            addmod(U1.u, r, Pallas.P_MOD)
        );
    }
}

library NIFSVesta {
    uint256 private constant MOD = Vesta.P_MOD;
    uint256 private constant NUM_FE_FOR_RO = 24;

    struct NIFS {
        bytes32 compressed_comm_T;
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

    function verify(NIFS memory nifs, uint256 pp_digest, RelaxedR1CSInstance calldata U1, R1CSInstance calldata U2)
        public
        view
        returns (RelaxedR1CSInstance memory)
    {
        uint256 counter = 0;

        uint256[] memory elementsToHash = new uint256[](NUM_FE_FOR_RO);

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
        } else {
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
        } else {
            elementsToHash[counter] = 0;
        }
        counter++;

        // Abosrb u
        elementsToHash[counter] = U1.u;
        counter++;

        // Absorb X
        for (uint256 i = 0; i < U1.X.length; i++) {
            uint256 entry = U1.X[i];
            (uint256 limb1, uint256 limb2, uint256 limb3, uint256 limb4) = Field.extractLimbs(entry);

            elementsToHash[counter] = limb1;
            counter++;
            elementsToHash[counter] = limb2;
            counter++;
            elementsToHash[counter] = limb3;
            counter++;
            elementsToHash[counter] = limb4;
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
        } else {
            elementsToHash[counter] = 0;
        }
        counter++;

        // Absorb X
        for (uint256 i = 0; i < U2.X.length; i++) {
            elementsToHash[counter] = U2.X[i];
            counter++;
        }

        // Absorb comm_T
        Vesta.VestaAffinePoint memory comm_T = Vesta.fromBytes(nifs.compressed_comm_T);
        elementsToHash[counter] = comm_T.x;
        counter++;
        elementsToHash[counter] = comm_T.y;
        counter++;
        if (Vesta.isInfinity(comm_T)) {
            elementsToHash[counter] = 1;
        } else {
            elementsToHash[counter] = 0;
        }
        counter++;

        require(counter == NUM_FE_FOR_RO);

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

        RelaxedR1CSInstance memory result =
            foldInstance(U1, U2, comm_T, output[0] & 0x00000000000000000000000000000000ffffffffffffffffffffffffffffffff);

        return result;
    }

    function foldInstance(
        RelaxedR1CSInstance calldata U1,
        R1CSInstance calldata u2,
        Vesta.VestaAffinePoint memory comm_T,
        uint256 r
    ) public view returns (RelaxedR1CSInstance memory) {
        uint256[] memory x2 = u2.X;
        Vesta.VestaAffinePoint memory comm_W_2 = u2.comm_W;

        require(U1.X.length == x2.length, "[NIFSVesta.foldInstance]: Witness vectors do not match length");

        uint256[] memory X = new uint256[](U1.X.length);

        for (uint256 i = 0; i < x2.length; i++) {
            X[i] = addmod(U1.X[i], mulmod(r, x2[i], Vesta.R_MOD), Vesta.R_MOD);
        }

        return RelaxedR1CSInstance(
            Vesta.add(U1.comm_W, Vesta.scalarMul(comm_W_2, r)),
            Vesta.add(U1.comm_E, Vesta.scalarMul(comm_T, r)),
            X,
            addmod(U1.u, r, Vesta.P_MOD)
        );
    }
}
