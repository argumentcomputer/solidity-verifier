// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.0;

import "@std/Test.sol";
import "src/pasta/Vesta.sol";
import "src/poseidon/Sponge.sol";
import "src/NovaVerifierAbstractions.sol";

library Step3Lib {
    struct RelaxedR1CSInstance {
        Vesta.VestaAffinePoint comm_W;
        Vesta.VestaAffinePoint comm_E;
        uint256[] X;
        uint256 u;
    }

    struct R1CSInstance {
        Vesta.VestaAffinePoint comm_W;
        uint256[] X;
    }

    uint32 private constant NUM_FE_FOR_RO = 24;

    function compute_r(uint256[] memory elementsToHash) private view returns (uint256) {
        SpongeOpLib.SpongeOp memory absorb = SpongeOpLib.SpongeOp(SpongeOpLib.SpongeOpType.Absorb, NUM_FE_FOR_RO);
        SpongeOpLib.SpongeOp memory squeeze = SpongeOpLib.SpongeOp(SpongeOpLib.SpongeOpType.Squeeze, 1);
        SpongeOpLib.SpongeOp[] memory pattern = new SpongeOpLib.SpongeOp[](2);
        pattern[0] = absorb;
        pattern[1] = squeeze;

        NovaSpongeVestaLib.SpongeU24Vesta memory sponge = NovaSpongeVestaLib.start(IOPatternLib.IOPattern(pattern), 0);

        sponge = NovaSpongeVestaLib.absorb(sponge, elementsToHash);

        (, uint256[] memory output) = NovaSpongeVestaLib.squeeze(sponge, 1);

        return output[0] & 0x00000000000000000000000000000000ffffffffffffffffffffffffffffffff;
    }

    function compute_f_U_secondary(Abstractions.CompressedSnark calldata proof, Abstractions.VerifierKey calldata vk)
        public
        view
        returns (RelaxedR1CSInstance memory)
    {
        uint256 counter = 0;
        uint256[] memory elementsToHash = new uint256[](NUM_FE_FOR_RO);
        elementsToHash[counter] = vk.digest;
        counter++;

        Vesta.VestaAffinePoint memory point;
        //U1.absorb_in_ro
        // Absorb comm_W
        point = Vesta.decompress(proof.r_U_secondary.comm_W);
        elementsToHash[counter] = point.x;
        counter++;
        elementsToHash[counter] = point.y;
        counter++;
        if (Vesta.isInfinity(point)) {
            elementsToHash[counter] = 1;
        } else {
            elementsToHash[counter] = 0;
        }
        counter++;


        // Absorb comm_E
        point = Vesta.decompress(proof.r_U_secondary.comm_E);
        elementsToHash[counter] = point.x;
        counter++;
        elementsToHash[counter] = point.y;
        counter++;
        if (Vesta.isInfinity(point)) {
            elementsToHash[counter] = 1;
        } else {
            elementsToHash[counter] = 0;
        }
        counter++;

        // Abosrb u
        elementsToHash[counter] = proof.r_U_secondary.u;
        counter++;

        // Absorb X
        uint256 limb1;
        uint256 limb2;
        uint256 limb3;
        uint256 limb4;
        for (uint256 i = 0; i < proof.r_U_secondary.X.length; i++) {
            (limb1, limb2, limb3, limb4) = Field.extractLimbs(proof.r_U_secondary.X[i]);
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
        point = Vesta.decompress(proof.l_u_secondary.comm_W);
        elementsToHash[counter] = point.x;
        counter++;
        elementsToHash[counter] = point.y;
        counter++;
        if (Vesta.isInfinity(point)) {
            elementsToHash[counter] = 1;
        } else {
            elementsToHash[counter] = 0;
        }
        counter++;

        // Absorb X
        for (uint256 i = 0; i < proof.l_u_secondary.X.length; i++) {
            elementsToHash[counter] = proof.l_u_secondary.X[i];
            counter++;
        }

        // Absorb comm_T
        point = Vesta.fromBytes(bytes32(proof.nifs_compressed_comm_T));
        elementsToHash[counter] = point.x;
        counter++;
        elementsToHash[counter] = point.y;
        counter++;
        if (Vesta.isInfinity(point)) {
            elementsToHash[counter] = 1;
        } else {
            elementsToHash[counter] = 0;
        }
        counter++;

        require(counter == NUM_FE_FOR_RO, "[compute_f_U_secondary] counter != NUM_FE_FOR_RO");

        return foldInstance(
            RelaxedR1CSInstance(
                Vesta.decompress(proof.r_U_secondary.comm_W),
                Vesta.decompress(proof.r_U_secondary.comm_E),
                proof.r_U_secondary.X,
                proof.r_U_secondary.u
            ),
            R1CSInstance(Vesta.decompress(proof.l_u_secondary.comm_W), proof.l_u_secondary.X),
            point,
            compute_r(elementsToHash)
        );
    }

    function foldInstance(
        RelaxedR1CSInstance memory U1,
        R1CSInstance memory u2,
        Vesta.VestaAffinePoint memory comm_T,
        uint256 r
    ) public view returns (RelaxedR1CSInstance memory) {
        uint256[] memory x2 = u2.X;
        Vesta.VestaAffinePoint memory comm_W_2 = u2.comm_W;

        require(U1.X.length == x2.length, "[Step3.foldInstance]: Witness vectors do not match length");

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
