// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.16;

import "@std/Test.sol";
import "src/blocks/grumpkin/Grumpkin.sol";
import "src/blocks/EqPolynomial.sol";
import "src/Utilities.sol";
import "src/blocks/IpaPcs.sol";

contract IpaTest is Test {
    function composeIpaInput() public pure returns (InnerProductArgument.IpaInputGrumpkin memory) {
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
        return InnerProductArgument.IpaInputGrumpkin(ck_v, ck_s, point, L_vec, R_vec, commitment, eval, a_hat);
    }

    function testIpaGrumpkinVerification_2_Variables() public {
        InnerProductArgument.IpaInputGrumpkin memory input = composeIpaInput();
        assertTrue(InnerProductArgument.verifyGrumpkin(input, getTranscript()));
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
