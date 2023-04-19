// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/pasta/PastaContracts.sol";
import "../src/pasta/PallasLib.sol";
import "../src/pasta/VestaLib.sol";

contract PastaCurvesContractTests is Test {

    PallasContract pallas;
    VestaContract vesta;

    function setUp() public {
        pallas = new PallasContract();
        vesta = new VestaContract();
    }

    /*
    function utilities() public {
        Pallas.PallasAffinePoint memory pointPallas = pallas.affineGenerator();

        //console.log("pallas x: ", pointPallas.x);
        //console.log("pallas y: ", pointPallas.y);

        Vesta.VestaAffinePoint memory pointVesta = vesta.affineGenerator();

        //console.log("vesta x: ", pointVesta.x);
        //console.log("vesta y: ", pointVesta.y);

        assert(!pallas.isAffineInfinity(pointPallas));

        assert(!vesta.isAffineInfinity(pointVesta));

        pallas.validateCurvePoint(pointPallas);

        vesta.validateCurvePoint(pointVesta);

        uint256 pointVestaFromBytes = vesta.fromLeBytesModOrder(bytes32ToBytes(0x01749F991CFE31A6547A671AF292C8F28B9CE9A6FCBD0B06B5B62E160799165D));

    }
    */

    function testDebug() public {
        uint256 x = 0x3f2c8a8b8128a470f4f9231d9c9361bbbbbcde77b44c9e0a2e3bb46ce24beb7f;
        uint256 y = 0x01519840885e662c3cec5b77dd4869ad67c6c20f4b9bbb0ad2aaca8ac5a3c574;
        uint256 z = 0x0000000000000000000000000000000000000000000000000000000000000001;

        Pallas.PallasProjectivePoint memory pointPallasFromXYZ = Pallas.PallasProjectivePoint(x, y, z);

        assertEq(x, pointPallasFromXYZ.x);
        assertEq(y, pointPallasFromXYZ.y);
        assertEq(z, 1);

        Pallas.PallasAffinePoint memory pointPallasFromXYZAffine = pallas.toAffine(pointPallasFromXYZ);
        pallas.validateCurvePoint(pointPallasFromXYZAffine);
    }

    function testPallasInvertFr() public {
        /*
            let pallas_scalar = PallasScalar::from(2u64);
            println!("pallas scalar: {:?}", pallas_scalar);

            let pallas_scalar_inverted = pallas_scalar.invert().unwrap();
            println!("pallas scalar inverted: {:?}", pallas_scalar_inverted);
        */

        uint256 pallas_scalar = 0x0000000000000000000000000000000000000000000000000000000000000002;
        uint256 inverted = pallas.invertFr(pallas_scalar);
        assertEq(bytes32(inverted), bytes32(0x2000000000000000000000000000000011234c7e04ca546ec623759080000001));

        /*
            let pallas_scalar = PallasScalar::from(u64::MAX);
            println!("pallas scalar: {:?}", pallas_scalar);

            let pallas_scalar_inverted = pallas_scalar.invert().unwrap();
            println!("pallas scalar inverted: {:?}", pallas_scalar_inverted);
        */

        uint256 pallas_scalar_u64_rust_max = 0x000000000000000000000000000000000000000000000000ffffffffffffffff;
        uint256 inverted2 = pallas.invertFr(pallas_scalar_u64_rust_max);
        assertEq(bytes32(inverted2), bytes32(0x0c06b929d45b65578c06b929d45b655792778fa1e6f5858378f3903aae926aa1));
    }

    function testPallasInvertFrRandom() public {
        /*
            let pallas_scalar = PallasScalar::random(&mut rng);;
            println!("pallas scalar: {:?}", pallas_scalar);

            let pallas_scalar_inverted = pallas_scalar.invert().unwrap();
            println!("pallas scalar inverted: {:?}", pallas_scalar_inverted);
        */

        uint256 pallas_scalar = 0x0dc81d4e3f3a9e56ff1c4fa305c30d8db5bf3b507e590e0316217fd3d78d3b9e;
        uint256 inverted = pallas.invertFr(pallas_scalar);
        assertEq(bytes32(inverted), bytes32(0x030fba1cfbbd212b5eed438de5d8e4f4aa4069c9c54bf6b0d46ba9b9447a13ab));
    }

    // TODO: add scalar multiplication test with random scalar and scalar, greater than 2
    function testPallasPointScalarMultiplication_1() public {
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

        uint256 x_ = 0x2c4ed92736886d0c2a9472a429ff368d4a9e634cc8752e32f55d18f09d8a1a5d;
        uint256 y_ = 0x362ef36d07039637fa49a66e941a306b1529c5d738107ce2336d25872c01265a;
        uint256 z_ = 0x0000000000000000000000000000000000000000000000000000000000000001;

        Pallas.PallasProjectivePoint memory pallasPoint = Pallas.PallasProjectivePoint(x_, y_, z_);

        uint256 pallasScalar = 0x0000000000000000000000000000000000000000000000000000000000000002;

        uint256 x = 0x2536526b90b66c6378b88c47426bdf67cd7fd5d732ada454524c1e01ff3ad79c;
        uint256 y = 0x3366fc096d6a773f90c4aefab527576a6c0855aefa25e88e3d958fcba2ee9168;
        uint256 z = 0x2c5de6da0e072c6ff4934cdd283460d6080cf2b266d400a8cdad1a2158024cb3;
        Pallas.PallasProjectivePoint memory expected = Pallas.PallasProjectivePoint(x, y, z);

        Pallas.PallasProjectivePoint memory actual = pallas.projectiveScalarMul(pallasPoint, pallasScalar);

        assertEq(bytes32(expected.x), bytes32(actual.x));
        assertEq(bytes32(expected.y), bytes32(actual.y));
        assertEq(bytes32(expected.z), bytes32(actual.z));
    }

    function testPallasPointScalarMultiplication_2() public {
        uint256 x_ = 0x02807566a47b423db7b3c63b2d7eb090384a13af6f7b08dec55d498a3e1e2e4a;
        uint256 y_ = 0x1879f1b3da88f5619e1c7162fcc3703ace2a46d4a69b79ae5d7c40fc7d3213b7;
        uint256 z_ = 0x0000000000000000000000000000000000000000000000000000000000000001;

        Pallas.PallasProjectivePoint memory pallasPoint = Pallas.PallasProjectivePoint(x_, y_, z_);

        uint256 pallasScalar = 0x0000000000000000000000000000000000000000000000000000000000000001;
        pallas.validateScalarField(pallasScalar);

        uint256 x = 0x02807566a47b423db7b3c63b2d7eb090384a13af6f7b08dec55d498a3e1e2e4a;
        uint256 y = 0x1879f1b3da88f5619e1c7162fcc3703ace2a46d4a69b79ae5d7c40fc7d3213b7;
        uint256 z = 0x0000000000000000000000000000000000000000000000000000000000000001;
        Pallas.PallasProjectivePoint memory expected = Pallas.PallasProjectivePoint(x, y, z);

        // checking that P * 1 = P
        Pallas.PallasProjectivePoint memory actual = pallas.projectiveScalarMul(pallasPoint, pallasScalar);

        assertEq(expected.x, actual.x);
        assertEq(expected.y, actual.y);
        assertEq(expected.z, actual.z);

        // checking that P + P = P * 2
        Pallas.PallasProjectivePoint memory addition1 = pallas.projectiveAdd(expected, actual);

        uint256 pallasScalarTwo = 0x0000000000000000000000000000000000000000000000000000000000000002;
        pallas.validateScalarField(pallasScalarTwo);

        Pallas.PallasProjectivePoint memory addition2 = pallas.projectiveScalarMul(expected, pallasScalarTwo);

        assertEq(addition1.x, addition2.x);
        assertEq(addition1.y, addition2.y);
        assertEq(addition1.z, addition2.z);
    }

    function testPallasScalarImport() public view {
        /*
            Pallas scalar generated with the following Rust code:

            ```
                use rand_core::OsRng;

                type Scalar = pasta_curves::vesta::Scalar;
                let mut rng = OsRng;

                let vesta_scalar = Scalar::random(&mut rng);
                println!("vesta scalar: {:?}", vesta_scalar);
            ```
        */
        uint256 raw_pallas_scalar = 0x35d347c42b4964f332a153d84c17608baf6052b55c20801437cc64f38a97d09d;

        pallas.validateScalarField(raw_pallas_scalar);
    }

    function testVestaScalarImport() public view {
        /*
            Vesta scalar generated with the following Rust code:

            ```
                use rand_core::OsRng;

                type Scalar = pasta_curves::vesta::Scalar;
                let mut rng = OsRng;

                let vesta_scalar = Scalar::random(&mut rng);
                println!("vesta scalar: {:?}", vesta_scalar);
            ```
        */
        uint256 raw_vesta_scalar = 0x3c7b61f953a6fc1c2346b9b053940379478068187abc483bcb163427668405d7;

        vesta.validateScalarField(raw_vesta_scalar);
    }

    function testVestaPointImport() public {
        /*
            Pallas point coordinates generated with the following Rust code (it is guaranteed that point is on curve):

            ```
                use rand_core::OsRng;
                use pasta_curves::group::Group;

                type G1 = pasta_curves::pallas::Point;
                let mut rng = OsRng;

                let pallas_point = G1::random(&mut rng);
                println!("pallas: {:?}", pallas_point);

                let pallas_point = pallas_point.to_affine();
                println!("pallas affine: {:?}", pallas_point);
            ```
        */

        uint256 x = 0x2282b63faed97514f830f8111ffa9351bb32a2605f27fef69b873ffb30875c97;
        uint256 y = 0x066429dadc25df840526c110ac7cdeebe1efb550729770c9e6724c4548fc7c36;
        uint256 z = 1;

        Vesta.VestaProjectivePoint memory vestaPointFromXYZ = Vesta.VestaProjectivePoint(x, y, z);
        assertEq(vestaPointFromXYZ.x, x);
        assertEq(vestaPointFromXYZ.y, y);
        assertEq(vestaPointFromXYZ.z, z);

        Vesta.VestaAffinePoint memory vestaPointFromXYZAffine = vesta.toAffine(vestaPointFromXYZ);
        vesta.validateCurvePoint(vestaPointFromXYZAffine);
    }

    function testPallasPointImport() public {
        /*
            Pallas point coordinates generated with the following Rust code (it is guaranteed that point is on curve):

            ```
                use rand_core::OsRng;
                use pasta_curves::group::Group;

                type G1 = pasta_curves::pallas::Point;
                let mut rng = OsRng;

                let pallas_point = G1::random(&mut rng);
                println!("pallas: {:?}", pallas_point);

                let pallas_point = pallas_point.to_affine();
                println!("pallas affine: {:?}", pallas_point);
            ```
        */

        uint256 x = 0x3f2c8a8b8128a470f4f9231d9c9361bbbbbcde77b44c9e0a2e3bb46ce24beb7f;
        uint256 y = 0x01519840885e662c3cec5b77dd4869ad67c6c20f4b9bbb0ad2aaca8ac5a3c574;
        uint256 z = 0x0000000000000000000000000000000000000000000000000000000000000001;

        Pallas.PallasProjectivePoint memory pointPallasFromXYZ = Pallas.PallasProjectivePoint(x, y, z);
        assertEq(x, pointPallasFromXYZ.x);
        assertEq(y, pointPallasFromXYZ.y);
        assertEq(z, pointPallasFromXYZ.z);

        Pallas.PallasAffinePoint memory pointPallasFromXYZAffine = pallas.toAffine(pointPallasFromXYZ);
        pallas.validateCurvePoint(pointPallasFromXYZAffine);
    }

    /*
    function bytes32ToBytes(bytes32 _data) public pure returns (bytes memory) {
        return abi.encodePacked(_data);
    }
    */
}
