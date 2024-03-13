// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.16;

import "@std/Test.sol";
import "src/blocks/KeccakTranscript.sol";
import "src/blocks/grumpkin/Bn256.sol";
import "src/blocks/HyperKzg.sol";

contract HyperKzgTest is Test {
    function composeHyperKzgInput() private pure returns (HyperKzg.HyperKzgInput memory) {
        Bn256.Bn256AffinePoint[] memory pi_comms = new Bn256.Bn256AffinePoint[](2);
        pi_comms[0] = Bn256.Bn256AffinePoint(
            0x1e252582f77d12b3fbf9376aa756426e7c9c6496be4f60f35f5b6a09cd65b580,
            0x1f57963fa20b11863d2043784a3a18b2114fb88c1952b6678e50be94d0b80e06
        );
        pi_comms[1] = Bn256.Bn256AffinePoint(
            0x25a9384bbdb73227da1ddb26c8e7563efda3ed03561766e1ebdb0afa1b44ace2,
            0x2c167a83cd2abcef00126bd88f03047cbdcfab86eede65e27a26e0e022dfbe44
        );

        uint256[] memory R_x = new uint256[](3);
        R_x[0] = 0x0668744da4b2c836a526ef2fd7542a5235eb6641607226dc4abbc82b64575fc9;
        R_x[1] = 0x2fd7691f3ffbddb1d736d3383ba404ea1a1c0614d57dad97643851a51b834b5a;
        R_x[2] = 0x037fe8cabffa876afdeea56f06697e141a23180e57ec226273e196d574eb4b85;

        uint256[] memory pi_evals_0 = new uint256[](3);
        pi_evals_0[0] = 0x0c7736e33a1001b108e7a3ac40d072ed01af99ffb87fa2d5ed9750600253ad5a;
        pi_evals_0[1] = 0x124b64189008472130026f55b6ddc63268636603c10c966a74339d933c7261df;
        pi_evals_0[2] = 0x165b65c6cf5ed06ba20bd24fac16b88da1e9c5dd6901eec8ea888cd9cdda95e9;

        uint256[] memory pi_evals_1 = new uint256[](3);
        pi_evals_1[0] = 0x1143360fd32e3d1e6c28544694b073e1549863be33d5cf0bd7df1cfa187f0300;
        pi_evals_1[1] = 0x0eeef019ff0cc2b286f6daf143597325d803ab337fc1527a610746a912e7cbcc;
        pi_evals_1[2] = 0x1a08e8ac11d2cfbe16447366d56a9fcf864a226b10b781c8595968ba22256a8a;

        uint256[] memory pi_evals_2 = new uint256[](3);
        pi_evals_2[0] = 0x0137e8ed95aeb25bdd6f419220919937b9a20b304f5b811e84de9759dfdfa98c;
        pi_evals_2[1] = 0x1e2ee91698c880a7659a7a822645cdb89a9e88ede8e2a15c3557842cfae39a93;
        pi_evals_2[2] = 0x20a23f9e734d84352ef257f9ab6cdbb664f884c2414b38a5681237b6689d909c;

        uint256 p_of_x = 0x0000000000000000000000000000000000000000000000000000000000000039;

        uint256[] memory point = new uint256[](3);
        point[0] = 0x0000000000000000000000000000000000000000000000000000000000000004;
        point[1] = 0x0000000000000000000000000000000000000000000000000000000000000003;
        point[2] = 0x0000000000000000000000000000000000000000000000000000000000000008;

        Bn256.Bn256AffinePoint memory C = Bn256.Bn256AffinePoint(
            0x2217f0ebf964dd979d11a0ad218290dcd70cf9e82d7b20c779fc97e8328f8512,
            0x0dd40f5b93890e2d683b84c06ed37b0fb3982d83df771ab0e7593a930f6ff666
        );
        Bn256.Bn256AffinePoint memory C_Q = Bn256.Bn256AffinePoint(
            0x17fa7dd4c9f33daf159191c6286eb0feca19233f87a72b61a4fb67cf8125f1ac,
            0x210cf9d424ae9e2d49f513dfcf15d914fca1168518c72a1c28e5ac25ac311473
        );
        Bn256.Bn256AffinePoint memory C_H = Bn256.Bn256AffinePoint(
            0x1ad1228340addaff3338e1a3cbf13b12d06f6e1cdee371362d4f7e391a9e7016,
            0x1ec571fa0118a7bc56c260559d9b0b7a4ef65cd0be79450362744ca539e3b7ce
        );

        Bn256.Bn256AffinePoint memory vk_g = Bn256.Bn256AffinePoint(
            0x0fc4701ef297cf49eb0c93df917d8546a35f048f4250ef99fd0fdc50d1848acc,
            0x0e639233f85f7f00b4ad1c99f19236a8fb918ed9a052e86b7ca07575d478e500
        );

        Pairing.G2Point memory beta_h = Pairing.G2Point(
            [
                0x0bb659fbdbc9452452df8b156239350ac7111a21c815356dc1abfc1a5b9d9134,
                0x01c61ba933e55911edcd07161657ea81bbbe15ff3489d16268108ebee888b66b
            ],
            [
                0x009eb4def1cfcf0020557a0fb66341ea45959df5e262d5bfcdebbfa9ed35ca5a,
                0x0e3b956418672742a67e1c980f13e934d8e755af02f8c2fcb63e18ad6a6b6ab4
            ]
        );

        Pairing.G2Point memory h = Pairing.G2Point(
            [
                0x0bd636a3af7014b4d9b117242da8a2163a31e0fe77249cc5daa7e9ba0cb4fadb,
                0x2a14219918143cff7b915de597c9eb6d94fb18db74799a82d09c988f1dc2f67e
            ],
            [
                0x2bcfeeca3782c18f03413d57d31d9a0e02e8059ff5829befa14edcf9f4c1b6d4,
                0x2e0e806bfe80d792ee6c2ef78c11188db5f6b6d0f85bd46fa706316138f7fd0d
            ]
        );

        return HyperKzg.HyperKzgInput(
            pi_comms, R_x, pi_evals_0, pi_evals_1, pi_evals_2, p_of_x, point, C, C_Q, C_H, vk_g, beta_h, h
        );
    }

    function testHyperKzgVerification() public {
        HyperKzg.HyperKzgInput memory input = composeHyperKzgInput();
        KeccakTranscriptLib.KeccakTranscript memory transcript = getTranscript();
        assertTrue(HyperKzg.verify(input, transcript));
    }

    function getTranscript() public pure returns (KeccakTranscriptLib.KeccakTranscript memory) {
        // b"TestEval" in Rust
        uint8[] memory label = new uint8[](8);
        label[0] = 0x54;
        label[1] = 0x65;
        label[2] = 0x73;
        label[3] = 0x74;
        label[4] = 0x45;
        label[5] = 0x76;
        label[6] = 0x61;
        label[7] = 0x6c;

        KeccakTranscriptLib.KeccakTranscript memory keccak_transcript = KeccakTranscriptLib.instantiate(label);
        return keccak_transcript;
    }
}
