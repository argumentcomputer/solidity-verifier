// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.0;

import "src/verifier/step4/KeccakTranscript.sol";
import "src/verifier/step4/EqPolynomial.sol";

library PolyLib {
    struct MLPoly {
        uint64 numvars;
        uint256[] Z;
    }

    struct SparseEntry{
        uint256 idx;
        uint256 entry;
    }

    struct SparsePoly{
        uint64 numvars;
        SparseEntry[] Z;
    }
    
    function newML(uint256[] memory Z, uint64 numvars) public pure returns (MLPoly memory){
        require(Z.length == 2 ^ numvars);
        return MLPoly(numvars, Z);
    }

    function boundPolyVarTop(MLPoly calldata P, uint256 r) public pure returns(MLPoly memory) {
        uint256 mid = P.Z.length / 2;

        uint256[] memory new_Z;

        for (uint256 i = 0; i < mid; i++) {
            uint256 a = P.Z[i];
            uint256 b = P.Z[mid + i];
            new_Z[i] = a + r * (b - a); // TODO: Fix this arithmetic to a particular field
        }
        
        return MLPoly(P.numvars - 1, new_Z);
    }

    function evaluate(MLPoly calldata P, uint256[] calldata r) public pure returns (uint256 result) {
        require(P.Z.length == r.length);

        uint256[] memory chis = EqPolinomialLib.evalsPallas(r);

        for (uint256 i  = 0; i < r.length; i++) {
            result += chis[i] * P.Z[i]; // TODO: Fix this arithmetic to Pallas
        }
    }

    function computeChi(bool[] memory a, uint256[] calldata r) public pure returns (uint256) {
        require(a.length == r.length);

        uint256 result;

        for (uint256 j = 0; j < r.length; j++) {
            if (a[j]) {
                result *= r[j];
            }
            else {
                result *= (1 - r[j]); // TODO: Fix this arithmetic
            }
        }

        return result;
    }

    function getBits(uint256 num, uint256 numbits) internal pure returns (bool[] memory) {
        bool[] memory result;

        for (uint256 shift_amount = 0; shift_amount < numbits; shift_amount++) {
            result[shift_amount] = (num & (1 << (numbits - shift_amount -1)) > 0);
        }

        return result;
    }

    function evaluate(SparsePoly calldata P, uint256[] calldata r) public pure returns (uint256) {
        require(P.numvars == r.length);

        uint256 result;

        for (uint256 i = 0; i < r.length; i++) {
            bool[] memory bits = getBits(P.Z[i].entry, r.length);
            result += computeChi(bits, r) * P.Z[i].idx; // TODO: Fix this arithmetic
        }

        return result;
    }
}

library Sumcheck {
    struct CompressedUniPoly {
        uint256[] coeffs_except_linear_term;
    }

    struct UniPoly {
        uint256[] coeffs;
    }

    struct SumcheckProof {
        CompressedUniPoly[] compressed_polys;
    }

    function decompress(
        CompressedUniPoly calldata poly,
        uint256 hint
    ) public pure returns (UniPoly memory) {
        uint256 linear_term = hint - poly.coeffs_except_linear_term[0] - poly.coeffs_except_linear_term[0];
        for (uint256 i = 1; i < poly.coeffs_except_linear_term.length; i++) {
            linear_term -= poly.coeffs_except_linear_term[i];
        }

        uint256[] memory coeffs;
        coeffs[0] = poly.coeffs_except_linear_term[0];
        coeffs[1] = linear_term;

        for (uint256 i = 1; i < poly.coeffs_except_linear_term.length; i++) {
            coeffs[i + 1]  = poly.coeffs_except_linear_term[i];
        }

        require(poly.coeffs_except_linear_term.length + 1 == coeffs.length);

        return UniPoly(coeffs);
    }

    function verify(
        SumcheckProof calldata proof,
        uint256 claim,
        uint256 num_rounds,
        uint256 degree_bound,
        KeccakTranscriptLib.KeccakTranscript memory transcript
    ) public pure returns (uint256, uint256[] memory) {
        require(proof.compressed_polys.length == num_rounds, "Wrong number of polynomials");


    }
}
