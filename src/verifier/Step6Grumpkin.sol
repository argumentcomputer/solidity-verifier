// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.16;

import "@std/Test.sol";
import "src/verifier/Step5.sol";
import "src/verifier/Step6.sol";
import "src/blocks/IdentityPolynomial.sol";
import "src/blocks/SparsePolynomial.sol";
import "src/blocks/PolyEvalInstance.sol";
import "src/NovaVerifierAbstractions.sol";

library Step6GrumpkinLib {
    function compute_eval_Z(
        Abstractions.RelaxedR1CSSNARK memory proof,
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
            Step6Lib.compute_factor(vk_s_comm_N, num_vars, r_prod, modulus, negateBase);

        uint256 eval_X = Step6Lib.compute_eval_X(num_vars, r_prod_unpad, U_X, U_u, modulus, negateBase);

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
}
