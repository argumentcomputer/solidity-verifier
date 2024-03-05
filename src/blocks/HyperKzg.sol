// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.16;

import "src/blocks/grumpkin/Bn256.sol";
import "src/blocks/Pairing.sol";
import "src/blocks/KeccakTranscript.sol";

library HyperKzg {
    struct HyperKzgInput {
        Bn256.Bn256AffinePoint[] pi_comms;
        uint256[] R_x;
        uint256[] pi_evals_0;
        uint256[] pi_evals_1;
        uint256[] pi_evals_2;
        uint256 p_of_x;
        uint256[] point;
        Bn256.Bn256AffinePoint C;
        Bn256.Bn256AffinePoint C_Q;
        Bn256.Bn256AffinePoint C_H;
        Bn256.Bn256AffinePoint vk_g;
        Pairing.G2Point beta_h;
        Pairing.G2Point h;
    }

    function pushElement(uint256[] memory input, uint256 element) private pure returns (uint256[] memory) {
        uint256[] memory output = new uint256[](input.length + 1);
        for (uint256 i = 0; i < input.length; i++) {
            output[i] = input[i];
        }
        output[output.length - 1] = element;
        return output;
    }

    function insertPoint(Bn256.Bn256AffinePoint[] memory input, Bn256.Bn256AffinePoint memory point, uint256 index)
        private
        pure
        returns (Bn256.Bn256AffinePoint[] memory)
    {
        require(index <= input.length, "unexpected index");

        Bn256.Bn256AffinePoint[] memory output = new Bn256.Bn256AffinePoint[](input.length + 1);
        for (uint256 i = 0; i < index; i++) {
            output[i] = input[i];
        }
        output[index] = point;
        for (uint256 i = index + 1; i < output.length; i++) {
            output[i] = input[i - 1];
        }
        return output;
    }

    function pi_polys_are_correct(
        uint256[] memory pi_evals_0,
        uint256[] memory pi_evals_1,
        uint256[] memory pi_evals_2,
        uint256[] memory point_in,
        uint256 r,
        uint256 p_of_x
    ) private pure returns (bool) {
        require(pi_evals_0.length == point_in.length, "unexpected length of pi_evals_0");
        require(pi_evals_1.length == point_in.length, "unexpected length of pi_evals_1");
        require(pi_evals_2.length == point_in.length, "unexpected length of pi_evals_2");

        uint256[] memory evals_0 = pushElement(pi_evals_0, p_of_x);
        uint256[] memory evals_1 = pushElement(pi_evals_1, p_of_x);
        uint256[] memory evals_2 = pushElement(pi_evals_2, p_of_x);

        // reverse order of points
        uint256[] memory point = new uint256[](point_in.length);
        for (uint256 index = 0; index < point.length; index++) {
            point[point.length - index - 1] = point_in[index];
        }

        uint256 r_mul_2 = mulmod(2, r, Bn256.R_MOD);

        uint256 even;
        uint256 odd;
        uint256 left;
        uint256 right;
        uint256 tmp;
        for (uint256 index = 0; index < point.length; index++) {
            even = addmod(evals_0[index], evals_1[index], Bn256.R_MOD);
            odd = addmod(evals_0[index], Bn256.negateScalar(evals_1[index]), Bn256.R_MOD);
            tmp = mulmod(point[index], odd, Bn256.R_MOD);
            right = addmod(1, Bn256.negateScalar(point[index]), Bn256.R_MOD);
            right = mulmod(right, even, Bn256.R_MOD);
            right = mulmod(right, r, Bn256.R_MOD);
            right = addmod(right, tmp, Bn256.P_MOD);

            left = mulmod(evals_2[index + 1], r_mul_2, Bn256.R_MOD);

            if (left != right) {
                return false;
            }
        }
        return true;
    }

    function compute_C_P(Bn256.Bn256AffinePoint[] memory pi_comms, Bn256.Bn256AffinePoint memory C, uint256 q)
        private
        returns (Bn256.Bn256AffinePoint memory)
    {
        Bn256.Bn256AffinePoint[] memory comms = insertPoint(pi_comms, C, 0);

        uint256[] memory q_degrees = new uint256[](comms.length);
        q_degrees[0] = 1;
        q_degrees[1] = q;

        for (uint256 i = 2; i < comms.length; i++) {
            q_degrees[i] = mulmod(q_degrees[i - 1], q, Bn256.R_MOD);
        }
        return Bn256.multiScalarMul(comms, q_degrees);
    }

    function compute_C_K(
        HyperKzgInput memory input,
        uint256 a,
        uint256[] memory D_coeffs,
        PolyLib.UniPoly memory R_x_poly,
        Bn256.Bn256AffinePoint memory C_P
    ) private returns (Bn256.Bn256AffinePoint memory) {
        Bn256.Bn256AffinePoint memory tmp = Bn256.scalarMul(input.vk_g, PolyLib.evaluate(R_x_poly, a, Bn256.R_MOD));
        Bn256.Bn256AffinePoint memory C_K =
            Bn256.scalarMul(input.C_Q, PolyLib.evaluate(PolyLib.UniPoly(D_coeffs), a, Bn256.R_MOD));
        C_K = Bn256.negate(Bn256.add(tmp, C_K));
        C_K = Bn256.add(C_P, C_K);
        return C_K;
    }

    function pairingCheckSuccessful(HyperKzgInput memory input, Bn256.Bn256AffinePoint memory C_K, uint256 a)
        private
        returns (bool)
    {
        /*
           let pairing_inputs: Vec<(E::G1Affine, E::G2Prepared)> = vec![
               (C_H, vk.beta_h.into()),
               ((C_H * (-a) - C_K).to_affine(), vk.h.into()),
           ];
        */
        Pairing.G1Point memory g1_1 = Pairing.G1Point(input.C_H);
        Pairing.G2Point memory g2_1 = input.beta_h;

        Pairing.G1Point memory g1_2 =
            Pairing.G1Point(Bn256.add(Bn256.negate(C_K), Bn256.scalarMul(input.C_H, Bn256.negateScalar(a))));
        Pairing.G2Point memory g2_2 = input.h;

        return Pairing.pairingProd2(g1_1, g2_1, g1_2, g2_2);
    }

    function verify(HyperKzgInput memory input, KeccakTranscriptLib.KeccakTranscript memory transcript)
        public
        returns (bool)
    {
        // b"c" in Rust
        uint8[] memory label = new uint8[](1);
        label[0] = 0x63;

        transcript = KeccakTranscriptLib.absorb(transcript, label, input.pi_comms);
        uint256 r;
        (transcript, r) = KeccakTranscriptLib.squeeze(transcript, ScalarFromUniformLib.curveBn256(), label);

        uint256[] memory u = new uint256[](3);
        u[0] = r;
        u[1] = Bn256.negateScalar(r);
        u[2] = mulmod(r, r, Bn256.R_MOD);

        PolyLib.UniPoly memory R_x_poly = PolyLib.UniPoly(input.R_x);

        // b"v" in Rust
        label[0] = 0x76;
        transcript = KeccakTranscriptLib.absorb(transcript, label, input.pi_evals_0, input.pi_evals_1, input.pi_evals_2);

        // b"r" in Rust
        label[0] = 0x72;
        uint256 q;
        (transcript, q) = KeccakTranscriptLib.squeeze(transcript, ScalarFromUniformLib.curveBn256(), label);

        PolyLib.UniPoly[3] memory evals =
            [PolyLib.UniPoly(input.pi_evals_0), PolyLib.UniPoly(input.pi_evals_1), PolyLib.UniPoly(input.pi_evals_2)];
        for (uint256 i = 0; i < evals.length; i++) {
            if (PolyLib.evaluate(R_x_poly, u[i], Bn256.R_MOD) != PolyLib.evaluate(evals[i], q, Bn256.R_MOD)) {
                return false;
            }
        }

        if (!pi_polys_are_correct(input.pi_evals_0, input.pi_evals_1, input.pi_evals_2, input.point, r, input.p_of_x)) {
            return false;
        }

        Bn256.Bn256AffinePoint memory C_P = compute_C_P(input.pi_comms, input.C, q);

        // D = (x - r) * (x + r) * (x - r^2) = 1 * x^3 - r^2 * x^2 - r^2 * x + r^4
        uint256[] memory D_coeffs = new uint256[](4);
        D_coeffs[0] = mulmod(u[2], u[2], Bn256.R_MOD);
        D_coeffs[1] = Bn256.negateScalar(u[2]);
        D_coeffs[2] = Bn256.negateScalar(u[2]);
        D_coeffs[3] = 1;

        // b"C_Q" in Rust
        label = new uint8[](3);
        label[0] = 0x43;
        label[1] = 0x5f;
        label[2] = 0x51;
        transcript = KeccakTranscriptLib.absorb(transcript, label, input.C_Q);

        // b"a" in Rust
        label = new uint8[](1);
        label[0] = 0x61;
        uint256 a;
        (transcript, a) = KeccakTranscriptLib.squeeze(transcript, ScalarFromUniformLib.curveBn256(), label);

        Bn256.Bn256AffinePoint memory C_K = compute_C_K(input, a, D_coeffs, R_x_poly, C_P);

        return pairingCheckSuccessful(input, C_K, a);
    }
}
