// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@std/Test.sol";
import "src/poseidon/PoseidonNeptuneU6.sol";
import "src/poseidon/PoseidonNeptuneU24.sol";

contract PoseidonContractTest is Test {

    function testPoseidonNeptuneU6Compatibility() public {
        /*
            let domain_separation = HashType::Encryption;
            let security_level = Strength::Standard;
            let constants: PoseidonConstants<Fr, U6> =
                PoseidonConstants::new_with_strength_and_type(security_level, domain_separation);

            let mut new = Poseidon::<Fr, U6>::new(&constants);

            let mut rng = OsRng;
            let random_data= (0..6).into_iter().map(|_| {
                let scalar = Scalar::random(&mut rng);
                println!("scalar: {:?}", scalar);
                scalar
            }).collect::<Vec<Scalar>>();

            new.set_preimage(&random_data);

            let digest = new.hash_in_mode(HashMode::Correct);
            println!("digest: {:?}", digest);
        */

        uint bls12CurveModulus = uint(bytes32(0x73eda753299d7d483339d80809a1d80553bda402fffe5bfeffffffff00000001));

        // In neptune we use domain separation, so first field element doesn't hold actual data - rather service information
        PoseidonU6.HashInputs7 memory state = PoseidonU6.HashInputs7 (
            0x0000000000000000000000000000000000000000000000000000000100000000,
            0x4eda116c5395cf1a8c45a5bfca8d6f0b02cd2a581700b5dcdb7bc8aab66f78eb,
            0x5ab9ba8f9693639e230657a66daa7b3f2c0409ed77fe2d09fa76f8ee3f69717e,
            0x2ed3e4145bc5a7d82bae4669226e2d6329c3c1705d07d77e0a2df51ce664d7ee,
            0x2a8f1709c1450f2e2a7a773993ab788b81c1c2d2182778e388ef3c3b25304a89,
            0x3e67aa78a45a9dfcdafbe7c301ec603c2140b90628baf218e9af2a43bc314426,
            0x47ca0a5a9a5dfe0a8e08614565605d330a9bba17537b781bb77cf8da948657c5
        );

        uint actual = PoseidonU6.hash(state, bls12CurveModulus);

        uint expected = 0x67cc1a9381c717d9b92cb82a5eb625c9e836351074a9ae8e0fa75b3d063ae6c0;

        assertEq(expected, actual);
    }

    /// This is how Neptune is used in Nova context - e.g. via SAFE API with variable number of absorbs and one squeeze. Arity is U24.
    function testPoseidonNeptuneU24Compatibility() public {
        /*
            let domain_separation = HashType::Sponge;
            let security_level = Strength::Standard;
            let constants: PoseidonConstants<Fr, U24> =
                    PoseidonConstants::new_with_strength_and_type(security_level, domain_separation);

            let mut new = Poseidon::<Fr, U24>::new(&constants);

            let mut rng = OsRng;
            let random_data= (0..24).into_iter().map(|_| {
                let scalar = Scalar::random(&mut rng);
                println!("scalar: {:?}", scalar);
                scalar
            }).collect::<Vec<Scalar>>();

            new.set_preimage(&random_data);

            let digest = new.hash_in_mode(HashMode::Correct);
            println!("\ndigest: {:?}", digest);
        */

        uint bls12CurveModulus = uint(bytes32(0x73eda753299d7d483339d80809a1d80553bda402fffe5bfeffffffff00000001));
        // In neptune we use domain separation, so first field element doesn't hold actual data - rather service information
        PoseidonU24.HashInputs25 memory state = PoseidonU24.HashInputs25 (
            0x0000000000000000000000000000000000000000000000000000000000000000,
            0x240379f1568ff9ed9906fe7d7094d69b0ed3f5dcbb78b0485e069f74f8f5ff3b,
            0x5907ad407be50278d3944ed2530e63fb25cbfc366d31f8965510a946a893cbab,
            0x2a83620efa2462f7c998b9b9ad87dad51306214e67716674f8da47b1efe20439,
            0x100a7a62383cf3e2f706394bfef754b55328717ca33280054ad5a865aaa56d53,
            0x4f091847f7bc0b42668b8f7a91b315a1d6c9a2a26f799648d08bd681a3de1abf,
            0x5ff2b84842a51be0025dba63eb448f3f001513e3a5199d686aca0d94c01e82b3,
            0x2cc7bf852ee4809c6fc5723f73558f5a1ea34b99f3967e0aa1481f91def2e889,
            0x2bf6423ed6796dd120aa3ff28c5dd8d8acb4a9df800366f1826791c21734df8f,
            0x0b6174acf12b588b8e5da43f620b917c5af4e9235e28cf9001a1f139eb7a7e74,
            0x1ce63209d6eb6e1c895a044f3c884efa20a30c9ee446fa6cf94a5b0f09ac9d40,
            0x56d8e72bf9169c85e3e60e90b6387b9fc3ed988a957db0957edd6c8aa6d186ae,
            0x18c159c2488ceae04da7a4040c6f29ff8feab351b9c3a93642551ee002b61a34,
            0x675264caafc14c28d0c6c14c4f6bd304a1108652ebc7b1a1030858089ff99e0b,
            0x2296c647f0864701c0391933a122217b6c09a68e2affe61b63b6cafdfecf209e,
            0x648f39534912dc99b2733cb72aaa8d10175bc156f8928d833b043c65f40d46f3,
            0x193fbfabb3b1daf3f8d933f176c25f2fc2ec53953e0babd3e0994f8168473200,
            0x052b6819e717202fe74b09bd32ea31e276382292635f0a227ddd75ec8b4c94d3,
            0x61ca456ba60872c1a3ba1ef373abc154fc7a685694bc13a1f50339e64ef4250f,
            0x0ec9dcc0dd0ad94caa0ed853c6333e117265d9a5da00b5268b127219ff448c16,
            0x1a14dafb1e8e487322b6d551e57bbcffbcf26a96e5ae36e47b88839f24c61f7a,
            0x4f492fb641c2af36001026acfd2c5d3458d35e8e186682c0f6ffe7baaf7c89d3,
            0x04b6ffd0e023cb33f146d9eb1c32f86319baea730c3a52e782a90bc9ac6f7350,
            0x6e58f5b1b72dc0794bdd6f284b0d3c6bebc4c40c6e13bcbbe641f5bc932ff629,
            0x6b2dc870132b54df34d5a825d114eb0c42ed6d5ce37e454ca83bd6b1304db121
        );

        uint actual = PoseidonU24.hash(state, bls12CurveModulus);

        uint expected = 0x2c3668faf2d4885e67e8b5ee65e8f2e28a73fd4a82b19ec87a7068ef40d6bc37;

        assertEq(expected, actual);
    }
}
