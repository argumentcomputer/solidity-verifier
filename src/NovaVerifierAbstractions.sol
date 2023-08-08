// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.16;

import "src/blocks/pasta/Vesta.sol";
import "src/blocks/pasta/Pallas.sol";

library Abstractions {
    struct RelaxedR1CSInstance {
        uint256 comm_W; // compressed EC point
        uint256 comm_E; // compressed EC point
        uint256[] X;
        uint256 u;
    }

    struct R1CSInstance {
        uint256 comm_W;
        uint256[] X;
    }

    struct CompressedPolys {
        uint256[] coeffs_except_linear_term;
    }

    struct SumcheckProof {
        CompressedPolys[] compressed_polys;
    }

    struct RelaxedR1CSSNARK {
        uint256 comm_Az;
        uint256 comm_Bz;
        uint256 comm_Cz;
        uint256 comm_E_row;
        uint256 comm_E_col;
        uint256 eval_Az_at_tau;
        uint256 eval_Bz_at_tau;
        uint256 eval_Cz_at_tau;
        uint256[] comm_output_arr;
        uint256[] claims_product_arr;
        SumcheckProof sc_sat;
        uint256[] eval_left_arr;
        uint256[] eval_right_arr;
        uint256[] eval_output_arr;
        uint256 eval_Az;
        uint256 eval_Bz;
        uint256 eval_Cz;
        uint256 eval_E;
        uint256 eval_val_A;
        uint256 eval_val_B;
        uint256 eval_val_C;
        uint256 eval_E_row;
        uint256 eval_E_col;
        uint256[] eval_input_arr;
        uint256 eval_row_audit_ts;
        uint256 eval_row;
        uint256 eval_E_row_at_r_prod;
        uint256 eval_row_read_ts;
        uint256 eval_col_audit_ts;
        uint256 eval_col;
        uint256 eval_E_col_at_r_prod;
        uint256 eval_col_read_ts;
        uint256 eval_W;
        uint256[] evals_batch_arr;
        SumcheckProof sc_proof_batch;
        uint256[] eval_output2_arr;
    }

    struct CompressedSnark {
        R1CSInstance l_u_secondary;
        RelaxedR1CSInstance r_U_primary;
        RelaxedR1CSInstance r_U_secondary;
        uint256[] zn_primary;
        uint256[] zn_secondary;
        uint256 nifs_compressed_comm_T;
        RelaxedR1CSSNARK f_W_snark_secondary;
        RelaxedR1CSSNARK r_W_snark_primary;
    }

    struct ROConstants {
        uint256[] mixConstants;
        uint256[] addRoundConstants;
    }

    struct R1CSShapeSparkCommitment {
        uint256 N;
        uint256 comm_val_A;
        uint256 comm_val_B;
        uint256 comm_val_C;
        uint256 comm_row;
        uint256 comm_row_read_ts;
        uint256 comm_row_audit_ts;
        uint256 comm_col;
        uint256 comm_col_read_ts;
        uint256 comm_col_audit_ts;
    }

    struct VerifierKeyS1 {
        uint256 num_cons;
        uint256 num_vars;
        R1CSShapeSparkCommitment S_comm;
        uint256 digest;
    }

    struct VerifierKeyS2 {
        R1CSShapeSparkCommitment S_comm;
        uint256 digest;
    }

    struct VerifierKey {
        uint256 f_arity_primary;
        uint256 f_arity_secondary;
        uint256 digest;
        ROConstants ro_consts_primary;
        ROConstants ro_consts_secondary;
        VerifierKeyS2 vk_secondary;
        VerifierKeyS1 vk_primary;
    }
}
