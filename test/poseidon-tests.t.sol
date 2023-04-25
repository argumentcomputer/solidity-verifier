// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@std/Test.sol";
import "src/poseidon/Poseidon.sol";

contract PoseidonContractTest is Test {

    function testDebug() public {
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
        Poseidon.HashInputs7 memory state = Poseidon.HashInputs7 (
            0x0000000000000000000000000000000000000000000000000000000100000000,
            0x4eda116c5395cf1a8c45a5bfca8d6f0b02cd2a581700b5dcdb7bc8aab66f78eb,
            0x5ab9ba8f9693639e230657a66daa7b3f2c0409ed77fe2d09fa76f8ee3f69717e,
            0x2ed3e4145bc5a7d82bae4669226e2d6329c3c1705d07d77e0a2df51ce664d7ee,
            0x2a8f1709c1450f2e2a7a773993ab788b81c1c2d2182778e388ef3c3b25304a89,
            0x3e67aa78a45a9dfcdafbe7c301ec603c2140b90628baf218e9af2a43bc314426,
            0x47ca0a5a9a5dfe0a8e08614565605d330a9bba17537b781bb77cf8da948657c5
        );

        uint actual = Poseidon.hash_t7f6p52(state, bls12CurveModulus);

        uint expected = 0x67cc1a9381c717d9b92cb82a5eb625c9e836351074a9ae8e0fa75b3d063ae6c0;

        assertEq(expected, actual);
    }
}