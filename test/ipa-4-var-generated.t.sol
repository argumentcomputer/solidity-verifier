// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.16;

import "@std/Test.sol";
import "src/blocks/grumpkin/Grumpkin.sol";
import "src/blocks/EqPolynomial.sol";
import "src/Utilities.sol";
import "src/blocks/IpaPcs.sol";

contract IpaTest is Test {
    function composeIpaInput() public pure returns (InnerProductArgument.IpaInputGrumpkin memory) {
        Grumpkin.GrumpkinAffinePoint[] memory ck_v = new Grumpkin.GrumpkinAffinePoint[](16);
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
        ck_v[4] = Grumpkin.GrumpkinAffinePoint(
            0x00561f915062be50a6f0b4966c812394f6209e305eaba304eb0442bd8658db3f,
            0x101fd2e6e6f14f80c5d5b851f75f377aa4a9fa70feee973acab6c085ba390b31
        );
        ck_v[5] = Grumpkin.GrumpkinAffinePoint(
            0x2c6ac455956eeab7124f2b7468d14731b082a76b33b30bfa5cd4286652646cc7,
            0x0c9f73a8296c89a7e4a85cc17920b2988a5f1fabb0738dfc2399b4c0bd5823f9
        );
        ck_v[6] = Grumpkin.GrumpkinAffinePoint(
            0x295a7a5268032eeabea8d38dbf482721c2d2eb96e9bc113225e6cc97bf931d1b,
            0x18eceee12552137b0d09e35056e944a618f8103cb408191edd8c5e9f92bae99c
        );
        ck_v[7] = Grumpkin.GrumpkinAffinePoint(
            0x1fb6c4c5970ecb51f1970e9b2a214ea88079d598df36d784140b7b81463eb90b,
            0x07bb64def7fed9c68d8542e22afad6995481615e7a7185cd695105b482d05180
        );
        ck_v[8] = Grumpkin.GrumpkinAffinePoint(
            0x06061711a72997d20766c7476e6f4617ff7b1192bbbf7f2847ea3b062a71864f,
            0x097bacb3366e0afcc82c97fc6614f1f856f4e52f23180213ba658e0e3ead1549
        );
        ck_v[9] = Grumpkin.GrumpkinAffinePoint(
            0x07914756c3369c74daf2ee5d2d0eda42f7eca51b4bc7aaa79805b4631adbe339,
            0x1542b7223764e174ea0e142bb21b553577857b056d7b39e9654e3b7e0135b212
        );
        ck_v[10] = Grumpkin.GrumpkinAffinePoint(
            0x18b4e44172503af59ffee81d9981d8e5110058298c9297f5e7cd01d98c945fcc,
            0x2f6ce4e56da558e99e815fd2045cfe34d830ee5a1b9b0581183a5abeb489002a
        );
        ck_v[11] = Grumpkin.GrumpkinAffinePoint(
            0x02eb377ea769967188a7b2d5e980c034f15039f05e72dc5576bb9d917fdc7efc,
            0x26e442de38bef9bedd39be263ec28c716205a7887e6140fefcce37cf158d140b
        );
        ck_v[12] = Grumpkin.GrumpkinAffinePoint(
            0x127bfea2cba218b61cfb9c40e91bdbd2fd3314fbe2fe8a9913d581c81ce5750a,
            0x1a054311afc5c9ad5fdcd8c4e4d7d2cd9290f6928c9c6e12198a9604adb13e70
        );
        ck_v[13] = Grumpkin.GrumpkinAffinePoint(
            0x00f7637be06d925289c2638b9820d7bf667224fa0a9b3a781a3fcb1622da33ad,
            0x18b2cc376f30b46d77bcc8157c7113d27a3230155f57d19802797fc70eb96bac
        );
        ck_v[14] = Grumpkin.GrumpkinAffinePoint(
            0x26f5439b107e0c669889de237f700f586392b01b37445833e34d951073f77c63,
            0x28396b0f70dcfde4914d39da9081a812bf9856cb9a52e81c5ba47476429df911
        );
        ck_v[15] = Grumpkin.GrumpkinAffinePoint(
            0x09eebd78de7ea21a772468f85e0876d795a60139b84fce47ced8d9a534d9487e,
            0x1010d482dd01a49532efd3964ecc4e8457f49931476fa136227a0ae255ad72b8
        );

        Grumpkin.GrumpkinAffinePoint[] memory ck_s = new Grumpkin.GrumpkinAffinePoint[](1);
        ck_s[0] = Grumpkin.GrumpkinAffinePoint(
            0x2e8facd7beb3da0e505fa1e33ee77b0b19fa1dfc1c5e04537cda07bf56cc248b,
            0x11a32df7bf180b18e526371ee2e21bb42ee2d9a7ac875f0816be6effda4e3dfb
        );

        uint256[] memory point = new uint256[](4);
        point[0] = 0x0af56c33c08199ec8350af7dcbf3da25a22d951ce7f21331c3637a99e92bf823;
        point[1] = 0x002f8404c582d244e3bb702303a9a9776b06de4304162737a3a54089b1b25950;
        point[2] = 0x231752522c40e9d937e4e53844571c74f79be0720a2e5e7b12277cb979a71f3c;
        point[3] = 0x18d2d4210a41ab4576da86e78c0aeb88ae30f01a1401d24623e5b50c2b3e0679;

        uint256[] memory L_vec = new uint256[](4);
        L_vec[0] = 0x02b0c748e7f90109637ab48e83fd486ab71edde760c6c5e789c57caaeba61851;
        L_vec[1] = 0x6f2d172124c7b08d3800a0a2597c229c345a2d6806ec79b1a099bb7572ad3a62;
        L_vec[2] = 0x30013cbb437f5c51936df454f6df4d5bc872cbd6bd70f42fd388d1eba6d126cd;
        L_vec[3] = 0x692db80ea0824441c76c843d3cac78b0131f95788da55345f656f5e77627d01e;

        uint256[] memory R_vec = new uint256[](4);
        R_vec[0] = 0x50a44efc989119688f62b717193d48045ea489138c3a2045b7e39780bc9cb74b;
        R_vec[1] = 0x263166685aa8e17335a49e3e27f0d7d3fa6e0dfb810d88980525f510dc2c84c8;
        R_vec[2] = 0x0b7db88c9163f4415bc82ea1f5af599248d3e433d7b9660241c3bcfbdd9eb49d;
        R_vec[3] = 0x18af7b0d3cbf3724815afc4c48b94d4b8436449831c280b091100b8df3188b3a;

        uint256 a_hat = 0x04e14e04cc1a6b1cbf740a2c52e8ab51e9fe90dbb51d8ff3afe43ec33d67c2cb;

        // InnerProductInstance
        Grumpkin.GrumpkinAffinePoint memory commitment = Grumpkin.GrumpkinAffinePoint(
            0x1a4d71952082e4e8d1e83dcf7fc6b9243751395217e7d0a5cb39ac7b7673952d,
            0x0bb59f09fbab84fa5cf4084a280efbbeecbd8ffbd1c146e972b4506ca6af7950
        );

        uint256 eval = 0x14249465fd50ffbc1ca77b7d091356a0c9b04324eb05148a95ce993febacd78e;

        return InnerProductArgument.IpaInputGrumpkin(ck_v, ck_s, point, L_vec, R_vec, commitment, eval, a_hat);
    }

    function testIpaGrumpkinVerification_4_Variables() public {
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
