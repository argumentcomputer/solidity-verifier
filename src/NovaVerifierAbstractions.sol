// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.0;

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

    struct CompressedSnark {
        R1CSInstance l_u_secondary;
        RelaxedR1CSInstance r_U_primary;
        RelaxedR1CSInstance r_U_secondary;
        uint256[] zn_primary;
        uint256[] zn_secondary;
        uint256 nifs_compressed_comm_T;
    }

    struct ROConstants {
        uint256[] mixConstants;
        uint256[] addRoundConstants;
    }

    struct VerifierKey {
        uint256 f_arity_primary;
        uint256 f_arity_secondary;
        uint256 digest;
        ROConstants ro_consts_primary;
        ROConstants ro_consts_secondary;
    }
}
