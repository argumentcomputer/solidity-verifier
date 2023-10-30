// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.16;

import "@std/Test.sol";
import "src/NovaVerifierAbstractions.sol";
import "src/blocks/KeccakTranscript.sol";
import "src/blocks/PolyEvalInstance.sol";
import "src/blocks/EqPolynomial.sol";
import "src/blocks/Sumcheck.sol";

library Step7GrumpkinZeromorphLib {
    function compute_claim_batch_final_right(
        Abstractions.RelaxedR1CSSNARK memory proof,
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
        (transcript, c) = KeccakTranscriptLib.squeeze(transcript, ScalarFromUniformLib.curveBn256(), label);
        c = Field.reverse256(c);

        return (transcript, c);
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
        (transcript, c) = KeccakTranscriptLib.squeeze(transcript, ScalarFromUniformLib.curveGrumpkin(), label);
        c = Field.reverse256(c);

        return (transcript, c);
    }

    function compute_u_secondary(
        Abstractions.RelaxedR1CSSNARK calldata proof,
        Abstractions.VerifierKeyS2Zeromorph calldata vk,
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

        Grumpkin.GrumpkinAffinePoint[] memory comm_vec = new Grumpkin.GrumpkinAffinePoint[](9);
        comm_vec[0] = Grumpkin.decompress(proof.comm_Az);
        //console.logBytes32(bytes32(comm_vec[0].x));
        comm_vec[1] = Grumpkin.decompress(proof.comm_Bz);
        //console.logBytes32(bytes32(comm_vec[1].x));
        comm_vec[2] = Grumpkin.decompress(proof.comm_Cz);
        //console.logBytes32(bytes32(comm_vec[2].x));
        comm_vec[3] = Grumpkin.GrumpkinAffinePoint(U_comm_E_x, U_comm_E_y);
        //console.logBytes32(bytes32(comm_vec[3].x));
        comm_vec[4] = Grumpkin.decompress(proof.comm_E_row);
        //console.logBytes32(bytes32(comm_vec[4].x));
        comm_vec[5] = Grumpkin.decompress(proof.comm_E_col);
        //console.logBytes32(bytes32(comm_vec[5].x));
        comm_vec[6] = Grumpkin.decompress(vk.S_comm.comm_val_A);
        //console.logBytes32(bytes32(comm_vec[6].x));
        comm_vec[7] = Grumpkin.decompress(vk.S_comm.comm_val_B);
        //console.logBytes32(bytes32(comm_vec[7].x));
        comm_vec[8] = Grumpkin.decompress(vk.S_comm.comm_val_C);
        //console.logBytes32(bytes32(comm_vec[8].x));

        return PolyEvalInstanceLib.batchGrumpkin(comm_vec, r_sat, eval_vec, c);
    }

    function compute_u_primary(
        Abstractions.RelaxedR1CSSNARK calldata proof,
        Abstractions.VerifierKeyS1Zeromorph calldata vk,
        uint256 U_comm_E_x,
        uint256 U_comm_E_y,
        uint256[] memory r_sat,
        uint256 c
    ) public returns (PolyEvalInstanceLib.PolyEvalInstance memory) {
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

        Bn256.Bn256AffinePoint[] memory comm_vec = new Bn256.Bn256AffinePoint[](9);
        comm_vec[0] = Bn256.decompress(proof.comm_Az);
        comm_vec[1] = Bn256.decompress(proof.comm_Bz);
        comm_vec[2] = Bn256.decompress(proof.comm_Cz);
        comm_vec[3] = Bn256.Bn256AffinePoint(U_comm_E_x, U_comm_E_y);
        comm_vec[4] = Bn256.decompress(proof.comm_E_row);
        comm_vec[5] = Bn256.decompress(proof.comm_E_col);
        comm_vec[6] = Bn256.decompress(vk.S_comm.comm_val_A);
        comm_vec[7] = Bn256.decompress(vk.S_comm.comm_val_B);
        comm_vec[8] = Bn256.decompress(vk.S_comm.comm_val_C);

        return PolyEvalInstanceLib.batchBn256(comm_vec, r_sat, eval_vec, c);
    }

    function compute_rho_primary(KeccakTranscriptLib.KeccakTranscript memory transcript)
        public
        pure
        returns (KeccakTranscriptLib.KeccakTranscript memory, uint256)
    {
        uint8[] memory label = new uint8[](1);
        label[0] = 0x72; // Rust's b"r"

        uint256 rho;
        (transcript, rho) = KeccakTranscriptLib.squeeze(transcript, ScalarFromUniformLib.curveBn256(), label);
        rho = Field.reverse256(rho);

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
        (transcript, rho) = KeccakTranscriptLib.squeeze(transcript, ScalarFromUniformLib.curveGrumpkin(), label);
        rho = Field.reverse256(rho);

        return (transcript, rho);
    }

    function extract_sumcheck_proof(Abstractions.SumcheckProof memory proof)
        private
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

    function compute_claim_batch_final_left_secondary(
        Abstractions.SumcheckProof memory proof,
        KeccakTranscriptLib.KeccakTranscript memory transcript,
        uint256 claim_batch_joint,
        uint256 num_rounds_z
    ) internal returns (KeccakTranscriptLib.KeccakTranscript memory, uint256, uint256[] memory) {
        SumcheckUtilities.SumcheckProof memory sumcheckProof = extract_sumcheck_proof(proof);

        uint256 claim_batch_final_left;
        uint256[] memory r_z;
        // Reference verifier uses hardcoded degreeBound = 2
        (claim_batch_final_left, r_z, transcript) =
            SumcheckGrumpkin.verify(sumcheckProof, claim_batch_joint, num_rounds_z, 2, transcript);

        return (transcript, claim_batch_final_left, r_z);
    }

    function compute_claim_batch_final_left_primary(
        Abstractions.SumcheckProof memory proof,
        KeccakTranscriptLib.KeccakTranscript memory transcript,
        uint256 claim_batch_joint,
        uint256 num_rounds_z
    ) internal returns (KeccakTranscriptLib.KeccakTranscript memory, uint256, uint256[] memory) {
        SumcheckUtilities.SumcheckProof memory sumcheckProof = extract_sumcheck_proof(proof);

        uint256 claim_batch_final_left;
        uint256[] memory r_z;
        // Reference verifier uses hardcoded degreeBound = 2
        (claim_batch_final_left, r_z, transcript) =
            SumcheckBn256.verify(sumcheckProof, claim_batch_joint, num_rounds_z, 2, transcript);

        return (transcript, claim_batch_final_left, r_z);
    }
}
