// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.16;

import "@std/Test.sol";
import "src/blocks/grumpkin/Zeromorph.sol";

contract ZeromorphContract is Test {
    function testPairingUsage() public {
        Pairing.G1Point memory g1_0 = Pairing.P1();
        Pairing.G2Point memory g2_0 = Pairing.P2();

        Pairing.G1Point memory g1_1 = Pairing.negate(Pairing.P1());
        Pairing.G2Point memory g2_1 = Pairing.P2();

        bool pairingResult = Pairing.pairingProd2(g1_0, g2_0, g1_1, g2_1);
        assert(pairingResult);
    }

    function testPairingUsage1() public {
        Pairing.G1Point memory g1_0 = Pairing.G1Point(
            Bn256.Bn256AffinePoint(
                0x1ef82c2035a3520826df5b73f4eaedde3d10e74b9b3352d275c1302588872491,
                0x28bbe15526b667c98b9a86bca8add2139e3abfc29d7dd99954373df54d5fbb94
            )
        );
        Pairing.G2Point memory g2_0 = Pairing.G2Point(
            [
                0x16fbf49184b341ac39c2c0f1c9341976eb37ec19f763bb8543dd91e54809620e,
                0x24f6c064992fc6fdd92f6730c24d56e42f840ee7c77255ce3f4abcb089de3e8e
            ],
            [
                0x1b75ad996f86347c6a801a67e4ce988ec59284a6cef9d5f23a8b80603a566e48,
                0x2b2d74b801ae862441d6b1165a533ad4c20561581804b12e47ed33e57e2e4a23
            ]
        );

        Pairing.G1Point memory g1_1 = Pairing.G1Point(
            Bn256.Bn256AffinePoint(
                0x285c6a90e2fd13fa96a64dd3739c6f5aef1478782a24aa2b50bb6473c8a79aa7,
                0x18ef959c6d5591cff24309eb2984297e1006b06cd25581a0f89ba339d6a374de
            )
        );
        Pairing.G2Point memory g2_1 = Pairing.G2Point(
            [
                0x17b98d85ad27b8b4cc04a8633429a33f4d7ba441e7b2e346b7933a3c5da96c4b,
                0x1c3193deda40efafb014ce3e27e900d08f0e983d0082ffb65307ae0b03c01f76
            ],
            [
                0x18fc2e0337d6d3dff3af7ec4a85cae08eb7cc5f06c0d4084ccde0abd216fe8fc,
                0x04a540891086ebc377fe94712e320b0d2eac0694d59b350e487147e9afd2a9c5
            ]
        );

        bool pairingResult = Pairing.pairingProd2(g1_0, g2_0, g1_1, g2_1);
        assert(pairingResult);
    }


}
