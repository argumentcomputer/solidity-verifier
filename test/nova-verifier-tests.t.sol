// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.0;

import "@std/Test.sol";
import "src/verifier/step1/Step1Logic.sol";
import "src/verifier/step1/Step1Data.sol";
import "src/verifier/step2/Step2Logic.sol";
import "src/verifier/step2/Step2Data.sol";
import "src/verifier/step3/Step3Logic.sol";
import "src/verifier/step3/Step3Data.sol";
import "src/poseidon/Sponge.sol";
import "src/verifier/step4/SubStep2.sol";
import "src/verifier/step4/SumcheckLogic.sol";
import "src/verifier/step4/SumcheckData.sol";
import "src/blocks/pasta/Pallas.sol";
import "src/blocks/pasta/Vesta.sol";

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

    function testNontrivialPrimaryFolding() public {
        (
            uint256 S_digest,
            bytes32 nifs,
            uint256 r_W,
            uint256 r_E,
            uint256[] memory r_X,
            uint256 r_u,
            uint256 l_W,
            uint256[] memory l_X
        ) = Step3Data.returnPrimaryData();

        NIFSPallas.RelaxedR1CSInstance memory result = NIFSPallas.verify(
            NIFSPallas.NIFS(nifs),
            S_digest,
            NIFSPallas.RelaxedR1CSInstance(Pallas.decompress(r_W), Pallas.decompress(r_E), r_X, r_u),
            NIFSPallas.R1CSInstance(Pallas.decompress(l_W), l_X)
        );

        uint256 expected_comm_W_x = 0x377d16c3de44e589fb6f0371093d648d2f3933db1c52aab0f28e76834ea98e8c;
        uint256 expected_comm_W_y = 0x0985c3acbcdcfe95fd6531f819e82b17e5afdf8cc82187a4367c658bb9fb0a55;
        uint256 expected_comm_W_z = 0x0406f654f562ba978cb48c15983ec87135382aef386bbe5d984980c6ef462323;

        Pallas.PallasAffinePoint memory expected_comm_W =
            Pallas.IntoAffine(Pallas.PallasProjectivePoint(expected_comm_W_x, expected_comm_W_y, expected_comm_W_z));

        uint256 expected_comm_E_x = 0x3fc650f5b92937a4a00c54c14da562de8dfca830c4bb82dd34debbaa5f847b19;
        uint256 expected_comm_E_y = 0x12059c8862f4766782e3add45baad4e0dd5bc5e133baa9cc8fbd4f53ea857597;
        uint256 expected_comm_E_z = 0x0741cc9fdbf8d776f052b3350776a93e038328478aa2926b319c62e9a46f1ab1;

        Pallas.PallasAffinePoint memory expected_comm_E =
            Pallas.IntoAffine(Pallas.PallasProjectivePoint(expected_comm_E_x, expected_comm_E_y, expected_comm_E_z));

        uint256[] memory expected_X = new uint256[](2);
        expected_X[0] = 0x2e56d20a56a66f2ba12798f718d7d3071f18e03da5d4cac52190ba09ae72f46a;
        expected_X[1] = 0x2875f52ba1a60c5b478f684b058d0e2bf2ce904bd0a377ce38699d1a2aa69fad;

        uint256 expected_u = 0x00000000000000000000000000000001a389d9eab44c587699bb449d20fe6530;

        assertEq(result.comm_W.x, expected_comm_W.x);
        assertEq(result.comm_W.y, expected_comm_W.y);
        assertEq(result.comm_E.x, expected_comm_E.x);
        assertEq(result.comm_E.y, expected_comm_E.y);
        assertEq(result.X, expected_X);
        assertEq(result.u, expected_u);
    }

    function testNontrivialSecondaryFolding() public {
        (
            uint256 S_digest,
            bytes32 nifs,
            uint256 r_W,
            uint256 r_E,
            uint256[] memory r_X,
            uint256 r_u,
            uint256 l_W,
            uint256[] memory l_X
        ) = Step3Data.returnSecondaryData();

        NIFSVesta.RelaxedR1CSInstance memory result = NIFSVesta.verify(
            NIFSVesta.NIFS(nifs),
            S_digest,
            NIFSVesta.RelaxedR1CSInstance(Vesta.decompress(r_W), Vesta.decompress(r_E), r_X, r_u),
            NIFSVesta.R1CSInstance(Vesta.decompress(l_W), l_X)
        );

        uint256 expected_comm_W_x = 0x16b45f4410b378a414b2303772e97ca21f97cedca866dc446a0c03701db8607f;
        uint256 expected_comm_W_y = 0x08dd11b5cc6a77afcb553cb341b4c4e89b64593c4a4c79af5f8027ebfa5ba143;
        uint256 expected_comm_W_z = 0x0193373d89342b5a3c0ade3a0d2f6d6f5c6f919265e2429bc019d1cf329d5c7e;

        Vesta.VestaAffinePoint memory expected_comm_W =
            Vesta.IntoAffine(Vesta.VestaProjectivePoint(expected_comm_W_x, expected_comm_W_y, expected_comm_W_z));

        uint256 expected_comm_E_x = 0x35cd0c83e99ab8826aeabdb360449a8138ac8efde6e791801fc4ba6024c5a9c1;
        uint256 expected_comm_E_y = 0x3b8b16f35f6bc8cc10fb1988d19b7ca069b71c4378a9fab07b053eb71a394df7;
        uint256 expected_comm_E_z = 0x38e70020eab8f6d0210659e5f28712a8031d29d382644c924d75c386d92461c6;

        Vesta.VestaAffinePoint memory expected_comm_E =
            Vesta.IntoAffine(Vesta.VestaProjectivePoint(expected_comm_E_x, expected_comm_E_y, expected_comm_E_z));

        uint256[] memory expected_X = new uint256[](2);
        expected_X[0] = 0x32d8d912584abe410b9c9c56cc9efdb0261ed5a636e0fc823bd5b427cf9fcbee;
        expected_X[1] = 0x25b86df67043654b4f2becbaf1ea152688dfeffdb1de89cdf0164c59b0330198;

        uint256 expected_u = 0x00000000000000000000000000000001e4444ecefc90a788e6a520cdef7c6e46;

        assertEq(result.comm_W.x, expected_comm_W.x);
        assertEq(result.comm_W.y, expected_comm_W.y);
        assertEq(result.comm_E.x, expected_comm_E.x);
        assertEq(result.comm_E.y, expected_comm_E.y);
        assertEq(result.X, expected_X);
        assertEq(result.u, expected_u);
    }

    function testSumcheckPrimary() public {
        uint8[] memory input = new uint8[](16); // b"RelaxedR1CSSNARK" in Rust
        input[0] = 0x52;
        input[1] = 0x65;
        input[2] = 0x6c;
        input[3] = 0x61;
        input[4] = 0x78;
        input[5] = 0x65;
        input[6] = 0x64;
        input[7] = 0x52;
        input[8] = 0x31;
        input[9] = 0x43;
        input[10] = 0x53;
        input[11] = 0x53;
        input[12] = 0x4e;
        input[13] = 0x41;
        input[14] = 0x52;
        input[15] = 0x4b;

        KeccakTranscriptLib.KeccakTranscript memory transcript = KeccakTranscriptLib.instantiate(input);

        uint8[] memory vk_comm = SumcheckData.returnPrimaryTranscriptData();
        uint8[] memory vk_comm_label = new uint8[](1);
        vk_comm_label[0] = 0x43; // b"C"

        uint8[] memory U = new uint8[](226);
        U[0] = 0xab;
        U[1] = 0xf4;
        U[2] = 0xc0;
        U[3] = 0x93;
        U[4] = 0xd7;
        U[5] = 0x1b;
        U[6] = 0xd2;
        U[7] = 0xab;
        U[8] = 0x61;
        U[9] = 0xa2;
        U[10] = 0x84;
        U[11] = 0x16;
        U[12] = 0x3a;
        U[13] = 0x36;
        U[14] = 0xb2;
        U[15] = 0x6c;
        U[16] = 0x75;
        U[17] = 0x42;
        U[18] = 0x9c;
        U[19] = 0x4e;
        U[20] = 0x0a;
        U[21] = 0xbe;
        U[22] = 0x30;
        U[23] = 0x25;
        U[24] = 0x86;
        U[25] = 0xb8;
        U[26] = 0x75;
        U[27] = 0x6f;
        U[28] = 0x56;
        U[29] = 0x1c;
        U[30] = 0x3b;
        U[31] = 0x22;
        U[32] = 0x08;
        U[33] = 0x4e;
        U[34] = 0xc4;
        U[35] = 0x00;
        U[36] = 0xc1;
        U[37] = 0xbc;
        U[38] = 0x28;
        U[39] = 0x22;
        U[40] = 0x6d;
        U[41] = 0xc7;
        U[42] = 0x98;
        U[43] = 0x66;
        U[44] = 0x2a;
        U[45] = 0x67;
        U[46] = 0x8d;
        U[47] = 0x47;
        U[48] = 0xf0;
        U[49] = 0x1e;
        U[50] = 0x0c;
        U[51] = 0x24;
        U[52] = 0xee;
        U[53] = 0xaa;
        U[54] = 0x59;
        U[55] = 0x69;
        U[56] = 0xf7;
        U[57] = 0xaa;
        U[58] = 0xcf;
        U[59] = 0x24;
        U[60] = 0x19;
        U[61] = 0x8c;
        U[62] = 0x21;
        U[63] = 0x05;
        U[64] = 0x01;
        U[65] = 0x94;
        U[66] = 0x18;
        U[67] = 0x0d;
        U[68] = 0x05;
        U[69] = 0x6f;
        U[70] = 0xf8;
        U[71] = 0x6d;
        U[72] = 0xd8;
        U[73] = 0xb2;
        U[74] = 0x99;
        U[75] = 0x7f;
        U[76] = 0x5f;
        U[77] = 0xd7;
        U[78] = 0xe2;
        U[79] = 0x53;
        U[80] = 0xd4;
        U[81] = 0x0d;
        U[82] = 0xfb;
        U[83] = 0xa2;
        U[84] = 0x7a;
        U[85] = 0x8b;
        U[86] = 0x4c;
        U[87] = 0xb9;
        U[88] = 0x74;
        U[89] = 0x62;
        U[90] = 0xe6;
        U[91] = 0xef;
        U[92] = 0x3a;
        U[93] = 0x52;
        U[94] = 0x2b;
        U[95] = 0xf0;
        U[96] = 0x15;
        U[97] = 0x78;
        U[98] = 0x01;
        U[99] = 0x35;
        U[100] = 0x68;
        U[101] = 0xf3;
        U[102] = 0x63;
        U[103] = 0x2c;
        U[104] = 0x36;
        U[105] = 0x67;
        U[106] = 0x02;
        U[107] = 0x01;
        U[108] = 0xea;
        U[109] = 0x3a;
        U[110] = 0x89;
        U[111] = 0x9f;
        U[112] = 0x60;
        U[113] = 0x25;
        U[114] = 0x05;
        U[115] = 0x1e;
        U[116] = 0x74;
        U[117] = 0xd3;
        U[118] = 0x9a;
        U[119] = 0x85;
        U[120] = 0x6c;
        U[121] = 0xf0;
        U[122] = 0x96;
        U[123] = 0x77;
        U[124] = 0xff;
        U[125] = 0xda;
        U[126] = 0xea;
        U[127] = 0x48;
        U[128] = 0x34;
        U[129] = 0x01;
        U[130] = 0x30;
        U[131] = 0x65;
        U[132] = 0xfe;
        U[133] = 0x20;
        U[134] = 0x9d;
        U[135] = 0x44;
        U[136] = 0xbb;
        U[137] = 0x99;
        U[138] = 0x76;
        U[139] = 0x58;
        U[140] = 0x4c;
        U[141] = 0xb4;
        U[142] = 0xea;
        U[143] = 0xd9;
        U[144] = 0x89;
        U[145] = 0xa3;
        U[146] = 0x01;
        U[147] = 0x00;
        U[148] = 0x00;
        U[149] = 0x00;
        U[150] = 0x00;
        U[151] = 0x00;
        U[152] = 0x00;
        U[153] = 0x00;
        U[154] = 0x00;
        U[155] = 0x00;
        U[156] = 0x00;
        U[157] = 0x00;
        U[158] = 0x00;
        U[159] = 0x00;
        U[160] = 0x00;
        U[161] = 0x00;
        U[162] = 0x6a;
        U[163] = 0xf4;
        U[164] = 0x72;
        U[165] = 0xae;
        U[166] = 0x09;
        U[167] = 0xba;
        U[168] = 0x90;
        U[169] = 0x21;
        U[170] = 0xc5;
        U[171] = 0xca;
        U[172] = 0xd4;
        U[173] = 0xa5;
        U[174] = 0x3d;
        U[175] = 0xe0;
        U[176] = 0x18;
        U[177] = 0x1f;
        U[178] = 0x07;
        U[179] = 0xd3;
        U[180] = 0xd7;
        U[181] = 0x18;
        U[182] = 0xf7;
        U[183] = 0x98;
        U[184] = 0x27;
        U[185] = 0xa1;
        U[186] = 0x2b;
        U[187] = 0x6f;
        U[188] = 0xa6;
        U[189] = 0x56;
        U[190] = 0x0a;
        U[191] = 0xd2;
        U[192] = 0x56;
        U[193] = 0x2e;
        U[194] = 0xad;
        U[195] = 0x9f;
        U[196] = 0xa6;
        U[197] = 0x2a;
        U[198] = 0x1a;
        U[199] = 0x9d;
        U[200] = 0x69;
        U[201] = 0x38;
        U[202] = 0xce;
        U[203] = 0x77;
        U[204] = 0xa3;
        U[205] = 0xd0;
        U[206] = 0x4b;
        U[207] = 0x90;
        U[208] = 0xce;
        U[209] = 0xf2;
        U[210] = 0x2b;
        U[211] = 0x0e;
        U[212] = 0x8d;
        U[213] = 0x05;
        U[214] = 0x4b;
        U[215] = 0x68;
        U[216] = 0x8f;
        U[217] = 0x47;
        U[218] = 0x5b;
        U[219] = 0x0c;
        U[220] = 0xa6;
        U[221] = 0xa1;
        U[222] = 0x2b;
        U[223] = 0xf5;
        U[224] = 0x75;
        U[225] = 0x28;

        uint8[] memory U_label = new uint8[](1);
        U_label[0] = 0x55; // b"U"

        transcript = KeccakTranscriptLib.absorb(transcript, vk_comm_label, vk_comm);
        transcript = KeccakTranscriptLib.absorb(transcript, U_label, U);

        ScalarFromUniformLib.Curve curve = ScalarFromUniformLib.curveVesta();

        uint8[] memory t_label = new uint8[](1);
        t_label[0] = 0x74; // b"t"

        for (uint256 idx = 0; idx < 14; idx++) {
            (transcript,) = KeccakTranscriptLib.squeeze(transcript, curve, t_label);
        }

        PolyLib.SumcheckProof memory outer_proof = SumcheckData.returnPrimaryOuterData();

        uint256 claim_final;
        uint256[] memory r_x = new uint256[](14);

        (claim_final, r_x, transcript) = PrimarySumcheck.verify(outer_proof, 0, 14, 3, transcript);

        uint256[] memory r_x_result = new uint256[](14);
        r_x_result[0] = 0x265e1d73ee4ce9a23d98bf74a9807abd1c0bedf6368e8db884c05bd9336549bd;
        r_x_result[1] = 0x3a009bec1c4dc776ba75c643de9e61b3070a4a6b3865b5751a3d6f517e483a4a;
        r_x_result[2] = 0x3932891c1f17ba15d07baba47d6599058812a73225d11a554ced25ad00fd78dd;
        r_x_result[3] = 0x140622b73b006b8470ed724172721f7d25f3efb2208f42c73e0658fbc493579b;
        r_x_result[4] = 0x2516f6f6ccf854843d9319fad46a0dff2729c608af31c143590c347d0f0805c6;
        r_x_result[5] = 0x28942f6ecc7b89c49bfaa569687a9b6902ace63343300e808e86d608eca3f9dc;
        r_x_result[6] = 0x1ae6542e6085a0c42ae6e947813a6f701329263a1a59f823cb544e83dce0b9cf;
        r_x_result[7] = 0x39979cf05d7d96da05aba4dd24e9f072d52e8efbf4740f1a857680a096193f8b;
        r_x_result[8] = 0x2d887fae3954bcb89f20051c96f6812eb841ccc29c8b56e2879e445f74cb4331;
        r_x_result[9] = 0x29fb4b14d5d53616b881719c4986e5aad92f7320fc1e6c89f301b8a81ab72896;
        r_x_result[10] = 0x2d69fc2f360b3328cb723687589b065ff4250c414c817bd4f6b187583e103270;
        r_x_result[11] = 0x06dc812740949078bc2487f020274042e7400e44f7a95d26c2cf6de8b7ba5099;
        r_x_result[12] = 0x39ade5abede093bbb12d81f27c28cbc7149d1b1ad6e43c49424687fb4c29ae31;
        r_x_result[13] = 0x3d764ae71118a8a3c653b58c534db9fae607dd9c316cdd3675de0d62e0882bf1;

        assertEq(claim_final, 0x346b738474d5b2cda8c002566f1a7004d06cab6b467303a2b7c4b04eaa6df733);
        assertEq(r_x, r_x_result);
    }

    function testSumcheckSecondary() public {
        uint8[] memory input = new uint8[](16); // b"RelaxedR1CSSNARK" in Rust
        input[0] = 0x52;
        input[1] = 0x65;
        input[2] = 0x6c;
        input[3] = 0x61;
        input[4] = 0x78;
        input[5] = 0x65;
        input[6] = 0x64;
        input[7] = 0x52;
        input[8] = 0x31;
        input[9] = 0x43;
        input[10] = 0x53;
        input[11] = 0x53;
        input[12] = 0x4e;
        input[13] = 0x41;
        input[14] = 0x52;
        input[15] = 0x4b;

        KeccakTranscriptLib.KeccakTranscript memory transcript = KeccakTranscriptLib.instantiate(input);

        uint8[] memory vk_comm = SumcheckData.returnSecondaryTranscriptData();
        uint8[] memory vk_comm_label = new uint8[](1);
        vk_comm_label[0] = 0x43; // b"C"

        uint8[] memory U = new uint8[](226);
        U[0] = 0x58;
        U[1] = 0x72;
        U[2] = 0xeb;
        U[3] = 0x4;
        U[4] = 0x7;
        U[5] = 0xd2;
        U[6] = 0xe2;
        U[7] = 0xeb;
        U[8] = 0x41;
        U[9] = 0x55;
        U[10] = 0x85;
        U[11] = 0xab;
        U[12] = 0x31;
        U[13] = 0xb1;
        U[14] = 0x6a;
        U[15] = 0xf7;
        U[16] = 0xa7;
        U[17] = 0xb0;
        U[18] = 0xaa;
        U[19] = 0x2a;
        U[20] = 0x7e;
        U[21] = 0xa9;
        U[22] = 0x1f;
        U[23] = 0x4d;
        U[24] = 0x60;
        U[25] = 0x85;
        U[26] = 0x3;
        U[27] = 0x58;
        U[28] = 0xf3;
        U[29] = 0xe9;
        U[30] = 0xa4;
        U[31] = 0x33;
        U[32] = 0x23;
        U[33] = 0x65;
        U[34] = 0x80;
        U[35] = 0xd;
        U[36] = 0xf2;
        U[37] = 0x4f;
        U[38] = 0x9f;
        U[39] = 0xc7;
        U[40] = 0xb5;
        U[41] = 0xa7;
        U[42] = 0xc3;
        U[43] = 0xa3;
        U[44] = 0xb6;
        U[45] = 0x2;
        U[46] = 0x23;
        U[47] = 0xc0;
        U[48] = 0xe9;
        U[49] = 0x95;
        U[50] = 0x7c;
        U[51] = 0x84;
        U[52] = 0xd3;
        U[53] = 0x1;
        U[54] = 0xb5;
        U[55] = 0xa0;
        U[56] = 0x4c;
        U[57] = 0x79;
        U[58] = 0xd2;
        U[59] = 0x65;
        U[60] = 0x1;
        U[61] = 0x3a;
        U[62] = 0x84;
        U[63] = 0x31;
        U[64] = 0x1;
        U[65] = 0xc;
        U[66] = 0x74;
        U[67] = 0x22;
        U[68] = 0xf7;
        U[69] = 0xea;
        U[70] = 0xbb;
        U[71] = 0x81;
        U[72] = 0xb1;
        U[73] = 0x86;
        U[74] = 0x6c;
        U[75] = 0xc;
        U[76] = 0x6c;
        U[77] = 0x7e;
        U[78] = 0x9e;
        U[79] = 0x6c;
        U[80] = 0x43;
        U[81] = 0x42;
        U[82] = 0x5a;
        U[83] = 0xa8;
        U[84] = 0x84;
        U[85] = 0x96;
        U[86] = 0x38;
        U[87] = 0x31;
        U[88] = 0xfa;
        U[89] = 0x89;
        U[90] = 0x9e;
        U[91] = 0x1c;
        U[92] = 0x81;
        U[93] = 0x10;
        U[94] = 0xb3;
        U[95] = 0x98;
        U[96] = 0xf;
        U[97] = 0xbb;
        U[98] = 0x78;
        U[99] = 0x40;
        U[100] = 0x64;
        U[101] = 0x89;
        U[102] = 0x20;
        U[103] = 0x96;
        U[104] = 0xbc;
        U[105] = 0x48;
        U[106] = 0x82;
        U[107] = 0x40;
        U[108] = 0x7d;
        U[109] = 0xef;
        U[110] = 0xfb;
        U[111] = 0x4b;
        U[112] = 0x8c;
        U[113] = 0xa4;
        U[114] = 0xd9;
        U[115] = 0x5e;
        U[116] = 0xc6;
        U[117] = 0xb4;
        U[118] = 0x36;
        U[119] = 0xbf;
        U[120] = 0x55;
        U[121] = 0xac;
        U[122] = 0xa6;
        U[123] = 0xc5;
        U[124] = 0x10;
        U[125] = 0xee;
        U[126] = 0x7b;
        U[127] = 0x54;
        U[128] = 0x12;
        U[129] = 0x1;
        U[130] = 0x46;
        U[131] = 0x6e;
        U[132] = 0x7c;
        U[133] = 0xef;
        U[134] = 0xcd;
        U[135] = 0x20;
        U[136] = 0xa5;
        U[137] = 0xe6;
        U[138] = 0x88;
        U[139] = 0xa7;
        U[140] = 0x90;
        U[141] = 0xfc;
        U[142] = 0xce;
        U[143] = 0x4e;
        U[144] = 0x44;
        U[145] = 0xe4;
        U[146] = 0x1;
        U[147] = 0x0;
        U[148] = 0x0;
        U[149] = 0x0;
        U[150] = 0x0;
        U[151] = 0x0;
        U[152] = 0x0;
        U[153] = 0x0;
        U[154] = 0x0;
        U[155] = 0x0;
        U[156] = 0x0;
        U[157] = 0x0;
        U[158] = 0x0;
        U[159] = 0x0;
        U[160] = 0x0;
        U[161] = 0x0;
        U[162] = 0xee;
        U[163] = 0xcb;
        U[164] = 0x9f;
        U[165] = 0xcf;
        U[166] = 0x27;
        U[167] = 0xb4;
        U[168] = 0xd5;
        U[169] = 0x3b;
        U[170] = 0x82;
        U[171] = 0xfc;
        U[172] = 0xe0;
        U[173] = 0x36;
        U[174] = 0xa6;
        U[175] = 0xd5;
        U[176] = 0x1e;
        U[177] = 0x26;
        U[178] = 0xb0;
        U[179] = 0xfd;
        U[180] = 0x9e;
        U[181] = 0xcc;
        U[182] = 0x56;
        U[183] = 0x9c;
        U[184] = 0x9c;
        U[185] = 0xb;
        U[186] = 0x41;
        U[187] = 0xbe;
        U[188] = 0x4a;
        U[189] = 0x58;
        U[190] = 0x12;
        U[191] = 0xd9;
        U[192] = 0xd8;
        U[193] = 0x32;
        U[194] = 0x98;
        U[195] = 0x1;
        U[196] = 0x33;
        U[197] = 0xb0;
        U[198] = 0x59;
        U[199] = 0x4c;
        U[200] = 0x16;
        U[201] = 0xf0;
        U[202] = 0xcd;
        U[203] = 0x89;
        U[204] = 0xde;
        U[205] = 0xb1;
        U[206] = 0xfd;
        U[207] = 0xef;
        U[208] = 0xdf;
        U[209] = 0x88;
        U[210] = 0x26;
        U[211] = 0x15;
        U[212] = 0xea;
        U[213] = 0xf1;
        U[214] = 0xba;
        U[215] = 0xec;
        U[216] = 0x2b;
        U[217] = 0x4f;
        U[218] = 0x4b;
        U[219] = 0x65;
        U[220] = 0x43;
        U[221] = 0x70;
        U[222] = 0xf6;
        U[223] = 0x6d;
        U[224] = 0xb8;
        U[225] = 0x25;

        uint8[] memory U_label = new uint8[](1);
        U_label[0] = 0x55; // b"U"

        transcript = KeccakTranscriptLib.absorb(transcript, vk_comm_label, vk_comm);
        transcript = KeccakTranscriptLib.absorb(transcript, U_label, U);

        ScalarFromUniformLib.Curve curve = ScalarFromUniformLib.curveVesta();

        uint8[] memory t_label = new uint8[](1);
        t_label[0] = 0x74; // b"t"

        for (uint256 idx = 0; idx < 14; idx++) {
            (transcript,) = KeccakTranscriptLib.squeeze(transcript, curve, t_label);
        }

        PolyLib.SumcheckProof memory outer_proof = SumcheckData.returnSecondaryOuterData();

        uint256 claim_final;
        uint256[] memory r_x = new uint256[](14);

        (claim_final, r_x, transcript) = SecondarySumcheck.verify(outer_proof, 0, 14, 3, transcript);

        uint256[] memory r_x_result = new uint256[](14);
        r_x_result[0] = 0x0f165407419e8c2e7685d7d70bf99a758d8d7fbea89da907b3aeaa7bee833a56;
        r_x_result[1] = 0x29560c2a6cfae551d9c4dca9c51099996b3d3c2bdd2498e787f046506ba52814;
        r_x_result[2] = 0x362da2eabc9f9e7d98621f197a1302f443ce859376ef1855b994adeed58fe545;
        r_x_result[3] = 0x3cca5c7ea86a6a28fe166886c9170d6c5c11c0c3a62ec3542461ab9d4570db8e;
        r_x_result[4] = 0x011032bc2a262b1177be0d1a0819af301f07b2526b482a642c044e9f1fb235e0;
        r_x_result[5] = 0x2457b45828d84cbec89fe251bf00eef3eef83c892343349798c252ddfa6ed892;
        r_x_result[6] = 0x1e75806536a945babea5f7c8f9919c044ecac67b97598cb833253aebea65f43a;
        r_x_result[7] = 0x26ffb40cd04ebeee0ef0534d2e0ab8f3bab0b7965896acc89e8ca6d73fb7998f;
        r_x_result[8] = 0x0204eda144c122b0dd23f2730444b643873d2dfd24b3d9f6e4120699f8d67f17;
        r_x_result[9] = 0x2a5748db09c9d1253f8accba25f25e6cf536baadf655939b25f762251b238433;
        r_x_result[10] = 0x006775e2804bb5851a122fb8d1023ff427e3614f93b9dc201811638c88ce449b;
        r_x_result[11] = 0x1ff82c34a25a9521840fe3fce05a08766cf8236f214871de953ffed41f5312ba;
        r_x_result[12] = 0x070bb7c8b02abf2d75ef8b6b8fb3997745d1c041991e0d3af11d78b11f879920;
        r_x_result[13] = 0x0218ba00634e903a39bd7ed1388141981ac7aaa0572ba61802aaf2b580667bf1;

        assertEq(claim_final, 0x157e00e739ad0d53d95e24c8ec0e97081a1f94bb9a4e94a4d198c5533aebc28b);
        assertEq(r_x, r_x_result);
    }
}
