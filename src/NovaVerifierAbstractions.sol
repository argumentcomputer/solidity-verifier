// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.0;

library Abstractions {
    struct RelaxedR1CSInstance {
        uint256 comm_W;
        uint256 comm_E;
        uint256[] X;
        uint256 u;
    }

    struct R1CSInstance {
        uint256 comm_W;
        uint256[] X;
    }

    //struct VerifierKey {
    //
    //}

    struct CompressedSnark {
        R1CSInstance l_u_secondary;
        RelaxedR1CSInstance r_U_primary;
        RelaxedR1CSInstance r_U_secondary;
    }
}