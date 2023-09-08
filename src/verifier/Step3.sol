// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.16;

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
            console.log("------------------[Step3Lib::final_verification]------------------");
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
        Abstractions.RelaxedR1CSSNARK calldata proof,
        uint256 c_inner,
        uint256[] memory coeffs,
        uint256 modulus
    ) public view returns (uint256) {
        if (coeffs.length < 10) {
            console.log("[Step3Lib:compute_claim_inner_final] coeffs.len < 10");
            revert();
        }

        uint256 self_eval_val_A = proof.eval_val_A;
        uint256 self_eval_val_B = proof.eval_val_B;
        uint256 self_eval_val_C = proof.eval_val_C;
        uint256 self_eval_E_col = proof.eval_E_col;
        uint256 self_eval_E_row = proof.eval_E_row;
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
        Abstractions.RelaxedR1CSSNARK storage proof,
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

    function compute_claim_mem_final(
        Abstractions.RelaxedR1CSSNARK storage proof,
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
            console.log("-----------compute_claim_sat_final_r_sat_primary------------");
            console.log("CompressedUniPoly");
            for (uint256 index = 0; index < sumcheckProof.compressed_polys.length; index++) {
                console.log(index);
                for (uint256 i = 0; i < sumcheckProof.compressed_polys[index].coeffs_except_linear_term.length; i++) {
                    console.logBytes32(bytes32(sumcheckProof.compressed_polys[index].coeffs_except_linear_term[i]));
                }
            }
        }

        // degreeBound is hardcoded to 3 in Rust
        return PrimarySumcheck.verify(
            sumcheckProof,
            compute_sumcheck_claim(claim_inner, coeffs, p_modulus),
            CommonUtilities.log2(vk.S_comm.N),
            3,
            transcript
        );
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
        return SecondarySumcheck.verify(
            sumcheckProof,
            compute_sumcheck_claim(claim_inner, coeffs, p_modulus),
            CommonUtilities.log2(vk.S_comm.N),
            3,
            transcript
        );
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
        (transcript, coeffs[0]) = KeccakTranscriptLib.squeeze(transcript, ScalarFromUniformLib.curveVesta(), label);
        coeffs[0] = Field.reverse256(coeffs[0]);

        for (uint256 index = 1; index < coeffs.length; index++) {
            coeffs[index] = mulmod(coeffs[index - 1], coeffs[0], Vesta.P_MOD);
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
        (transcript, coeffs[0]) = KeccakTranscriptLib.squeeze(transcript, ScalarFromUniformLib.curvePallas(), label);
        coeffs[0] = Field.reverse256(coeffs[0]);

        for (uint256 index = 1; index < coeffs.length; index++) {
            coeffs[index] = mulmod(coeffs[index - 1], coeffs[0], Pallas.P_MOD);
        }
        return (transcript, coeffs);
    }

    function compute_rand_eq_primary(
        Abstractions.RelaxedR1CSSNARK calldata proof,
        Abstractions.VerifierKeyS1 calldata vk,
        KeccakTranscriptLib.KeccakTranscript memory transcript
    ) public view returns (KeccakTranscriptLib.KeccakTranscript memory, uint256[] memory) {
        uint256[] memory claims_product_arr = proof.claims_product_arr;
        require(claims_product_arr.length == 8, "[Step3.compute_rand_eq_primary]: claims_product_arr.length != 8");

        uint256[] memory comm_output_arr = proof.comm_output_arr;
        require(comm_output_arr.length == 8, "[Step3.compute_rand_eq_primary]: comm_output_arr.length != 8");

        Pallas.PallasAffinePoint[] memory comm_output_vec = new Pallas.PallasAffinePoint[](comm_output_arr.length);
        uint256 index;
        for (index = 0; index < comm_output_vec.length; index++) {
            comm_output_vec[index] = Pallas.decompress(comm_output_arr[index]);
        }

        uint8[] memory label = new uint8[](1);
        label[0] = 0x6f; // Rust's b"o"

        transcript = KeccakTranscriptLib.absorb(transcript, label, Abstractions.toTranscriptBytes(comm_output_vec));

        label[0] = 0x63; // Rust's b"c"

        transcript = KeccakTranscriptLib.absorb(transcript, label, Abstractions.toTranscriptBytes(claims_product_arr));

        uint256 num_rounds = CommonUtilities.log2(vk.S_comm.N);

        label[0] = 0x65; // Rust's b"e"
        uint256[] memory rand_eq = new uint256[](num_rounds);
        for (index = 0; index < num_rounds; index++) {
            (transcript, rand_eq[index]) =
                KeccakTranscriptLib.squeeze(transcript, ScalarFromUniformLib.curveVesta(), label);
            rand_eq[index] = Field.reverse256(rand_eq[index]);
        }

        return (transcript, rand_eq);
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

        transcript = KeccakTranscriptLib.absorb(transcript, label, Abstractions.toTranscriptBytes(comm_output_vec));

        label[0] = 0x63; // Rust's b"c"

        transcript = KeccakTranscriptLib.absorb(transcript, label, Abstractions.toTranscriptBytes(claims_product_arr));

        uint256 num_rounds = CommonUtilities.log2(vk.vk_secondary.S_comm.N);

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

    function compute_u_primary(Abstractions.RelaxedR1CSSNARK calldata proof, uint256[] memory tau, uint256 c)
        public
        view
        returns (PolyEvalInstanceLib.PolyEvalInstance memory)
    {
        uint256[] memory evals = new uint256[](3);
        evals[0] = proof.eval_Az_at_tau;
        evals[1] = proof.eval_Bz_at_tau;
        evals[2] = proof.eval_Cz_at_tau;

        Pallas.PallasAffinePoint[] memory comm_vec = new Pallas.PallasAffinePoint[](3);
        comm_vec[0] = Pallas.decompress(proof.comm_Az);
        comm_vec[1] = Pallas.decompress(proof.comm_Bz);
        comm_vec[2] = Pallas.decompress(proof.comm_Cz);

        return PolyEvalInstanceLib.batchPrimary(comm_vec, tau, evals, c);
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

        transcript = KeccakTranscriptLib.absorb(transcript, label, Abstractions.toTranscriptBytes(evals));
        transcript = KeccakTranscriptLib.absorb(transcript, label, Abstractions.toTranscriptBytes(comms_E));

        // Question to reference implemnetation: Do we need this absorbing, that duplicates one above?
        transcript = KeccakTranscriptLib.absorb(transcript, label, Abstractions.toTranscriptBytes(evals));

        label[0] = 0x63; // Rust's b"c"
        uint256 c;
        (transcript, c) = KeccakTranscriptLib.squeeze(transcript, ScalarFromUniformLib.curvePallas(), label);
        c = Field.reverse256(c);

        return (transcript, c);
    }

    function compute_c_primary(
        Abstractions.RelaxedR1CSSNARK calldata proof,
        KeccakTranscriptLib.KeccakTranscript memory transcript
    ) public view returns (KeccakTranscriptLib.KeccakTranscript memory, uint256) {
        Pallas.PallasAffinePoint[] memory comms_E = new Pallas.PallasAffinePoint[](2);
        comms_E[0] = Pallas.decompress(proof.comm_E_row);
        comms_E[1] = Pallas.decompress(proof.comm_E_col);

        uint256[] memory evals = new uint256[](3);
        evals[0] = proof.eval_Az_at_tau;
        evals[1] = proof.eval_Bz_at_tau;
        evals[2] = proof.eval_Cz_at_tau;

        uint8[] memory label = new uint8[](1);
        label[0] = 0x65; // Rust's b"e"

        transcript = KeccakTranscriptLib.absorb(transcript, label, Abstractions.toTranscriptBytes(evals));
        transcript = KeccakTranscriptLib.absorb(transcript, label, Abstractions.toTranscriptBytes(comms_E));

        // Question to reference implemnetation: Do we need this absorbing, that duplicates one above?
        transcript = KeccakTranscriptLib.absorb(transcript, label, Abstractions.toTranscriptBytes(evals));

        label[0] = 0x63; // Rust's b"c"
        uint256 c;
        (transcript, c) = KeccakTranscriptLib.squeeze(transcript, ScalarFromUniformLib.curveVesta(), label);
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

    function compute_gamma_1_primary(KeccakTranscriptLib.KeccakTranscript memory transcript)
        public
        pure
        returns (KeccakTranscriptLib.KeccakTranscript memory, uint256)
    {
        uint8[] memory label = new uint8[](2);
        label[0] = 0x67; // Rust's b"g1"
        label[1] = 0x31;

        uint256 gamma_1;
        (transcript, gamma_1) = KeccakTranscriptLib.squeeze(transcript, ScalarFromUniformLib.curveVesta(), label);
        gamma_1 = Field.reverse256(gamma_1);

        return (transcript, gamma_1);
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
        (transcript, gamma_2) = KeccakTranscriptLib.squeeze(transcript, ScalarFromUniformLib.curveVesta(), label);
        gamma_2 = Field.reverse256(gamma_2);

        return (transcript, gamma_2);
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
        transcript = KeccakTranscriptLib.absorb(transcript, label, Abstractions.toTranscriptBytes(proof.r_U_primary));

        label = new uint8[](1); // Rust's b"c"
        label[0] = 0x63;

        Pallas.PallasAffinePoint[] memory commitments = new Pallas.PallasAffinePoint[](3);
        commitments[0] = Pallas.decompress(proof.r_W_snark_primary.comm_Az);
        commitments[1] = Pallas.decompress(proof.r_W_snark_primary.comm_Bz);
        commitments[2] = Pallas.decompress(proof.r_W_snark_primary.comm_Cz);

        transcript = KeccakTranscriptLib.absorb(transcript, label, Abstractions.toTranscriptBytes(commitments));

        label = new uint8[](1); // Rust's b"t"
        label[0] = 0x74;

        uint256[] memory tau = new uint256[](17);

        for (uint256 index = 0; index < tau.length; index++) {
            (transcript, tau[index]) = KeccakTranscriptLib.squeeze(transcript, ScalarFromUniformLib.curveVesta(), label);
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
        Vesta.VestaAffinePoint memory f_U_secondary_comm_W,
        Vesta.VestaAffinePoint memory f_U_secondary_comm_E,
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
            transcript,
            label,
            Abstractions.toTranscriptBytes(f_U_secondary_comm_W, f_U_secondary_comm_E, f_U_secondary_X, f_U_secondary_u)
        );

        label = new uint8[](1); // Rust's b"c"
        label[0] = 0x63;

        Vesta.VestaAffinePoint[] memory commitments = new Vesta.VestaAffinePoint[](3);
        commitments[0] = Vesta.decompress(proof.f_W_snark_secondary.comm_Az);
        commitments[1] = Vesta.decompress(proof.f_W_snark_secondary.comm_Bz);
        commitments[2] = Vesta.decompress(proof.f_W_snark_secondary.comm_Cz);

        transcript = KeccakTranscriptLib.absorb(transcript, label, Abstractions.toTranscriptBytes(commitments));

        label = new uint8[](1); // Rust's b"t"
        label[0] = 0x74;

        uint256 num_rounds_sat = CommonUtilities.log2(vk.S_comm.N);

        uint256[] memory tau = new uint256[](num_rounds_sat);

        for (uint256 index = 0; index < tau.length; index++) {
            (transcript, tau[index]) =
                KeccakTranscriptLib.squeeze(transcript, ScalarFromUniformLib.curvePallas(), label);
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
}
