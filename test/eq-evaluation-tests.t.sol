// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.0;

import "@std/Test.sol";
import "src/blocks/EqPolynomial.sol";
import "src/pasta/Vesta.sol";
import "src/pasta/Pallas.sol";

contract EqEvaluationTest is Test {
    function testEqEvaluationPrimary1() public {
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

        uint256 expected = 0x1ecc7a4636c12e49b10abfeee2365a0c8d33720ef207c874decf5b635e5a0f5c;
        uint256 tauBoundRx = EqPolinomialLib.evaluate(tau, r_x, Vesta.P_MOD, Vesta.negateBase);

        assertEq(expected, tauBoundRx);
    }

    function testEqEvaluationPrimary2() public {
        uint256[] memory r_z = new uint256[](14);
        r_z[0] = 0x3900c2e0deca23f4261cf2b1fe25f55af15923fef096beb075597dc4484bdab4;
        r_z[1] = 0x19e64de64844ab77589ff14fe0d6aca79619e6ac8bb5e023355bdfbec1314299;
        r_z[2] = 0x023fc05d9c0afe68dee83dd08e45a162b2f9ec0008919c9bb6b74fd973c51e6e;
        r_z[3] = 0x15ba95ba2f4526812a66b6e929046889148f89ba98ed0955b5e1ef591196b617;
        r_z[4] = 0x2066410ddf6e0e8ee798b299ce080d37def2d64c7be907169deb62a939761ed2;
        r_z[5] = 0x001b94cfc1f4b004e1e50c1aff284d0f679402e4e8c741e6e63f6c159b53eb85;
        r_z[6] = 0x0b95f517c6afa96f9f7a6f38c881586cd55fffd7c8ccf5242bddb08f1ddf6224;
        r_z[7] = 0x191b78b4877a497460a9315e98b81468001c2b1efa033998a42bff8aa8522dba;
        r_z[8] = 0x1e672c36421ca2d681987997ffd76f5f2e8fe4793e87c691105160a257dbfac3;
        r_z[9] = 0x2f2f07e78df3c7658f5a66187821f9af743a1925c1a1d83af6b0dd33d1d8f0e8;
        r_z[10] = 0x0044b6fa5582115839d186d62373ccef34252fac77680e4626cc0d02130714a6;
        r_z[11] = 0x0b9b8c6e8dfdee36ee28b4db606180747d182379fcada2bc01047d3a714c6f62;
        r_z[12] = 0x2d38d3d07e03b3c211a22c63ba0c70986775fba207afb1b6c11e1b978ba4af8d;
        r_z[13] = 0x12a8ad443674d792661c7b457eec3d0583b4f493b9218ca57c9231c7d379c5f2;

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

        uint256 expected = 0x3b107e7354c4abec25131c83747810862c123a8f30de4670b369b8660520fb5b;
        uint256 rz_rx = EqPolinomialLib.evaluate(r_z, r_x, Vesta.P_MOD, Vesta.negateBase);

        assertEq(rz_rx, expected);
    }

    function testEqEvaluationPrimary3() public {
        uint256[] memory r_z = new uint256[](14);
        r_z[0] = 0x3900c2e0deca23f4261cf2b1fe25f55af15923fef096beb075597dc4484bdab4;
        r_z[1] = 0x19e64de64844ab77589ff14fe0d6aca79619e6ac8bb5e023355bdfbec1314299;
        r_z[2] = 0x023fc05d9c0afe68dee83dd08e45a162b2f9ec0008919c9bb6b74fd973c51e6e;
        r_z[3] = 0x15ba95ba2f4526812a66b6e929046889148f89ba98ed0955b5e1ef591196b617;
        r_z[4] = 0x2066410ddf6e0e8ee798b299ce080d37def2d64c7be907169deb62a939761ed2;
        r_z[5] = 0x001b94cfc1f4b004e1e50c1aff284d0f679402e4e8c741e6e63f6c159b53eb85;
        r_z[6] = 0x0b95f517c6afa96f9f7a6f38c881586cd55fffd7c8ccf5242bddb08f1ddf6224;
        r_z[7] = 0x191b78b4877a497460a9315e98b81468001c2b1efa033998a42bff8aa8522dba;
        r_z[8] = 0x1e672c36421ca2d681987997ffd76f5f2e8fe4793e87c691105160a257dbfac3;
        r_z[9] = 0x2f2f07e78df3c7658f5a66187821f9af743a1925c1a1d83af6b0dd33d1d8f0e8;
        r_z[10] = 0x0044b6fa5582115839d186d62373ccef34252fac77680e4626cc0d02130714a6;
        r_z[11] = 0x0b9b8c6e8dfdee36ee28b4db606180747d182379fcada2bc01047d3a714c6f62;
        r_z[12] = 0x2d38d3d07e03b3c211a22c63ba0c70986775fba207afb1b6c11e1b978ba4af8d;
        r_z[13] = 0x12a8ad443674d792661c7b457eec3d0583b4f493b9218ca57c9231c7d379c5f2;

        uint256[] memory r_y = new uint256[](14);
        r_y[0] = 0x08c4915bf1a1341472a82d0d29d9ed43f72c93b7812e34466494145af762fc6c;
        r_y[1] = 0x36d00685cf2a969330dbdf6a4533d7cb248def77ec139ad13ccdab2eb281993a;
        r_y[2] = 0x0204fd7c7c131b857af8d9c1fe84a8b35685d45bbae8b51ac47af2c0c080363f;
        r_y[3] = 0x1625b26a45ce9c1b46081ed7f0658e80bebe85a069357b39833b74e9be67113c;
        r_y[4] = 0x138f29758140496f766af34905ccbfff72cde5c6fb88374ebb0d5bd4f7102d82;
        r_y[5] = 0x0cab6796b99d03113e2f263ebb7ac9e49c0eba24c2537e78c4c332c7bedb695c;
        r_y[6] = 0x2c32a9b732efeb9657c4f8d08310b314c5092bc6d246be6a8c0d828f858af4ac;
        r_y[7] = 0x1de39d206f4df4fe1b745fe51c04b7405f6f4c371ceb6fb3817b1e4f3b70095b;
        r_y[8] = 0x330de47a606ded4033291e9c612abdfb0b2a7d3dd830cb7b9713eebf89705cdb;
        r_y[9] = 0x1d88a34c65d9cc8f8e009d7e5bfe03e0f01af93065873d5ac133fb5efa73b8df;
        r_y[10] = 0x2b2163f1db7afd6856c760a247fa961d8d623f331975ddc32d35a90218728434;
        r_y[11] = 0x0c2e1ba6d2908afa207a54f11f351dfee8c6ca8d55c032c248e92aa5f15ccd99;
        r_y[12] = 0x17634a890278ae48651f7fa7cea00884f17ccd04365ada8c6e4405a39478212e;
        r_y[13] = 0x0d2d8f8c26d30b56b526ddf9b803f597db14b25fe78fe4dba4ce487d9fb4fcb4;

        uint256 expected = 0x3c9713a8eb8666e4e2717f2ca5c3bed2e9a4532e3603984212bbbccf5008bf3a;
        uint256 rz_ry = EqPolinomialLib.evaluate(r_z, r_y, Vesta.P_MOD, Vesta.negateBase);

        assertEq(rz_ry, expected);
    }

    function testEqEvaluationSecondary1() public {
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

        uint256 expected = 0x183f09f805c4694f9330edd10a2b68ea8bb8f026cea7e79f2e034b837b2daeb6;
        uint256 tauBoundRx = EqPolinomialLib.evaluate(tau, r_x, Pallas.P_MOD, Pallas.negateBase);

        assertEq(expected, tauBoundRx);
    }

    function testEqEvaluationSecondary2() public {
        uint256[] memory r_z = new uint256[](14);
        r_z[0] = 0x19008fc483011b53299688f361eec08fb680cd864b11c9b0d3dab1c0df579acc;
        r_z[1] = 0x000c01d6cc03cdc597af60c1753ff78d07adfb44ec3183b143b8cca0d03e8bc6;
        r_z[2] = 0x3386993f3d5b7342a0baf3214e2bcf3a3b55134b16d1d45a68b439cfcd3a046c;
        r_z[3] = 0x3c9f9f86b6400fc42e3d94528a56181bbc5d4e985c781d20598f953f198269ff;
        r_z[4] = 0x22bd7eb5fc678b8bf4a60305d9839033b3efdf8f039c8e5722aaf069f412fc33;
        r_z[5] = 0x01e7f2d4b164a34471a7b105566c746454c30b13f7c780f48ae6a79cea1d02d3;
        r_z[6] = 0x0ea5e255156f5b74de3b5374934cde8239bf64442b774a8bac41db2f1d4df5bf;
        r_z[7] = 0x22e858c8956c0d4772329557f1e1801b37a29d9c383fb007fa685e37ab937e3a;
        r_z[8] = 0x2f15535ad333097d6abde17f1fe6e3afafd91644e9bf32f7bf5a7386ed729a5b;
        r_z[9] = 0x03a09951cd1a626b16999f8978105b9e83f102ace3777e3892e1e7ad07c977e3;
        r_z[10] = 0x38702c0cb0c7c4c640904ef3f8f1c4f7e6bcfb6e5626deb1c44c3dc8b8f4bf5f;
        r_z[11] = 0x103db07fadbfc71b43324ed218d3138f7f3701257cf8d741dc1e1b782b8216e8;
        r_z[12] = 0x0483daba04a71f22473533f474da6dba17ec2b6a4ed4087e052178172c2b8965;
        r_z[13] = 0x19468384272c70fe1a2868d2ab202b7c35ff62dea6602d40160897afb3934d88;

        uint256[] memory r_y = new uint256[](14);
        r_y[0] = 0x3916fe320f183c1453d0e9bb3bfa7374793096fdf38379aedea66cc7dcaf7e08;
        r_y[1] = 0x2a0d9fc4ae15bdce6a8e5a5471fb590535e9533508f035d90f9255fb48fc2e76;
        r_y[2] = 0x01b240c33764723dece2cb1b9df078fa37358487b31b02566ff41185864a5e62;
        r_y[3] = 0x17848bd9c88037915d94e8fce040d9ed50cfb2894c2fe9423f6dbe5c34d23cb3;
        r_y[4] = 0x26f476c4734135d0f82908d3e78552efc3d0f283eaa8c09ab62b54ac7d14addc;
        r_y[5] = 0x2a0fafde03242db9d319f8e09fff11a7e2f6124ed17cea107da09f36eb30dbbe;
        r_y[6] = 0x17901b6eba9aa318f4865f1f920197823475f95d8f45869885cd1791dc165716;
        r_y[7] = 0x300f98dcdf44099acb80516ec8ee48316df00cd09ccba21837a0cd906637778e;
        r_y[8] = 0x2a252100fac6781457578c3f24510de75b67164a4c6fd26ea6e8f7b86689dba4;
        r_y[9] = 0x3716a88a6fc03454b3527bb7ca8a0175ec71ec39a40de88f770dfe44ae611b1f;
        r_y[10] = 0x3e464a14ffef67ca9d1bb49e9afa113bcc701884b3aaa68385f4e6f804c07500;
        r_y[11] = 0x34169db7131567c40085024f4177f987cbcbf6168e630db10bd79f8d5775f37b;
        r_y[12] = 0x1ed7da2e753c94332e034b046d37937577582b78c2cffa3ada412ac7d6446745;
        r_y[13] = 0x3e69c1910a9263ddee4a0cec382a858a67e33f74de3d76058fd6248cd8257cc8;

        uint256 expected = 0x38c914520e951ca5d3478b57612d8df23cdeaca6ba8181f3831e4a461bce7389;
        uint256 rz_ry = EqPolinomialLib.evaluate(r_z, r_y, Pallas.P_MOD, Pallas.negateBase);

        assertEq(rz_ry, expected);
    }

    function testEqEvaluationSecondary3() public {
        uint256[] memory r_z = new uint256[](14);
        r_z[0] = 0x19008fc483011b53299688f361eec08fb680cd864b11c9b0d3dab1c0df579acc;
        r_z[1] = 0x000c01d6cc03cdc597af60c1753ff78d07adfb44ec3183b143b8cca0d03e8bc6;
        r_z[2] = 0x3386993f3d5b7342a0baf3214e2bcf3a3b55134b16d1d45a68b439cfcd3a046c;
        r_z[3] = 0x3c9f9f86b6400fc42e3d94528a56181bbc5d4e985c781d20598f953f198269ff;
        r_z[4] = 0x22bd7eb5fc678b8bf4a60305d9839033b3efdf8f039c8e5722aaf069f412fc33;
        r_z[5] = 0x01e7f2d4b164a34471a7b105566c746454c30b13f7c780f48ae6a79cea1d02d3;
        r_z[6] = 0x0ea5e255156f5b74de3b5374934cde8239bf64442b774a8bac41db2f1d4df5bf;
        r_z[7] = 0x22e858c8956c0d4772329557f1e1801b37a29d9c383fb007fa685e37ab937e3a;
        r_z[8] = 0x2f15535ad333097d6abde17f1fe6e3afafd91644e9bf32f7bf5a7386ed729a5b;
        r_z[9] = 0x03a09951cd1a626b16999f8978105b9e83f102ace3777e3892e1e7ad07c977e3;
        r_z[10] = 0x38702c0cb0c7c4c640904ef3f8f1c4f7e6bcfb6e5626deb1c44c3dc8b8f4bf5f;
        r_z[11] = 0x103db07fadbfc71b43324ed218d3138f7f3701257cf8d741dc1e1b782b8216e8;
        r_z[12] = 0x0483daba04a71f22473533f474da6dba17ec2b6a4ed4087e052178172c2b8965;
        r_z[13] = 0x19468384272c70fe1a2868d2ab202b7c35ff62dea6602d40160897afb3934d88;

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

        uint256 expected = 0x02548c885400ebd1e518ed3538d94c0d41e3b69ffc09cd4370784e6fd1ad9318;
        uint256 rz_rx = EqPolinomialLib.evaluate(r_z, r_x, Pallas.P_MOD, Pallas.negateBase);

        assertEq(rz_rx, expected);
    }

    function testEvalsSecondary1() public {
        uint256[] memory tau = new uint256[](3);
        tau[0] = 0x009c590b21fa438a0f41c61f879bde904d64caa038b18e804a5b45d294334b1e;
        tau[1] = 0x3d751f5428fbcf26b2ae69067c7fd14af5c1565070f12c8444ec6682ada61091;
        tau[2] = 0x3800b5d1d3dfba0d2299f91c1913e08322441751e5a16fac0221e9f272abc0e0;

        uint256 expectedEvalsLen = 2 ** tau.length;
        uint256[] memory expectedEvals = new uint256[](expectedEvalsLen);
        expectedEvals[0] = 0x274f14110adea35d5d213bce0f62eed5a470bb7887d169b6cd3b168c819b5a1d;
        expectedEvals[1] = 0x17b5a1f04a62eff1f76920ba4cb0b1e81c88e8e8375c2687429f16b533725e58;
        expectedEvals[2] = 0x2d6872658e860bab8d5e7cdf83bf620c45c7abb6e7191e9e426c0282695cfa65;
        expectedEvals[3] = 0x12f67e8dfa3e1d7b0ed5607898911ea5f06717403431145e7bec60ab4d62020b;
        expectedEvals[4] = 0x00b62b6f4eb3f3ce5bb7371b28a0d9d900d1b40e8431b8df771b5768cf75e5a6;
        expectedEvals[5] = 0x02cfff3b330ea9bb9d100355fecbb41e8d0083385ed8dc194cabeb14cdd65157;
        expectedEvals[6] = 0x329198484407a31b972f171b2b28f4c259859864440049b81bf066f8d2e604fc;
        expectedEvals[7] = 0x0a8496185c3002e47f4b749335065bd6885393f11b3b58acf6ea877d24010f26;

        uint256[] memory evals = EqPolinomialLib.evalsVesta(tau);
        assertEq(evals.length, expectedEvalsLen);

        for (uint256 i = 0; i < expectedEvalsLen; i++) {
            assertEq(bytes32(evals[i]), bytes32(expectedEvals[i]));
        }
    }

    function testEvalsSecondary2() public {
        uint256[] memory tau = new uint256[](4);
        tau[0] = 0x009c590b21fa438a0f41c61f879bde904d64caa038b18e804a5b45d294334b1e;
        tau[1] = 0x3d751f5428fbcf26b2ae69067c7fd14af5c1565070f12c8444ec6682ada61091;
        tau[2] = 0x3800b5d1d3dfba0d2299f91c1913e08322441751e5a16fac0221e9f272abc0e0;
        tau[3] = 0x09b0dcdd3ebe153fea39180a0f6bf9546778ffd7e288088489529aa95097fcea;

        uint256 expectedEvalsLen = 2 ** tau.length;
        uint256[] memory expectedEvals = new uint256[](expectedEvalsLen);
        expectedEvals[0] = 0x15b0cc42ce7c0f760ee8fbcd01ac9d11bc6f38c6e38be061b8d9210b8adff1ff;
        expectedEvals[1] = 0x119e47ce3c6293e74e3840010db651c3e80182b1a44589551461f580f6bb681e;
        expectedEvals[2] = 0x04d6c22d8297181b22a6afc36b59fcb769b32907367b7a498b4494ce3b986e08;
        expectedEvals[3] = 0x12dedfc2c7cbd7d6d4c270f6e156b530b2d5bfe100e0ac3db75a81e6f7d9f050;
        expectedEvals[4] = 0x17c58a32a53682f9e6e6d9a75882e0744ad1ef32981a6d6905ae5ae100e78f86;
        expectedEvals[5] = 0x15a2e832e94f88b1a677a3382b3c8197faf5bc844efeb1353cbda7a168756adf;
        expectedEvals[6] = 0x1e42317bdac5f9ed62288bf10225506cba28d6e28638749e729cc282e2f19706;
        expectedEvals[7] = 0x34b44d121f78238dacacd487966bce395884d959b78d489d959689496a706b06;
        expectedEvals[8] = 0x0a5432eb375ab1771e350bf06fd43fa39816db6950ce49367557491b22cd99c5;
        expectedEvals[9] = 0x3661f884175942573d822b2ab8cc9a358b0171a13cf818868e0af96eaca84be2;
        expectedEvals[10] = 0x3ba2ee3591edac9a6365d99796c5ed08ccdf3abd53de19f2f6959107bbb1dff5;
        expectedEvals[11] = 0x072d1105a120fd2139aa29be6805c715e267e177148f6b03e25d452e12247163;
        expectedEvals[12] = 0x26f49dead673ce8b9340fbfd2de956ba493e80df4e889240be5e93a1b0d566d8;
        expectedEvals[13] = 0x0b9cfa5d6d93d49003ee1b1dfd3f9e0810471784f577b7775d91d35722109e24;
        expectedEvals[14] = 0x38d419f8507619aa864bf547f461b89b484fa52f183b68d4c114d0d875c19bf6;
        expectedEvals[15] = 0x11b07c200bb9e939f8ff7f4b40a4a33b624a87be0c9498b5c21ca1c5ae3f7331;

        uint256[] memory evals = EqPolinomialLib.evalsVesta(tau);
        assertEq(evals.length, expectedEvalsLen);

        for (uint256 i = 0; i < expectedEvalsLen; i++) {
            assertEq(bytes32(evals[i]), bytes32(expectedEvals[i]));
        }
    }

    function testEvalsSecondary3() public {
        uint256[] memory tau = new uint256[](5);
        tau[0] = 0x009c590b21fa438a0f41c61f879bde904d64caa038b18e804a5b45d294334b1e;
        tau[1] = 0x3d751f5428fbcf26b2ae69067c7fd14af5c1565070f12c8444ec6682ada61091;
        tau[2] = 0x3800b5d1d3dfba0d2299f91c1913e08322441751e5a16fac0221e9f272abc0e0;
        tau[3] = 0x2b1fbf9f6d235d75e616c78a1fe7896bb7617c549d48e89bca5d543a861a086b;
        tau[4] = 0x097721fcef4ac39120d7370ac44f7aa376fd57491abff8b27721f38213c6c8ca;

        uint256 expectedEvalsLen = 2 ** tau.length;
        uint256[] memory expectedEvals = new uint256[](expectedEvalsLen);
        expectedEvals[0] = 0x30d1494dce85d69ab3e0d3d33de9f45622ccf28bb70dd96e6fee7853ada2a7fb;
        expectedEvals[1] = 0x3a51de85c12be8f413153be32095f1db498797fd4e9f220cdcf55937b8805756;
        expectedEvals[2] = 0x3347f804eaddbe6b8e20efe473394f1ec13edb3beb4dc3e4ac33f4495c5c6c06;
        expectedEvals[3] = 0x08e3f438904f2563080a3c333da9b985bb6a87aba9fffc11ecb126f9bf1beec8;
        expectedEvals[4] = 0x05f06fa4cb0f9255876d82e7d4cb855f6344eb3949aabd0feb91f00e56004749;
        expectedEvals[5] = 0x2e24aeb60d7d32bcfd6335d6662ec77de9bd0911c5e3ab68e42351327d18d3f4;
        expectedEvals[6] = 0x3014e06d00d555a0cf2577efbd581bab1f02459768b65ca18ab9cfc7440815a5;
        expectedEvals[7] = 0x338ba3287100d53ea372f00c545e495ff511e0fdd240b32800bddbef1c512d78;
        expectedEvals[8] = 0x1f24463e0342358171954338d2668a212dc867871d26065023ea13163f1a3d3d;
        expectedEvals[9] = 0x1123818ad9a39e40c47793da0413d606cffae52b3b52a2ff74b0cb548625f222;
        expectedEvals[10] = 0x01feeba44507d91d977dda0b496e55949b4400dbfd05f0a38570ed72347c73bf;
        expectedEvals[11] = 0x3b21bef86c985ecbbfd3cbc163d6ac4fcf06f7249b2f2d88b0a721c66fa05748;
        expectedEvals[12] = 0x2ce835d93477b46acb560d2d1a40b00ed9666acf7f61bc4d8ab71e8e82d0a07f;
        expectedEvals[13] = 0x2335170e223b0a04873d3b9e367beb5894ec4d0a5bd95dccc19bdaac6cf657e1;
        expectedEvals[14] = 0x36b56d960d67c531340746c1471324e88bad8bc87ef6498b0604d7ffa280b1a6;
        expectedEvals[15] = 0x0c23c410962399da883ad0ec00c15e563af40595ed290274422265b2bb1a5807;
        expectedEvals[16] = 0x129ebd9896ab82b1a4674bab2eb98fce2e9a106eabf0614cb050026dcbb5362e;
        expectedEvals[17] = 0x0f07fe1e6294ea8d298e9ab66149ce123224936ddd7334222f38f40e0047d97f;
        expectedEvals[18] = 0x0264378af480412b985804d8c78e3fa6f42c81a1c041666a82b8ad484be7f3c7;
        expectedEvals[19] = 0x1cab382d60f34563f5694be0d10f3c51ce2d278c442165e3a1209ec5b790e233;
        expectedEvals[20] = 0x17b5e21f66f1a2ce7cca66bc09a57f997d50fb5d14098339d8f89e1a92abf32c;
        expectedEvals[21] = 0x3ba258375f477c396187859715de9582ccb4f11e2791d4caf679e501cfdb9d4c;
        expectedEvals[22] = 0x1c4dd1d611fcbfe1e65f5e34cdee68d11b038997b315857c1243db54bd623b37;
        expectedEvals[23] = 0x1329f30e5ad8cad1d85eb8ce115936316c843f1d83515053838362e5adec85aa;
        expectedEvals[24] = 0x01463ebb82c628e0d72950f07c9513540963b6c98f3be33fb1d83efdd2afdfaa;
        expectedEvals[25] = 0x3c6fdfa1bd42d7e8d937f41ef81216ad36cc656c1d054eda375ad1a7835ad95f;
        expectedEvals[26] = 0x39b0944df1a7baba7bdf8b99967045d7f4801c5bb8244104b3fdb43864c41715;
        expectedEvals[27] = 0x3b2ae59d1256e7976aee4672201184e9696291caf2c42854974d785d181734e0;
        expectedEvals[28] = 0x2ff1caa844d21f1159c46c534c09c425bb51ba13765ea2fbf9ca593f5072dbdc;
        expectedEvals[29] = 0x129c066eb2b0df958f14cc0baf2ee6d3b166fa8688631d4690a121ffb6a08048;
        expectedEvals[30] = 0x23ba308243e90dfcf16d3ae14e5616ff92736ec5d39502bba0aacc61bfb7983c;
        expectedEvals[31] = 0x243c947f20c3f640a5050152eb7799ddcdb4a2895c0de769e462161e5d361ac8;

        uint256[] memory evals = EqPolinomialLib.evalsVesta(tau);
        assertEq(evals.length, expectedEvalsLen);

        for (uint256 i = 0; i < expectedEvalsLen; i++) {
            assertEq(bytes32(evals[i]), bytes32(expectedEvals[i]));
        }
    }

    function testEvalsSecondaryFinal() public {
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

        uint256 expected_25 = 0x07e5436563421cb8543e4b0840e06573c812669766df4944df2d7161a2dc1f6c;
        uint256 expected_380 = 0x2a7b1c7fa80313f1c025ab059407b86a231c2228b981a4468b018c651017c5c6;
        uint256 expected_1444 = 0x3cc771c99e94718d812e5f843830cfe685be08a18f26f998e416a50fb88d6975;
        uint256 expected_12846 = 0x08a280a50f2d4253c17ed47c5edfed39560f5189a430c102ef00960514e3300a;
        uint256 expected_16000 = 0x264db57dbf9e8cda1752e7c88c2380f2604c140067d1d6c294c92901fd80a1f0;

        uint256[] memory evals = EqPolinomialLib.evalsVesta(tau);
        assertEq(evals.length, 2 ** tau.length);
        assertEq(evals[25], expected_25);
        assertEq(evals[380], expected_380);
        assertEq(evals[1444], expected_1444);
        assertEq(evals[12846], expected_12846);
        assertEq(evals[16000], expected_16000);
    }

    function testEvalsPrimary1() public {
        uint256[] memory tau = new uint256[](3);
        tau[0] = 0x327f4af4db96711d3192cee19b1946d5b9d3c61e78d6f352261e11af7cbed55a;
        tau[1] = 0x2640290b59a25f849e020cb1b0063861e35a95a8c42a9cdd63928a4ea856adbf;
        tau[2] = 0x11b72e2a69592c5545a794428674fd998d4e3fbd52f156eca4a66d54f09f775e;

        uint256 expectedEvalsLen = 2 ** tau.length;
        uint256[] memory expectedEvals = new uint256[](expectedEvalsLen);
        expectedEvals[0] = 0x1b19cbc8b0208f204369a1a152322c3b65f924254219baabcd1c9fe233b54edb;
        expectedEvals[1] = 0x343893a10b1f87a5ae825fc178f5cf6089c40dc534e8638668a295ac926ada6c;
        expectedEvals[2] = 0x2643ee2b9edc40df89e166354b28bd25411d81370beb8b8d89b2e61079a72d32;
        expectedEvals[3] = 0x17ea6775ca4d373d529fc9864e9600697c2551b420f95d86bf4494144379d431;
        expectedEvals[4] = 0x0252794a86884ce86609ac2509d0a86c7d9e5f315d4c9a66a73601623a20e9c3;
        expectedEvals[5] = 0x081afe4064953ccd0a0845c67b012395f3d70b337aaffc44d806150257683f3a;
        expectedEvals[6] = 0x2a989e96c121b6c28703b7c1d25f70999289edad14e61a2e75e1e19827e322d5;
        expectedEvals[7] = 0x3d7934d32f5730a53a7d253443e80a39d81b07089588eb55bd4704d3c3528989;

        uint256[] memory evals = EqPolinomialLib.evalsVesta(tau);
        assertEq(evals.length, expectedEvalsLen);

        for (uint256 i = 0; i < expectedEvalsLen; i++) {
            assertEq(bytes32(evals[i]), bytes32(expectedEvals[i]));
        }
    }

    function testEvalsPrimary2() public {
        uint256[] memory tau = new uint256[](4);
        tau[0] = 0x327f4af4db96711d3192cee19b1946d5b9d3c61e78d6f352261e11af7cbed55a;
        tau[1] = 0x2640290b59a25f849e020cb1b0063861e35a95a8c42a9cdd63928a4ea856adbf;
        tau[2] = 0x11b72e2a69592c5545a794428674fd998d4e3fbd52f156eca4a66d54f09f775e;
        tau[3] = 0x09b0dcdd3ebe153fea39180a0f6bf9546778ffd7e288088489529aa95097fcea;

        uint256 expectedEvalsLen = 2 ** tau.length;
        uint256[] memory expectedEvals = new uint256[](expectedEvalsLen);
        expectedEvals[0] = 0x13773265a51901ca29f226b90f1126d1e7126b5c55e92615440c1ac20489e42a;
        expectedEvals[1] = 0x07a299630b078d5619777ae8432105697ee6b8c8ec309496891085202f2b6ab1;
        expectedEvals[2] = 0x2d3ba10be93c3143f9744aab68cf52f5f1b6e3d9b053c13797aa14b3ea15bb97;
        expectedEvals[3] = 0x06fcf29521e35661b50e151610267c6a980d29eb8494a24ed0f880f8a8551ed5;
        expectedEvals[4] = 0x09f48fe5068c42192a8aa1b9c50aa84df8d1ee68ecbab08127a3ebfa75cb2b0d;
        expectedEvals[5] = 0x1c4f5e46984ffec65f56c47b861e14d7484b92ce1f30db0c620efa1603dc0225;
        expectedEvals[6] = 0x0bc5f3afdadfc9f1d6c3ceb8c1a75e1e5ce39ce01ce665b60c47b3055f13ceb8;
        expectedEvals[7] = 0x0c2473c5ef6d6d4b7bdbfacd8ceea24b1f41b4d40412f7d0b2fce10ee4660579;
        expectedEvals[8] = 0x22bc24bb1c037fa3bab1b6d5d53ba18ff1c6afbefbc0cf0241368f96196fd5ca;
        expectedEvals[9] = 0x1f96548f6a84cd44ab57f54f349506dcae1e486e6b207441f2465ced20b113fa;
        expectedEvals[10] = 0x34ac71976ef3edc462b47dd8bb934736f772c378d8cbb84d37a212bc4f124960;
        expectedEvals[11] = 0x136e8ca8f5a14f08a753c7edbf6ddc5f1eaae0b6ab78ecd52caaed670855f5db;
        expectedEvals[12] = 0x2290207b9f3cd8e4d515dab3fb3cdcfeba882d74c023d8d647bf8cde32b8b4bf;
        expectedEvals[13] = 0x08087e1b21e4ddddb1eddd0dd722939ad801c03854c241582e2254b9f52a6e16;
        expectedEvals[14] = 0x25e9154e274c6559fe95f6bc65f5c0b24f60e8ec9f3c3d47d78f143450ae95ac;
        expectedEvals[15] = 0x17901f85080acb4b3be72e77ddf2498788ba1e1bf64cae0de5b7f09f72a3f3dd;

        uint256[] memory evals = EqPolinomialLib.evalsVesta(tau);
        assertEq(evals.length, expectedEvalsLen);

        for (uint256 i = 0; i < expectedEvalsLen; i++) {
            assertEq(bytes32(evals[i]), bytes32(expectedEvals[i]));
        }
    }

    function testEvalsPrimaryFinal() public {
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

        uint256 expected_98 = 0x300a3ae66435899e18da1ec393ef3cb5b7acea8457a16311c97e74238693b16f;
        uint256 expected_284 = 0x2e4a3e09e7d61341be3c766de6af5bf717e6cc6f7bc2ae83c538d36bf42932de;
        uint256 expected_5492 = 0x29b3808ad5ba1830488e59635c6a8807f5fbe88d7e0c896e18f0d31289095890;
        uint256 expected_10990 = 0x266112cd25ef3a6db1c5fd29c974623019b257d81d2d6030b1d86608a13ae827;
        uint256 expected_15998 = 0x39fc62e9d005e4ba23a27f29736dcb7a77c88aabda02ccaec49cc5591778da41;

        uint256[] memory evals = EqPolinomialLib.evalsVesta(tau);
        assertEq(evals.length, 2 ** tau.length);
        assertEq(evals[98], expected_98);
        assertEq(evals[284], expected_284);
        assertEq(evals[5492], expected_5492);
        assertEq(evals[10990], expected_10990);
        assertEq(evals[15998], expected_15998);
    }

    function testVectorEvalsFromMultiEvaluation1() public {
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

        uint256[] memory T_x = EqPolinomialLib.evalsPallas(r_x);

        uint256 expectedLen = 16384;
        uint256 T_x_expected_0 = 0x3cac77591cd8693719d5c89c475a6c978fbeb6bdb3fffc9cb916a97d5c17f664;
        uint256 T_x_expected_20 = 0x3c82227d64af6b102e74a400307763b86ac11841b050a8a4e4b1c193a38f1012;
        uint256 T_x_expected_300 = 0x15629d69df11293f8ddb92b50e0ba9f70fd37c67a698603b296a6b4909431918;
        uint256 T_x_expected_4000 = 0x0af59bd109a32676fd07269a18189c542ec83df497be7deab63be90d1c172fd5;
        uint256 T_x_expected_10000 = 0x33f200d559bb7d102f29a8a66f6f4ce8e48d1b4c5784b5e38235626809177eb2;
        uint256 T_x_expected_16000 = 0x2652db4337b9e14656054ecb597f7854b3f9968045a2691f024551639e731ebb;

        assertEq(expectedLen, T_x.length);
        assertEq(T_x_expected_0, T_x[0]);
        assertEq(T_x_expected_20, T_x[20]);
        assertEq(T_x_expected_300, T_x[300]);
        assertEq(T_x_expected_4000, T_x[4000]);
        assertEq(T_x_expected_10000, T_x[10000]);
        assertEq(T_x_expected_16000, T_x[16000]);
    }

    function testVectorEvalsFromMultiEvaluation2() public {
        uint256[] memory r_y = new uint256[](15);
        r_y[0] = 0x133d7ae3ae852269542c5198e6d1054dfc720f32dc111075699e40f4bed9dc98;
        r_y[1] = 0x3916fe320f183c1453d0e9bb3bfa7374793096fdf38379aedea66cc7dcaf7e08;
        r_y[2] = 0x2a0d9fc4ae15bdce6a8e5a5471fb590535e9533508f035d90f9255fb48fc2e76;
        r_y[3] = 0x01b240c33764723dece2cb1b9df078fa37358487b31b02566ff41185864a5e62;
        r_y[4] = 0x17848bd9c88037915d94e8fce040d9ed50cfb2894c2fe9423f6dbe5c34d23cb3;
        r_y[5] = 0x26f476c4734135d0f82908d3e78552efc3d0f283eaa8c09ab62b54ac7d14addc;
        r_y[6] = 0x2a0fafde03242db9d319f8e09fff11a7e2f6124ed17cea107da09f36eb30dbbe;
        r_y[7] = 0x17901b6eba9aa318f4865f1f920197823475f95d8f45869885cd1791dc165716;
        r_y[8] = 0x300f98dcdf44099acb80516ec8ee48316df00cd09ccba21837a0cd906637778e;
        r_y[9] = 0x2a252100fac6781457578c3f24510de75b67164a4c6fd26ea6e8f7b86689dba4;
        r_y[10] = 0x3716a88a6fc03454b3527bb7ca8a0175ec71ec39a40de88f770dfe44ae611b1f;
        r_y[11] = 0x3e464a14ffef67ca9d1bb49e9afa113bcc701884b3aaa68385f4e6f804c07500;
        r_y[12] = 0x34169db7131567c40085024f4177f987cbcbf6168e630db10bd79f8d5775f37b;
        r_y[13] = 0x1ed7da2e753c94332e034b046d37937577582b78c2cffa3ada412ac7d6446745;
        r_y[14] = 0x3e69c1910a9263ddee4a0cec382a858a67e33f74de3d76058fd6248cd8257cc8;

        uint256[] memory T_y = EqPolinomialLib.evalsPallas(r_y);

        uint256 expectedLen = 32768;
        uint256 T_y_expected_0 = 0x3d1442de6e207afdf8f0c86bc413471387757ee37ba9f7474637c24bd81f7500;
        uint256 T_y_expected_20 = 0x0e42ea2ee239daf67c0ee48a3fbbe214e946ba15813eb4871db635a6857e3215;
        uint256 T_y_expected_300 = 0x24ce4f356364f4f0e36e67c0c2da90abe9ea25f22d32138a0b974c2da2f38680;
        uint256 T_y_expected_4000 = 0x0ede2724331fa10acb981810dad0d53c4d2859bbe26f78fbd826f5547ef8ea4f;
        uint256 T_y_expected_10000 = 0x1c1a644b3601b80dd2eadb4abb80f9398e0005cd0e128342282eb70a7c3dde0d;
        uint256 T_y_expected_16000 = 0x2d61fe510e673bb7f1e00150428641e727f1d733d2ee485f7cef64873ede1b2c;
        uint256 T_y_expected_20000 = 0x0ee45b5e23300bc1ff255ea8065ba66916c311c7852a617f0e7d9f6e3732f797;
        uint256 T_y_expected_30000 = 0x2065902c645f999cfc142528a078e577132bb5146f10209a7527c7f20aae0940;

        assertEq(expectedLen, T_y.length);
        assertEq(T_y_expected_0, T_y[0]);
        assertEq(T_y_expected_20, T_y[20]);
        assertEq(T_y_expected_300, T_y[300]);
        assertEq(T_y_expected_4000, T_y[4000]);
        assertEq(T_y_expected_10000, T_y[10000]);
        assertEq(T_y_expected_16000, T_y[16000]);
        assertEq(T_y_expected_20000, T_y[20000]);
        assertEq(T_y_expected_30000, T_y[30000]);
    }
}
