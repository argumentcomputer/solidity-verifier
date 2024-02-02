// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.16;

import "@std/Test.sol";
import "src/blocks/grumpkin/Grumpkin.sol";
import "src/blocks/EqPolynomial.sol";
import "src/Utilities.sol";

// TODO:
// 1) Refactor and expose IPA as a library
// 2) Detect what is the max length of polynomial which can be supported without OutOfGas

contract IpaTest is Test {
    struct R {
        uint256[] r_vec;
        uint256[] r_vec_squared;
        uint256[] r_vec_inversed;
        uint256[] r_vec_inversed_squared;
    }

    function split_at(Grumpkin.GrumpkinAffinePoint[] memory ck, uint256 n)
        public
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
        public
        returns (Grumpkin.GrumpkinAffinePoint[] memory)
    {
        Grumpkin.GrumpkinAffinePoint[] memory scaled = new Grumpkin.GrumpkinAffinePoint[](ck_c.length);
        for (uint256 index = 0; index < ck_c.length; index++) {
            scaled[index] = Grumpkin.scalarMul(ck_c[index], r);
        }
        return scaled;
    }

    function batchInvert(uint256[] memory r_vec) public returns (uint256[] memory) {
        uint256[] memory products = new uint256[](r_vec.length);
        uint256 acc = 1;
        uint256 index;
        for (index = 0; index < r_vec.length; index++) {
            products[index] = acc;
            acc = mulmod(acc, r_vec[index], Grumpkin.P_MOD);
        }

        acc = Field.invert(acc, Grumpkin.P_MOD);

        uint256[] memory inversed = new uint256[](r_vec.length);

        uint256 tmp;
        for (index = 0; index < r_vec.length; index++) {
            tmp = mulmod(acc, r_vec[r_vec.length - index - 1], Grumpkin.P_MOD);
            inversed[r_vec.length - index - 1] = mulmod(products[r_vec.length - index - 1], acc, Grumpkin.P_MOD);
            acc = tmp;
        }

        return inversed;
    }

    function compute_P(
        Grumpkin.GrumpkinAffinePoint memory commitment,
        Grumpkin.GrumpkinAffinePoint[] memory ck_s,
        uint256 eval,
        uint256 r
    ) public returns (Grumpkin.GrumpkinAffinePoint memory) {
        Grumpkin.GrumpkinAffinePoint[] memory ck_s_scaled = scale(ck_s, r);
        return Grumpkin.add(commitment, Grumpkin.scalarMul(ck_s_scaled[0], eval));
    }

    function compute_r_based_values(
        Grumpkin.GrumpkinAffinePoint[] memory ck_s,
        uint256 eval,
        Grumpkin.GrumpkinAffinePoint[] memory L_vec,
        Grumpkin.GrumpkinAffinePoint memory commitment,
        uint256 r
    ) public returns (R memory) {
        /*
            // compute a vector of public coins using self.L_vec and self.R_vec
            let r = (0..self.L_vec.len())
                .map(|i| {
                    transcript.absorb(b"L", &self.L_vec[i]);
                    transcript.absorb(b"R", &self.R_vec[i]);
                    transcript.squeeze(b"r")
            })
            .collect::<Result<Vec<E::Scalar>, NovaError>>()?;
        */

        uint256[] memory r_vec = new uint256[](L_vec.length);
        r_vec[0] = 0x1a6d268ae789320863b0760561bf92cc5539e81239b97cea90542b5163cdd1c7;
        r_vec[1] = 0x0fa5b3f5911542c0976b82385f398e58e7fadf188c80638c541697005a97ab6d;

        uint256[] memory r_vec_squared = new uint256[](L_vec.length);

        uint256 index;
        for (index = 0; index < r_vec.length; index++) {
            r_vec_squared[index] = mulmod(r_vec[index], r_vec[index], Grumpkin.P_MOD);
        }

        uint256[] memory r_vec_inversed = batchInvert(r_vec);

        uint256[] memory r_vec_inversed_squared = new uint256[](L_vec.length);
        for (index = 0; index < r_vec.length; index++) {
            r_vec_inversed_squared[index] = mulmod(r_vec_inversed[index], r_vec_inversed[index], Grumpkin.P_MOD);
        }
        return R (r_vec, r_vec_squared, r_vec_inversed, r_vec_inversed_squared);
    }

    function get_pos_value(uint256 i) public pure returns (uint256) {
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

    function compute_s(uint256 n, uint256[] memory r_inverse, uint256[] memory r_square, uint256 L_vec_len)
        public
        returns (uint256[] memory)
    {
        uint256[] memory s = new uint256[](n);

        uint256 v = 1;
        uint256 index;
        for (index = 0; index < r_inverse.length; index++) {
            v = mulmod(v, r_inverse[index], Grumpkin.P_MOD);
        }
        s[0] = v;

        uint256 pos_in_r;
        for (index = 1; index < n; index++) {
            pos_in_r = get_pos_value(index);
            s[index] = mulmod(s[index - (1 << pos_in_r)], r_square[L_vec_len - 1 - pos_in_r], Grumpkin.P_MOD);
        }

        return s;
    }

    function inner_product_inner(uint256[] memory c) public returns (uint256[] memory) {
        if (c.length == 1) {
            return c;
        }
        uint256[] memory c_inner = new uint256[](c.length / 2);
        for (uint256 index = 0; index < c_inner.length; index++) {
            c_inner[index] = addmod(c[2 * index], c[2 * index + 1], Grumpkin.P_MOD);
        }
        return inner_product_inner(c_inner);
    }

    function inner_product(uint256[] memory a, uint256[] memory b) public returns (uint256) {
        require(a.length == b.length);
        uint256[] memory c = new uint256[](a.length);
        uint256 index;
        for (index = 0; index < a.length; index++) {
            c[index] = mulmod(a[index], b[index], Grumpkin.P_MOD);
        }

        c = inner_product_inner(c);
        return c[0];
    }

    function compute_P_hat_left(
        Grumpkin.GrumpkinAffinePoint[] memory L_vec,
        Grumpkin.GrumpkinAffinePoint[] memory R_vec,
        Grumpkin.GrumpkinAffinePoint memory P,
        R memory r_vec
    ) public returns (Grumpkin.GrumpkinAffinePoint memory){
        uint256 msm_len = L_vec.length + R_vec.length + 1;

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
        for (uint256 index = 0; index < L_vec.length; index++) {
            bases[msm_index] = L_vec[index];
            msm_index++;
        }
        for (uint256 index = 0; index < R_vec.length; index++) {
            bases[msm_index] = R_vec[index];
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
    ) public returns (Grumpkin.GrumpkinAffinePoint memory){
        Grumpkin.GrumpkinAffinePoint[] memory bases = new Grumpkin.GrumpkinAffinePoint[](2);
        bases[0] = ck_hat;
        bases[1] = ck_c;

        uint256[] memory scalars = new uint256[](2);
        scalars[0] = a_hat;
        scalars[1] = mulmod(a_hat, b_hat, Grumpkin.P_MOD);

        return Grumpkin.multiScalarMul(bases, scalars);
    }

    function ipa_computations_inner(
        uint256 n,
        Grumpkin.GrumpkinAffinePoint memory commitment,
        Grumpkin.GrumpkinAffinePoint[] memory ck_s,
        uint256 eval,
        Grumpkin.GrumpkinAffinePoint[] memory L_vec,
        Grumpkin.GrumpkinAffinePoint[] memory ck1,
        uint256[] memory b_vec,
        uint256 r
    ) public returns (R memory, uint256, Grumpkin.GrumpkinAffinePoint memory){

        R memory r_vectors = compute_r_based_values(ck_s, eval, L_vec, commitment, r);

        uint256[] memory s = compute_s(n, r_vectors.r_vec_inversed, r_vectors.r_vec_squared, L_vec.length);

        Grumpkin.GrumpkinAffinePoint memory ck_hat = Grumpkin.multiScalarMul(ck1, s);

        uint256 b_hat = inner_product(b_vec, s);

        return (r_vectors, b_hat, ck_hat);
    }

    struct IpaInput{
        Grumpkin.GrumpkinAffinePoint[] ck_v;
        Grumpkin.GrumpkinAffinePoint[] ck_s;
        uint256[] point;
        Grumpkin.GrumpkinAffinePoint[] L_vec;
        Grumpkin.GrumpkinAffinePoint[] R_vec;
        Grumpkin.GrumpkinAffinePoint commitment;
        uint256 eval;
        uint256 a_hat;
    }


    function ipa_computations(
        IpaInput memory input
    ) public {
        uint256 n = 2 ** input.point.length;

        uint256[] memory b_vec = EqPolynomialLib.evals(input.point, Grumpkin.P_MOD, Grumpkin.negateBase);
        (Grumpkin.GrumpkinAffinePoint[] memory ck1,) = split_at(input.ck_v, b_vec.length);

        // transcript.dom_sep(Self::protocol_name());

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

        //transcript.absorb(b"U", U);
        //let r = transcript.squeeze(b"r")?;

        uint256 r = 0x26dbed0c0b99929de85b3c8d4c501f5216b0c3fa951b92afb75b6044c7b6885d;

        (R memory r_vectors, uint256 b_hat, Grumpkin.GrumpkinAffinePoint memory ck_hat) = ipa_computations_inner(n, input.commitment, input.ck_s, input.eval, input.L_vec, ck1, b_vec, r);

        Grumpkin.GrumpkinAffinePoint memory P = compute_P(input.commitment, input.ck_s, input.eval, r);

        Grumpkin.GrumpkinAffinePoint memory P_hat_left = compute_P_hat_left(input.L_vec, input.R_vec, P, r_vectors);

        Grumpkin.GrumpkinAffinePoint[] memory ck_c = scale(input.ck_s, r);

        Grumpkin.GrumpkinAffinePoint memory P_hat_right = compute_P_hat_right(b_hat, input.a_hat, ck_hat, ck_c[0]);

        assertEq(P_hat_left.x, P_hat_right.x);
        assertEq(P_hat_left.y, P_hat_right.y);
    }

    function testDebug() public {
        Grumpkin.GrumpkinAffinePoint[] memory ck_v = new Grumpkin.GrumpkinAffinePoint[](4);
        ck_v[0] = Grumpkin.GrumpkinAffinePoint(
            0x15afa1c1de43e186ee615ee76389d1ca9de572d426869ab062a03f1ba65808a2,
            0x28d6d43cb5ba89778111ceaa56cb8bf2c34a5fb6013988513d5798a60846d423
        );
        ck_v[1] = Grumpkin.GrumpkinAffinePoint(
            0x132126b357d7299c5c18e04cbe13c4206b763dbc56a8d19900270cd0c59f3981,
            0x169077205c0ed8e9f2738a9f04d064e17c457a531a93e9ec5131e35d587cd381
        );
        ck_v[2] = Grumpkin.GrumpkinAffinePoint(
            0x20c9d6e3d55f0142ce09b6d1cd8b86c8eaecf8f204bce4c9b88a75c720e34b74,
            0x227f66a87a7649e8a76a2314e14c0c44877e1eca54015d5ecd8b1da08ccbb779
        );
        ck_v[3] = Grumpkin.GrumpkinAffinePoint(
            0x1300fe5112d72be0b65d1d365f294a136df15671e4f56e2fbf65be2ffec64e4f,
            0x0c93e3b91eeead0adf19f228e2a361b3b6055d1b89e699196c6a5550be5824b9
        );

        Grumpkin.GrumpkinAffinePoint[] memory ck_s = new Grumpkin.GrumpkinAffinePoint[](1);
        ck_s[0] = Grumpkin.GrumpkinAffinePoint(
            0x2e8facd7beb3da0e505fa1e33ee77b0b19fa1dfc1c5e04537cda07bf56cc248b,
            0x11a32df7bf180b18e526371ee2e21bb42ee2d9a7ac875f0816be6effda4e3dfb
        );

        uint256[] memory point = new uint256[](2);
        point[0] = 0x1fe29a0b699fa3cbc723126c4ad0e4a5f410c5f699f3599e92c4f0e99c1abd97;
        point[1] = 0x0ed4861fc966ff194c23744c2e6f63139211dc3550a28a9c8e0979427ff9c677;

        Grumpkin.GrumpkinAffinePoint[] memory L_vec = new Grumpkin.GrumpkinAffinePoint[](2);
        L_vec[0] = Grumpkin.GrumpkinAffinePoint(
            0x1aedd46eb53cfded07f7c3710015340b8cb21983fe71d24f0e7d9f5ab4854e2d,
            0x06d42154bbf58e193faa5443312aa938c3fc88648f1a0912d890ea1f7edc3ade
        );
        L_vec[1] = Grumpkin.GrumpkinAffinePoint(
            0x1c95cbc06044e13eca63f164a8d2dbd3bfc7ed470dd244154e2ae5f83592b649,
            0x0abde1d3428cfe8b21442f486b010f14042f5d84b54a811d06307104c4755a2c
        );

        Grumpkin.GrumpkinAffinePoint[] memory R_vec = new Grumpkin.GrumpkinAffinePoint[](2);
        R_vec[0] = Grumpkin.GrumpkinAffinePoint(
            0x2f1727ea1ac3c3862caa797261db6a9b0714f7d8e65adb97e5f4da457044ccfe,
            0x185e59b83d3e903a804f6dcfd68a3e34b5cb9d048aca562e7e89c77b5c7db13e
        );
        R_vec[1] = Grumpkin.GrumpkinAffinePoint(
            0x08adac48b78bbb3435da3efc7162332b5693f5db927e184c0d1faaeaaf60fdbd,
            0x1770ed9ec1f5ed7815a86ec6a5acc1b66d6c89d9bbbb53a2663ce292f7fe48b0
        );

        uint256 a_hat = 0x144237bc694bfa4f625dab1f8bfc854e3e7b9a612027e16bcd840383d088e190;

        // InnerProductInstance
        Grumpkin.GrumpkinAffinePoint memory commitment = Grumpkin.GrumpkinAffinePoint(
            0x1e7268591a2b38be3ff689fe1eb31600f9161a2163a08ee9842d458ac0bddf05,
            0x1f3070c0592c3f0135e1aba5100d43785490023f9536025b119bf9c0f96d5281
        );
        uint256 eval = 0x2514662a7e8e9a7a4ab7ea7c8e6a3423e7a47fca5105e6f3264d20d88e6d33bf;

        ipa_computations(IpaInput(ck_v, ck_s, point, L_vec, R_vec, commitment, eval, a_hat));
    }
}
