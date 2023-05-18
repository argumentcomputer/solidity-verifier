// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@std/Test.sol";
import "src/poseidon/PoseidonNeptuneU24pallas.sol";

contract PoseidonContractTest is Test {
    function testPoseidonNeptuneU24PallasCompatibility() public {
        /*
            let domain_separation = HashType::Sponge;
            let security_level = Strength::Standard;
            let constants: PoseidonConstants<Fp, U24> =
                PoseidonConstants::new_with_strength_and_type(security_level, domain_separation);

            let mut new = Poseidon::<Fp, U24>::new(&constants);

            let mut rng = OsRng;
            let random_data= (0..24).into_iter().map(|_| {
            let scalar = Fp::random(&mut rng);
                println!("scalar: {:?}", scalar);
                scalar
            }).collect::<Vec<Fp>>();

            new.set_preimage(&random_data);

            let digest = new.hash_in_mode(HashMode::Correct);
            println!("\ndigest: {:?}", digest);
        */
        uint pallasCurveModulus = uint(bytes32(0x40000000000000000000000000000000224698fc094cf91b992d30ed00000001));

        PoseidonU24Pallas.HashInputs25 memory state = PoseidonU24Pallas.HashInputs25 (
            0x0000000000000000000000000000000000000000000000000000000000000000,
            0x08c367263dbcf5935e1c02c04358695d5fb90ae1a4c9309c09c9d9ad1a7ed817,
            0x05f4510c8e36dbbee6e073eb91e0f357ccd6e0c8e94074e7474cb706b5402423,
            0x19da8ff4e08de78a1e009dc935a80ca0b3a22a5418ec8ccfa0211377d07423fe,
            0x2a40b1f88b8ea34ed82c582975736d5c5595df692fea3ca0d4e933631aee4c8c,
            0x27ff0bac55faf230e4c2896c18480c733d4845d3baf43621a5fcf05985ff9aa0,
            0x088147cc67aca31d6f840a8d9ee300a81163391c022b870e8320bce8f7cf4aff,
            0x2af6de079ea443eab6e06e5e48c470a25feace7343361a5d210ddb511e8c44da,
            0x0f680b59a3dc6171fbce3b350cbc8187f658eb58d566d2cf400187462684ac62,
            0x11dc195884a47c4aaf3de8707b47be9a02eaab10fccd334501df52a9dfef44de,
            0x18918fe8e902794bbacbd82c4f5f638fbd5f26f2f786d5322f5703183c69e79a,
            0x24de4c971cb63b82389e133d4841ed7e05bbe2371490f98940cb9c0e6390ea0a,
            0x358aa40b9920f94e6f02364c11c86b333944d5a5b01fe5394112f4e425c912c3,
            0x1035b8dc849960310dbc39d563aecebdee045730340ccd1f6a2a0e8b61af147e,
            0x21a8370f4a968a3066273798627c6f38af3a52fb36e14b5f7484e2c7df420e7c,
            0x0992f3029999175ab3e9586c5ecf7c0c63c27990aa3ff693d6d9ee70d43365b5,
            0x0779528e3c683298e86e9538872d22e5e5a17f66ae3ecdc4fb440d64254a9fff,
            0x0390cd1912aeec531cd72f44905cefd43f6e14ca78d9304d0bf19192306f9433,
            0x3afbf6b3307e81190f660c2acd8772e93da6851fbe5b3a602e1c6e672f22eb67,
            0x16d2b1dddd74924cabb81d87d7047878eafe4775ea2c8ab19dd16df8c5b7837f,
            0x3f77da1a4afbaaaf4c41fdf808cf9a4e9c698ebeb9304eedcf528e1e23a6351a,
            0x18256703fa5cc1f5b9d2db75b256d1f2d74b0bb89c951048167c718a9b794c4a,
            0x189de460920b31c667a5a9b2d1d6ae05b69d4d407649571e17924d68f1d578f4,
            0x1ed1d1168009a2710e264f030da787e5aab7f11128828fa3e69fce623817b53a,
            0x251fc5ac3427e9d295a88e350c65f0f9c17a05d80ebc462d9557f1024592656a
        );

        uint actual = PoseidonU24Pallas.hash(state, pallasCurveModulus);

        uint expected = 0x0a85fc12d012ed3ae407c1589fb0e2eb0fe337f1d4c3374a785a89a134cbdf47;

        assertEq(expected, actual);
    }
}
