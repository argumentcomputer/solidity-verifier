// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.16;

import "src/pasta/Pallas.sol";
import "src/pasta/Vesta.sol";
import "src/verifier/step4/KeccakTranscript.sol";
import "src/verifier/step4/EqPolynomial.sol";
import "src/Polynomial.sol";

library PrimarySumcheck {
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

library SecondarySumcheck {
    struct SumcheckProof {
        PolyLib.CompressedUniPoly[] compressed_polys;
    }

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
