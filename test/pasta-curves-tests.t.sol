// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@std/Test.sol";
import "../src/pasta/Pallas.sol";
import "../src/pasta/Vesta.sol";

contract PastaCurvesContractTests is Test {

    function testMSM() public {
        /*
            use rand_core::OsRng;
            use pasta_curves::group::Group;

            type PallasPoint = pasta_curves::pallas::Point;
            type PallasScalar = pasta_curves::pallas::Scalar;

            let mut rng = OsRng;

            let p1 = PallasPoint::random(&mut rng).to_affine();
            println!("p1: {:?}", p1);

            let p2 = PallasPoint::random(&mut rng).to_affine();
            println!("p2: {:?}", p2);

            let p3 = PallasPoint::random(&mut rng).to_affine();
            println!("p3: {:?}", p3);

            let s1 = PallasScalar::random(&mut rng);
            println!("s1: {:?}", s1);

            let s2 = PallasScalar::random(&mut rng);
            println!("s2: {:?}", s2);

            let s3 = PallasScalar::random(&mut rng);
            println!("s3: {:?}", s3);

            let msm_output = pasta_msm::pallas([p1, p2, p3].as_slice(), [s1, s2, s3].as_slice());

            println!("msm: {:?}", msm_output.to_affine())
        */

        uint256 x1 = 0x1d972b37c58032d30791ccd8a1738274e4d40638e5d0951380de9c5214ee7149;
        uint256 y1 = 0x13bf619aada94194bf5163ece37935fb4a4f041de89651e18c786ab6ba8d26c2;

        Pallas.PallasAffinePoint memory point1 = Pallas.PallasAffinePoint(x1, y1);

        uint256 x2 = 0x388e0d99bc3c14e7f74ceebb1e8d6ed0519d730ebcacf46d6c301339da2fb32f;
        uint256 y2 = 0x3f2cc8b649fe9261ca49f71c8cf1be6a682c1e399378647f2fbfb50083ca3208;

        Pallas.PallasAffinePoint memory point2 = Pallas.PallasAffinePoint(x2, y2);

        uint256 x3 = 0x048960ccf125fb52db997aa846c91e8ee777cf6fc41517a7600dc9b7dc0fc1e5;
        uint256 y3 = 0x00a0585128fbd33a6b1a357b6f7f952a11b970073d8dcb63064e53613e7d9e38;

        Pallas.PallasAffinePoint memory point3 = Pallas.PallasAffinePoint(x3, y3);

        uint256 scalar1 = 0x1fc5c6553c906561a852a6d453da1928817f2e1dfa6dd33ce2aa38e834f7d460;
        uint256 scalar2 = 0x1bd76e81d96589edc288bcadc17f290addf4ba508101018f86961d3c650764f7;
        uint256 scalar3 = 0x1c32f723cc8570b54f584b78173b72eff07a6422f26a585b7815dd7543c2b7f5;

        Pallas.PallasAffinePoint[] memory bases = new Pallas.PallasAffinePoint[](3);
        bases[0] = point1;
        bases[1] = point2;
        bases[2] = point3;

        uint256[] memory exponents = new uint256[](3);
        exponents[0] = scalar1;
        exponents[1] = scalar2;
        exponents[2] = scalar3;

        Pallas.PallasAffinePoint memory msm = Pallas.multiScalarMul(bases, exponents);

        uint256 xExpected = 0x2565de35a8233431d6123bfe0632643d807071cf5664b077c5da4df8e3c3f641;
        uint256 yExpected = 0x0915100ff05cc4b9bd3422980fd3e7c34c4635956fdbcb0f2a9f3267e082dc73;

        assertEq(bytes32(xExpected), bytes32(msm.x));
        assertEq(bytes32(yExpected), bytes32(msm.y));
    }

    // TODO: add test for pow small with random exponent
    function testPallasPowSmall() public {
        /*
            use rand_core::OsRng;
            use pasta_curves::group::Group;

            type PallasPoint = pasta_curves::pallas::Point;
            type PallasScalar = pasta_curves::pallas::Scalar;

            let mut rng = OsRng;

            let p = PallasScalar::random(&mut rng);
            println!("p: {:?}", p);

            let exp_p = p.pow_vartime([2, 0, 0, 0]);
            println!("exp_p: {:?}", exp_p);
        */

        uint256 base = 0x3724def858c3d13a605830569046f39c0f3572895076481fa07174fb682a6b54;
        uint256 exponent = 0x0000000000000000000000000000000000000000000000000000000000000002;

        uint256 result = Pallas.powSmall(base, exponent, Pallas.R_MOD);

        uint256 expected = 0x3ac7fb6ca64a328ead7f613f9d96f06b10b229c6e9a5f6d93e7c0746d82909d3;

        assertEq(bytes32(expected), bytes32(result));
    }

    function testPallasFromLeBytesModOrder() public {
        /*
            use rand_core::OsRng;
            use pasta_curves::group::Group;

            type PallasPoint = pasta_curves::pallas::Point;
            type PallasScalar = pasta_curves::pallas::Scalar;

            let mut rng = OsRng;

            let p = PallasScalar::random(&mut rng);

            println!("p: {:?}", p);
            println!("p: {:x?}", p.to_repr());
        */

        bytes32 scalarBytes = 0x38124caf446d50036fc4b72373d76c0e400030829c82a4e8a0b0af80abe3a80f;
        uint256 scalar = Pallas.fromLeBytesModOrder(abi.encodePacked(scalarBytes));

        uint256 expected = 0x0fa8e3ab80afb0a0e8a4829c823000400e6cd77323b7c46f03506d44af4c1238;
        assertEq(expected, scalar);
    }

    function testPallasScalarValidation() public pure {
        uint256 scalar = 0x35ab23a4edfce9b7c35cc32bf0cb9a8b0d7ed781772e31900fdb106430dcfeaa;
        Pallas.validateScalarField(scalar);
    }


    function testPallasPointValidation() public view {
        uint256 x = 0x31a201b68c15156c487099a0235ad9638cfe5a928344cbbb29a228656c045bc2;
        uint256 y = 0x110bc29083e7d40ea6508ae8a17466252b3d12e0aaba29744a12355b15ae3a40;
        uint256 z = 0x0000000000000000000000000000000000000000000000000000000000000001;

        Pallas.PallasProjectivePoint memory point = Pallas.PallasProjectivePoint(x, y, z);

        Pallas.validateCurvePoint(Pallas.IntoAffine(point));
    }

    // TODO figure out why ScalarMul over projective point / scalar doesn't pass test vector
    //function testPallasScalarMulProjective() public {
        /*
            use rand_core::OsRng;
            use pasta_curves::group::Group;
            use pasta_curves::group::Curve;

            type PallasPoint = pasta_curves::pallas::Point;
            type PallasScalar = pasta_curves::pallas::Scalar;

            let mut rng = OsRng;

            let p = PallasPoint::random(&mut rng);
            println!("p: {:?}", p);

            let scalar = PallasScalar::random(&mut rng);
            println!("scalar: {:?}", scalar);

            let p_mul_scalar = p.mul(scalar);
            println!("p_mul_scalar: {:?}", p_mul_scalar);
        */

        /*
        uint256 x1 = 0x2a9787a5e39f9f8e97ea234ece859b7d657e6fa4a1feaf08e61ebaf32463e87e;
        uint256 y1 = 0x3cfba0ca6a9ee846fa0957f89035c29d1fdd1fc62693b7027198360c3588d6dc;
        uint256 z1 = 0x0000000000000000000000000000000000000000000000000000000000000001;

        Pallas.PallasProjectivePoint memory p1 = Pallas.PallasProjectivePoint(x1, y1, z1);

        uint256 scalar = 0x0716ea7ecbe554f483e62dc4a31ef8d080b35ea748906aa770491c144257819a;

        Pallas.PallasProjectivePoint memory p1MulScalar = Pallas.projectiveScalarMul(p1, scalar);

        uint256 x_expected = 0x35ea0d47490c86c70ce776259a0537323f498676a11358b8c91bea2eb00d5817;
        uint256 y_expected = 0x315dba1fbee5f02fcf5205349cb4d9ff9e64eed7bfc6ead3ce90cf7c359bf3e9;
        uint256 z_expected = 0x13990e37fa334265f5f33d8c941c28dcd07a6e8219b79417ea30ba8ae162867f;
        */
        //assertEq(bytes32(x_expected), bytes32(p1MulScalar.x));
        //assertEq(bytes32(y_expected), bytes32(p1MulScalar.y));
        //assertEq(bytes32(z_expected), bytes32(p1MulScalar.z));
    //}


    function testPallasScalarMulAffine() public {
        /*
            use rand_core::OsRng;
            use pasta_curves::group::Group;
            use pasta_curves::group::Curve;

            type PallasPoint = pasta_curves::pallas::Point;
            type PallasScalar = pasta_curves::pallas::Scalar;

            let mut rng = OsRng;

            let p = PallasPoint::random(&mut rng).to_affine();
            println!("p: {:?}", p);

            let scalar = PallasScalar::random(&mut rng);
            println!("scalar: {:?}", scalar);

            let p_mul_scalar = p.mul(scalar);
            println!("p_mul_scalar: {:?}", p_mul_scalar.to_affine());
        */

        uint256 x1 = 0x03744571afe66fa380fa2a661a27f1df68d405173023281e6c644459bae1fefc;
        uint256 y1 = 0x2f971d7929db23f7985a53ac84d4cffe2a85ddd39ff1a8c6a822c8b5087ebc15;

        Pallas.PallasAffinePoint memory p1 = Pallas.PallasAffinePoint(x1, y1);

        uint256 scalar = 0x22695b548e0b09140224ef3a292349f96ac26b2b82c6fd7c31b6da1742401c6d;

        Pallas.PallasAffinePoint memory p1MulScalar = Pallas.scalarMul(p1, scalar);

        uint256 xExpected = 0x3a37cd0a53fd0550c75d4afde145611e65b17f568fd2965aab251dfe6d4e8de2;
        uint256 yExpected = 0x054f018342cc56e49348af0dcca916f084f153a88f5da1ad8318144b7f8dbbcf;

        assertEq(bytes32(xExpected), bytes32(p1MulScalar.x));
        assertEq(bytes32(yExpected), bytes32(p1MulScalar.y));
    }
    function testPallasAddAffine() public {
        /*
            use rand_core::OsRng;
            use pasta_curves::group::Group;
            use pasta_curves::group::Curve;

            type PallasPoint = pasta_curves::pallas::Point;
            type PallasScalar = pasta_curves::pallas::Scalar;

            let mut rng = OsRng;

            let p1 = PallasPoint::random(&mut rng).to_affine();
            println!("p1: {:?}", p1);

            let p2 = PallasPoint::random(&mut rng).to_affine();
            println!("p2: {:?}", p2);

            let p1_p2_add = p1.add(p2).to_affine();
            println!("p1_p2_add: {:?}", p1_p2_add);
        */

        uint256 x1 = 0x3f2ad2fbd8c6b4cf406a9706874d03445350fa1c7c234c5dd86f7c8cf9cb759c;
        uint256 y1 = 0x3131287a5ea51ffb23759e90d998a50f87f386cf8ff45238ac50f03c09279bdf;

        Pallas.PallasAffinePoint memory p1 = Pallas.PallasAffinePoint(x1, y1);

        uint256 x2 = 0x0faa070e87caa21bed5430a37bb7e030581509169c585a8c065a416e8c63e613;
        uint256 y2 = 0x1bd57159775742b1d80ef1d9df95bec2422af2eb3976e7fab8635920e6c690f8;

        Pallas.PallasAffinePoint memory p2 = Pallas.PallasAffinePoint(x2, y2);

        Pallas.PallasAffinePoint memory p1p2Add = Pallas.add(p1, p2);

        uint256 xExpected = 0x1d67782d21f44a1780ae2f480a01a332089105ca6c2636f1586dff07d7b103a1;
        uint256 yExpected = 0x253aa575691f2d132d816147b2f09c33372a12ca361b879c8511b163c1988624;

        assertEq(bytes32(xExpected), bytes32(p1p2Add.x));
        assertEq(bytes32(yExpected), bytes32(p1p2Add.y));
    }

    function testPallasAddProjective() public {
        /*
            use rand_core::OsRng;
            use pasta_curves::group::Group;
            use pasta_curves::group::Curve;

            type PallasPoint = pasta_curves::pallas::Point;
            type PallasScalar = pasta_curves::pallas::Scalar;

            let mut rng = OsRng;

            let p1 = PallasPoint::random(&mut rng);
            println!("p1: {:?}", p1);

            let p2 = PallasPoint::random(&mut rng);
            println!("p2: {:?}", p2);

            let p1_p2_add = p1.add(p2);
            println!("p1_p2_add: {:?}", p1_p2_add);
        */

        uint256 x1 = 0x2dc6b24fee6088baff97fff40d7db27509ad35fa2626a888733c03bd199e63b5;
        uint256 y1 = 0x05c2f9aa43354384349502b8f8f8fc5da68293b20eaa55557bab0435baf31a7d;
        uint256 z1 = 0x0000000000000000000000000000000000000000000000000000000000000001;

        Pallas.PallasProjectivePoint memory p1 = Pallas.PallasProjectivePoint(x1, y1, z1);

        uint256 x2 = 0x3dc355a2b69450add36a1bfb87342b96e29b24c997bdc4e8b30ba92d21eb2a31;
        uint256 y2 = 0x1ce32af0c379bdf5d09533ba20512e145acaaf0bb540ebc2e3ffb800f4f6e340;
        uint256 z2 = 0x0000000000000000000000000000000000000000000000000000000000000001;

        Pallas.PallasProjectivePoint memory p2 = Pallas.PallasProjectivePoint(x2, y2, z2);

        Pallas.PallasProjectivePoint memory p1p2Add = Pallas.add(p1, p2);

        uint256 xExpected = 0x1450ca1656c299a3a68682867bf546d518ac9c9ae912fb4ab6a2d8997ea1bddb;
        uint256 yExpected = 0x3ffd1bac970c51adbfbdf72d42040653b1faa42283d81391e47cb6942f63d49b;
        uint256 zExpected = 0x1ff946a590678fe5a7a4380ef36cf243b1dbdd9ee32e38c07f9f4ae010998cf8;

        assertEq(bytes32(xExpected), bytes32(p1p2Add.x));
        assertEq(bytes32(yExpected), bytes32(p1p2Add.y));
        assertEq(bytes32(zExpected), bytes32(p1p2Add.z));
    }

    function testPallasDoubleProjective() public {
        /*
            use rand_core::OsRng;
            use pasta_curves::group::Group;
            use pasta_curves::group::Curve;

            type PallasPoint = pasta_curves::pallas::Point;
            type PallasScalar = pasta_curves::pallas::Scalar;

            let mut rng = OsRng;

            let p = PallasPoint::random(&mut rng);
            println!("p: {:?}", p);

            let double_p = p.double();
            println!("double_p: {:?}", double_p);
        */

        uint256 x = 0x287a9faaf5efbcf26337b834fbc61513225a11089b34d96a6b59ed9988a839ff;
        uint256 y = 0x1b6d5d7bebd0a5a033f20dcefdb3f3d872cb1abcd2687d1099bade03abb4ce91;
        uint256 z = 0x0000000000000000000000000000000000000000000000000000000000000001;

        Pallas.PallasProjectivePoint memory p = Pallas.PallasProjectivePoint(x, y, z);

        Pallas.PallasProjectivePoint memory doubleP = Pallas.double(p);

        uint256 xExpected = 0x24dea599222651e4cd2252a7a30ec18be8b637f303edc329cc4b4422dfda8103;
        uint256 yExpected = 0x2154fb21e4af89269b0ffa144dc7a39c5bf124a47462917a050d9d398db1b8d7;
        uint256 zExpected = 0x36dabaf7d7a14b4067e41b9dfb67e7b0e5963579a4d0fa213375bc0757699d22;

        assertEq(bytes32(xExpected), bytes32(doubleP.x));
        assertEq(bytes32(yExpected), bytes32(doubleP.y));
        assertEq(bytes32(zExpected), bytes32(doubleP.z));
    }

    function testPallasNegateScalar() public {
        /*
            use rand_core::OsRng;
            use pasta_curves::group::Group;

            type PallasPoint = pasta_curves::pallas::Point;
            type PallasScalar = pasta_curves::pallas::Scalar;

            let mut rng = OsRng;

            let p = PallasScalar::random(&mut rng);
            println!("p: {:?}", p);

            let minus_p = p.neg();
            println!("minus_p: {:?}", minus_p);
        */

        uint256 scalar = 0x2e9db40a60ed61b6e7adbdade0b08d35c60eb72d500f24a054c634a66fe0b331;
        uint256 minusScalar = Pallas.negate(scalar);

        uint256 expected = 0x11624bf59f129e49185242521f4f72ca5c37e1ceb985843d3780b67a901f4cd0;
        assertEq(bytes32(expected), bytes32(minusScalar));
    }

    function testPallasNegateAffine() public {
        /*
            use rand_core::OsRng;
            use pasta_curves::group::Group;

            type PallasPoint = pasta_curves::pallas::Point;
            type PallasScalar = pasta_curves::pallas::Scalar;

            let mut rng = OsRng;

            let p = PallasPoint::random(&mut rng).to_affine();
            println!("p: {:?}", p);

            let minus_p = p.neg();
            println!("minus_p: {:?}", minus_p);
        */

        uint256 x = 0x21f2cbf70ab36a05d7bb34b6b64ae2f51cc58c9f6f43e38c384bd3a44e02ee76;
        uint256 y = 0x00b55101c22d2273b223f9d8fed7863967ffa1f4af955ad82f9486e6ead1ea75;

        Pallas.PallasAffinePoint memory p = Pallas.PallasAffinePoint(x, y);

        Pallas.PallasAffinePoint memory minusP = Pallas.negate(p);

        uint256 xExpected = 0x21f2cbf70ab36a05d7bb34b6b64ae2f51cc58c9f6f43e38c384bd3a44e02ee76;
        uint256 yExpected = 0x3f4aaefe3dd2dd8c4ddc0627012879c6ba46f70759b79e436998aa06152e158c;

        assertEq(bytes32(xExpected), bytes32(minusP.x));
        assertEq(bytes32(yExpected), bytes32(minusP.y));
    }

    function testPallasNegateProjective() public {
        /*
            use rand_core::OsRng;
            use pasta_curves::group::Group;

            type PallasPoint = pasta_curves::pallas::Point;
            type PallasScalar = pasta_curves::pallas::Scalar;

            let mut rng = OsRng;

            let p = PallasPoint::random(&mut rng);
            println!("p: {:?}", p);

            let minus_p = p.neg();
            println!("minus_p: {:?}", minus_p);
        */

        uint256 x = 0x3e9ccc4bed28364439802d73e01b1371bfe6d94e4fab63c0cad0f660abaeb5f0;
        uint256 y = 0x3506e7d43b681f752bf86d0f5a581a9f0cc054aa3d3c2b6f67bce6b0329523cb;
        uint256 z = 0x0000000000000000000000000000000000000000000000000000000000000001;

        Pallas.PallasProjectivePoint memory p = Pallas.PallasProjectivePoint(x, y, z);

        Pallas.PallasProjectivePoint memory minusP = Pallas.negate(p);

        uint256 xExpected = 0x3e9ccc4bed28364439802d73e01b1371bfe6d94e4fab63c0cad0f660abaeb5f0;
        uint256 yExpected = 0x0af9182bc497e08ad40792f0a5a7e56115864451cc10cdac31704a3ccd6adc36;
        uint256 zExpected = 0x0000000000000000000000000000000000000000000000000000000000000001;

        assertEq(bytes32(xExpected), bytes32(minusP.x));
        assertEq(bytes32(yExpected), bytes32(minusP.y));
        assertEq(bytes32(zExpected), bytes32(minusP.z));
    }

    // TODO add test when projective point has non-zero Z coordinate
    function testPallasToAffine() public {
        /*
            use rand_core::OsRng;
            use pasta_curves::group::Group;

            type PallasPoint = pasta_curves::pallas::Point;
            type PallasScalar = pasta_curves::pallas::Scalar;

            let mut rng = OsRng;

            let p = PallasPoint::random(&mut rng);
            println!("random point projective: {:?}", p);

            let p = p.to_affine();
            println!("random point affine: {:?}", p);
        */

        uint256 x = 0x01c296ffab785ef499226010ea6cca1829c705b28e104342ba5337701379c54a;
        uint256 y = 0x12aed2775c0c1d07489f129b07eb86d7c12d3147cfcb5d6ab54ab6a39d362334;
        uint256 z = 0x0000000000000000000000000000000000000000000000000000000000000001;

        Pallas.PallasProjectivePoint memory pointProjective = Pallas.PallasProjectivePoint(x, y, z);

        Pallas.PallasAffinePoint memory pointAffine = Pallas.IntoAffine(pointProjective);

        uint256 xExpected = 0x01c296ffab785ef499226010ea6cca1829c705b28e104342ba5337701379c54a;
        uint256 yExpected = 0x12aed2775c0c1d07489f129b07eb86d7c12d3147cfcb5d6ab54ab6a39d362334;
        assertEq(bytes32(xExpected), bytes32(pointAffine.x));
        assertEq(bytes32(yExpected), bytes32(pointAffine.y));
    }

    function testPallasProjectiveGenerator() public {
        /*
            use pasta_curves::group::Group;

            type PallasPoint = pasta_curves::pallas::Point;
            type PallasScalar = pasta_curves::pallas::Scalar;

            let p = PallasPoint::generator();
            println!("generator: {:?}", p);
        */

        uint256 pallasGeneratorXexpected = 0x40000000000000000000000000000000224698fc094cf91b992d30ed00000000;
        uint256 pallasGeneratorYexpected = 0x0000000000000000000000000000000000000000000000000000000000000002;
        uint256 pallasGeneratorZexpected = 0x0000000000000000000000000000000000000000000000000000000000000001;

        Pallas.PallasProjectivePoint memory point = Pallas.ProjectiveGenerator();
        assertEq(bytes32(point.x), bytes32(pallasGeneratorXexpected));
        assertEq(bytes32(point.y), bytes32(pallasGeneratorYexpected));
        assertEq(bytes32(point.z), bytes32(pallasGeneratorZexpected));
    }

    function testPallasAffineGenerator() public {
        /*
            use pasta_curves::group::Group;

            type PallasPoint = pasta_curves::pallas::Point;
            type PallasScalar = pasta_curves::pallas::Scalar;

            let p = PallasPoint::generator().to_affine();
            println!("generator: {:?}", p);
        */

        uint256 pallasGeneratorXexpected = 0x40000000000000000000000000000000224698fc094cf91b992d30ed00000000;
        uint256 pallasGeneratorYexpected = 0x0000000000000000000000000000000000000000000000000000000000000002;

        Pallas.PallasAffinePoint memory point = Pallas.AffineGenerator();
        assertEq(bytes32(point.x), bytes32(pallasGeneratorXexpected));
        assertEq(bytes32(point.y), bytes32(pallasGeneratorYexpected));
    }

    function testPallasInvertFr() public {
        /*
            use rand_core::OsRng;
            use pasta_curves::group::Group;

            type PallasPoint = pasta_curves::pallas::Point;
            type PallasScalar = pasta_curves::pallas::Scalar;

            let mut rng = OsRng;

            let pallas_scalar = PallasScalar::random(&mut rng);
            println!("pallas scalar: {:?}", pallas_scalar);

            let pallas_scalar_inverted = pallas_scalar.invert().unwrap();
            println!("pallas scalar inverted: {:?}", pallas_scalar_inverted);

        */

        uint256 pallasScalar = 0x241485a5238caca98c32f3113a90f0fd5e7f62f4caecb639b938d7a0a4e08867;
        uint256 inverted = Pallas.invert(pallasScalar, Pallas.R_MOD);
        assertEq(bytes32(inverted), bytes32(0x1ec5d74264fcb22d01cb7c46b1f129637e5fd7990100b3b64e7e937360bcbfac));
    }

    function testPallasScalarMulProjective_1() public {
        /*
            let pallas_point = PallasPoint::random(&mut rng);
            let pallas_scalar = PallasScalar::from(2u64);

            println!("pallas_point X: {:?}", pallas_point.jacobian_coordinates().0);
            println!("pallas_point Y: {:?}", pallas_point.jacobian_coordinates().1);
            println!("pallas_point z: {:?}", pallas_point.jacobian_coordinates().2);

            println!("pallas_scalar: {:?}", pallas_scalar);

            let scalar_multiplication_result = pallas_point.mul(pallas_scalar);

            println!("scalar_multiplication_result X: {:?}", scalar_multiplication_result.jacobian_coordinates().0);
            println!("scalar_multiplication_result Y: {:?}", scalar_multiplication_result.jacobian_coordinates().1);
            println!("scalar_multiplication_result z: {:?}", scalar_multiplication_result.jacobian_coordinates().2);
        */

        uint256 x = 0x2c4ed92736886d0c2a9472a429ff368d4a9e634cc8752e32f55d18f09d8a1a5d;
        uint256 y = 0x362ef36d07039637fa49a66e941a306b1529c5d738107ce2336d25872c01265a;
        uint256 z = 0x0000000000000000000000000000000000000000000000000000000000000001;

        Pallas.PallasProjectivePoint memory pallasPoint = Pallas.PallasProjectivePoint(x, y, z);

        uint256 pallasScalar = 0x0000000000000000000000000000000000000000000000000000000000000002;

        uint256 xExpected = 0x2536526b90b66c6378b88c47426bdf67cd7fd5d732ada454524c1e01ff3ad79c;
        uint256 yExpected = 0x3366fc096d6a773f90c4aefab527576a6c0855aefa25e88e3d958fcba2ee9168;
        uint256 zExpected = 0x2c5de6da0e072c6ff4934cdd283460d6080cf2b266d400a8cdad1a2158024cb3;

        Pallas.PallasProjectivePoint memory actual = Pallas.scalarMul(pallasPoint, pallasScalar);

        assertEq(bytes32(xExpected), bytes32(actual.x));
        assertEq(bytes32(yExpected), bytes32(actual.y));
        assertEq(bytes32(zExpected), bytes32(actual.z));
    }

    function testPallasScalarMulProjective_2() public {
        uint256 x_ = 0x02807566a47b423db7b3c63b2d7eb090384a13af6f7b08dec55d498a3e1e2e4a;
        uint256 y_ = 0x1879f1b3da88f5619e1c7162fcc3703ace2a46d4a69b79ae5d7c40fc7d3213b7;
        uint256 z_ = 0x0000000000000000000000000000000000000000000000000000000000000001;

        Pallas.PallasProjectivePoint memory pallasPoint = Pallas.PallasProjectivePoint(x_, y_, z_);

        uint256 pallasScalar = 0x0000000000000000000000000000000000000000000000000000000000000001;
        Pallas.validateScalarField(pallasScalar);

        uint256 x = 0x02807566a47b423db7b3c63b2d7eb090384a13af6f7b08dec55d498a3e1e2e4a;
        uint256 y = 0x1879f1b3da88f5619e1c7162fcc3703ace2a46d4a69b79ae5d7c40fc7d3213b7;
        uint256 z = 0x0000000000000000000000000000000000000000000000000000000000000001;
        Pallas.PallasProjectivePoint memory expected = Pallas.PallasProjectivePoint(x, y, z);

        // checking that P * 1 = P
        Pallas.PallasProjectivePoint memory actual = Pallas.scalarMul(pallasPoint, pallasScalar);

        assertEq(expected.x, actual.x);
        assertEq(expected.y, actual.y);
        assertEq(expected.z, actual.z);

        // checking that P + P = P * 2
        Pallas.PallasProjectivePoint memory addition1 = Pallas.add(expected, actual);

        uint256 pallasScalarTwo = 0x0000000000000000000000000000000000000000000000000000000000000002;
        Pallas.validateScalarField(pallasScalarTwo);

        Pallas.PallasProjectivePoint memory addition2 = Pallas.scalarMul(expected, pallasScalarTwo);

        assertEq(addition1.x, addition2.x);
        assertEq(addition1.y, addition2.y);
        assertEq(addition1.z, addition2.z);
    }
}
