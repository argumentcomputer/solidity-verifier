// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.16;

import "src/blocks/pasta/Vesta.sol";
import "src/blocks/pasta/Pallas.sol";
import "src/Utilities.sol";

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

    struct M {
        uint256[] m_inner;
    }

    struct PSM {
        uint256[] psm_inner;
    }

    struct W_HAT {
        uint256[] w_hat_inner;
    }

    struct V_REST {
        uint256[] v_rest_inner;
    }

    struct ROConstants {
        M[] m;
        PSM[] psm;
        W_HAT[] w_hats;
        V_REST[] v_rests;
        uint256[] addRoundConstants;
        uint256 partial_rounds;
        uint256 full_rounds;
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
        uint256 num_cons;
        uint256 num_vars;
        R1CSShapeSparkCommitment S_comm;
        uint256 digest;
    }

    struct VerifierKey {
        uint256 f_arity_primary;
        uint256 f_arity_secondary;
        uint256 digest;
        VerifierKeyS2 vk_secondary;
        VerifierKeyS1 vk_primary;
    }

    struct ROConstantsPasta {
        uint256[] mixConstants;
        uint256[] addRoundConstants;
    }

    struct VerifierKeyPasta {
        uint256 f_arity_primary;
        uint256 f_arity_secondary;
        uint256 digest;
        ROConstantsPasta ro_consts_primary;
        ROConstantsPasta ro_consts_secondary;
        VerifierKeyS2 vk_secondary;
        VerifierKeyS1 vk_primary;
    }

    function toTranscriptBytes(uint256[] memory scalars) public pure returns (uint8[] memory) {
        uint8[] memory output = new uint8[](32 * scalars.length);
        uint256 index = 0;
        for (uint256 j = 0; j < scalars.length; j++) {
            for (uint256 i = 0; i < 32; i++) {
                output[index] = uint8(bytes1(bytes32(scalars[j])[31 - i]));
                index++;
            }
        }
        return output;
    }

    function toTranscriptBytes(Vesta.VestaAffinePoint[] memory points) public pure returns (uint8[] memory) {
        uint8[] memory output = new uint8[]((32 * 2 + 1) * points.length);
        uint256 index = 0;
        for (uint256 j = 0; j < points.length; j++) {
            // write x coordinate
            for (uint256 i = 0; i < 32; i++) {
                output[index] = uint8(bytes1(bytes32(points[j].x)[31 - i]));
                index++;
            }
            // write y coordinate
            for (uint256 i = 0; i < 32; i++) {
                output[index] = uint8(bytes1(bytes32(points[j].y)[31 - i]));
                index++;
            }

            // write byte indicating whether point is at infinity
            if (Vesta.isInfinity(points[j])) {
                output[index] = 0x00;
            } else {
                output[index] = 0x01;
            }
            index++;
        }

        return output;
    }

    function toTranscriptBytes(
        Vesta.VestaAffinePoint memory comm_W,
        Vesta.VestaAffinePoint memory comm_E,
        uint256[] memory X,
        uint256 u
    ) public pure returns (uint8[] memory) {
        // comm_W: 32 (X) + 32 (Y) + 1 (1 byte indicating whether comm_W is point at infinity)
        // comm_E: 32 (X) + 32 (Y) + 1 (1 byte indicating whether comm_E is point at infinity)
        // u: 32
        // X: 32 * len(X)
        uint8[] memory output = new uint8[](32 * 2 + 1 + 32 * 2 + 1 + 32 * X.length + 32);

        uint256 i = 0;
        uint256 index = 0;
        uint256 val;

        // write comm_W.x
        val = comm_W.x;
        for (i = 0; i < 32; i++) {
            output[index] = uint8(bytes1(bytes32(val)[31 - i]));
            index++;
        }
        // write comm_W.y
        val = comm_W.y;
        for (i = 0; i < 32; i++) {
            output[index] = uint8(bytes1(bytes32(val)[31 - i]));
            index++;
        }
        // write byte indicating whether comm_W is point at infinity
        if (Vesta.isInfinity(comm_W)) {
            output[index] = 0x00;
        } else {
            output[index] = 0x01;
        }
        index++;

        // write comm_E.x
        val = comm_E.x;
        for (i = 0; i < 32; i++) {
            output[index] = uint8(bytes1(bytes32(val)[31 - i]));
            index++;
        }
        // write comm_E.y
        val = comm_E.y;
        for (i = 0; i < 32; i++) {
            output[index] = uint8(bytes1(bytes32(val)[31 - i]));
            index++;
        }

        // write byte indicating whether comm_E is point at infinity
        if (Vesta.isInfinity(comm_E)) {
            output[index] = 0x00;
        } else {
            output[index] = 0x01;
        }
        index++;

        // write u
        val = u;
        for (i = 0; i < 32; i++) {
            output[index] = uint8(bytes1(bytes32(val)[31 - i]));
            index++;
        }

        // write X
        for (i = 0; i < X.length; i++) {
            val = X[i];
            for (uint256 j = 0; j < 32; j++) {
                output[index] = uint8(bytes1(bytes32(val)[31 - j]));
                index++;
            }
        }

        require(index == output.length, "[RelaxedR1CSInstance.toTranscriptBytesVesta] unexpected length");

        return output;
    }

    /*function toTranscriptBytes(RelaxedR1CSInstance memory U) public view returns (uint8[] memory) {
        Vesta.VestaAffinePoint memory comm_W = Vesta.decompress(U.comm_W);
        Vesta.VestaAffinePoint memory comm_E = Vesta.decompress(U.comm_E);
        return toTranscriptBytes(comm_W, comm_E, U.X, U.u);
    }*/

    function toTranscriptBytes(Pallas.PallasAffinePoint[] memory points) public pure returns (uint8[] memory) {
        uint8[] memory output = new uint8[]((32 * 2 + 1) * points.length);
        uint256 index = 0;
        for (uint256 j = 0; j < points.length; j++) {
            // write x coordinate
            for (uint256 i = 0; i < 32; i++) {
                output[index] = uint8(bytes1(bytes32(points[j].x)[31 - i]));
                index++;
            }
            // write y coordinate
            for (uint256 i = 0; i < 32; i++) {
                output[index] = uint8(bytes1(bytes32(points[j].y)[31 - i]));
                index++;
            }

            // write byte indicating whether point is at infinity
            if (Pallas.isInfinity(points[j])) {
                output[index] = 0x00;
            } else {
                output[index] = 0x01;
            }
            index++;
        }

        return output;
    }

    function toTranscriptBytes(
        Pallas.PallasAffinePoint memory comm_W,
        Pallas.PallasAffinePoint memory comm_E,
        uint256[] memory X,
        uint256 u
    ) public pure returns (uint8[] memory) {
        // comm_W: 32 (X) + 32 (Y) + 1 (1 byte indicating whether comm_W is point at infinity)
        // comm_E: 32 (X) + 32 (Y) + 1 (1 byte indicating whether comm_E is point at infinity)
        // u: 32
        // X: 32 * len(X)
        uint8[] memory output = new uint8[](32 * 2 + 1 + 32 * 2 + 1 + 32 * X.length + 32);

        uint256 i = 0;
        uint256 index = 0;
        uint256 val;

        // write comm_W.x
        val = comm_W.x;
        for (i = 0; i < 32; i++) {
            output[index] = uint8(bytes1(bytes32(val)[31 - i]));
            index++;
        }
        // write comm_W.y
        val = comm_W.y;
        for (i = 0; i < 32; i++) {
            output[index] = uint8(bytes1(bytes32(val)[31 - i]));
            index++;
        }
        // write byte indicating whether comm_W is point at infinity
        if (Pallas.isInfinity(comm_W)) {
            output[index] = 0x00;
        } else {
            output[index] = 0x01;
        }
        index++;

        // write comm_E.x
        val = comm_E.x;
        for (i = 0; i < 32; i++) {
            output[index] = uint8(bytes1(bytes32(val)[31 - i]));
            index++;
        }
        // write comm_E.y
        val = comm_E.y;
        for (i = 0; i < 32; i++) {
            output[index] = uint8(bytes1(bytes32(val)[31 - i]));
            index++;
        }

        // write byte indicating whether comm_E is point at infinity
        if (Pallas.isInfinity(comm_E)) {
            output[index] = 0x00;
        } else {
            output[index] = 0x01;
        }
        index++;

        // write u
        val = u;
        for (i = 0; i < 32; i++) {
            output[index] = uint8(bytes1(bytes32(val)[31 - i]));
            index++;
        }

        // write X
        for (i = 0; i < X.length; i++) {
            val = X[i];
            for (uint256 j = 0; j < 32; j++) {
                output[index] = uint8(bytes1(bytes32(val)[31 - j]));
                index++;
            }
        }

        require(index == output.length, "[RelaxedR1CSInstance.toTranscriptBytesPallas] unexpected length");

        return output;
    }

    function toTranscriptBytes(RelaxedR1CSInstance memory U) public view returns (uint8[] memory) {
        Pallas.PallasAffinePoint memory comm_W = Pallas.decompress(U.comm_W);
        Pallas.PallasAffinePoint memory comm_E = Pallas.decompress(U.comm_E);
        return toTranscriptBytes(comm_W, comm_E, U.X, U.u);
    }
}
