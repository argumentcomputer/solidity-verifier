// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.0;

import "src/verifier/step4/EqPolynomial.sol";
import "src/pasta/Vesta.sol";
import "src/pasta/Pallas.sol";

library SpartanVerificationSupStep2Lib {
    function verifyPrimary(
        uint256[] memory tau,
        uint256[] memory r_x,
        uint256 claim_Az,
        uint256 claim_Bz,
        uint256 claim_Cz,
        uint256 eval_E,
        uint256 U_u,
        uint256 claim_outer_final
    ) public pure {
        uint256 taus_bound_rx = EqPolinomialLib.evaluateVesta(tau, r_x);

        uint256 claim_outer_final_computed;

        uint256 modulusVesta = Vesta.P_MOD;

        uint256 tmp1;
        assembly {
            tmp1 := mulmod(claim_Az, claim_Bz, modulusVesta) // Vesta
        }
        uint256 tmp2;
        assembly {
            tmp2 := mulmod(U_u, claim_Cz, modulusVesta) // Vesta
        }
        tmp2 = Vesta.negateBase(tmp2); // Vesta

        uint256 tmp3 = Vesta.negateBase(eval_E); // Vesta

        assembly {
            claim_outer_final_computed := addmod(tmp1, tmp2, modulusVesta) // Vesta
            claim_outer_final_computed := addmod(claim_outer_final_computed, tmp3, modulusVesta) // Vesta
            claim_outer_final_computed := mulmod(claim_outer_final_computed, taus_bound_rx, modulusVesta) // Vesta
        }

        require(
            claim_outer_final_computed == claim_outer_final,
            "[SpartanVerificationSupStep2Lib.verifyPrimary] InvalidSumcheckProof"
        );
    }

    function verifySecondary(
        uint256[] memory tau,
        uint256[] memory r_x,
        uint256 claim_Az,
        uint256 claim_Bz,
        uint256 claim_Cz,
        uint256 eval_E,
        uint256 U_u,
        uint256 claim_outer_final
    ) public pure {
        uint256 taus_bound_rx = EqPolinomialLib.evaluatePallas(tau, r_x);

        uint256 claim_outer_final_computed;

        uint256 modulusPallas = Pallas.P_MOD;

        uint256 tmp1;
        assembly {
            tmp1 := mulmod(claim_Az, claim_Bz, modulusPallas) // Pallas
        }

        uint256 tmp2;
        assembly {
            tmp2 := mulmod(U_u, claim_Cz, modulusPallas) // Pallas
        }

        tmp2 = Pallas.negateBase(tmp2); // Pallas

        uint256 tmp3 = Pallas.negateBase(eval_E); // Pallas

        assembly {
            claim_outer_final_computed := addmod(tmp1, tmp2, modulusPallas) // Pallas
            claim_outer_final_computed := addmod(claim_outer_final_computed, tmp3, modulusPallas) // Pallas
            claim_outer_final_computed := mulmod(claim_outer_final_computed, taus_bound_rx, modulusPallas) // Pallas
        }

        require(
            claim_outer_final_computed == claim_outer_final,
            "[SpartanVerificationSupStep2Lib.verifySecondary] InvalidSumcheckProof"
        );
    }
}
