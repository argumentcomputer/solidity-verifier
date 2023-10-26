pragma solidity ^0.8.16;

import "@std/Test.sol";
import "src/Utilities.sol";

library Bn256 {
    // P_MOD and R_MOD need to be switched (and whole set of unit-tests revisited)!!!
    uint256 public constant P_MOD = 0x30644e72e131a029b85045b68181585d97816a916871ca8d3c208c16d87cfd47;
    uint256 public constant R_MOD = 0x30644e72e131a029b85045b68181585d2833e84879b9709143e1f593f0000001;
    uint256 public constant B = 3;

    struct Bn256AffinePoint {
        uint256 x;
        uint256 y;
    }

    function add(Bn256AffinePoint memory p1, Bn256AffinePoint memory p2) public returns (Bn256AffinePoint memory) {
        bytes32[2] memory addResult;

        bytes32[4] memory input;
        input[0] = bytes32(p1.x);
        input[1] = bytes32(p1.y);
        input[2] = bytes32(p2.x);
        input[3] = bytes32(p2.y);

        assembly {
            let success := call(gas(), 0x06, 0, input, 0x80, addResult, 0x40)
            switch success
            case 0 { revert(0, 0) }
        }

        return Bn256AffinePoint(uint256(addResult[0]), uint256(addResult[1]));
    }

    function scalarMul(Bn256AffinePoint memory a, uint256 scalar) public returns (Bn256AffinePoint memory) {
        bytes32[3] memory input;
        input[0] = bytes32(a.x);
        input[1] = bytes32(a.y);
        input[2] = bytes32(scalar);

        bytes32[2] memory mulResult;

        assembly {
            let success := call(gas(), 0x07, 0, input, 0x60, mulResult, 0x40)
            switch success
            case 0 { revert(0, 0) }
        }
        return Bn256AffinePoint(uint256(mulResult[0]), uint256(mulResult[1]));
    }

    function negate(Bn256AffinePoint memory a) public pure returns (Bn256AffinePoint memory) {
        return Bn256AffinePoint(a.x, P_MOD - (a.y % P_MOD));
    }

    function negateBase(uint256 scalar) internal pure returns (uint256) {
        return P_MOD - (scalar % P_MOD);
    }

    function negateScalar(uint256 scalar) internal pure returns (uint256) {
        return R_MOD - (scalar % R_MOD);
    }

    function is_identity(Bn256AffinePoint memory p1) public pure returns (bool) {
        if (p1.x != 0) {
            return false;
        }
        if (p1.y != 0) {
            return false;
        }
        return true;
    }

    function decompress(uint256 compressed) public view returns (Bn256AffinePoint memory) {
        uint8 is_inf = uint8(bytes32(compressed)[0]) >> 7;
        uint8 y_sign = uint8(bytes32(compressed)[0]) >> 6;
        y_sign &= 1;

        uint256 x = compressed & 0x3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;

        if ((x == 0) && (is_inf == 0)) {
            // identity
            return Bn256AffinePoint(0, 0);
        }

        uint256 y;
        uint256 _mod = P_MOD;

        assembly {
            y := mulmod(x, x, _mod)
            y := mulmod(y, x, _mod)
            y := addmod(y, B, _mod)
        }

        y = Field.sqrt(y, _mod);

        uint8 sign = ((uint8(y & 0xff)) & 1);

        if ((y_sign ^ sign) == 1) {
            y = negateBase(y);
        }

        return Bn256AffinePoint(x, y);
    }
}
