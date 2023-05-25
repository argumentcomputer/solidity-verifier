// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@std/Test.sol";
import "src/poseidon/PoseidonNeptuneU24pallas.sol";
import "src/poseidon/PoseidonNeptuneU24vesta.sol";

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

    function testPoseidonNeptuneU24VestaCompatibility() public {
        /*
            let domain_separation = HashType::Sponge;
            let security_level = Strength::Standard;
            let constants: PoseidonConstants<Fq, U24> =
                PoseidonConstants::new_with_strength_and_type(security_level, domain_separation);


            let mut new = Poseidon::<Fq, U24>::new(&constants);

            let mut rng = OsRng;
            let random_data= (0..24).into_iter().map(|_| {
                let scalar = Fq::random(&mut rng);
                scalar
            }).collect::<Vec<Fq>>();

            new.set_preimage(&random_data);

            let digest = new.hash_in_mode(HashMode::Correct);
            println!("\ndigest: {:?}", digest);
        */

        uint vestaCurveModulus = uint(bytes32(0x40000000000000000000000000000000224698fc0994a8dd8c46eb2100000001));
        PoseidonU24Vesta.HashInputs25 memory state = PoseidonU24Vesta.HashInputs25 (
            0x0000000000000000000000000000000000000000000000000000000000000000,
            0x082c5d2a623d16dbff291b613201013e981eecdb655a4a194e7515ad6bdc3030,
            0x0391318ddaa0e9ececaf60b67e4747ba43b9f439abe98f76af386d968783a0cd,
            0x2aa3838f5178c2059b3a190106189bc75ed634b16dadd4aecccaf0ebaf002fd8,
            0x1d1fab4a0b06b9b341026ba9270fc04cb4623ee1daaed72ac83ee7cdfc09b85d,
            0x0f1ead1c4d3f334433d955fa82f252a549e40b86c39ae092644ef5ad0930ee2d,
            0x35f34227b178373a44d67d3c07df47da42a0ed6c46fb47a19445ecae11627646,
            0x33fd0fce976cc42aec93da35b5e93dbf46afa24156929ec3353df549fa183c57,
            0x3b131390696d9b30870d527ba1025ca6ed648fdbc05c16de1fa2a9d48d3c088f,
            0x0404fcc533cc057b11f2084f9fea5eaaf29b10f61810c25befb8c19c4191f6b2,
            0x25f5a5ad241b421acf200c422af9ac08163086750f2de40b8441100887653d53,
            0x2440afe684c1efd9464edeb2eb573ac5aedcc5767745815a1391907d2201d1f5,
            0x16335ef40a5aef6df1a9e029dd4c2800a3c537d82ad36394951912edafb8b2e4,
            0x04cd0660bd7f37662ae8f4cf731dd79f1ad0ad48a5c3155fd703dd4e65a740c0,
            0x0fd32dfaa692fb5d586e710bbcbdeaaf7f2389185ff0a83228f6c1f349be59b0,
            0x1d23a86fa30295a76a7c8d3ebab441fdbe596c38feee1d8438bb156a36cf3c9c,
            0x2c7d5a19a8aad8c1de3756c86bbe1689c538ae6551904cfb50db0d5f769904ba,
            0x23658ab8e9fac625bba418fe1b43cdb853cd8e64e3c6529af01742a8c2d85fab,
            0x32380dc4ec9ed7ecb8f0f90d0632e159a7069fe9fa1bfa282c5b6714fab4dee5,
            0x296cbd7a792ef170ac4bb4eaea049a1ea14032726d9bd0cc5a618dc790e1aa2f,
            0x0a9afa57f8749e834d35640583d1c833150f3b726f6b3e15035a790119ef323f,
            0x3d070661fad3db2c6bfa438ceeb702f6149b84121a16333165cc1e9f26fb2538,
            0x27d0d5d75fd1e515a1ba004330b394490efd0e3302240e19c1f6711598c83e61,
            0x0354daf9a4df967ccc3d4fb720c06ac274932f69d44481a722ed61292554bb7f,
            0x02f191e6d8d764d337e264446e23f7f0ca25fafc4f2287322d55c44a16852b2e
        );

        uint actual = PoseidonU24Vesta.hash(state, vestaCurveModulus);

        uint expected = 0x0b12b46e51c266adc1ddc71e369249e2199b3d9b23c8316b36471e7a02869599;

        assertEq(expected, actual);
    }
}
