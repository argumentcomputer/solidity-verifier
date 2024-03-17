// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.16;

import "@std/Test.sol";
import "src/Utilities.sol";
import "src/blocks/grumpkin/Grumpkin.sol";
import "src/blocks/grumpkin/Bn256.sol";

contract MultiscalarMulTest is Test {
    function testGetAt() public {
        uint256 c = 8;
        uint256 scalar = 0x15afa1c1de43e186ee615ee76389d1ca9de572d426869ab062a03f1ba65808a2;

        uint256 get1 = Grumpkin.getAt(0, c, scalar);
        assertEq(get1, 0xa2);
    }

    function testGrumpkin3Serial() public {
        Grumpkin.GrumpkinAffinePoint[] memory bases = new Grumpkin.GrumpkinAffinePoint[](8);
        bases[0] = Grumpkin.GrumpkinAffinePoint(
            0x15afa1c1de43e186ee615ee76389d1ca9de572d426869ab062a03f1ba65808a2,
            0x28d6d43cb5ba89778111ceaa56cb8bf2c34a5fb6013988513d5798a60846d423
        );
        bases[1] = Grumpkin.GrumpkinAffinePoint(
            0x132126b357d7299c5c18e04cbe13c4206b763dbc56a8d19900270cd0c59f3981,
            0x169077205c0ed8e9f2738a9f04d064e17c457a531a93e9ec5131e35d587cd381
        );
        bases[2] = Grumpkin.GrumpkinAffinePoint(
            0x20c9d6e3d55f0142ce09b6d1cd8b86c8eaecf8f204bce4c9b88a75c720e34b74,
            0x227f66a87a7649e8a76a2314e14c0c44877e1eca54015d5ecd8b1da08ccbb779
        );
        bases[3] = Grumpkin.GrumpkinAffinePoint(
            0x1300fe5112d72be0b65d1d365f294a136df15671e4f56e2fbf65be2ffec64e4f,
            0x0c93e3b91eeead0adf19f228e2a361b3b6055d1b89e699196c6a5550be5824b9
        );
        bases[4] = Grumpkin.GrumpkinAffinePoint(
            0x00561f915062be50a6f0b4966c812394f6209e305eaba304eb0442bd8658db3f,
            0x101fd2e6e6f14f80c5d5b851f75f377aa4a9fa70feee973acab6c085ba390b31
        );
        bases[5] = Grumpkin.GrumpkinAffinePoint(
            0x2c6ac455956eeab7124f2b7468d14731b082a76b33b30bfa5cd4286652646cc7,
            0x0c9f73a8296c89a7e4a85cc17920b2988a5f1fabb0738dfc2399b4c0bd5823f9
        );
        bases[6] = Grumpkin.GrumpkinAffinePoint(
            0x295a7a5268032eeabea8d38dbf482721c2d2eb96e9bc113225e6cc97bf931d1b,
            0x18eceee12552137b0d09e35056e944a618f8103cb408191edd8c5e9f92bae99c
        );
        bases[7] = Grumpkin.GrumpkinAffinePoint(
            0x1fb6c4c5970ecb51f1970e9b2a214ea88079d598df36d784140b7b81463eb90b,
            0x07bb64def7fed9c68d8542e22afad6995481615e7a7185cd695105b482d05180
        );

        uint256[] memory scalars = new uint256[](8);
        scalars[0] = 0x1a8e54bfe01d0d0cb3f43427a4e4d17b5433c0da1fe2afdde034c1c1930f7f7d;
        scalars[1] = 0x0a3ba18282db74f05d05e71329fa6c7a31b5b5ab5a1dc3ebace94d3863e48983;
        scalars[2] = 0x073fe7f0c2a1b32d93f3cc1041c9fdb09e5f94be09e6a17b28ab1e3954e5a567;
        scalars[3] = 0x1ed4bae9714e4e28fc63fdcc1b54b1f4ac8ec079aca2cca4b92b7e45d63b1395;
        scalars[4] = 0x1cb0ba55ddf67148f5fa7a8ef3f9c8cafdfe56bea23b1d5a6253e0857e56ad82;
        scalars[5] = 0x440d065f48ded1fe82dfffa571aa3875c0496b9821e0bff98c9a24e69065488a;
        scalars[6] = 0x1b32544e236d677739086e7725aa4ae01f1a664092225af076a4fb72f1002e75;
        scalars[7] = 0x5325e7f1c0e1bf320bc2649d3b5764d8795abcf137d8325b3fbf3198774085e1;

        Grumpkin.GrumpkinAffinePoint memory out = Grumpkin.multiScalarMulSerial(bases, scalars);

        assertEq(bytes32(out.x), bytes32(0x14df709e5f2820818a45604d280f1a21088aeee4b37cbc7ba41a7fe9b2005c41));
        assertEq(bytes32(out.y), bytes32(0x1780bfb139af4e3905ab498d514d1cbbab9e0bc2839fdfdf18464ff857cb6b4c));
    }

    function testGrumpkin3Unoptimized() public {
        Grumpkin.GrumpkinAffinePoint[] memory bases = new Grumpkin.GrumpkinAffinePoint[](8);
        bases[0] = Grumpkin.GrumpkinAffinePoint(
            0x15afa1c1de43e186ee615ee76389d1ca9de572d426869ab062a03f1ba65808a2,
            0x28d6d43cb5ba89778111ceaa56cb8bf2c34a5fb6013988513d5798a60846d423
        );
        bases[1] = Grumpkin.GrumpkinAffinePoint(
            0x132126b357d7299c5c18e04cbe13c4206b763dbc56a8d19900270cd0c59f3981,
            0x169077205c0ed8e9f2738a9f04d064e17c457a531a93e9ec5131e35d587cd381
        );
        bases[2] = Grumpkin.GrumpkinAffinePoint(
            0x20c9d6e3d55f0142ce09b6d1cd8b86c8eaecf8f204bce4c9b88a75c720e34b74,
            0x227f66a87a7649e8a76a2314e14c0c44877e1eca54015d5ecd8b1da08ccbb779
        );
        bases[3] = Grumpkin.GrumpkinAffinePoint(
            0x1300fe5112d72be0b65d1d365f294a136df15671e4f56e2fbf65be2ffec64e4f,
            0x0c93e3b91eeead0adf19f228e2a361b3b6055d1b89e699196c6a5550be5824b9
        );
        bases[4] = Grumpkin.GrumpkinAffinePoint(
            0x00561f915062be50a6f0b4966c812394f6209e305eaba304eb0442bd8658db3f,
            0x101fd2e6e6f14f80c5d5b851f75f377aa4a9fa70feee973acab6c085ba390b31
        );
        bases[5] = Grumpkin.GrumpkinAffinePoint(
            0x2c6ac455956eeab7124f2b7468d14731b082a76b33b30bfa5cd4286652646cc7,
            0x0c9f73a8296c89a7e4a85cc17920b2988a5f1fabb0738dfc2399b4c0bd5823f9
        );
        bases[6] = Grumpkin.GrumpkinAffinePoint(
            0x295a7a5268032eeabea8d38dbf482721c2d2eb96e9bc113225e6cc97bf931d1b,
            0x18eceee12552137b0d09e35056e944a618f8103cb408191edd8c5e9f92bae99c
        );
        bases[7] = Grumpkin.GrumpkinAffinePoint(
            0x1fb6c4c5970ecb51f1970e9b2a214ea88079d598df36d784140b7b81463eb90b,
            0x07bb64def7fed9c68d8542e22afad6995481615e7a7185cd695105b482d05180
        );

        uint256[] memory scalars = new uint256[](8);
        scalars[0] = 0x1a8e54bfe01d0d0cb3f43427a4e4d17b5433c0da1fe2afdde034c1c1930f7f7d;
        scalars[1] = 0x0a3ba18282db74f05d05e71329fa6c7a31b5b5ab5a1dc3ebace94d3863e48983;
        scalars[2] = 0x073fe7f0c2a1b32d93f3cc1041c9fdb09e5f94be09e6a17b28ab1e3954e5a567;
        scalars[3] = 0x1ed4bae9714e4e28fc63fdcc1b54b1f4ac8ec079aca2cca4b92b7e45d63b1395;
        scalars[4] = 0x1cb0ba55ddf67148f5fa7a8ef3f9c8cafdfe56bea23b1d5a6253e0857e56ad82;
        scalars[5] = 0x440d065f48ded1fe82dfffa571aa3875c0496b9821e0bff98c9a24e69065488a;
        scalars[6] = 0x1b32544e236d677739086e7725aa4ae01f1a664092225af076a4fb72f1002e75;
        scalars[7] = 0x5325e7f1c0e1bf320bc2649d3b5764d8795abcf137d8325b3fbf3198774085e1;

        Grumpkin.GrumpkinAffinePoint memory out = Grumpkin.multiScalarMul(bases, scalars);

        assertEq(bytes32(out.x), bytes32(0x14df709e5f2820818a45604d280f1a21088aeee4b37cbc7ba41a7fe9b2005c41));
        assertEq(bytes32(out.y), bytes32(0x1780bfb139af4e3905ab498d514d1cbbab9e0bc2839fdfdf18464ff857cb6b4c));
    }

    function testGrumpkin4Serial() public {
        Grumpkin.GrumpkinAffinePoint[] memory bases = new Grumpkin.GrumpkinAffinePoint[](16);
        bases[0] = Grumpkin.GrumpkinAffinePoint(
            0x15afa1c1de43e186ee615ee76389d1ca9de572d426869ab062a03f1ba65808a2,
            0x28d6d43cb5ba89778111ceaa56cb8bf2c34a5fb6013988513d5798a60846d423
        );
        bases[1] = Grumpkin.GrumpkinAffinePoint(
            0x132126b357d7299c5c18e04cbe13c4206b763dbc56a8d19900270cd0c59f3981,
            0x169077205c0ed8e9f2738a9f04d064e17c457a531a93e9ec5131e35d587cd381
        );
        bases[2] = Grumpkin.GrumpkinAffinePoint(
            0x20c9d6e3d55f0142ce09b6d1cd8b86c8eaecf8f204bce4c9b88a75c720e34b74,
            0x227f66a87a7649e8a76a2314e14c0c44877e1eca54015d5ecd8b1da08ccbb779
        );
        bases[3] = Grumpkin.GrumpkinAffinePoint(
            0x1300fe5112d72be0b65d1d365f294a136df15671e4f56e2fbf65be2ffec64e4f,
            0x0c93e3b91eeead0adf19f228e2a361b3b6055d1b89e699196c6a5550be5824b9
        );
        bases[4] = Grumpkin.GrumpkinAffinePoint(
            0x00561f915062be50a6f0b4966c812394f6209e305eaba304eb0442bd8658db3f,
            0x101fd2e6e6f14f80c5d5b851f75f377aa4a9fa70feee973acab6c085ba390b31
        );
        bases[5] = Grumpkin.GrumpkinAffinePoint(
            0x2c6ac455956eeab7124f2b7468d14731b082a76b33b30bfa5cd4286652646cc7,
            0x0c9f73a8296c89a7e4a85cc17920b2988a5f1fabb0738dfc2399b4c0bd5823f9
        );
        bases[6] = Grumpkin.GrumpkinAffinePoint(
            0x295a7a5268032eeabea8d38dbf482721c2d2eb96e9bc113225e6cc97bf931d1b,
            0x18eceee12552137b0d09e35056e944a618f8103cb408191edd8c5e9f92bae99c
        );
        bases[7] = Grumpkin.GrumpkinAffinePoint(
            0x1fb6c4c5970ecb51f1970e9b2a214ea88079d598df36d784140b7b81463eb90b,
            0x07bb64def7fed9c68d8542e22afad6995481615e7a7185cd695105b482d05180
        );
        bases[8] = Grumpkin.GrumpkinAffinePoint(
            0x06061711a72997d20766c7476e6f4617ff7b1192bbbf7f2847ea3b062a71864f,
            0x097bacb3366e0afcc82c97fc6614f1f856f4e52f23180213ba658e0e3ead1549
        );
        bases[9] = Grumpkin.GrumpkinAffinePoint(
            0x07914756c3369c74daf2ee5d2d0eda42f7eca51b4bc7aaa79805b4631adbe339,
            0x1542b7223764e174ea0e142bb21b553577857b056d7b39e9654e3b7e0135b212
        );
        bases[10] = Grumpkin.GrumpkinAffinePoint(
            0x18b4e44172503af59ffee81d9981d8e5110058298c9297f5e7cd01d98c945fcc,
            0x2f6ce4e56da558e99e815fd2045cfe34d830ee5a1b9b0581183a5abeb489002a
        );
        bases[11] = Grumpkin.GrumpkinAffinePoint(
            0x02eb377ea769967188a7b2d5e980c034f15039f05e72dc5576bb9d917fdc7efc,
            0x26e442de38bef9bedd39be263ec28c716205a7887e6140fefcce37cf158d140b
        );
        bases[12] = Grumpkin.GrumpkinAffinePoint(
            0x127bfea2cba218b61cfb9c40e91bdbd2fd3314fbe2fe8a9913d581c81ce5750a,
            0x1a054311afc5c9ad5fdcd8c4e4d7d2cd9290f6928c9c6e12198a9604adb13e70
        );
        bases[13] = Grumpkin.GrumpkinAffinePoint(
            0x00f7637be06d925289c2638b9820d7bf667224fa0a9b3a781a3fcb1622da33ad,
            0x18b2cc376f30b46d77bcc8157c7113d27a3230155f57d19802797fc70eb96bac
        );
        bases[14] = Grumpkin.GrumpkinAffinePoint(
            0x26f5439b107e0c669889de237f700f586392b01b37445833e34d951073f77c63,
            0x28396b0f70dcfde4914d39da9081a812bf9856cb9a52e81c5ba47476429df911
        );
        bases[15] = Grumpkin.GrumpkinAffinePoint(
            0x09eebd78de7ea21a772468f85e0876d795a60139b84fce47ced8d9a534d9487e,
            0x1010d482dd01a49532efd3964ecc4e8457f49931476fa136227a0ae255ad72b8
        );

        uint256[] memory scalars = new uint256[](16);
        scalars[0] = 0x1a8e54bfe01d0d0cb3f43427a4e4d17b5433c0da1fe2afdde034c1c1930f7f7d;
        scalars[1] = 0x0a3ba18282db74f05d05e71329fa6c7a31b5b5ab5a1dc3ebace94d3863e48983;
        scalars[2] = 0x073fe7f0c2a1b32d93f3cc1041c9fdb09e5f94be09e6a17b28ab1e3954e5a567;
        scalars[3] = 0x1ed4bae9714e4e28fc63fdcc1b54b1f4ac8ec079aca2cca4b92b7e45d63b1395;
        scalars[4] = 0x0af56c33c08199ec8350af7dcbf3da25a22d951ce7f21331c3637a99e92bf823;
        scalars[5] = 0x002f8404c582d244e3bb702303a9a9776b06de4304162737a3a54089b1b25950;
        scalars[6] = 0x231752522c40e9d937e4e53844571c74f79be0720a2e5e7b12277cb979a71f3c;
        scalars[7] = 0x18d2d4210a41ab4576da86e78c0aeb88ae30f01a1401d24623e5b50c2b3e0679;
        scalars[8] = 0x02b0c748e7f90109637ab48e83fd486ab71edde760c6c5e789c57caaeba61851;
        scalars[9] = 0x6f2d172124c7b08d3800a0a2597c229c345a2d6806ec79b1a099bb7572ad3a62;
        scalars[10] = 0x30013cbb437f5c51936df454f6df4d5bc872cbd6bd70f42fd388d1eba6d126cd;
        scalars[11] = 0x692db80ea0824441c76c843d3cac78b0131f95788da55345f656f5e77627d01e;
        scalars[12] = 0x50a44efc989119688f62b717193d48045ea489138c3a2045b7e39780bc9cb74b;
        scalars[13] = 0x263166685aa8e17335a49e3e27f0d7d3fa6e0dfb810d88980525f510dc2c84c8;
        scalars[14] = 0x0b7db88c9163f4415bc82ea1f5af599248d3e433d7b9660241c3bcfbdd9eb49d;
        scalars[15] = 0x18af7b0d3cbf3724815afc4c48b94d4b8436449831c280b091100b8df3188b3a;

        Grumpkin.GrumpkinAffinePoint memory out = Grumpkin.multiScalarMulSerial(bases, scalars);

        assertEq(bytes32(out.x), bytes32(0x1d7f6b43dcf51bc977e8ccbf52ca4b684b3e45eb4fd8a4e8db460dc0083b6de5));
        assertEq(bytes32(out.y), bytes32(0x1dd8577b2b2eec3c167344c48aaaa28f3496a55c71e04621ae228260c806e211));
    }

    function testGrumpkin4Unoptimized() public {
        Grumpkin.GrumpkinAffinePoint[] memory bases = new Grumpkin.GrumpkinAffinePoint[](16);
        bases[0] = Grumpkin.GrumpkinAffinePoint(
            0x15afa1c1de43e186ee615ee76389d1ca9de572d426869ab062a03f1ba65808a2,
            0x28d6d43cb5ba89778111ceaa56cb8bf2c34a5fb6013988513d5798a60846d423
        );
        bases[1] = Grumpkin.GrumpkinAffinePoint(
            0x132126b357d7299c5c18e04cbe13c4206b763dbc56a8d19900270cd0c59f3981,
            0x169077205c0ed8e9f2738a9f04d064e17c457a531a93e9ec5131e35d587cd381
        );
        bases[2] = Grumpkin.GrumpkinAffinePoint(
            0x20c9d6e3d55f0142ce09b6d1cd8b86c8eaecf8f204bce4c9b88a75c720e34b74,
            0x227f66a87a7649e8a76a2314e14c0c44877e1eca54015d5ecd8b1da08ccbb779
        );
        bases[3] = Grumpkin.GrumpkinAffinePoint(
            0x1300fe5112d72be0b65d1d365f294a136df15671e4f56e2fbf65be2ffec64e4f,
            0x0c93e3b91eeead0adf19f228e2a361b3b6055d1b89e699196c6a5550be5824b9
        );
        bases[4] = Grumpkin.GrumpkinAffinePoint(
            0x00561f915062be50a6f0b4966c812394f6209e305eaba304eb0442bd8658db3f,
            0x101fd2e6e6f14f80c5d5b851f75f377aa4a9fa70feee973acab6c085ba390b31
        );
        bases[5] = Grumpkin.GrumpkinAffinePoint(
            0x2c6ac455956eeab7124f2b7468d14731b082a76b33b30bfa5cd4286652646cc7,
            0x0c9f73a8296c89a7e4a85cc17920b2988a5f1fabb0738dfc2399b4c0bd5823f9
        );
        bases[6] = Grumpkin.GrumpkinAffinePoint(
            0x295a7a5268032eeabea8d38dbf482721c2d2eb96e9bc113225e6cc97bf931d1b,
            0x18eceee12552137b0d09e35056e944a618f8103cb408191edd8c5e9f92bae99c
        );
        bases[7] = Grumpkin.GrumpkinAffinePoint(
            0x1fb6c4c5970ecb51f1970e9b2a214ea88079d598df36d784140b7b81463eb90b,
            0x07bb64def7fed9c68d8542e22afad6995481615e7a7185cd695105b482d05180
        );
        bases[8] = Grumpkin.GrumpkinAffinePoint(
            0x06061711a72997d20766c7476e6f4617ff7b1192bbbf7f2847ea3b062a71864f,
            0x097bacb3366e0afcc82c97fc6614f1f856f4e52f23180213ba658e0e3ead1549
        );
        bases[9] = Grumpkin.GrumpkinAffinePoint(
            0x07914756c3369c74daf2ee5d2d0eda42f7eca51b4bc7aaa79805b4631adbe339,
            0x1542b7223764e174ea0e142bb21b553577857b056d7b39e9654e3b7e0135b212
        );
        bases[10] = Grumpkin.GrumpkinAffinePoint(
            0x18b4e44172503af59ffee81d9981d8e5110058298c9297f5e7cd01d98c945fcc,
            0x2f6ce4e56da558e99e815fd2045cfe34d830ee5a1b9b0581183a5abeb489002a
        );
        bases[11] = Grumpkin.GrumpkinAffinePoint(
            0x02eb377ea769967188a7b2d5e980c034f15039f05e72dc5576bb9d917fdc7efc,
            0x26e442de38bef9bedd39be263ec28c716205a7887e6140fefcce37cf158d140b
        );
        bases[12] = Grumpkin.GrumpkinAffinePoint(
            0x127bfea2cba218b61cfb9c40e91bdbd2fd3314fbe2fe8a9913d581c81ce5750a,
            0x1a054311afc5c9ad5fdcd8c4e4d7d2cd9290f6928c9c6e12198a9604adb13e70
        );
        bases[13] = Grumpkin.GrumpkinAffinePoint(
            0x00f7637be06d925289c2638b9820d7bf667224fa0a9b3a781a3fcb1622da33ad,
            0x18b2cc376f30b46d77bcc8157c7113d27a3230155f57d19802797fc70eb96bac
        );
        bases[14] = Grumpkin.GrumpkinAffinePoint(
            0x26f5439b107e0c669889de237f700f586392b01b37445833e34d951073f77c63,
            0x28396b0f70dcfde4914d39da9081a812bf9856cb9a52e81c5ba47476429df911
        );
        bases[15] = Grumpkin.GrumpkinAffinePoint(
            0x09eebd78de7ea21a772468f85e0876d795a60139b84fce47ced8d9a534d9487e,
            0x1010d482dd01a49532efd3964ecc4e8457f49931476fa136227a0ae255ad72b8
        );

        uint256[] memory scalars = new uint256[](16);
        scalars[0] = 0x1a8e54bfe01d0d0cb3f43427a4e4d17b5433c0da1fe2afdde034c1c1930f7f7d;
        scalars[1] = 0x0a3ba18282db74f05d05e71329fa6c7a31b5b5ab5a1dc3ebace94d3863e48983;
        scalars[2] = 0x073fe7f0c2a1b32d93f3cc1041c9fdb09e5f94be09e6a17b28ab1e3954e5a567;
        scalars[3] = 0x1ed4bae9714e4e28fc63fdcc1b54b1f4ac8ec079aca2cca4b92b7e45d63b1395;
        scalars[4] = 0x0af56c33c08199ec8350af7dcbf3da25a22d951ce7f21331c3637a99e92bf823;
        scalars[5] = 0x002f8404c582d244e3bb702303a9a9776b06de4304162737a3a54089b1b25950;
        scalars[6] = 0x231752522c40e9d937e4e53844571c74f79be0720a2e5e7b12277cb979a71f3c;
        scalars[7] = 0x18d2d4210a41ab4576da86e78c0aeb88ae30f01a1401d24623e5b50c2b3e0679;
        scalars[8] = 0x02b0c748e7f90109637ab48e83fd486ab71edde760c6c5e789c57caaeba61851;
        scalars[9] = 0x6f2d172124c7b08d3800a0a2597c229c345a2d6806ec79b1a099bb7572ad3a62;
        scalars[10] = 0x30013cbb437f5c51936df454f6df4d5bc872cbd6bd70f42fd388d1eba6d126cd;
        scalars[11] = 0x692db80ea0824441c76c843d3cac78b0131f95788da55345f656f5e77627d01e;
        scalars[12] = 0x50a44efc989119688f62b717193d48045ea489138c3a2045b7e39780bc9cb74b;
        scalars[13] = 0x263166685aa8e17335a49e3e27f0d7d3fa6e0dfb810d88980525f510dc2c84c8;
        scalars[14] = 0x0b7db88c9163f4415bc82ea1f5af599248d3e433d7b9660241c3bcfbdd9eb49d;
        scalars[15] = 0x18af7b0d3cbf3724815afc4c48b94d4b8436449831c280b091100b8df3188b3a;

        Grumpkin.GrumpkinAffinePoint memory out = Grumpkin.multiScalarMul(bases, scalars);

        assertEq(bytes32(out.x), bytes32(0x1d7f6b43dcf51bc977e8ccbf52ca4b684b3e45eb4fd8a4e8db460dc0083b6de5));
        assertEq(bytes32(out.y), bytes32(0x1dd8577b2b2eec3c167344c48aaaa28f3496a55c71e04621ae228260c806e211));
    }
}
