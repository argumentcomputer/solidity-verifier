//SPDX-License-Identifier: MIT OR Apache-2.0
pragma solidity ^0.8.0;

import {Pallas as P} from "src/pasta/PallasLib.sol";
import {Vesta as C} from "src/pasta/VestaLib.sol";

contract PallasContract {
    constructor() {}

    // solhint-disable-next-line func-name-mixedcase
    function affineGenerator() public pure returns (P.PallasAffinePoint memory) {
        return P.AffineGenerator();
    }

    // solhint-disable-next-line func-name-mixedcase
    function projectiveGenerator() public pure returns (P.PallasProjectivePoint memory) {
        return P.ProjectiveGenerator();
    }

    // solhint-disable-next-line func-name-mixedcase
    function toAffine(P.PallasProjectivePoint memory point)
    public
    view
    returns (P.PallasAffinePoint memory)
    {
        return P.IntoAffine(point);
    }

    // solhint-disable-next-line func-name-mixedcase
    function toProjective(P.PallasAffinePoint memory point)
    public
    pure
    returns (P.PallasProjectivePoint memory)
    {
        return P.IntoProjective(point);
    }

    function isProjectiveInfinity(P.PallasProjectivePoint memory point)
    public
    pure
    returns (bool)
    {
        return P.isInfinity(point);
    }

    function isAffineInfinity(P.PallasAffinePoint memory point) public pure returns (bool) {
        return P.isInfinity(point);
    }

    function affineNegate(P.PallasAffinePoint memory p)
    public
    pure
    returns (P.PallasAffinePoint memory r)
    {
        return P.negate(p);
    }

    function projectiveNegate(P.PallasProjectivePoint memory p)
    public
    pure
    returns (P.PallasProjectivePoint memory r)
    {
        return P.negate(p);
    }

    function affineDouble(P.PallasAffinePoint memory p)
    public
    view
    returns (P.PallasAffinePoint memory)
    {
        return P.double(p);
    }

    function projectiveDouble(P.PallasProjectivePoint memory p)
    public
    pure
    returns (P.PallasProjectivePoint memory)
    {
        return P.double(p);
    }

    function affineAdd(P.PallasAffinePoint memory p1, P.PallasAffinePoint memory p2)
    public
    view
    returns (P.PallasAffinePoint memory)
    {
        return P.add(p1, p2);
    }

    function projectiveAdd(P.PallasProjectivePoint memory p1, P.PallasProjectivePoint memory p2)
    public
    pure
    returns (P.PallasProjectivePoint memory)
    {
        return P.add(p1, p2);
    }

    function affineScalarMul(P.PallasAffinePoint memory p, uint256 s)
    public
    view
    returns (P.PallasAffinePoint memory r)
    {
        return P.scalarMul(p, s);
    }

    function projectiveScalarMul(P.PallasProjectivePoint memory p, uint256 s)
    public
    pure
    returns (P.PallasProjectivePoint memory r)
    {
        return P.scalarMul(p, s);
    }

    function invertFr(uint256 fr) public view returns (uint256 output) {
        return P.invert(fr, P.R_MOD);
    }

    function invertFq(uint256 fq) public view returns (uint256 output) {
        return P.invert(fq, P.P_MOD);
    }

    function validateCurvePoint(P.PallasAffinePoint memory point) public pure {
        P.validateCurvePoint(point);
    }

    function validateScalarField(uint256 fr) public pure {
        P.validateScalarField(fr);
    }

    function fromLeBytesModOrder(bytes memory leBytes) public pure returns (uint256) {
        return P.fromLeBytesModOrder(leBytes);
    }

    function isYNegative(P.PallasAffinePoint memory p) public pure returns (bool) {
        return P.isYNegative(p);
    }

    function powSmall(
        uint256 base,
        uint256 exponent,
        uint256 modulus
    ) public pure returns (uint256) {
        return P.powSmall(base, exponent, modulus);
    }

    function testMultiScalarMul(P.PallasAffinePoint[] memory bases, uint256[] memory scalars)
    public
    view
    returns (P.PallasAffinePoint memory)
    {
        return P.multiScalarMul(bases, scalars);
    }
}

contract VestaContract {
    constructor() {}

    // solhint-disable-next-line func-name-mixedcase
    function affineGenerator() public pure returns (C.VestaAffinePoint memory) {
        return C.AffineGenerator();
    }

    // solhint-disable-next-line func-name-mixedcase
    function projectiveGenerator() public pure returns (C.VestaProjectivePoint memory) {
        return C.ProjectiveGenerator();
    }

    // solhint-disable-next-line func-name-mixedcase
    function toAffine(C.VestaProjectivePoint memory point)
    public
    view
    returns (C.VestaAffinePoint memory)
    {
        return C.IntoAffine(point);
    }

    // solhint-disable-next-line func-name-mixedcase
    function toProjective(C.VestaAffinePoint memory point)
    public
    pure
    returns (C.VestaProjectivePoint memory)
    {
        return C.IntoProjective(point);
    }

    function isProjectiveInfinity(C.VestaProjectivePoint memory point) public pure returns (bool) {
        return C.isInfinity(point);
    }

    function isAffineInfinity(C.VestaAffinePoint memory point) public pure returns (bool) {
        return C.isInfinity(point);
    }

    function affineNegate(C.VestaAffinePoint memory p)
    public
    pure
    returns (C.VestaAffinePoint memory r)
    {
        return C.negate(p);
    }

    function projectiveNegate(C.VestaProjectivePoint memory p)
    public
    pure
    returns (C.VestaProjectivePoint memory r)
    {
        return C.negate(p);
    }

    function affineDouble(C.VestaAffinePoint memory p)
    public
    view
    returns (C.VestaAffinePoint memory)
    {
        return C.double(p);
    }

    function projectiveDouble(C.VestaProjectivePoint memory p)
    public
    pure
    returns (C.VestaProjectivePoint memory)
    {
        return C.double(p);
    }

    function affineAdd(C.VestaAffinePoint memory p1, C.VestaAffinePoint memory p2)
    public
    view
    returns (C.VestaAffinePoint memory)
    {
        return C.add(p1, p2);
    }

    function projectiveAdd(C.VestaProjectivePoint memory p1, C.VestaProjectivePoint memory p2)
    public
    pure
    returns (C.VestaProjectivePoint memory)
    {
        return C.add(p1, p2);
    }

    function affineScalarMul(C.VestaAffinePoint memory p, uint256 s)
    public
    view
    returns (C.VestaAffinePoint memory r)
    {
        return C.scalarMul(p, s);
    }

    function projectiveScalarMul(C.VestaProjectivePoint memory p, uint256 s)
    public
    pure
    returns (C.VestaProjectivePoint memory r)
    {
        return C.scalarMul(p, s);
    }

    function invertFr(uint256 fr) public view returns (uint256 output) {
        return C.invert(fr, C.R_MOD);
    }

    function invertFq(uint256 fq) public view returns (uint256 output) {
        return C.invert(fq, C.P_MOD);
    }

    function validateCurvePoint(C.VestaAffinePoint memory point) public pure {
        C.validateCurvePoint(point);
    }

    function validateScalarField(uint256 fr) public pure {
        C.validateScalarField(fr);
    }

    function fromLeBytesModOrder(bytes memory leBytes) public pure returns (uint256) {
        return C.fromLeBytesModOrder(leBytes);
    }

    function isYNegative(C.VestaAffinePoint memory p) public pure returns (bool) {
        return C.isYNegative(p);
    }

    function powSmall(
        uint256 base,
        uint256 exponent,
        uint256 modulus
    ) public pure returns (uint256) {
        return C.powSmall(base, exponent, modulus);
    }

    function testMultiScalarMul(C.VestaAffinePoint[] memory bases, uint256[] memory scalars)
    public
    view
    returns (C.VestaAffinePoint memory)
    {
        return C.multiScalarMul(bases, scalars);
    }
}

