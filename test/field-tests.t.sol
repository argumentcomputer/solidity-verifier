// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@std/Test.sol";
import "src/Field.sol";
import "src/pasta/Pallas.sol";
import "src/pasta/Vesta.sol";

contract FieldLibraryTest is Test {
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
        uint256 inverted = Field.invert(pallasScalar, Pallas.R_MOD);
        assertEq(bytes32(inverted), bytes32(0x1ec5d74264fcb22d01cb7c46b1f129637e5fd7990100b3b64e7e937360bcbfac));
    }

    function testVestaInvertFr() public {
        /* s/pallas/vesta */

        uint256 vestaScalar = 0x32642babe229d616c0221a7c8fb94f442088f6947752b98115240705ca7d15ec;
        uint256 inverted = Field.invert(vestaScalar, Vesta.R_MOD);
        assertEq(bytes32(inverted), bytes32(0x130b3c43d6025758f4e5ed60d9e70fa5f7f5a40ec523584f696237878975aa6f));
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

        uint256 result = Field.powSmall(base, exponent, Pallas.R_MOD);

        uint256 expected = 0x362242b2a1f2674375360e8398bdab0d1cc56f295be9ac6e39c17bc8bbc4a114;

        assertEq(bytes32(expected), bytes32(result));
    }

    function testVestaPowSmall() public {
        /*
        s/pallas/vesta
        */

        uint256 base = 0x28a66bbc0fd68c99ca92677d02d515daeddcebd8440b568bf32ba9a5d56b37c5;

        uint64 exponent = 771196355631305937;

        uint256 result = Field.powSmall(base, exponent, Vesta.R_MOD);

        uint256 expected = 0x3f0ca3245ac5c4dfe10dce43c1694588c2f4f8bc144bca88ed622987acb8ac25;

        assertEq(bytes32(expected), bytes32(result));
    }

    function testSqrt() view public {
        /*
            sage: GF(32183)(392).sqrt()
            sage: GF(32183)(1994).sqrt()
            sage: GF(738283496539)(4958723045).sqrt()
            sage: GF(738283496539)(619100439513669).sqrt()
            sage: p = 28948022309329048855892746252171976963363056481941560715954676764349967630337
            sage: q = 28948022309329048855892746252171976963363056481941647379679742748393362948097
            sage: GF(p)(39192938138472398475092837459827349058720398457082340503458).sqrt()
            sage: GF(q)(8234882384828389199345394599345003450304929342349912032349).sqrt() 

        */
        uint256 smallP = 32183;
        assert((Field.sqrt(392, smallP) == 15294) || (Field.sqrt(392, smallP) == smallP - 15294));
        assert((Field.sqrt(1994, smallP) == 5397) || (Field.sqrt(1994, smallP) == smallP - 5397));
        
        uint256 mediumP = 738283496539;
        assert((Field.sqrt(4958723045, mediumP) == 34190259867) || (Field.sqrt(4958723045, mediumP) == mediumP - 34190259867));
        assert((Field.sqrt(619100439513669, mediumP) == 721501758733) || (Field.sqrt(619100439513669, mediumP) == mediumP - 721501758733));

        assert((Field.sqrt(39192938138472398475092837459827349058720398457082340503458, Pallas.P_MOD) == 6952326682511089053505497910269311565103218810361727881723961806337596520691) || (Field.sqrt(39192938138472398475092837459827349058720398457082340503458, Pallas.P_MOD) == Pallas.P_MOD - 6952326682511089053505497910269311565103218810361727881723961806337596520691));
        assert((Field.sqrt(8234882384828389199345394599345003450304929342349912032349, Vesta.P_MOD) == 12180706984407879127889907639794534706595779502336066753700348335280986255802) || (Field.sqrt(8234882384828389199345394599345003450304929342349912032349, Vesta.P_MOD) == Vesta.P_MOD - 12180706984407879127889907639794534706595779502336066753700348335280986255802));
    }

}