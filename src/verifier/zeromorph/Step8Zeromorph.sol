// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.16;

import "@std/Test.sol";
import "src/NovaVerifierAbstractions.sol";
import "src/blocks/KeccakTranscript.sol";
import "src/blocks/grumpkin/Zeromorph.sol";

library Step8GrumpkinZeromorphLib {
    function compute_scalars(
        KeccakTranscriptLib.KeccakTranscript memory transcript,
        Abstractions.EvaluationArgumentZMProof memory proof,
        uint256 evaluation,
        uint256[] memory r_z
    ) public returns (uint256[] memory) {
        uint256 index;
        uint8[] memory zeromorph_keccak_label = new uint8[](9); // Rust's b"Zeromorph"
        zeromorph_keccak_label[0] = 0x5a;
        zeromorph_keccak_label[1] = 0x65;
        zeromorph_keccak_label[2] = 0x72;
        zeromorph_keccak_label[3] = 0x6f;
        zeromorph_keccak_label[4] = 0x6d;
        zeromorph_keccak_label[5] = 0x6f;
        zeromorph_keccak_label[6] = 0x72;
        zeromorph_keccak_label[7] = 0x70;
        zeromorph_keccak_label[8] = 0x68;

        transcript = KeccakTranscriptLib.dom_sep(transcript, zeromorph_keccak_label);

        zeromorph_keccak_label = new uint8[](3); // Rust's b"quo"
        zeromorph_keccak_label[0] = 0x71;
        zeromorph_keccak_label[1] = 0x75;
        zeromorph_keccak_label[2] = 0x6f;
        for (index = 0; index < proof.ck.length; index++) {
            transcript = KeccakTranscriptLib.absorb(transcript, zeromorph_keccak_label, proof.ck[index]);
        }
        zeromorph_keccak_label = new uint8[](1); // Rust's b"y"
        zeromorph_keccak_label[0] = 0x79;
        uint256 y;
        (transcript, y) =
            KeccakTranscriptLib.squeeze(transcript, ScalarFromUniformLib.curveBn256(), zeromorph_keccak_label);

        zeromorph_keccak_label = new uint8[](5); // Rust's b"q_hat"
        zeromorph_keccak_label[0] = 0x71;
        zeromorph_keccak_label[1] = 0x5f;
        zeromorph_keccak_label[2] = 0x68;
        zeromorph_keccak_label[3] = 0x61;
        zeromorph_keccak_label[4] = 0x74;

        transcript = KeccakTranscriptLib.absorb(
            transcript, zeromorph_keccak_label, Bn256.Bn256AffinePoint(proof.cqhat_x, proof.cqhat_y)
        );

        zeromorph_keccak_label = new uint8[](1); // Rust's b"x"
        zeromorph_keccak_label[0] = 0x78;
        uint256 x;
        (transcript, x) =
            KeccakTranscriptLib.squeeze(transcript, ScalarFromUniformLib.curveBn256(), zeromorph_keccak_label);

        zeromorph_keccak_label = new uint8[](1); // Rust's b"z"
        zeromorph_keccak_label[0] = 0x7a;
        uint256 z;
        (transcript, z) =
            KeccakTranscriptLib.squeeze(transcript, ScalarFromUniformLib.curveBn256(), zeromorph_keccak_label);

        (uint256 eval_scalar, uint256[] memory scalars) = Zeromorph.eval_and_quotient_scalars(y, x, z, r_z);

        return Zeromorph.compose_scalars(eval_scalar, z, evaluation, scalars);
    }

    function verify(
        KeccakTranscriptLib.KeccakTranscript memory transcript,
        Abstractions.EvaluationArgumentZMProof memory proof,
        Abstractions.UVKZGVerifierKey memory vp,
        uint256[] memory r_z,
        uint256 evaluation,
        Bn256.Bn256AffinePoint memory comm_joint
    ) public returns (bool) {
        uint256[] memory scalars = compute_scalars(transcript, proof, evaluation, r_z);
        Bn256.Bn256AffinePoint[] memory bases = new Bn256.Bn256AffinePoint[](3 + proof.ck.length);
        bases[0] = Bn256.Bn256AffinePoint(proof.cqhat_x, proof.cqhat_y);
        bases[1] = comm_joint;
        bases[2] = Bn256.Bn256AffinePoint(vp.g_x, vp.g_y);
        for (uint256 index = 0; index < proof.ck.length; index++) {
            bases[index + 3] = proof.ck[index];
        }

        // TODO implement decompression and negation of G2 elements and remove following hardcode
        return Zeromorph.runPairingCheck(
            Pairing.G1Point(Bn256.multiScalarMul(bases, scalars)),
            Pairing.G2Point(
                [
                    0x2e85a64b176a89f651b755522402780ac5224a690c62c2a3580e2b77391eb85f,
                    0x25a630e1b1bb847ca0e32e8d5a2c62d424e4b0d67d8295d094589efba2611485
                ],
                [
                    0x20062c1dedabfae5465f5543c8118fcdd4dc0bf87f74feb0664664ece453bb80,
                    0x1beb7fcb3dc0213c812c157449f4b3877b1400bd34850b63d448784bbda0fa99
                ]
            ),
            Pairing.G1Point(Bn256.Bn256AffinePoint(proof.pi_x, proof.pi_y)),
            Pairing.G2Point(
                [
                    0x116a2db8e437dbad09dd9a8d0c8c1c87a340d9b0d6368f67c1309b62ab9c7b31,
                    0x01f9945864ce66be7689eefac2c5a73fb3f844fedb390c5c6a7ac4afd2893625
                ],
                [
                    0x1274b49a6ca889a2d59c5d7dc2e0802b795ba68d434bc4ce34bdb8780ee88906,
                    0x1d5f6640e89e8fcf6b5bfd1af8fc17f4c7bf1589bb30460ba04a4b69c2a742b4
                ]
            )
        );
    }
}
