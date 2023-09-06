// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.16;

import "@std/Test.sol";
import "src/NovaVerifierAbstractions.sol";
import "src/verifier/Step1.sol";
import "src/verifier/Step2Grumpkin.sol";
import "test/utils.t.sol";

contract PpSpartanStep1Step2Computations is Test {
    function loadTestProof() private returns (Abstractions.CompressedSnark memory) {
        Abstractions.CompressedSnark memory proof;

        uint256[] memory l_u_secondary_X = new uint256[](2);
        l_u_secondary_X[0] = 0x023361c80ce57f1f312081a10254e699c0f148a7ece8d685656549c78bea18ef;
        l_u_secondary_X[1] = 0x00730e25342e24057fcd53fc978b7d6e60159e67cdeec13a53c5abea8b261540;

        uint256[] memory r_u_primary_X = new uint256[](2);
        r_u_primary_X[0] = 0x08f230d21087f2e0ea33703b5a0de3b92ff58b09b8bdbcee2016f70d7699cbd9;
        r_u_primary_X[1] = 0x1e7d17e953a2bee716b7139675a0fc9c1a3d34f00c1c071eac84e21f33841927;

        uint256[] memory r_u_secondary_X = new uint256[](2);
        r_u_secondary_X[0] = 0x061a2f5f4992d13d51a5c0de405bc5757db93f1017a028dad7733e3a76c5ebd4;
        r_u_secondary_X[1] = 0x22d8987b56519e9839c8896b472ffe00e93af2df4e3b9e808a8a6a280b5c968a;

        proof.l_u_secondary = Abstractions.R1CSInstance(
            0x9a139e5911fa3cbb24e8dd66a7e6ad54057e5895adaa43be5b2cc8c1f7d8081e, l_u_secondary_X
        );
        proof.r_U_primary = Abstractions.RelaxedR1CSInstance(
            0x2515118a9651a9fbbb31e98929e94cf118f973f8227e4f5e3e19e8f86306fa07,
            0x576283d72a0a70468e57b0b0b163e2313bbc66a0c5fdb2a8f7a5126c10acc74d,
            r_u_primary_X,
            0x000000000000000000000000000000010a3cb5af114bc6094024d5e8b5817038
        );
        proof.r_U_secondary = Abstractions.RelaxedR1CSInstance(
            0x88bed3689a94506fe46065e5600749882804d3bf4793864638f641b3b2325157,
            0x924c225b250e5c8ad64bf84be692ab94a868f40c730086344eea3e979979d727,
            r_u_secondary_X,
            0x0000000000000000000000000000000178199520d5ba0196f34b2ac2a3e306f4
        );

        proof.zn_primary = new uint256[](1);
        proof.zn_primary[0] = 0x0000000000000000000000000000000000000000000000000000000000000001;

        proof.zn_secondary = new uint256[](1);
        proof.zn_secondary[0] = 0x0000000000000000000000000000000000000000000000000000000000258b63;

        return proof;
    }

    function loadPublicParameters() private returns (Abstractions.VerifierKey memory) {
        Abstractions.VerifierKey memory vk;

        vk.f_arity_primary = 1;
        vk.digest = 0x03e0cc9d0a2e880508793f5f2b0e202504238d16bede6fba0c963b3842ec2d78;
        vk.f_arity_secondary = 1;

        return vk;
    }

    function testStep1() public {
        Abstractions.CompressedSnark memory proof = loadTestProof();
        uint32 numSteps = 3;
        assert(Step1Lib.verify(proof, numSteps)); // can be reused
    }

    function testStep2() public {
        Abstractions.CompressedSnark memory proof = loadTestProof();
        Abstractions.VerifierKey memory vk = loadPublicParameters();
        uint32 numSteps = 3;
        uint256[] memory z0_primary = new uint256[](1);
        z0_primary[0] = 0x0000000000000000000000000000000000000000000000000000000000000001;

        uint256[] memory z0_secondary = new uint256[](1);
        z0_secondary[0] = 0x0000000000000000000000000000000000000000000000000000000000000000;

        assert(
            Step2GrumpkinLib.verify(
                proof,
                vk,
                TestUtilities.loadGrumpkinConstants(),
                TestUtilities.loadBn256Constants(),
                numSteps,
                z0_primary,
                z0_secondary
            )
        );
    }
}
