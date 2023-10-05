// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.0;

import "@std/Test.sol";
import "src/blocks/poseidon/PoseidonNeptuneU24pallas.sol";
import "src/blocks/poseidon/PoseidonNeptuneU24vesta.sol";
import "src/blocks/poseidon/PoseidonNeptuneU24Optimized.sol";
import "src/blocks/pasta/Pallas.sol";
import "src/blocks/pasta/Vesta.sol";
import "src/blocks/grumpkin/Bn256.sol";
import "src/blocks/grumpkin/Grumpkin.sol";
import "test/utils.t.sol";

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
        uint256 pallasCurveModulus =
            uint256(bytes32(0x40000000000000000000000000000000224698fc094cf91b992d30ed00000001));

        PoseidonU24Pallas.HashInputs25 memory state = PoseidonU24Pallas.HashInputs25(
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

        uint256 actual = PoseidonU24Pallas.hash(state, pallasCurveModulus);

        uint256 expected = 0x0a85fc12d012ed3ae407c1589fb0e2eb0fe337f1d4c3374a785a89a134cbdf47;

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

        uint256 vestaCurveModulus = uint256(bytes32(0x40000000000000000000000000000000224698fc0994a8dd8c46eb2100000001));
        PoseidonU24Vesta.HashInputs25 memory state = PoseidonU24Vesta.HashInputs25(
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

        uint256 actual = PoseidonU24Vesta.hash(state, vestaCurveModulus);

        uint256 expected = 0x0b12b46e51c266adc1ddc71e369249e2199b3d9b23c8316b36471e7a02869599;

        assertEq(expected, actual);
    }

    function testPoseidonNonOptimizedPallas() public {
        PoseidonU24Pallas.HashInputs25 memory input = PoseidonU24Pallas.HashInputs25(
            0x0000000000000000000000000000000000000000000000000000000000000000,
            0x0000000000000000000000000000000000000000000000000000000000000000,
            0x0000000000000000000000000000000000000000000000000000000000000001,
            0x0000000000000000000000000000000000000000000000000000000000000002,
            0x0000000000000000000000000000000000000000000000000000000000000003,
            0x0000000000000000000000000000000000000000000000000000000000000004,
            0x0000000000000000000000000000000000000000000000000000000000000005,
            0x0000000000000000000000000000000000000000000000000000000000000006,
            0x0000000000000000000000000000000000000000000000000000000000000007,
            0x0000000000000000000000000000000000000000000000000000000000000008,
            0x0000000000000000000000000000000000000000000000000000000000000009,
            0x000000000000000000000000000000000000000000000000000000000000000a,
            0x000000000000000000000000000000000000000000000000000000000000000b,
            0x000000000000000000000000000000000000000000000000000000000000000c,
            0x000000000000000000000000000000000000000000000000000000000000000d,
            0x000000000000000000000000000000000000000000000000000000000000000e,
            0x000000000000000000000000000000000000000000000000000000000000000f,
            0x0000000000000000000000000000000000000000000000000000000000000010,
            0x0000000000000000000000000000000000000000000000000000000000000011,
            0x0000000000000000000000000000000000000000000000000000000000000012,
            0x0000000000000000000000000000000000000000000000000000000000000013,
            0x0000000000000000000000000000000000000000000000000000000000000014,
            0x0000000000000000000000000000000000000000000000000000000000000015,
            0x0000000000000000000000000000000000000000000000000000000000000016,
            0x0000000000000000000000000000000000000000000000000000000000000017
        );

        uint256 expected = 0x04763abc4003fd052b7aa8baef37d7bf0182e5e16aab89c413f7c31fb310f346;
        uint256 actual = PoseidonU24Pallas.hash(input, Pallas.P_MOD);
        assertEq(expected, actual);
    }

    function testPoseidonOptimizedPallas() public {
        PoseidonU24Optimized.HashInputs25 memory input = PoseidonU24Optimized.HashInputs25(
            0x0000000000000000000000000000000000000000000000000000000000000000,
            0x0000000000000000000000000000000000000000000000000000000000000000,
            0x0000000000000000000000000000000000000000000000000000000000000001,
            0x0000000000000000000000000000000000000000000000000000000000000002,
            0x0000000000000000000000000000000000000000000000000000000000000003,
            0x0000000000000000000000000000000000000000000000000000000000000004,
            0x0000000000000000000000000000000000000000000000000000000000000005,
            0x0000000000000000000000000000000000000000000000000000000000000006,
            0x0000000000000000000000000000000000000000000000000000000000000007,
            0x0000000000000000000000000000000000000000000000000000000000000008,
            0x0000000000000000000000000000000000000000000000000000000000000009,
            0x000000000000000000000000000000000000000000000000000000000000000a,
            0x000000000000000000000000000000000000000000000000000000000000000b,
            0x000000000000000000000000000000000000000000000000000000000000000c,
            0x000000000000000000000000000000000000000000000000000000000000000d,
            0x000000000000000000000000000000000000000000000000000000000000000e,
            0x000000000000000000000000000000000000000000000000000000000000000f,
            0x0000000000000000000000000000000000000000000000000000000000000010,
            0x0000000000000000000000000000000000000000000000000000000000000011,
            0x0000000000000000000000000000000000000000000000000000000000000012,
            0x0000000000000000000000000000000000000000000000000000000000000013,
            0x0000000000000000000000000000000000000000000000000000000000000014,
            0x0000000000000000000000000000000000000000000000000000000000000015,
            0x0000000000000000000000000000000000000000000000000000000000000016,
            0x0000000000000000000000000000000000000000000000000000000000000017
        );

        uint256 expected = 0x04763abc4003fd052b7aa8baef37d7bf0182e5e16aab89c413f7c31fb310f346;
        uint256 actual = PoseidonU24Optimized.hash(input, TestUtilities.loadPallasConstants(), Pallas.P_MOD);
        assertEq(expected, actual);
    }

    function testPoseidonNonOptimizedVesta() public {
        PoseidonU24Vesta.HashInputs25 memory input = PoseidonU24Vesta.HashInputs25(
            0x0000000000000000000000000000000000000000000000000000000000000000,
            0x0000000000000000000000000000000000000000000000000000000000000000,
            0x0000000000000000000000000000000000000000000000000000000000000001,
            0x0000000000000000000000000000000000000000000000000000000000000002,
            0x0000000000000000000000000000000000000000000000000000000000000003,
            0x0000000000000000000000000000000000000000000000000000000000000004,
            0x0000000000000000000000000000000000000000000000000000000000000005,
            0x0000000000000000000000000000000000000000000000000000000000000006,
            0x0000000000000000000000000000000000000000000000000000000000000007,
            0x0000000000000000000000000000000000000000000000000000000000000008,
            0x0000000000000000000000000000000000000000000000000000000000000009,
            0x000000000000000000000000000000000000000000000000000000000000000a,
            0x000000000000000000000000000000000000000000000000000000000000000b,
            0x000000000000000000000000000000000000000000000000000000000000000c,
            0x000000000000000000000000000000000000000000000000000000000000000d,
            0x000000000000000000000000000000000000000000000000000000000000000e,
            0x000000000000000000000000000000000000000000000000000000000000000f,
            0x0000000000000000000000000000000000000000000000000000000000000010,
            0x0000000000000000000000000000000000000000000000000000000000000011,
            0x0000000000000000000000000000000000000000000000000000000000000012,
            0x0000000000000000000000000000000000000000000000000000000000000013,
            0x0000000000000000000000000000000000000000000000000000000000000014,
            0x0000000000000000000000000000000000000000000000000000000000000015,
            0x0000000000000000000000000000000000000000000000000000000000000016,
            0x0000000000000000000000000000000000000000000000000000000000000017
        );

        uint256 expected = 0x197c8d92c454a295dca58cfd2bb33f1ef7461fafc904ce12de3f707242f54b80;
        uint256 actual = PoseidonU24Vesta.hash(input, Vesta.P_MOD);
        assertEq(expected, actual);
    }

    function testPoseidonOptimizedVesta() public {
        PoseidonU24Optimized.HashInputs25 memory input = PoseidonU24Optimized.HashInputs25(
            0x0000000000000000000000000000000000000000000000000000000000000000,
            0x0000000000000000000000000000000000000000000000000000000000000000,
            0x0000000000000000000000000000000000000000000000000000000000000001,
            0x0000000000000000000000000000000000000000000000000000000000000002,
            0x0000000000000000000000000000000000000000000000000000000000000003,
            0x0000000000000000000000000000000000000000000000000000000000000004,
            0x0000000000000000000000000000000000000000000000000000000000000005,
            0x0000000000000000000000000000000000000000000000000000000000000006,
            0x0000000000000000000000000000000000000000000000000000000000000007,
            0x0000000000000000000000000000000000000000000000000000000000000008,
            0x0000000000000000000000000000000000000000000000000000000000000009,
            0x000000000000000000000000000000000000000000000000000000000000000a,
            0x000000000000000000000000000000000000000000000000000000000000000b,
            0x000000000000000000000000000000000000000000000000000000000000000c,
            0x000000000000000000000000000000000000000000000000000000000000000d,
            0x000000000000000000000000000000000000000000000000000000000000000e,
            0x000000000000000000000000000000000000000000000000000000000000000f,
            0x0000000000000000000000000000000000000000000000000000000000000010,
            0x0000000000000000000000000000000000000000000000000000000000000011,
            0x0000000000000000000000000000000000000000000000000000000000000012,
            0x0000000000000000000000000000000000000000000000000000000000000013,
            0x0000000000000000000000000000000000000000000000000000000000000014,
            0x0000000000000000000000000000000000000000000000000000000000000015,
            0x0000000000000000000000000000000000000000000000000000000000000016,
            0x0000000000000000000000000000000000000000000000000000000000000017
        );

        uint256 expected = 0x197c8d92c454a295dca58cfd2bb33f1ef7461fafc904ce12de3f707242f54b80;
        uint256 actual = PoseidonU24Optimized.hash(input, TestUtilities.loadVestaConstants(), Vesta.P_MOD);
        assertEq(expected, actual);
    }

    function testPoseidonOptimizedBn256() public {
        PoseidonU24Optimized.PoseidonConstantsU24 memory c = TestUtilities.loadBn256Constants();

        PoseidonU24Optimized.HashInputs25 memory input = PoseidonU24Optimized.HashInputs25(
            0x0000000000000000000000000000000000000000000000000000000000000000,
            0x0000000000000000000000000000000000000000000000000000000000000000,
            0x0000000000000000000000000000000000000000000000000000000000000001,
            0x0000000000000000000000000000000000000000000000000000000000000002,
            0x0000000000000000000000000000000000000000000000000000000000000003,
            0x0000000000000000000000000000000000000000000000000000000000000004,
            0x0000000000000000000000000000000000000000000000000000000000000005,
            0x0000000000000000000000000000000000000000000000000000000000000006,
            0x0000000000000000000000000000000000000000000000000000000000000007,
            0x0000000000000000000000000000000000000000000000000000000000000008,
            0x0000000000000000000000000000000000000000000000000000000000000009,
            0x000000000000000000000000000000000000000000000000000000000000000a,
            0x000000000000000000000000000000000000000000000000000000000000000b,
            0x000000000000000000000000000000000000000000000000000000000000000c,
            0x000000000000000000000000000000000000000000000000000000000000000d,
            0x000000000000000000000000000000000000000000000000000000000000000e,
            0x000000000000000000000000000000000000000000000000000000000000000f,
            0x0000000000000000000000000000000000000000000000000000000000000010,
            0x0000000000000000000000000000000000000000000000000000000000000011,
            0x0000000000000000000000000000000000000000000000000000000000000012,
            0x0000000000000000000000000000000000000000000000000000000000000013,
            0x0000000000000000000000000000000000000000000000000000000000000014,
            0x0000000000000000000000000000000000000000000000000000000000000015,
            0x0000000000000000000000000000000000000000000000000000000000000016,
            0x0000000000000000000000000000000000000000000000000000000000000017
        );

        uint256 expected = 0x30281e34a83c3d41ae25f8ef570a98c1c885af508ee8f3e359dc6314e3978285;

        uint256 gasCost = gasleft();
        uint256 actual = PoseidonU24Optimized.hash(input, c, Bn256.R_MOD);
        console.log("gas cost: ", gasCost - uint256(gasleft()));

        assertEq(expected, actual);
    }

    function testPoseidonOptimizedGrumpkin() public {
        PoseidonU24Optimized.PoseidonConstantsU24 memory c = TestUtilities.loadGrumpkinConstants();

        PoseidonU24Optimized.HashInputs25 memory input = PoseidonU24Optimized.HashInputs25(
            0x0000000000000000000000000000000000000000000000000000000000000000,
            0x0000000000000000000000000000000000000000000000000000000000000000,
            0x0000000000000000000000000000000000000000000000000000000000000001,
            0x0000000000000000000000000000000000000000000000000000000000000002,
            0x0000000000000000000000000000000000000000000000000000000000000003,
            0x0000000000000000000000000000000000000000000000000000000000000004,
            0x0000000000000000000000000000000000000000000000000000000000000005,
            0x0000000000000000000000000000000000000000000000000000000000000006,
            0x0000000000000000000000000000000000000000000000000000000000000007,
            0x0000000000000000000000000000000000000000000000000000000000000008,
            0x0000000000000000000000000000000000000000000000000000000000000009,
            0x000000000000000000000000000000000000000000000000000000000000000a,
            0x000000000000000000000000000000000000000000000000000000000000000b,
            0x000000000000000000000000000000000000000000000000000000000000000c,
            0x000000000000000000000000000000000000000000000000000000000000000d,
            0x000000000000000000000000000000000000000000000000000000000000000e,
            0x000000000000000000000000000000000000000000000000000000000000000f,
            0x0000000000000000000000000000000000000000000000000000000000000010,
            0x0000000000000000000000000000000000000000000000000000000000000011,
            0x0000000000000000000000000000000000000000000000000000000000000012,
            0x0000000000000000000000000000000000000000000000000000000000000013,
            0x0000000000000000000000000000000000000000000000000000000000000014,
            0x0000000000000000000000000000000000000000000000000000000000000015,
            0x0000000000000000000000000000000000000000000000000000000000000016,
            0x0000000000000000000000000000000000000000000000000000000000000017
        );

        uint256 expected = 0x0efcf2f101b1d582f189365cf9e11e372a2ffd70be4bdcbfb94c489a006388a8;

        uint256 gasCost = gasleft();
        uint256 actual = PoseidonU24Optimized.hash(input, c, Grumpkin.P_MOD);
        console.log("gas cost: ", gasCost - uint256(gasleft()));

        assertEq(expected, actual);
    }

    function testPoseidonOptimizedBn256Assembly() public {
        PoseidonU24Optimized.PoseidonConstantsU24 memory c = TestUtilities.loadBn256Constants();

        uint256[25] memory input;
        input[0] = 0x0000000000000000000000000000000000000000000000000000000000000000;
        input[1] = 0x0000000000000000000000000000000000000000000000000000000000000000;
        input[2] = 0x0000000000000000000000000000000000000000000000000000000000000001;
        input[3] = 0x0000000000000000000000000000000000000000000000000000000000000002;
        input[4] = 0x0000000000000000000000000000000000000000000000000000000000000003;
        input[5] = 0x0000000000000000000000000000000000000000000000000000000000000004;
        input[6] = 0x0000000000000000000000000000000000000000000000000000000000000005;
        input[7] = 0x0000000000000000000000000000000000000000000000000000000000000006;
        input[8] = 0x0000000000000000000000000000000000000000000000000000000000000007;
        input[9] = 0x0000000000000000000000000000000000000000000000000000000000000008;
        input[10] = 0x0000000000000000000000000000000000000000000000000000000000000009;
        input[11] = 0x000000000000000000000000000000000000000000000000000000000000000a;
        input[12] = 0x000000000000000000000000000000000000000000000000000000000000000b;
        input[13] = 0x000000000000000000000000000000000000000000000000000000000000000c;
        input[14] = 0x000000000000000000000000000000000000000000000000000000000000000d;
        input[15] = 0x000000000000000000000000000000000000000000000000000000000000000e;
        input[16] = 0x000000000000000000000000000000000000000000000000000000000000000f;
        input[17] = 0x0000000000000000000000000000000000000000000000000000000000000010;
        input[18] = 0x0000000000000000000000000000000000000000000000000000000000000011;
        input[19] = 0x0000000000000000000000000000000000000000000000000000000000000012;
        input[20] = 0x0000000000000000000000000000000000000000000000000000000000000013;
        input[21] = 0x0000000000000000000000000000000000000000000000000000000000000014;
        input[22] = 0x0000000000000000000000000000000000000000000000000000000000000015;
        input[23] = 0x0000000000000000000000000000000000000000000000000000000000000016;
        input[24] = 0x0000000000000000000000000000000000000000000000000000000000000017;

        uint256 expected = 0x30281e34a83c3d41ae25f8ef570a98c1c885af508ee8f3e359dc6314e3978285;
        uint256 actual = poseidonAssembly(input, c, Bn256.R_MOD);
        assertEq(expected, actual);
    }

    function testPoseidonOptimizedGrumpkinAssembly() public {
        PoseidonU24Optimized.PoseidonConstantsU24 memory c = TestUtilities.loadGrumpkinConstants();

        uint256[25] memory input;
        input[0] = 0x0000000000000000000000000000000000000000000000000000000000000000;
        input[1] = 0x0000000000000000000000000000000000000000000000000000000000000000;
        input[2] = 0x0000000000000000000000000000000000000000000000000000000000000001;
        input[3] = 0x0000000000000000000000000000000000000000000000000000000000000002;
        input[4] = 0x0000000000000000000000000000000000000000000000000000000000000003;
        input[5] = 0x0000000000000000000000000000000000000000000000000000000000000004;
        input[6] = 0x0000000000000000000000000000000000000000000000000000000000000005;
        input[7] = 0x0000000000000000000000000000000000000000000000000000000000000006;
        input[8] = 0x0000000000000000000000000000000000000000000000000000000000000007;
        input[9] = 0x0000000000000000000000000000000000000000000000000000000000000008;
        input[10] = 0x0000000000000000000000000000000000000000000000000000000000000009;
        input[11] = 0x000000000000000000000000000000000000000000000000000000000000000a;
        input[12] = 0x000000000000000000000000000000000000000000000000000000000000000b;
        input[13] = 0x000000000000000000000000000000000000000000000000000000000000000c;
        input[14] = 0x000000000000000000000000000000000000000000000000000000000000000d;
        input[15] = 0x000000000000000000000000000000000000000000000000000000000000000e;
        input[16] = 0x000000000000000000000000000000000000000000000000000000000000000f;
        input[17] = 0x0000000000000000000000000000000000000000000000000000000000000010;
        input[18] = 0x0000000000000000000000000000000000000000000000000000000000000011;
        input[19] = 0x0000000000000000000000000000000000000000000000000000000000000012;
        input[20] = 0x0000000000000000000000000000000000000000000000000000000000000013;
        input[21] = 0x0000000000000000000000000000000000000000000000000000000000000014;
        input[22] = 0x0000000000000000000000000000000000000000000000000000000000000015;
        input[23] = 0x0000000000000000000000000000000000000000000000000000000000000016;
        input[24] = 0x0000000000000000000000000000000000000000000000000000000000000017;

        uint256 expected = 0x0efcf2f101b1d582f189365cf9e11e372a2ffd70be4bdcbfb94c489a006388a8;
        uint256 actual = poseidonAssembly(input, c, Grumpkin.P_MOD);
        assertEq(expected, actual);
    }

    uint256 internal constant INPUT0 = 0x200 + 0x340 + 0x00;
    uint256 internal constant INPUT1 = 0x200 + 0x340 + 0x20;
    uint256 internal constant INPUT2 = 0x200 + 0x340 + 0x40;
    uint256 internal constant INPUT3 = 0x200 + 0x340 + 0x60;
    uint256 internal constant INPUT4 = 0x200 + 0x340 + 0x80;
    uint256 internal constant INPUT5 = 0x200 + 0x340 + 0xa0;
    uint256 internal constant INPUT6 = 0x200 + 0x340 + 0xc0;
    uint256 internal constant INPUT7 = 0x200 + 0x340 + 0xe0;
    uint256 internal constant INPUT8 = 0x200 + 0x340 + 0x100;
    uint256 internal constant INPUT9 = 0x200 + 0x340 + 0x120;
    uint256 internal constant INPUT10 = 0x200 + 0x340 + 0x140;
    uint256 internal constant INPUT11 = 0x200 + 0x340 + 0x160;
    uint256 internal constant INPUT12 = 0x200 + 0x340 + 0x180;
    uint256 internal constant INPUT13 = 0x200 + 0x340 + 0x1a0;
    uint256 internal constant INPUT14 = 0x200 + 0x340 + 0x1c0;
    uint256 internal constant INPUT15 = 0x200 + 0x340 + 0x1e0;
    uint256 internal constant INPUT16 = 0x200 + 0x340 + 0x200;
    uint256 internal constant INPUT17 = 0x200 + 0x340 + 0x220;
    uint256 internal constant INPUT18 = 0x200 + 0x340 + 0x240;
    uint256 internal constant INPUT19 = 0x200 + 0x340 + 0x260;
    uint256 internal constant INPUT20 = 0x200 + 0x340 + 0x280;
    uint256 internal constant INPUT21 = 0x200 + 0x340 + 0x2a0;
    uint256 internal constant INPUT22 = 0x200 + 0x340 + 0x2c0;
    uint256 internal constant INPUT23 = 0x200 + 0x340 + 0x2e0;
    uint256 internal constant INPUT24 = 0x200 + 0x340 + 0x300;

    uint256 internal constant TMP_0 = 0x200 + 0x340 + 0x320;
    uint256 internal constant TMP_1 = 0x200 + 0x340 + 0x340;
    uint256 internal constant TMP_2 = 0x200 + 0x340 + 0x360;
    uint256 internal constant TMP_3 = 0x200 + 0x340 + 0x380;
    uint256 internal constant TMP_4 = 0x200 + 0x340 + 0x3a0;
    uint256 internal constant TMP_5 = 0x200 + 0x340 + 0x3c0;
    uint256 internal constant TMP_6 = 0x200 + 0x340 + 0x3e0;
    uint256 internal constant TMP_7 = 0x200 + 0x340 + 0x400;
    uint256 internal constant TMP_8 = 0x200 + 0x340 + 0x420;
    uint256 internal constant TMP_9 = 0x200 + 0x340 + 0x440;
    uint256 internal constant TMP_10 = 0x200 + 0x340 + 0x460;
    uint256 internal constant TMP_11 = 0x200 + 0x340 + 0x480;
    uint256 internal constant TMP_12 = 0x200 + 0x340 + 0x4a0;
    uint256 internal constant TMP_13 = 0x200 + 0x340 + 0x4c0;
    uint256 internal constant TMP_14 = 0x200 + 0x340 + 0x4e0;
    uint256 internal constant TMP_15 = 0x200 + 0x340 + 0x500;
    uint256 internal constant TMP_16 = 0x200 + 0x340 + 0x520;
    uint256 internal constant TMP_17 = 0x200 + 0x340 + 0x540;
    uint256 internal constant TMP_18 = 0x200 + 0x340 + 0x560;
    uint256 internal constant TMP_19 = 0x200 + 0x340 + 0x580;
    uint256 internal constant TMP_20 = 0x200 + 0x340 + 0x5a0;
    uint256 internal constant TMP_21 = 0x200 + 0x340 + 0x5c0;
    uint256 internal constant TMP_22 = 0x200 + 0x340 + 0x5e0;
    uint256 internal constant TMP_23 = 0x200 + 0x340 + 0x600;
    uint256 internal constant TMP_24 = 0x200 + 0x340 + 0x620;

    function get_w_hats(PoseidonU24Optimized.PoseidonConstantsU24 memory c) private pure returns (uint256[][] memory) {
        uint256[][] memory w_hats = new uint256[][](c.sparseMatrices.length);
        for (uint256 index = 0; index < w_hats.length; index++) {
            w_hats[index] = new uint256[](c.sparseMatrices[index].w_hat.length);
            for (uint256 j = 0; j < w_hats[index].length; j++) {
                w_hats[index][j] = c.sparseMatrices[index].w_hat[j];
            }
        }
        return w_hats;
    }

    function get_v_rests(PoseidonU24Optimized.PoseidonConstantsU24 memory c)
        private
        pure
        returns (uint256[][] memory)
    {
        uint256[][] memory v_rests = new uint256[][](c.sparseMatrices.length);
        for (uint256 index = 0; index < v_rests.length; index++) {
            v_rests[index] = new uint256[](c.sparseMatrices[index].v_rest.length);
            for (uint256 j = 0; j < v_rests[index].length; j++) {
                v_rests[index][j] = c.sparseMatrices[index].v_rest[j];
            }
        }
        return v_rests;
    }

    function poseidonAssembly(
        uint256[25] memory input,
        PoseidonU24Optimized.PoseidonConstantsU24 memory c,
        uint256 modulus
    ) private returns (uint256) {
        uint256 partial_rounds = c.partialRounds;
        uint256 half_of_full_rounds_minus_1 = (c.fullRounds / 2) - 1;
        uint256[] memory round_constants = c.round_constants;
        uint256[][] memory c_m = c.m;
        uint256[][] memory c_psm = c.psm;
        uint256[][] memory w_hats = get_w_hats(c);
        uint256[][] memory v_rests = get_v_rests(c);

        uint256 hash;

        uint256 gasCost = gasleft();
        assembly {
            function mix(_c_m, _modulus) {
                mix_inner(TMP_0, mload(add(_c_m, 32)), _modulus)
                mix_inner(TMP_1, mload(add(_c_m, 64)), _modulus)
                mix_inner(TMP_2, mload(add(_c_m, 96)), _modulus)
                mix_inner(TMP_3, mload(add(_c_m, 128)), _modulus)
                mix_inner(TMP_4, mload(add(_c_m, 160)), _modulus)
                mix_inner(TMP_5, mload(add(_c_m, 192)), _modulus)
                mix_inner(TMP_6, mload(add(_c_m, 224)), _modulus)
                mix_inner(TMP_7, mload(add(_c_m, 256)), _modulus)
                mix_inner(TMP_8, mload(add(_c_m, 288)), _modulus)
                mix_inner(TMP_9, mload(add(_c_m, 320)), _modulus)
                mix_inner(TMP_10, mload(add(_c_m, 352)), _modulus)
                mix_inner(TMP_11, mload(add(_c_m, 384)), _modulus)
                mix_inner(TMP_12, mload(add(_c_m, 416)), _modulus)
                mix_inner(TMP_13, mload(add(_c_m, 448)), _modulus)
                mix_inner(TMP_14, mload(add(_c_m, 480)), _modulus)
                mix_inner(TMP_15, mload(add(_c_m, 512)), _modulus)
                mix_inner(TMP_16, mload(add(_c_m, 544)), _modulus)
                mix_inner(TMP_17, mload(add(_c_m, 576)), _modulus)
                mix_inner(TMP_18, mload(add(_c_m, 608)), _modulus)
                mix_inner(TMP_19, mload(add(_c_m, 640)), _modulus)
                mix_inner(TMP_20, mload(add(_c_m, 672)), _modulus)
                mix_inner(TMP_21, mload(add(_c_m, 704)), _modulus)
                mix_inner(TMP_22, mload(add(_c_m, 736)), _modulus)
                mix_inner(TMP_23, mload(add(_c_m, 768)), _modulus)
                mix_inner(TMP_24, mload(add(_c_m, 800)), _modulus)

                mstore(INPUT0, mload(TMP_0))
                mstore(INPUT1, mload(TMP_1))
                mstore(INPUT2, mload(TMP_2))
                mstore(INPUT3, mload(TMP_3))
                mstore(INPUT4, mload(TMP_4))
                mstore(INPUT5, mload(TMP_5))
                mstore(INPUT6, mload(TMP_6))
                mstore(INPUT7, mload(TMP_7))
                mstore(INPUT8, mload(TMP_8))
                mstore(INPUT9, mload(TMP_9))
                mstore(INPUT10, mload(TMP_10))
                mstore(INPUT11, mload(TMP_11))
                mstore(INPUT12, mload(TMP_12))
                mstore(INPUT13, mload(TMP_13))
                mstore(INPUT14, mload(TMP_14))
                mstore(INPUT15, mload(TMP_15))
                mstore(INPUT16, mload(TMP_16))
                mstore(INPUT17, mload(TMP_17))
                mstore(INPUT18, mload(TMP_18))
                mstore(INPUT19, mload(TMP_19))
                mstore(INPUT20, mload(TMP_20))
                mstore(INPUT21, mload(TMP_21))
                mstore(INPUT22, mload(TMP_22))
                mstore(INPUT23, mload(TMP_23))
                mstore(INPUT24, mload(TMP_24))
            }
            function add_round_constants(_round_constants, offset, _modulus) {
                mstore(INPUT0, addmod(mload(INPUT0), mload(add(_round_constants, add(offset, 32))), _modulus))
                mstore(INPUT1, addmod(mload(INPUT1), mload(add(_round_constants, add(offset, 64))), _modulus))
                mstore(INPUT2, addmod(mload(INPUT2), mload(add(_round_constants, add(offset, 96))), _modulus))
                mstore(INPUT3, addmod(mload(INPUT3), mload(add(_round_constants, add(offset, 128))), _modulus))
                mstore(INPUT4, addmod(mload(INPUT4), mload(add(_round_constants, add(offset, 160))), _modulus))
                mstore(INPUT5, addmod(mload(INPUT5), mload(add(_round_constants, add(offset, 192))), _modulus))
                mstore(INPUT6, addmod(mload(INPUT6), mload(add(_round_constants, add(offset, 224))), _modulus))
                mstore(INPUT7, addmod(mload(INPUT7), mload(add(_round_constants, add(offset, 256))), _modulus))
                mstore(INPUT8, addmod(mload(INPUT8), mload(add(_round_constants, add(offset, 288))), _modulus))
                mstore(INPUT9, addmod(mload(INPUT9), mload(add(_round_constants, add(offset, 320))), _modulus))
                mstore(INPUT10, addmod(mload(INPUT10), mload(add(_round_constants, add(offset, 352))), _modulus))
                mstore(INPUT11, addmod(mload(INPUT11), mload(add(_round_constants, add(offset, 384))), _modulus))
                mstore(INPUT12, addmod(mload(INPUT12), mload(add(_round_constants, add(offset, 416))), _modulus))
                mstore(INPUT13, addmod(mload(INPUT13), mload(add(_round_constants, add(offset, 448))), _modulus))
                mstore(INPUT14, addmod(mload(INPUT14), mload(add(_round_constants, add(offset, 480))), _modulus))
                mstore(INPUT15, addmod(mload(INPUT15), mload(add(_round_constants, add(offset, 512))), _modulus))
                mstore(INPUT16, addmod(mload(INPUT16), mload(add(_round_constants, add(offset, 544))), _modulus))
                mstore(INPUT17, addmod(mload(INPUT17), mload(add(_round_constants, add(offset, 576))), _modulus))
                mstore(INPUT18, addmod(mload(INPUT18), mload(add(_round_constants, add(offset, 608))), _modulus))
                mstore(INPUT19, addmod(mload(INPUT19), mload(add(_round_constants, add(offset, 640))), _modulus))
                mstore(INPUT20, addmod(mload(INPUT20), mload(add(_round_constants, add(offset, 672))), _modulus))
                mstore(INPUT21, addmod(mload(INPUT21), mload(add(_round_constants, add(offset, 704))), _modulus))
                mstore(INPUT22, addmod(mload(INPUT22), mload(add(_round_constants, add(offset, 736))), _modulus))
                mstore(INPUT23, addmod(mload(INPUT23), mload(add(_round_constants, add(offset, 768))), _modulus))
                mstore(INPUT24, addmod(mload(INPUT24), mload(add(_round_constants, add(offset, 800))), _modulus))
            }

            function sbox_full(_modulus) {
                mstore(INPUT0, sbox(mload(INPUT0), _modulus))
                mstore(INPUT1, sbox(mload(INPUT1), _modulus))
                mstore(INPUT2, sbox(mload(INPUT2), _modulus))
                mstore(INPUT3, sbox(mload(INPUT3), _modulus))
                mstore(INPUT4, sbox(mload(INPUT4), _modulus))
                mstore(INPUT5, sbox(mload(INPUT5), _modulus))
                mstore(INPUT6, sbox(mload(INPUT6), _modulus))
                mstore(INPUT7, sbox(mload(INPUT7), _modulus))
                mstore(INPUT8, sbox(mload(INPUT8), _modulus))
                mstore(INPUT9, sbox(mload(INPUT9), _modulus))
                mstore(INPUT10, sbox(mload(INPUT10), _modulus))
                mstore(INPUT11, sbox(mload(INPUT11), _modulus))
                mstore(INPUT12, sbox(mload(INPUT12), _modulus))
                mstore(INPUT13, sbox(mload(INPUT13), _modulus))
                mstore(INPUT14, sbox(mload(INPUT14), _modulus))
                mstore(INPUT15, sbox(mload(INPUT15), _modulus))
                mstore(INPUT16, sbox(mload(INPUT16), _modulus))
                mstore(INPUT17, sbox(mload(INPUT17), _modulus))
                mstore(INPUT18, sbox(mload(INPUT18), _modulus))
                mstore(INPUT19, sbox(mload(INPUT19), _modulus))
                mstore(INPUT20, sbox(mload(INPUT20), _modulus))
                mstore(INPUT21, sbox(mload(INPUT21), _modulus))
                mstore(INPUT22, sbox(mload(INPUT22), _modulus))
                mstore(INPUT23, sbox(mload(INPUT23), _modulus))
                mstore(INPUT24, sbox(mload(INPUT24), _modulus))
            }

            function sbox(a, _modulus) -> ret {
                let tmp := 0
                tmp := mulmod(a, a, _modulus)
                tmp := mulmod(tmp, tmp, _modulus)
                ret := mulmod(a, tmp, _modulus)
            }

            function mix_inner(input_pointer, matrix_pointer, _modulus) {
                let tmp := 0

                tmp := addmod(tmp, mulmod(mload(INPUT0), mload(add(matrix_pointer, 32)), _modulus), _modulus)
                tmp := addmod(tmp, mulmod(mload(INPUT1), mload(add(matrix_pointer, 64)), _modulus), _modulus)
                tmp := addmod(tmp, mulmod(mload(INPUT2), mload(add(matrix_pointer, 96)), _modulus), _modulus)
                tmp := addmod(tmp, mulmod(mload(INPUT3), mload(add(matrix_pointer, 128)), _modulus), _modulus)
                tmp := addmod(tmp, mulmod(mload(INPUT4), mload(add(matrix_pointer, 160)), _modulus), _modulus)
                tmp := addmod(tmp, mulmod(mload(INPUT5), mload(add(matrix_pointer, 192)), _modulus), _modulus)
                tmp := addmod(tmp, mulmod(mload(INPUT6), mload(add(matrix_pointer, 224)), _modulus), _modulus)
                tmp := addmod(tmp, mulmod(mload(INPUT7), mload(add(matrix_pointer, 256)), _modulus), _modulus)
                tmp := addmod(tmp, mulmod(mload(INPUT8), mload(add(matrix_pointer, 288)), _modulus), _modulus)
                tmp := addmod(tmp, mulmod(mload(INPUT9), mload(add(matrix_pointer, 320)), _modulus), _modulus)
                tmp := addmod(tmp, mulmod(mload(INPUT10), mload(add(matrix_pointer, 352)), _modulus), _modulus)
                tmp := addmod(tmp, mulmod(mload(INPUT11), mload(add(matrix_pointer, 384)), _modulus), _modulus)
                tmp := addmod(tmp, mulmod(mload(INPUT12), mload(add(matrix_pointer, 416)), _modulus), _modulus)
                tmp := addmod(tmp, mulmod(mload(INPUT13), mload(add(matrix_pointer, 448)), _modulus), _modulus)
                tmp := addmod(tmp, mulmod(mload(INPUT14), mload(add(matrix_pointer, 480)), _modulus), _modulus)
                tmp := addmod(tmp, mulmod(mload(INPUT15), mload(add(matrix_pointer, 512)), _modulus), _modulus)
                tmp := addmod(tmp, mulmod(mload(INPUT16), mload(add(matrix_pointer, 544)), _modulus), _modulus)
                tmp := addmod(tmp, mulmod(mload(INPUT17), mload(add(matrix_pointer, 576)), _modulus), _modulus)
                tmp := addmod(tmp, mulmod(mload(INPUT18), mload(add(matrix_pointer, 608)), _modulus), _modulus)
                tmp := addmod(tmp, mulmod(mload(INPUT19), mload(add(matrix_pointer, 640)), _modulus), _modulus)
                tmp := addmod(tmp, mulmod(mload(INPUT20), mload(add(matrix_pointer, 672)), _modulus), _modulus)
                tmp := addmod(tmp, mulmod(mload(INPUT21), mload(add(matrix_pointer, 704)), _modulus), _modulus)
                tmp := addmod(tmp, mulmod(mload(INPUT22), mload(add(matrix_pointer, 736)), _modulus), _modulus)
                tmp := addmod(tmp, mulmod(mload(INPUT23), mload(add(matrix_pointer, 768)), _modulus), _modulus)
                tmp := addmod(tmp, mulmod(mload(INPUT24), mload(add(matrix_pointer, 800)), _modulus), _modulus)
                mstore(input_pointer, tmp)
            }

            function mix_sparse(_v_rests, _w_hats, _offset_mix, _modulus) {
                mstore(TMP_0, 0)
                mstore(TMP_1, 0)
                mstore(TMP_2, 0)
                mstore(TMP_3, 0)
                mstore(TMP_4, 0)
                mstore(TMP_5, 0)
                mstore(TMP_6, 0)
                mstore(TMP_7, 0)
                mstore(TMP_8, 0)
                mstore(TMP_9, 0)
                mstore(TMP_10, 0)
                mstore(TMP_11, 0)
                mstore(TMP_12, 0)
                mstore(TMP_13, 0)
                mstore(TMP_14, 0)
                mstore(TMP_15, 0)
                mstore(TMP_16, 0)
                mstore(TMP_17, 0)
                mstore(TMP_18, 0)
                mstore(TMP_19, 0)
                mstore(TMP_20, 0)
                mstore(TMP_21, 0)
                mstore(TMP_22, 0)
                mstore(TMP_23, 0)
                mstore(TMP_24, 0)

                // w_hat
                let w_hat_pointer := mload(add(_w_hats, add(_offset_mix, 32)))
                // v_rest
                let v_rest_pointer := mload(add(_v_rests, add(_offset_mix, 32)))

                let tmp := 0

                tmp := mulmod(mload(INPUT0), mload(add(w_hat_pointer, 32)), _modulus)
                mstore(TMP_0, addmod(mload(TMP_0), tmp, _modulus))

                tmp := mulmod(mload(INPUT1), mload(add(w_hat_pointer, 64)), _modulus)
                mstore(TMP_0, addmod(mload(TMP_0), tmp, _modulus))

                tmp := mulmod(mload(INPUT2), mload(add(w_hat_pointer, 96)), _modulus)
                mstore(TMP_0, addmod(mload(TMP_0), tmp, _modulus))

                tmp := mulmod(mload(INPUT3), mload(add(w_hat_pointer, 128)), _modulus)
                mstore(TMP_0, addmod(mload(TMP_0), tmp, _modulus))

                tmp := mulmod(mload(INPUT4), mload(add(w_hat_pointer, 160)), _modulus)
                mstore(TMP_0, addmod(mload(TMP_0), tmp, _modulus))

                tmp := mulmod(mload(INPUT5), mload(add(w_hat_pointer, 192)), _modulus)
                mstore(TMP_0, addmod(mload(TMP_0), tmp, _modulus))

                tmp := mulmod(mload(INPUT6), mload(add(w_hat_pointer, 224)), _modulus)
                mstore(TMP_0, addmod(mload(TMP_0), tmp, _modulus))

                tmp := mulmod(mload(INPUT7), mload(add(w_hat_pointer, 256)), _modulus)
                mstore(TMP_0, addmod(mload(TMP_0), tmp, _modulus))

                tmp := mulmod(mload(INPUT8), mload(add(w_hat_pointer, 288)), _modulus)
                mstore(TMP_0, addmod(mload(TMP_0), tmp, _modulus))

                tmp := mulmod(mload(INPUT9), mload(add(w_hat_pointer, 320)), _modulus)
                mstore(TMP_0, addmod(mload(TMP_0), tmp, _modulus))

                tmp := mulmod(mload(INPUT10), mload(add(w_hat_pointer, 352)), _modulus)
                mstore(TMP_0, addmod(mload(TMP_0), tmp, _modulus))

                tmp := mulmod(mload(INPUT11), mload(add(w_hat_pointer, 384)), _modulus)
                mstore(TMP_0, addmod(mload(TMP_0), tmp, _modulus))

                tmp := mulmod(mload(INPUT12), mload(add(w_hat_pointer, 416)), _modulus)
                mstore(TMP_0, addmod(mload(TMP_0), tmp, _modulus))

                tmp := mulmod(mload(INPUT13), mload(add(w_hat_pointer, 448)), _modulus)
                mstore(TMP_0, addmod(mload(TMP_0), tmp, _modulus))

                tmp := mulmod(mload(INPUT14), mload(add(w_hat_pointer, 480)), _modulus)
                mstore(TMP_0, addmod(mload(TMP_0), tmp, _modulus))

                tmp := mulmod(mload(INPUT15), mload(add(w_hat_pointer, 512)), _modulus)
                mstore(TMP_0, addmod(mload(TMP_0), tmp, _modulus))

                tmp := mulmod(mload(INPUT16), mload(add(w_hat_pointer, 544)), _modulus)
                mstore(TMP_0, addmod(mload(TMP_0), tmp, _modulus))

                tmp := mulmod(mload(INPUT17), mload(add(w_hat_pointer, 576)), _modulus)
                mstore(TMP_0, addmod(mload(TMP_0), tmp, _modulus))

                tmp := mulmod(mload(INPUT18), mload(add(w_hat_pointer, 608)), _modulus)
                mstore(TMP_0, addmod(mload(TMP_0), tmp, _modulus))

                tmp := mulmod(mload(INPUT19), mload(add(w_hat_pointer, 640)), _modulus)
                mstore(TMP_0, addmod(mload(TMP_0), tmp, _modulus))

                tmp := mulmod(mload(INPUT20), mload(add(w_hat_pointer, 672)), _modulus)
                mstore(TMP_0, addmod(mload(TMP_0), tmp, _modulus))

                tmp := mulmod(mload(INPUT21), mload(add(w_hat_pointer, 704)), _modulus)
                mstore(TMP_0, addmod(mload(TMP_0), tmp, _modulus))

                tmp := mulmod(mload(INPUT22), mload(add(w_hat_pointer, 736)), _modulus)
                mstore(TMP_0, addmod(mload(TMP_0), tmp, _modulus))

                tmp := mulmod(mload(INPUT23), mload(add(w_hat_pointer, 768)), _modulus)
                mstore(TMP_0, addmod(mload(TMP_0), tmp, _modulus))

                tmp := mulmod(mload(INPUT24), mload(add(w_hat_pointer, 800)), _modulus)
                mstore(TMP_0, addmod(mload(TMP_0), tmp, _modulus))

                let val := 0

                val := mload(INPUT1)
                tmp := mload(add(v_rest_pointer, 32))
                tmp := mulmod(tmp, mload(INPUT0), _modulus)
                mstore(TMP_1, addmod(val, tmp, _modulus))

                val := mload(INPUT2)
                tmp := mload(add(v_rest_pointer, 64))
                tmp := mulmod(tmp, mload(INPUT0), _modulus)
                mstore(TMP_2, addmod(val, tmp, _modulus))

                val := mload(INPUT3)
                tmp := mload(add(v_rest_pointer, 96))
                tmp := mulmod(tmp, mload(INPUT0), _modulus)
                mstore(TMP_3, addmod(val, tmp, _modulus))

                val := mload(INPUT4)
                tmp := mload(add(v_rest_pointer, 128))
                tmp := mulmod(tmp, mload(INPUT0), _modulus)
                mstore(TMP_4, addmod(val, tmp, _modulus))

                val := mload(INPUT5)
                tmp := mload(add(v_rest_pointer, 160))
                tmp := mulmod(tmp, mload(INPUT0), _modulus)
                mstore(TMP_5, addmod(val, tmp, _modulus))

                val := mload(INPUT6)
                tmp := mload(add(v_rest_pointer, 192))
                tmp := mulmod(tmp, mload(INPUT0), _modulus)
                mstore(TMP_6, addmod(val, tmp, _modulus))

                val := mload(INPUT7)
                tmp := mload(add(v_rest_pointer, 224))
                tmp := mulmod(tmp, mload(INPUT0), _modulus)
                mstore(TMP_7, addmod(val, tmp, _modulus))

                val := mload(INPUT8)
                tmp := mload(add(v_rest_pointer, 256))
                tmp := mulmod(tmp, mload(INPUT0), _modulus)
                mstore(TMP_8, addmod(val, tmp, _modulus))

                val := mload(INPUT9)
                tmp := mload(add(v_rest_pointer, 288))
                tmp := mulmod(tmp, mload(INPUT0), _modulus)
                mstore(TMP_9, addmod(val, tmp, _modulus))

                val := mload(INPUT10)
                tmp := mload(add(v_rest_pointer, 320))
                tmp := mulmod(tmp, mload(INPUT0), _modulus)
                mstore(TMP_10, addmod(val, tmp, _modulus))

                val := mload(INPUT11)
                tmp := mload(add(v_rest_pointer, 352))
                tmp := mulmod(tmp, mload(INPUT0), _modulus)
                mstore(TMP_11, addmod(val, tmp, _modulus))

                val := mload(INPUT12)
                tmp := mload(add(v_rest_pointer, 384))
                tmp := mulmod(tmp, mload(INPUT0), _modulus)
                mstore(TMP_12, addmod(val, tmp, _modulus))

                val := mload(INPUT13)
                tmp := mload(add(v_rest_pointer, 416))
                tmp := mulmod(tmp, mload(INPUT0), _modulus)
                mstore(TMP_13, addmod(val, tmp, _modulus))

                val := mload(INPUT14)
                tmp := mload(add(v_rest_pointer, 448))
                tmp := mulmod(tmp, mload(INPUT0), _modulus)
                mstore(TMP_14, addmod(val, tmp, _modulus))

                val := mload(INPUT15)
                tmp := mload(add(v_rest_pointer, 480))
                tmp := mulmod(tmp, mload(INPUT0), _modulus)
                mstore(TMP_15, addmod(val, tmp, _modulus))

                val := mload(INPUT16)
                tmp := mload(add(v_rest_pointer, 512))
                tmp := mulmod(tmp, mload(INPUT0), _modulus)
                mstore(TMP_16, addmod(val, tmp, _modulus))

                val := mload(INPUT17)
                tmp := mload(add(v_rest_pointer, 544))
                tmp := mulmod(tmp, mload(INPUT0), _modulus)
                mstore(TMP_17, addmod(val, tmp, _modulus))

                val := mload(INPUT18)
                tmp := mload(add(v_rest_pointer, 576))
                tmp := mulmod(tmp, mload(INPUT0), _modulus)
                mstore(TMP_18, addmod(val, tmp, _modulus))

                val := mload(INPUT19)
                tmp := mload(add(v_rest_pointer, 608))
                tmp := mulmod(tmp, mload(INPUT0), _modulus)
                mstore(TMP_19, addmod(val, tmp, _modulus))

                val := mload(INPUT20)
                tmp := mload(add(v_rest_pointer, 640))
                tmp := mulmod(tmp, mload(INPUT0), _modulus)
                mstore(TMP_20, addmod(val, tmp, _modulus))

                val := mload(INPUT21)
                tmp := mload(add(v_rest_pointer, 672))
                tmp := mulmod(tmp, mload(INPUT0), _modulus)
                mstore(TMP_21, addmod(val, tmp, _modulus))

                val := mload(INPUT22)
                tmp := mload(add(v_rest_pointer, 704))
                tmp := mulmod(tmp, mload(INPUT0), _modulus)
                mstore(TMP_22, addmod(val, tmp, _modulus))

                val := mload(INPUT23)
                tmp := mload(add(v_rest_pointer, 736))
                tmp := mulmod(tmp, mload(INPUT0), _modulus)
                mstore(TMP_23, addmod(val, tmp, _modulus))

                val := mload(INPUT24)
                tmp := mload(add(v_rest_pointer, 768))
                tmp := mulmod(tmp, mload(INPUT0), _modulus)
                mstore(TMP_24, addmod(val, tmp, _modulus))

                mstore(INPUT0, mload(TMP_0))
                mstore(INPUT1, mload(TMP_1))
                mstore(INPUT2, mload(TMP_2))
                mstore(INPUT3, mload(TMP_3))
                mstore(INPUT4, mload(TMP_4))
                mstore(INPUT5, mload(TMP_5))
                mstore(INPUT6, mload(TMP_6))
                mstore(INPUT7, mload(TMP_7))
                mstore(INPUT8, mload(TMP_8))
                mstore(INPUT9, mload(TMP_9))
                mstore(INPUT10, mload(TMP_10))
                mstore(INPUT11, mload(TMP_11))
                mstore(INPUT12, mload(TMP_12))
                mstore(INPUT13, mload(TMP_13))
                mstore(INPUT14, mload(TMP_14))
                mstore(INPUT15, mload(TMP_15))
                mstore(INPUT16, mload(TMP_16))
                mstore(INPUT17, mload(TMP_17))
                mstore(INPUT18, mload(TMP_18))
                mstore(INPUT19, mload(TMP_19))
                mstore(INPUT20, mload(TMP_20))
                mstore(INPUT21, mload(TMP_21))
                mstore(INPUT22, mload(TMP_22))
                mstore(INPUT23, mload(TMP_23))
                mstore(INPUT24, mload(TMP_24))
            }

            // initial round constants addition
            {
                mstore(INPUT0, addmod(mload(input), mload(add(round_constants, 32)), modulus))
                mstore(INPUT1, addmod(mload(add(input, 32)), mload(add(round_constants, 64)), modulus))
                mstore(INPUT2, addmod(mload(add(input, 64)), mload(add(round_constants, 96)), modulus))
                mstore(INPUT3, addmod(mload(add(input, 96)), mload(add(round_constants, 128)), modulus))
                mstore(INPUT4, addmod(mload(add(input, 128)), mload(add(round_constants, 160)), modulus))
                mstore(INPUT5, addmod(mload(add(input, 160)), mload(add(round_constants, 192)), modulus))
                mstore(INPUT6, addmod(mload(add(input, 192)), mload(add(round_constants, 224)), modulus))
                mstore(INPUT7, addmod(mload(add(input, 224)), mload(add(round_constants, 256)), modulus))
                mstore(INPUT8, addmod(mload(add(input, 256)), mload(add(round_constants, 288)), modulus))
                mstore(INPUT9, addmod(mload(add(input, 288)), mload(add(round_constants, 320)), modulus))
                mstore(INPUT10, addmod(mload(add(input, 320)), mload(add(round_constants, 352)), modulus))
                mstore(INPUT11, addmod(mload(add(input, 352)), mload(add(round_constants, 384)), modulus))
                mstore(INPUT12, addmod(mload(add(input, 384)), mload(add(round_constants, 416)), modulus))
                mstore(INPUT13, addmod(mload(add(input, 416)), mload(add(round_constants, 448)), modulus))
                mstore(INPUT14, addmod(mload(add(input, 448)), mload(add(round_constants, 480)), modulus))
                mstore(INPUT15, addmod(mload(add(input, 480)), mload(add(round_constants, 512)), modulus))
                mstore(INPUT16, addmod(mload(add(input, 512)), mload(add(round_constants, 544)), modulus))
                mstore(INPUT17, addmod(mload(add(input, 544)), mload(add(round_constants, 576)), modulus))
                mstore(INPUT18, addmod(mload(add(input, 576)), mload(add(round_constants, 608)), modulus))
                mstore(INPUT19, addmod(mload(add(input, 608)), mload(add(round_constants, 640)), modulus))
                mstore(INPUT20, addmod(mload(add(input, 640)), mload(add(round_constants, 672)), modulus))
                mstore(INPUT21, addmod(mload(add(input, 672)), mload(add(round_constants, 704)), modulus))
                mstore(INPUT22, addmod(mload(add(input, 704)), mload(add(round_constants, 736)), modulus))
                mstore(INPUT23, addmod(mload(add(input, 736)), mload(add(round_constants, 768)), modulus))
                mstore(INPUT24, addmod(mload(add(input, 768)), mload(add(round_constants, 800)), modulus))
            }

            let offset_arc := 800

            // first half of full rounds
            let index := 0
            for {} lt(index, half_of_full_rounds_minus_1) {} {
                sbox_full(modulus)
                add_round_constants(round_constants, offset_arc, modulus)
                offset_arc := add(offset_arc, 800)
                mix(c_m, modulus)

                index := add(index, 1)
            }

            sbox_full(modulus)
            add_round_constants(round_constants, offset_arc, modulus)
            offset_arc := add(offset_arc, 800)
            mix(c_psm, modulus)

            // partial rounds
            let offset_mix := 0
            index := 0
            for {} lt(index, partial_rounds) {} {
                mstore(INPUT0, sbox(mload(INPUT0), modulus))
                mstore(INPUT0, addmod(mload(INPUT0), mload(add(round_constants, add(offset_arc, 32))), modulus))
                offset_arc := add(offset_arc, 32)

                mix_sparse(v_rests, w_hats, offset_mix, modulus)
                offset_mix := add(offset_mix, 32)

                index := add(index, 1)
            }

            // last half of full rounds
            index := 0
            for {} lt(index, half_of_full_rounds_minus_1) {} {
                sbox_full(modulus)
                add_round_constants(round_constants, offset_arc, modulus)
                offset_arc := add(offset_arc, 800)
                mix(c_m, modulus)

                index := add(index, 1)
            }

            // final round
            sbox_full(modulus)
            mix(c_m, modulus)

            hash := mload(INPUT1)
        }

        console.log("gas cost: ", gasCost - uint256(gasleft()));

        return hash;
    }
}
