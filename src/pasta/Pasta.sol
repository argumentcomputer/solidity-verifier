// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PastaCurve {
    uint256 immutable P_MOD;
    uint256 immutable R_MOD;
    uint256 immutable _THREE_OVER_TWO;

    constructor(uint256 P, uint256 R) {
      P_MOD = P;
      R_MOD = R;
      uint256 inv2 = invert(2, P);
      _THREE_OVER_TWO = mulmod(3, inv2, P);
    }

    struct AffinePoint {
        uint256 x;
        uint256 y;
    }

    struct ProjectivePoint {
        uint256 x;
        uint256 y;
        uint256 z;
    }

    /// @return the generator
    // solhint-disable-next-line func-name-mixedcase
    function AffineGenerator() public view returns (AffinePoint memory) {
        return AffinePoint(P_MOD - 1, 2);
    }

    /// @return the generator
    // solhint-disable-next-line func-name-mixedcase
    function ProjectiveGenerator() public view returns (ProjectivePoint memory) {
        return ProjectivePoint(P_MOD - 1, 2, 1);
    }

    /// @return the convert an affine point into projective
    // solhint-disable-next-line func-name-mixedcase
    function IntoProjective(AffinePoint memory point)
    public
    pure
    returns (ProjectivePoint memory)
    {
        if (isInfinity(point)) {
            return ProjectivePoint(0, 0, 0);
        }

        return ProjectivePoint(point.x, point.y, 1);
    }

    /// @return the convert a projective point into affine
    // solhint-disable-next-line func-name-mixedcase
    function IntoAffine(ProjectivePoint memory point)
    public
    view
    returns (AffinePoint memory)
    {
        if (isInfinity(point)) {
            return AffinePoint(0, 0);
        }

        uint256 zinv = invert(point.z, P_MOD);
        uint256 zinv2 = mulmod(zinv, zinv, P_MOD);
        uint256 x = mulmod(point.x, zinv2, P_MOD);
        zinv2 = mulmod(zinv, zinv2, P_MOD);
        uint256 y = mulmod(point.y, zinv2, P_MOD);

        return AffinePoint(x, y);
    }

    /// @dev check if a AffinePoint is Infinity
    /// @notice (0, 0) AffinePoint of Infinity,
    /// some crypto libraries (such as arkwork) uses a boolean flag to mark PoI, and
    /// just use (0, 1) as affine coordinates (not on curve) to represents PoI.
    function isInfinity(AffinePoint memory point) public pure returns (bool result) {
        assembly {
            let x := mload(point)
            let y := mload(add(point, 0x20))
            result := and(iszero(x), iszero(y))
        }
    }

    /// @dev check if a ProjectivePoint is Infinity
    /// @notice (0, 0, 0) ProjectivePoint of Infinity,
    /// some crypto libraries (such as arkwork) uses a boolean flag to mark PoI, and
    /// just use (0, 1, 0) as affine coordinates (not on curve) to represents PoI.
    function isInfinity(ProjectivePoint memory point) public pure returns (bool result) {
        assembly {
            let x := mload(point)
            let y := mload(add(point, 0x20))
            let z := mload(add(point, 0x20))
            result := and(and(iszero(x), iszero(y)), iszero(z))
        }
    }

    /// @return r the negation of p, i.e. p.add(p.negate()) should be zero.
    function negate(AffinePoint memory p) public view returns (AffinePoint memory) {
        if (isInfinity(p)) {
            return p;
        }
        return AffinePoint(p.x, P_MOD - (p.y % P_MOD));
    }

    /// @return r the negation of p, i.e. p.add(p.negate()) should be zero.
    function negate(ProjectivePoint memory p)
    public
    view
    returns (ProjectivePoint memory)
    {
        if (isInfinity(p)) {
            return p;
        }
        return ProjectivePoint(p.x, P_MOD - (p.y % P_MOD), p.z);
    }

    /// @return res = -fr the negation of scalar field element.
    function negate(uint256 fr) public view returns (uint256 res) {
        return R_MOD - (fr % R_MOD);
    }

    /// @return 2*point
    function double(ProjectivePoint memory point)
    public
    view
    returns (ProjectivePoint memory)
    {
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
        uint256 P = P_MOD;

        assembly {
        // A = X1^2
            a := mulmod(x, x, P)
        // B = Y1^2
            b := mulmod(y, y, P)
        // C = B^2
            c := mulmod(b, b, P)
        // D = 2*((X1+B)^2-A-C)
            d := add(x, b)
            d := mulmod(d, d, P)
            b := add(a, c)
            d := add(d, sub(doubleP, b))
            d := mulmod(d, 2, P)
        // E = 3*A
            e := mul(a, 3)
        // F = E^2
            f := mulmod(e, e, P)
        // Z3 = 2*Y1*Z1
            z := mulmod(mul(y, 2), z, P)
        // X3 = F-2*D
            x := addmod(f, sub(doubleP, mul(d, 2)), P)
        // Y3 = E*(D-X3)-8*C
            y := add(d, sub(P, x))
            y := mulmod(e, y, P)
            y := addmod(y, sub(P, mulmod(c, 8, P)), P)
        }

        return ProjectivePoint(x, y, z);
    }

    /// @return 2*point
    function double(AffinePoint memory point)
    public
    view
    returns (AffinePoint memory)
    {
        if (isInfinity(point)) {
            return point;
        }

        uint256 lambda;
        uint256 x = point.x;
        uint256 y = point.y;
        uint256 yInv = invert(point.y, P_MOD);
        uint256 xPrime;
        uint256 yPrime;
        uint256 P = P_MOD;
        uint256 TO2 = _THREE_OVER_TWO;

        assembly {
        // lambda = 3x^2/2y
            lambda := mulmod(x, x, P)
            lambda := mulmod(lambda, yInv, P)
            lambda := mulmod(lambda, TO2, P)

        // x' = lambda^2 - 2x
            xPrime := mulmod(lambda, lambda, P)
            xPrime := add(xPrime, P)
            xPrime := add(xPrime, P)
            xPrime := sub(xPrime, x)
            xPrime := sub(xPrime, x)
            xPrime := mod(xPrime, P)

        // y' = lambda * (x-x') - y
            yPrime := add(x, P)
            yPrime := sub(yPrime, xPrime)
            yPrime := mulmod(lambda, yPrime, P)
            yPrime := add(yPrime, P)
            yPrime := sub(yPrime, y)
            yPrime := mod(yPrime, P)
        }

        return AffinePoint(xPrime, yPrime);
    }

    /// @return r the sum of two AffinePoints
    function add(AffinePoint memory p1, AffinePoint memory p2)
    public
    view
    returns (AffinePoint memory)
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
        uint256 P = P_MOD;

        // lambda = (y1-y2)/(x1-x2)
        assembly {
            lambda := add(x1, P)
            lambda := sub(lambda, x2)
            tmp := add(y1, P)
            tmp := sub(tmp, y2)
        }
        if (lambda > P) {
            lambda -= P;
        }
        lambda = invert(lambda, P);
        assembly {
        // lambda = (y1-y2)/(x1-x2)
            lambda := mulmod(lambda, tmp, P)

        // x3 = lambda^2 - x1 - x2
            x3 := mulmod(lambda, lambda, P)
            x3 := add(x3, P)
            x3 := add(x3, P)
            x3 := sub(x3, x1)
            x3 := sub(x3, x2)
            x3 := mod(x3, P)

        // y' = lambda * (x-x') - y
            y3 := add(x1, P)
            y3 := sub(y3, x3)
            y3 := mulmod(lambda, y3, P)
            y3 := add(y3, P)
            y3 := sub(y3, y1)
            y3 := mod(y3, P)
        }

        return AffinePoint(x3, y3);
    }

    /// @return r the sum of two AffinePoints
    function add(ProjectivePoint memory p1, ProjectivePoint memory p2)
    public
    view
    returns (ProjectivePoint memory)
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

        uint256 P = P_MOD;

        if (u1 == u2) {
            if (s1 == s2) {
                return double(p1);
            }
        }

        // TODO! Below is the original assembly block from https://github.com/zhenfeizhang/pasta-solidity. It produces "Stack too deep" error.
        // TODO! The most trivial recommendation for such errors is reducing number of ingtermediate variables, so original assembly block is commented and
        // TODO! refactored one is used, with less variables introduced, which sacrifices code readability. It would be nice to revisit this weird fix.

        // assembly {
        // // H = U2-U1
        //     let h := add(u2, sub(P, u1))
        // // I = (2*H)^2
        //     let i := addmod(h, h, P)
        //     i := mulmod(i, i, P)
        // // J = H*I
        //     let j := mulmod(h, i, P)
        // // r = 2*(S2-S1)
        //     let r := add(s2, sub(P, s1))
        //     r := addmod(r, r, P)
        // // V = U1*I
        //     let v := mulmod(u1, i, P)

        // // X3 = r^2 - J - 2*V
        //     x3 := mulmod(r, r, P)
        //     let tripleP := mul(P, 3)
        //     x3 := addmod(x3, sub(tripleP, add(j, add(v, v))), P)

        // // Y3 = r*(V - X3) - 2*S1*J
        //     y3 := add(v, sub(P, x3))
        //     y3 := mulmod(r, y3, P)
        //     s1 := mul(s1, 2)
        //     s1 := mulmod(s1, j, P)
        //     y3 := addmod(y3, sub(P, s1), P)

        // // Z3 = ((Z1+Z2)^2 - Z1Z1 - Z2Z2)*H
        //     z3 := add(mload(add(p1, 0x40)), mload(add(p2, 0x40)))
        //     z3 := mulmod(z3, z3, P)
        //     let doubleP := mul(P, 2)
        //     z3 := add(z3, sub(doubleP, add(z1z1, z2z2)))
        //     z3 := mulmod(z3, h, P)
        // }

        assembly {
            let i := addmod(add(u2, sub(P, u1)), add(u2, sub(P, u1)), P)
            i := mulmod(i, i, P)
            let r := add(s2, sub(P, s1))
            r := addmod(r, r, P)
            x3 := mulmod(r, r, P)
            x3 := addmod(x3, sub(mul(P, 3), add(mulmod(add(u2, sub(P, u1)), i, P), add(mulmod(u1, i, P), mulmod(u1, i, P)))), P)
            y3 := add(mulmod(u1, i, P), sub(P, x3))
            y3 := mulmod(r, y3, P)
            s1 := mul(s1, 2)
            s1 := mulmod(s1, mulmod(add(u2, sub(P, u1)), i, P), P)
            y3 := addmod(y3, sub(P, s1), P)
            z3 := add(mload(add(p1, 0x40)), mload(add(p2, 0x40)))
            z3 := mulmod(z3, z3, P)
            z3 := add(z3, sub(mul(P, 2), add(z1z1, z2z2)))
            z3 := mulmod(z3, add(u2, sub(P, u1)), P)
        }

        return ProjectivePoint(x3, y3, z3);
    }

    /// @return r the product of a AffinePoint and a scalar, i.e.
    /// p == p.mul(1) and p.add(p) == p.mul(2) for all AffinePoints p.
    function scalarMul(AffinePoint memory p, uint256 s)
    public
    view
    returns (AffinePoint memory r)
    {
        uint256 bit;
        uint256 i = 0;
        AffinePoint memory tmp = p;
        r = AffinePoint(0, 0);

        for (i = 0; i < 256; i++) {
            bit = s & 1;
            s /= 2;
            if (bit == 1) {
                r = add(r, tmp);
            }
            tmp = double(tmp);
        }
    }

    /// @return r the product of a ProjectivePoint and a scalar, i.e.
    /// p == p.mul(1) and p.add(p) == p.mul(2) for all ProjectivePoint p.
    function scalarMul(ProjectivePoint memory p, uint256 s)
    public
    view
    returns (ProjectivePoint memory r)
    {
        uint256 bit;
        uint256 i = 0;
        ProjectivePoint memory tmp = p;
        r = ProjectivePoint(0, 0, 0);

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
    function multiScalarMul(AffinePoint[] memory bases, uint256[] memory scalars)
    public
    view
    returns (AffinePoint memory r)
    {
        require(scalars.length == bases.length, "MSM error: length does not match");

        r = scalarMul(bases[0], scalars[0]);
        for (uint256 i = 1; i < scalars.length; i++) {
            r = add(r, scalarMul(bases[i], scalars[i]));
        }
    }

    /// @dev Compute f^-1 for f \in Fr scalar field
    /// @notice credit: Aztec, Spilsbury Holdings Ltd
    function invert(uint256 fr, uint256 modulus) public view returns (uint256 output) {
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
        require(success, ": pow precompile failed!");
    }

    /**
     * validate the following:
     *   x != 0
     *   y != 0
     *   x < p
     *   y < p
     *   y^2 = x^3 + 5 mod p
     */
    /// @dev validate AffinePoint and check if it is on curve
    /// @notice credit: Aztec, Spilsbury Holdings Ltd
    function validateCurvePoint(AffinePoint memory point) public view {
        bool isWellFormed;
        uint256 p = P_MOD;
        assembly {
            let x := mload(point)
            let y := mload(add(point, 0x20))

            isWellFormed := and(
            and(and(lt(x, p), lt(y, p)), not(or(iszero(x), iszero(y)))),
            eq(mulmod(y, y, p), addmod(mulmod(x, mulmod(x, x, p), p), 5, p))
            )
        }
        require(isWellFormed, ": invalid point");
    }

    /// @dev Validate scalar field, revert if invalid (namely if fr > r_mod).
    /// @notice Writing this inline instead of calling it might save gas.
    function validateScalarField(uint256 fr) public view {
        bool isValid;
        uint256 R = R_MOD;
        assembly {
            isValid := lt(fr, R)
        }
        require(isValid, ": invalid scalar field");
    }

    function fromLeBytesModOrder(bytes memory leBytes) public view returns (uint256 ret) {
        // TODO: Can likely be gas optimized by copying the first 31 bytes directly.
        for (uint256 i = 0; i < leBytes.length; i++) {
            ret = mulmod(ret, 256, R_MOD);
            ret = addmod(ret, uint256(uint8(leBytes[leBytes.length - 1 - i])), R_MOD);
        }
    }

    /// @dev Check if y-coordinate of AffinePoint is negative.
    function isYNegative(AffinePoint memory point) public view returns (bool) {
        return point.y < P_MOD / 2;
    }

    // @dev Perform a modular exponentiation.
    // @return base^exponent (mod modulus)
    // This method is ideal for small exponents (~64 bits or less), as it is cheaper than using the pow precompile
    // @notice credit: credit: Aztec, Spilsbury Holdings Ltd
    function powSmall(
        uint256 base,
        uint256 exponent,
        uint256 modulus
    ) public pure returns (uint256) {
        uint256 result = 1;
        uint256 input = base;
        uint256 count = 1;

        assembly {
            let endPoint := add(exponent, 0x01)
            for {

            } lt(count, endPoint) {
                count := add(count, count)
            } {
                if and(exponent, count) {
                    result := mulmod(result, input, modulus)
                }
                input := mulmod(input, input, modulus)
            }
        }

        return result;
    }
}
