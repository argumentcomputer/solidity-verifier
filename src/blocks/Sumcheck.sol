// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.0;

import "@std/Test.sol";
import "src/pasta/Pallas.sol";
import "src/pasta/Vesta.sol";
import "src/blocks/KeccakTranscript.sol";
import "src/blocks/EqPolynomial.sol";

library SumcheckUtilities {
    struct UniPoly {
        uint256[] coeffs;
    }

    struct CompressedUniPoly {
        uint256[] coeffs_except_linear_term;
    }

    struct SumcheckProof {
        CompressedUniPoly[] compressed_polys;
    }

    function degree(UniPoly memory poly) public pure returns (uint256) {
        return poly.coeffs.length - 1;
    }

    function evalAtZero(UniPoly memory poly) public pure returns (uint256) {
        return poly.coeffs[0];
    }

    function toUInt8Array(uint256 input) private pure returns (uint8[] memory) {
        uint8[] memory result = new uint8[](32);

        bytes32 input_bytes = bytes32(input);

        for (uint256 i = 0; i < 32; i++) {
            result[i] = uint8(input_bytes[31 - i]);
        }
        return result;
    }

    function toTranscriptBytes(SumcheckUtilities.UniPoly memory poly) public pure returns (uint8[] memory) {
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

    function evalAtOne(UniPoly memory poly, uint256 modulus) public pure returns (uint256 result) {
        for (uint256 i = 0; i < poly.coeffs.length; i++) {
            // result += poly.coeffs[i];
            result = addmod(result, poly.coeffs[i], modulus);
        }
    }

    function evaluate(UniPoly memory poly, uint256 r, uint256 modulus) public pure returns (uint256) {
        uint256 power = r;
        uint256 result = poly.coeffs[0];
        for (uint256 i = 1; i < poly.coeffs.length; i++) {
            // result += power * poly.coeffs[i];
            result = addmod(result, mulmod(power, poly.coeffs[i], modulus), modulus);
            // power *= r;
            power = mulmod(power, r, modulus);
        }

        return result;
    }

    function decompress(
        SumcheckUtilities.CompressedUniPoly memory poly,
        uint256 hint,
        uint256 modulus,
        function (uint256) returns (uint256) negateScalar
    ) internal returns (SumcheckUtilities.UniPoly memory) {
        // uint256 linear_term = hint - poly.coeffs_except_linear_term[0] - poly.coeffs_except_linear_term[0];
        uint256 linear_term = addmod(
            hint,
            negateScalar(addmod(poly.coeffs_except_linear_term[0], poly.coeffs_except_linear_term[0], modulus)),
            modulus
        );

        for (uint256 i = 1; i < poly.coeffs_except_linear_term.length; i++) {
            // linear_term -= poly.coeffs_except_linear_term[i];
            linear_term = addmod(linear_term, negateScalar(poly.coeffs_except_linear_term[i]), modulus);
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

        return SumcheckUtilities.UniPoly(coeffs);
    }
}

library PrimarySumcheck {
    function verify(
        SumcheckUtilities.SumcheckProof calldata proof,
        uint256 claim,
        uint256 num_rounds,
        uint256 degree_bound,
        KeccakTranscriptLib.KeccakTranscript memory transcript
    ) public returns (uint256, uint256[] memory, KeccakTranscriptLib.KeccakTranscript memory) {
        uint256 e = claim;
        uint256[] memory r = new uint256[](proof.compressed_polys.length);

        if (proof.compressed_polys.length != num_rounds) {
            console.log("[NovaError::InvalidSumcheckProof | Primary], proof.compressed_polys.length != num_rounds");
            revert();
        }

        SumcheckUtilities.UniPoly memory uni_poly;
        uint8[] memory transcriptBytes;
        uint8[] memory label = new uint8[](1);

        for (uint256 index = 0; index < proof.compressed_polys.length; index++) {
            uni_poly = SumcheckUtilities.decompress(proof.compressed_polys[index], e, Pallas.R_MOD, Pallas.negateScalar); // Pallas

            if (SumcheckUtilities.degree(uni_poly) != degree_bound) {
                console.log(
                    "[NovaError::InvalidSumcheckProof | Primary], SumcheckUtilities.degree(uni_poly) != degreeBound"
                );
                revert();
            }

            // Rust:
            // debug_assert_eq!(poly.eval_at_zero() + poly.eval_at_one(), e);
            require(
                addmod(
                    SumcheckUtilities.evalAtZero(uni_poly),
                    SumcheckUtilities.evalAtOne(uni_poly, Pallas.R_MOD), // Pallas
                    Pallas.R_MOD // Pallas
                ) == e,
                "[Primary] evalAtZero + evalAtOne != e"
            );

            transcriptBytes = SumcheckUtilities.toTranscriptBytes(uni_poly);

            label[0] = 0x70; // b"p" in Rust
            transcript = KeccakTranscriptLib.absorb(transcript, label, transcriptBytes);

            label[0] = 0x63; // b"c" in Rust
            (transcript, r[index]) = KeccakTranscriptLib.squeeze(transcript, ScalarFromUniformLib.curveVesta(), label); // Vesta

            e = SumcheckUtilities.evaluate(uni_poly, r[index], Pallas.R_MOD); // Pallas
        }

        return (e, r, transcript);
    }
}

library SecondarySumcheck {
    function verify(
        SumcheckUtilities.SumcheckProof calldata proof,
        uint256 claim,
        uint256 num_rounds,
        uint256 degree_bound,
        KeccakTranscriptLib.KeccakTranscript memory transcript
    ) public returns (uint256, uint256[] memory, KeccakTranscriptLib.KeccakTranscript memory) {
        uint256 e = claim;
        uint256[] memory r = new uint256[](proof.compressed_polys.length);

        if (proof.compressed_polys.length != num_rounds) {
            console.log("[NovaError::InvalidSumcheckProof | Secondary], proof.compressed_polys.length != num_rounds");
            revert();
        }

        SumcheckUtilities.UniPoly memory uni_poly;
        uint8[] memory transcriptBytes;
        uint8[] memory label = new uint8[](1);

        for (uint256 index = 0; index < proof.compressed_polys.length; index++) {
            uni_poly = SumcheckUtilities.decompress(proof.compressed_polys[index], e, Vesta.R_MOD, Vesta.negateScalar); // Vesta

            if (SumcheckUtilities.degree(uni_poly) != degree_bound) {
                console.log(
                    "[NovaError::InvalidSumcheckProof | Secondary], SumcheckUtilities.degree(uni_poly) != degreeBound"
                );
                revert();
            }

            // Rust:
            // debug_assert_eq!(poly.eval_at_zero() + poly.eval_at_one(), e);
            require(
                addmod(
                    SumcheckUtilities.evalAtZero(uni_poly),
                    SumcheckUtilities.evalAtOne(uni_poly, Vesta.R_MOD), // Vesta
                    Vesta.R_MOD // Vesta
                ) == e,
                "[Secondary] evalAtZero + evalAtOne != e"
            );

            transcriptBytes = SumcheckUtilities.toTranscriptBytes(uni_poly);

            label[0] = 0x70; // b"p" in Rust
            transcript = KeccakTranscriptLib.absorb(transcript, label, transcriptBytes);

            label[0] = 0x63; // b"c" in Rust
            (transcript, r[index]) = KeccakTranscriptLib.squeeze(transcript, ScalarFromUniformLib.curvePallas(), label); // Pallas
            r[index] = Field.reverse256(r[index]);

            e = SumcheckUtilities.evaluate(uni_poly, r[index], Vesta.R_MOD); // Vesta
        }

        return (e, r, transcript);
    }
}
