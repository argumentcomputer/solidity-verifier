// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.0;

import "@std/Test.sol";
import "src/verifier/step1/Step1Logic.sol";
import "src/verifier/step1/Step1Data.sol";
import "src/verifier/step2/Step2Logic.sol";
import "src/verifier/step2/Step2Data.sol";
import "src/poseidon/Sponge.sol";
import "src/verifier/step4/SubStep2.sol";

contract NovaVerifierContractTest is Test {
    function testVerificationStep1() public pure {
        NovaVerifierStep1Lib.VerifierKeyStep1 memory verifierKeyStep1 = NovaVerifierStep1Lib.loadVerifierKeyStep1();

        uint256[] memory r_u_primary_X = NovaVerifierStep1DataLib.get_r_u_primary_X();

        uint256[] memory l_u_primary_X = NovaVerifierStep1DataLib.get_l_u_primary_X();

        uint256[] memory r_u_secondary_X = NovaVerifierStep1DataLib.get_r_u_secondary_X();

        uint256[] memory l_u_secondary_X = NovaVerifierStep1DataLib.get_l_u_secondary_X();

        NovaVerifierStep1Lib.CompressedSnarkStep1 memory proofDataStep1 = NovaVerifierStep1Lib.loadCompressedSnarkStep1(
            l_u_primary_X, l_u_secondary_X, r_u_primary_X, r_u_secondary_X
        );

        uint32 numSteps = 3;

        NovaVerifierStep1Lib.verify(proofDataStep1, verifierKeyStep1, numSteps);
    }

    function testVerificationStep2() public view {
        uint32 numSteps = 3;
        uint256[] memory z0_primary = new uint256[](1);
        z0_primary[0] = 1;

        uint256[] memory z0_secondary = new uint256[](1);
        z0_secondary[0] = 0;

        NovaVerifierStep2DataLib.CompressedSnarkStep2Primary memory proofDataPrimary =
            NovaVerifierStep2DataLib.getCompressedSnarkStep2Primary();
        NovaVerifierStep2DataLib.CompressedSnarkStep2Secondary memory proofDataSecondary =
            NovaVerifierStep2DataLib.getCompressedSnarkStep2Secondary();
        NovaVerifierStep2DataLib.VerifierKeyStep2 memory vk = NovaVerifierStep2DataLib.getVerifierKeyStep2();
        (PoseidonConstants.Pallas memory pallasConstants, PoseidonConstants.Vesta memory vestaConstants) =
            PoseidonConstants.getPoseidonConstantsForBasicComparison();

        NovaVerifierStep2Lib.verifyPrimary(vestaConstants, proofDataPrimary, vk, numSteps, z0_primary);
        NovaVerifierStep2Lib.verifySecondary(pallasConstants, proofDataSecondary, vk, numSteps, z0_secondary);
    }

    function testPrimaryVerificationStep4SubStep2() public pure {
        uint256[] memory tau = new uint256[](14);
        tau[0] = 0x327f4af4db96711d3192cee19b1946d5b9d3c61e78d6f352261e11af7cbed55a;
        tau[1] = 0x2640290b59a25f849e020cb1b0063861e35a95a8c42a9cdd63928a4ea856adbf;
        tau[2] = 0x11b72e2a69592c5545a794428674fd998d4e3fbd52f156eca4a66d54f09f775e;
        tau[3] = 0x09b0dcdd3ebe153fea39180a0f6bf9546778ffd7e288088489529aa95097fcea;
        tau[4] = 0x3757c49e53ce7f58203159e411db2fe38854df4fc7a93833f28e63960576202e;
        tau[5] = 0x362681bac77a734c4b893a2a2ff2f3cfbff469319b1a1e851c139349f1f62232;
        tau[6] = 0x3036e71d56b2ed7027b5e305dddbc94d3bae6c6afdfaec8bdcd7d05cd89fc4ef;
        tau[7] = 0x33ebf2408bbe683a2516b6e3904d95f6a99da08c27843d425bb3e781b407f812;
        tau[8] = 0x03b2369449d816527fe9f0ec97e4971a65a35f89762ae71610f06096337ea9f2;
        tau[9] = 0x38ca25021f2193df59c755dcebe90a5efb52e97c0440597915d022e9a59357bd;
        tau[10] = 0x240032a20ecb27257f7334b3f538d836f40783e9709b879bd5523f789aad0a63;
        tau[11] = 0x364f7a4b101385305529e5d5237cb71e69950f2b4ed7b4f0b160b1aa3ac71c9a;
        tau[12] = 0x3ffacadcc0e723b1fa45c1ad1b30612dc31924e6027171f0a5da6d8963671c5a;
        tau[13] = 0x25ad865935043775d676da736cc400404b1060585df1386dd4f560de4c4680bc;

        uint256[] memory r_x = new uint256[](14);
        r_x[0] = 0x265e1d73ee4ce9a23d98bf74a9807abd1c0bedf6368e8db884c05bd9336549bd;
        r_x[1] = 0x3a009bec1c4dc776ba75c643de9e61b3070a4a6b3865b5751a3d6f517e483a4a;
        r_x[2] = 0x3932891c1f17ba15d07baba47d6599058812a73225d11a554ced25ad00fd78dd;
        r_x[3] = 0x140622b73b006b8470ed724172721f7d25f3efb2208f42c73e0658fbc493579b;
        r_x[4] = 0x2516f6f6ccf854843d9319fad46a0dff2729c608af31c143590c347d0f0805c6;
        r_x[5] = 0x28942f6ecc7b89c49bfaa569687a9b6902ace63343300e808e86d608eca3f9dc;
        r_x[6] = 0x1ae6542e6085a0c42ae6e947813a6f701329263a1a59f823cb544e83dce0b9cf;
        r_x[7] = 0x39979cf05d7d96da05aba4dd24e9f072d52e8efbf4740f1a857680a096193f8b;
        r_x[8] = 0x2d887fae3954bcb89f20051c96f6812eb841ccc29c8b56e2879e445f74cb4331;
        r_x[9] = 0x29fb4b14d5d53616b881719c4986e5aad92f7320fc1e6c89f301b8a81ab72896;
        r_x[10] = 0x2d69fc2f360b3328cb723687589b065ff4250c414c817bd4f6b187583e103270;
        r_x[11] = 0x06dc812740949078bc2487f020274042e7400e44f7a95d26c2cf6de8b7ba5099;
        r_x[12] = 0x39ade5abede093bbb12d81f27c28cbc7149d1b1ad6e43c49424687fb4c29ae31;
        r_x[13] = 0x3d764ae71118a8a3c653b58c534db9fae607dd9c316cdd3675de0d62e0882bf1;

        uint256 claim_Az = 0x27b19050bb63eec9d7954d32b06139e5a2c3fc22479fd40579a0205fc2f256cf;
        uint256 claim_Bz = 0x0d1d226352e34fae269e9f8e2fc5d745db9270adc02225a1172bbcbff6334594;
        uint256 claim_Cz = 0x3c6c77a78e0e83779eb8a3dc58145e9d60153e2b72a272e1b5a2f962570fd3ac;
        uint256 U_u = 0x00000000000000000000000000000001a389d9eab44c587699bb449d20fe6530;
        uint256 eval_E = 0x1a081bf51d978d12ec79337fa96b1478a40c3dd3ec8005355a8e3fb8ef01b60e;
        uint256 claim_outer_final = 0x346b738474d5b2cda8c002566f1a7004d06cab6b467303a2b7c4b04eaa6df733;

        SpartanVerificationSubStep2Lib.verifyPrimary(
            tau, r_x, claim_Az, claim_Bz, claim_Cz, eval_E, U_u, claim_outer_final
        );
    }

    function testSecondaryVerificationStep4SubStep2() public pure {
        uint256[] memory tau = new uint256[](14);
        tau[0] = 0x009c590b21fa438a0f41c61f879bde904d64caa038b18e804a5b45d294334b1e;
        tau[1] = 0x3d751f5428fbcf26b2ae69067c7fd14af5c1565070f12c8444ec6682ada61091;
        tau[2] = 0x3800b5d1d3dfba0d2299f91c1913e08322441751e5a16fac0221e9f272abc0e0;
        tau[3] = 0x2b1fbf9f6d235d75e616c78a1fe7896bb7617c549d48e89bca5d543a861a086b;
        tau[4] = 0x097721fcef4ac39120d7370ac44f7aa376fd57491abff8b27721f38213c6c8ca;
        tau[5] = 0x02b260afeb7e57bd25dee31120f7d0255e38cebe651348834ec9caab97dd2626;
        tau[6] = 0x28c59e7e0901255f1c24bf1e3c956b5912d9c175adbaa4c24f17d9e4264ddd1a;
        tau[7] = 0x2d22f3f087ed7343f0311a2b4619381d4528d3f3854a592aa976947ed4d21b43;
        tau[8] = 0x0f527dd8578b1c985a782c72705080e78e343d4a51ca822f6d6f9bae4b9f3a34;
        tau[9] = 0x0a5a266eeb0f6f4beb2d7909275088b64d909546e10d6fd110156b3bcaac4200;
        tau[10] = 0x06b0a4c1b0c64419bbd52d64c97eba76fcda7a5d908cd0f09fe64df7e093731d;
        tau[11] = 0x38ec3c68941ff11895c19b3fb11fdacca1bf720c182f01143022ef33065c19e3;
        tau[12] = 0x081053b801dc7593cc709d028fa2171fd1b1fb7edc1a5f69acde08b43e89aeb6;
        tau[13] = 0x0f33d679b3f3c36b6c01e821c23a71c1ff6f68cdc9b54d2bca469a60279bd3b0;

        uint256[] memory r_x = new uint256[](14);
        r_x[0] = 0x0f165407419e8c2e7685d7d70bf99a758d8d7fbea89da907b3aeaa7bee833a56;
        r_x[1] = 0x29560c2a6cfae551d9c4dca9c51099996b3d3c2bdd2498e787f046506ba52814;
        r_x[2] = 0x362da2eabc9f9e7d98621f197a1302f443ce859376ef1855b994adeed58fe545;
        r_x[3] = 0x3cca5c7ea86a6a28fe166886c9170d6c5c11c0c3a62ec3542461ab9d4570db8e;
        r_x[4] = 0x011032bc2a262b1177be0d1a0819af301f07b2526b482a642c044e9f1fb235e0;
        r_x[5] = 0x2457b45828d84cbec89fe251bf00eef3eef83c892343349798c252ddfa6ed892;
        r_x[6] = 0x1e75806536a945babea5f7c8f9919c044ecac67b97598cb833253aebea65f43a;
        r_x[7] = 0x26ffb40cd04ebeee0ef0534d2e0ab8f3bab0b7965896acc89e8ca6d73fb7998f;
        r_x[8] = 0x0204eda144c122b0dd23f2730444b643873d2dfd24b3d9f6e4120699f8d67f17;
        r_x[9] = 0x2a5748db09c9d1253f8accba25f25e6cf536baadf655939b25f762251b238433;
        r_x[10] = 0x006775e2804bb5851a122fb8d1023ff427e3614f93b9dc201811638c88ce449b;
        r_x[11] = 0x1ff82c34a25a9521840fe3fce05a08766cf8236f214871de953ffed41f5312ba;
        r_x[12] = 0x070bb7c8b02abf2d75ef8b6b8fb3997745d1c041991e0d3af11d78b11f879920;
        r_x[13] = 0x0218ba00634e903a39bd7ed1388141981ac7aaa0572ba61802aaf2b580667bf1;

        uint256 claim_Az = 0x068a69fb72f79f02c92459e061e9acf60949ff81f88a78fb7fa772c968d1e369;
        uint256 claim_Bz = 0x3b02830fb14aaf203a53f3269b6029bb0c99dd4224bef315f2871debf79a403e;
        uint256 claim_Cz = 0x22c6447d74583c311ff04818fd2360591db020cd6bf9b809051d35c3fc6771c2;
        uint256 U_u = 0x00000000000000000000000000000001e4444ecefc90a788e6a520cdef7c6e46;
        uint256 eval_E = 0x146438b19e9b9c5483f5301af079f68e3562d46419401ac68c94aab3372c0cac;
        uint256 claim_outer_final = 0x157e00e739ad0d53d95e24c8ec0e97081a1f94bb9a4e94a4d198c5533aebc28b;

        SpartanVerificationSubStep2Lib.verifySecondary(
            tau, r_x, claim_Az, claim_Bz, claim_Cz, eval_E, U_u, claim_outer_final
        );
    }
}
