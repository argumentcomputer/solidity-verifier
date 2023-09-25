pragma solidity ^0.8.16;

import "@std/Test.sol";
import "src/blocks/grumpkin/Bn256.sol";

library Zeromorph {

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
