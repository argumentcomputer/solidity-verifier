// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.16;

import "@std/Test.sol";
import "src/blocks/grumpkin/Bn256.sol";
import "src/blocks/ZeromorphEngine.sol";
import "src/blocks/KeccakTranscript.sol";

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

    function testZeromorphPairingCheck() public {
        Pairing.G1Point memory c = Pairing.G1Point(
            Bn256.Bn256AffinePoint(
                0x24ebd48a50a76a41179922f9f45530d5c4dfb0275aa13d63c097b825104755e0,
                0x11d28e911785f1457ce030d2614f164a24bd6ccd1ed4d691266de871565daa12
            )
        );
        Pairing.G2Point memory minus_vk_s_offset = Pairing.G2Point(
            [
                0x106118a6555b5312b682535cb0137bc741420a2d19b2d438a79987d6e0940dcf,
                0x1430436e84dad0d644cb63e36045e5461312628782c6518f5a52fc2309a2826a
            ],
            [
                0x19269aa57e4639ea1860c75447e32986cc801678c462d4022abeb3a0b819236d,
                0x193f8b6d53e03bc5346d50a964d162cc0c9c1a108e1d29889107c79a61d9119d
            ]
        );

        Pairing.G1Point memory pi = Pairing.G1Point(
            Bn256.Bn256AffinePoint(
                0x2e923a37c616ddeb8b00a0236fd2a7199fb5aac0770f1a6c28aee8a5f8a2e76f,
                0x053c913a0ad8229df46d46c781642b150bb26bd4ce09ca59221cec3e2e602345
            )
        );
        Pairing.G2Point memory vk_vp_beta_h_minus_vk_vp_h_mul_x = Pairing.G2Point(
            [
                0x1cebf2bc8578b525a75df7ba7c90fe3e1bb7fa2c469abd3ac2d198d03d0f2af1,
                0x098fc98ab46750514243738445fad4fcb50197d9f56046c3657c53042fd60848
            ],
            [
                0x1803b97f63e2edafad0362fe3ed141b11caebe33168c091d00ddd986923b0623,
                0x0272386e92d10d82e55285b0e86ef36b0f8a13c9692ca0f9a7d3d3994c1da411
            ]
        );

        assert(Zeromorph.runPairingCheck(c, minus_vk_s_offset, pi, vk_vp_beta_h_minus_vk_vp_h_mul_x));
    }

    function testComputeC() public {
        Bn256.Bn256AffinePoint[] memory bases = new Bn256.Bn256AffinePoint[](6);
        bases[0] = Bn256.Bn256AffinePoint(
            0x0f206674cce3d14b6756a69c4b0e6974baa1ca62e3493df0f6c9077b5592a80f,
            0x0fbb22d476b8d2ba5f43721031b7e1454fa8a400e97e08cdd0c4bde209e4ebe4
        );
        bases[1] = Bn256.Bn256AffinePoint(
            0x1132b8f12f58a64fbaf709f75bdb1e54550b800d8d0aeb70676640c9ab047807,
            0x03fe1f8892dfa544ddb7899a394f736b2b4206f6eb85fd28363e51e80e3ce928
        );
        bases[2] = Bn256.Bn256AffinePoint(
            0x0c5335cd6eef344df1c7987362cdea67642eeb5200b61df396a0efc91ebd9f65,
            0x17df746a603c81d14ad1c9ab50e5066bd90b75631e957fd5ddae835c4d2bb481
        );
        bases[3] = Bn256.Bn256AffinePoint(
            0x032568dd9940089358fd8c9c398c319a0afd0517a32a4aa67a721404ea0e4941,
            0x0fbaab8eb8d76b55e83b1bebf523b3453cd4a227c1b0167caf6fcfbb21fd5e62
        );
        bases[4] = Bn256.Bn256AffinePoint(
            0x14d549da2d6ac76663d9845faa33cdec2abd4bb1eacf321907fdeaef7bfd40bb,
            0x108a3d48b45aa4dcbb90d49d8c433c4ad09c78809fd70c9f5b7c3bdd749b5c15
        );
        bases[5] = Bn256.Bn256AffinePoint(
            0x0a4390fc88227c8c8a12c28b9535db799af165c7addfa4a11c44a58b24f333f7,
            0x10636457d381ce1eb67db2e16f486b7139bfa6af2e5121115dd28a8fb52b4f4b
        );

        uint256[] memory scalars = new uint256[](6);
        scalars[0] = 0x0000000000000000000000000000000000000000000000000000000000000001;
        scalars[1] = 0x1c5002f8d69058e9878a3fd49c1a0a908b8eacc3f7a9a37515ce765df4087b84;
        scalars[2] = 0x2a8416815dedd0ce9d6f3d5f7f9b148c738b047a75268f7102098f55cb13d13b;
        scalars[3] = 0x04b26c6892f5a4bf0e5c827d831ce8fa0231dc77dd8925eb92cb029ad4d6a108;
        scalars[4] = 0x14e0287e1f778c161a11825982fd4800f86da9da41ece78e8d4534526e43896d;
        scalars[5] = 0x2dc37bdc9700b7c0e42f8e1630213cda5a5a4bc104d1e5e217600ec18d72fa1d;

        Bn256.Bn256AffinePoint memory c = Bn256.multiScalarMul(bases, scalars);
        assertEq(c.x, 0x24ebd48a50a76a41179922f9f45530d5c4dfb0275aa13d63c097b825104755e0);
        assertEq(c.y, 0x11d28e911785f1457ce030d2614f164a24bd6ccd1ed4d691266de871565daa12);
    }

    function test_compose_scalars() public {
        uint256 eval_scalar = 0x19cb8436c667bce0ca81531a9d6df3853534d938b8d55cd5207a804e0494a152;
        uint256[] memory q_scalars = new uint256[](3);
        q_scalars[0] = 0x04b26c6892f5a4bf0e5c827d831ce8fa0231dc77dd8925eb92cb029ad4d6a108;
        q_scalars[1] = 0x14e0287e1f778c161a11825982fd4800f86da9da41ece78e8d4534526e43896d;
        q_scalars[2] = 0x2dc37bdc9700b7c0e42f8e1630213cda5a5a4bc104d1e5e217600ec18d72fa1d;

        uint256 z = 0x1c5002f8d69058e9878a3fd49c1a0a908b8eacc3f7a9a37515ce765df4087b84;
        uint256 zm_evaluation = 0x120ac1a0d37696b7612fd0bbc91bd56ef277ae116a29139adb6c895e2193c7d9;

        uint256[] memory scalars = Zeromorph.compose_scalars(eval_scalar, Field.reverse256(z), zm_evaluation, q_scalars);
        assertEq(scalars[0], 1);
        assertEq(scalars[1], 0x1c5002f8d69058e9878a3fd49c1a0a908b8eacc3f7a9a37515ce765df4087b84);
        assertEq(scalars[2], 0x2a8416815dedd0ce9d6f3d5f7f9b148c738b047a75268f7102098f55cb13d13b);
        assertEq(scalars[3], 0x04b26c6892f5a4bf0e5c827d831ce8fa0231dc77dd8925eb92cb029ad4d6a108);
        assertEq(scalars[4], 0x14e0287e1f778c161a11825982fd4800f86da9da41ece78e8d4534526e43896d);
        assertEq(scalars[5], 0x2dc37bdc9700b7c0e42f8e1630213cda5a5a4bc104d1e5e217600ec18d72fa1d);
    }

    function test_compute_eval_scalar_q_scalars() public {
        uint256 x = 0x1bbe88b6514053ba1a2e352dc3ef41e3a3b446b26b07408f1020116508d3185d;
        uint256 y = 0x0d1f03b1b327f07237088a4b7439fd2f4a2237f8345a487944031651659d59f0;
        uint256 z = 0x1c5002f8d69058e9878a3fd49c1a0a908b8eacc3f7a9a37515ce765df4087b84;
        uint256[] memory point = new uint256[](3);
        point[0] = 0x118c24bce71a6e7d10c4d7fb71b107ae49503282c2dd2fada2e6949de728b87d;
        point[1] = 0x10768d7096b0235e0f169e88cacbb3180d81088a8bc3a98120f4a02f4dee43ce;
        point[2] = 0x0b560e2d2d8d0033887c312bf7638de26efa39555a777f5ba76091605e3f5445;

        (uint256 eval_scalar, uint256[] memory q_scalars) =
            Zeromorph.eval_and_quotient_scalars(Field.reverse256(y), Field.reverse256(x), Field.reverse256(z), point);
        assertEq(eval_scalar, 0x19cb8436c667bce0ca81531a9d6df3853534d938b8d55cd5207a804e0494a152);
        assertEq(q_scalars[0], 0x04b26c6892f5a4bf0e5c827d831ce8fa0231dc77dd8925eb92cb029ad4d6a108);
        assertEq(q_scalars[1], 0x14e0287e1f778c161a11825982fd4800f86da9da41ece78e8d4534526e43896d);
        assertEq(q_scalars[2], 0x2dc37bdc9700b7c0e42f8e1630213cda5a5a4bc104d1e5e217600ec18d72fa1d);
    }

    function test_compute_xyz() public {
        uint8[] memory zeromorph_keccak_label = new uint8[](4); // Rust's b"test"
        zeromorph_keccak_label[0] = 0x74;
        zeromorph_keccak_label[1] = 0x65;
        zeromorph_keccak_label[2] = 0x73;
        zeromorph_keccak_label[3] = 0x74;

        KeccakTranscriptLib.KeccakTranscript memory transcript = KeccakTranscriptLib.instantiate(zeromorph_keccak_label);
        zeromorph_keccak_label = new uint8[](9); // Rust's b"Zeromorph"
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

        uint256[] memory ck = new uint256[](3);
        ck[2] = 0x4a4390fc88227c8c8a12c28b9535db799af165c7addfa4a11c44a58b24f333f7;
        ck[1] = 0x54d549da2d6ac76663d9845faa33cdec2abd4bb1eacf321907fdeaef7bfd40bb;
        ck[0] = 0x032568dd9940089358fd8c9c398c319a0afd0517a32a4aa67a721404ea0e4941;

        zeromorph_keccak_label = new uint8[](3); // Rust's b"quo"
        zeromorph_keccak_label[0] = 0x71;
        zeromorph_keccak_label[1] = 0x75;
        zeromorph_keccak_label[2] = 0x6f;

        for (uint256 index = 0; index < ck.length; index++) {
            transcript = KeccakTranscriptLib.absorb(transcript, zeromorph_keccak_label, ck[index]);
        }

        zeromorph_keccak_label = new uint8[](1); // Rust's b"y"
        zeromorph_keccak_label[0] = 0x79;

        uint256 output;
        (transcript, output) =
            KeccakTranscriptLib.squeeze(transcript, ScalarFromUniformLib.curveBn256(), zeromorph_keccak_label);

        // y
        assertEq(output, 0x0d1f03b1b327f07237088a4b7439fd2f4a2237f8345a487944031651659d59f0);

        uint256 cqhat = 0x0f206674cce3d14b6756a69c4b0e6974baa1ca62e3493df0f6c9077b5592a80f;

        zeromorph_keccak_label = new uint8[](5); // Rust's b"q_hat"
        zeromorph_keccak_label[0] = 0x71;
        zeromorph_keccak_label[1] = 0x5f;
        zeromorph_keccak_label[2] = 0x68;
        zeromorph_keccak_label[3] = 0x61;
        zeromorph_keccak_label[4] = 0x74;

        transcript = KeccakTranscriptLib.absorb(transcript, zeromorph_keccak_label, cqhat);

        zeromorph_keccak_label = new uint8[](1); // Rust's b"x"
        zeromorph_keccak_label[0] = 0x78;

        (transcript, output) =
            KeccakTranscriptLib.squeeze(transcript, ScalarFromUniformLib.curveBn256(), zeromorph_keccak_label);

        // x
        assertEq(output, 0x1bbe88b6514053ba1a2e352dc3ef41e3a3b446b26b07408f1020116508d3185d);

        zeromorph_keccak_label = new uint8[](1); // Rust's b"z"
        zeromorph_keccak_label[0] = 0x7a;

        (transcript, output) =
            KeccakTranscriptLib.squeeze(transcript, ScalarFromUniformLib.curveBn256(), zeromorph_keccak_label);

        // z
        assertEq(output, 0x1c5002f8d69058e9878a3fd49c1a0a908b8eacc3f7a9a37515ce765df4087b84);
    }
}
