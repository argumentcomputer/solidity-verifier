// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.16;

import "@std/Test.sol";
import "src/Utilities.sol";

library Bn256 {
    // The prime modulus of the finite field over which the Bn256 curve is defined.
    uint256 public constant P_MOD = 0x30644e72e131a029b85045b68181585d97816a916871ca8d3c208c16d87cfd47;
    // The order of the base point of the Bn256 elliptic curve.
    uint256 public constant R_MOD = 0x30644e72e131a029b85045b68181585d2833e84879b9709143e1f593f0000001;
    // Coefficient in the Bn256 equation: y^2 = x^3 + B
    uint256 public constant B = 3;

    struct Bn256AffinePoint {
        uint256 x;
        uint256 y;
    }

    /**
     * @dev Performs elliptic curve addition according to the Bn256 curve rules.
     * @param p1 First affine point for addition. It must be a valid point on the Bn256 curve.
     * @param p2 Second affine point for addition. It must also be   a valid point on the Bn256 curve.
     * @return Returns the result of adding two Bn256 affine points, which is also a point on the curve.
     */
    function add(Bn256AffinePoint memory p1, Bn256AffinePoint memory p2) public returns (Bn256AffinePoint memory) {
        bytes32[2] memory addResult;

        bytes32[4] memory input;
        input[0] = bytes32(p1.x);
        input[1] = bytes32(p1.y);
        input[2] = bytes32(p2.x);
        input[3] = bytes32(p2.y);

        // Assembly code to call the pre-compiled Bn256 points addition contract for Bn256 curve operations, with error management.
        assembly {
            let success := call(gas(), 0x06, 0, input, 0x80, addResult, 0x40)
            switch success
            case 0 { revert(0, 0) }
        }

        return Bn256AffinePoint(uint256(addResult[0]), uint256(addResult[1]));
    }

    /**
     * @dev Performs scalar multiplication on the Bn256 curve.
     * @param p The point on the Bn256 curve to be multiplied.
     * @param s The scalar by which to multiply the point.
     * @return The result of scalar multiplication, which is another point on the curve.
     */
    function scalarMul(Bn256AffinePoint memory a, uint256 scalar) public returns (Bn256AffinePoint memory) {
        bytes32[3] memory input;
        input[0] = bytes32(a.x);
        input[1] = bytes32(a.y);
        input[2] = bytes32(scalar);

        bytes32[2] memory mulResult;

    // Assembly code to call the pre-compiled Bn256 scalar multiplication contract for Bn256 curve operations, with
    // error management.
    assembly {
            let success := call(gas(), 0x07, 0, input, 0x60, mulResult, 0x40)
            switch success
            case 0 { revert(0, 0) }
        }
        return Bn256AffinePoint(uint256(mulResult[0]), uint256(mulResult[1]));
    }

    /**
     * @dev Performs multiple scalar multiplications on the Bn256 curve. Useful for batch processing, allowing multiple
     *      scalar multiplications to be performed in a single call.
     * @param points An array of points on the Bn256 curve to be multiplied.
     * @param scalars An array of scalars by which to multiply the corresponding points.
     * @return An array of points, each being the result of the scalar multiplication of the corresponding point and scalar.
     */
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

    /**
     * @dev Negates a point on the Bn256 curve. This operation inverts the point over the x-axis on the elliptic curve.
     * @param point The point on the Bn256 curve to be negated.
     * @return The negated point, also on the Bn256 curve.
     */
    function negate(Bn256AffinePoint memory a) public pure returns (Bn256AffinePoint memory) {
        return Bn256AffinePoint(a.x, P_MOD - (a.y % P_MOD));
    }

    /**
     * @dev Negates the base point of the Bn256 curve. This is a specialized case of point negation for the curve's base point.
     * @return The negated base point on the Bn256 curve.
     */
    function negateBase(uint256 scalar) internal pure returns (uint256) {
        return P_MOD - (scalar % P_MOD);
    }

    /**
     * @dev Negates a scalar value. This operation performs modular arithmetic negation of a scalar.
     * @param scalar The scalar value to be negated.
     * @return The negated scalar value.
     */
    function negateScalar(uint256 scalar) internal pure returns (uint256) {
        return R_MOD - (scalar % R_MOD);
    }

    /**
     * @dev Checks if a given point is the identity element (also known as the point at infinity) on the Bn256 curve.
     *      The identity element also serves the group's neutral element.
     * @param point The point on the Bn256 curve to be checked.
     * @return True if the point is the identity element, False otherwise.
     */
    function is_identity(Bn256AffinePoint memory p1) public pure returns (bool) {
        if (p1.x != 0) {
            return false;
        }
        if (p1.y != 0) {
            return false;
        }
        return true;
    }

    /**
     * @dev This function takes a Bn256 compressed point and returns its uncompressed form.
     * @param input The compressed point on the Bn256 curve.
     * @return The decompressed point, including both x and y coordinates.
     */
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
