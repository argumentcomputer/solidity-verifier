// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.16;

import "@std/Test.sol";
import "src/NovaVerifierAbstractions.sol";
import "src/verifier/Step5.sol";
import "src/blocks/KeccakTranscript.sol";

library Step5GrumpkinLib {
    function compute_c_primary(
        Abstractions.RelaxedR1CSSNARK memory proof,
        KeccakTranscriptLib.KeccakTranscript memory transcript
    ) public view returns (KeccakTranscriptLib.KeccakTranscript memory, uint256) {
        uint256[] memory input = compute_c_inner(proof);

        uint8[] memory label = new uint8[](1);
        label[0] = 0x65; // Rust's b"e"

        transcript = KeccakTranscriptLib.absorb(transcript, label, input);

        label[0] = 0x63; // Rust's b"c"

        uint256 output;
        (transcript, output) = KeccakTranscriptLib.squeeze(transcript, ScalarFromUniformLib.curveBn256(), label);
        output = Field.reverse256(output);

        return (transcript, output);
    }

    function compute_c_secondary(
        Abstractions.RelaxedR1CSSNARK memory proof,
        KeccakTranscriptLib.KeccakTranscript memory transcript
    ) public view returns (KeccakTranscriptLib.KeccakTranscript memory, uint256) {
        uint256[] memory input = compute_c_inner(proof);

        uint8[] memory label = new uint8[](1);
        label[0] = 0x65; // Rust's b"e"

        transcript = KeccakTranscriptLib.absorb(transcript, label, input);

        label[0] = 0x63; // Rust's b"c"

        uint256 output;
        (transcript, output) = KeccakTranscriptLib.squeeze(transcript, ScalarFromUniformLib.curveGrumpkin(), label);
        output = Field.reverse256(output);

        return (transcript, output);
    }

    // TODO think about reusing existing function with 'storage' proof
    function compute_c_inner(Abstractions.RelaxedR1CSSNARK memory proof) public view returns (uint256[] memory) {
        uint256 index = 0;
        uint256[] memory eval_vec =
            new uint256[](9 + proof.eval_left_arr.length + proof.eval_right_arr.length + proof.eval_output_arr.length);
        eval_vec[index] = proof.eval_Az;
        index++;

        eval_vec[index] = proof.eval_Bz;
        index++;

        eval_vec[index] = proof.eval_Cz;
        index++;

        eval_vec[index] = proof.eval_E;
        index++;

        eval_vec[index] = proof.eval_E_row;
        index++;

        eval_vec[index] = proof.eval_E_col;
        index++;

        eval_vec[index] = proof.eval_val_A;
        index++;

        eval_vec[index] = proof.eval_val_B;
        index++;

        eval_vec[index] = proof.eval_val_C;
        index++;

        for (uint256 i = 0; i < proof.eval_left_arr.length; i++) {
            eval_vec[index] = proof.eval_left_arr[i];
            index++;
        }

        for (uint256 i = 0; i < proof.eval_right_arr.length; i++) {
            eval_vec[index] = proof.eval_right_arr[i];
            index++;
        }

        for (uint256 i = 0; i < proof.eval_output_arr.length; i++) {
            eval_vec[index] = proof.eval_output_arr[i];
            index++;
        }

        return eval_vec;
    }

    function compute_claims_read_write(
        Abstractions.RelaxedR1CSSNARK memory proof,
        uint256 gamma1,
        uint256 gamma2,
        uint256 modulus,
        function (uint256) returns (uint256) negateBase
    ) internal returns (uint256, uint256) {
        uint256 claim_read = Step5Lib.hash_func(
            gamma1, gamma2, proof.eval_row, proof.eval_E_row_at_r_prod, proof.eval_row_read_ts, modulus, negateBase
        );

        uint256 ts_write = addmod(proof.eval_row_read_ts, 1, modulus);
        uint256 claim_write = Step5Lib.hash_func(
            gamma1, gamma2, proof.eval_row, proof.eval_E_row_at_r_prod, ts_write, modulus, negateBase
        );

        return (claim_read, claim_write);
    }

    function compute_u_vec_items_primary(
        Abstractions.RelaxedR1CSSNARK memory proof,
        Abstractions.VerifierKeyS1 memory vk,
        KeccakTranscriptLib.KeccakTranscript memory transcript,
        uint256[] memory r_sat,
        uint256[] memory r_prod
    ) public returns (KeccakTranscriptLib.KeccakTranscript memory, PolyEvalInstanceLib.PolyEvalInstance[] memory) {
        PolyEvalInstanceLib.PolyEvalInstance[] memory u_vec_items = new PolyEvalInstanceLib.PolyEvalInstance[](4);

        uint256[] memory powers_of_rho;
        (transcript, powers_of_rho) = compute_powers_of_rho_primary(proof, transcript);

        u_vec_items[0] = compute_u_vec_1_primary(proof, powers_of_rho, r_sat);
        u_vec_items[1] = compute_u_vec_2_primary(proof, powers_of_rho, r_sat);
        u_vec_items[2] = compute_u_vec_3_primary(proof, powers_of_rho, r_prod);
        (transcript, u_vec_items[3]) = compute_u_vec_4_primary(proof, vk, transcript, r_prod);

        return (transcript, u_vec_items);
    }

    function compute_powers_of_rho_primary(
        Abstractions.RelaxedR1CSSNARK memory proof,
        KeccakTranscriptLib.KeccakTranscript memory transcript
    ) public returns (KeccakTranscriptLib.KeccakTranscript memory, uint256[] memory) {
        uint256 i = 0;
        uint256[] memory evals = new uint256[](proof.eval_input_arr.length + proof.eval_output2_arr.length);

        uint256 index;
        //console.log("evals");
        for (index = 0; index < proof.eval_input_arr.length; index++) {
            //console.logBytes32(bytes32(proof.eval_input_arr[index]));
            evals[i] = proof.eval_input_arr[index];
            i++;
        }
        for (index = 0; index < proof.eval_output2_arr.length; index++) {
            //console.logBytes32(bytes32(proof.eval_output2_arr[index]));
            evals[i] = proof.eval_output2_arr[index];
            i++;
        }
        //console.log("#######");

        uint8[] memory label = new uint8[](1);
        label[0] = 0x65; // Rust's b"e"

        transcript = KeccakTranscriptLib.absorb(transcript, label, evals);

        label[0] = 0x72; // Rust's b"r"

        // num_claims is hardcoded to be equal to 10
        uint256 num_claims = 10;
        uint256[] memory rho = new uint256[](num_claims);
        (transcript, rho[0]) = KeccakTranscriptLib.squeeze(transcript, ScalarFromUniformLib.curveBn256(), label);
        rho[0] = Field.reverse256(rho[0]);

        for (index = 1; index < num_claims; index++) {
            rho[index] = mulmod(rho[index - 1], rho[0], Bn256.R_MOD);
        }

        return (transcript, rho);
    }

    function compute_u_vec_1_primary(
        Abstractions.RelaxedR1CSSNARK memory proof,
        uint256[] memory powers_of_rho,
        uint256[] memory r_sat
    ) public returns (PolyEvalInstanceLib.PolyEvalInstance memory) {
        require(
            proof.comm_output_arr.length == proof.eval_output_arr.length,
            "[Step5::compute_u_vec_1_primary] proof.comm_output_arr.length != proof.eval_output_arr.length"
        );
        require(
            powers_of_rho.length >= proof.comm_output_arr.length,
            "[Step5::compute_u_vec_1_primary] powers_of_rho.length < proof.comm_output_arr.length"
        );

        //console.log("proof.comm_output_arr");
        Bn256.Bn256AffinePoint[] memory comm_output_vec = new Bn256.Bn256AffinePoint[](proof.comm_output_arr.length);
        for (uint256 index = 0; index < comm_output_vec.length; index++) {
            //console.logBytes32(bytes32(proof.comm_output_arr[index]));
            comm_output_vec[index] = Bn256.decompress(proof.comm_output_arr[index]);
        }

        Bn256.Bn256AffinePoint memory comm_output;
        Bn256.Bn256AffinePoint memory scalarMul;
        //console.log("powers of rho");
        for (uint256 index = 0; index < comm_output_vec.length; index++) {
            //console.logBytes32(bytes32(powers_of_rho[index]));
            scalarMul = Bn256.scalarMul(comm_output_vec[index], powers_of_rho[index]);
            comm_output = Bn256.add(comm_output, scalarMul);
        }

        uint256 eval_output;
        uint256 tmp;
        for (uint256 index = 0; index < proof.eval_output_arr.length; index++) {
            tmp = mulmod(proof.eval_output_arr[index], powers_of_rho[index], Bn256.R_MOD);
            eval_output = addmod(eval_output, tmp, Bn256.R_MOD);
        }

        return PolyEvalInstanceLib.PolyEvalInstance(comm_output.x, comm_output.y, r_sat, eval_output);
    }

    function compute_u_vec_2_primary(
        Abstractions.RelaxedR1CSSNARK memory proof,
        uint256[] memory powers_of_rho,
        uint256[] memory r_sat
    ) public returns (PolyEvalInstanceLib.PolyEvalInstance memory) {
        require(
            proof.comm_output_arr.length == proof.claims_product_arr.length,
            "[Step5::compute_u_vec_2_primary] proof.comm_output_arr.length == proof.claims_product_arr.length"
        );
        require(
            powers_of_rho.length >= proof.claims_product_arr.length,
            "[Step5::compute_u_vec_2_primary] powers_of_rho.length >= proof.claims_product_arr.length"
        );

        Bn256.Bn256AffinePoint[] memory comm_output_vec = new Bn256.Bn256AffinePoint[](proof.comm_output_arr.length);
        for (uint256 index = 0; index < comm_output_vec.length; index++) {
            comm_output_vec[index] = Bn256.decompress(proof.comm_output_arr[index]);
        }

        Bn256.Bn256AffinePoint memory comm_output;
        Bn256.Bn256AffinePoint memory scalarMul;
        for (uint256 index = 0; index < comm_output_vec.length; index++) {
            scalarMul = Bn256.scalarMul(comm_output_vec[index], powers_of_rho[index]);
            comm_output = Bn256.add(comm_output, scalarMul);
        }

        uint256 product;
        uint256 tmp;
        for (uint256 index = 0; index < proof.claims_product_arr.length; index++) {
            tmp = mulmod(proof.claims_product_arr[index], powers_of_rho[index], Bn256.R_MOD);
            product = addmod(product, tmp, Bn256.R_MOD);
        }

        // claimed_product = output(1, ..., 1, 0)
        uint256[] memory x = new uint256[](r_sat.length);
        for (uint256 index = 0; index < x.length - 1; index++) {
            x[index] = 1;
        }

        return PolyEvalInstanceLib.PolyEvalInstance(comm_output.x, comm_output.y, x, product);
    }

    function compute_u_vec_3_primary(
        Abstractions.RelaxedR1CSSNARK memory proof,
        uint256[] memory powers_of_rho,
        uint256[] memory r_prod
    ) public returns (PolyEvalInstanceLib.PolyEvalInstance memory) {
        require(
            proof.comm_output_arr.length == proof.eval_output2_arr.length,
            "[Step5::compute_u_vec_3_primary] proof.comm_output_arr.length == proof.eval_output2_arr.length"
        );
        require(
            powers_of_rho.length >= proof.claims_product_arr.length,
            "[Step5::compute_u_vec_3_primary] powers_of_rho.length >= proof.claims_product_arr.length"
        );

        Bn256.Bn256AffinePoint[] memory comm_output_vec = new Bn256.Bn256AffinePoint[](proof.comm_output_arr.length);
        for (uint256 index = 0; index < comm_output_vec.length; index++) {
            comm_output_vec[index] = Bn256.decompress(proof.comm_output_arr[index]);
        }

        Bn256.Bn256AffinePoint memory comm_output;
        Bn256.Bn256AffinePoint memory scalarMul;
        for (uint256 index = 0; index < comm_output_vec.length; index++) {
            scalarMul = Bn256.scalarMul(comm_output_vec[index], powers_of_rho[index]);
            comm_output = Bn256.add(comm_output, scalarMul);
        }

        uint256 eval_output2;
        uint256 tmp;
        for (uint256 index = 0; index < proof.eval_output2_arr.length; index++) {
            tmp = mulmod(proof.eval_output2_arr[index], powers_of_rho[index], Bn256.R_MOD);
            eval_output2 = addmod(eval_output2, tmp, Bn256.R_MOD);
        }

        return PolyEvalInstanceLib.PolyEvalInstance(comm_output.x, comm_output.y, r_prod, eval_output2);
    }

    function compute_u_vec_4_primary(
        Abstractions.RelaxedR1CSSNARK memory proof,
        Abstractions.VerifierKeyS1 memory vk,
        KeccakTranscriptLib.KeccakTranscript memory transcript,
        uint256[] memory r_prod
    ) public returns (KeccakTranscriptLib.KeccakTranscript memory, PolyEvalInstanceLib.PolyEvalInstance memory) {
        uint256[] memory eval_vec = new uint256[](8);
        eval_vec[0] = proof.eval_row;
        eval_vec[1] = proof.eval_row_read_ts;
        eval_vec[2] = proof.eval_E_row_at_r_prod;
        eval_vec[3] = proof.eval_row_audit_ts;
        eval_vec[4] = proof.eval_col;
        eval_vec[5] = proof.eval_col_read_ts;
        eval_vec[6] = proof.eval_E_col_at_r_prod;
        eval_vec[7] = proof.eval_col_audit_ts;

        Bn256.Bn256AffinePoint[] memory comm_vec = new Bn256.Bn256AffinePoint[](8);
        comm_vec[0] = Bn256.decompress(vk.S_comm.comm_row);
        comm_vec[1] = Bn256.decompress(vk.S_comm.comm_row_read_ts);
        comm_vec[2] = Bn256.decompress(proof.comm_E_row);
        comm_vec[3] = Bn256.decompress(vk.S_comm.comm_row_audit_ts);
        comm_vec[4] = Bn256.decompress(vk.S_comm.comm_col);
        comm_vec[5] = Bn256.decompress(vk.S_comm.comm_col_read_ts);
        comm_vec[6] = Bn256.decompress(proof.comm_E_col);
        comm_vec[7] = Bn256.decompress(vk.S_comm.comm_col_audit_ts);

        uint256[] memory eval_vec_c = new uint256[](eval_vec.length + 1);
        //console.log("eval_vec_c");
        for (uint256 index = 0; index < eval_vec.length; index++) {
            eval_vec_c[index] = eval_vec[index];
            //console.logBytes32(bytes32(eval_vec_c[index]));
        }
        eval_vec_c[eval_vec_c.length - 1] = proof.eval_W;
        //console.logBytes32(bytes32(eval_vec_c[eval_vec_c.length - 1]));

        uint8[] memory label = new uint8[](1);
        label[0] = 0x65; // Rust's b"e"

        transcript = KeccakTranscriptLib.absorb(transcript, label, eval_vec_c);

        label[0] = 0x63; // Rust's b"c"

        uint256 c;
        (transcript, c) = KeccakTranscriptLib.squeeze(transcript, ScalarFromUniformLib.curveBn256(), label);
        c = Field.reverse256(c);

        return (transcript, PolyEvalInstanceLib.batchBn256(comm_vec, r_prod, eval_vec, c));
    }

    function compute_u_vec_items_secondary(
        Abstractions.RelaxedR1CSSNARK memory proof,
        Abstractions.VerifierKeyS2 memory vk,
        KeccakTranscriptLib.KeccakTranscript memory transcript,
        uint256[] memory r_sat,
        uint256[] memory r_prod
    ) public returns (KeccakTranscriptLib.KeccakTranscript memory, PolyEvalInstanceLib.PolyEvalInstance[] memory) {
        PolyEvalInstanceLib.PolyEvalInstance[] memory u_vec_items = new PolyEvalInstanceLib.PolyEvalInstance[](4);

        uint256[] memory powers_of_rho;
        (transcript, powers_of_rho) = compute_powers_of_rho_secondary(proof, transcript);

        u_vec_items[0] = compute_u_vec_1_secondary(proof, powers_of_rho, r_sat);
        u_vec_items[1] = compute_u_vec_2_secondary(proof, powers_of_rho, r_sat);
        u_vec_items[2] = compute_u_vec_3_secondary(proof, powers_of_rho, r_prod);
        (transcript, u_vec_items[3]) = compute_u_vec_4_secondary(proof, vk, transcript, r_prod);

        return (transcript, u_vec_items);
    }

    function compute_powers_of_rho_secondary(
        Abstractions.RelaxedR1CSSNARK memory proof,
        KeccakTranscriptLib.KeccakTranscript memory transcript
    ) public returns (KeccakTranscriptLib.KeccakTranscript memory, uint256[] memory) {
        uint256 i = 0;
        uint256[] memory evals = new uint256[](proof.eval_input_arr.length + proof.eval_output2_arr.length);

        uint256 index;
        //console.log("evals");
        for (index = 0; index < proof.eval_input_arr.length; index++) {
            //console.logBytes32(bytes32(proof.eval_input_arr[index]));
            evals[i] = proof.eval_input_arr[index];
            i++;
        }
        for (index = 0; index < proof.eval_output2_arr.length; index++) {
            //console.logBytes32(bytes32(proof.eval_output2_arr[index]));
            evals[i] = proof.eval_output2_arr[index];
            i++;
        }
        //console.log("#######");

        uint8[] memory label = new uint8[](1);
        label[0] = 0x65; // Rust's b"e"

        transcript = KeccakTranscriptLib.absorb(transcript, label, evals);

        label[0] = 0x72; // Rust's b"r"

        // num_claims is hardcoded to be equal to 10
        uint256 num_claims = 10;
        uint256[] memory rho = new uint256[](num_claims);
        (transcript, rho[0]) = KeccakTranscriptLib.squeeze(transcript, ScalarFromUniformLib.curveGrumpkin(), label);
        rho[0] = Field.reverse256(rho[0]);

        for (index = 1; index < num_claims; index++) {
            rho[index] = mulmod(rho[index - 1], rho[0], Grumpkin.P_MOD);
        }

        return (transcript, rho);
    }

    function compute_u_vec_1_secondary(
        Abstractions.RelaxedR1CSSNARK memory proof,
        uint256[] memory powers_of_rho,
        uint256[] memory r_sat
    ) public returns (PolyEvalInstanceLib.PolyEvalInstance memory) {
        require(
            proof.comm_output_arr.length == proof.eval_output_arr.length,
            "[Step5::compute_u_vec_1_primary] proof.comm_output_arr.length != proof.eval_output_arr.length"
        );
        require(
            powers_of_rho.length >= proof.comm_output_arr.length,
            "[Step5::compute_u_vec_1_primary] powers_of_rho.length < proof.comm_output_arr.length"
        );

        //console.log("proof.comm_output_arr");
        Grumpkin.GrumpkinAffinePoint[] memory comm_output_vec =
            new Grumpkin.GrumpkinAffinePoint[](proof.comm_output_arr.length);
        for (uint256 index = 0; index < comm_output_vec.length; index++) {
            //console.logBytes32(bytes32(proof.comm_output_arr[index]));
            comm_output_vec[index] = Grumpkin.decompress(proof.comm_output_arr[index]);
        }

        Grumpkin.GrumpkinAffinePoint memory comm_output;
        Grumpkin.GrumpkinAffinePoint memory scalarMul;
        //console.log("powers of rho");
        for (uint256 index = 0; index < comm_output_vec.length; index++) {
            //console.logBytes32(bytes32(powers_of_rho[index]));
            scalarMul = Grumpkin.scalarMul(comm_output_vec[index], powers_of_rho[index]);
            comm_output = Grumpkin.add(comm_output, scalarMul);
        }

        uint256 eval_output;
        uint256 tmp;
        for (uint256 index = 0; index < proof.eval_output_arr.length; index++) {
            tmp = mulmod(proof.eval_output_arr[index], powers_of_rho[index], Grumpkin.P_MOD);
            eval_output = addmod(eval_output, tmp, Grumpkin.P_MOD);
        }

        return PolyEvalInstanceLib.PolyEvalInstance(comm_output.x, comm_output.y, r_sat, eval_output);
    }

    function compute_u_vec_2_secondary(
        Abstractions.RelaxedR1CSSNARK memory proof,
        uint256[] memory powers_of_rho,
        uint256[] memory r_sat
    ) public returns (PolyEvalInstanceLib.PolyEvalInstance memory) {
        require(
            proof.comm_output_arr.length == proof.claims_product_arr.length,
            "[Step5::compute_u_vec_2_primary] proof.comm_output_arr.length == proof.claims_product_arr.length"
        );
        require(
            powers_of_rho.length >= proof.claims_product_arr.length,
            "[Step5::compute_u_vec_2_primary] powers_of_rho.length >= proof.claims_product_arr.length"
        );

        Grumpkin.GrumpkinAffinePoint[] memory comm_output_vec =
            new Grumpkin.GrumpkinAffinePoint[](proof.comm_output_arr.length);
        for (uint256 index = 0; index < comm_output_vec.length; index++) {
            comm_output_vec[index] = Grumpkin.decompress(proof.comm_output_arr[index]);
        }

        Grumpkin.GrumpkinAffinePoint memory comm_output;
        Grumpkin.GrumpkinAffinePoint memory scalarMul;
        for (uint256 index = 0; index < comm_output_vec.length; index++) {
            scalarMul = Grumpkin.scalarMul(comm_output_vec[index], powers_of_rho[index]);
            comm_output = Grumpkin.add(comm_output, scalarMul);
        }

        uint256 product;
        uint256 tmp;
        for (uint256 index = 0; index < proof.claims_product_arr.length; index++) {
            tmp = mulmod(proof.claims_product_arr[index], powers_of_rho[index], Grumpkin.P_MOD);
            product = addmod(product, tmp, Grumpkin.P_MOD);
        }

        // claimed_product = output(1, ..., 1, 0)
        uint256[] memory x = new uint256[](r_sat.length);
        for (uint256 index = 0; index < x.length - 1; index++) {
            x[index] = 1;
        }

        return PolyEvalInstanceLib.PolyEvalInstance(comm_output.x, comm_output.y, x, product);
    }

    function compute_u_vec_3_secondary(
        Abstractions.RelaxedR1CSSNARK memory proof,
        uint256[] memory powers_of_rho,
        uint256[] memory r_prod
    ) public returns (PolyEvalInstanceLib.PolyEvalInstance memory) {
        require(
            proof.comm_output_arr.length == proof.eval_output2_arr.length,
            "[Step5::compute_u_vec_3_primary] proof.comm_output_arr.length == proof.eval_output2_arr.length"
        );
        require(
            powers_of_rho.length >= proof.claims_product_arr.length,
            "[Step5::compute_u_vec_3_primary] powers_of_rho.length >= proof.claims_product_arr.length"
        );

        Grumpkin.GrumpkinAffinePoint[] memory comm_output_vec =
            new Grumpkin.GrumpkinAffinePoint[](proof.comm_output_arr.length);
        for (uint256 index = 0; index < comm_output_vec.length; index++) {
            comm_output_vec[index] = Grumpkin.decompress(proof.comm_output_arr[index]);
        }

        Grumpkin.GrumpkinAffinePoint memory comm_output;
        Grumpkin.GrumpkinAffinePoint memory scalarMul;
        for (uint256 index = 0; index < comm_output_vec.length; index++) {
            scalarMul = Grumpkin.scalarMul(comm_output_vec[index], powers_of_rho[index]);
            comm_output = Grumpkin.add(comm_output, scalarMul);
        }

        uint256 eval_output2;
        uint256 tmp;
        for (uint256 index = 0; index < proof.eval_output2_arr.length; index++) {
            tmp = mulmod(proof.eval_output2_arr[index], powers_of_rho[index], Grumpkin.P_MOD);
            eval_output2 = addmod(eval_output2, tmp, Grumpkin.P_MOD);
        }

        return PolyEvalInstanceLib.PolyEvalInstance(comm_output.x, comm_output.y, r_prod, eval_output2);
    }

    function compute_u_vec_4_secondary(
        Abstractions.RelaxedR1CSSNARK memory proof,
        Abstractions.VerifierKeyS2 memory vk,
        KeccakTranscriptLib.KeccakTranscript memory transcript,
        uint256[] memory r_prod
    ) public returns (KeccakTranscriptLib.KeccakTranscript memory, PolyEvalInstanceLib.PolyEvalInstance memory) {
        uint256[] memory eval_vec = new uint256[](8);
        eval_vec[0] = proof.eval_row;
        eval_vec[1] = proof.eval_row_read_ts;
        eval_vec[2] = proof.eval_E_row_at_r_prod;
        eval_vec[3] = proof.eval_row_audit_ts;
        eval_vec[4] = proof.eval_col;
        eval_vec[5] = proof.eval_col_read_ts;
        eval_vec[6] = proof.eval_E_col_at_r_prod;
        eval_vec[7] = proof.eval_col_audit_ts;

        Grumpkin.GrumpkinAffinePoint[] memory comm_vec = new Grumpkin.GrumpkinAffinePoint[](8);
        comm_vec[0] = Grumpkin.decompress(vk.S_comm.comm_row);
        comm_vec[1] = Grumpkin.decompress(vk.S_comm.comm_row_read_ts);
        comm_vec[2] = Grumpkin.decompress(proof.comm_E_row);
        comm_vec[3] = Grumpkin.decompress(vk.S_comm.comm_row_audit_ts);
        comm_vec[4] = Grumpkin.decompress(vk.S_comm.comm_col);
        comm_vec[5] = Grumpkin.decompress(vk.S_comm.comm_col_read_ts);
        comm_vec[6] = Grumpkin.decompress(proof.comm_E_col);
        comm_vec[7] = Grumpkin.decompress(vk.S_comm.comm_col_audit_ts);

        uint256[] memory eval_vec_c = new uint256[](eval_vec.length + 1);
        //console.log("eval_vec_c");
        for (uint256 index = 0; index < eval_vec.length; index++) {
            eval_vec_c[index] = eval_vec[index];
            //console.logBytes32(bytes32(eval_vec_c[index]));
        }
        eval_vec_c[eval_vec_c.length - 1] = proof.eval_W;
        //console.logBytes32(bytes32(eval_vec_c[eval_vec_c.length - 1]));

        uint8[] memory label = new uint8[](1);
        label[0] = 0x65; // Rust's b"e"

        transcript = KeccakTranscriptLib.absorb(transcript, label, eval_vec_c);

        label[0] = 0x63; // Rust's b"c"

        uint256 c;
        (transcript, c) = KeccakTranscriptLib.squeeze(transcript, ScalarFromUniformLib.curveGrumpkin(), label);
        c = Field.reverse256(c);

        return (transcript, PolyEvalInstanceLib.batchGrumpkin(comm_vec, r_prod, eval_vec, c));
    }
}
