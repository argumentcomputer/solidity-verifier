// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.16;

import "@std/Test.sol";
import "src/NovaVerifierAbstractions.sol";
import "src/blocks/poseidon/Sponge.sol";
import "src/blocks/grumpkin/Bn256.sol";
import "src/blocks/grumpkin/Grumpkin.sol";
import "src/blocks/Sumcheck.sol";
import "src/blocks/PolyEvalInstance.sol";
import "test/utils.t.sol";

library Step3GrumpkinLib {
    uint32 private constant NUM_FE_FOR_RO = 24;

    function compute_sumcheck_claim(uint256 claim_inner, uint256[] memory coeffs, uint256 p_modulus)
        private
        pure
        returns (uint256)
    {
        return mulmod(coeffs[9], claim_inner, p_modulus);
    }

    function extract_sumcheck_proof(Abstractions.SumcheckProof calldata proof)
        internal
        pure
        returns (SumcheckUtilities.SumcheckProof memory)
    {
        // TODO: simplify conversions between abstractions
        Abstractions.CompressedPolys[] memory polys = proof.compressed_polys;
        SumcheckUtilities.CompressedUniPoly[] memory compressed_polys =
            new SumcheckUtilities.CompressedUniPoly[](polys.length);
        uint256 index = 0;
        for (index = 0; index < polys.length; index++) {
            compressed_polys[index] = SumcheckUtilities.CompressedUniPoly(polys[index].coeffs_except_linear_term);
        }
        return SumcheckUtilities.SumcheckProof(compressed_polys);
    }

    function compute_claim_sat_final_r_sat_secondary(
        Abstractions.RelaxedR1CSSNARK calldata proof,
        Abstractions.VerifierKeyS2 calldata vk,
        KeccakTranscriptLib.KeccakTranscript memory transcript,
        uint256 claim_inner,
        uint256[] memory coeffs,
        uint256 p_modulus,
        bool enableLogging
    ) public returns (uint256, uint256[] memory, KeccakTranscriptLib.KeccakTranscript memory) {
        SumcheckUtilities.SumcheckProof memory sumcheckProof = extract_sumcheck_proof(proof.sc_sat);

        if (enableLogging) {
            console.log("-----------compute_claim_sat_final_r_sat_secondary------------");
            console.log("CompressedUniPoly");
            for (uint256 index = 0; index < sumcheckProof.compressed_polys.length; index++) {
                console.log(index);
                for (uint256 i = 0; i < sumcheckProof.compressed_polys[index].coeffs_except_linear_term.length; i++) {
                    console.logBytes32(bytes32(sumcheckProof.compressed_polys[index].coeffs_except_linear_term[i]));
                }
            }
        }
        // degreeBound is hardcoded to 3 in Rust
        return SumcheckGrumpkin.verify(
            sumcheckProof,
            compute_sumcheck_claim(claim_inner, coeffs, p_modulus),
            CommonUtilities.log2(vk.S_comm.N),
            3,
            transcript
        );
    }

    function compute_claim_sat_final_r_sat_primary(
        Abstractions.RelaxedR1CSSNARK calldata proof,
        Abstractions.VerifierKeyS1 calldata vk,
        KeccakTranscriptLib.KeccakTranscript memory transcript,
        uint256 claim_inner,
        uint256[] memory coeffs,
        uint256 p_modulus,
        bool enableLogging
    ) public returns (uint256, uint256[] memory, KeccakTranscriptLib.KeccakTranscript memory) {
        SumcheckUtilities.SumcheckProof memory sumcheckProof = extract_sumcheck_proof(proof.sc_sat);

        if (enableLogging) {
            console.log("-----------compute_claim_sat_final_r_sat_secondary------------");
            console.log("CompressedUniPoly");
            for (uint256 index = 0; index < sumcheckProof.compressed_polys.length; index++) {
                console.log(index);
                for (uint256 i = 0; i < sumcheckProof.compressed_polys[index].coeffs_except_linear_term.length; i++) {
                    console.logBytes32(bytes32(sumcheckProof.compressed_polys[index].coeffs_except_linear_term[i]));
                }
            }
        }
        // degreeBound is hardcoded to 3 in Rust
        return SumcheckBn256.verify(
            sumcheckProof,
            compute_sumcheck_claim(claim_inner, coeffs, p_modulus),
            CommonUtilities.log2(vk.S_comm.N),
            3,
            transcript
        );
    }

    // TODO: this is just for testing (memory proof). In contract we can use function from Step3Lib (storage proof)
    function compute_claim_mem_final(
        Abstractions.RelaxedR1CSSNARK memory proof,
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

        if (proof.eval_left_arr.length != len) {
            console.log(
                "[Step3Lib:compute_claim_mem_final_expected] proof.f_W_snark_secondary.eval_left_arr.length != len"
            );
            revert();
        }
        if (proof.eval_right_arr.length != len) {
            console.log(
                "[Step3Lib:compute_claim_mem_final_expected] proof.f_W_snark_secondary.eval_right_arr.length != len"
            );
            revert();
        }
        if (proof.eval_output_arr.length != len) {
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
            eval_left_arr_item = proof.eval_left_arr[index];
            eval_right_arr_item = proof.eval_right_arr[index];
            tmp = negateBase(proof.eval_output_arr[index]);
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

    // TODO: this is just for testing (memory proof). In contract we can use function from Step3Lib (storage proof)
    function compute_claim_outer_final(
        Abstractions.RelaxedR1CSSNARK memory proof,
        uint256 r_U_primary_u,
        uint256[] memory coeffs,
        uint256 taus_bound_r_sat,
        uint256 modulus,
        function (uint256) returns (uint256) negateBase
    ) internal returns (uint256) {
        if (coeffs.length < 9) {
            console.log("[Step3Lib:compute_claim_outer_final] coeffs.len < 9");
            revert();
        }

        uint256 actual = mulmod(r_U_primary_u, proof.eval_Cz, modulus);
        actual = negateBase(actual);
        uint256 minus_self_eval_E = negateBase(proof.eval_E);
        uint256 coeffs_8 = coeffs[8];
        uint256 self_eval_Az = proof.eval_Az;
        uint256 self_eval_Bz = proof.eval_Bz;
        assembly {
            let tmp := mulmod(self_eval_Az, self_eval_Bz, modulus)
            tmp := addmod(tmp, minus_self_eval_E, modulus)
            actual := addmod(actual, tmp, modulus)
            actual := mulmod(actual, taus_bound_r_sat, modulus)
            actual := mulmod(actual, coeffs_8, modulus)
        }
        return actual;
    }

    function compute_f_U_secondary(Abstractions.CompressedSnark calldata proof, Abstractions.VerifierKey calldata vk)
        public
        returns (Grumpkin.GrumpkinAffinePoint memory, Grumpkin.GrumpkinAffinePoint memory, uint256[] memory, uint256)
    {
        (uint256[] memory elementsToHash, Grumpkin.GrumpkinAffinePoint memory comm_T) =
            prepareElementsToHashSecondary(proof, vk);

        // TODO implement fetching Bn256 Poseidon constants from vk
        return foldInstanceSecondary(
            proof.r_U_secondary,
            proof.l_u_secondary,
            comm_T,
            compute_r_secondary(elementsToHash, TestUtilities.loadBn256Constants(), Bn256.R_MOD)
        );
    }

    function prepareElementsToHashSecondary(
        Abstractions.CompressedSnark calldata proof,
        Abstractions.VerifierKey calldata vk
    ) public view returns (uint256[] memory, Grumpkin.GrumpkinAffinePoint memory) {
        uint256 counter = 0;
        uint256[] memory elementsToHash = new uint256[](NUM_FE_FOR_RO);
        elementsToHash[counter] = vk.digest;
        counter++;

        Grumpkin.GrumpkinAffinePoint memory point;
        //U1.absorb_in_ro
        // Absorb comm_W
        point = Grumpkin.decompress(proof.r_U_secondary.comm_W);
        elementsToHash[counter] = point.x;
        counter++;
        elementsToHash[counter] = point.y;
        counter++;
        if (Grumpkin.is_identity(point)) {
            elementsToHash[counter] = 1;
        } else {
            elementsToHash[counter] = 0;
        }
        counter++;

        // Absorb comm_E
        point = Grumpkin.decompress(proof.r_U_secondary.comm_E);
        elementsToHash[counter] = point.x;
        counter++;
        elementsToHash[counter] = point.y;
        counter++;
        if (Grumpkin.is_identity(point)) {
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
        point = Grumpkin.decompress(proof.l_u_secondary.comm_W);
        elementsToHash[counter] = point.x;
        counter++;
        elementsToHash[counter] = point.y;
        counter++;
        if (Grumpkin.is_identity(point)) {
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
        point = Grumpkin.decompress(proof.nifs_compressed_comm_T);
        elementsToHash[counter] = point.x;
        counter++;
        elementsToHash[counter] = point.y;
        counter++;
        if (Grumpkin.is_identity(point)) {
            elementsToHash[counter] = 1;
        } else {
            elementsToHash[counter] = 0;
        }
        counter++;

        require(counter == NUM_FE_FOR_RO, "[Step3LibGrumpkin.prepareElementsToHash] counter != NUM_FE_FOR_RO");

        return (elementsToHash, point);
    }

    function foldInstanceSecondary(
        Abstractions.RelaxedR1CSInstance memory U1,
        Abstractions.R1CSInstance memory u2,
        Grumpkin.GrumpkinAffinePoint memory comm_T,
        uint256 r
    )
        public
        view
        returns (Grumpkin.GrumpkinAffinePoint memory, Grumpkin.GrumpkinAffinePoint memory, uint256[] memory, uint256)
    {
        uint256[] memory x2 = u2.X;
        Grumpkin.GrumpkinAffinePoint memory comm_W_2 = Grumpkin.decompress(u2.comm_W);

        require(U1.X.length == x2.length, "[Step3Grumpkin.foldInstance]: Witness vectors do not match length");

        uint256[] memory X = new uint256[](U1.X.length);

        for (uint256 i = 0; i < x2.length; i++) {
            X[i] = addmod(U1.X[i], mulmod(r, x2[i], Grumpkin.P_MOD), Grumpkin.P_MOD);
        }

        return (
            Grumpkin.add(Grumpkin.decompress(U1.comm_W), Grumpkin.scalarMul(comm_W_2, r)),
            Grumpkin.add(Grumpkin.decompress(U1.comm_E), Grumpkin.scalarMul(comm_T, r)),
            X,
            addmod(U1.u, r, Grumpkin.P_MOD)
        );
    }

    function compute_r_secondary(
        uint256[] memory elementsToHash,
        PoseidonU24Optimized.PoseidonConstantsU24 memory constants,
        uint256 modulus
    ) public returns (uint256) {
        SpongeOpLib.SpongeOp memory absorb = SpongeOpLib.SpongeOp(SpongeOpLib.SpongeOpType.Absorb, NUM_FE_FOR_RO);
        SpongeOpLib.SpongeOp memory squeeze = SpongeOpLib.SpongeOp(SpongeOpLib.SpongeOpType.Squeeze, 1);
        SpongeOpLib.SpongeOp[] memory pattern = new SpongeOpLib.SpongeOp[](2);
        pattern[0] = absorb;
        pattern[1] = squeeze;

        NovaSpongeLib.SpongeU24 memory sponge = NovaSpongeLib.start(IOPatternLib.IOPattern(pattern), 0, constants);

        sponge = NovaSpongeLib.absorb(sponge, elementsToHash, modulus);

        (, uint256[] memory output) = NovaSpongeLib.squeeze(sponge, 1, modulus);

        return output[0] & 0x00000000000000000000000000000000ffffffffffffffffffffffffffffffff;
    }

    function compute_tau_primary(
        Abstractions.CompressedSnark calldata proof,
        Abstractions.VerifierKeyS1 calldata vk,
        KeccakTranscriptLib.KeccakTranscript memory transcript,
        bool useLogging
    ) public view returns (KeccakTranscriptLib.KeccakTranscript memory, uint256[] memory) {
        uint8[] memory label = new uint8[](2); // Rust's b"vk"
        label[0] = 0x76;
        label[1] = 0x6b;

        transcript = KeccakTranscriptLib.absorb(transcript, label, vk.digest);

        label = new uint8[](1); // Rust's b"U"
        label[0] = 0x55;
        transcript = KeccakTranscriptLib.absorb(
            transcript,
            label,
            Bn256.decompress(proof.r_U_primary.comm_W),
            Bn256.decompress(proof.r_U_primary.comm_E),
            proof.r_U_primary.X,
            proof.r_U_primary.u
        );

        label = new uint8[](1); // Rust's b"c"
        label[0] = 0x63;

        Bn256.Bn256AffinePoint[] memory commitments = new Bn256.Bn256AffinePoint[](3);
        commitments[0] = Bn256.decompress(proof.r_W_snark_primary.comm_Az);
        commitments[1] = Bn256.decompress(proof.r_W_snark_primary.comm_Bz);
        commitments[2] = Bn256.decompress(proof.r_W_snark_primary.comm_Cz);

        transcript = KeccakTranscriptLib.absorb(transcript, label, commitments);

        label = new uint8[](1); // Rust's b"t"
        label[0] = 0x74;

        uint256[] memory tau = new uint256[](17);

        for (uint256 index = 0; index < tau.length; index++) {
            (transcript, tau[index]) = KeccakTranscriptLib.squeeze(transcript, ScalarFromUniformLib.curveBn256(), label);
            tau[index] = Field.reverse256(tau[index]);
        }

        if (useLogging) {
            console.log("----------------compute_tau_primary--------------");
            console.log("vk.digest");
            console.logBytes32(bytes32(vk.digest));
            console.log("proof.r_W_snark_primary.comm_Az");
            console.logBytes32(bytes32(proof.r_W_snark_primary.comm_Az));
            console.log("proof.r_W_snark_primary.comm_Bz");
            console.logBytes32(bytes32(proof.r_W_snark_primary.comm_Bz));
            console.log("proof.r_W_snark_primary.comm_Cz");
            console.logBytes32(bytes32(proof.r_W_snark_primary.comm_Cz));
            console.log("vk.S_comm.N");
            console.log(vk.S_comm.N);
        }

        return (transcript, tau);
    }

    function compute_tau_secondary(
        Abstractions.CompressedSnark calldata proof,
        Abstractions.VerifierKeyS2 calldata vk,
        KeccakTranscriptLib.KeccakTranscript memory transcript,
        Grumpkin.GrumpkinAffinePoint memory f_U_secondary_comm_W,
        Grumpkin.GrumpkinAffinePoint memory f_U_secondary_comm_E,
        uint256[] memory f_U_secondary_X,
        uint256 f_U_secondary_u,
        bool useLogging
    ) public view returns (KeccakTranscriptLib.KeccakTranscript memory, uint256[] memory) {
        uint8[] memory label = new uint8[](2); // Rust's b"vk"
        label[0] = 0x76;
        label[1] = 0x6b;

        transcript = KeccakTranscriptLib.absorb(transcript, label, vk.digest);

        label = new uint8[](1); // Rust's b"U"
        label[0] = 0x55;
        transcript = KeccakTranscriptLib.absorb(
            transcript, label, f_U_secondary_comm_W, f_U_secondary_comm_E, f_U_secondary_X, f_U_secondary_u
        );

        label = new uint8[](1); // Rust's b"c"
        label[0] = 0x63;

        Grumpkin.GrumpkinAffinePoint[] memory commitments = new Grumpkin.GrumpkinAffinePoint[](3);
        commitments[0] = Grumpkin.decompress(proof.f_W_snark_secondary.comm_Az);
        commitments[1] = Grumpkin.decompress(proof.f_W_snark_secondary.comm_Bz);
        commitments[2] = Grumpkin.decompress(proof.f_W_snark_secondary.comm_Cz);

        transcript = KeccakTranscriptLib.absorb(transcript, label, commitments);

        label = new uint8[](1); // Rust's b"t"
        label[0] = 0x74;

        uint256 num_rounds_sat = CommonUtilities.log2(vk.S_comm.N);

        uint256[] memory tau = new uint256[](num_rounds_sat);

        for (uint256 index = 0; index < tau.length; index++) {
            (transcript, tau[index]) =
                KeccakTranscriptLib.squeeze(transcript, ScalarFromUniformLib.curveGrumpkin(), label);
            tau[index] = Field.reverse256(tau[index]);
        }

        if (useLogging) {
            console.log("----------------compute_tau_secondary--------------");
            console.log("vk.digest");
            console.logBytes32(bytes32(vk.digest));
            console.log("proof.f_W_snark_secondary.comm_Az");
            console.logBytes32(bytes32(proof.f_W_snark_secondary.comm_Az));
            console.log("proof.f_W_snark_secondary.comm_Bz");
            console.logBytes32(bytes32(proof.f_W_snark_secondary.comm_Bz));
            console.log("proof.f_W_snark_secondary.comm_Cz");
            console.logBytes32(bytes32(proof.f_W_snark_secondary.comm_Cz));
            console.log("vk.S_comm.N");
            console.log(vk.S_comm.N);
        }

        return (transcript, tau);
    }

    function compute_c_secondary(
        Abstractions.CompressedSnark calldata proof,
        KeccakTranscriptLib.KeccakTranscript memory transcript
    ) public view returns (KeccakTranscriptLib.KeccakTranscript memory, uint256) {
        Grumpkin.GrumpkinAffinePoint[] memory comms_E = new Grumpkin.GrumpkinAffinePoint[](2);
        comms_E[0] = Grumpkin.decompress(proof.f_W_snark_secondary.comm_E_row);
        comms_E[1] = Grumpkin.decompress(proof.f_W_snark_secondary.comm_E_col);

        uint256[] memory evals = new uint256[](3);
        evals[0] = proof.f_W_snark_secondary.eval_Az_at_tau;
        evals[1] = proof.f_W_snark_secondary.eval_Bz_at_tau;
        evals[2] = proof.f_W_snark_secondary.eval_Cz_at_tau;

        uint8[] memory label = new uint8[](1);
        label[0] = 0x65; // Rust's b"e"

        transcript = KeccakTranscriptLib.absorb(transcript, label, evals);
        transcript = KeccakTranscriptLib.absorb(transcript, label, comms_E);

        // Question to reference implemnetation: Do we need this absorbing, that duplicates one above?
        transcript = KeccakTranscriptLib.absorb(transcript, label, evals);

        label[0] = 0x63; // Rust's b"c"
        uint256 c;
        (transcript, c) = KeccakTranscriptLib.squeeze(transcript, ScalarFromUniformLib.curveGrumpkin(), label);
        c = Field.reverse256(c);

        return (transcript, c);
    }

    function compute_c_primary(
        Abstractions.CompressedSnark calldata proof,
        KeccakTranscriptLib.KeccakTranscript memory transcript
    ) public view returns (KeccakTranscriptLib.KeccakTranscript memory, uint256) {
        Bn256.Bn256AffinePoint[] memory comms_E = new Bn256.Bn256AffinePoint[](2);
        comms_E[0] = Bn256.decompress(proof.r_W_snark_primary.comm_E_row);
        comms_E[1] = Bn256.decompress(proof.r_W_snark_primary.comm_E_col);

        uint256[] memory evals = new uint256[](3);
        evals[0] = proof.r_W_snark_primary.eval_Az_at_tau;
        evals[1] = proof.r_W_snark_primary.eval_Bz_at_tau;
        evals[2] = proof.r_W_snark_primary.eval_Cz_at_tau;

        uint8[] memory label = new uint8[](1);
        label[0] = 0x65; // Rust's b"e"

        transcript = KeccakTranscriptLib.absorb(transcript, label, evals);
        transcript = KeccakTranscriptLib.absorb(transcript, label, comms_E);

        // Question to reference implemnetation: Do we need this absorbing, that duplicates one above?
        transcript = KeccakTranscriptLib.absorb(transcript, label, evals);

        label[0] = 0x63; // Rust's b"c"
        uint256 c;
        (transcript, c) = KeccakTranscriptLib.squeeze(transcript, ScalarFromUniformLib.curveBn256(), label);
        c = Field.reverse256(c);

        return (transcript, c);
    }

    function compute_u_secondary(Abstractions.CompressedSnark calldata proof, uint256[] memory tau, uint256 c)
        public
        returns (PolyEvalInstanceLib.PolyEvalInstance memory)
    {
        uint256[] memory evals = new uint256[](3);
        evals[0] = proof.f_W_snark_secondary.eval_Az_at_tau;
        evals[1] = proof.f_W_snark_secondary.eval_Bz_at_tau;
        evals[2] = proof.f_W_snark_secondary.eval_Cz_at_tau;

        Grumpkin.GrumpkinAffinePoint[] memory comm_vec = new Grumpkin.GrumpkinAffinePoint[](3);
        comm_vec[0] = Grumpkin.decompress(proof.f_W_snark_secondary.comm_Az);
        comm_vec[1] = Grumpkin.decompress(proof.f_W_snark_secondary.comm_Bz);
        comm_vec[2] = Grumpkin.decompress(proof.f_W_snark_secondary.comm_Cz);

        return PolyEvalInstanceLib.batchGrumpkin(comm_vec, tau, evals, c);
    }

    function compute_u_primary(Abstractions.CompressedSnark calldata proof, uint256[] memory tau, uint256 c)
        public
        returns (PolyEvalInstanceLib.PolyEvalInstance memory)
    {
        uint256[] memory evals = new uint256[](3);
        evals[0] = proof.r_W_snark_primary.eval_Az_at_tau;
        evals[1] = proof.r_W_snark_primary.eval_Bz_at_tau;
        evals[2] = proof.r_W_snark_primary.eval_Cz_at_tau;

        Bn256.Bn256AffinePoint[] memory comm_vec = new Bn256.Bn256AffinePoint[](3);
        comm_vec[0] = Bn256.decompress(proof.r_W_snark_primary.comm_Az);
        comm_vec[1] = Bn256.decompress(proof.r_W_snark_primary.comm_Bz);
        comm_vec[2] = Bn256.decompress(proof.r_W_snark_primary.comm_Cz);

        return PolyEvalInstanceLib.batchBn256(comm_vec, tau, evals, c);
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
        (transcript, gamma_1) = KeccakTranscriptLib.squeeze(transcript, ScalarFromUniformLib.curveGrumpkin(), label);
        gamma_1 = Field.reverse256(gamma_1);

        return (transcript, gamma_1);
    }

    function compute_gamma_1_primary(KeccakTranscriptLib.KeccakTranscript memory transcript)
        public
        pure
        returns (KeccakTranscriptLib.KeccakTranscript memory, uint256)
    {
        uint8[] memory label = new uint8[](2);
        label[0] = 0x67; // Rust's b"g1"
        label[1] = 0x31;

        uint256 gamma_1;
        (transcript, gamma_1) = KeccakTranscriptLib.squeeze(transcript, ScalarFromUniformLib.curveBn256(), label);
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
        (transcript, gamma_2) = KeccakTranscriptLib.squeeze(transcript, ScalarFromUniformLib.curveGrumpkin(), label);
        gamma_2 = Field.reverse256(gamma_2);

        return (transcript, gamma_2);
    }

    function compute_gamma_2_primary(KeccakTranscriptLib.KeccakTranscript memory transcript)
        public
        pure
        returns (KeccakTranscriptLib.KeccakTranscript memory, uint256)
    {
        uint8[] memory label = new uint8[](2);
        label[0] = 0x67; // Rust's b"g2"
        label[1] = 0x32;

        uint256 gamma_2;
        (transcript, gamma_2) = KeccakTranscriptLib.squeeze(transcript, ScalarFromUniformLib.curveBn256(), label);
        gamma_2 = Field.reverse256(gamma_2);

        return (transcript, gamma_2);
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

        Grumpkin.GrumpkinAffinePoint[] memory comm_output_vec =
            new Grumpkin.GrumpkinAffinePoint[](comm_output_arr.length);
        uint256 index;
        for (index = 0; index < comm_output_vec.length; index++) {
            comm_output_vec[index] = Grumpkin.decompress(comm_output_arr[index]);
        }

        uint8[] memory label = new uint8[](1);
        label[0] = 0x6f; // Rust's b"o"

        transcript = KeccakTranscriptLib.absorb(transcript, label, comm_output_vec);

        label[0] = 0x63; // Rust's b"c"

        transcript = KeccakTranscriptLib.absorb(transcript, label, claims_product_arr);

        uint256 num_rounds = CommonUtilities.log2(vk.vk_secondary.S_comm.N);

        label[0] = 0x65; // Rust's b"e"
        uint256[] memory rand_eq = new uint256[](num_rounds);
        for (index = 0; index < num_rounds; index++) {
            (transcript, rand_eq[index]) =
                KeccakTranscriptLib.squeeze(transcript, ScalarFromUniformLib.curveGrumpkin(), label);
            rand_eq[index] = Field.reverse256(rand_eq[index]);
        }

        return (transcript, rand_eq);
    }

    function compute_rand_eq_primary(
        Abstractions.CompressedSnark calldata proof,
        Abstractions.VerifierKey calldata vk,
        KeccakTranscriptLib.KeccakTranscript memory transcript
    ) public view returns (KeccakTranscriptLib.KeccakTranscript memory, uint256[] memory) {
        uint256[] memory claims_product_arr = proof.r_W_snark_primary.claims_product_arr;
        require(claims_product_arr.length == 8, "[Step3.compute_rand_eq]: claims_product_arr.length != 8");

        uint256[] memory comm_output_arr = proof.r_W_snark_primary.comm_output_arr;
        require(comm_output_arr.length == 8, "[Step3.compute_rand_eq]: comm_output_arr.length != 8");

        Bn256.Bn256AffinePoint[] memory comm_output_vec = new Bn256.Bn256AffinePoint[](comm_output_arr.length);
        uint256 index;
        for (index = 0; index < comm_output_vec.length; index++) {
            comm_output_vec[index] = Bn256.decompress(comm_output_arr[index]);
        }

        uint8[] memory label = new uint8[](1);
        label[0] = 0x6f; // Rust's b"o"

        transcript = KeccakTranscriptLib.absorb(transcript, label, comm_output_vec);

        label[0] = 0x63; // Rust's b"c"

        transcript = KeccakTranscriptLib.absorb(transcript, label, claims_product_arr);

        uint256 num_rounds = CommonUtilities.log2(vk.vk_secondary.S_comm.N);

        label[0] = 0x65; // Rust's b"e"
        uint256[] memory rand_eq = new uint256[](num_rounds);
        for (index = 0; index < num_rounds; index++) {
            (transcript, rand_eq[index]) =
                KeccakTranscriptLib.squeeze(transcript, ScalarFromUniformLib.curveBn256(), label);
            rand_eq[index] = Field.reverse256(rand_eq[index]);
        }

        return (transcript, rand_eq);
    }

    function compute_coeffs_primary(KeccakTranscriptLib.KeccakTranscript memory transcript)
        public
        pure
        returns (KeccakTranscriptLib.KeccakTranscript memory, uint256[] memory)
    {
        uint8[] memory label = new uint8[](1);
        label[0] = 0x72; // Rust's b"r"

        // in Rust length of coeffs is hardcoded to 10
        uint256[] memory coeffs = new uint256[](10);
        (transcript, coeffs[0]) = KeccakTranscriptLib.squeeze(transcript, ScalarFromUniformLib.curveBn256(), label);
        coeffs[0] = Field.reverse256(coeffs[0]);

        for (uint256 index = 1; index < coeffs.length; index++) {
            coeffs[index] = mulmod(coeffs[index - 1], coeffs[0], Bn256.R_MOD);
        }
        return (transcript, coeffs);
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
        (transcript, coeffs[0]) = KeccakTranscriptLib.squeeze(transcript, ScalarFromUniformLib.curveGrumpkin(), label);
        coeffs[0] = Field.reverse256(coeffs[0]);

        for (uint256 index = 1; index < coeffs.length; index++) {
            coeffs[index] = mulmod(coeffs[index - 1], coeffs[0], Grumpkin.P_MOD);
        }
        return (transcript, coeffs);
    }
}
