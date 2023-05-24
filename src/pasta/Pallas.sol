// SPDX-License-Identifier: Apache-2.0
//
//
// Copyright 2022 Zhenfei Zhang
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
import "../Field.sol";

pragma solidity ^0.8.0;

library Pallas {
    //
    // Pallas curve:
    //   p = 28948022309329048855892746252171976963363056481941560715954676764349967630337
    //   r = 28948022309329048855892746252171976963363056481941647379679742748393362948097
    // E has the equation:
    //   E: y^2 = x^3 + 5

    uint256 public constant P_MOD = 28948022309329048855892746252171976963363056481941560715954676764349967630337;
    uint256 public constant R_MOD = 28948022309329048855892746252171976963363056481941647379679742748393362948097;

    uint256 private constant _THREE_OVER_TWO =
        14474011154664524427946373126085988481681528240970780357977338382174983815170;

    struct PallasAffinePoint {
        uint256 x;
        uint256 y;
    }

    struct PallasProjectivePoint {
        uint256 x;
        uint256 y;
        uint256 z;
    }

    /// @return the affine generator
    // solhint-disable-next-line func-name-mixedcase
    function AffineGenerator() internal pure returns (PallasAffinePoint memory) {
        return PallasAffinePoint(P_MOD - 1, 2);
    }

    /// @return the projective generator
    // solhint-disable-next-line func-name-mixedcase
    function ProjectiveGenerator() internal pure returns (PallasProjectivePoint memory) {
        return PallasProjectivePoint(P_MOD - 1, 2, 1);
    }

    function AffineInfinity() internal pure returns (PallasAffinePoint memory) {
        return PallasAffinePoint(0, 0);
    }

    function ProjectiveInfinity() internal pure returns (PallasProjectivePoint memory) {
        return PallasProjectivePoint(0, 1, 0);
    }

    /// @return the convert an affine point into projective
    // solhint-disable-next-line func-name-mixedcase
    function IntoProjective(PallasAffinePoint memory point) internal pure returns (PallasProjectivePoint memory) {
        if (isInfinity(point)) {
            return ProjectiveInfinity();
        }

        return PallasProjectivePoint(point.x, point.y, 1);
    }

    /// @return the convert a projective point into affine
    // solhint-disable-next-line func-name-mixedcase
    function IntoAffine(PallasProjectivePoint memory point) internal view returns (PallasAffinePoint memory) {
        if (isInfinity(point)) {
            return AffineInfinity();
        }

        uint256 zinv = invert(point.z, P_MOD);
        uint256 zinv2 = mulmod(zinv, zinv, P_MOD);
        uint256 x = mulmod(point.x, zinv2, P_MOD);
        zinv2 = mulmod(zinv, zinv2, P_MOD);
        uint256 y = mulmod(point.y, zinv2, P_MOD);

        return PallasAffinePoint(x, y);
    }

    /// @dev check if a PallasAffinePoint is Infinity
    /// @notice precompile bn256Add at address(6) takes (0, 0) as PallasAffinePoint of Infinity,
    /// some crypto libraries (such as arkwork) uses a boolean flag to mark PoI, and
    /// just use (0, 1) as affine coordinates (not on curve) to represents PoI.
    function isInfinity(PallasAffinePoint memory point) internal pure returns (bool result) {
        assembly {
            let x := mload(point)
            let y := mload(add(point, 0x20))
            result := and(iszero(x), iszero(y))
        }
    }

    /// @dev check if a PallasProjectivePoint is Infinity
    /// @notice (0, 1, 0) PallasProjectivePoint of Infinity,
    /// some crypto libraries (such as arkwork) uses a boolean flag to mark PoI, and
    /// just use (0, 1, 0) as affine coordinates (not on curve) to represents PoI.
    function isInfinity(PallasProjectivePoint memory point) internal pure returns (bool result) {
        assembly {
            let x := mload(point)
            let y := mload(add(point, 0x20))
            let z := mload(add(point, 0x20))
            result := and(and(iszero(x), eq(y, 1)), iszero(z))
        }
    }

    /// @return r the negation of p, i.e. p.add(p.negate()) should be zero.
    function negate(PallasAffinePoint memory p) internal pure returns (PallasAffinePoint memory) {
        if (isInfinity(p)) {
            return p;
        }
        return PallasAffinePoint(p.x, P_MOD - (p.y % P_MOD));
    }

    /// @return r the negation of p, i.e. p.add(p.negate()) should be zero.
    function negate(PallasProjectivePoint memory p) internal pure returns (PallasProjectivePoint memory) {
        if (isInfinity(p)) {
            return p;
        }
        return PallasProjectivePoint(p.x, P_MOD - (p.y % P_MOD), p.z);
    }

    /// @return res = -fr the negation of base field element.
    function negateBase(uint256 fr) internal pure returns (uint256 res) {
        return P_MOD - (fr % P_MOD);
    }

    /// @return res = -fr the negation of scalar field element.
    function negateScalar(uint256 fr) internal pure returns (uint256 res) {
        return R_MOD - (fr % R_MOD);
    }

    /// @return 2*point
    function double(PallasProjectivePoint memory point) internal pure returns (PallasProjectivePoint memory) {
        if (isInfinity(point)) {
            return point;
        }

        // todo: improve memory usage
        uint256 x = point.x;
        uint256 y = point.y;
        uint256 z = point.z;
        uint256 a;
        uint256 b;
        uint256 c;
        uint256 d;
        uint256 e;
        uint256 f;
        uint256 doubleP = P_MOD << 1;

        assembly {
            // A = X1^2
            a := mulmod(x, x, P_MOD)
            // B = Y1^2
            b := mulmod(y, y, P_MOD)
            // C = B^2
            c := mulmod(b, b, P_MOD)
            // D = 2*((X1+B)^2-A-C)
            d := add(x, b)
            d := mulmod(d, d, P_MOD)
            b := add(a, c)
            d := add(d, sub(doubleP, b))
            d := mulmod(d, 2, P_MOD)
            // E = 3*A
            e := mul(a, 3)
            // F = E^2
            f := mulmod(e, e, P_MOD)
            // Z3 = 2*Y1*Z1
            z := mulmod(mul(y, 2), z, P_MOD)
            // X3 = F-2*D
            x := addmod(f, sub(doubleP, mul(d, 2)), P_MOD)
            // Y3 = E*(D-X3)-8*C
            y := add(d, sub(P_MOD, x))
            y := mulmod(e, y, P_MOD)
            y := addmod(y, sub(P_MOD, mulmod(c, 8, P_MOD)), P_MOD)
        }

        return PallasProjectivePoint(x, y, z);
    }

    function double(PallasAffinePoint memory point) internal view returns (PallasAffinePoint memory) {
        if (isInfinity(point)) {
            return point;
        }

        uint256 lambda;
        uint256 x = point.x;
        uint256 y = point.y;
        uint256 yInv = invert(point.y, P_MOD);
        uint256 xPrime;
        uint256 yPrime;

        assembly {
            // lambda = 3x^2/2y
            lambda := mulmod(x, x, P_MOD)
            lambda := mulmod(lambda, yInv, P_MOD)
            lambda := mulmod(lambda, _THREE_OVER_TWO, P_MOD)

            // x' = lambda^2 - 2x
            xPrime := mulmod(lambda, lambda, P_MOD)
            xPrime := add(xPrime, P_MOD)
            xPrime := add(xPrime, P_MOD)
            xPrime := sub(xPrime, x)
            xPrime := sub(xPrime, x)
            xPrime := mod(xPrime, P_MOD)

            // y' = lambda * (x-x') - y
            yPrime := add(x, P_MOD)
            yPrime := sub(yPrime, xPrime)
            yPrime := mulmod(lambda, yPrime, P_MOD)
            yPrime := add(yPrime, P_MOD)
            yPrime := sub(yPrime, y)
            yPrime := mod(yPrime, P_MOD)
        }

        return PallasAffinePoint(xPrime, yPrime);
    }

    /// @return r the sum of two PallasAffinePoints
    function add(PallasAffinePoint memory p1, PallasAffinePoint memory p2)
        internal
        view
        returns (PallasAffinePoint memory)
    {
        if (isInfinity(p1)) {
            return p2;
        }

        if (isInfinity(p2)) {
            return p1;
        }

        uint256 lambda;
        uint256 tmp;
        uint256 x1 = p1.x;
        uint256 y1 = p1.y;
        uint256 x2 = p2.x;
        uint256 y2 = p2.y;
        uint256 x3;
        uint256 y3;

        // lambda = (y1-y2)/(x1-x2)
        assembly {
            lambda := add(x1, P_MOD)
            lambda := sub(lambda, x2)
            tmp := add(y1, P_MOD)
            tmp := sub(tmp, y2)
        }
        if (lambda > P_MOD) {
            lambda -= P_MOD;
        }
        lambda = invert(lambda, P_MOD);
        assembly {
            // lambda = (y1-y2)/(x1-x2)
            lambda := mulmod(lambda, tmp, P_MOD)

            // x3 = lambda^2 - x1 - x2
            x3 := mulmod(lambda, lambda, P_MOD)
            x3 := add(x3, P_MOD)
            x3 := add(x3, P_MOD)
            x3 := sub(x3, x1)
            x3 := sub(x3, x2)
            x3 := mod(x3, P_MOD)

            // y' = lambda * (x-x') - y
            y3 := add(x1, P_MOD)
            y3 := sub(y3, x3)
            y3 := mulmod(lambda, y3, P_MOD)
            y3 := add(y3, P_MOD)
            y3 := sub(y3, y1)
            y3 := mod(y3, P_MOD)
        }

        return PallasAffinePoint(x3, y3);
    }

    /// @return r the sum of two PallasProjectivePoints
    function add(PallasProjectivePoint memory p1, PallasProjectivePoint memory p2)
        internal
        pure
        returns (PallasProjectivePoint memory)
    {
        if (isInfinity(p1)) {
            return p2;
        }

        if (isInfinity(p2)) {
            return p1;
        }

        uint256 x3;
        uint256 y3;
        uint256 z3;

        // Z1Z1 = Z1^2
        uint256 z1z1 = mulmod(p1.z, p1.z, P_MOD);
        // Z2Z2 = Z2^2
        uint256 z2z2 = mulmod(p2.z, p2.z, P_MOD);
        // U1 = X1*Z2Z2
        uint256 u1 = mulmod(p1.x, z2z2, P_MOD);
        // U2 = X2*Z1Z1
        uint256 u2 = mulmod(p2.x, z1z1, P_MOD);
        // S1 = Y1*Z2*Z2Z2
        uint256 s1 = mulmod(p1.y, p2.z, P_MOD);
        s1 = mulmod(s1, z2z2, P_MOD);
        // S2 = Y2*Z1*Z1Z1
        uint256 s2 = mulmod(p2.y, p1.z, P_MOD);
        s2 = mulmod(s2, z1z1, P_MOD);

        if (u1 == u2) {
            if (s1 == s2) {
                return double(p1);
            }
        }

        // TODO! Below is the original assembly block from https://github.com/zhenfeizhang/pasta-solidity. It produces "Stack too deep" error.
        // TODO! The most trivial recommendation for such errors is reducing number of ingtermediate variables, so original assembly block is commented and
        // TODO! refactored one is used, with less variables introduced, which sacrifices code readability. It would be nice to revisit this weird fix.

        assembly {
            // H = U2-U1
            let h := add(u2, sub(P_MOD, u1))
            // I = (2*H)^2
            let i := addmod(h, h, P_MOD)
            i := mulmod(i, i, P_MOD)
            // J = H*I
            let j := mulmod(h, i, P_MOD)
            // r = 2*(S2-S1)
            let r := add(s2, sub(P_MOD, s1))
            r := addmod(r, r, P_MOD)
            // V = U1*I
            let v := mulmod(u1, i, P_MOD)

            // X3 = r^2 - J - 2*V
            x3 := mulmod(r, r, P_MOD)
            let tripleP := mul(P_MOD, 3)
            x3 := addmod(x3, sub(tripleP, add(j, add(v, v))), P_MOD)

            // Y3 = r*(V - X3) - 2*S1*J
            y3 := add(v, sub(P_MOD, x3))
            y3 := mulmod(r, y3, P_MOD)
            s1 := mul(s1, 2)
            s1 := mulmod(s1, j, P_MOD)
            y3 := addmod(y3, sub(P_MOD, s1), P_MOD)

            // Z3 = ((Z1+Z2)^2 - Z1Z1 - Z2Z2)*H
            z3 := add(mload(add(p1, 0x40)), mload(add(p2, 0x40)))
            z3 := mulmod(z3, z3, P_MOD)
            let doubleP := mul(P_MOD, 2)
            z3 := add(z3, sub(doubleP, add(z1z1, z2z2)))
            z3 := mulmod(z3, h, P_MOD)
        }

        // assembly {
        //     let i := addmod(add(u2, sub(P_MOD, u1)), add(u2, sub(P_MOD, u1)), P_MOD)
        //     i := mulmod(i, i, P_MOD)
        //     let r := add(s2, sub(P_MOD, s1))
        //     r := addmod(r, r, P_MOD)
        //     x3 := mulmod(r, r, P_MOD)
        //     x3 := addmod(x3, sub(mul(P_MOD, 3), add(mulmod(add(u2, sub(P_MOD, u1)), i, P_MOD), add(mulmod(u1, i, P_MOD), mulmod(u1, i, P_MOD)))), P_MOD)
        //     y3 := add(mulmod(u1, i, P_MOD), sub(P_MOD, x3))
        //     y3 := mulmod(r, y3, P_MOD)
        //     s1 := mul(s1, 2)
        //     s1 := mulmod(s1, mulmod(add(u2, sub(P_MOD, u1)), i, P_MOD), P_MOD)
        //     y3 := addmod(y3, sub(P_MOD, s1), P_MOD)
        //     z3 := add(mload(add(p1, 0x40)), mload(add(p2, 0x40)))
        //     z3 := mulmod(z3, z3, P_MOD)
        //     z3 := add(z3, sub(mul(P_MOD, 2), add(z1z1, z2z2)))
        //     z3 := mulmod(z3, add(u2, sub(P_MOD, u1)), P_MOD)
        // }

        return PallasProjectivePoint(x3, y3, z3);
    }

    /// @return r the product of a PallasAffinePoint on Pallas and a scalar, i.e.
    /// p == p.mul(1) and p.add(p) == p.mul(2) for all PallasAffinePoints p.
    function scalarMul(PallasAffinePoint memory p, uint256 s) internal view returns (PallasAffinePoint memory r) {
        uint256 bit;
        uint256 i = 0;
        PallasAffinePoint memory tmp = p;
        r = PallasAffinePoint(0, 0);

        for (i = 0; i < 256; i++) {
            bit = s & 1;
            s /= 2;
            if (bit == 1) {
                r = add(r, tmp);
            }
            tmp = double(tmp);
        }
    }

    /// @return r the product of a PallasProjectivePoint and a scalar, i.e.
    /// p == p.mul(1) and p.add(p) == p.mul(2) for all PallasProjectivePoint p.
    function scalarMul(PallasProjectivePoint memory p, uint256 s)
        internal
        pure
        returns (PallasProjectivePoint memory r)
    {
        uint256 bit;
        uint256 i = 0;
        PallasProjectivePoint memory tmp = p;
        r = PallasProjectivePoint(0, 0, 0);

        for (i = 0; i < 256; i++) {
            bit = s & 1;
            s /= 2;
            if (bit == 1) {
                r = add(r, tmp);
            }
            tmp = double(tmp);
        }
    }

    /// @dev Multi-scalar Mulitiplication (MSM)
    /// @return r = \Prod{B_i^s_i} where {s_i} are `scalars` and {B_i} are `bases`
    function multiScalarMul(PallasAffinePoint[] memory bases, uint256[] memory scalars)
        internal
        view
        returns (PallasAffinePoint memory r)
    {
        require(scalars.length == bases.length, "MSM error: length does not match");

        r = scalarMul(bases[0], scalars[0]);
        for (uint256 i = 1; i < scalars.length; i++) {
            r = add(r, scalarMul(bases[i], scalars[i]));
        }
    }

    /// @dev Compute f^-1 for f \in Fr scalar field
    /// @notice credit: Aztec, Spilsbury Holdings Ltd
    function invert(uint256 fr, uint256 modulus) internal view returns (uint256 output) {
        bool success;
        assembly {
            let mPtr := mload(0x40)
            mstore(mPtr, 0x20)
            mstore(add(mPtr, 0x20), 0x20)
            mstore(add(mPtr, 0x40), 0x20)
            mstore(add(mPtr, 0x60), fr)
            mstore(add(mPtr, 0x80), sub(modulus, 2))
            mstore(add(mPtr, 0xa0), modulus)
            success := staticcall(gas(), 0x05, mPtr, 0xc0, 0x00, 0x20)
            output := mload(0x00)
        }
        require(success, "Pallas: pow precompile failed!");
    }

    /**
     * validate the following:
     *   x != 0
     *   y != 0
     *   x < p
     *   y < p
     *   y^2 = x^3 + 5 mod p
     */
    /// @dev validate PallasAffinePoint and check if it is on curve
    /// @notice credit: Aztec, Spilsbury Holdings Ltd
    function validateCurvePoint(PallasAffinePoint memory point) internal pure {
        bool isWellFormed;
        uint256 p = P_MOD;
        assembly {
            let x := mload(point)
            let y := mload(add(point, 0x20))

            isWellFormed :=
                and(
                    and(and(lt(x, p), lt(y, p)), not(or(iszero(x), iszero(y)))),
                    eq(mulmod(y, y, p), addmod(mulmod(x, mulmod(x, x, p), p), 5, p))
                )
        }
        require(isWellFormed, "Pallas: invalid point");
    }

    /// @dev Validate scalar field, revert if invalid (namely if fr > r_mod).
    /// @notice Writing this inline instead of calling it might save gas.
    function validateScalarField(uint256 fr) internal pure {
        bool isValid;
        assembly {
            isValid := lt(fr, R_MOD)
        }
        require(isValid, "Pallas: invalid scalar field");
    }

    function fromLeBytesModOrder(bytes memory leBytes) internal pure returns (uint256 ret) {
        // TODO: Can likely be gas optimized by copying the first 31 bytes directly.
        for (uint256 i = 0; i < leBytes.length; i++) {
            ret = mulmod(ret, 256, R_MOD);
            ret = addmod(ret, uint256(uint8(leBytes[leBytes.length - 1 - i])), R_MOD);
        }
    }

    /// @dev Check if y-coordinate of PallasAffinePoint is negative.
    function isYNegative(PallasAffinePoint memory point) internal pure returns (bool) {
        return point.y < P_MOD / 2;
    }

    // @dev Perform a modular exponentiation.
    // @return base^exponent (mod modulus)
    // This method is ideal for small exponents (~64 bits or less), as it is cheaper than using the pow precompile
    // @notice credit: credit: Aztec, Spilsbury Holdings Ltd
    function powSmall(uint256 base, uint256 exponent, uint256 modulus) internal pure returns (uint256) {
        uint256 result = 1;
        uint256 input = base;
        uint256 count = 1;

        assembly {
            let endpoint := add(exponent, 0x01)
            for {} lt(count, endpoint) { count := add(count, count) } {
                if and(exponent, count) { result := mulmod(result, input, modulus) }
                input := mulmod(input, input, modulus)
            }
        }

        return result;
    }

    function unCompress(uint256 compressed_x_coord) public view returns (PallasProjectivePoint memory point) {
        bool y_sign = (compressed_x_coord >> 255) == 1;
        uint256 x_coord = compressed_x_coord & 0x7fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff;

        if ((x_coord == 0) && y_sign) {
            return ProjectiveInfinity();
        }

        uint256 y_coord;
        uint256 _mod = P_MOD;

        assembly{
            y_coord := mulmod(x_coord, x_coord, _mod)
            y_coord := mulmod(y_coord, x_coord, _mod)
            y_coord := addmod(y_coord, 5, _mod)
        }

        y_coord = Field.sqrt(y_coord, _mod);

        point = PallasProjectivePoint(x_coord, y_coord, 1);

        bool y_coord_sign = (y_coord >> 254) & 0xff == 1;

        if ((y_sign || y_coord_sign) && !(y_sign && y_coord_sign)) {
            negate(point);
        }
    }
}
