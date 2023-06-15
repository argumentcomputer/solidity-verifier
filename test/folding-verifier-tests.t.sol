// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.0;

import "@std/Test.sol";
import "src/verifier/step3/Step3Logic.sol";

contract FoldingVerifierTest is Test {
    function testVerify() public {

        // // unfolded initial RelaxedR1CSWitness
        // uint256[4] memory r_W_W = [uint(0x0), uint(0x0), uint(0x0), uint(0x0)];
        // uint256[4] memory r_W_E = [uint(0x0), uint(0x0), uint(0x0), uint(0x0)];

        // unfolded initial R1CSInstance
        Pallas.PallasAffinePoint memory u1_comm_W = 
        Pallas.IntoAffine(
            Pallas.PallasProjectivePoint(
                0x33994e94205b12e08375c9d864e0461fb8f834c677669ba3fe0fbedc07a88447,
                0x2eb7ce4fe3644be8df61651e1a5a4ccb824c83ea713af157b3a44b255e742ddc,
                0x323fba7fd1181553e40103a03d7b057a8b3e6467bf48bd31d410a41572062437
            )
        );

        uint256[] memory u1_X = new uint256[](2);
        u1_X[0] = 0x1d842dd4649f21030e41842d3c26665d0a36ecc6b1a6b83b753bcee3111be156;
        u1_X[1] = 0x3150178e6572a3f0ff91ec7501d1581e7348d96101b1e092dfc2c2784b4428c9;

        NIFSPallas.R1CSInstance memory u1 = NIFSPallas.R1CSInstance(u1_comm_W, u1_X);

        // Pallas.PallasAffinePoint memory comm_W = Pallas.AffineInfinity();
        // Pallas.PallasAffinePoint memory comm_E = Pallas.AffineInfinity();

        uint256[] memory r_U_X = new uint256[](2);
        r_U_X[0] = 0x0;
        r_U_X[1] = 0x0;

        // uint256 r_U_u = 0;

        NIFSPallas.RelaxedR1CSInstance memory r_U = 
            NIFSPallas.RelaxedR1CSInstance(Pallas.AffineInfinity(), Pallas.AffineInfinity(), r_U_X, 0);


        // result of the first NIFS::prove
        NIFSPallas.NIFS memory res_1_nifs = NIFSPallas.NIFS([0,0,0,0,0,0,0,0,
                                                             0,0,0,0,0,0,0,0,
                                                             0,0,0,0,0,0,0,0,
                                                             0,0,0,0,0,0,0,0]);

        Pallas.PallasAffinePoint memory res_1_U_comm_W = 
        Pallas.IntoAffine(
            Pallas.PallasProjectivePoint(
                0x1b7bc2c4634610cc853340c6b525c4fc1ad63b2a1f55bfce4263b4052b091607,
                0x1a3574b82a61aaca640db15271cb643f452a741758ef5938b669b42767090e7c,
                0x2a4b792425aba98ebda29118ef48a6d1d06941da381de5b7acba9c6bfeb564f4
            )
        );

        // Pallas.PallasAffinePoint memory res_1_U_comm_E = Pallas.AffineInfinity();

        uint256[] memory res_1_U_X = new uint256[](2);

        res_1_U_X[0] = 0x2c76b1ae028a798f6cb21b12425f677795496230c6ff7c48ccd6a63e64344014;
        res_1_U_X[1] = 0x0dffa6d558f2fe7d0b36d749bdd43a0c95fe60a7a4ef70d9b142981c4c994a30;

        uint256 res_1_U_u = 0x00000000000000000000000000000000efa47160861ed8a71abb45fe468cb6dd;

        // NIFSPallas.RelaxedR1CSInstance memory res_1_U = NIFSPallas.RelaxedR1CSInstance(
        //     res_1_U_comm_W,
        //     res_1_U_comm_E,
        //     res_1_U_X,
        //     res_1_U_u
        // );

        NIFSPallas.RelaxedR1CSInstance memory res = NIFSPallas.verify(res_1_nifs, 0, r_U, u1);

        // Check the resulting RelaxedR1CSInstance is the one obtained by proving
        assertEq(res.comm_W.x, res_1_U_comm_W.x);
        assertEq(res.comm_W.y, res_1_U_comm_W.y);
        assert(Pallas.isInfinity(res.comm_E));
        assertEq(res.u, res_1_U_u);
        assertEq(res.X, res_1_U_X);
    }
}