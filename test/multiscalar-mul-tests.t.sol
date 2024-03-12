// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.16;

import "@std/Test.sol";
import "src/Utilities.sol";
import "src/blocks/grumpkin/Grumpkin.sol";

contract MultiscalarMulTest is Test {
    function testMSMUnoptimized() public {
        Grumpkin.GrumpkinAffinePoint[] memory bases = new Grumpkin.GrumpkinAffinePoint[](1);
        bases[0] = Grumpkin.GrumpkinAffinePoint(
            0x15afa1c1de43e186ee615ee76389d1ca9de572d426869ab062a03f1ba65808a2,
            0x28d6d43cb5ba89778111ceaa56cb8bf2c34a5fb6013988513d5798a60846d423
        );
        // bases[1] = Grumpkin.GrumpkinAffinePoint(
        //     0x132126b357d7299c5c18e04cbe13c4206b763dbc56a8d19900270cd0c59f3981,
        //     0x169077205c0ed8e9f2738a9f04d064e17c457a531a93e9ec5131e35d587cd381
        // );
        // bases[2] = Grumpkin.GrumpkinAffinePoint(
        //     0x20c9d6e3d55f0142ce09b6d1cd8b86c8eaecf8f204bce4c9b88a75c720e34b74,
        //     0x227f66a87a7649e8a76a2314e14c0c44877e1eca54015d5ecd8b1da08ccbb779
        // );
        // bases[3] = Grumpkin.GrumpkinAffinePoint(
        //     0x1300fe5112d72be0b65d1d365f294a136df15671e4f56e2fbf65be2ffec64e4f,
        //     0x0c93e3b91eeead0adf19f228e2a361b3b6055d1b89e699196c6a5550be5824b9
        // );
        // bases[4] = Grumpkin.GrumpkinAffinePoint(
        //     0x00561f915062be50a6f0b4966c812394f6209e305eaba304eb0442bd8658db3f,
        //     0x101fd2e6e6f14f80c5d5b851f75f377aa4a9fa70feee973acab6c085ba390b31
        // );
        // bases[5] = Grumpkin.GrumpkinAffinePoint(
        //     0x2c6ac455956eeab7124f2b7468d14731b082a76b33b30bfa5cd4286652646cc7,
        //     0x0c9f73a8296c89a7e4a85cc17920b2988a5f1fabb0738dfc2399b4c0bd5823f9
        // );
        // bases[6] = Grumpkin.GrumpkinAffinePoint(
        //     0x295a7a5268032eeabea8d38dbf482721c2d2eb96e9bc113225e6cc97bf931d1b,
        //     0x18eceee12552137b0d09e35056e944a618f8103cb408191edd8c5e9f92bae99c
        // );
        // bases[7] = Grumpkin.GrumpkinAffinePoint(
        //     0x1fb6c4c5970ecb51f1970e9b2a214ea88079d598df36d784140b7b81463eb90b,
        //     0x07bb64def7fed9c68d8542e22afad6995481615e7a7185cd695105b482d05180
        // );

        uint256[] memory scalars = new uint256[](1);
        scalars[0] = 0x1a8e54bfe01d0d0cb3f43427a4e4d17b5433c0da1fe2afdde034c1c1930f7f7d;
        // scalars[1] = 0x0a3ba18282db74f05d05e71329fa6c7a31b5b5ab5a1dc3ebace94d3863e48983;
        // scalars[2] = 0x073fe7f0c2a1b32d93f3cc1041c9fdb09e5f94be09e6a17b28ab1e3954e5a567;
        // scalars[3] = 0x1ed4bae9714e4e28fc63fdcc1b54b1f4ac8ec079aca2cca4b92b7e45d63b1395;
        // scalars[4] = 0x1cb0ba55ddf67148f5fa7a8ef3f9c8cafdfe56bea23b1d5a6253e0857e56ad82;
        // scalars[5] = 0x440d065f48ded1fe82dfffa571aa3875c0496b9821e0bff98c9a24e69065488a;
        // scalars[6] = 0x1b32544e236d677739086e7725aa4ae01f1a664092225af076a4fb72f1002e75;
        // scalars[7] = 0x5325e7f1c0e1bf320bc2649d3b5764d8795abcf137d8325b3fbf3198774085e1;

        Grumpkin.GrumpkinAffinePoint memory out = Grumpkin.multiScalarMul(bases, scalars);

        assertEq(bytes32(out.x), bytes32(0x14df709e5f2820818a45604d280f1a21088aeee4b37cbc7ba41a7fe9b2005c41));
        assertEq(bytes32(out.y), bytes32(0x1780bfb139af4e3905ab498d514d1cbbab9e0bc2839fdfdf18464ff857cb6b4c));
    }
}
