// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.16;

import "@std/Test.sol";
import "src/NovaVerifierAbstractions.sol";
import "src/blocks/KeccakTranscript.sol";
import "src/verifier/zeromorph/Step8Zeromorph.sol";

contract PpSpartanZeromorphStep8Computations is Test {
    function loadZeromorphProof() public returns (Abstractions.EvaluationArgumentZMProof memory) {
        uint256 pi_x = 0x1a1951fa731fde4e28573858009645d5372f61f3ac3bd7b86ac03cac61669e4c;
        uint256 pi_y = 0x17c4238551f4a3b92c11ae07bb59bed97a53d6bce11bf31d0900f11afefe325e;
        uint256 cqhat_x = 0x124440d97938a7016f54d882b4534b6a0dfce9ec588124af33073f652de6e558;
        uint256 cqhat_y = 0x0af3d6d60611fedf1384e014feb1e3429926cd423983a0124a005cab83c90dbe;
        Bn256.Bn256AffinePoint[] memory ck = new Bn256.Bn256AffinePoint[](17);
        ck[0] = Bn256.Bn256AffinePoint(
            0x02732a093c880ec69da7f043a724c71349080205c9a6913d04af491fb7acabd6,
            0x15f7f12ae7cd522f7ead0ca4cb95989cd4065df3a10cdc5dab49a989622fdac0
        );
        ck[1] = Bn256.Bn256AffinePoint(
            0x2505aa569ad73f3d582f9dfccbab97c2ff202e91ab7ecb7ccda59b56598d5929,
            0x1b995512ca43140dc5fc8bee6e912329c6b3f2618c3b58fda7b98919e18e2633
        );
        ck[2] = Bn256.Bn256AffinePoint(
            0x1fb623e0ae71c025416b09d0f00ad8f53675ccf85144912f82de0255a3cabc1e,
            0x2d7418cc827bc08cfdbd2f59726cf370c81adb8850b18147ed78e52a12cf30fe
        );
        ck[3] = Bn256.Bn256AffinePoint(
            0x2088058bf502c05556cfe5d1e26c6ee40372339cd86468d4abc36ac7a67119ac,
            0x2fa7df8403e8473843caeaa7338908a16fe2761873df2bfc1945c9b5a562e703
        );
        ck[4] = Bn256.Bn256AffinePoint(
            0x1876f0167bcd2c8f76ea74f7787364d7759581617e3f92f3517071e5b417c5ba,
            0x2c3cd5446436f9d6ad5f1f6918e92ce1f382a1623b04c988e389e72350b8d72f
        );
        ck[5] = Bn256.Bn256AffinePoint(
            0x23b83f842767356a8a6f675f2359df148dab29f2124f4845c1f0c6f31ff1c97c,
            0x004b1a805d4ea4b9631048771bec30e6d3365856cbd3921f3f9406be452c6ca8
        );
        ck[6] = Bn256.Bn256AffinePoint(
            0x0c692940caed7bb4e50199b0cfb12e2a100db635a2af628db51852a5a9ad2264,
            0x10726289a84fe88e7592edeff33a583d1303060336114a7f624797650792c2a8
        );
        ck[7] = Bn256.Bn256AffinePoint(
            0x16034531b1e91ccd99f195e33535f974aef02b03014413e6768c2959499e8898,
            0x190d9814ffd7edb604382c813789b31b73bcb9d6ce16c8f55d703fa3df942c53
        );
        ck[8] = Bn256.Bn256AffinePoint(
            0x277bcd735d9522cdb64e16b9764d9364362c0a7372564ca4fce3d2d80f35c0d6,
            0x241333388ef4bfc22a546048f3ae592d9bf0cf8f02728768d0b7927cfa13feef
        );
        ck[9] = Bn256.Bn256AffinePoint(
            0x253a5ab08250dece4363d2a97619e07f35efc8f9bf0da6cc41f231f70f1e26fa,
            0x296f9e09207e79cc211bf2e5bd970273f305a5103b7115503bdc04a8488b3fda
        );
        ck[10] = Bn256.Bn256AffinePoint(
            0x29559e4daebf4e0378db80bd906ba7aea3d9aa379e47121d21bc302d6ee263e8,
            0x23cf346e59bcc70b59762786d1c92fe800b6f3c78fac5a3360afe9cb82f041cd
        );
        ck[11] = Bn256.Bn256AffinePoint(
            0x2ba9936d0b68c34cf10b7cfb2f7185a170a2b3453a0f4c3e5b055cacd4c663a7,
            0x2cad5597147749dcb5978d678b22bf89eec93c1f51c8833121f99392fbfa4bae
        );
        ck[12] = Bn256.Bn256AffinePoint(
            0x13fb93108d9533a3852e9101898eb7ffdc67afb445d01366fdb62b51bf45ae64,
            0x1e0a9d11922bdbcdc9566f3dfcbddfd6874834443c18f251576c5f5845e6f79d
        );
        ck[13] = Bn256.Bn256AffinePoint(
            0x08dc8a38f7d51496b6f95d242133c27f49743081ff6c8c5b2e2b8e82c0da947d,
            0x1511025c66ebd81446f97907a621b72e374e829e3045b909410e165d9075d223
        );
        ck[14] = Bn256.Bn256AffinePoint(
            0x2cb989f402713f00d30cccb02ae06302fc863a1c13de1d0fe52e5aa55c1d6acd,
            0x1df85f1aaca220d0c75da5fdb090bd192e67be6a67cf4cb0111812989649b9f9
        );
        ck[15] = Bn256.Bn256AffinePoint(
            0x1bb55508f3bd9db2022ec398f929967596543b9d4c92443455523032a53c2f72,
            0x0836cf76fc743eae5eef55e311712686113ffeb65225f51d6232430d4759e208
        );
        ck[16] = Bn256.Bn256AffinePoint(
            0x0c019cd4289f6c7848cc542dbff194fcf8a588bde305527d1e054bf657ae5873,
            0x1044c55409d48d94bac79a324a248add2a98f7aa5ca59c7648e259046d70d7bc
        );
        return Abstractions.EvaluationArgumentZMProof(pi_x, pi_y, cqhat_x, cqhat_y, ck);
    }

    function loadTranscript() public returns (KeccakTranscriptLib.KeccakTranscript memory) {
        uint16 rounds = 78;
        uint8[] memory state = new uint8[](64);
        state[0] = 0xd3;
        state[1] = 0xe3;
        state[2] = 0x3c;
        state[3] = 0x68;
        state[4] = 0xaa;
        state[5] = 0x01;
        state[6] = 0x90;
        state[7] = 0x80;
        state[8] = 0xcb;
        state[9] = 0x6f;
        state[10] = 0x44;
        state[11] = 0x75;
        state[12] = 0xb7;
        state[13] = 0xf2;
        state[14] = 0x73;
        state[15] = 0x8d;
        state[16] = 0x4e;
        state[17] = 0xea;
        state[18] = 0x1f;
        state[19] = 0x47;
        state[20] = 0xe7;
        state[21] = 0x74;
        state[22] = 0xb7;
        state[23] = 0x47;
        state[24] = 0x64;
        state[25] = 0xd0;
        state[26] = 0xcb;
        state[27] = 0xc7;
        state[28] = 0x73;
        state[29] = 0x90;
        state[30] = 0xf7;
        state[31] = 0x7d;
        state[32] = 0xdb;
        state[33] = 0x50;
        state[34] = 0x94;
        state[35] = 0x41;
        state[36] = 0x6f;
        state[37] = 0x7c;
        state[38] = 0x40;
        state[39] = 0xeb;
        state[40] = 0x20;
        state[41] = 0x2e;
        state[42] = 0xa4;
        state[43] = 0xb9;
        state[44] = 0x4a;
        state[45] = 0x0b;
        state[46] = 0xaa;
        state[47] = 0x47;
        state[48] = 0xe8;
        state[49] = 0x05;
        state[50] = 0x3c;
        state[51] = 0x55;
        state[52] = 0xd4;
        state[53] = 0xb3;
        state[54] = 0x8f;
        state[55] = 0x2f;
        state[56] = 0x89;
        state[57] = 0x6c;
        state[58] = 0x3f;
        state[59] = 0x31;
        state[60] = 0xd7;
        state[61] = 0xf6;
        state[62] = 0x5f;
        state[63] = 0x2f;

        uint8[] memory transcript = new uint8[](0);

        return KeccakTranscriptLib.KeccakTranscript(rounds, state, transcript);
    }

    function loadZeromorphVerifierKey() public returns (Abstractions.UVKZGVerifierKey memory) {
        uint256 g_x = 0x19bda954d37c89a7ec5421733e948eb0b3337c4e900e83f4e6421669f8926a2c;
        uint256 g_y = 0x273f124cb69142991467b4ecc2064f0d6e69541632b6858405d5c17400275aa7;

        Abstractions.UVKZGVerifierKey memory vp = Abstractions.UVKZGVerifierKey(g_x, g_y);
        return vp;
    }

    function testDebug() public {
        KeccakTranscriptLib.KeccakTranscript memory transcript = loadTranscript();
        Abstractions.EvaluationArgumentZMProof memory zm_proof = loadZeromorphProof();
        Abstractions.UVKZGVerifierKey memory vp = loadZeromorphVerifierKey();
        Bn256.Bn256AffinePoint memory comm_joint = Bn256.Bn256AffinePoint(
            0x026840bdc049abdc2b68be3e7fc7af89436a653b9f9c12a0685d329e100643eb,
            0x131cd39c5bf1d41d4370ab0713893af55dc87fd8799d37106c9f237cb6446157
        );

        uint256[] memory r_z = new uint256[](17);
        r_z[0] = 0x1defc1b4602cfcbb0bd90b4f0df27d9b1b849b380ac3a0a053251f9361fdd65a;
        r_z[1] = 0x0ea6c202496ca483a713b82bcc0a50c12a6b73d07dd6e6389e1b2be32d8ac53f;
        r_z[2] = 0x22e42d920af98aeafd3328567f2abedc61ceebb526c98572d5b19d3bb2e7d26e;
        r_z[3] = 0x218f0d8f30118b3d4e48b46eb6edc4232455e51e91c7c2cea747490f367e1da2;
        r_z[4] = 0x0d593911e89103f83a3b3622f9ae8eac293e2a264afd2fb6dcaaa55938747560;
        r_z[5] = 0x09fd4a7e0d73c65a18b4057c0525bffa368881b02fc63d7534a60067916d77c6;
        r_z[6] = 0x0d18950f37dcd6b8b2f8b51f5a408c238be83bcfb6ca3521cf7c317c02ef0351;
        r_z[7] = 0x0c4188a423dacaa7347b1c31dc820104e7d22b4b1e4666f8c8bea2d83e57c931;
        r_z[8] = 0x0dcbf36e8a088ec8a6dc9bf89d869f209ec33af18e9db09a447e342bf4faab84;
        r_z[9] = 0x29b17435b0000e8a93c07aff0a9cd65a72af5ef3bd6942fb87c5b066db5623ae;
        r_z[10] = 0x2051ad80cf7fed228ab0903627e28365b97f019ac131689f9a60f8c1c1be9915;
        r_z[11] = 0x1bfa9803b8c28171925ee80b95381f6981a0c6fc8b4695421d1a28d75f2aa4e2;
        r_z[12] = 0x15759ac8b62673484298ecba49917c38479310bc884ecf04315f03e94bc5da3d;
        r_z[13] = 0x2f40239779f36fa9331fe2c3771bc4099902117174edfdd4c0850d8ee84f11f6;
        r_z[14] = 0x01a6fa70ded57385201da6f9e024549a93c8fc59380197db0163a04068f98cfe;
        r_z[15] = 0x0c84cd0ae4299616c5a1afedbfde638bdd2921230f78b9bc58b68355215b0f3b;
        r_z[16] = 0x21754d788f1840a109bd7a4f8d84c677c142326de145c78fc5d7c99dd09014bb;

        uint256 evaluation = 0x1e87e97fff7a0ae2efd16bec475fd68cdc493b11ecb72b32be8bcb4f827d4f69;

        uint256 gasCost = gasleft();
        assert(Step8GrumpkinZeromorphLib.verify(transcript, zm_proof, vp, r_z, evaluation, comm_joint));
        console.log("gas cost: ", gasCost - gasleft());
    }
}
