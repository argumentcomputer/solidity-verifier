pragma solidity ^0.8.16;

import "@std/Test.sol";
import "src/Utilities.sol";

library Grumpkin {
    uint256 public constant P_MOD = 0x30644e72e131a029b85045b68181585d97816a916871ca8d3c208c16d87cfd47;
    uint256 public constant R_MOD = 0x30644e72e131a029b85045b68181585d2833e84879b9709143e1f593f0000001;
    uint256 public constant B = 0x30644e72e131a029b85045b68181585d2833e84879b9709143e1f593effffff0;

    struct GrumpkinAffinePoint {
        uint256 x;
        uint256 y;
    }

    function Identity() public pure returns (GrumpkinAffinePoint memory) {
        return GrumpkinAffinePoint(0, 0);
    }

    function add(GrumpkinAffinePoint memory p1, GrumpkinAffinePoint memory p2)
        public
        view
        returns (GrumpkinAffinePoint memory)
    {
        uint256 self_x = p1.x;
        uint256 rhs_x = p2.x;
        uint256 self_y = p1.y;
        uint256 rhs_y = p2.y;
        uint256 self_z = 1;
        uint256 rhs_z = 1;

        if (is_identity(p1)) {
            self_x = 0;
            self_y = 1;
            self_z = 0;
        }
        if (is_identity(p2)) {
            rhs_x = 0;
            rhs_y = 1;
            rhs_z = 0;
            // if both p1 and p2 are identities, result is identity
            if (is_identity(p1)) {
                return GrumpkinAffinePoint(0, 0);
            }
        }

        // t0, t1, t2, t3, t4, t5
        uint256[] memory t = new uint256[](6);

        uint256 x3;
        uint256 y3;
        uint256 z3;

        t[0] = mulmod(self_x, rhs_x, R_MOD);
        t[1] = mulmod(self_y, rhs_y, R_MOD);
        t[2] = mulmod(self_z, rhs_z, R_MOD);
        t[3] = addmod(self_x, self_y, R_MOD);
        t[4] = addmod(rhs_x, rhs_y, R_MOD);
        t[3] = mulmod(t[3], t[4], R_MOD);
        t[4] = addmod(t[0], t[1], R_MOD);
        t[3] = addmod(t[3], negateScalar(t[4]), R_MOD); // negateScalar, R_MOD
        t[4] = addmod(self_x, self_z, R_MOD);
        t[5] = addmod(rhs_x, rhs_z, R_MOD);
        t[4] = mulmod(t[4], t[5], R_MOD);
        t[5] = addmod(t[0], t[2], R_MOD);
        t[4] = addmod(t[4], negateScalar(t[5]), R_MOD); // negateScalar, R_MOD
        t[5] = addmod(self_y, self_z, R_MOD);
        x3 = addmod(rhs_y, rhs_z, R_MOD);
        t[5] = mulmod(t[5], x3, R_MOD);
        x3 = addmod(t[1], t[2], R_MOD);
        t[5] = addmod(t[5], negateScalar(x3), R_MOD); // negateScalar, R_MOD
        z3 = 0; // since constant A = 0 in Grumpkin
        x3 = mul_by_3b(t[2]);
        z3 = addmod(x3, z3, R_MOD);
        x3 = addmod(t[1], negateScalar(z3), R_MOD); // negateScalar, R_MOD
        z3 = addmod(t[1], z3, R_MOD);
        y3 = mulmod(x3, z3, R_MOD);
        t[1] = addmod(t[0], t[0], R_MOD);
        t[1] = addmod(t[1], t[0], R_MOD);
        t[2] = 0; // since constant A = 0 in Grumpkin
        t[4] = mul_by_3b(t[4]);
        t[1] = addmod(t[1], t[2], R_MOD);
        t[2] = addmod(t[0], negateScalar(t[2]), R_MOD); // negateScalar, R_MOD
        t[2] = 0; // since constant A = 0 in Grumpkin
        t[4] = addmod(t[4], t[2], R_MOD);
        t[0] = mulmod(t[1], t[4], R_MOD);
        y3 = addmod(y3, t[0], R_MOD);
        t[0] = mulmod(t[5], t[4], R_MOD);
        x3 = mulmod(t[3], x3, R_MOD);
        x3 = addmod(x3, negateScalar(t[0]), R_MOD); // negateScalar, R_MOD
        t[0] = mulmod(t[3], t[1], R_MOD);
        z3 = mulmod(t[5], z3, R_MOD);
        z3 = addmod(z3, t[0], R_MOD);
        (t[0], t[1]) = to_affine(x3, y3, z3);

        return GrumpkinAffinePoint(t[0], t[1]);
    }

    function is_identity(GrumpkinAffinePoint memory p1) public pure returns (bool) {
        if (p1.x != 0) {
            return false;
        }
        if (p1.y != 0) {
            return false;
        }
        return true;
    }

    function to_affine(uint256 x_input, uint256 y_input, uint256 z_input) private view returns (uint256, uint256) {
        require(z_input != 0, "[Grumpkin::to_affine] can't invert zero");

        uint256 zinv = Field.invert(z_input, R_MOD);
        uint256 x = mulmod(x_input, zinv, R_MOD);
        uint256 y = mulmod(y_input, zinv, R_MOD);
        return (x, y);
    }

    function mul_by_3b(uint256 t) private pure returns (uint256) {
        // In Rust:
        //        static ref CONST_3B: $base = $constant_b + $constant_b + $constant_b;
        // In Solidity:
        //        uint256 const_b = 0x30644e72e131a029b85045b68181585d2833e84879b9709143e1f593effffff0;
        //        uint256 const_2b = addmod(const_b, const_b, Grumpkin.R_MOD);
        //        uint256 const_3b = addmod(const_2b, const_b, Grumpkin.R_MOD);
        return mulmod(t, 0x30644e72e131a029b85045b68181585d2833e84879b9709143e1f593efffffce, R_MOD);
    }

    function negate(GrumpkinAffinePoint memory a) public pure returns (GrumpkinAffinePoint memory) {
        return GrumpkinAffinePoint(a.x, P_MOD - (a.y % P_MOD));
    }

    function negateBase(uint256 scalar) internal pure returns (uint256) {
        return P_MOD - (scalar % P_MOD);
    }

    function negateScalar(uint256 scalar) internal pure returns (uint256) {
        return R_MOD - (scalar % R_MOD);
    }

    function double(GrumpkinAffinePoint memory point) public view returns (GrumpkinAffinePoint memory) {
        if (is_identity(point)) {
            return point;
        }
        uint256 x = point.x;
        uint256 y = point.y;
        //uint256 z = 1;

        uint256 t0 = mulmod(x, x, R_MOD);
        uint256 t1 = mulmod(y, y, R_MOD);
        uint256 t2 = 1; // z * z = 1 * 1 = 1
        uint256 t3 = mulmod(x, y, R_MOD);
        t3 = addmod(t3, t3, R_MOD);
        uint256 z3 = x; // x * z = x * 1 = x
        z3 = addmod(z3, z3, R_MOD);
        uint256 x3 = 0; // since constant A = 0 in Grumpkin
        uint256 y3 = mul_by_3b(t2);
        y3 = addmod(x3, y3, R_MOD);
        x3 = addmod(t1, negateScalar(y3), R_MOD);
        y3 = addmod(t1, y3, R_MOD);
        y3 = mulmod(x3, y3, R_MOD);
        x3 = mulmod(t3, x3, R_MOD);
        z3 = mul_by_3b(z3);
        t2 = 0; // // since constant A = 0 in Grumpkin
        t3 = addmod(t0, negateScalar(t2), R_MOD);
        t3 = 0; // since constant A = 0 in Grumpkin
        t3 = addmod(t3, z3, R_MOD);
        z3 = addmod(t0, t0, R_MOD);
        t0 = addmod(z3, t0, R_MOD);
        t0 = addmod(t0, t2, R_MOD);
        t0 = mulmod(t0, t3, R_MOD);
        y3 = addmod(y3, t0, R_MOD);
        t2 = y; // y * z = y * 1 = y
        t2 = addmod(t2, t2, R_MOD);
        t0 = mulmod(t2, t3, R_MOD);
        x3 = addmod(x3, negateScalar(t0), R_MOD);
        z3 = mulmod(t2, t1, R_MOD);
        z3 = addmod(z3, z3, R_MOD);
        z3 = addmod(z3, z3, R_MOD);

        (x, y) = to_affine(x3, y3, z3);

        return GrumpkinAffinePoint(x, y);
    }

    function scalarMul(GrumpkinAffinePoint memory point, uint256 scalar)
        public
        view
        returns (GrumpkinAffinePoint memory)
    {
        GrumpkinAffinePoint memory acc = Identity();

        bytes32 scalar_bytes = bytes32(scalar);
        for (uint256 byteIndex = 0; byteIndex < 32; byteIndex++) {
            for (uint256 bitIndex = 0; bitIndex < 8; bitIndex++) {
                acc = double(acc);
                if ((uint8(scalar_bytes[byteIndex] >> (7 - bitIndex)) & 1) == 1) {
                    acc = add(acc, point);
                }
            }
        }

        return acc;
    }

    function decompress(uint256 compressed) public view returns (GrumpkinAffinePoint memory) {
        uint8 is_inf = uint8(bytes32(compressed)[0]) >> 7;
        uint8 y_sign = uint8(bytes32(compressed)[0]) >> 6;
        y_sign &= 1;

        uint256 x = compressed & 0x3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;

        if ((x == 0) && (is_inf == 0)) {
            return Identity();
        }

        uint256 y;
        uint256 _mod = R_MOD;

        assembly {
            y := mulmod(x, x, _mod)
            y := mulmod(y, x, _mod)
            y := addmod(y, B, _mod)
        }

        y = Field.sqrt(y, _mod);

        uint8 sign = ((uint8(y & 0xff)) & 1);

        if ((y_sign ^ sign) == 1) {
            y = negateScalar(y);
        }

        return GrumpkinAffinePoint(x, y);
    }
}
