// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.0;

import "@std/Test.sol";
import "src/blocks/pasta/Pallas.sol";
import "src/blocks/pasta/Vesta.sol";
import "src/blocks/poseidon/Sponge.sol";
import "src/blocks/KeccakTranscript.sol";
import "src/blocks/Sumcheck.sol";
import "src/NovaVerifierAbstractions.sol";
import "src/blocks/PolyEvalInstance.sol";

library Step3Lib {
    uint32 private constant NUM_FE_FOR_RO = 24;

    function final_verification(
        uint256 claim_mem_final_expected,
        uint256 claim_outer_final_expected,
        uint256 claim_inner_final_expected,
        uint256 claim_sat_final,
        uint256 modulus
    ) public view returns (bool) {
        uint256 actual = addmod(
            addmod(claim_mem_final_expected, claim_outer_final_expected, modulus), claim_inner_final_expected, modulus
        );

        if (actual != claim_sat_final) {
            console.log("claim_sat_final [expected]");
            console.logBytes32(bytes32(claim_sat_final));
            console.log("claim_sat_final [actual]");
            console.logBytes32(bytes32(actual));
            console.log("-------------------------------------------------");

            console.log("claim_mem_final");
            console.logBytes32(bytes32(claim_mem_final_expected));

            console.log("claim_outer_final");
            console.logBytes32(bytes32(claim_outer_final_expected));

            console.log("claim_inner_final");
            console.logBytes32(bytes32(claim_inner_final_expected));

            return false;
        }

        return true;
    }

    function compute_claim_inner_final(
        Abstractions.CompressedSnark calldata proof,
        uint256 c_inner,
        uint256[] memory coeffs,
        uint256 modulus
    ) public view returns (uint256) {
        if (coeffs.length < 10) {
            console.log("[Step3Lib:compute_claim_inner_final] coeffs.len < 10");
            revert();
        }

        uint256 self_eval_val_A = proof.f_W_snark_secondary.eval_val_A;
        uint256 self_eval_val_B = proof.f_W_snark_secondary.eval_val_B;
        uint256 self_eval_val_C = proof.f_W_snark_secondary.eval_val_C;
        uint256 self_eval_E_col = proof.f_W_snark_secondary.eval_E_col;
        uint256 self_eval_E_row = proof.f_W_snark_secondary.eval_E_row;
        uint256 coeffs_9 = coeffs[9];

        uint256 actual;
        assembly {
            let tmp := mulmod(c_inner, c_inner, modulus)
            tmp := mulmod(tmp, self_eval_val_C, modulus)
            tmp := addmod(tmp, self_eval_val_A, modulus)
            actual := mulmod(c_inner, self_eval_val_B, modulus)
            actual := addmod(actual, tmp, modulus)
            actual := mulmod(actual, self_eval_E_col, modulus)
            actual := mulmod(actual, self_eval_E_row, modulus)
            actual := mulmod(actual, coeffs_9, modulus)
        }

        return actual;
    }

    function compute_claim_outer_final(
        Abstractions.CompressedSnark storage proof,
        uint256 f_U_secondary_u,
        uint256[] memory coeffs,
        uint256 taus_bound_r_sat,
        uint256 modulus,
        function (uint256) returns (uint256) negateBase
    ) internal returns (uint256) {
        if (coeffs.length < 9) {
            console.log("[Step3Lib:compute_claim_outer_final] coeffs.len < 9");
            revert();
        }

        uint256 actual = mulmod(f_U_secondary_u, proof.f_W_snark_secondary.eval_Cz, modulus);
        actual = negateBase(actual);
        uint256 minus_self_eval_E = Pallas.negateBase(proof.f_W_snark_secondary.eval_E);
        uint256 coeffs_8 = coeffs[8];
        uint256 self_eval_Az = proof.f_W_snark_secondary.eval_Az;
        uint256 self_eval_Bz = proof.f_W_snark_secondary.eval_Bz;
        assembly {
            let tmp := mulmod(self_eval_Az, self_eval_Bz, modulus)
            tmp := addmod(tmp, minus_self_eval_E, modulus)
            actual := addmod(actual, tmp, modulus)
            actual := mulmod(actual, taus_bound_r_sat, modulus)
            actual := mulmod(actual, coeffs_8, modulus)
        }
        return actual;
    }

    function compute_claim_mem_final(
        Abstractions.CompressedSnark storage proof,
        uint256[] memory coeffs,
        uint256 rand_eq_bound_r_sat,
        uint256 modulus,
        function (uint256) returns (uint256) negateBase
    ) internal returns (uint256) {
        uint256 len = 8;
        if (coeffs.length < len) {
            console.log("[Step3Lib:compute_claim_mem_final_expected] coeffs.length < len");
            revert();
        }

        if (proof.f_W_snark_secondary.eval_left_arr.length != len) {
            console.log(
                "[Step3Lib:compute_claim_mem_final_expected] proof.f_W_snark_secondary.eval_left_arr.length != len"
            );
            revert();
        }
        if (proof.f_W_snark_secondary.eval_right_arr.length != len) {
            console.log(
                "[Step3Lib:compute_claim_mem_final_expected] proof.f_W_snark_secondary.eval_right_arr.length != len"
            );
            revert();
        }
        if (proof.f_W_snark_secondary.eval_output_arr.length != len) {
            console.log(
                "[Step3Lib:compute_claim_mem_final_expected] proof.f_W_snark_secondary.eval_output_arr.length != len"
            );
            revert();
        }

        uint256 actual;

        uint256 coeffs_item;
        uint256 eval_left_arr_item;
        uint256 eval_right_arr_item;

        uint256 tmp;
        for (uint256 index = 0; index < len; index++) {
            coeffs_item = coeffs[index];
            eval_left_arr_item = proof.f_W_snark_secondary.eval_left_arr[index];
            eval_right_arr_item = proof.f_W_snark_secondary.eval_right_arr[index];
            tmp = negateBase(proof.f_W_snark_secondary.eval_output_arr[index]);
            assembly {
                let tmp1 := mulmod(eval_left_arr_item, eval_right_arr_item, modulus)
                tmp1 := addmod(tmp1, tmp, modulus)
                tmp1 := mulmod(tmp1, rand_eq_bound_r_sat, modulus)
                tmp1 := mulmod(tmp1, coeffs_item, modulus)
                actual := addmod(actual, tmp1, modulus)
            }
        }

        return actual;
    }

    function compute_claim_sat_final_r_sat(
        Abstractions.CompressedSnark calldata proof,
        Abstractions.VerifierKey calldata vk,
        KeccakTranscriptLib.KeccakTranscript memory transcript,
        uint256 claim_inner,
        uint256[] memory coeffs,
        uint256 p_modulus
    ) public returns (uint256, uint256[] memory, KeccakTranscriptLib.KeccakTranscript memory) {
        // TODO: simplify convertions between abstractions
        Abstractions.CompressedPolys[] memory polys = proof.f_W_snark_secondary.sc_sat.compressed_polys;
        SumcheckUtilities.CompressedUniPoly[] memory compressed_polys =
            new SumcheckUtilities.CompressedUniPoly[](polys.length);
        for (uint256 index = 0; index < polys.length; index++) {
            compressed_polys[index] = SumcheckUtilities.CompressedUniPoly(polys[index].coeffs_except_linear_term);
        }

        // degreeBound is hardcoded to 3 in Rust
        return SecondarySumcheck.verify(
            SumcheckUtilities.SumcheckProof(compressed_polys),
            mulmod(coeffs[9], claim_inner, p_modulus),
            log2(vk.vk_secondary.S_comm.N),
            3,
            transcript
        );
    }

    function compute_coeffs_secondary(KeccakTranscriptLib.KeccakTranscript memory transcript)
        public
        pure
        returns (KeccakTranscriptLib.KeccakTranscript memory, uint256[] memory)
    {
        uint8[] memory label = new uint8[](1);
        label[0] = 0x72; // Rust's b"r"

        // in Rust length of coeffs is hardcoded to 10
        uint256[] memory coeffs = new uint256[](10);
        (transcript, coeffs[0]) = KeccakTranscriptLib.squeeze(transcript, ScalarFromUniformLib.curvePallas(), label);
        coeffs[0] = Field.reverse256(coeffs[0]);

        for (uint256 index = 1; index < coeffs.length; index++) {
            coeffs[index] = mulmod(coeffs[index - 1], coeffs[0], Pallas.P_MOD);
        }
        return (transcript, coeffs);
    }

    function compute_rand_eq_secondary(
        Abstractions.CompressedSnark calldata proof,
        Abstractions.VerifierKey calldata vk,
        KeccakTranscriptLib.KeccakTranscript memory transcript
    ) public view returns (KeccakTranscriptLib.KeccakTranscript memory, uint256[] memory) {
        uint256[] memory claims_product_arr = proof.f_W_snark_secondary.claims_product_arr;
        require(claims_product_arr.length == 8, "[Step3.compute_rand_eq]: claims_product_arr.length != 8");

        uint256[] memory comm_output_arr = proof.f_W_snark_secondary.comm_output_arr;
        require(comm_output_arr.length == 8, "[Step3.compute_rand_eq]: comm_output_arr.length != 8");

        Vesta.VestaAffinePoint[] memory comm_output_vec = new Vesta.VestaAffinePoint[](comm_output_arr.length);
        uint256 index;
        for (index = 0; index < comm_output_vec.length; index++) {
            comm_output_vec[index] = Vesta.decompress(comm_output_arr[index]);
        }

        uint8[] memory label = new uint8[](1);
        label[0] = 0x6f; // Rust's b"o"

        transcript = KeccakTranscriptLib.absorb(transcript, label, Abstractions.toTranscriptBytesVesta(comm_output_vec));

        label[0] = 0x63; // Rust's b"c"

        transcript =
            KeccakTranscriptLib.absorb(transcript, label, Abstractions.toTranscriptBytesVesta(claims_product_arr));

        uint256 num_rounds = log2(vk.vk_secondary.S_comm.N);

        label[0] = 0x65; // Rust's b"e"
        uint256[] memory rand_eq = new uint256[](num_rounds);
        for (index = 0; index < num_rounds; index++) {
            (transcript, rand_eq[index]) =
                KeccakTranscriptLib.squeeze(transcript, ScalarFromUniformLib.curvePallas(), label);
            rand_eq[index] = Field.reverse256(rand_eq[index]);
        }

        return (transcript, rand_eq);
    }

    function compute_u_secondary(Abstractions.CompressedSnark calldata proof, uint256[] memory tau, uint256 c)
        public
        view
        returns (PolyEvalInstanceLib.PolyEvalInstance memory)
    {
        uint256[] memory evals = new uint256[](3);
        evals[0] = proof.f_W_snark_secondary.eval_Az_at_tau;
        evals[1] = proof.f_W_snark_secondary.eval_Bz_at_tau;
        evals[2] = proof.f_W_snark_secondary.eval_Cz_at_tau;

        Vesta.VestaAffinePoint[] memory comm_vec = new Vesta.VestaAffinePoint[](3);
        comm_vec[0] = Vesta.decompress(proof.f_W_snark_secondary.comm_Az);
        comm_vec[1] = Vesta.decompress(proof.f_W_snark_secondary.comm_Bz);
        comm_vec[2] = Vesta.decompress(proof.f_W_snark_secondary.comm_Cz);

        return PolyEvalInstanceLib.batchSecondary(comm_vec, tau, evals, c);
    }

    function compute_c_secondary(
        Abstractions.CompressedSnark calldata proof,
        KeccakTranscriptLib.KeccakTranscript memory transcript
    ) public view returns (KeccakTranscriptLib.KeccakTranscript memory, uint256) {
        Vesta.VestaAffinePoint[] memory comms_E = new Vesta.VestaAffinePoint[](2);
        comms_E[0] = Vesta.decompress(proof.f_W_snark_secondary.comm_E_row);
        comms_E[1] = Vesta.decompress(proof.f_W_snark_secondary.comm_E_col);

        uint256[] memory evals = new uint256[](3);
        evals[0] = proof.f_W_snark_secondary.eval_Az_at_tau;
        evals[1] = proof.f_W_snark_secondary.eval_Bz_at_tau;
        evals[2] = proof.f_W_snark_secondary.eval_Cz_at_tau;

        uint8[] memory label = new uint8[](1);
        label[0] = 0x65; // Rust's b"e"

        transcript = KeccakTranscriptLib.absorb(transcript, label, Abstractions.toTranscriptBytesVesta(evals));
        transcript = KeccakTranscriptLib.absorb(transcript, label, Abstractions.toTranscriptBytesVesta(comms_E));

        // Question to reference implemnetation: Do we need this absorbing, that duplicates one above?
        transcript = KeccakTranscriptLib.absorb(transcript, label, Abstractions.toTranscriptBytesVesta(evals));

        label[0] = 0x63; // Rust's b"c"
        uint256 c;
        (transcript, c) = KeccakTranscriptLib.squeeze(transcript, ScalarFromUniformLib.curvePallas(), label);
        c = Field.reverse256(c);

        return (transcript, c);
    }

    function compute_gamma_1_secondary(KeccakTranscriptLib.KeccakTranscript memory transcript)
        public
        pure
        returns (KeccakTranscriptLib.KeccakTranscript memory, uint256)
    {
        uint8[] memory label = new uint8[](2);
        label[0] = 0x67; // Rust's b"g1"
        label[1] = 0x31;

        uint256 gamma_1;
        (transcript, gamma_1) = KeccakTranscriptLib.squeeze(transcript, ScalarFromUniformLib.curvePallas(), label);
        gamma_1 = Field.reverse256(gamma_1);

        return (transcript, gamma_1);
    }

    function compute_gamma_2_secondary(KeccakTranscriptLib.KeccakTranscript memory transcript)
        public
        pure
        returns (KeccakTranscriptLib.KeccakTranscript memory, uint256)
    {
        uint8[] memory label = new uint8[](2);
        label[0] = 0x67; // Rust's b"g2"
        label[1] = 0x32;

        uint256 gamma_2;
        (transcript, gamma_2) = KeccakTranscriptLib.squeeze(transcript, ScalarFromUniformLib.curvePallas(), label);
        gamma_2 = Field.reverse256(gamma_2);

        return (transcript, gamma_2);
    }

    function compute_tau_secondary(
        Abstractions.CompressedSnark calldata proof,
        Abstractions.VerifierKey calldata vk,
        KeccakTranscriptLib.KeccakTranscript memory transcript,
        Vesta.VestaAffinePoint memory f_U_secondary_comm_W,
        Vesta.VestaAffinePoint memory f_U_secondary_comm_E,
        uint256[] memory f_U_secondary_X,
        uint256 f_U_secondary_u
    ) public view returns (KeccakTranscriptLib.KeccakTranscript memory, uint256[] memory) {
        uint8[] memory label = new uint8[](2); // Rust's b"vk"
        label[0] = 0x76;
        label[1] = 0x6b;

        transcript = KeccakTranscriptLib.absorb(transcript, label, vk.vk_secondary.digest);

        label = new uint8[](1); // Rust's b"U"
        label[0] = 0x55;
        transcript = KeccakTranscriptLib.absorb(
            transcript,
            label,
            Abstractions.toTranscriptBytesVesta(
                f_U_secondary_comm_W, f_U_secondary_comm_E, f_U_secondary_X, f_U_secondary_u
            )
        );

        label = new uint8[](1); // Rust's b"c"
        label[0] = 0x63;

        Vesta.VestaAffinePoint[] memory commitments = new Vesta.VestaAffinePoint[](3);
        commitments[0] = Vesta.decompress(proof.f_W_snark_secondary.comm_Az);
        commitments[1] = Vesta.decompress(proof.f_W_snark_secondary.comm_Bz);
        commitments[2] = Vesta.decompress(proof.f_W_snark_secondary.comm_Cz);

        transcript = KeccakTranscriptLib.absorb(transcript, label, Abstractions.toTranscriptBytesVesta(commitments));

        label = new uint8[](1); // Rust's b"t"
        label[0] = 0x74;

        uint256 num_rounds_sat = log2(vk.vk_secondary.S_comm.N);

        uint256[] memory tau = new uint256[](num_rounds_sat);

        for (uint256 index = 0; index < tau.length; index++) {
            (transcript, tau[index]) =
                KeccakTranscriptLib.squeeze(transcript, ScalarFromUniformLib.curvePallas(), label);
            tau[index] = Field.reverse256(tau[index]);
        }
        return (transcript, tau);
    }

    function compute_f_U_secondary(Abstractions.CompressedSnark calldata proof, Abstractions.VerifierKey calldata vk)
        public
        view
        returns (Vesta.VestaAffinePoint memory, Vesta.VestaAffinePoint memory, uint256[] memory, uint256)
    {
        (uint256[] memory elementsToHash, Vesta.VestaAffinePoint memory comm_T) =
            prepareElementsToHashSecondary(proof, vk);

        return foldInstanceSecondary(
            Abstractions.RelaxedR1CSInstance(
                proof.r_U_secondary.comm_W, proof.r_U_secondary.comm_E, proof.r_U_secondary.X, proof.r_U_secondary.u
            ),
            Abstractions.R1CSInstance(proof.l_u_secondary.comm_W, proof.l_u_secondary.X),
            comm_T,
            compute_r_secondary(elementsToHash)
        );
    }

    function compute_r_secondary(uint256[] memory elementsToHash) private pure returns (uint256) {
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

    function prepareElementsToHashSecondary(
        Abstractions.CompressedSnark calldata proof,
        Abstractions.VerifierKey calldata vk
    ) private view returns (uint256[] memory, Vesta.VestaAffinePoint memory) {
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

        require(counter == NUM_FE_FOR_RO, "[Step3Lib.prepareElementsToHash] counter != NUM_FE_FOR_RO");

        return (elementsToHash, point);
    }

    function foldInstanceSecondary(
        Abstractions.RelaxedR1CSInstance memory U1,
        Abstractions.R1CSInstance memory u2,
        Vesta.VestaAffinePoint memory comm_T,
        uint256 r
    ) private view returns (Vesta.VestaAffinePoint memory, Vesta.VestaAffinePoint memory, uint256[] memory, uint256) {
        uint256[] memory x2 = u2.X;
        Vesta.VestaAffinePoint memory comm_W_2 = Vesta.decompress(u2.comm_W);

        require(U1.X.length == x2.length, "[Step3.foldInstance]: Witness vectors do not match length");

        uint256[] memory X = new uint256[](U1.X.length);

        for (uint256 i = 0; i < x2.length; i++) {
            X[i] = addmod(U1.X[i], mulmod(r, x2[i], Vesta.R_MOD), Vesta.R_MOD);
        }

        return (
            Vesta.add(Vesta.decompress(U1.comm_W), Vesta.scalarMul(comm_W_2, r)),
            Vesta.add(Vesta.decompress(U1.comm_E), Vesta.scalarMul(comm_T, r)),
            X,
            addmod(U1.u, r, Vesta.P_MOD)
        );
    }

    function log2(uint256 x) private pure returns (uint256 y) {
        assembly {
            let arg := x
            x := sub(x, 1)
            x := or(x, div(x, 0x02))
            x := or(x, div(x, 0x04))
            x := or(x, div(x, 0x10))
            x := or(x, div(x, 0x100))
            x := or(x, div(x, 0x10000))
            x := or(x, div(x, 0x100000000))
            x := or(x, div(x, 0x10000000000000000))
            x := or(x, div(x, 0x100000000000000000000000000000000))
            x := add(x, 1)
            let m := mload(0x40)
            mstore(m, 0xf8f9cbfae6cc78fbefe7cdc3a1793dfcf4f0e8bbd8cec470b6a28a7a5a3e1efd)
            mstore(add(m, 0x20), 0xf5ecf1b3e9debc68e1d9cfabc5997135bfb7a7a3938b7b606b5b4b3f2f1f0ffe)
            mstore(add(m, 0x40), 0xf6e4ed9ff2d6b458eadcdf97bd91692de2d4da8fd2d0ac50c6ae9a8272523616)
            mstore(add(m, 0x60), 0xc8c0b887b0a8a4489c948c7f847c6125746c645c544c444038302820181008ff)
            mstore(add(m, 0x80), 0xf7cae577eec2a03cf3bad76fb589591debb2dd67e0aa9834bea6925f6a4a2e0e)
            mstore(add(m, 0xa0), 0xe39ed557db96902cd38ed14fad815115c786af479b7e83247363534337271707)
            mstore(add(m, 0xc0), 0xc976c13bb96e881cb166a933a55e490d9d56952b8d4e801485467d2362422606)
            mstore(add(m, 0xe0), 0x753a6d1b65325d0c552a4d1345224105391a310b29122104190a110309020100)
            mstore(0x40, add(m, 0x100))
            let magic := 0x818283848586878898a8b8c8d8e8f929395969799a9b9d9e9faaeb6bedeeff
            let shift := 0x100000000000000000000000000000000000000000000000000000000000000
            let a := div(mul(x, magic), shift)
            y := div(mload(add(m, sub(255, a))), shift)
            y := add(y, mul(256, gt(arg, 0x8000000000000000000000000000000000000000000000000000000000000000)))
        }
    }
}
