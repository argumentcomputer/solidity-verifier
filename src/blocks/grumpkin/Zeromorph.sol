pragma solidity ^0.8.16;

import "@std/Test.sol";
import "src/blocks/grumpkin/Bn256.sol";

library Zeromorph {
    function runPairingCheck(
        Pairing.G1Point memory c,
        Pairing.G2Point memory minus_vk_s_offset,
        Pairing.G1Point memory pi,
        Pairing.G2Point memory vk_vp_beta_h_minus_vk_vp_h_mul_x
    ) internal returns (bool) {
        return Pairing.pairingProd2(c, minus_vk_s_offset, pi, vk_vp_beta_h_minus_vk_vp_h_mul_x);
    }

    function compute_squares_of_x(uint256 num_vars, uint256 x) internal returns (uint256[] memory) {
        // x, x^3, x^5, x^7, ...
        uint256[] memory squares_of_x = new uint256[](1 + num_vars);
        uint256 item = mulmod(x, x, Bn256.R_MOD);
        squares_of_x[0] = x;
        for (uint256 index = 1; index < squares_of_x.length; index++) {
            squares_of_x[index] = item;
            item = mulmod(item, item, Bn256.R_MOD);
        }
        return squares_of_x;
    }

    function compute_offsets_of_x(uint256 num_vars, uint256[] memory squares_of_x)
        internal
        returns (uint256[] memory)
    {
        uint256[] memory offsets_of_x = new uint256[](num_vars);
        uint256 state = 1;
        for (uint256 index = 1; index < squares_of_x.length; index++) {
            state = mulmod(state, squares_of_x[squares_of_x.length - index - 1], Bn256.R_MOD);
            offsets_of_x[squares_of_x.length - index - 1] = state;
        }
        return offsets_of_x;
    }

    function compute_vs(uint256 num_vars, uint256[] memory squares_of_x) internal returns (uint256[] memory) {
        uint256[] memory vs = new uint256[](1 + num_vars);
        uint256 v_numer = addmod(squares_of_x[num_vars], Bn256.negateScalar(1), Bn256.R_MOD);
        for (uint256 index = 0; index < squares_of_x.length; index++) {
            vs[index] = addmod(squares_of_x[index], Bn256.negateScalar(1), Bn256.R_MOD);
            vs[index] = Field.invert(vs[index], Bn256.R_MOD);
            vs[index] = mulmod(vs[index], v_numer, Bn256.R_MOD);
        }
        return vs;
    }

    function eval_and_quotient_scalars(uint256 y, uint256 x, uint256 z, uint256[] memory u)
        internal
        returns (uint256, uint256[] memory)
    {
        uint256 index;

        uint256[] memory squares_of_x = compute_squares_of_x(u.length, x);

        uint256[] memory offsets_of_x = compute_offsets_of_x(u.length, squares_of_x);

        uint256[] memory vs = compute_vs(u.length, squares_of_x);

        uint256[] memory q_scalars = new uint256[](u.length);
        uint256 tmp = y;
        uint256 tmp1;
        uint256 tmp2;
        for (index = 0; index < q_scalars.length; index++) {
            q_scalars[index] = mulmod(tmp, offsets_of_x[index], Bn256.R_MOD);
            tmp = mulmod(tmp, y, Bn256.R_MOD);

            tmp1 = mulmod(u[index], vs[index], Bn256.R_MOD);
            tmp2 = mulmod(squares_of_x[index], vs[index + 1], Bn256.R_MOD);
            tmp1 = addmod(tmp2, Bn256.negateScalar(tmp1), Bn256.R_MOD);
            tmp1 = mulmod(z, tmp1, Bn256.R_MOD);

            q_scalars[index] = addmod(q_scalars[index], tmp1, Bn256.R_MOD);
            q_scalars[index] = Bn256.negateScalar(q_scalars[index]);
        }

        return (mulmod(Bn256.negateScalar(vs[0]), z, Bn256.R_MOD), q_scalars);
    }

    function compose_scalars(uint256 eval_scalar, uint256 z, uint256 zm_evaluation, uint256[] memory q_scalars)
        internal
        pure
        returns (uint256[] memory)
    {
        uint256[] memory output = new uint256[](3 + q_scalars.length);
        uint256 offset = 0;

        output[offset] = 1;
        offset += 1;

        output[offset] = z;
        offset += 1;

        output[offset] = mulmod(eval_scalar, zm_evaluation, Bn256.R_MOD);
        offset += 1;

        for (uint256 i = 0; i < q_scalars.length; i++) {
            output[offset] = q_scalars[i];
            offset += 1;
        }

        return output;
    }
}

// Based on: https://gist.github.com/chriseth/f9be9d9391efc5beb9704255a8e2989d
library Pairing {
    struct G1Point {
        Bn256.Bn256AffinePoint inner;
    }

    struct G2Point {
        uint256[2] X;
        uint256[2] Y;
    }

    function P1() internal pure returns (G1Point memory) {
        return G1Point(Bn256.Bn256AffinePoint(1, 2));
    }

    function P2() internal pure returns (G2Point memory) {
        return G2Point(
            [
                10857046999023057135944570762232829481370756359578518086990519993285655852781,
                11559732032986387107991004021392285783925812861821192530917403151452391805634
            ],
            [
                8495653923123431417604973247489272438418190587263600148770280649306958101930,
                4082367875863433681332203403145435568316851327593401208105741076214120093531
            ]
        );
    }

    function negate(G1Point memory p) internal pure returns (G1Point memory) {
        return G1Point(Bn256.negate(p.inner));
    }

    function mul(G1Point memory p, uint256 s) internal returns (G1Point memory) {
        return G1Point(Bn256.scalarMul(p.inner, s));
    }

    function add(G1Point memory p1, G1Point memory p2) internal returns (G1Point memory) {
        return G1Point(Bn256.add(p1.inner, p2.inner));
    }

    /// @return the result of computing the pairing check
    /// e(p1[0], p2[0]) *  .... * e(p1[n], p2[n]) == 1
    /// For example pairing([P1(), P1().negate()], [P2(), P2()]) should
    /// return true.
    function pairing(G1Point[] memory p1, G2Point[] memory p2) internal returns (bool) {
        require(p1.length == p2.length);
        uint256 elements = p1.length;
        uint256 inputSize = elements * 6;
        uint256[] memory input = new uint[](inputSize);
        for (uint256 i = 0; i < elements; i++) {
            input[i * 6 + 0] = p1[i].inner.x;
            input[i * 6 + 1] = p1[i].inner.y;
            // To be compatible with Rust, it is necessary to reverse the field element encoding
            input[i * 6 + 2] = p2[i].X[1];
            input[i * 6 + 3] = p2[i].X[0];
            input[i * 6 + 4] = p2[i].Y[1];
            input[i * 6 + 5] = p2[i].Y[0];
        }
        uint256[1] memory out;
        assembly {
            let success := call(sub(gas(), 2000), 8, 0, add(input, 0x20), mul(inputSize, 0x20), out, 0x20)
            switch success
            case 0 { revert(0, 0) }
        }
        return out[0] != 0;
    }

    function pairingProd2(G1Point memory a1, G2Point memory a2, G1Point memory b1, G2Point memory b2)
        internal
        returns (bool)
    {
        G1Point[] memory p1 = new G1Point[](2);
        G2Point[] memory p2 = new G2Point[](2);
        p1[0] = a1;
        p1[1] = b1;
        p2[0] = a2;
        p2[1] = b2;
        return pairing(p1, p2);
    }
}
