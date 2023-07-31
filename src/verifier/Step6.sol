// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.0;

import "@std/Test.sol";
import "src/verifier/Step5.sol";
import "src/blocks/IdentityPolynomial.sol";
import "src/blocks/SparsePolynomial.sol";
import "src/blocks/PolyEvalInstance.sol";
import "src/NovaVerifierAbstractions.sol";

library Step6Lib {
    function finalVerification(
        Abstractions.RelaxedR1CSSNARK calldata proof,
        uint256 claim_init_expected_col,
        uint256 claim_read_expected_col,
        uint256 claim_write_expected_col,
        uint256 claim_audit_expected_col
    ) public pure returns (bool) {
        if (claim_init_expected_col != proof.eval_input_arr[4]) {
            return false;
        }

        if (claim_read_expected_col != proof.eval_input_arr[5]) {
            return false;
        }

        if (claim_write_expected_col != proof.eval_input_arr[6]) {
            return false;
        }

        if (claim_audit_expected_col != proof.eval_input_arr[7]) {
            return false;
        }

        return true;
    }

    function compute_claims_init_audit(
        Abstractions.RelaxedR1CSSNARK storage proof,
        uint256 gamma1,
        uint256 gamma2,
        uint256 eval_Z,
        uint256[] memory r_prod,
        uint256 modulus,
        function (uint256) returns (uint256) negate
    ) internal returns (uint256, uint256) {
        return (
            Step5Lib.hash_func(
                gamma1, gamma2, IdentityPolynomialLib.evaluate(r_prod, modulus), eval_Z, 0, modulus, negate
                ),
            Step5Lib.hash_func(
                gamma1,
                gamma2,
                IdentityPolynomialLib.evaluate(r_prod, modulus),
                eval_Z,
                proof.eval_col_audit_ts,
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
        uint256 ts_write = addmod(proof.eval_col_read_ts, 1, modulus);
        return (
            Step5Lib.hash_func(
                gamma1, gamma2, proof.eval_col, proof.eval_E_col_at_r_prod, proof.eval_col_read_ts, modulus, negateBase
                ),
            Step5Lib.hash_func(
                gamma1, gamma2, proof.eval_col, proof.eval_E_col_at_r_prod, ts_write, modulus, negateBase
                )
        );
    }

    function compute_eval_X(
        uint256 num_vars,
        uint256[] memory r_prod_unpad,
        uint256[] memory U_X,
        uint256 U_u,
        uint256 modulus,
        function (uint256) returns (uint256) negateBase
    ) internal returns (uint256) {
        uint256[] memory r_prod_unpad_no_zero_element = new uint256[](r_prod_unpad.length - 1);
        uint256 index = 0;
        for (index = 0; index < r_prod_unpad_no_zero_element.length; index++) {
            r_prod_unpad_no_zero_element[index] = r_prod_unpad[index + 1];
        }

        index = 0;
        SparsePolynomialLib.Z[] memory poly_X = new SparsePolynomialLib.Z[](U_X.length + 1);
        poly_X[index] = SparsePolynomialLib.Z(index, U_u);
        index++;

        for (uint256 i = 0; i < U_X.length; i++) {
            poly_X[index] = SparsePolynomialLib.Z(index, U_X[i]);
            index++;
        }

        uint256 actual = SparsePolynomialLib.evaluate(
            CommonUtilities.log2(num_vars), poly_X, r_prod_unpad_no_zero_element, modulus, negateBase
        );

        return actual;
    }

    function compute_factor(
        uint256 vk_s_comm_N,
        uint256 num_vars,
        uint256[] memory r_prod,
        uint256 modulus,
        function (uint256) returns (uint256) negateBase
    ) internal returns (uint256, uint256[] memory) {
        if (vk_s_comm_N < num_vars) {
            console.log("[Step6::compute_factor] vk_s_comm_N < num_vars");
            revert();
        }

        uint256 l = CommonUtilities.log2(vk_s_comm_N) - CommonUtilities.log2(2 * num_vars);

        if (l > r_prod.length) {
            console.log("[Step6::compute_factor] l > r_prod.length");
            revert();
        }

        uint256 factor = 1;

        uint256 tmp;
        for (uint256 index = 0; index < l; index++) {
            tmp = negateBase(r_prod[index]);
            tmp = addmod(tmp, 1, modulus);
            factor = mulmod(factor, tmp, modulus);
        }

        uint256[] memory r_prod_unpad = new uint256[](r_prod.length - l);
        for (uint256 index = 0; index < r_prod_unpad.length; index++) {
            r_prod_unpad[index] = r_prod[index + l];
        }

        return (factor, r_prod_unpad);
    }

    function compute_eval_Z(
        Abstractions.RelaxedR1CSSNARK storage proof,
        uint256[] memory U_X,
        uint256 U_u,
        uint256 vk_s_comm_N,
        uint256 num_vars,
        uint256[] memory r_prod,
        uint256 modulus,
        function (uint256) returns (uint256) negateBase
    ) internal returns (uint256, uint256[] memory) {
        uint256 self_eval_W = proof.eval_W;

        (uint256 factor, uint256[] memory r_prod_unpad) =
            compute_factor(vk_s_comm_N, num_vars, r_prod, modulus, negateBase);

        uint256 eval_X = compute_eval_X(num_vars, r_prod_unpad, U_X, U_u, modulus, negateBase);

        uint256 result;
        uint256 r_prod_unpad_0 = r_prod_unpad[0];
        uint256 tmp = negateBase(r_prod_unpad_0);
        assembly {
            tmp := addmod(tmp, 1, modulus)
            tmp := mulmod(tmp, self_eval_W, modulus)
            result := mulmod(r_prod_unpad_0, eval_X, modulus)
            result := addmod(result, tmp, modulus)
            result := mulmod(result, factor, modulus)
        }
        return (result, r_prod_unpad);
    }

    function compute_u_vec_5(
        Abstractions.RelaxedR1CSSNARK storage proof,
        uint256[] memory r_prod_unpad,
        uint256 U_x,
        uint256 U_y
    ) public returns (PolyEvalInstanceLib.PolyEvalInstance memory) {
        uint256[] memory x = new uint256[](r_prod_unpad.length - 1);
        for (uint256 index = 0; index < r_prod_unpad.length - 1; index++) {
            x[index] = r_prod_unpad[index + 1];
        }
        return PolyEvalInstanceLib.PolyEvalInstance(U_x, U_y, x, proof.eval_W);
    }
}
