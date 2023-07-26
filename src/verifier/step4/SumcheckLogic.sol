// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.0;

import "src/pasta/Pallas.sol";
import "src/pasta/Vesta.sol";
import "src/verifier/step4/KeccakTranscript.sol";
import "src/verifier/step4/EqPolynomial.sol";

library PallasPolyLib {
    struct MLPoly {
        uint64 numvars;
        uint256[] Z;
    }

    struct SparseEntry {
        uint256 idx;
        uint256 entry;
    }

    struct SparsePoly {
        uint64 numvars;
        SparseEntry[] Z;
    }

    struct UniPoly {
        uint256[] coeffs;
    }

    struct CompressedUniPoly {
        uint256[] coeffs_except_linear_term;
    }

    function newML(uint256[] memory Z, uint64 numvars) public pure returns (MLPoly memory) {
        require(Z.length == 2 ^ numvars);
        return MLPoly(numvars, Z);
    }

    function boundPolyVarTop(MLPoly calldata P, uint256 r) public pure returns (MLPoly memory) {
        uint256 mid = P.Z.length / 2;

        uint256[] memory new_Z;

        for (uint256 i = 0; i < mid; i++) {
            uint256 a = P.Z[i];
            uint256 b = P.Z[mid + i];
            // new_Z[i] = a + r * (b - a);
            new_Z[i] = addmod(a, mulmod(r, addmod(b, Pallas.negateBase(a), Pallas.P_MOD), Pallas.P_MOD), Pallas.P_MOD);
        }

        return MLPoly(P.numvars - 1, new_Z);
    }

    function evaluate(MLPoly calldata P, uint256[] calldata r) public pure returns (uint256 result) {
        require(P.Z.length == r.length);

        uint256[] memory chis = EqPolinomialLib.evalsPallas(r);

        for (uint256 i = 0; i < r.length; i++) {
            // result += chis[i] * P.Z[i];
            result = addmod(result, mulmod(chis[i], P.Z[i], Pallas.P_MOD), Pallas.P_MOD);
        }
    }

    function computeChi(bool[] memory a, uint256[] calldata r) public pure returns (uint256) {
        require(a.length == r.length);

        uint256 result;

        for (uint256 j = 0; j < r.length; j++) {
            if (a[j]) {
                // result *= r[j];
                result = mulmod(result, r[j], Pallas.P_MOD);
            } else {
                // result *= (1 - r[j]);
                result = mulmod(result, addmod(1, Pallas.negateBase(r[j]), Pallas.P_MOD), Pallas.P_MOD);
            }
        }

        return result;
    }

    function getBits(uint256 num, uint256 numbits) private pure returns (bool[] memory) {
        bool[] memory result;

        for (uint256 shift_amount = 0; shift_amount < numbits; shift_amount++) {
            result[shift_amount] = (num & (1 << (numbits - shift_amount - 1)) > 0);
        }

        return result;
    }

    function evaluate(SparsePoly calldata P, uint256[] calldata r) public pure returns (uint256) {
        require(P.numvars == r.length);

        uint256 result;

        for (uint256 i = 0; i < r.length; i++) {
            bool[] memory bits = getBits(P.Z[i].entry, r.length);
            // result += computeChi(bits, r) * P.Z[i].idx;
            result = addmod(result, mulmod(computeChi(bits, r), P.Z[i].idx, Pallas.P_MOD), Pallas.P_MOD);
        }

        return result;
    }

    function degree(UniPoly memory poly) public pure returns (uint256) {
        return poly.coeffs.length - 1;
    }

    function evalAtZero(UniPoly memory poly) public pure returns (uint256) {
        return poly.coeffs[0];
    }

    function evalAtOne(UniPoly memory poly) public pure returns (uint256 result) {
        for (uint256 i = 0; i < poly.coeffs.length; i++) {
            // result += poly.coeffs[i];
            result = addmod(result, poly.coeffs[i], Pallas.R_MOD);
        }
    }

    function evaluate(UniPoly memory poly, uint256 r) public pure returns (uint256) {
        uint256 power = r;
        uint256 result = poly.coeffs[0];
        for (uint256 i = 1; i < poly.coeffs.length; i++) {
            // result += power * poly.coeffs[i];
            result = addmod(result, mulmod(power, poly.coeffs[i], Pallas.R_MOD), Pallas.R_MOD);
            // power *= r;
            power = mulmod(power, r, Pallas.R_MOD);
        }

        return result;
    }

    function compress(UniPoly memory poly) public pure returns (CompressedUniPoly memory result) {
        result.coeffs_except_linear_term[0] = poly.coeffs[0];
        for (uint256 i = 1; i < poly.coeffs.length; i++) {
            result.coeffs_except_linear_term[i - 1] = poly.coeffs[i];
        }
    }

    function decompress(CompressedUniPoly calldata poly, uint256 hint) public pure returns (UniPoly memory) {
        // uint256 linear_term = hint - poly.coeffs_except_linear_term[0] - poly.coeffs_except_linear_term[0];
        uint256 linear_term = addmod(
            hint,
            Pallas.negateScalar(
                addmod(poly.coeffs_except_linear_term[0], poly.coeffs_except_linear_term[0], Pallas.R_MOD)
            ),
            Pallas.R_MOD
        );

        for (uint256 i = 1; i < poly.coeffs_except_linear_term.length; i++) {
            // linear_term -= poly.coeffs_except_linear_term[i];
            linear_term = addmod(linear_term, Pallas.negateScalar(poly.coeffs_except_linear_term[i]), Pallas.R_MOD);
        }

        uint256 coeff_index = 0;
        uint256[] memory coeffs = new uint256[](poly.coeffs_except_linear_term.length + 1);
        coeffs[coeff_index] = poly.coeffs_except_linear_term[0];
        coeff_index++;
        coeffs[coeff_index] = linear_term;
        coeff_index++;

        for (uint256 i = 1; i < poly.coeffs_except_linear_term.length; i++) {
            coeffs[coeff_index] = poly.coeffs_except_linear_term[i];
            coeff_index++;
        }

        return UniPoly(coeffs);
    }

    function toUInt8Array(uint256 input) private pure returns (uint8[] memory) {
        uint8[] memory result = new uint8[](32);

        bytes32 input_bytes = bytes32(input);

        for (uint256 i = 0; i < 32; i++) {
            result[i] = uint8(input_bytes[31 - i]);
        }
        return result;
    }

    function toTranscriptBytes(UniPoly memory poly) public pure returns (uint8[] memory) {
        uint8[] memory result = new uint8[](32 * (poly.coeffs.length - 1));

        uint256 offset;
        uint8[] memory coeff_bytes = toUInt8Array(poly.coeffs[0]);
        for (uint256 i = 0; i < 32; i++) {
            result[i] = coeff_bytes[i];
        }
        offset += 32;

        for (uint256 i = 2; i < poly.coeffs.length; i++) {
            coeff_bytes = toUInt8Array(poly.coeffs[i]);
            for (uint256 j = 0; j < 32; j++) {
                result[offset + j] = coeff_bytes[j];
            }
            offset += 32;
        }

        return result;
    }
}

library VestaPolyLib {
    struct MLPoly {
        uint64 numvars;
        uint256[] Z;
    }

    struct SparseEntry {
        uint256 idx;
        uint256 entry;
    }

    struct SparsePoly {
        uint64 numvars;
        SparseEntry[] Z;
    }

    struct UniPoly {
        uint256[] coeffs;
    }

    struct CompressedUniPoly {
        uint256[] coeffs_except_linear_term;
    }

    function newML(uint256[] memory Z, uint64 numvars) public pure returns (MLPoly memory) {
        require(Z.length == 2 ^ numvars);
        return MLPoly(numvars, Z);
    }

    function boundPolyVarTop(MLPoly calldata P, uint256 r) public pure returns (MLPoly memory) {
        uint256 mid = P.Z.length / 2;

        uint256[] memory new_Z;

        for (uint256 i = 0; i < mid; i++) {
            uint256 a = P.Z[i];
            uint256 b = P.Z[mid + i];
            // new_Z[i] = a + r * (b - a);
            new_Z[i] = addmod(a, mulmod(r, addmod(b, Vesta.negateBase(a), Vesta.P_MOD), Vesta.P_MOD), Vesta.P_MOD);
        }

        return MLPoly(P.numvars - 1, new_Z);
    }

    function evaluate(MLPoly calldata P, uint256[] calldata r) public pure returns (uint256 result) {
        require(P.Z.length == r.length);

        uint256[] memory chis = EqPolinomialLib.evalsVesta(r);

        for (uint256 i = 0; i < r.length; i++) {
            // result += chis[i] * P.Z[i];
            result = addmod(result, mulmod(chis[i], P.Z[i], Vesta.P_MOD), Vesta.P_MOD);
        }
    }

    function computeChi(bool[] memory a, uint256[] calldata r) public pure returns (uint256) {
        require(a.length == r.length);

        uint256 result;

        for (uint256 j = 0; j < r.length; j++) {
            if (a[j]) {
                // result *= r[j];
                result = mulmod(result, r[j], Vesta.P_MOD);
            } else {
                // result *= (1 - r[j]);
                result = mulmod(result, addmod(1, Vesta.negateBase(r[j]), Vesta.P_MOD), Vesta.P_MOD);
            }
        }

        return result;
    }

    function getBits(uint256 num, uint256 numbits) private pure returns (bool[] memory) {
        bool[] memory result;

        for (uint256 shift_amount = 0; shift_amount < numbits; shift_amount++) {
            result[shift_amount] = (num & (1 << (numbits - shift_amount - 1)) > 0);
        }

        return result;
    }

    function evaluate(SparsePoly calldata P, uint256[] calldata r) public pure returns (uint256) {
        require(P.numvars == r.length);

        uint256 result;

        for (uint256 i = 0; i < r.length; i++) {
            bool[] memory bits = getBits(P.Z[i].entry, r.length);
            // result += computeChi(bits, r) * P.Z[i].idx;
            result = addmod(result, mulmod(computeChi(bits, r), P.Z[i].idx, Vesta.R_MOD), Vesta.R_MOD);
        }

        return result;
    }

    function degree(UniPoly memory poly) public pure returns (uint256) {
        return poly.coeffs.length - 1;
    }

    function evalAtZero(UniPoly memory poly) public pure returns (uint256) {
        return poly.coeffs[0];
    }

    function evalAtOne(UniPoly memory poly) public pure returns (uint256 result) {
        for (uint256 i = 0; i < poly.coeffs.length; i++) {
            // result += poly.coeffs[i];
            result = addmod(result, poly.coeffs[i], Vesta.R_MOD);
        }
    }

    function evaluate(UniPoly memory poly, uint256 r) public pure returns (uint256) {
        uint256 power = r;
        uint256 result = poly.coeffs[0];
        for (uint256 i = 1; i < poly.coeffs.length; i++) {
            // result += power * poly.coeffs[i];
            result = addmod(result, mulmod(power, poly.coeffs[i], Vesta.R_MOD), Vesta.R_MOD);
            // power *= r;
            power = mulmod(power, r, Vesta.R_MOD);
        }

        return result;
    }

    function compress(UniPoly memory poly) public pure returns (CompressedUniPoly memory result) {
        result.coeffs_except_linear_term[0] = poly.coeffs[0];
        for (uint256 i = 0; i < poly.coeffs.length; i++) {
            result.coeffs_except_linear_term[i - 1] = poly.coeffs[i];
        }
    }

    function decompress(CompressedUniPoly calldata poly, uint256 hint) public pure returns (UniPoly memory) {
        // uint256 linear_term = hint - poly.coeffs_except_linear_term[0] - poly.coeffs_except_linear_term[0];
        uint256 linear_term = addmod(
            hint,
            Vesta.negateScalar(
                addmod(poly.coeffs_except_linear_term[0], poly.coeffs_except_linear_term[0], Vesta.R_MOD)
            ),
            Vesta.R_MOD
        );
        for (uint256 i = 1; i < poly.coeffs_except_linear_term.length; i++) {
            // linear_term -= poly.coeffs_except_linear_term[i];
            linear_term = addmod(linear_term, Vesta.negateScalar(poly.coeffs_except_linear_term[i]), Vesta.R_MOD);
        }

        uint256[] memory coeffs = new uint256[](poly.coeffs_except_linear_term.length + 1);
        coeffs[0] = poly.coeffs_except_linear_term[0];
        coeffs[1] = linear_term;

        for (uint256 i = 1; i < poly.coeffs_except_linear_term.length; i++) {
            coeffs[i + 1] = poly.coeffs_except_linear_term[i];
        }

        return UniPoly(coeffs);
    }

    function toUInt8Array(uint256 input) private pure returns (uint8[] memory) {
        uint8[] memory result = new uint8[](32);

        bytes32 input_bytes = bytes32(input);

        for (uint256 i = 0; i < 32; i++) {
            result[i] = uint8(input_bytes[31 - i]);
        }
        return result;
    }

    function toTranscriptBytes(UniPoly memory poly) public pure returns (uint8[] memory) {
        uint8[] memory result = new uint8[](32 * (poly.coeffs.length - 1));

        uint256 offset;
        uint8[] memory coeff_bytes = toUInt8Array(poly.coeffs[0]);
        for (uint256 i = 0; i < 32; i++) {
            result[i] = coeff_bytes[i];
        }
        offset += 32;

        for (uint256 i = 2; i < poly.coeffs.length; i++) {
            coeff_bytes = toUInt8Array(poly.coeffs[i]);
            for (uint256 j = 0; j < 32; j++) {
                result[offset + j] = coeff_bytes[j];
            }
            offset += 32;
        }

        return result;
    }
}

library PrimarySumcheck {
    struct SumcheckProof {
        PallasPolyLib.CompressedUniPoly[] compressed_polys;
    }

    function verify(
        SumcheckProof calldata proof,
        uint256 claim,
        uint256 num_rounds,
        uint256 degree_bound,
        KeccakTranscriptLib.KeccakTranscript memory transcript
    ) public pure returns (uint256, uint256[] memory, KeccakTranscriptLib.KeccakTranscript memory) {
        uint256 e = claim;
        uint256[] memory r = new uint256[](num_rounds);

        uint8[] memory p_label = new uint8[](1);
        uint8[] memory c_label = new uint8[](1);

        p_label[0] = 112;
        c_label[0] = 99;

        require(proof.compressed_polys.length == num_rounds, "Wrong number of polynomials");

        PallasPolyLib.UniPoly memory poly;

        for (uint256 i = 0; i < num_rounds; i++) {
            poly = PallasPolyLib.decompress(proof.compressed_polys[i], e);

            require(PallasPolyLib.degree(poly) == degree_bound, "Polynomial has wrong degree");
            require(
                addmod(PallasPolyLib.evalAtZero(poly), PallasPolyLib.evalAtOne(poly), Pallas.R_MOD) == e,
                "Polynomial decompression yields incorrect result"
            );

            transcript = KeccakTranscriptLib.absorb(transcript, p_label, PallasPolyLib.toTranscriptBytes(poly));

            uint256 r_i;
            (transcript, r_i) = KeccakTranscriptLib.squeeze(transcript, ScalarFromUniformLib.curveVesta(), c_label);

            r[i] = r_i;

            e = PallasPolyLib.evaluate(poly, r_i);
        }

        return (e, r, transcript);
    }
}

library SecondarySumcheck {
    struct SumcheckProof {
        VestaPolyLib.CompressedUniPoly[] compressed_polys;
    }

    function verify(
        SumcheckProof calldata proof,
        uint256 claim,
        uint256 num_rounds,
        uint256 degree_bound,
        KeccakTranscriptLib.KeccakTranscript memory transcript
    ) public view returns (uint256, uint256[] memory, KeccakTranscriptLib.KeccakTranscript memory) {
        uint256 e = claim;
        uint256[] memory r = new uint256[](num_rounds);

        uint8[] memory p_label = new uint8[](1);
        uint8[] memory c_label = new uint8[](1);

        p_label[0] = 112;
        c_label[0] = 99;

        require(proof.compressed_polys.length == num_rounds, "Wrong number of polynomials");

        VestaPolyLib.UniPoly memory poly;

        for (uint256 i = 0; i < num_rounds; i++) {
            poly = VestaPolyLib.decompress(proof.compressed_polys[i], e);

            require(VestaPolyLib.degree(poly) == degree_bound, "Polynomial has wrong degree");
            require(
                addmod(VestaPolyLib.evalAtZero(poly), VestaPolyLib.evalAtOne(poly), Vesta.R_MOD) == e,
                "Polynomial decompression yields incorrect result"
            );

            transcript = KeccakTranscriptLib.absorb(transcript, p_label, VestaPolyLib.toTranscriptBytes(poly));

            uint256 r_i;
            (transcript, r_i) = KeccakTranscriptLib.squeeze(transcript, ScalarFromUniformLib.curvePallas(), c_label);

            console.log("got here");
            r[i] = r_i;

            e = VestaPolyLib.evaluate(poly, r_i);
        }

        return (e, r, transcript);
    }
}
