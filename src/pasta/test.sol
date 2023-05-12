// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Pasta.sol";
import "./Pallas.sol";

contract TestCurveContract {

  Pallas curve = new Pallas();

  function test() external view returns (PastaCurve.ProjectivePoint memory) {
    Pallas.ProjectivePoint memory G = curve.ProjectiveGenerator();
    Pallas.ProjectivePoint memory G2 = curve.double(G);
    G2 = curve.double(G2);

    curve.double(G2);
    return G2;
  }
}
