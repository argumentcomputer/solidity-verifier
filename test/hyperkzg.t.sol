// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.16;

import "@std/Test.sol";
import "src/blocks/KeccakTranscript.sol";
import "src/blocks/grumpkin/Bn256.sol";
import "src/Utilities.sol";
import "src/blocks/Pairing.sol";

contract HyperKzgTest is Test {
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

    function composeHyperKzgInput() private pure returns (HyperKzgInput memory) {
        Bn256.Bn256AffinePoint[] memory pi_comms = new Bn256.Bn256AffinePoint[](2);
        pi_comms[0] = Bn256.Bn256AffinePoint(
            0x1e252582f77d12b3fbf9376aa756426e7c9c6496be4f60f35f5b6a09cd65b580,
            0x1f57963fa20b11863d2043784a3a18b2114fb88c1952b6678e50be94d0b80e06
        );
        pi_comms[1] = Bn256.Bn256AffinePoint(
            0x25a9384bbdb73227da1ddb26c8e7563efda3ed03561766e1ebdb0afa1b44ace2,
            0x2c167a83cd2abcef00126bd88f03047cbdcfab86eede65e27a26e0e022dfbe44
        );

        uint256[] memory R_x = new uint256[](3);
        R_x[0] = 0x0668744da4b2c836a526ef2fd7542a5235eb6641607226dc4abbc82b64575fc9;
        R_x[1] = 0x2fd7691f3ffbddb1d736d3383ba404ea1a1c0614d57dad97643851a51b834b5a;
        R_x[2] = 0x037fe8cabffa876afdeea56f06697e141a23180e57ec226273e196d574eb4b85;

        uint256[] memory pi_evals_0 = new uint256[](3);
        pi_evals_0[0] = 0x0c7736e33a1001b108e7a3ac40d072ed01af99ffb87fa2d5ed9750600253ad5a;
        pi_evals_0[1] = 0x124b64189008472130026f55b6ddc63268636603c10c966a74339d933c7261df;
        pi_evals_0[2] = 0x165b65c6cf5ed06ba20bd24fac16b88da1e9c5dd6901eec8ea888cd9cdda95e9;

        uint256[] memory pi_evals_1 = new uint256[](3);
        pi_evals_1[0] = 0x1143360fd32e3d1e6c28544694b073e1549863be33d5cf0bd7df1cfa187f0300;
        pi_evals_1[1] = 0x0eeef019ff0cc2b286f6daf143597325d803ab337fc1527a610746a912e7cbcc;
        pi_evals_1[2] = 0x1a08e8ac11d2cfbe16447366d56a9fcf864a226b10b781c8595968ba22256a8a;

        uint256[] memory pi_evals_2 = new uint256[](3);
        pi_evals_2[0] = 0x0137e8ed95aeb25bdd6f419220919937b9a20b304f5b811e84de9759dfdfa98c;
        pi_evals_2[1] = 0x1e2ee91698c880a7659a7a822645cdb89a9e88ede8e2a15c3557842cfae39a93;
        pi_evals_2[2] = 0x20a23f9e734d84352ef257f9ab6cdbb664f884c2414b38a5681237b6689d909c;

        uint256 p_of_x = 0x0000000000000000000000000000000000000000000000000000000000000039;

        uint256[] memory point = new uint256[](3);
        point[0] = 0x0000000000000000000000000000000000000000000000000000000000000004;
        point[1] = 0x0000000000000000000000000000000000000000000000000000000000000003;
        point[2] = 0x0000000000000000000000000000000000000000000000000000000000000008;

        Bn256.Bn256AffinePoint memory C = Bn256.Bn256AffinePoint(
            0x2217f0ebf964dd979d11a0ad218290dcd70cf9e82d7b20c779fc97e8328f8512,
            0x0dd40f5b93890e2d683b84c06ed37b0fb3982d83df771ab0e7593a930f6ff666
        );
        Bn256.Bn256AffinePoint memory C_Q = Bn256.Bn256AffinePoint(
            0x17fa7dd4c9f33daf159191c6286eb0feca19233f87a72b61a4fb67cf8125f1ac,
            0x210cf9d424ae9e2d49f513dfcf15d914fca1168518c72a1c28e5ac25ac311473
        );
        Bn256.Bn256AffinePoint memory C_H = Bn256.Bn256AffinePoint(
            0x1ad1228340addaff3338e1a3cbf13b12d06f6e1cdee371362d4f7e391a9e7016,
            0x1ec571fa0118a7bc56c260559d9b0b7a4ef65cd0be79450362744ca539e3b7ce
        );

        Bn256.Bn256AffinePoint memory vk_g = Bn256.Bn256AffinePoint(
            0x0fc4701ef297cf49eb0c93df917d8546a35f048f4250ef99fd0fdc50d1848acc,
            0x0e639233f85f7f00b4ad1c99f19236a8fb918ed9a052e86b7ca07575d478e500
        );

        Pairing.G2Point memory beta_h = Pairing.G2Point(
            [
                0x0bb659fbdbc9452452df8b156239350ac7111a21c815356dc1abfc1a5b9d9134,
                0x01c61ba933e55911edcd07161657ea81bbbe15ff3489d16268108ebee888b66b
            ],
            [
                0x009eb4def1cfcf0020557a0fb66341ea45959df5e262d5bfcdebbfa9ed35ca5a,
                0x0e3b956418672742a67e1c980f13e934d8e755af02f8c2fcb63e18ad6a6b6ab4
            ]
        );

        Pairing.G2Point memory h = Pairing.G2Point(
            [
                0x0bd636a3af7014b4d9b117242da8a2163a31e0fe77249cc5daa7e9ba0cb4fadb,
                0x2a14219918143cff7b915de597c9eb6d94fb18db74799a82d09c988f1dc2f67e
            ],
            [
                0x2bcfeeca3782c18f03413d57d31d9a0e02e8059ff5829befa14edcf9f4c1b6d4,
                0x2e0e806bfe80d792ee6c2ef78c11188db5f6b6d0f85bd46fa706316138f7fd0d
            ]
        );

        return HyperKzgInput(
            pi_comms, R_x, pi_evals_0, pi_evals_1, pi_evals_2, p_of_x, point, C, C_Q, C_H, vk_g, beta_h, h
        );
    }

    function testDebug() public {
        HyperKzgInput memory input = composeHyperKzgInput();

        KeccakTranscriptLib.KeccakTranscript memory transcript = getTranscript();

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
                // verification failed
                assert(false);
            }
        }

        if (!pi_polys_are_correct(input.pi_evals_0, input.pi_evals_1, input.pi_evals_2, input.point, r, input.p_of_x)) {
            // verification failed
            assert(false);
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

        assert(pairingCheckSuccessful(input, C_K, a));
    }

    function getTranscript() public pure returns (KeccakTranscriptLib.KeccakTranscript memory) {
        // b"TestEval" in Rust
        uint8[] memory label = new uint8[](8);
        label[0] = 0x54;
        label[1] = 0x65;
        label[2] = 0x73;
        label[3] = 0x74;
        label[4] = 0x45;
        label[5] = 0x76;
        label[6] = 0x61;
        label[7] = 0x6c;

        KeccakTranscriptLib.KeccakTranscript memory keccak_transcript = KeccakTranscriptLib.instantiate(label);
        return keccak_transcript;
    }
}
