// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.16;

import "@std/Test.sol";
import "src/blocks/grumpkin/Bn256.sol";
import "src/blocks/grumpkin/Grumpkin.sol";
import "src/Utilities.sol";

contract GrumpkinCurvesContractTests is Test {
    // Randomly generated Bn256 points addition using precompile
    function testBnAddition() public {
        Bn256.Bn256AffinePoint memory a = Bn256.Bn256AffinePoint(
            0x0600e76ee572ed1c922270a03624819d95b82c01da3851b3223c8e8177a77ba3,
            0x22836034aa3f792c72b9921de7b6e2d5a9a740871c5bb81fc96b11b054b55e96
        );
        Bn256.Bn256AffinePoint memory b = Bn256.Bn256AffinePoint(
            0x142d727ed45eb01eecf8ca51b3868146d43dc4061af1022b15b8888391811a76,
            0x2965258188dbaa96d5b497fccb39ca21e4fd9c9728f9d5147bf5001bbfb9d053
        );

        Bn256.Bn256AffinePoint memory a_add_b = Bn256.add(a, b);

        assertEq(a_add_b.x, 0x0c445108a8c1409d4a4c8a7a1d762d174b1a0febb0ee7959e4f4d26ad68abe69);
        assertEq(a_add_b.y, 0x06331f7b05cc6a4db7cd1d754f1c7bb8afc4d403d8a3f7628657beeb533d4892);
    }

    // Randomly generated Bn256 point and scalar multiplication
    function testBnScalarMultiplication() public {
        Bn256.Bn256AffinePoint memory a = Bn256.Bn256AffinePoint(
            0x0073b501af3655120d0f0ff62f04ec139f23edd48d5f2afd45b49e5edbe2ddcb,
            0x010cafb3c0955012dd182e622a632870bb2cada3c078906af277c18481e05b94
        );
        uint256 scalar = 0x191d3d4743b4d1ce3936a0a668cf6f6450284579dbe266e3645b6764cf24b936;

        Bn256.Bn256AffinePoint memory a_mul_scalar = Bn256.scalarMul(a, scalar);

        assertEq(a_mul_scalar.x, 0x106ebfc296f4d9bbd8f9f3ba53f5302d8c812b061ebf87b3c936436c0e16c98a);
        assertEq(a_mul_scalar.y, 0x09805523852e4a2ad468b7f3417e6021a162bc54fcaa57022ef9a4874429d5de);
    }

    function testBnPointNegation() public {
        Bn256.Bn256AffinePoint memory a = Bn256.Bn256AffinePoint(
            0x21d7a77ac2284a43e092d71d61bdbba7aefc1e510be9564d1baf0871aca726d2,
            0x1f01970d4ea84fca4a280ecaa8f6ad64878145e79440865d2ef6453255db4465
        );

        Bn256.Bn256AffinePoint memory minus_a = Bn256.negate(a);

        assertEq(minus_a.x, 0x21d7a77ac2284a43e092d71d61bdbba7aefc1e510be9564d1baf0871aca726d2);
        assertEq(minus_a.y, 0x1162b7659289505f6e2836ebd88aaaf9100024a9d43144300d2a46e482a1b8e2);
    }

    function testBnScalarNegation() public {
        uint256 negatedScalar = Bn256.negateScalar(0x2cc21dfa7b3092856bcb6cf1b5a1d681ad209329433fed39a6293bcda0fd84d2);
        assertEq(negatedScalar, 0x03a2307866010da44c84d8c4cbdf81db7b13551f367983579db8b9c64f027b2f);
    }

    function testBnDecompression1() public {
        uint256 compressedBnPoint = 0x02e13aa9d761e0e472e32515efc93524b979da114497f4c8920d73b3cd5b5369;

        Bn256.Bn256AffinePoint memory point = Bn256.decompress(compressedBnPoint);

        assertEq(point.x, 0x02e13aa9d761e0e472e32515efc93524b979da114497f4c8920d73b3cd5b5369);
        assertEq(point.y, 0x20d927c1597b83877cd1792f881a18aab67e51e03fa00618570ab2fecbd2f756);
    }

    function testBnDecompression2() public {
        uint256 compressedBnPoint = 0x2e03e31d1390cec6f8a9e09b54c5fdded07a3fb1c909f20dc392c4ecbede7789;

        Bn256.Bn256AffinePoint memory point = Bn256.decompress(compressedBnPoint);

        assertEq(point.x, 0x2e03e31d1390cec6f8a9e09b54c5fdded07a3fb1c909f20dc392c4ecbede7789);
        assertEq(point.y, 0x1a28a3d14671aef04ecddc2e37ba640983ac9a249f8504db242d880d2946bb92);
    }

    function testGrumpkinPointsAddition() public {
        Grumpkin.GrumpkinAffinePoint memory a = Grumpkin.GrumpkinAffinePoint(
            0x1cccccb80012e70dd67726216a7d958066d2df2ab126eab550c9e57cc02eaf88,
            0x0a5809d7d9f66ae7e22107f71bbe8f6f1d980eb0254903eeb17e46255a5758bb
        );
        Grumpkin.GrumpkinAffinePoint memory b = Grumpkin.GrumpkinAffinePoint(
            0x0eb7400597f60115135a47416a82e673ada930a84d61fdcff6238b7432f5cc4a,
            0x1b6b2a54c04eb0830097f90e5792465b5c131599e1cd9646539ef175d9eac362
        );

        Grumpkin.GrumpkinAffinePoint memory a_add_b = Grumpkin.add(a, b);

        assertEq(a_add_b.x, 0x20f8a568a0f88b810c1e188bed483c59d3bc9580961189610a3417c1d059988d);
        assertEq(a_add_b.y, 0x129ddaf2d82686acfaf2027286ff4863518f2f287cfd260764b3882db95c5aae);
    }

    function testGrumpkinPointsAddition1() public {
        Grumpkin.GrumpkinAffinePoint memory a = Grumpkin.GrumpkinAffinePoint(
            0x0e45bef5a4dc0a829e12237f664a560e40b0b64b5ad756ef1570f9c06d5ea34c,
            0x029377f80a53f008b12353147e6319ac321e7a3041f133aa3d57f27af76a4b89
        );
        Grumpkin.GrumpkinAffinePoint memory b = Grumpkin.GrumpkinAffinePoint(
            0x246cddd7825b1188bd148b7934c51b3f89acd0e9b8512859586ee331ec0c608f,
            0x0c773a07e528f09398f61c62dff3fecc7c159a8f92c5e0f9754701e1eb6a3a6b
        );

        Grumpkin.GrumpkinAffinePoint memory a_add_b = Grumpkin.add(a, b);

        assertEq(a_add_b.x, 0x1c1e620d141dc309aee9abbcfdf8f209ebb1e2b6a273047982a8dbc79df08606);
        assertEq(a_add_b.y, 0x1c9c67cb1ba6e574e3e81ff3a8a671db240e9fd6fc80a743a4012d811819c1fc);
    }

    function testGrumpkinPointsAddition2() public {
        Grumpkin.GrumpkinAffinePoint memory a = Grumpkin.GrumpkinAffinePoint(
            0x1cf5113f81880211c8f14803e3188441c2deef67beed0121bc9931edf45d6fb5,
            0x28951e68549bcf980f6907cec255844ecda807f7db23eb1003d2ff66e2ea7dcc
        );
        Grumpkin.GrumpkinAffinePoint memory b = Grumpkin.GrumpkinAffinePoint(
            0x00f0d2a7e214d1a51fdb6cb5beed13b9fbf9fa5542d149c44ed3eb7ef9a84e68,
            0x1d95d822d4e231a8b23c34a0ba9c3463c09f436bf20dbcb72af1956bef990d3f
        );

        Grumpkin.GrumpkinAffinePoint memory a_add_b = Grumpkin.add(a, b);

        assertEq(a_add_b.x, 0x15fe13d4a92134913a5929757cdc0c3f783b480ac5a0b41d670aabf9c0b72b35);
        assertEq(a_add_b.y, 0x10fa7c954c30cc5b6914794d30235cfa4dade3c195a7ed2c4187432bba3be499);
    }

    function testGrumpkinPointsAddition3() public {
        Grumpkin.GrumpkinAffinePoint memory a = Grumpkin.GrumpkinAffinePoint(
            0x1940be2c132240cbe99245cf5211c05417573258ecc403728563b6aabdf41e11,
            0x2bb5a742615d526847fff41cf06848aedfb0aeaa3a655fcbf65d73379d9f16d0
        );
        Grumpkin.GrumpkinAffinePoint memory b = Grumpkin.GrumpkinAffinePoint(
            0x054dfd4b4e430978944d28679119746bcdf686983017522912e5d4ccc66a6003,
            0x0ebccaea4b3292f4b74b207473e21c77eca8c6ecd58ecca6b4b6ea6dee967df0
        );

        Grumpkin.GrumpkinAffinePoint memory a_add_b = Grumpkin.add(a, b);

        assertEq(a_add_b.x, 0x0db92df56f8c8f731f7eef74bce8f003e1c2808bf68eb2fe1687a283fa7fdf93);
        assertEq(a_add_b.y, 0x0e4cea88bc86bb8978c63c2ee5b16ac5be37ba75e76325937a04d2fc05a1fdcd);
    }

    function testGrumpkinPointsAddition4() public {
        Grumpkin.GrumpkinAffinePoint memory a = Grumpkin.GrumpkinAffinePoint(
            0x1c2748abace80f28e88d3cc7622e3ebfd68914ca3b7bdf8683aabeaccc4edd12,
            0x1af19579be59c1c791bf0eb6724736bda88a80ebdcc33fc62c274a955831eeb6
        );
        Grumpkin.GrumpkinAffinePoint memory b = Grumpkin.GrumpkinAffinePoint(
            0x02cd6d604d50dec5570af383108a57fc3710fc72e1c3663b1b67dd8de5cf5c74,
            0x1fd05c9a771ba7d9319e8345dd7e6cd1f2f94fdd50fd7d6f81fb384469535319
        );

        Grumpkin.GrumpkinAffinePoint memory a_add_b = Grumpkin.add(a, b);

        assertEq(a_add_b.x, 0x26bc0d2e0c7b884f3f633aac1148b8940e2d2fdfee546332b7513b4cf604cf3b);
        assertEq(a_add_b.y, 0x046d7ca187d27e8e6d79f1d856c4d6af2adac6fda93a3301b32dd8922d52608c);
    }

    function testGrumpkinPointsAddition5() public {
        Grumpkin.GrumpkinAffinePoint memory a = Grumpkin.GrumpkinAffinePoint(
            0x16353e3056528a8c810bf56be5fa412f1690358165a576959bc2c1e2f159b0b9,
            0x24e6a39c3f02cb19f0b32c99ee421b6fa9ed54496235fb88e6f70c3f6511ceb2
        );
        Grumpkin.GrumpkinAffinePoint memory b = Grumpkin.GrumpkinAffinePoint(
            0x029eec5b38efd718d62a8c5a2c83485c248383e30472855fa45b55de2315c542,
            0x1836838e05a41628b6e339947633288bcdc108371c2ac5881e0cbec5669dee0b
        );

        Grumpkin.GrumpkinAffinePoint memory a_add_b = Grumpkin.add(a, b);

        assertEq(a_add_b.x, 0x27d77e1502e2f888b1b3e7daa03fc8b69e46e0a0c24ec9d016baa9cb2fd829dc);
        assertEq(a_add_b.y, 0x1ca364bd41ac17a7af6c242b8acc3a6f486142bf945f69376c8f49cf72a14113);
    }

    function testGrumpkinPointsAddition6() public {
        Grumpkin.GrumpkinAffinePoint memory a = Grumpkin.GrumpkinAffinePoint(
            0x2a8ba135eda19a259a760ef9562173fbf2cab7ed43dccc4f0c497d5cc954a7a6,
            0x2949dbc6d48633b0005866c204f6cbbcdb5bd51781860525b128aadbae498770
        );
        Grumpkin.GrumpkinAffinePoint memory b = Grumpkin.GrumpkinAffinePoint(
            0x063ae3fafc7dd8420d2e7c6f3397260ed240ca7756676a2097326c5336139899,
            0x18e76dcd3e67f8ff8ecc37297623c78e8e5ea4928e1be68114cda43771ada376
        );

        Grumpkin.GrumpkinAffinePoint memory a_add_b = Grumpkin.add(a, b);

        assertEq(a_add_b.x, 0x1e3bf84008940aedc050fad7d585a7167f0ec1e06d86c9730c8c0394090ca258);
        assertEq(a_add_b.y, 0x0aa9cb105226f6fb27db76e79b81c531c9ca0d8faad7bdd5335c387323e1037c);
    }

    function testGrumpkinPointsAddition7() public {
        Grumpkin.GrumpkinAffinePoint memory a = Grumpkin.GrumpkinAffinePoint(
            0x0b08bb259b4069c824638614ec593ee9593c357e029bcaab21cd5bf9110699e2,
            0x085d8a3de9e877e70471cd6afb8a5e647add1c1dbc9a292696055d2d9a25774e
        );
        Grumpkin.GrumpkinAffinePoint memory b = Grumpkin.GrumpkinAffinePoint(
            0x1ec4fbfe0e7e6770da9d2de60ceb4341cbb3b3a6f7c8fdf616b2d39ebbec7a02,
            0x257618b421e75f58d9ed2dacecfb0817c86d05ab45e3ca33a0290e31d7c9ffaf
        );

        Grumpkin.GrumpkinAffinePoint memory a_add_b = Grumpkin.add(a, b);

        assertEq(a_add_b.x, 0x2a1db4d997272461b992c6eb554a489a5dd5167631b145a765843d046c14cd47);
        assertEq(a_add_b.y, 0x1a35a85f97e95d38f0dc1234ccbd444d347749e82a8fe4e05250b6c926a6ab7b);
    }

    function testGrumpkinPointsAddition8() public {
        Grumpkin.GrumpkinAffinePoint memory a = Grumpkin.GrumpkinAffinePoint(
            0x06a2b53af7f4b4c18deb2e309d570a86a56043cb6441723c202da557a1a2e8ad,
            0x2de7a137f3c9b3eeccdb4f3ebcd1861283cf20ea807507597a9296d646c7903a
        );
        Grumpkin.GrumpkinAffinePoint memory b = Grumpkin.GrumpkinAffinePoint(
            0x17ac4bed55f478b8bd3d4550143ee65f046681d3ddcf5bb1d37e708baff5fc09,
            0x2de6e1d3420af7e92d001928fbc9ab6139583081b547108c0871143a0e449e71
        );

        Grumpkin.GrumpkinAffinePoint memory a_add_b = Grumpkin.add(a, b);

        assertEq(a_add_b.x, 0x01e3367ac681303d84a0d0d33ddd6329a8f547a53ade71c965dbd268a93978e4);
        assertEq(a_add_b.y, 0x16fe6b35f8734fb0926de3c31c14faec2289f7a8f83888d69f3a03b12b515c3c);
    }

    function testGrumpkinPointsAddition9() public {
        Grumpkin.GrumpkinAffinePoint memory a = Grumpkin.GrumpkinAffinePoint(
            0x1e3b66da2488f7f8037f0c78687e29fcb08bd723b354bb96a25a07d995e45796,
            0x1d9435c02aa4d182b9475f5cabf1773188258c8581e5c6031bca5e3e4a0b572d
        );
        Grumpkin.GrumpkinAffinePoint memory b = Grumpkin.GrumpkinAffinePoint(
            0x21de1ae000727349ffb29f90c8810df2fd738e5f5be2c214da36b4df73042623,
            0x2dbe941d609f3808a0d6ea51fca5043bbbe7215df0424592853e47d8c5bc1ac4
        );

        Grumpkin.GrumpkinAffinePoint memory a_add_b = Grumpkin.add(a, b);

        assertEq(a_add_b.x, 0x0d9b2f0aa4c9320d147d2b22b03e821172dd3e27f5dfe6e9906d35666c997375);
        assertEq(a_add_b.y, 0x1c40ce4bfe1883382f9fdf1962512ed0ba7fb8a035da1a2fbf16d91a95701000);
    }

    function testGrumpkinPointsAddition10() public {
        Grumpkin.GrumpkinAffinePoint memory a = Grumpkin.GrumpkinAffinePoint(
            0x21f3a141bdb24ecd9522714278bb4929359ba5a9af9e4419fe9858bb84161e15,
            0x117d59a5647d638b4ae874c72e7f79822bbd304516d6386f905eee31485bd4d8
        );
        Grumpkin.GrumpkinAffinePoint memory b = Grumpkin.GrumpkinAffinePoint(
            0x1bb4c1d79815fe795ed0da7155e04bca6f3d3a0466d1a653b1c4be5c8f99ed46,
            0x1ecb17faaa7d008a52867da7d3330b1af6b802db4056d4669a7cd384307a842d
        );

        Grumpkin.GrumpkinAffinePoint memory a_add_b = Grumpkin.add(a, b);

        assertEq(a_add_b.x, 0x1848ef946f596f469c848438bd4298e8052945b6586215ce17239b525066f6f4);
        assertEq(a_add_b.y, 0x001a2f39bd6cddd97502bc15b89c9d3376c3bf227a1ef667ba593fc9ed1361cd);
    }

    function testGrumpkinScalarMultiplication() public {
        uint256 scalar = 0x29bd9a803cd11224817183fc6bceb32d59926fd9aa37d3cfb1c7845cbf7fae0d;

        Grumpkin.GrumpkinAffinePoint memory point = Grumpkin.GrumpkinAffinePoint(
            0x0a457db8ec3235bd290311c7aa8356a7cbb24771a3ed0ccfb5d276953bef3aca,
            0x0d7a2a8c2a155df8c022c1f953e622e81e792d3bcf68e1d5d26eb13064a31b22
        );

        Grumpkin.GrumpkinAffinePoint memory result = Grumpkin.scalarMul(point, scalar);

        assertEq(result.x, 0x23a8467859c9d32cf98c6ca74480024400f95c161808ad6477a993137612e0ad);
        assertEq(result.y, 0x1ff011d011d6988453b220017339c1bfe7906f266d8becdce5c733993bf17772);
    }

    function testGrumpkinDecompression() public {
        uint256 compressedGrumpkinPoint = 0x0eb7400597f60115135a47416a82e673ada930a84d61fdcff6238b7432f5cc4a;

        Grumpkin.GrumpkinAffinePoint memory point = Grumpkin.decompress(compressedGrumpkinPoint);

        assertEq(point.x, 0x0eb7400597f60115135a47416a82e673ada930a84d61fdcff6238b7432f5cc4a);
        assertEq(point.y, 0x1b6b2a54c04eb0830097f90e5792465b5c131599e1cd9646539ef175d9eac362);
    }

    function testGrumpkinDecompression1() public {
        uint256 compressedGrumpkinPoint =
            Field.reverse256(0x88bed3689a94506fe46065e5600749882804d3bf4793864638f641b3b2325157);

        Grumpkin.GrumpkinAffinePoint memory point = Grumpkin.decompress(compressedGrumpkinPoint);

        assertEq(point.x, 0x175132b2b341f63846869347bfd3042888490760e56560e46f50949a68d3be88);
        assertEq(point.y, 0x2f7039df869b2f301490e03faedf85d7b6079ee4e389fb09e87425446ec2133d);
    }
}
