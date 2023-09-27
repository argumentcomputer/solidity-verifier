// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.16;

import "@std/Test.sol";
import "src/verifier/Step3.sol";
import "src/blocks/EqPolynomial.sol";
import "src/blocks/PolyEvalInstance.sol";
import "src/blocks/KeccakTranscript.sol";
import "src/NovaVerifierAbstractions.sol";
import "src/blocks/Sumcheck.sol";

library Step7Lib {
    function compute_claim_batch_final_right(
        Abstractions.RelaxedR1CSSNARK storage proof,
        uint256[] memory r_z,
        PolyEvalInstanceLib.PolyEvalInstance[] memory u_vec_padded,
        uint256[] memory powers_of_rho,
        uint256 modulus,
        function (uint256) returns (uint256) negateBase
    ) internal returns (uint256) {
        require(u_vec_padded.length == proof.evals_batch_arr.length);
        require(powers_of_rho.length == proof.evals_batch_arr.length);

        uint256[] memory evals = new uint256[](u_vec_padded.length);
        uint256 index = 0;
        for (index = 0; index < u_vec_padded.length; index++) {
            evals[index] = EqPolinomialLib.evaluate(r_z, u_vec_padded[index].x, modulus, negateBase);
        }

        uint256 result;
        uint256 e_i;
        uint256 p_i;
        uint256 rho_i;
        for (index = 0; index < evals.length; index++) {
            e_i = evals[index];
            p_i = proof.evals_batch_arr[index];
            rho_i = powers_of_rho[index];
            assembly {
                e_i := mulmod(e_i, p_i, modulus)
                e_i := mulmod(e_i, rho_i, modulus)
                result := addmod(e_i, result, modulus)
            }
        }
        return result;
    }

    function extract_sumcheck_proof(Abstractions.SumcheckProof storage proof)
        private
        view
        returns (PolyLib.SumcheckProof memory)
    {
        // TODO: simplify conversions between abstractions
        Abstractions.CompressedPolys[] memory polys = proof.compressed_polys;
        PolyLib.CompressedUniPoly[] memory compressed_polys = new PolyLib.CompressedUniPoly[](polys.length);
        uint256 index = 0;
        for (index = 0; index < polys.length; index++) {
            compressed_polys[index] = PolyLib.CompressedUniPoly(polys[index].coeffs_except_linear_term);
        }
        return PolyLib.SumcheckProof(compressed_polys);
    }

    function compute_claim_batch_final_left_secondary(
        Abstractions.SumcheckProof storage proof,
        KeccakTranscriptLib.KeccakTranscript memory transcript,
        uint256 claim_batch_joint,
        uint256 num_rounds_z
    ) internal returns (KeccakTranscriptLib.KeccakTranscript memory, uint256, uint256[] memory) {
        PolyLib.SumcheckProof memory sumcheckProof = extract_sumcheck_proof(proof);

        uint256 claim_batch_final_left;
        uint256[] memory r_z;
        // Reference verifier uses hardcoded degreeBound = 2
        (claim_batch_final_left, r_z, transcript) =
            SecondarySumcheck.verify(sumcheckProof, claim_batch_joint, num_rounds_z, 2, transcript);

        return (transcript, claim_batch_final_left, r_z);
    }

    function compute_claim_batch_final_left_primary(
        Abstractions.SumcheckProof storage proof,
        KeccakTranscriptLib.KeccakTranscript memory transcript,
        uint256 claim_batch_joint,
        uint256 num_rounds_z
    ) internal returns (KeccakTranscriptLib.KeccakTranscript memory, uint256, uint256[] memory) {
        PolyLib.SumcheckProof memory sumcheckProof = extract_sumcheck_proof(proof);

        uint256 claim_batch_final_left;
        uint256[] memory r_z;
        // Reference verifier uses hardcoded degreeBound = 2
        (claim_batch_final_left, r_z, transcript) =
            PrimarySumcheck.verify(sumcheckProof, claim_batch_joint, num_rounds_z, 2, transcript);

        return (transcript, claim_batch_final_left, r_z);
    }

    function compute_c_secondary(
        Abstractions.RelaxedR1CSSNARK calldata proof,
        KeccakTranscriptLib.KeccakTranscript memory transcript
    ) public pure returns (KeccakTranscriptLib.KeccakTranscript memory, uint256) {
        uint256[] memory eval_vec = new uint256[](9);
        eval_vec[0] = proof.eval_Az;
        eval_vec[1] = proof.eval_Bz;
        eval_vec[2] = proof.eval_Cz;
        eval_vec[3] = proof.eval_E;
        eval_vec[4] = proof.eval_E_row;
        eval_vec[5] = proof.eval_E_col;
        eval_vec[6] = proof.eval_val_A;
        eval_vec[7] = proof.eval_val_B;
        eval_vec[8] = proof.eval_val_C;

        uint8[] memory label = new uint8[](1);
        label[0] = 0x65; // Rust's b"e"

        transcript = KeccakTranscriptLib.absorb(transcript, label, eval_vec);

        label[0] = 0x63; // Rust's b"c"

        uint256 c;
        (transcript, c) = KeccakTranscriptLib.squeeze(transcript, ScalarFromUniformLib.curvePallas(), label);

        return (transcript, c);
    }

    function compute_c_primary(
        Abstractions.RelaxedR1CSSNARK calldata proof,
        KeccakTranscriptLib.KeccakTranscript memory transcript
    ) public pure returns (KeccakTranscriptLib.KeccakTranscript memory, uint256) {
        uint256[] memory eval_vec = new uint256[](9);
        eval_vec[0] = proof.eval_Az;
        eval_vec[1] = proof.eval_Bz;
        eval_vec[2] = proof.eval_Cz;
        eval_vec[3] = proof.eval_E;
        eval_vec[4] = proof.eval_E_row;
        eval_vec[5] = proof.eval_E_col;
        eval_vec[6] = proof.eval_val_A;
        eval_vec[7] = proof.eval_val_B;
        eval_vec[8] = proof.eval_val_C;

        uint8[] memory label = new uint8[](1);
        label[0] = 0x65; // Rust's b"e"

        transcript = KeccakTranscriptLib.absorb(transcript, label, eval_vec);

        label[0] = 0x63; // Rust's b"c"

        uint256 c;
        (transcript, c) = KeccakTranscriptLib.squeeze(transcript, ScalarFromUniformLib.curveVesta(), label);

        return (transcript, c);
    }

    function compute_rho_primary(KeccakTranscriptLib.KeccakTranscript memory transcript)
        public
        pure
        returns (KeccakTranscriptLib.KeccakTranscript memory, uint256)
    {
        uint8[] memory label = new uint8[](1);
        label[0] = 0x72; // Rust's b"r"

        uint256 rho;
        (transcript, rho) = KeccakTranscriptLib.squeeze(transcript, ScalarFromUniformLib.curveVesta(), label);

        return (transcript, rho);
    }

    function compute_rho_secondary(KeccakTranscriptLib.KeccakTranscript memory transcript)
        public
        pure
        returns (KeccakTranscriptLib.KeccakTranscript memory, uint256)
    {
        uint8[] memory label = new uint8[](1);
        label[0] = 0x72; // Rust's b"r"

        uint256 rho;
        (transcript, rho) = KeccakTranscriptLib.squeeze(transcript, ScalarFromUniformLib.curvePallas(), label);

        return (transcript, rho);
    }

    function compute_sc_proof_batch_verification_input(
        PolyEvalInstanceLib.PolyEvalInstance[] memory u_vec_padded,
        uint256 rho,
        uint256 modulus
    ) public pure returns (uint256, uint256, uint256[] memory) {
        require(u_vec_padded.length >= 1, "u_vec_padded.length is empty");

        uint256 num_rounds_z = u_vec_padded[0].x.length;

        uint256 num_claims = u_vec_padded.length;

        uint256[] memory powers_of_rho = CommonUtilities.powers(rho, num_claims, modulus);

        require(powers_of_rho.length == u_vec_padded.length, "powers_of_rho.length != u_vec_padded.length");

        uint256 u_vec_padded_e_item;
        uint256 powers_of_rho_item;
        uint256 claim_batch_joint;

        for (uint256 index = 0; index < u_vec_padded.length; index++) {
            u_vec_padded_e_item = u_vec_padded[index].e;
            powers_of_rho_item = powers_of_rho[index];
            assembly {
                u_vec_padded_e_item := mulmod(u_vec_padded_e_item, powers_of_rho_item, modulus)
                claim_batch_joint := addmod(u_vec_padded_e_item, claim_batch_joint, modulus)
            }
        }

        return (claim_batch_joint, num_rounds_z, powers_of_rho);
    }

    function compute_u_vec_padded(PolyEvalInstanceLib.PolyEvalInstance[] memory u_vec)
        public
        pure
        returns (PolyEvalInstanceLib.PolyEvalInstance[] memory)
    {
        return PolyEvalInstanceLib.pad(u_vec);
    }

    function compute_u_primary(
        Abstractions.RelaxedR1CSSNARK calldata proof,
        Abstractions.VerifierKeyS1 calldata vk,
        uint256 U_comm_E_x,
        uint256 U_comm_E_y,
        uint256[] memory r_sat,
        uint256 c
    ) public view returns (PolyEvalInstanceLib.PolyEvalInstance memory) {
        uint256[] memory eval_vec = new uint256[](9);
        eval_vec[0] = proof.eval_Az;
        eval_vec[1] = proof.eval_Bz;
        eval_vec[2] = proof.eval_Cz;
        eval_vec[3] = proof.eval_E;
        eval_vec[4] = proof.eval_E_row;
        eval_vec[5] = proof.eval_E_col;
        eval_vec[6] = proof.eval_val_A;
        eval_vec[7] = proof.eval_val_B;
        eval_vec[8] = proof.eval_val_C;

        Pallas.PallasAffinePoint[] memory comm_vec = new Pallas.PallasAffinePoint[](9);
        comm_vec[0] = Pallas.decompress(proof.comm_Az);
        comm_vec[1] = Pallas.decompress(proof.comm_Bz);
        comm_vec[2] = Pallas.decompress(proof.comm_Cz);
        comm_vec[3] = Pallas.PallasAffinePoint(U_comm_E_x, U_comm_E_y);
        comm_vec[4] = Pallas.decompress(proof.comm_E_row);
        comm_vec[5] = Pallas.decompress(proof.comm_E_col);
        comm_vec[6] = Pallas.decompress(vk.S_comm.comm_val_A);
        comm_vec[7] = Pallas.decompress(vk.S_comm.comm_val_B);
        comm_vec[8] = Pallas.decompress(vk.S_comm.comm_val_C);

        return PolyEvalInstanceLib.batchPrimary(comm_vec, r_sat, eval_vec, c);
    }

    function compute_u_secondary(
        Abstractions.RelaxedR1CSSNARK calldata proof,
        Abstractions.VerifierKeyS2 calldata vk,
        uint256 U_comm_E_x,
        uint256 U_comm_E_y,
        uint256[] memory r_sat,
        uint256 c
    ) public view returns (PolyEvalInstanceLib.PolyEvalInstance memory) {
        uint256[] memory eval_vec = new uint256[](9);
        eval_vec[0] = proof.eval_Az;
        eval_vec[1] = proof.eval_Bz;
        eval_vec[2] = proof.eval_Cz;
        eval_vec[3] = proof.eval_E;
        eval_vec[4] = proof.eval_E_row;
        eval_vec[5] = proof.eval_E_col;
        eval_vec[6] = proof.eval_val_A;
        eval_vec[7] = proof.eval_val_B;
        eval_vec[8] = proof.eval_val_C;

        Vesta.VestaAffinePoint[] memory comm_vec = new Vesta.VestaAffinePoint[](9);
        comm_vec[0] = Vesta.decompress(proof.comm_Az);
        comm_vec[1] = Vesta.decompress(proof.comm_Bz);
        comm_vec[2] = Vesta.decompress(proof.comm_Cz);
        comm_vec[3] = Vesta.VestaAffinePoint(U_comm_E_x, U_comm_E_y);
        comm_vec[4] = Vesta.decompress(proof.comm_E_row);
        comm_vec[5] = Vesta.decompress(proof.comm_E_col);
        comm_vec[6] = Vesta.decompress(vk.S_comm.comm_val_A);
        comm_vec[7] = Vesta.decompress(vk.S_comm.comm_val_B);
        comm_vec[8] = Vesta.decompress(vk.S_comm.comm_val_C);

        return PolyEvalInstanceLib.batchSecondary(comm_vec, r_sat, eval_vec, c);
    }
}
