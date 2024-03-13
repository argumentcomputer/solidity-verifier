// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.16;

import "src/blocks/grumpkin/Grumpkin.sol";
import "src/blocks/KeccakTranscript.sol";

library InnerProductArgument {
    struct IpaInputGrumpkin {
        Grumpkin.GrumpkinAffinePoint[] ck_v;
        Grumpkin.GrumpkinAffinePoint[] ck_s;
        uint256[] point;
        uint256[] L_vec;
        uint256[] R_vec;
        Grumpkin.GrumpkinAffinePoint commitment;
        uint256 eval;
        uint256 a_hat;
    }

    struct InstanceGrumpkin {
        Grumpkin.GrumpkinAffinePoint comm_a_vec;
        uint256[] b_vec;
        uint256 c;
    }

    struct R {
        uint256[] r_vec;
        uint256[] r_vec_squared;
        uint256[] r_vec_inversed;
        uint256[] r_vec_inversed_squared;
    }

    struct P_hat_right_input {
        uint256 n;
        R r_vectors;
        Grumpkin.GrumpkinAffinePoint[] ck1;
        uint256[] b_vec;
        uint256 a_hat;
        Grumpkin.GrumpkinAffinePoint ck_c;
    }

    function batchInvert(uint256[] memory r_vec, uint256 modulus) private view returns (uint256[] memory) {
        uint256[] memory products = new uint256[](r_vec.length);
        uint256 acc = 1;
        uint256 index;
        for (index = 0; index < r_vec.length; index++) {
            products[index] = acc;
            acc = mulmod(acc, r_vec[index], modulus);
        }

        acc = Field.invert(acc, modulus);

        uint256[] memory inversed = new uint256[](r_vec.length);

        uint256 tmp;
        for (index = 0; index < r_vec.length; index++) {
            tmp = mulmod(acc, r_vec[r_vec.length - index - 1], modulus);
            inversed[r_vec.length - index - 1] = mulmod(products[r_vec.length - index - 1], acc, modulus);
            acc = tmp;
        }

        return inversed;
    }

    function compute_r_based_values(uint256[] memory r_vec, uint256 modulus) private view returns (R memory) {
        uint256[] memory r_vec_squared = new uint256[](r_vec.length);
        uint256 index;
        for (index = 0; index < r_vec.length; index++) {
            r_vec_squared[index] = mulmod(r_vec[index], r_vec[index], modulus);
        }

        uint256[] memory r_vec_inversed = batchInvert(r_vec, modulus);

        uint256[] memory r_vec_inversed_squared = new uint256[](r_vec.length);
        for (index = 0; index < r_vec.length; index++) {
            r_vec_inversed_squared[index] = mulmod(r_vec_inversed[index], r_vec_inversed[index], modulus);
        }
        return R(r_vec, r_vec_squared, r_vec_inversed, r_vec_inversed_squared);
    }

    function split_at(Grumpkin.GrumpkinAffinePoint[] memory ck, uint256 n)
        private
        pure
        returns (Grumpkin.GrumpkinAffinePoint[] memory, Grumpkin.GrumpkinAffinePoint[] memory)
    {
        require(n <= ck.length, "[split_at] unexpected n");

        Grumpkin.GrumpkinAffinePoint[] memory ck1 = new Grumpkin.GrumpkinAffinePoint[](n);
        Grumpkin.GrumpkinAffinePoint[] memory ck2 = new Grumpkin.GrumpkinAffinePoint[](n);
        uint256 ck_index = 0;
        for (uint256 i = 0; i < n; i++) {
            ck1[i] = ck[ck_index];
            ck_index++;
        }
        for (uint256 i = n; i < ck.length; i++) {
            ck2[i] = ck[ck_index];
            ck_index++;
        }

        return (ck1, ck2);
    }

    function scale(Grumpkin.GrumpkinAffinePoint[] memory ck_c, uint256 r)
        private
        view
        returns (Grumpkin.GrumpkinAffinePoint memory)
    {
        require(ck_c.length == 1, "[scale] unexpected ck_c");
        return Grumpkin.scalarMul(ck_c[0], r);
    }

    function inner_product_inner(uint256[] memory c) private pure returns (uint256[] memory) {
        if (c.length == 1) {
            return c;
        }
        uint256[] memory c_inner = new uint256[](c.length / 2);
        for (uint256 index = 0; index < c_inner.length; index++) {
            c_inner[index] = addmod(c[2 * index], c[2 * index + 1], Grumpkin.P_MOD);
        }
        return inner_product_inner(c_inner);
    }

    function inner_product(uint256[] memory a, uint256[] memory b) private pure returns (uint256) {
        require(a.length == b.length);
        uint256[] memory c = new uint256[](a.length);
        uint256 index;
        for (index = 0; index < a.length; index++) {
            c[index] = mulmod(a[index], b[index], Grumpkin.P_MOD);
        }

        c = inner_product_inner(c);
        return c[0];
    }

    function get_pos_value(uint256 i) private pure returns (uint256) {
        require(i >= 1, "[get_pos_value], i < 1");
        require(i <= 16, "[get_pos_value], i > 16");
        uint256[] memory result = new uint256[](16);
        result[0] = 0;
        result[1] = 1;
        result[2] = 1;
        result[3] = 2;
        result[4] = 2;
        result[5] = 2;
        result[6] = 2;
        result[7] = 3;
        result[8] = 3;
        result[9] = 3;
        result[10] = 3;
        result[11] = 3;
        result[12] = 3;
        result[13] = 3;
        result[14] = 3;
        result[15] = 4;
        return result[i - 1];
    }

    function compute_P_hat_right(P_hat_right_input memory input)
        private
        view
        returns (Grumpkin.GrumpkinAffinePoint memory)
    {
        uint256[] memory s = new uint256[](input.n);

        uint256 v = 1;
        uint256 index;
        for (index = 0; index < input.r_vectors.r_vec_inversed.length; index++) {
            v = mulmod(v, input.r_vectors.r_vec_inversed[index], Grumpkin.P_MOD);
        }
        s[0] = v;

        uint256 pos_in_r;
        uint256 r_square_length = input.r_vectors.r_vec_squared.length;
        for (index = 1; index < input.n; index++) {
            pos_in_r = get_pos_value(index);
            s[index] = mulmod(
                s[index - (1 << pos_in_r)],
                input.r_vectors.r_vec_squared[r_square_length - 1 - pos_in_r],
                Grumpkin.P_MOD
            );
        }

        uint256 b_hat = inner_product(input.b_vec, s);
        Grumpkin.GrumpkinAffinePoint memory ck_hat = Grumpkin.multiScalarMul(input.ck1, s);

        Grumpkin.GrumpkinAffinePoint[] memory bases = new Grumpkin.GrumpkinAffinePoint[](2);
        bases[0] = ck_hat;
        bases[1] = input.ck_c;

        uint256[] memory scalars = new uint256[](2);
        scalars[0] = input.a_hat;
        scalars[1] = mulmod(input.a_hat, b_hat, Grumpkin.P_MOD);

        return Grumpkin.multiScalarMul(bases, scalars);
    }

    function compute_P_hat_left(IpaInputGrumpkin memory input, R memory r_vec, Grumpkin.GrumpkinAffinePoint memory ck_c)
        private
        view
        returns (Grumpkin.GrumpkinAffinePoint memory)
    {
        Grumpkin.GrumpkinAffinePoint memory P = Grumpkin.add(input.commitment, Grumpkin.scalarMul(ck_c, input.eval));

        uint256 msm_len = input.L_vec.length + input.R_vec.length + 1;

        uint256 msm_index = 0;
        uint256[] memory scalars = new uint256[](msm_len);
        for (uint256 index = 0; index < r_vec.r_vec_squared.length; index++) {
            scalars[msm_index] = r_vec.r_vec_squared[index];
            msm_index++;
        }
        for (uint256 index = 0; index < r_vec.r_vec_inversed_squared.length; index++) {
            scalars[msm_index] = r_vec.r_vec_inversed_squared[index];
            msm_index++;
        }
        scalars[msm_index] = 0x01;

        msm_index = 0;
        Grumpkin.GrumpkinAffinePoint[] memory bases = new Grumpkin.GrumpkinAffinePoint[](msm_len);
        for (uint256 index = 0; index < input.L_vec.length; index++) {
            bases[msm_index] = Grumpkin.decompress(input.L_vec[index]);
            msm_index++;
        }
        for (uint256 index = 0; index < input.R_vec.length; index++) {
            bases[msm_index] = Grumpkin.decompress(input.R_vec[index]);
            msm_index++;
        }
        bases[msm_index] = P;

        return Grumpkin.multiScalarMul(bases, scalars);
    }

    function compute_P_hat_right(
        uint256 b_hat,
        uint256 a_hat,
        Grumpkin.GrumpkinAffinePoint memory ck_hat,
        Grumpkin.GrumpkinAffinePoint memory ck_c
    ) private view returns (Grumpkin.GrumpkinAffinePoint memory) {
        Grumpkin.GrumpkinAffinePoint[] memory bases = new Grumpkin.GrumpkinAffinePoint[](2);
        bases[0] = ck_hat;
        bases[1] = ck_c;

        uint256[] memory scalars = new uint256[](2);
        scalars[0] = a_hat;
        scalars[1] = mulmod(a_hat, b_hat, Grumpkin.P_MOD);

        return Grumpkin.multiScalarMul(bases, scalars);
    }

    function verifyGrumpkin(IpaInputGrumpkin memory input, KeccakTranscriptLib.KeccakTranscript memory transcript)
        public
        returns (bool)
    {
        uint256 n = 2 ** input.point.length;

        uint256[] memory b_vec = EqPolynomialLib.evals(input.point, Grumpkin.P_MOD, Grumpkin.negateBase);
        (Grumpkin.GrumpkinAffinePoint[] memory ck1,) = split_at(input.ck_v, b_vec.length);

        // b"IPA" in Rust
        uint8[] memory label = new uint8[](3);
        label[0] = 0x49;
        label[1] = 0x50;
        label[2] = 0x41;

        transcript = KeccakTranscriptLib.dom_sep(transcript, label);

        if (b_vec.length != n) {
            revert("NovaError::InvalidInputLength");
        }
        if (n != 1 << input.L_vec.length) {
            revert("NovaError::InvalidInputLength");
        }
        if (input.L_vec.length != input.R_vec.length) {
            revert("NovaError::InvalidInputLength");
        }
        if (input.L_vec.length >= 32) {
            revert("NovaError::InvalidInputLength");
        }

        // b"U" in Rust
        label = new uint8[](1);
        label[0] = 0x55;

        transcript =
            KeccakTranscriptLib.absorb(transcript, label, InstanceGrumpkin(input.commitment, b_vec, input.eval));

        // b"r" in Rust
        label = new uint8[](1);
        label[0] = 0x72;
        uint256 r;
        (transcript, r) = KeccakTranscriptLib.squeeze(transcript, ScalarFromUniformLib.curveGrumpkin(), label);

        uint256[] memory r_vec = new uint256[](input.L_vec.length);
        for (uint256 index = 0; index < r_vec.length; index++) {
            // b"L" in Rust
            label[0] = 0x4c;
            transcript = KeccakTranscriptLib.absorb(transcript, label, input.L_vec[index]);

            // b"R" in Rust
            label[0] = 0x52;
            transcript = KeccakTranscriptLib.absorb(transcript, label, input.R_vec[index]);

            // b"r" in Rust
            label[0] = 0x72;
            (transcript, r_vec[index]) =
                KeccakTranscriptLib.squeeze(transcript, ScalarFromUniformLib.curveGrumpkin(), label);
        }

        R memory r_vectors = compute_r_based_values(r_vec, Grumpkin.P_MOD);

        Grumpkin.GrumpkinAffinePoint memory ck_c = scale(input.ck_s, r);

        Grumpkin.GrumpkinAffinePoint memory P_hat_right =
            compute_P_hat_right(P_hat_right_input(n, r_vectors, ck1, b_vec, input.a_hat, ck_c));

        Grumpkin.GrumpkinAffinePoint memory P_hat_left = compute_P_hat_left(input, r_vectors, ck_c);

        if (P_hat_right.x != P_hat_left.x) {
            return false;
        }
        if (P_hat_right.y != P_hat_left.y) {
            return false;
        }

        return true;
    }
}
