// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.0;

import "@std/Test.sol";
import "src/verifier/step3/Step3Logic.sol";

contract FoldingVerifierTest is Test {
    function testVerify() public {
        /*
            Test vector generated using

            let mut csprng = ChaChaRng::from_seed([17u8; 32]);

            in test_tiny_r1cs_with
        */

        // unfolded initial RelaxedR1CSWitness
        // uint256[4] memory r_W_W = [uint(0x0), uint(0x0), uint(0x0), uint(0x0)];
        // uint256[4] memory r_W_E = [uint(0x0), uint(0x0), uint(0x0), uint(0x0)];

        // unfolded initial R1CSInstance
        Pallas.PallasAffinePoint memory u1_comm_W = 
        Pallas.IntoAffine(
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

        // Pallas.PallasAffinePoint memory comm_W = Pallas.AffineInfinity();
        // Pallas.PallasAffinePoint memory comm_E = Pallas.AffineInfinity();

        uint256[] memory r_U_X = new uint256[](2);
        r_U_X[0] = 0x0;
        r_U_X[1] = 0x0;

        // uint256 r_U_u = 0;

        NIFSPallas.RelaxedR1CSInstance memory r_U = 
            NIFSPallas.RelaxedR1CSInstance(Pallas.AffineInfinity(), Pallas.AffineInfinity(), r_U_X, 0);


        // NIFS instance
        // result of the first NIFS::prove
        NIFSPallas.NIFS memory input_1_nifs = NIFSPallas.NIFS([0,0,0,0,0,0,0,0,
                                                             0,0,0,0,0,0,0,0,
                                                             0,0,0,0,0,0,0,0,
                                                             0,0,0,0,0,0,0,0]);

        Pallas.PallasAffinePoint memory res_1_U_comm_W = 
        Pallas.IntoAffine(
            Pallas.PallasProjectivePoint(
                0x1603f1814dac3534ae4091202fe2eb88832983a9fbaa5ebeec6d3dfabbdae892,
                0x0d022bd151c061d4e91f3ff131b39d0fba10919f860e831412a815dae1295b77,
                0x2f857938dfeddd66b08b95a7dba0d0b8b76d6f8ea1f64e96668fdd25a018436c
            )
        );

        // Pallas.PallasAffinePoint memory res_1_U_comm_E = Pallas.AffineInfinity();

        uint256[] memory res_1_U_X = new uint256[](2);

        res_1_U_X[0] = 0x0699b06b6ebadaf9d40cba2d702f48fad255059f25d85441bcf706bc0510b95e;
        res_1_U_X[1] = 0x3307f24938c5acb2fa00b27fc0a1e733f48bc7cf4a4558febed97167978bb576;

        uint256 res_1_U_u = 0x000000000000000000000000000000006cbba3b281698850b3c9ea90b6ccbb65;

        // NIFSPallas.RelaxedR1CSInstance memory res_1_U = NIFSPallas.RelaxedR1CSInstance(
        //     res_1_U_comm_W,
        //     res_1_U_comm_E,
        //     res_1_U_X,
        //     res_1_U_u
        // );

        NIFSPallas.RelaxedR1CSInstance memory res = NIFSPallas.verify(input_1_nifs, 0, r_U, u1);

        // Check the resulting RelaxedR1CSInstance is the one obtained by proving
        assertEq(res.comm_W.x, res_1_U_comm_W.x);
        assertEq(res.comm_W.y, res_1_U_comm_W.y);
        assert(Pallas.isInfinity(res.comm_E));
        assertEq(res.u, res_1_U_u);
        assertEq(res.X, res_1_U_X);
    }
}