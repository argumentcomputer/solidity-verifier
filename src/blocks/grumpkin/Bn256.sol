pragma solidity ^0.8.16;

import "@std/Test.sol";
import "src/Utilities.sol";

library Bn256 {
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

    function multiScalarMul(Bn256AffinePoint[] memory bases, uint256[] memory scalars)
        public
        returns (Bn256AffinePoint memory r)
    {
        require(scalars.length == bases.length, "MSM error: length does not match");

        r = scalarMul(bases[0], scalars[0]);
        for (uint256 i = 1; i < scalars.length; i++) {
            r = add(r, scalarMul(bases[i], scalars[i]));
        }
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

// Implementation of arithmetics over G2 elements (required by Zeromorph computations)
// TODO: implement scalar multiplication (https://github.com/privacy-scaling-explorations/halo2curves/blob/main/src/derive/curve.rs#L1276),
// which relies on G2 point doubling (https://github.com/privacy-scaling-explorations/halo2curves/blob/main/src/derive/curve.rs#L635)
library G2 {
    struct Fq2 {
        uint256 c0;
        uint256 c1;
    }

    struct G2Affine {
        Fq2 x;
        Fq2 y;
    }

    function g2Add(G2Affine memory self, G2Affine memory rhs) public returns (G2Affine memory) {
        // All affine points have z = (1, 0)
        Fq2 memory z = Fq2(1, 0);
        Fq2 memory t0 = multFq2(self.x, rhs.x);
        Fq2 memory t1 = multFq2(self.y, rhs.y);
        Fq2 memory t2 = multFq2(z, z);
        Fq2 memory t3 = addFq2(self.x, self.y);
        Fq2 memory t4 = addFq2(rhs.x, rhs.y);

        t3 = multFq2(t3, t4);
        t4 = addFq2(t0, t1);
        t3 = subFq2(t3, t4);
        t4 = addFq2(self.x, z);
        Fq2 memory t5 = addFq2(rhs.x, z);

        t4 = multFq2(t4, t5);
        t5 = addFq2(t0, t2);
        t4 = subFq2(t4, t5);
        t5 = addFq2(self.y, z);
        Fq2 memory x3 = addFq2(rhs.y, z);

        t5 = multFq2(t5, x3);
        x3 = addFq2(t1, t2);
        t5 = subFq2(t5, x3);

        // since z3 = A * t4 and A = (0, 0), so z3 = (0, 0)
        Fq2 memory z3 = Fq2(0, 0);
        x3 = mul_by_3b(t2);
        z3 = addFq2(x3, z3);
        x3 = subFq2(t1, z3);
        z3 = addFq2(t1, z3);
        Fq2 memory y3 = multFq2(x3, z3);
        t1 = addFq2(t0, t0);
        t1 = addFq2(t1, t0);

        // since t2 = A * t2 and A = (0, 0), so t2 = (0, 0)
        t2 = Fq2(0, 0);
        t4 = mul_by_3b(t4);
        t1 = addFq2(t1, t2);
        t2 = subFq2(t0, t2);

        // since t2 = A * t2 and A = (0, 0), so t2 = (0, 0)
        t2 = Fq2(0, 0);
        t4 = addFq2(t4, t2);
        t0 = multFq2(t1, t4);
        y3 = addFq2(y3, t0);
        t0 = multFq2(t5, t4);
        x3 = multFq2(t3, x3);
        x3 = subFq2(x3, t0);
        t0 = multFq2(t3, t1);
        z3 = multFq2(t5, z3);
        z3 = addFq2(z3, t0);

        Fq2 memory out_x;
        Fq2 memory out_y;

        (out_x, out_y) = to_g2affine(x3, y3, z3);
        return G2Affine(out_x, out_y);
    }

    function invertFq2(Fq2 memory fq2) public returns (Fq2 memory) {
        uint256 t1 = mulmod(fq2.c1, fq2.c1, Bn256.P_MOD);
        uint256 t0 = mulmod(fq2.c0, fq2.c0, Bn256.P_MOD);

        t0 = addmod(t0, t1, Bn256.P_MOD);
        uint256 t = Field.invert(t0, Bn256.P_MOD);

        uint256 c0 = fq2.c0;
        uint256 c1 = fq2.c1;

        c0 = mulmod(c0, t, Bn256.P_MOD);
        c1 = mulmod(c1, t, Bn256.P_MOD);
        c1 = Bn256.negateBase(c1);

        return Fq2(c0, c1);
    }

    function to_g2affine(Fq2 memory x, Fq2 memory y, Fq2 memory z) public returns (Fq2 memory, Fq2 memory) {
        Fq2 memory zinv = invertFq2(z);
        Fq2 memory x_ = multFq2(x, zinv);
        Fq2 memory y_ = multFq2(y, zinv);

        if (zinv.c0 == 0) {
            if (zinv.c0 == 0) {
                return (Fq2(0, 0), Fq2(0, 0));
            }
        }

        return (x_, y_);
    }

    function mul_by_3b(Fq2 memory input) public returns (Fq2 memory) {
        // B = (0x20753adca9c6bfb81499be5e509e8f8ff21b7c8d3cb039cf1ef69c66bce9b021, 0x01c53b10b0d2fc7e67860f09cc8af9ddf5eee18eaf8748f8ade8371391494176)
        return multFq2(
            input,
            Fq2(
                0x20753adca9c6bfb81499be5e509e8f8ff21b7c8d3cb039cf1ef69c66bce9b021,
                0x01c53b10b0d2fc7e67860f09cc8af9ddf5eee18eaf8748f8ade8371391494176
            )
        );
    }

    function subFq2(Fq2 memory self, Fq2 memory other) public view returns (Fq2 memory) {
        Fq2 memory b_neg = Fq2(Bn256.negateBase(other.c0), Bn256.negateBase(other.c1));

        return Fq2(addmod(self.c0, b_neg.c0, Bn256.P_MOD), addmod(self.c1, b_neg.c1, Bn256.P_MOD));
    }

    function addFq2(Fq2 memory self, Fq2 memory other) public view returns (Fq2 memory) {
        return Fq2(addmod(self.c0, other.c0, Bn256.P_MOD), addmod(self.c1, other.c1, Bn256.P_MOD));
    }

    function multFq2(Fq2 memory self, Fq2 memory other) public view returns (Fq2 memory) {
        uint256 self_c1;
        uint256 self_c0;
        uint256 t1;
        uint256 t0;
        uint256 t2;
        t1 = mulmod(self.c0, other.c0, Bn256.P_MOD);
        t0 = addmod(self.c0, self.c1, Bn256.P_MOD);
        t2 = mulmod(self.c1, other.c1, Bn256.P_MOD);
        self_c1 = addmod(other.c0, other.c1, Bn256.P_MOD);
        self_c0 = addmod(t1, Bn256.negateBase(t2), Bn256.P_MOD);
        t1 = addmod(t1, t2, Bn256.P_MOD);
        t0 = mulmod(t0, self_c1, Bn256.P_MOD);
        self_c1 = addmod(t0, Bn256.negateBase(t1), Bn256.P_MOD);

        return Fq2(self_c0, self_c1);
    }
}
