// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.0;

import "@std/Test.sol";
import "src/blocks/pasta/Pallas.sol";
import "src/blocks/pasta/Vesta.sol";
import "src/blocks/EqPolynomial.sol";
import "src/blocks/IdentityPolynomial.sol";
import "src/blocks/KeccakTranscript.sol";
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
}
