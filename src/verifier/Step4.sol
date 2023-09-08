// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.16;

import "@std/Test.sol";
import "src/blocks/pasta/Pallas.sol";
import "src/blocks/pasta/Vesta.sol";
import "src/NovaVerifierAbstractions.sol";

library Step4Lib {
    function verify(Abstractions.CompressedSnark calldata proof, uint256 modulusPrimary, uint256 modulusSecondary)
        public
        pure
        returns (bool)
    {
        if (!verifyInner(proof.r_W_snark_primary, modulusPrimary)) {
            return false;
        } else if (!verifyInner(proof.f_W_snark_secondary, modulusSecondary)) {
            return false;
        }
        return true;
    }

    function verifyInner(Abstractions.RelaxedR1CSSNARK calldata proof, uint256 modulus) private pure returns (bool) {
        // row
        uint256 left = mulmod(proof.claims_product_arr[0], proof.claims_product_arr[2], modulus);
        uint256 right = mulmod(proof.claims_product_arr[1], proof.claims_product_arr[3], modulus);
        if (left != right) {
            return false;
        }

        // col
        left = mulmod(proof.claims_product_arr[4], proof.claims_product_arr[6], modulus);
        right = mulmod(proof.claims_product_arr[5], proof.claims_product_arr[7], modulus);
        if (left != right) {
            return false;
        }

        return true;
    }
}
