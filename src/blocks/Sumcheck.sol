// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.16;

import "src/blocks/pasta/Pallas.sol";
import "src/blocks/pasta/Vesta.sol";
import "src/blocks/KeccakTranscript.sol";
import "src/blocks/EqPolynomial.sol";
import "src/Utilities.sol";

/**
 * @title Primary Sumcheck Library
 * @notice Implements the primary sumcheck verification protocol.
 */
library PrimarySumcheck {
    /**
     * @notice Verifies the primary sumcheck proof.
     * @param proof The sumcheck proof to be verified.
     * @param claim The initial claim or value to verify against.
     * @param num_rounds The number of rounds in the sumcheck protocol.
     * @param degree_bound The degree bound of the polynomial.
     * @param transcript The Keccak transcript used during verification.
     * @return A tuple of 3 elements: the final value after all rounds of verification, the array of challenges used in
     *         each round, and the updated Keccak transcript.
     */
    function verify(
        PolyLib.SumcheckProof calldata proof,
        uint256 claim,
        uint256 num_rounds,
        uint256 degree_bound,
        KeccakTranscriptLib.KeccakTranscript memory transcript
    ) public pure returns (uint256, uint256[] memory, KeccakTranscriptLib.KeccakTranscript memory) {
        uint256 e = claim;
        uint256[] memory r = new uint256[](num_rounds);

        uint8[] memory label = new uint8[](1);

        require(proof.compressed_polys.length == num_rounds, "[PrimarySumcheck::verify] Wrong number of polynomials");

        PolyLib.UniPoly memory poly;

        for (uint256 i = 0; i < num_rounds; i++) {
            poly = PolyLib.decompress(proof.compressed_polys[i], e, Pallas.R_MOD);

            require(PolyLib.degree(poly) == degree_bound, "[PrimarySumcheck::verify] Polynomial has wrong degree");
            require(
                addmod(PolyLib.evalAtZero(poly), PolyLib.evalAtOne(poly, Pallas.R_MOD), Pallas.R_MOD) == e,
                "[PrimarySumcheck::verify] Polynomial decompression yields incorrect result"
            );

            label[0] = 112; // p_label[0] = 112;

            transcript = KeccakTranscriptLib.absorb(transcript, label, poly);

            uint256 r_i;
            label[0] = 99; // c_label[0] = 99;
            (transcript, r_i) = KeccakTranscriptLib.squeeze(transcript, ScalarFromUniformLib.curveVesta(), label);
            r[i] = r_i;

            e = PolyLib.evaluate(poly, r_i, Pallas.R_MOD);
        }

        return (e, r, transcript);
    }
}

/**
 * @title Secondary Sumcheck Library
 * @notice Implements the secondary sumcheck verification protocol.
 */
library SecondarySumcheck {
    /**
     * @notice Verifies the secondary sumcheck proof.
     * @param proof The sumcheck proof to be verified.
     * @param claim The initial claim or value to verify against.
     * @param num_rounds The number of rounds in the sumcheck protocol.
     * @param degree_bound The degree bound of the polynomial.
     * @param transcript The Keccak transcript used during verification.
     * @return A tuple of 3 elements: the final value after all rounds of verification, the array of challenges used in
     *         each round, and the updated Keccak transcript.
     */
    function verify(
        PolyLib.SumcheckProof calldata proof,
        uint256 claim,
        uint256 num_rounds,
        uint256 degree_bound,
        KeccakTranscriptLib.KeccakTranscript memory transcript
    ) public pure returns (uint256, uint256[] memory, KeccakTranscriptLib.KeccakTranscript memory) {
        uint256 e = claim;
        uint256[] memory r = new uint256[](num_rounds);

        uint8[] memory label = new uint8[](1);

        require(proof.compressed_polys.length == num_rounds, "[SecondarySumcheck::verify] Wrong number of polynomials");

        PolyLib.UniPoly memory poly;

        for (uint256 i = 0; i < num_rounds; i++) {
            poly = PolyLib.decompress(proof.compressed_polys[i], e, Vesta.R_MOD);

            require(PolyLib.degree(poly) == degree_bound, "[SecondarySumcheck::verify] Polynomial has wrong degree");
            require(
                addmod(PolyLib.evalAtZero(poly), PolyLib.evalAtOne(poly, Vesta.R_MOD), Vesta.R_MOD) == e,
                "[SecondarySumcheck::verify] Polynomial decompression yields incorrect result"
            );

            label[0] = 112; // p_label[0] = 112;

            transcript = KeccakTranscriptLib.absorb(transcript, label, poly);

            uint256 r_i;
            label[0] = 99; // c_label[0] = 99;
            (transcript, r_i) = KeccakTranscriptLib.squeeze(transcript, ScalarFromUniformLib.curvePallas(), label);
            r[i] = r_i;

            e = PolyLib.evaluate(poly, r_i, Vesta.R_MOD);
        }

        return (e, r, transcript);
    }
}
