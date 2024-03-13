// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.16;

import "src/blocks/grumpkin/Bn256.sol";

/**
 * @title Pairing Library
 * @notice Provides functionalities for elliptic curve pairing operations, specifically for BN256 curve. Based on:
 *         https://gist.github.com/chriseth/f9be9d9391efc5beb9704255a8e2989d
 * @dev This library is essential for cryptographic operations that require pairing checks.
 */
library Pairing {
    // Represents a point on G1 (first group of BN256 curve).
    struct G1Point {
        Bn256.Bn256AffinePoint inner;
    }
    // Represents a point on G2 (second group of BN256 curve).

    struct G2Point {
        uint256[2] X;
        uint256[2] Y;
    }

    /**
     * @notice Computes the pairing check of two sets of points.
     * @param p1 Array of G1 points.
     * @param p2 Array of G2 points.
     * @return True if the pairing check passes, false otherwise.
     * @dev For example pairing([P1(), P1().negate()], [P2(), P2()]) should
     *      return true.
     */
    function pairing(G1Point[] memory p1, G2Point[] memory p2) internal returns (bool) {
        require(p1.length == p2.length);
        uint256 elements = p1.length;
        uint256 inputSize = elements * 6;
        uint256[] memory input = new uint256[](inputSize);
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

    /**
     * @notice Computes the product of pairings for two pairs of points.
     * @param a1 The first G1 point in the first pair.
     * @param a2 The first G2 point in the first pair.
     * @param b1 The second G1 point in the second pair.
     * @param b2 The second G2 point in the second pair.
     * @return True if the product of pairings check passes, false otherwise.
     */
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
