// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@std/Test.sol";
import "../src/pasta/Pallas.sol";
import "../src/pasta/Vesta.sol";

contract PastaCurvesContractTests is Test {
    Pallas pallas = new Pallas();
    Vesta vesta = new Vesta();

    function testPallasMSM() public {
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

        PastaCurve.AffinePoint memory point1 = PastaCurve.AffinePoint(x1, y1);

        uint256 x2 = 0x388e0d99bc3c14e7f74ceebb1e8d6ed0519d730ebcacf46d6c301339da2fb32f;
        uint256 y2 = 0x3f2cc8b649fe9261ca49f71c8cf1be6a682c1e399378647f2fbfb50083ca3208;

        PastaCurve.AffinePoint memory point2 = PastaCurve.AffinePoint(x2, y2);

        uint256 x3 = 0x048960ccf125fb52db997aa846c91e8ee777cf6fc41517a7600dc9b7dc0fc1e5;
        uint256 y3 = 0x00a0585128fbd33a6b1a357b6f7f952a11b970073d8dcb63064e53613e7d9e38;

        PastaCurve.AffinePoint memory point3 = PastaCurve.AffinePoint(x3, y3);

        uint256 scalar1 = 0x1fc5c6553c906561a852a6d453da1928817f2e1dfa6dd33ce2aa38e834f7d460;
        uint256 scalar2 = 0x1bd76e81d96589edc288bcadc17f290addf4ba508101018f86961d3c650764f7;
        uint256 scalar3 = 0x1c32f723cc8570b54f584b78173b72eff07a6422f26a585b7815dd7543c2b7f5;

        PastaCurve.AffinePoint[] memory bases = new PastaCurve.AffinePoint[](3);
        bases[0] = point1;
        bases[1] = point2;
        bases[2] = point3;

        uint256[] memory exponents = new uint256[](3);
        exponents[0] = scalar1;
        exponents[1] = scalar2;
        exponents[2] = scalar3;

        PastaCurve.AffinePoint memory msm = pallas.multiScalarMul(bases, exponents);

        uint256 xExpected = 0x2565de35a8233431d6123bfe0632643d807071cf5664b077c5da4df8e3c3f641;
        uint256 yExpected = 0x0915100ff05cc4b9bd3422980fd3e7c34c4635956fdbcb0f2a9f3267e082dc73;

        assertEq(bytes32(xExpected), bytes32(msm.x));
        assertEq(bytes32(yExpected), bytes32(msm.y));
    }

    function testVestaMSM() public {
        /* s/pallas/vesta */

        uint256 x1 = 0x0b4a189e3b8aca95da758002798a9c66489a35d64ea6eb9bdc76a5500552aea4;
        uint256 y1 = 0x12068e83a1f78f55517f56ca69d269d4e072283e0d51faec94236960507e0d1e;

        PastaCurve.AffinePoint memory point1 = PastaCurve.AffinePoint(x1, y1);

        uint256 x2 = 0x3bb1f5d26c0899db391a66eac5b16722df026c6df555d246fc8fa813bb1818de;
        uint256 y2 = 0x0f56136af171934139893b3546b94b0567e0725986fe8a9986093bc1904eefee;

        PastaCurve.AffinePoint memory point2 = PastaCurve.AffinePoint(x2, y2);

        uint256 x3 = 0x36146c04e77073b469bea50fdf80334eca8b3412bf97d513fe1c3f186a114f51;
        uint256 y3 = 0x310bd3f23087ee568ebaaadeec05af0153f961b9102b96808fa56e48a4c463a5;

        PastaCurve.AffinePoint memory point3 = PastaCurve.AffinePoint(x3, y3);

        uint256 scalar1 = 0x15fe7f7b29cf2597419c7c48f75fb204f4b082b6a8e0bd2d73a2f2446b4e6100;
        uint256 scalar2 = 0x014f43fed74133e645256d60ea6fddb3f5db61e4e7bfc490bf85cb9c458c9ae5;
        uint256 scalar3 = 0x0e0d197668b07d988f1f5b11c94ff67287ba79d951cc8416a29c849a3ecca0f4;

        PastaCurve.AffinePoint[] memory bases = new PastaCurve.AffinePoint[](3);
        bases[0] = point1;
        bases[1] = point2;
        bases[2] = point3;

        uint256[] memory exponents = new uint256[](3);
        exponents[0] = scalar1;
        exponents[1] = scalar2;
        exponents[2] = scalar3;

        PastaCurve.AffinePoint memory msm = vesta.multiScalarMul(bases, exponents);

        uint256 xExpected = 0x2f690641193272e1add95189f83e9fd0609fa7f764da7d39519248237a8972a6;
        uint256 yExpected = 0x0effd976d3c3922fe6778e373e7347648cafbd213b0622201d6685392c8b08e0;

        assertEq(bytes32(xExpected), bytes32(msm.x));
        assertEq(bytes32(yExpected), bytes32(msm.y));
    }

    function testPallasPowSmall() public {
        /*
            use rand_core::OsRng;
            use pasta_curves::group::Group;

            type PallasScalar = pasta_curves::pallas::Scalar;

            let mut rng = OsRng;

            let q = PallasScalar::random(&mut rng);
            println!("q: {:?}", q);

            let exponent: u64 = rand::random(); 

            println!("exponent: {:?}", exponent);

            let exp_q = q.pow_vartime([exponent]);

            println!("exp_q: {:?}", exp_q);
        */

        uint256 base = 0x2bd477403f0713e5b5028dd7b3b0c2a6f21a606ebd5a19a9dd00f7e4149ca4c7;

        uint64 exponent = 12024954401023057353;

        uint256 result = pallas.powSmall(base, exponent, pallas.R_MOD());

        uint256 expected = 0x362242b2a1f2674375360e8398bdab0d1cc56f295be9ac6e39c17bc8bbc4a114;

        assertEq(bytes32(expected), bytes32(result));
    }

    function testVestaPowSmall() public {
        /*
        s/pallas/vesta
        */

        uint256 base = 0x28a66bbc0fd68c99ca92677d02d515daeddcebd8440b568bf32ba9a5d56b37c5;

        uint64 exponent = 771196355631305937;

        uint256 result = pallas.powSmall(base, exponent, vesta.R_MOD());

        uint256 expected = 0x3f0ca3245ac5c4dfe10dce43c1694588c2f4f8bc144bca88ed622987acb8ac25;

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
        uint256 scalar = pallas.fromLeBytesModOrder(abi.encodePacked(scalarBytes));

        uint256 expected = 0x0fa8e3ab80afb0a0e8a4829c823000400e6cd77323b7c46f03506d44af4c1238 % pallas.R_MOD();
        assertEq(expected, scalar);
    }

    // TODO: Failing test
    function testVestaFromLeBytesModOrder() public {
        /* s/pallas/vesta */

        bytes32 scalarBytes = 0x12a1307a83385802344c8cb32387e0b2c5e615cdb7ee2b2d149c88b52b6e667b;
        uint256 scalar = vesta.fromLeBytesModOrder(abi.encodePacked(scalarBytes));

        uint256 expected = 0x7b666e2bb5889c142d2beeb7cd15e6c5b2e08723b38c4c34025838837a30a112 % vesta.R_MOD();

        assertEq(expected, scalar);
    }

    function testPallasScalarValidation() public view {
        uint256 scalar = 0x35ab23a4edfce9b7c35cc32bf0cb9a8b0d7ed781772e31900fdb106430dcfeaa;
        pallas.validateScalarField(scalar);
    }

    function testVestaScalarValidation() public view {
        uint256 scalar = 0x40000000000000000000000000000000224698fc094cf91b992d30ed00000000;
        vesta.validateScalarField(scalar);
    }

    function testPallasPointValidation() public view {
        uint256 x = 0x37545db1df518ef152bba8c07080f4e6b08c08e7df487e732c5d799b664eb40f;
        uint256 y = 0x08dabd54ca47f62acb28f69a58d9b4f9fb27772af2df39a03cd644d8d4f260a2;
        uint256 z = 0x0d5eb59526c449a73c58ac4fc612f2564327992d7b23effec4dcff257e3e1ccb;

        PastaCurve.ProjectivePoint memory point = PastaCurve.ProjectivePoint(x, y, z);

        pallas.validateCurvePoint(pallas.IntoAffine(point));
    }

    function testVestaPointValidation() public view {
        uint256 x = 0x0c1eff5c6ebcca3f5cb7d8a2092d70c435161001ae673eaa0262ba979a27b569;
        uint256 y = 0x3f8d12cf3e81157519f5fb4df86fcd343b95de07dec3d558833ba1e4c4e03640;
        uint256 z = 0x3510c77a94bf0481de019e4cc4f3e5d50b93d6f3cb175029c561c022ed89b28a;

        PastaCurve.ProjectivePoint memory point = PastaCurve.ProjectivePoint(x, y, z);

        vesta.validateCurvePoint(vesta.IntoAffine(point));
    }

    function testPallasScalarMulProjective() public {
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

        uint256 x1 = 0x2a9787a5e39f9f8e97ea234ece859b7d657e6fa4a1feaf08e61ebaf32463e87e;
        uint256 y1 = 0x3cfba0ca6a9ee846fa0957f89035c29d1fdd1fc62693b7027198360c3588d6dc;
        uint256 z1 = 0x0000000000000000000000000000000000000000000000000000000000000001;

        PastaCurve.ProjectivePoint memory p1 = PastaCurve.ProjectivePoint(x1, y1, z1);

        uint256 scalar = 0x0716ea7ecbe554f483e62dc4a31ef8d080b35ea748906aa770491c144257819a;

        PastaCurve.ProjectivePoint memory p1MulScalar = pallas.scalarMul(p1, scalar);

        PastaCurve.AffinePoint memory affineMulScalar = pallas.IntoAffine(p1MulScalar);

        uint256 x_expected = 0x35ea0d47490c86c70ce776259a0537323f498676a11358b8c91bea2eb00d5817;
        uint256 y_expected = 0x315dba1fbee5f02fcf5205349cb4d9ff9e64eed7bfc6ead3ce90cf7c359bf3e9;
        uint256 z_expected = 0x13990e37fa334265f5f33d8c941c28dcd07a6e8219b79417ea30ba8ae162867f;

        PastaCurve.ProjectivePoint memory projectiveExpected = PastaCurve.ProjectivePoint(x_expected, y_expected, z_expected);

        PastaCurve.AffinePoint memory affineExpected = pallas.IntoAffine(projectiveExpected);


        assertEq(affineExpected.x, affineMulScalar.x);
        assertEq(affineExpected.y, affineMulScalar.y);
    }

    function testVestaScalarMulProjective() public {
        /* s/pallas/vesta */

        uint256 x1 = 0x21dc4147b0cb6ca7758d06850805c267f3df620523f722fcffa431bb318f937c;
        uint256 y1 = 0x13de5d8a0acf66f23f7e19551f9e46ad93e38ea2004e01fc1a7b11cb98f5932d;
        uint256 z1 = 0x0000000000000000000000000000000000000000000000000000000000000001;

        PastaCurve.ProjectivePoint memory p1 = PastaCurve.ProjectivePoint(x1, y1, z1);

        uint256 scalar = 0x396e4cc77da6e0f032a25401ff736ae97bd2a1dfe64424691cd4eb3bb368584f;

        PastaCurve.ProjectivePoint memory p1MulScalar = vesta.scalarMul(p1, scalar);

        PastaCurve.AffinePoint memory affineMulScalar = vesta.IntoAffine(p1MulScalar);

        uint256 x_expected = 0x3ed2b341f78f5d6843901fdb2036829d8d42af46562f4bd780dc262d5923e3de;
        uint256 y_expected = 0x1eff69777059ffde342e3ed2ecee022ec0ab5bb85e0e2ba5209ccdfc75ca8a10;
        uint256 z_expected = 0x1318d38989ad52549f1c1a50b5b02fdc58fb01e906aa5259d0e0dc199f5e7acc;

        PastaCurve.ProjectivePoint memory projectiveExpected = PastaCurve.ProjectivePoint(x_expected, y_expected, z_expected);

        PastaCurve.AffinePoint memory affineExpected = vesta.IntoAffine(projectiveExpected);

        assertEq(affineExpected.x, affineMulScalar.x);
        assertEq(affineExpected.y, affineMulScalar.y);
    }

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

        PastaCurve.AffinePoint memory p1 = PastaCurve.AffinePoint(x1, y1);

        uint256 scalar = 0x22695b548e0b09140224ef3a292349f96ac26b2b82c6fd7c31b6da1742401c6d;

        PastaCurve.AffinePoint memory p1MulScalar = pallas.scalarMul(p1, scalar);

        uint256 xExpected = 0x3a37cd0a53fd0550c75d4afde145611e65b17f568fd2965aab251dfe6d4e8de2;
        uint256 yExpected = 0x054f018342cc56e49348af0dcca916f084f153a88f5da1ad8318144b7f8dbbcf;

        assertEq(bytes32(xExpected), bytes32(p1MulScalar.x));
        assertEq(bytes32(yExpected), bytes32(p1MulScalar.y));
    }

    function testVestaScalarMulAffine() public {
        /* s/pallas/vesta */

        uint256 x1 = 0x15e5a524d9a5ce0ae02f4e048c5167363713069c3d8786c51592561b0c04d4a6;
        uint256 y1 = 0x2e028c219748d860869acc4c1874ee48515efe88fb69e896e428be8bb64c9eb2;

        PastaCurve.AffinePoint memory p1 = PastaCurve.AffinePoint(x1, y1);

        uint256 scalar = 0x21366b48aa43e1aca96125e97285e90792c92a2b734a390d4ebbaace8bd16769;

        PastaCurve.AffinePoint memory p1MulScalar = vesta.scalarMul(p1, scalar);

        uint256 xExpected = 0x29e6674d46e202f27de4bdf1b79869f0646eed86911c639595082a1a1be86b60;
        uint256 yExpected = 0x09051f62bd70626044f77f9aba1b6863faae64a3f83195a28230d3a402ce80b4;

        assertEq(bytes32(xExpected), bytes32(p1MulScalar.x));
        assertEq(bytes32(yExpected), bytes32(p1MulScalar.y));
    }

    function testPallasAddAfine() public {
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

        PastaCurve.AffinePoint memory p1 = PastaCurve.AffinePoint(x1, y1);

        uint256 x2 = 0x0faa070e87caa21bed5430a37bb7e030581509169c585a8c065a416e8c63e613;
        uint256 y2 = 0x1bd57159775742b1d80ef1d9df95bec2422af2eb3976e7fab8635920e6c690f8;

        PastaCurve.AffinePoint memory p2 = PastaCurve.AffinePoint(x2, y2);

        PastaCurve.AffinePoint memory p1p2Add = pallas.add(p1, p2);

        uint256 xExpected = 0x1d67782d21f44a1780ae2f480a01a332089105ca6c2636f1586dff07d7b103a1;
        uint256 yExpected = 0x253aa575691f2d132d816147b2f09c33372a12ca361b879c8511b163c1988624;

        assertEq(bytes32(xExpected), bytes32(p1p2Add.x));
        assertEq(bytes32(yExpected), bytes32(p1p2Add.y));
    }

    function testVestaddAffine() public {
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

        uint256 x1 = 0x0b23575e0bff63fc07130201ad378ab781952963ef8aef83788b798aebf08d72;
        uint256 y1 = 0x2352d9f36ab6a44ac5260c668e06e7f3a14fc1ea01e161f006774586c1c3ff3b;

        PastaCurve.AffinePoint memory p1 = PastaCurve.AffinePoint(x1, y1);

        uint256 x2 = 0x2d094f40c6baf06b82d1b3ba45d2343686ae578521b170e29bf5e67c54c8fe6b;
        uint256 y2 = 0x22cf0a75c77dc3eac20d8c1bd4d421d1e99e0dfe24d3dba3aebb874926e8a9b7;

        PastaCurve.AffinePoint memory p2 = PastaCurve.AffinePoint(x2, y2);

        PastaCurve.AffinePoint memory p1p2Add = vesta.add(p1, p2);

        uint256 xExpected = 0x115f0fa26e2c1bd2a9eba7ecdf3e28c272f91451178bce4a97ab3273610682a0;
        uint256 yExpected = 0x2914f54f20304abf0639a324f0775a3388b670e5592e99011ce63f07d857c9ce;

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

        PastaCurve.ProjectivePoint memory p1 = PastaCurve.ProjectivePoint(x1, y1, z1);

        uint256 x2 = 0x3dc355a2b69450add36a1bfb87342b96e29b24c997bdc4e8b30ba92d21eb2a31;
        uint256 y2 = 0x1ce32af0c379bdf5d09533ba20512e145acaaf0bb540ebc2e3ffb800f4f6e340;
        uint256 z2 = 0x0000000000000000000000000000000000000000000000000000000000000001;

        PastaCurve.ProjectivePoint memory p2 = PastaCurve.ProjectivePoint(x2, y2, z2);

        PastaCurve.ProjectivePoint memory p1p2Add = pallas.add(p1, p2);

        uint256 xExpected = 0x1450ca1656c299a3a68682867bf546d518ac9c9ae912fb4ab6a2d8997ea1bddb;
        uint256 yExpected = 0x3ffd1bac970c51adbfbdf72d42040653b1faa42283d81391e47cb6942f63d49b;
        uint256 zExpected = 0x1ff946a590678fe5a7a4380ef36cf243b1dbdd9ee32e38c07f9f4ae010998cf8;

        assertEq(bytes32(xExpected), bytes32(p1p2Add.x));
        assertEq(bytes32(yExpected), bytes32(p1p2Add.y));
        assertEq(bytes32(zExpected), bytes32(p1p2Add.z));
    }

    function testVestaAddProjective() public {
        /* s/pallas/vesta */

        uint256 x1 = 0x1cd1259dd4e44b5ee1663ba1b9c313021e315381a329a927e463cfe01653deb6;
        uint256 y1 = 0x0381de6cd994d4b0b9bd3a061f7ae5dbfb2a21ab3b37b8ec60a0add85e72c01f;
        uint256 z1 = 0x0000000000000000000000000000000000000000000000000000000000000001;

        PastaCurve.ProjectivePoint memory p1 = PastaCurve.ProjectivePoint(x1, y1, z1);

        uint256 x2 = 0x12b3feb505756a28fe167d2982cdad453a0941e0199ee66d995d95c71a989b6c;
        uint256 y2 = 0x2f744a05548c9181fba3bec46de6744a2aff4f42abb76b464e29668af683393a;
        uint256 z2 = 0x0000000000000000000000000000000000000000000000000000000000000001;

        PastaCurve.ProjectivePoint memory p2 = PastaCurve.ProjectivePoint(x2, y2, z2);

        PastaCurve.ProjectivePoint memory p1p2Add = vesta.add(p1, p2);

        uint256 xExpected = 0x0a7c9233bb5496f5d75648dc183a9c59b515d8dec0e58b53e94ed6375a9bd9e1;
        uint256 yExpected = 0x2a78075dafbfc91732721c22e8aba94dde46397bee3a2ca48fcfd1f432e1563e;
        uint256 zExpected = 0x2bc5b22e61223d943960830f9215348659f675b8f67f2368f63a76ef0889796d;

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

        PastaCurve.ProjectivePoint memory p = PastaCurve.ProjectivePoint(x, y, z);

        PastaCurve.ProjectivePoint memory doubleP = pallas.double(p);

        uint256 xExpected = 0x24dea599222651e4cd2252a7a30ec18be8b637f303edc329cc4b4422dfda8103;
        uint256 yExpected = 0x2154fb21e4af89269b0ffa144dc7a39c5bf124a47462917a050d9d398db1b8d7;
        uint256 zExpected = 0x36dabaf7d7a14b4067e41b9dfb67e7b0e5963579a4d0fa213375bc0757699d22;

        assertEq(bytes32(xExpected), bytes32(doubleP.x));
        assertEq(bytes32(yExpected), bytes32(doubleP.y));
        assertEq(bytes32(zExpected), bytes32(doubleP.z));
    }

    function testVestaDoubleProjective() public {
        /* s/pallas/vesta */

        uint256 x = 0x3e4b97b7166a00da0a7b681275edb719b2910c43ec178c0c8e8b624f28e59b9d;
        uint256 y = 0x0dfbbf73b1098a34ab6bd6397d7acb68abf5910ab741d597389f8c424cb55b67;
        uint256 z = 0x0000000000000000000000000000000000000000000000000000000000000001;

        PastaCurve.ProjectivePoint memory p = PastaCurve.ProjectivePoint(x, y, z);

        PastaCurve.ProjectivePoint memory doubleP = vesta.double(p);

        uint256 xExpected = 0x1a8c3f39c4dff80d07e8ecf0605af7283247817b737eac4e8739bb33832f7070;
        uint256 yExpected = 0x322c7e8c3381aff79076d30d3169cad46140659df7cd396127a1d67afd5a7381;
        uint256 zExpected = 0x1bf77ee76213146956d7ac72faf596d157eb22156e83ab2e713f1884996ab6ce;

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
        uint256 minusScalar = pallas.negate(scalar);

        uint256 expected = 0x11624bf59f129e49185242521f4f72ca5c37e1ceb985843d3780b67a901f4cd0;
        assertEq(bytes32(expected), bytes32(minusScalar));
    }

    function testVestaNegateScalar() public {
        /* s/pallas/vesta */

        uint256 scalar = 0x2d9c1fab594375189e3cda886533ff6007762c11ceeb4e2a908bb52935e55fae;
        uint256 minusScalar = vesta.negate(scalar);

        uint256 expected = 0x1263e054a6bc8ae761c325779acc00a01ad06cea3a61aaf108a17bc3ca1aa053;
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

        PastaCurve.AffinePoint memory p = PastaCurve.AffinePoint(x, y);

        PastaCurve.AffinePoint memory minusP = pallas.negate(p);

        uint256 xExpected = 0x21f2cbf70ab36a05d7bb34b6b64ae2f51cc58c9f6f43e38c384bd3a44e02ee76;
        uint256 yExpected = 0x3f4aaefe3dd2dd8c4ddc0627012879c6ba46f70759b79e436998aa06152e158c;

        assertEq(bytes32(xExpected), bytes32(minusP.x));
        assertEq(bytes32(yExpected), bytes32(minusP.y));
    }

    function testVestaNegateAffine() public {
        /* s/pallas/vesta */

        uint256 x = 0x1a128fbcb7e495cb5eb3904494f1eafa30caf9b4ad31ed29a6c51004bbe1abc3;
        uint256 y = 0x1f5628e50b707f3b95b2b55a87f6bbb9bf6be717282c8a98cd189d7a12457041;

        PastaCurve.AffinePoint memory p = PastaCurve.AffinePoint(x, y);

        PastaCurve.AffinePoint memory minusP = vesta.negate(p);

        uint256 xExpected = 0x1a128fbcb7e495cb5eb3904494f1eafa30caf9b4ad31ed29a6c51004bbe1abc3;
        uint256 yExpected = 0x20a9d71af48f80c46a4d4aa57809444662dab1e4e1681e44bf2e4da6edba8fc0;

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

        PastaCurve.ProjectivePoint memory p = PastaCurve.ProjectivePoint(x, y, z);

        PastaCurve.ProjectivePoint memory minusP = pallas.negate(p);

        uint256 xExpected = 0x3e9ccc4bed28364439802d73e01b1371bfe6d94e4fab63c0cad0f660abaeb5f0;
        uint256 yExpected = 0x0af9182bc497e08ad40792f0a5a7e56115864451cc10cdac31704a3ccd6adc36;
        uint256 zExpected = 0x0000000000000000000000000000000000000000000000000000000000000001;

        assertEq(bytes32(xExpected), bytes32(minusP.x));
        assertEq(bytes32(yExpected), bytes32(minusP.y));
        assertEq(bytes32(zExpected), bytes32(minusP.z));
    }

    function testVestaNegateProjective() public {
        /* s/pallas/vesta */

        uint256 x = 0x0b2c3f43b9dd807ce942cb6322b46ac4fee411d9ce17289f5bdae1fac5d01035;
        uint256 y = 0x03a3e8a25a983fe5104a269b05da77d7a5750a163de7d18acd84b45256d90dc2;
        uint256 z = 0x0000000000000000000000000000000000000000000000000000000000000001;

        PastaCurve.ProjectivePoint memory p = PastaCurve.ProjectivePoint(x, y, z);

        PastaCurve.ProjectivePoint memory minusP = vesta.negate(p);

        uint256 xExpected = 0x0b2c3f43b9dd807ce942cb6322b46ac4fee411d9ce17289f5bdae1fac5d01035;
        uint256 yExpected = 0x3c5c175da567c01aefb5d964fa2588287cd18ee5cbacd752bec236cea926f23f;
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

        PastaCurve.ProjectivePoint memory pointProjective = PastaCurve.ProjectivePoint(x, y, z);

        PastaCurve.AffinePoint memory pointAffine = pallas.IntoAffine(pointProjective);

        uint256 xExpected = 0x01c296ffab785ef499226010ea6cca1829c705b28e104342ba5337701379c54a;
        uint256 yExpected = 0x12aed2775c0c1d07489f129b07eb86d7c12d3147cfcb5d6ab54ab6a39d362334;
        assertEq(bytes32(xExpected), bytes32(pointAffine.x));
        assertEq(bytes32(yExpected), bytes32(pointAffine.y));
    }

    function testVestaToAffine() public {
        /* s/pallas/vesta */
        
        uint256 x = 0x0e1f9acd0f17819e1f2eaaafe11c430789a939dacf5ff33f0ae6c4a5b706e5dc;
        uint256 y = 0x1988bff490069754e66a11f37ac87a7895eb10978a6cf9592b3e6c0faf0f5d94;
        uint256 z = 0x0000000000000000000000000000000000000000000000000000000000000001;

        PastaCurve.ProjectivePoint memory pointProjective = PastaCurve.ProjectivePoint(x, y, z);

        PastaCurve.AffinePoint memory pointAffine = vesta.IntoAffine(pointProjective);

        uint256 xExpected = 0x0e1f9acd0f17819e1f2eaaafe11c430789a939dacf5ff33f0ae6c4a5b706e5dc;
        uint256 yExpected = 0x1988bff490069754e66a11f37ac87a7895eb10978a6cf9592b3e6c0faf0f5d94;
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

        PastaCurve.ProjectivePoint memory point = pallas.ProjectiveGenerator();
        assertEq(bytes32(point.x), bytes32(pallasGeneratorXexpected));
        assertEq(bytes32(point.y), bytes32(pallasGeneratorYexpected));
        assertEq(bytes32(point.z), bytes32(pallasGeneratorZexpected));
    }

    function testVestaProjectiveGenerator() public {
        /* s/pallas/vesta */

        uint256 vestaGeneratorXexpected = 0x40000000000000000000000000000000224698fc0994a8dd8c46eb2100000000;
        uint256 vestaGeneratorYexpected = 0x0000000000000000000000000000000000000000000000000000000000000002;
        uint256 vestaGeneratorZexpected = 0x0000000000000000000000000000000000000000000000000000000000000001;

        PastaCurve.ProjectivePoint memory point = vesta.ProjectiveGenerator();
        assertEq(bytes32(point.x), bytes32(vestaGeneratorXexpected));
        assertEq(bytes32(point.y), bytes32(vestaGeneratorYexpected));
        assertEq(bytes32(point.z), bytes32(vestaGeneratorZexpected));
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

        PastaCurve.AffinePoint memory point = pallas.AffineGenerator();
        assertEq(bytes32(point.x), bytes32(pallasGeneratorXexpected));
        assertEq(bytes32(point.y), bytes32(pallasGeneratorYexpected));
    }

    function testVestaAffineGenerator() public {
        /* s/pallas/vesta */

        uint256 vestaGeneratorXexpected = 0x40000000000000000000000000000000224698fc0994a8dd8c46eb2100000000;
        uint256 vestaGeneratorYexpected = 0x0000000000000000000000000000000000000000000000000000000000000002;

        PastaCurve.AffinePoint memory point = vesta.AffineGenerator();
        assertEq(bytes32(point.x), bytes32(vestaGeneratorXexpected));
        assertEq(bytes32(point.y), bytes32(vestaGeneratorYexpected));
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
        uint256 inverted = pallas.invert(pallasScalar, pallas.R_MOD());
        assertEq(bytes32(inverted), bytes32(0x1ec5d74264fcb22d01cb7c46b1f129637e5fd7990100b3b64e7e937360bcbfac));
    }

    function testVestaInvertFr() public {
        /* s/pallas/vesta */

        uint256 vestaScalar = 0x32642babe229d616c0221a7c8fb94f442088f6947752b98115240705ca7d15ec;
        uint256 inverted = vesta.invert(vestaScalar, vesta.R_MOD());
        assertEq(bytes32(inverted), bytes32(0x130b3c43d6025758f4e5ed60d9e70fa5f7f5a40ec523584f696237878975aa6f));
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

        PastaCurve.ProjectivePoint memory pallasPoint = PastaCurve.ProjectivePoint(x, y, z);

        uint256 pallasScalar = 0x0000000000000000000000000000000000000000000000000000000000000002;

        uint256 xExpected = 0x2536526b90b66c6378b88c47426bdf67cd7fd5d732ada454524c1e01ff3ad79c;
        uint256 yExpected = 0x3366fc096d6a773f90c4aefab527576a6c0855aefa25e88e3d958fcba2ee9168;
        uint256 zExpected = 0x2c5de6da0e072c6ff4934cdd283460d6080cf2b266d400a8cdad1a2158024cb3;

        PastaCurve.ProjectivePoint memory actual = pallas.scalarMul(pallasPoint, pallasScalar);

        assertEq(bytes32(xExpected), bytes32(actual.x));
        assertEq(bytes32(yExpected), bytes32(actual.y));
        assertEq(bytes32(zExpected), bytes32(actual.z));
    }

    function testVestaScalarMulProjective_1() public {
        /* s/pallas/vesta */

        uint256 x = 0x05bf0832f25e66ea75be3af90fcd28c0232756458625a40a2d9cfeaa9b4f032a;
        uint256 y = 0x236d3a1f6f901f16355d9a7be3f1425575e3b022e584365af1c6a46d4fcb37d7;
        uint256 z = 0x0000000000000000000000000000000000000000000000000000000000000001;

        PastaCurve.ProjectivePoint memory vestaPoint = PastaCurve.ProjectivePoint(x, y, z);

        uint256 vestaScalar = 0x0000000000000000000000000000000000000000000000000000000000000002;

        uint256 xExpected = 0x0b644f389adada02f4c689d58b0d3ccc33659850b35c8a1c6a758bead81fc2c3;
        uint256 yExpected = 0x06ed4ad17e5e869cdca91e94c2e584cf4998288ed00de3233647df64b51837f6;
        uint256 zExpected = 0x06da743edf203e2c6abb34f7c7e284aac980c749c173c3d857465db99f966fad;

        PastaCurve.ProjectivePoint memory actual = vesta.scalarMul(vestaPoint, vestaScalar);

        assertEq(bytes32(xExpected), bytes32(actual.x));
        assertEq(bytes32(yExpected), bytes32(actual.y));
        assertEq(bytes32(zExpected), bytes32(actual.z));
    }

    function testPallasScalarMulProjective_2() public {
        uint256 x_ = 0x02807566a47b423db7b3c63b2d7eb090384a13af6f7b08dec55d498a3e1e2e4a;
        uint256 y_ = 0x1879f1b3da88f5619e1c7162fcc3703ace2a46d4a69b79ae5d7c40fc7d3213b7;
        uint256 z_ = 0x0000000000000000000000000000000000000000000000000000000000000001;

        PastaCurve.ProjectivePoint memory pallasPoint = PastaCurve.ProjectivePoint(x_, y_, z_);

        uint256 pallasScalar = 0x0000000000000000000000000000000000000000000000000000000000000001;
        pallas.validateScalarField(pallasScalar);

        uint256 x = 0x02807566a47b423db7b3c63b2d7eb090384a13af6f7b08dec55d498a3e1e2e4a;
        uint256 y = 0x1879f1b3da88f5619e1c7162fcc3703ace2a46d4a69b79ae5d7c40fc7d3213b7;
        uint256 z = 0x0000000000000000000000000000000000000000000000000000000000000001;
        PastaCurve.ProjectivePoint memory expected = PastaCurve.ProjectivePoint(x, y, z);

        // checking that P * 1 = P
        PastaCurve.ProjectivePoint memory actual = pallas.scalarMul(pallasPoint, pallasScalar);

        assertEq(expected.x, actual.x);
        assertEq(expected.y, actual.y);
        assertEq(expected.z, actual.z);

        // checking that P + P = P * 2
        PastaCurve.ProjectivePoint memory addition1 = pallas.add(expected, actual);

        uint256 pallasScalarTwo = 0x0000000000000000000000000000000000000000000000000000000000000002;
        pallas.validateScalarField(pallasScalarTwo);

        PastaCurve.ProjectivePoint memory addition2 = pallas.scalarMul(expected, pallasScalarTwo);

        assertEq(addition1.x, addition2.x);
        assertEq(addition1.y, addition2.y);
        assertEq(addition1.z, addition2.z);
    }

    function testVestaScalarMulProjective_2() public {
        uint256 x_ = 0x31a8602af8e58990004c7176317f9fc14e4d3758719c03bbe2b77fb3736883b2;
        uint256 y_ = 0x3fdbe932ebc2a0e21d14387572006097a53d79eb8ea24d2f1f64adf45f32ddbd;
        uint256 z_ = 0x0000000000000000000000000000000000000000000000000000000000000001;

        PastaCurve.ProjectivePoint memory vestaPoint = PastaCurve.ProjectivePoint(x_, y_, z_);

        uint256 vestaScalar = 0x0000000000000000000000000000000000000000000000000000000000000001;
        vesta.validateScalarField(vestaScalar);

        uint256 x = 0x31a8602af8e58990004c7176317f9fc14e4d3758719c03bbe2b77fb3736883b2;
        uint256 y = 0x3fdbe932ebc2a0e21d14387572006097a53d79eb8ea24d2f1f64adf45f32ddbd;
        uint256 z = 0x0000000000000000000000000000000000000000000000000000000000000001;
        PastaCurve.ProjectivePoint memory expected = PastaCurve.ProjectivePoint(x, y, z);

        // checking that P * 1 = P
        PastaCurve.ProjectivePoint memory actual = vesta.scalarMul(vestaPoint, vestaScalar);

        assertEq(expected.x, actual.x);
        assertEq(expected.y, actual.y);
        assertEq(expected.z, actual.z);

        // checking that P + P = P * 2
        PastaCurve.ProjectivePoint memory addition1 = vesta.add(expected, actual);

        uint256 vestaScalarTwo = 0x0000000000000000000000000000000000000000000000000000000000000002;
        vesta.validateScalarField(vestaScalarTwo);

        PastaCurve.ProjectivePoint memory addition2 = vesta.scalarMul(expected, vestaScalarTwo);

        assertEq(addition1.x, addition2.x);
        assertEq(addition1.y, addition2.y);
        assertEq(addition1.z, addition2.z);
    }
}
