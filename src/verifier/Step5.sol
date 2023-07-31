// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.0;

import "@std/Test.sol";
import "src/blocks/pasta/Pallas.sol";
import "src/blocks/pasta/Vesta.sol";
import "src/blocks/EqPolynomial.sol";
import "src/blocks/IdentityPolynomial.sol";
import "src/blocks/KeccakTranscript.sol";
import "src/blocks/PolyEvalInstance.sol";
import "src/NovaVerifierAbstractions.sol";

library Step5Lib {
    function final_verification(
        Abstractions.RelaxedR1CSSNARK calldata proof,
        uint256 claim_init_expected_row,
        uint256 claim_read_expected_row,
        uint256 claim_write_expected_row,
        uint256 claim_audit_expected_row
    ) public pure returns (bool) {
        if (claim_init_expected_row != proof.eval_input_arr[0]) {
            return false;
        }
        if (claim_read_expected_row != proof.eval_input_arr[1]) {
            return false;
        }
        if (claim_write_expected_row != proof.eval_input_arr[2]) {
            return false;
        }
        if (claim_audit_expected_row != proof.eval_input_arr[3]) {
            return false;
        }
        return true;
    }

    function hash_func(
        uint256 gamma1,
        uint256 gamma2,
        uint256 addr,
        uint256 val,
        uint256 ts,
        uint256 modulus,
        function (uint256) returns (uint256) negate
    ) internal returns (uint256) {
        uint256 result = val;
        uint256 tmp = ts;
        uint256 minus_gamma2 = negate(gamma2);
        assembly {
            tmp := mulmod(tmp, gamma1, modulus)
            tmp := mulmod(tmp, gamma1, modulus)

            result := mulmod(result, gamma1, modulus)
            result := addmod(result, tmp, modulus)
            result := addmod(result, addr, modulus)
            result := addmod(result, minus_gamma2, modulus)
        }

        return result;
    }

    function compute_claims_init_audit(
        uint256 eval_row_audit_ts,
        uint256 gamma1,
        uint256 gamma2,
        uint256[] memory r_prod,
        uint256[] memory tau,
        uint256 modulus,
        function (uint256) returns (uint256) negate
    ) internal returns (uint256, uint256) {
        return (
            hash_func(
                gamma1,
                gamma2,
                IdentityPolynomialLib.evaluate(r_prod, modulus),
                EqPolinomialLib.evaluate(tau, r_prod, modulus, negate),
                0,
                modulus,
                negate
                ),
            hash_func(
                gamma1,
                gamma2,
                IdentityPolynomialLib.evaluate(r_prod, modulus),
                EqPolinomialLib.evaluate(tau, r_prod, modulus, negate),
                eval_row_audit_ts,
                modulus,
                negate
                )
        );
    }

    function compute_claims_read_write(
        Abstractions.RelaxedR1CSSNARK storage proof,
        uint256 gamma1,
        uint256 gamma2,
        uint256 modulus,
        function (uint256) returns (uint256) negateBase
    ) internal returns (uint256, uint256) {
        uint256 claim_read = hash_func(
            gamma1, gamma2, proof.eval_row, proof.eval_E_row_at_r_prod, proof.eval_row_read_ts, modulus, negateBase
        );

        uint256 ts_write = addmod(proof.eval_row_read_ts, 1, modulus);
        uint256 claim_write =
            hash_func(gamma1, gamma2, proof.eval_row, proof.eval_E_row_at_r_prod, ts_write, modulus, negateBase);

        return (claim_read, claim_write);
    }

    function compute_r_prod(uint256 c, uint256[] memory r_sat) public pure returns (uint256[] memory) {
        uint256[] memory rand_ext = new uint256[](r_sat.length + 1);
        for (uint256 index = 0; index < r_sat.length; index++) {
            rand_ext[index] = r_sat[index];
        }

        rand_ext[r_sat.length] = c;

        uint256[] memory r_prod = new uint256[](rand_ext.length - 1);
        for (uint256 index = 1; index < rand_ext.length; index++) {
            r_prod[index - 1] = rand_ext[index];
        }

        return r_prod;
    }

    function compute_c_inner(Abstractions.RelaxedR1CSSNARK storage proof) private view returns (uint8[] memory) {
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

        return Abstractions.toTranscriptBytes(eval_vec);
    }

    function compute_c_primary(
        Abstractions.RelaxedR1CSSNARK storage proof,
        KeccakTranscriptLib.KeccakTranscript memory transcript
    ) public view returns (KeccakTranscriptLib.KeccakTranscript memory, uint256) {
        uint8[] memory input = compute_c_inner(proof);

        uint8[] memory label = new uint8[](1);
        label[0] = 0x65; // Rust's b"e"

        transcript = KeccakTranscriptLib.absorb(transcript, label, input);

        label[0] = 0x63; // Rust's b"c"

        uint256 output;
        (transcript, output) = KeccakTranscriptLib.squeeze(transcript, ScalarFromUniformLib.curveVesta(), label);
        output = Field.reverse256(output);

        return (transcript, output);
    }

    function compute_c_secondary(
        Abstractions.RelaxedR1CSSNARK storage proof,
        KeccakTranscriptLib.KeccakTranscript memory transcript
    ) public view returns (KeccakTranscriptLib.KeccakTranscript memory, uint256) {
        uint8[] memory input = compute_c_inner(proof);

        uint8[] memory label = new uint8[](1);
        label[0] = 0x65; // Rust's b"e"

        transcript = KeccakTranscriptLib.absorb(transcript, label, input);

        label[0] = 0x63; // Rust's b"c"

        uint256 output;
        (transcript, output) = KeccakTranscriptLib.squeeze(transcript, ScalarFromUniformLib.curvePallas(), label);
        output = Field.reverse256(output);

        return (transcript, output);
    }

    function compute_powers_of_rho_primary(
        Abstractions.RelaxedR1CSSNARK storage proof,
        KeccakTranscriptLib.KeccakTranscript memory transcript
    ) public returns (KeccakTranscriptLib.KeccakTranscript memory, uint256[] memory) {
        uint256 i = 0;
        uint256[] memory evals = new uint256[](proof.eval_input_arr.length + proof.eval_output2_arr.length);

        uint256 index;
        for (index = 0; index < proof.eval_input_arr.length; index++) {
            evals[i] = proof.eval_input_arr[index];
            i++;
        }
        for (index = 0; index < proof.eval_output2_arr.length; index++) {
            evals[i] = proof.eval_output2_arr[index];
            i++;
        }

        uint8[] memory input = Abstractions.toTranscriptBytes(evals);

        uint8[] memory label = new uint8[](1);
        label[0] = 0x65; // Rust's b"e"

        transcript = KeccakTranscriptLib.absorb(transcript, label, input);

        label[0] = 0x72; // Rust's b"r"

        // num_claims is hardcoded to be equal to 10
        uint256 num_claims = 10;
        uint256[] memory rho = new uint256[](num_claims);
        (transcript, rho[0]) = KeccakTranscriptLib.squeeze(transcript, ScalarFromUniformLib.curveVesta(), label);
        rho[0] = Field.reverse256(rho[0]);

        for (index = 1; index < num_claims; index++) {
            rho[index] = mulmod(rho[index - 1], rho[0], Vesta.P_MOD);
        }

        return (transcript, rho);
    }

    function compute_powers_of_rho_secondary(
        Abstractions.RelaxedR1CSSNARK storage proof,
        KeccakTranscriptLib.KeccakTranscript memory transcript
    ) public returns (KeccakTranscriptLib.KeccakTranscript memory, uint256[] memory) {
        uint256 i = 0;
        uint256[] memory evals = new uint256[](proof.eval_input_arr.length + proof.eval_output2_arr.length);

        uint256 index;
        for (index = 0; index < proof.eval_input_arr.length; index++) {
            evals[i] = proof.eval_input_arr[index];
            i++;
        }
        for (index = 0; index < proof.eval_output2_arr.length; index++) {
            evals[i] = proof.eval_output2_arr[index];
            i++;
        }

        uint8[] memory input = Abstractions.toTranscriptBytes(evals);

        uint8[] memory label = new uint8[](1);
        label[0] = 0x65; // Rust's b"e"

        transcript = KeccakTranscriptLib.absorb(transcript, label, input);

        label[0] = 0x72; // Rust's b"r"

        // num_claims is hardcoded to be equal to 10
        uint256 num_claims = 10;
        uint256[] memory rho = new uint256[](num_claims);
        (transcript, rho[0]) = KeccakTranscriptLib.squeeze(transcript, ScalarFromUniformLib.curvePallas(), label);
        rho[0] = Field.reverse256(rho[0]);

        for (index = 1; index < num_claims; index++) {
            rho[index] = mulmod(rho[index - 1], rho[0], Pallas.P_MOD);
        }

        return (transcript, rho);
    }

    function compute_u_vec_1_primary(
        Abstractions.RelaxedR1CSSNARK storage proof,
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

        Pallas.PallasAffinePoint[] memory comm_output_vec = new Pallas.PallasAffinePoint[](proof.comm_output_arr.length);
        for (uint256 index = 0; index < comm_output_vec.length; index++) {
            comm_output_vec[index] = Pallas.decompress(proof.comm_output_arr[index]);
        }

        Pallas.PallasAffinePoint memory comm_output;
        Pallas.PallasAffinePoint memory scalarMul;
        for (uint256 index = 0; index < comm_output_vec.length; index++) {
            scalarMul = Pallas.scalarMul(comm_output_vec[index], powers_of_rho[index]);
            comm_output = Pallas.add(comm_output, scalarMul);
        }

        uint256 eval_output;
        uint256 tmp;
        for (uint256 index = 0; index < proof.eval_output_arr.length; index++) {
            tmp = mulmod(proof.eval_output_arr[index], powers_of_rho[index], Vesta.P_MOD);
            eval_output = addmod(eval_output, tmp, Vesta.P_MOD);
        }

        return PolyEvalInstanceLib.PolyEvalInstance(comm_output.x, comm_output.y, r_sat, eval_output);
    }

    function compute_u_vec_1_secondary(
        Abstractions.RelaxedR1CSSNARK storage proof,
        uint256[] memory powers_of_rho,
        uint256[] memory r_sat
    ) public returns (PolyEvalInstanceLib.PolyEvalInstance memory) {
        require(
            proof.comm_output_arr.length == proof.eval_output_arr.length,
            "[Step5::compute_u_vec_1_secondary] proof.comm_output_arr.length != proof.eval_output_arr.length"
        );
        require(
            powers_of_rho.length >= proof.comm_output_arr.length,
            "[Step5::compute_u_vec_1_secondary] powers_of_rho.length < proof.comm_output_arr.length"
        );

        Vesta.VestaAffinePoint[] memory comm_output_vec = new Vesta.VestaAffinePoint[](proof.comm_output_arr.length);
        for (uint256 index = 0; index < comm_output_vec.length; index++) {
            comm_output_vec[index] = Vesta.decompress(proof.comm_output_arr[index]);
        }

        Vesta.VestaAffinePoint memory comm_output;
        Vesta.VestaAffinePoint memory scalarMul;
        for (uint256 index = 0; index < comm_output_vec.length; index++) {
            scalarMul = Vesta.scalarMul(comm_output_vec[index], powers_of_rho[index]);
            comm_output = Vesta.add(comm_output, scalarMul);
        }

        uint256 eval_output;
        uint256 tmp;
        for (uint256 index = 0; index < proof.eval_output_arr.length; index++) {
            tmp = mulmod(proof.eval_output_arr[index], powers_of_rho[index], Pallas.P_MOD);
            eval_output = addmod(eval_output, tmp, Pallas.P_MOD);
        }

        return PolyEvalInstanceLib.PolyEvalInstance(comm_output.x, comm_output.y, r_sat, eval_output);
    }

    function compute_u_vec_2_primary(
        Abstractions.RelaxedR1CSSNARK storage proof,
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

        Pallas.PallasAffinePoint[] memory comm_output_vec = new Pallas.PallasAffinePoint[](proof.comm_output_arr.length);
        for (uint256 index = 0; index < comm_output_vec.length; index++) {
            comm_output_vec[index] = Pallas.decompress(proof.comm_output_arr[index]);
        }

        Pallas.PallasAffinePoint memory comm_output;
        Pallas.PallasAffinePoint memory scalarMul;
        for (uint256 index = 0; index < comm_output_vec.length; index++) {
            scalarMul = Pallas.scalarMul(comm_output_vec[index], powers_of_rho[index]);
            comm_output = Pallas.add(comm_output, scalarMul);
        }

        uint256 product;
        uint256 tmp;
        for (uint256 index = 0; index < proof.claims_product_arr.length; index++) {
            tmp = mulmod(proof.claims_product_arr[index], powers_of_rho[index], Vesta.P_MOD);
            product = addmod(product, tmp, Vesta.P_MOD);
        }

        // claimed_product = output(1, ..., 1, 0)
        uint256[] memory x = new uint256[](r_sat.length);
        for (uint256 index = 0; index < x.length - 1; index++) {
            x[index] = 1;
        }

        return PolyEvalInstanceLib.PolyEvalInstance(comm_output.x, comm_output.y, x, product);
    }

    function compute_u_vec_2_secondary(
        Abstractions.RelaxedR1CSSNARK storage proof,
        uint256[] memory powers_of_rho,
        uint256[] memory r_sat
    ) public returns (PolyEvalInstanceLib.PolyEvalInstance memory) {
        require(
            proof.comm_output_arr.length == proof.claims_product_arr.length,
            "[Step5::compute_u_vec_2_secondary] proof.comm_output_arr.length == proof.claims_product_arr.length"
        );
        require(
            powers_of_rho.length >= proof.claims_product_arr.length,
            "[Step5::compute_u_vec_2_secondary] powers_of_rho.length >= proof.claims_product_arr.length"
        );

        Vesta.VestaAffinePoint[] memory comm_output_vec = new Vesta.VestaAffinePoint[](proof.comm_output_arr.length);
        for (uint256 index = 0; index < comm_output_vec.length; index++) {
            comm_output_vec[index] = Vesta.decompress(proof.comm_output_arr[index]);
        }

        Vesta.VestaAffinePoint memory comm_output;
        Vesta.VestaAffinePoint memory scalarMul;
        for (uint256 index = 0; index < comm_output_vec.length; index++) {
            scalarMul = Vesta.scalarMul(comm_output_vec[index], powers_of_rho[index]);
            comm_output = Vesta.add(comm_output, scalarMul);
        }

        uint256 product;
        uint256 tmp;
        for (uint256 index = 0; index < proof.claims_product_arr.length; index++) {
            tmp = mulmod(proof.claims_product_arr[index], powers_of_rho[index], Pallas.P_MOD);
            product = addmod(product, tmp, Pallas.P_MOD);
        }

        // claimed_product = output(1, ..., 1, 0)
        uint256[] memory x = new uint256[](r_sat.length);
        for (uint256 index = 0; index < x.length - 1; index++) {
            x[index] = 1;
        }

        return PolyEvalInstanceLib.PolyEvalInstance(comm_output.x, comm_output.y, x, product);
    }

    function compute_u_vec_3_primary(
        Abstractions.RelaxedR1CSSNARK storage proof,
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

        Pallas.PallasAffinePoint[] memory comm_output_vec = new Pallas.PallasAffinePoint[](proof.comm_output_arr.length);
        for (uint256 index = 0; index < comm_output_vec.length; index++) {
            comm_output_vec[index] = Pallas.decompress(proof.comm_output_arr[index]);
        }

        Pallas.PallasAffinePoint memory comm_output;
        Pallas.PallasAffinePoint memory scalarMul;
        for (uint256 index = 0; index < comm_output_vec.length; index++) {
            scalarMul = Pallas.scalarMul(comm_output_vec[index], powers_of_rho[index]);
            comm_output = Pallas.add(comm_output, scalarMul);
        }

        uint256 eval_output2;
        uint256 tmp;
        for (uint256 index = 0; index < proof.eval_output2_arr.length; index++) {
            tmp = mulmod(proof.eval_output2_arr[index], powers_of_rho[index], Vesta.P_MOD);
            eval_output2 = addmod(eval_output2, tmp, Vesta.P_MOD);
        }

        return PolyEvalInstanceLib.PolyEvalInstance(comm_output.x, comm_output.y, r_prod, eval_output2);
    }

    function compute_u_vec_3_secondary(
        Abstractions.RelaxedR1CSSNARK storage proof,
        uint256[] memory powers_of_rho,
        uint256[] memory r_prod
    ) public returns (PolyEvalInstanceLib.PolyEvalInstance memory) {
        require(
            proof.comm_output_arr.length == proof.eval_output2_arr.length,
            "[Step5::compute_u_vec_3_secondary] proof.comm_output_arr.length == proof.eval_output2_arr.length"
        );
        require(
            powers_of_rho.length >= proof.claims_product_arr.length,
            "[Step5::compute_u_vec_3_secondary] powers_of_rho.length >= proof.claims_product_arr.length"
        );

        Vesta.VestaAffinePoint[] memory comm_output_vec = new Vesta.VestaAffinePoint[](proof.comm_output_arr.length);
        for (uint256 index = 0; index < comm_output_vec.length; index++) {
            comm_output_vec[index] = Vesta.decompress(proof.comm_output_arr[index]);
        }

        Vesta.VestaAffinePoint memory comm_output;
        Vesta.VestaAffinePoint memory scalarMul;
        for (uint256 index = 0; index < comm_output_vec.length; index++) {
            scalarMul = Vesta.scalarMul(comm_output_vec[index], powers_of_rho[index]);
            comm_output = Vesta.add(comm_output, scalarMul);
        }

        uint256 eval_output2;
        uint256 tmp;
        for (uint256 index = 0; index < proof.eval_output2_arr.length; index++) {
            tmp = mulmod(proof.eval_output2_arr[index], powers_of_rho[index], Pallas.P_MOD);
            eval_output2 = addmod(eval_output2, tmp, Pallas.P_MOD);
        }

        return PolyEvalInstanceLib.PolyEvalInstance(comm_output.x, comm_output.y, r_prod, eval_output2);
    }

    function compute_u_vec_4_primary(
        Abstractions.RelaxedR1CSSNARK storage proof,
        Abstractions.VerifierKeyS1 storage vk,
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

        Pallas.PallasAffinePoint[] memory comm_vec = new Pallas.PallasAffinePoint[](8);
        comm_vec[0] = Pallas.decompress(vk.S_comm.comm_row);
        comm_vec[1] = Pallas.decompress(vk.S_comm.comm_row_read_ts);
        comm_vec[2] = Pallas.decompress(proof.comm_E_row);
        comm_vec[3] = Pallas.decompress(vk.S_comm.comm_row_audit_ts);
        comm_vec[4] = Pallas.decompress(vk.S_comm.comm_col);
        comm_vec[5] = Pallas.decompress(vk.S_comm.comm_col_read_ts);
        comm_vec[6] = Pallas.decompress(proof.comm_E_col);
        comm_vec[7] = Pallas.decompress(vk.S_comm.comm_col_audit_ts);

        uint256[] memory eval_vec_c = new uint256[](eval_vec.length + 1);
        for (uint256 index = 0; index < eval_vec.length; index++) {
            eval_vec_c[index] = eval_vec[index];
        }
        eval_vec_c[eval_vec_c.length - 1] = proof.eval_W;

        uint8[] memory input = Abstractions.toTranscriptBytes(eval_vec_c);

        uint8[] memory label = new uint8[](1);
        label[0] = 0x65; // Rust's b"e"

        transcript = KeccakTranscriptLib.absorb(transcript, label, input);

        label[0] = 0x63; // Rust's b"c"

        uint256 c;
        (transcript, c) = KeccakTranscriptLib.squeeze(transcript, ScalarFromUniformLib.curveVesta(), label);
        c = Field.reverse256(c);

        return (transcript, PolyEvalInstanceLib.batchPrimary(comm_vec, r_prod, eval_vec, c));
    }

    function compute_u_vec_4_secondary(
        Abstractions.RelaxedR1CSSNARK storage proof,
        Abstractions.VerifierKeyS2 storage vk,
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

        Vesta.VestaAffinePoint[] memory comm_vec = new Vesta.VestaAffinePoint[](8);
        comm_vec[0] = Vesta.decompress(vk.S_comm.comm_row);
        comm_vec[1] = Vesta.decompress(vk.S_comm.comm_row_read_ts);
        comm_vec[2] = Vesta.decompress(proof.comm_E_row);
        comm_vec[3] = Vesta.decompress(vk.S_comm.comm_row_audit_ts);
        comm_vec[4] = Vesta.decompress(vk.S_comm.comm_col);
        comm_vec[5] = Vesta.decompress(vk.S_comm.comm_col_read_ts);
        comm_vec[6] = Vesta.decompress(proof.comm_E_col);
        comm_vec[7] = Vesta.decompress(vk.S_comm.comm_col_audit_ts);

        uint256[] memory eval_vec_c = new uint256[](eval_vec.length + 1);
        for (uint256 index = 0; index < eval_vec.length; index++) {
            eval_vec_c[index] = eval_vec[index];
        }
        eval_vec_c[eval_vec_c.length - 1] = proof.eval_W;

        uint8[] memory input = Abstractions.toTranscriptBytes(eval_vec_c);

        uint8[] memory label = new uint8[](1);
        label[0] = 0x65; // Rust's b"e"

        transcript = KeccakTranscriptLib.absorb(transcript, label, input);

        label[0] = 0x63; // Rust's b"c"

        uint256 c;
        (transcript, c) = KeccakTranscriptLib.squeeze(transcript, ScalarFromUniformLib.curvePallas(), label);
        c = Field.reverse256(c);

        return (transcript, PolyEvalInstanceLib.batchSecondary(comm_vec, r_prod, eval_vec, c));
    }

    function compute_u_vec_items_primary(
        Abstractions.RelaxedR1CSSNARK storage proof,
        Abstractions.VerifierKeyS1 storage vk,
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

    function compute_u_vec_items_secondary(
        Abstractions.RelaxedR1CSSNARK storage proof,
        Abstractions.VerifierKeyS2 storage vk,
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
}
