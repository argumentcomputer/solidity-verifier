// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.0;

import "@std/Test.sol";
import "src/blocks/pasta/Pallas.sol";
import "src/blocks/pasta/Vesta.sol";
import "src/Field.sol";
import "src/verifier/step3/Step3Logic.sol";
import "src/verifier/step3/Step3Data.sol";

contract FoldingVerifierTest is Test {
    function testTinyInstanceFolding() public {
        /*
            Test vector generated using

            let mut csprng = ChaChaRng::from_seed([17u8; 32]);

            in test_tiny_r1cs_with
        */

        // unfolded initial R1CSInstance
        Pallas.PallasAffinePoint memory u1_comm_W = Pallas.IntoAffine(
            Pallas.PallasProjectivePoint(
                0x1c178ee13ca557d2c68c77ae48361df45fdaa5504297d1af622902242afcf154,
                0x330fab9610d3222bfd999f8297b647a902ef98b099aef8d93743a4f870ec904c,
                0x08f4a8de0b7df4347d41a278ee4a3be366ba18cb130c907271849c1d0387677b
            )
        );

        uint256[] memory u1_X = new uint256[](2);
        u1_X[0] = 0x2ab11c4b451eab35b0e5407e4eacb780a317a34935c4c0d5511f6b00a493389f;
        u1_X[1] = 0x0b475cff3a5f46b549451802e64ded130c5151037f31b5174ef9036746c5ba0e;

        NIFSPallas.R1CSInstance memory u1 = NIFSPallas.R1CSInstance(u1_comm_W, u1_X);

        // RelaxedR1CSInstance

        uint256[] memory r_U_X = new uint256[](2);
        r_U_X[0] = 0x0;
        r_U_X[1] = 0x0;

        NIFSPallas.RelaxedR1CSInstance memory r_U =
            NIFSPallas.RelaxedR1CSInstance(Pallas.AffineInfinity(), Pallas.AffineInfinity(), r_U_X, 0);

        // NIFS instance
        // result of the first NIFS::prove
        NIFSPallas.NIFS memory input_nifs = NIFSPallas.NIFS(
            Field.uint8ArrayToBytes32(
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
            )
        );

        Pallas.PallasAffinePoint memory res_U_comm_W = Pallas.IntoAffine(
            Pallas.PallasProjectivePoint(
                0x1603f1814dac3534ae4091202fe2eb88832983a9fbaa5ebeec6d3dfabbdae892,
                0x0d022bd151c061d4e91f3ff131b39d0fba10919f860e831412a815dae1295b77,
                0x2f857938dfeddd66b08b95a7dba0d0b8b76d6f8ea1f64e96668fdd25a018436c
            )
        );

        uint256[] memory res_U_X = new uint256[](2);

        res_U_X[0] = 0x0699b06b6ebadaf9d40cba2d702f48fad255059f25d85441bcf706bc0510b95e;
        res_U_X[1] = 0x3307f24938c5acb2fa00b27fc0a1e733f48bc7cf4a4558febed97167978bb576;

        uint256 res_U_u = 0x000000000000000000000000000000006cbba3b281698850b3c9ea90b6ccbb65;

        NIFSPallas.RelaxedR1CSInstance memory res = NIFSPallas.verify(input_nifs, 0, r_U, u1);

        // Check the resulting RelaxedR1CSInstance is the one obtained by proving
        assertEq(res.comm_W.x, res_U_comm_W.x);
        assertEq(res.comm_W.y, res_U_comm_W.y);
        assert(Pallas.isInfinity(res.comm_E));
        assertEq(res.u, res_U_u);
        assertEq(res.X, res_U_X);

        // Second input R1CSInstance
        u1_comm_W = Pallas.IntoAffine(
            Pallas.PallasProjectivePoint(
                0x166c397590b591b38485f4d4db866afd8aecd4255d00e70153d7cc3ce3186b51,
                0x274173e01c6133a2a90faa0296496c2661cd7c04d79c190ef6f43c1764565ca5,
                0x1d535198a7eb87ce16d7f0aa529729c1128637b3f83777d966be58c8f2a5b5b6
            )
        );

        u1_X[0] = 0x0b475cff3a5f46b549451802e64ded130c5151037f31b5174ef9036746c5ba0e;
        u1_X[1] = 0x188fbd43956fbf712f60b46fb3a0d608c99ae9f7f4f2d7f7becd150dee669089;

        u1 = NIFSPallas.R1CSInstance(u1_comm_W, u1_X);

        // Result of the second NIFS::prove
        input_nifs = NIFSPallas.NIFS(
            Field.uint8ArrayToBytes32(
                [
                    168,
                    57,
                    208,
                    82,
                    169,
                    86,
                    167,
                    134,
                    12,
                    8,
                    190,
                    237,
                    144,
                    237,
                    99,
                    68,
                    3,
                    22,
                    144,
                    12,
                    90,
                    70,
                    28,
                    172,
                    86,
                    202,
                    180,
                    126,
                    45,
                    205,
                    39,
                    5
                ]
            )
        );

        res_U_comm_W = Pallas.IntoAffine(
            Pallas.PallasProjectivePoint(
                0x122238e71a344dde362e92c65f93690c6f356c6666db533f5d0f39e8ab134ab2,
                0x2a1550650218ca763a7cd9fe48e67d97a6c39fd69b7043fb39eaeced7c5ed721,
                0x0008d28e00b56e6dffbde9cc3caa4415789d013d2ca8f6b5483edee2087720c2
            )
        );

        Pallas.PallasAffinePoint memory res_U_comm_E = Pallas.IntoAffine(
            Pallas.PallasProjectivePoint(
                0x1e87a801f6b831cbce80ce8b1585cb690307ef8e871fbf0bbf58e199bd1801ee,
                0x1cccc4e22a8c9ce3716046a8d4bc6d7406164e0f89621d34460a566b8170b658,
                0x0534667e7d16b8e798bd1bca1242c6f5d4f7677eb37846cba8688f65a1c11cd2
            )
        );

        res_U_X[0] = 0x3fa77fe734b081a54b7d6c05ab52246994ceee962993c5f1d8d1ba9b9a9f2292;
        res_U_X[1] = 0x3bb3e2353aa89382debe2689f2e2b153d54a95d647d6a390c277f1d65e892815;

        res_U_u = 0x00000000000000000000000000000000bca88a0bf16269fef2be84cbdf620537;

        NIFSPallas.RelaxedR1CSInstance memory res2 = NIFSPallas.verify(input_nifs, 0, res, u1);

        assertEq(res2.comm_W.x, res_U_comm_W.x);
        assertEq(res2.comm_W.y, res_U_comm_W.y);
        assertEq(res2.comm_E.x, res_U_comm_E.x);
        assertEq(res2.comm_E.y, res_U_comm_E.y);
        assertEq(res2.u, res_U_u);
        assertEq(res2.X, res_U_X);
    }
}
