// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.0;

import "src/pasta/Vesta.sol";
import "src/pasta/Pallas.sol";

library PolyEvalInstanceUtilities {
    function powers(uint256 s, uint256 len, uint256 modulus) internal pure returns (uint256[] memory) {
        require(len >= 1);
        uint256[] memory result = new uint256[](len);
        result[0] = 1;

        for (uint256 index = 1; index < len; index++) {
            result[index] = mulmod(result[index - 1], s, modulus);
        }

        return result;
    }
}

library PolyEvalInstanceLib {
    struct PolyEvalInstanceVesta {
        Vesta.VestaAffinePoint c;
        uint256[] x;
        uint256 e;
    }

    struct PolyEvalInstancePallas {
        Pallas.PallasAffinePoint c;
        uint256[] x;
        uint256 e;
    }

    function batchPrimary(
        Pallas.PallasAffinePoint[] memory comm_vec,
        uint256[] memory x,
        uint256[] memory eval_vec,
        uint256 s
    ) public view returns (PolyEvalInstancePallas memory) {
        require(
            comm_vec.length == eval_vec.length, "[PolyEvalInstanceLib.batchPrimary]: comm_vec.length != eval_vec.length"
        );

        uint256[] memory powers_of_s = PolyEvalInstanceUtilities.powers(s, comm_vec.length, Pallas.R_MOD);
        uint256 e;
        for (uint256 index = 0; index < eval_vec.length; index++) {
            e = addmod(e, mulmod(powers_of_s[index], eval_vec[index], Pallas.R_MOD), Pallas.R_MOD);
        }

        Pallas.PallasAffinePoint memory c_out = Pallas.PallasAffinePoint(0, 0);
        Pallas.PallasAffinePoint memory temp = Pallas.PallasAffinePoint(0, 0);
        for (uint256 index = 0; index < comm_vec.length; index++) {
            temp = Pallas.scalarMul(comm_vec[index], powers_of_s[index]);

            c_out = Pallas.add(temp, c_out);
        }
        // x is just a copy of input
        return PolyEvalInstancePallas(c_out, x, e);
    }

    function batchSecondary(
        Vesta.VestaAffinePoint[] memory comm_vec,
        uint256[] memory x,
        uint256[] memory eval_vec,
        uint256 s
    ) public view returns (PolyEvalInstanceVesta memory) {
        require(
            comm_vec.length == eval_vec.length,
            "[PolyEvalInstanceLib.batchSecondary]: comm_vec.length != eval_vec.length"
        );

        uint256[] memory powers_of_s = PolyEvalInstanceUtilities.powers(s, comm_vec.length, Vesta.R_MOD);

        uint256 e;
        for (uint256 index = 0; index < eval_vec.length; index++) {
            e = addmod(e, mulmod(powers_of_s[index], eval_vec[index], Vesta.R_MOD), Vesta.R_MOD);
        }

        Vesta.VestaAffinePoint memory c_out = Vesta.VestaAffinePoint(0, 0);
        Vesta.VestaAffinePoint memory temp = Vesta.VestaAffinePoint(0, 0);
        for (uint256 index = 0; index < comm_vec.length; index++) {
            temp = Vesta.scalarMul(comm_vec[index], powers_of_s[index]);

            c_out = Vesta.add(temp, c_out);
        }

        // x is just a copy of input
        return PolyEvalInstanceVesta(c_out, x, e);
    }
}
