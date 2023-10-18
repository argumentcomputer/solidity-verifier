// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.16;

import "@std/Test.sol";
import "src/blocks/pasta/Pallas.sol";
import "src/blocks/pasta/Vesta.sol";
import "src/blocks/grumpkin/Bn256.sol";
import "src/blocks/grumpkin/Grumpkin.sol";
import "src/blocks/PolyEvalInstance.sol";

contract PolyEvalInstanceTest is Test {
    function testPolyEvalInstanceBatchPrimary() public {
        uint256 c = 0x2bf7d5c8107fa9dfff6588835fd722abd21d80cfa1fc553807fa0d88af856c48;
        uint256[] memory tau = new uint256[](17);
        tau[0] = 0x15f5e9f471c313af5c8190c109c3a1fe9cee73d035bcd08a204898e795d8e497;
        tau[1] = 0x026bc743ada824501ac59409a022aeaba83ebe9c6fe153969c47d3dbcba1be20;
        tau[2] = 0x0235a660a3f8c7aa923e90ef914634b078bec35cd1b1ed8d763735655f16c86b;
        tau[3] = 0x06b9cd3880fe5f9881f9fd2b0f15eaa134f0271faa129290886932018371f6a4;
        tau[4] = 0x369f08f9d3a1b649e724e2ded5d88ae935ee5128bfc966a33b09fd298ce1f4f9;
        tau[5] = 0x17c2194712668c76ac2ac0d4ddc7ae50995905fa689a153b3a46b539a40a0cb8;
        tau[6] = 0x0416682dc67529249a90de425db7b2f08a44eefa18ff9a42dae68dd77e001d23;
        tau[7] = 0x08414bd36fb4ec48989f9922cd0fa9ab1e1414d9bc3e7be4dd87166124351a6c;
        tau[8] = 0x3714b73daef1dd873e79a9b670c7f403a506aaec54666f2a9daa8805ce3fa7df;
        tau[9] = 0x3c23643dd2a5d6b64ba3f86d6ea4c347db24e45163421b450b20dc44e502da77;
        tau[10] = 0x219bd827a1a9cfcbacb2d66370f8ab9af8449f0e779eeb441b0cc3e46ac24408;
        tau[11] = 0x2a99b7d2d92e7ce4b1a5bb9893a58c94525afcc43ca64c9579217d5db1980289;
        tau[12] = 0x244902bf184af91659be921be063244f4d9aacf94e19fd121446104850f2b1d9;
        tau[13] = 0x1594eeac26b85866f2cf09dea1c5ee8920e8b4bfde8edba325f5e89ac9995ab6;
        tau[14] = 0x2e6dee8a44ef6d3058da01d7e90582d1f5d6b2fd8f05eea54540fe77a8444f12;
        tau[15] = 0x17798e8f0e66b1d6e1f53871eeaaabb28f680fda97a9ae07eb833be231310035;
        tau[16] = 0x2a7e0ec4192134bc0102de30940d4fd26bb0cd60e11f74519f9d9a90bebeaf5f;

        uint256[] memory eval_vec = new uint256[](3);
        eval_vec[0] = 0x392e7115e56e1204476bb7bd0822c98c92372549ce1a153358f22caa7d7a6580;
        eval_vec[1] = 0x06aeecbdd8d4fdafbf0e4b0d739b60a084c4434f1b3fad4b6872907f1e6a6b61;
        eval_vec[2] = 0x28fd09141451e22d1359c05a6185054e21f569ac2b02f4ddc50949cfaee53277;

        Pallas.PallasAffinePoint[] memory comm_vec = new Pallas.PallasAffinePoint[](3);
        comm_vec[0] = Pallas.PallasAffinePoint(
            0x33f7fe7aadab0547f6aac7531ec6c508338ba5118aff5eeb68891acc847e3687,
            0x0e1a548676d1dfa14e19f32eb98e1b1bff230e8ba130b147c523c87a1a955e1d
        );
        comm_vec[1] = Pallas.PallasAffinePoint(
            0x2417b2e8c58924f71273dea4ed0c6c9d03a89aaa03c1bd208128b41c6d92a93d,
            0x233f71da4d66c714fccf3de4e6ae4b9baf259eaf68d87ef22c3820ffd20f612d
        );

        comm_vec[2] = Pallas.PallasAffinePoint(
            0x2f11d5c141f26972584526f310ac8b01b2a2b52213e30ac920fe782d365958d3,
            0x2b9ba1235a1ef95ab89c4c25f520b7598d995e11e6257b587914cc426c4c31ef
        );

        PolyEvalInstanceLib.PolyEvalInstance memory actual =
            PolyEvalInstanceLib.batchPrimary(comm_vec, tau, eval_vec, c);

        uint256 e_expected = 0x2b005e5de5ae62075c66de1c5343c86a235ffc0184fd317079c6687f53596bd4;
        Vesta.VestaAffinePoint memory c_expected = Vesta.VestaAffinePoint(
            0x27f23d4d7603ec8b206a427a04da21bf3282a95e114447aee4a1ac76e4aacb4d,
            0x209850df39cd098612ab3329da5e21001c81c08b9be94d2bc90833cf7bde14e7
        );

        assertEq(actual.e, e_expected);
        assertEq(actual.c_x, c_expected.x);
        assertEq(actual.c_y, c_expected.y);
        assertEq(tau.length, actual.x.length);
        for (uint256 index = 0; index < tau.length; index++) {
            assertEq(tau[index], actual.x[index]);
        }
    }

    function testPolyEvalInstanceBatchSecondary() public {
        uint256 c = 0x0b997b6ffdc3ec15ffa942ce26cb2144184c7e88eaa29770a3061b22c062ea1e;

        uint256[] memory tau = new uint256[](17);
        tau[0] = 0x17c03663671666409d2e5656c3ee877145c7e32e3494e16dbbec709afd0709e6;
        tau[1] = 0x38b515b8596f09d0f1c56b3da33dc7c7dd3b1fe25d0d04b87cd716dc23f2cc31;
        tau[2] = 0x23ae00416f6e0bd1e292f12ba6cbd2c498509027b8a2d92f287314235f2b2a6d;
        tau[3] = 0x35281c3c99450dd3bdb0fccdafdf3028ea4e5b11a59fd8d485191cf79344f9e4;
        tau[4] = 0x3110a4ef81e06dd527736a4fa519e2dd25453adb5355b08e9c83bd6341274585;
        tau[5] = 0x02f5cd90a9bb245b75139967f5e033ccdaa0a5c03aa8eb349ec36eed1a4ee8fc;
        tau[6] = 0x3f7bbbc64bcd58d08a504d873192746a9f568042907f926b174b59a0247f6e8e;
        tau[7] = 0x2a3cb49129f6437fc4fc78ea272a653b610569f37a21757078fa74b39340f832;
        tau[8] = 0x246eaeb45c2eaa49fe0490501a77cea8f18497c2b7a35b9d86f0930e0e082b7f;
        tau[9] = 0x2f401cf8151d3eb918d15212f026ebd4930794107e7cd915c789a4b1c7e5eadd;
        tau[10] = 0x133bd93c31e8b783f39e71c9b40c96591649115e90b0bafbffa1823fffb10ba0;
        tau[11] = 0x14605eada47c70ab4c51563dc9fbb4953df05924deef56cbf8189840774a3828;
        tau[12] = 0x3a09b34278f95c71529c3374c6567cec43f5dd65c76f863469249d5c2ef43e9e;
        tau[13] = 0x0d88b3a19bf13be9c4c868dcff22a6790cc07736b9ed457be5782809bb55e0e4;
        tau[14] = 0x19430f84eabe5885bd7fcdb9630c471c8c6002ad54302818962e3f63293935f0;
        tau[15] = 0x3c43f9fc4e8571b3b15190551fe246bc25d190cff304e99253123126baf888ef;
        tau[16] = 0x0bde99a49b09b102f23fe24cf9790380c734acc82063014a243edbbe4b8ba3ed;

        uint256[] memory eval_vec = new uint256[](3);
        eval_vec[0] = 0x03ceb0495f19505b379b535efae65b4aff31add3f912304bcc92df3ea5aae3d9;
        eval_vec[1] = 0x2183da210706e672e013cfde880e41bf49dc13f12ab15a5741bd7d0d2adcab27;
        eval_vec[2] = 0x16b1a33f9c928dce78632e3b85f165cb349011f4431d8e8aeda66956471adb0b;

        Vesta.VestaAffinePoint[] memory comm_vec = new Vesta.VestaAffinePoint[](3);
        comm_vec[0] = Vesta.IntoAffine(
            Vesta.VestaProjectivePoint(
                0x399fb61daa126807594503e6b5a9f4d41d47c0e94b77a54e33f9abc7500d8830,
                0x3c7525102839e143f08f1365392295980eecb695885acfb73e6c050a7d83e1f7,
                0x0000000000000000000000000000000000000000000000000000000000000001
            )
        );

        comm_vec[1] = Vesta.IntoAffine(
            Vesta.VestaProjectivePoint(
                0x2dea24643491790d8d700e24bab5daa86ffcb9dfc7f590c801116d74f04782a4,
                0x13cc89863fccababa979cae3f29d64a5f817e9293ab0a7ce19410a140da6eb0d,
                0x0000000000000000000000000000000000000000000000000000000000000001
            )
        );

        comm_vec[2] = Vesta.IntoAffine(
            Vesta.VestaProjectivePoint(
                0x11a118c96ba25b5e6ded741c1df681a55cfa8608aaedcb239dd264f851d22c32,
                0x2c2c0081a75a06c5c8dfc20e62f02ee1eb41d7ac03b3d53d188de772c676b1b5,
                0x0000000000000000000000000000000000000000000000000000000000000001
            )
        );

        PolyEvalInstanceLib.PolyEvalInstance memory actual =
            PolyEvalInstanceLib.batchSecondary(comm_vec, tau, eval_vec, c);

        uint256 e_expected = 0x2144bc0d13b5cfc99beab8db542dd270bd2a8af3911e754ca0ca0818a5b9a5ba;
        Vesta.VestaAffinePoint memory c_expected = Vesta.VestaAffinePoint(
            0x15353461b0478bc4adc71d396fdb3d98aef58ac5184a56985b145ff8a72056cd,
            0x2042fe5212f18f19e509506eb626870011bfd54556493e761833a88dc40cadc0
        );

        assertEq(actual.e, e_expected);
        assertEq(actual.c_x, c_expected.x);
        assertEq(actual.c_y, c_expected.y);
        assertEq(tau.length, actual.x.length);
        for (uint256 index = 0; index < tau.length; index++) {
            assertEq(tau[index], actual.x[index]);
        }
    }

    function testPolyEvalInstanceBatchBn256() public {
        uint256 c = 0x1acafdcb84c47d71973e472fff62b7c5c9ab8ef5c4a6198c582d7d99427cef9b;

        uint256[] memory r_sat = new uint256[](17);
        r_sat[0] = 0x144454412fd8764e4aaf2cec1546f1a9f1f154e7de160d033a632ecdfdd5964d;
        r_sat[1] = 0x05837413e5049a37ef21bc91fd21fcce3f89e80202ec70aa01872cc9221d95cd;
        r_sat[2] = 0x17430b827b82e51b14fcdf9511b6a8061d1392d4589b8221dafbae759dd6e070;
        r_sat[3] = 0x0256f4d5674a529ec39e0afba3738d0263cb1d385a563ce608edad719f47d5fd;
        r_sat[4] = 0x00f87554a6caed435bb9e714a355fa73cfd359d5dd8b31fc172ada8cecd7ee30;
        r_sat[5] = 0x29b4dbb7be87a4961e21fe447b03125469077ba2bad896ac2c374aa55be358ab;
        r_sat[6] = 0x1493591a52ded39471fbcd9937537aae9023e77080708f790798671aaa268fc9;
        r_sat[7] = 0x046d5e95bee7ea383f29e0ffa2a6e2816d5b82a75283265e2bc17e63d6ecaeee;
        r_sat[8] = 0x0ea46d83cda8cac4084d937137ab451e89d3fef4b6e25ec00e80fcb8bf8a5308;
        r_sat[9] = 0x26d16ee1e12b5e781327f54a2b89bb7f397e500ec503066b4e37c5e59c372aa1;
        r_sat[10] = 0x2826c37882e6cec0184d476e6e14ac3cb48aee6e233a1ee085c174d53cf1f419;
        r_sat[11] = 0x1b054f124db95f87ec662a5b8ddf47f2b0264e97ef866a05e2a3e0335bce3b16;
        r_sat[12] = 0x0fd296132bf7fc749c44059331d68c735b05f8f746c26e0bf25c3e0a0e6b17b1;
        r_sat[13] = 0x2aede350fab3723fb2ed55ed281f40e4a718f43237901e99264cb09a586661ef;
        r_sat[14] = 0x1a99798029810bbe8a2a5e0d738e8a7c54c010acf84892178463c3222d08b351;
        r_sat[15] = 0x01611bd374a32895d454f4fbe32f051f82e1fef13242ee7951dc6df7848cef97;
        r_sat[16] = 0x019b91a9d375fe46af22a415a0cba65d78d7a605eecf99b3eff27cd508e6282c;

        uint256[] memory eval_vec = new uint256[](9);
        eval_vec[0] = 0x1869c92844ee39c772ada2ff95041cfd30d520c02c2b6fd36957769338dc642e;
        eval_vec[1] = 0x06294f00889dbe513fa56b4333b61b9929bae58203ebdf5022c5f50a5214d419;
        eval_vec[2] = 0x2e853d4cce3097a6cc3ce6308a033f635b83706b762d0bb8b5f372daa90019db;
        eval_vec[3] = 0x011bde0bb1a59fc9630ffabef3a13fe6a5d5e8c424ce36ecb66e3f73f222c844;
        eval_vec[4] = 0x00ecd149fca8636f1ab0dec1093267aadc8048a235599a4e58511351de79bfb4;
        eval_vec[5] = 0x07141dd079428a72a7f9ea25742d9f533d7c72909d37840673dcd9c2d0a6ceb0;
        eval_vec[6] = 0x0f00fa9ce009193f1639936a4f2ada76bb13239a4e9f492a49643e3984928c04;
        eval_vec[7] = 0x1ffe417d0bb8f7a36ec208ea1bcfc085f746cbcc64bd61756247be41d9986251;
        eval_vec[8] = 0x2af914dc2e54d9dc1294d8517951f5438a3fe7a8b6eca78479652d42b20c9b34;

        Bn256.Bn256AffinePoint[] memory comm_vec = new Bn256.Bn256AffinePoint[](9);
        comm_vec[0] = Bn256.Bn256AffinePoint(
            0x07529bc5cb82ba96db4998574b56d9bbbf012645235b57ae7e04379e028f09df,
            0x0be031e78adfd8cb47edf75ee3fd98d9375f390b43b0dc1fae311990ea5900a0
        );

        comm_vec[1] = Bn256.Bn256AffinePoint(
            0x2bd6ad0e89f1380640a2ab467a5e98c61c56837bc91290503dd6d56ba980a38f,
            0x21009a78324cb30435f455a3b5fbaacf8703657c51a828a3ac4827f1590a260f
        );

        comm_vec[2] = Bn256.Bn256AffinePoint(
            0x1d1f026b9179be7883bd431d47b58f589e1e250464dc4411b84857b9e6931da4,
            0x02aaa7285e6d0d106a9c84098748940ffeb3b139bbd247b6da2fff2fad3be8d6
        );

        comm_vec[3] = Bn256.Bn256AffinePoint(
            0x0dc7ac106c12a5f7a8b2fdc5a066bc3b31e263b1b0b0578e46700a2ad7836257,
            0x21b2f712c2fc970c0a6802243982f8efa9041bd4ca2d53134a1664703c554c3b
        );

        comm_vec[4] = Bn256.Bn256AffinePoint(
            0x22cb779a2f0c48d16a3bb9ea9d606dd7cd319fd9cc2b23975fb618d4cf8c5ff0,
            0x100d402ff4c9e471facc9607a9ce804f945bb9471d329321efb031c316ebe201
        );

        comm_vec[5] = Bn256.Bn256AffinePoint(
            0x14e8dabf9cf5e772190c40ea32665978b81988aa19ae6af9ad13e254229d7ee4,
            0x2dcd8f7ec6354d5c378d04c8c712285bffc81b2b5a50d967ae3443d4f061c513
        );

        comm_vec[6] = Bn256.Bn256AffinePoint(
            0x102e79e22c5552b770774eee21d0b8c059a7451bdb680861cb67f0190888f67b,
            0x2dbfb0ca92f9bcacbcfa85915c7832989579395849508972732c75b5a9d38f54
        );

        comm_vec[7] = Bn256.Bn256AffinePoint(
            0x0c699972babb4c1f0a941e4b41a816208dce53cc4335a2999bfcd6182964d45b,
            0x2e946fd65a8c045a8661ceb72f1290a36ca59b37b6e12061fddf41d3f386c25c
        );

        comm_vec[8] = Bn256.Bn256AffinePoint(
            0x2550d516660f14e32b4df1b879e362382ddb115779da5152fc59c7d9bef11ff5,
            0x2a0099d439d2573a8eba9b5bc393917375fa2abbd3da2e5af15cc0e0cae608ce
        );

        uint256 gasCost = gasleft();
        PolyEvalInstanceLib.PolyEvalInstance memory actual =
            PolyEvalInstanceLib.batchBn256(comm_vec, r_sat, eval_vec, c);
        console.log("gas cost: ", gasCost - uint256(gasleft()));

        uint256 e_expected = 0x101e200bd035b257fe90e8d2d1c0df37860d3f49effed18058414ff5ec3d465c;
        Bn256.Bn256AffinePoint memory c_expected = Bn256.Bn256AffinePoint(
            0x2829fe3f56f139c48a22a3ae7c35a777425e3f578cc81038c7cb0ec519839f6e,
            0x27a0a9319530016b2f890c1cb0d8e956e715477366e11cef729c4aff9a969cfc
        );

        assertEq(actual.e, e_expected);
        assertEq(actual.c_x, c_expected.x);
        assertEq(actual.c_y, c_expected.y);
        assertEq(r_sat.length, actual.x.length);
        for (uint256 index = 0; index < r_sat.length; index++) {
            assertEq(r_sat[index], actual.x[index]);
        }

        (uint256 c_x_assembly, uint256 c_y_assembly, uint256 e_assembly) =
            poly_eval_assembly_bn256(comm_vec, eval_vec, c);

        assertEq(e_assembly, e_expected);
        assertEq(actual.c_x, c_x_assembly);
        assertEq(actual.c_y, c_y_assembly);
    }

    function testPolyEvalInstanceBatchGrumpkin() public {
        uint256 c = 0x2e8f8a893be2cb407f2ab721fb17adce6170f3c4b5f9817b5afff03046c1afce;

        uint256[] memory r_sat = new uint256[](17);
        r_sat[0] = 0x25172cbbd1289dde3d5a3ec6806b7408475968df10e71565ca1ba3579b950bab;
        r_sat[1] = 0x1725a070098a94cf768334d9b0c3ac4a261682687b39c8e6db7ad3c2901d5e24;
        r_sat[2] = 0x26b72d7895ccf170139a9a71e7da7431d81afd3cd5223969d4794ca8b1366241;
        r_sat[3] = 0x2c9493e9d5b214b3cad4bb621544e6001cb1dc10421ede559fb937d89568cd01;
        r_sat[4] = 0x1334cd36b6c002cd14bd1ac0e19bfca3b7fe600634fa22ac5d6fc6b271c50ea1;
        r_sat[5] = 0x24e56409afcdd7500f2608d82db8f7a607cb1c5246aaa03cb30fdab50e6b0131;
        r_sat[6] = 0x27ee3e707f58a066bd5c0c4078fc690de3d108a7f759884c0d890dcf9c71d0ae;
        r_sat[7] = 0x12060dfdd8c1fceaba38ac16288cd391e1bd33e08476edde5dafa859d2bc20c3;
        r_sat[8] = 0x1715421e99f5091ab24230608160f638748e685707ded14d8df5e502eff1c726;
        r_sat[9] = 0x21225c719bfbac3279313676bb52f31d166432319612381d19e29680a23a9e54;
        r_sat[10] = 0x1f5f277e7a112badb02d8cd4794afac553a48acec6eb4895fd4ac287309e0766;
        r_sat[11] = 0x01c6ef7072eae3366e9bac92954116f78dba97d93b34943cdbca7473e03c303c;
        r_sat[12] = 0x2d724a66a4244a6a493bbf6f10e9a1aefce0702e21bc3d1995f4741e0d20e0b6;
        r_sat[13] = 0x287e29cb6788fd94d01ef493dbff1e658619a05ce4fdd1541726bff3cbe8b33b;
        r_sat[14] = 0x106e96134b2e80dc2b4691a8c3ecfc2ea1ef0ab294c5f708cd6774bfeb403009;
        r_sat[15] = 0x2fe84884f541263540ef28f6f103eeccb2413af5378e27d63469466568f56e84;
        r_sat[16] = 0x19a2ee861704322444687829379a8303142709c02feb0f0d56de44c5ab0540e2;

        uint256[] memory eval_vec = new uint256[](9);
        eval_vec[0] = 0x061152dfca99a38e7c0f33e7bf37232e30775a541c5c695799d111e8e815d70d;
        eval_vec[1] = 0x11a2669b59ea53e92bcd84311ac04a2f06ea2df2cc6c0c26f170b24e2b27b2f9;
        eval_vec[2] = 0x0d3a3e3e7c117e3c5d081099a5dbe33450eac5b779fda5454a8d871bb1efb705;
        eval_vec[3] = 0x2ad024657205bb9046e2b5c9e8d7f645449df1497cf08e44adbe64f3baf100dd;
        eval_vec[4] = 0x13eb9b4d9cd546509f9bbd6776e869b25e825220b13d8a8f058e059691f557dd;
        eval_vec[5] = 0x0836f29dba76b5306d17d9e86ea76824a342c8aa124d8c49645128167066a71c;
        eval_vec[6] = 0x0cf93bd2d1465cadb1e7577a09166857378c2422f34f24df0ecabfc6141f5721;
        eval_vec[7] = 0x1b25d17955a5dbbfa7584d1eabe26b37b072d154e0c950a17034475f7155d83c;
        eval_vec[8] = 0x10753e7c91f0aba812b52e835b3a427de7824b4716c054345ec419832be3a8dd;

        Grumpkin.GrumpkinAffinePoint[] memory comm_vec = new Grumpkin.GrumpkinAffinePoint[](9);
        comm_vec[0] = Grumpkin.GrumpkinAffinePoint(
            0x0e725c0a599707e2a957110ce2f96014033005bc88b4dcde75ef06a27169a1dc,
            0x0e366bebddc76eceb1a9e5fbf676fae1bb287f2ff096bbdbf48f6bcf9fd3ecae
        );

        comm_vec[1] = Grumpkin.GrumpkinAffinePoint(
            0x1d37023876a4b66664246686233001ff0fd49d56a930a4de1f789c3971e71f85,
            0x1eae632c5b849657395d625b0c2b02d197d0de037ea142771f97efa159e3ccea
        );

        comm_vec[2] = Grumpkin.GrumpkinAffinePoint(
            0x14b61a3165f2459d0091c5e37fbbea69efea75208f70e8385b034e4e1ce7d30d,
            0x093d34cc4f743944a8e7ed74198022dd74e5354ac768979ebe241679ae57c2db
        );

        comm_vec[3] = Grumpkin.GrumpkinAffinePoint(
            0x1a36a923eb54c2958c1d8f71a8c0a5cbf23fd14b97171736c92de181a2c2271a,
            0x2c00e3ae72c8f5121351cbc7059eeb7e8f98e93c74812429cdcac2397b51843d
        );

        comm_vec[4] = Grumpkin.GrumpkinAffinePoint(
            0x25f77b35698f4f73110525ffb55fe20175a6de4dc83b0555cf47f4d2eaf419de,
            0x07a6415c75c0dae6aea253325102f7ef9d1da89909002ffd599940cd6ccd3c49
        );

        comm_vec[5] = Grumpkin.GrumpkinAffinePoint(
            0x23f069c968669773747617297de032794a2e743869527192c8bbc4a12116d4de,
            0x19ce86221677a23807d6999deea6f5ef203e52f02551779c3f9a992dbf7d21d3
        );

        comm_vec[6] = Grumpkin.GrumpkinAffinePoint(
            0x2157aa228599da44bdd4ecc64f375b736b671d602bc9cb1721d9bcab66839744,
            0x248f38cf3759c4a9884d6db388003a2e4e5bf6e7494ae67ccc3743e657faa25a
        );

        comm_vec[7] = Grumpkin.GrumpkinAffinePoint(
            0x2808d74472a6a4bbc90f8aef38b1a1e6bba9de1cfc9ad567f8d7944919a15839,
            0x1a90ce337756989cc13295ec9e03195418d07447c70b65e7466214bdde5521b1
        );

        comm_vec[8] = Grumpkin.GrumpkinAffinePoint(
            0x19c263edbdff59571f6c1dd8da0d69b5e50cac68c92c689d27e73a0f5c013f82,
            0x1e7ea7240c683088a2b611e1e6c61d935f3788ac65e075a7ccac0079d34dcd46
        );

        uint256 gasCost = gasleft();
        PolyEvalInstanceLib.PolyEvalInstance memory actual =
            PolyEvalInstanceLib.batchGrumpkin(comm_vec, r_sat, eval_vec, c);
        console.log("gasCost: ", gasCost - uint256(gasleft()));

        uint256 e_expected = 0x0088669e792dcb64cc9598dbed28620719bebd0129650d26e886bc06dc43d852;
        Grumpkin.GrumpkinAffinePoint memory c_expected = Grumpkin.GrumpkinAffinePoint(
            0x27f88af1eec0500e566c3e25d6147661e7456b52b2f023f91f421270873d2f92,
            0x03de91147588dfc46735f07ff26fbb05e680de5ee4aa35cd9af42d75e8eee4f7
        );

        assertEq(actual.e, e_expected);
        assertEq(actual.c_x, c_expected.x);
        assertEq(actual.c_y, c_expected.y);
        assertEq(r_sat.length, actual.x.length);
        for (uint256 index = 0; index < r_sat.length; index++) {
            assertEq(r_sat[index], actual.x[index]);
        }

        (uint256 c_x_assembly, uint256 c_y_assembly, uint256 e_assembly) =
            poly_eval_assembly_grumpkin(comm_vec, eval_vec, c);

        assertEq(e_assembly, e_expected);
        assertEq(actual.c_x, c_x_assembly);
        assertEq(actual.c_y, c_y_assembly);
    }

    // Errors
    bytes4 internal constant COMMS_EVALS_SIZE_MISMATCH = 0x426de8af;
    bytes4 internal constant Z_EQUALS_ZERO = 0x95fee54e;
    bytes4 internal constant BN256_POINTS_ADDITION_ERROR = 0x554efa60;
    bytes4 internal constant BN256_SCALAR_MUL_ERROR = 0x8c654ede;

    // Storage
    uint256 internal constant A_X = 0x200 + 0x10000 + 0x00;
    uint256 internal constant A_Y = 0x200 + 0x10000 + 0x20;
    uint256 internal constant A_Z = 0x200 + 0x10000 + 0x40;
    uint256 internal constant T0 = 0x200 + 0x10000 + 0x60;
    uint256 internal constant T1 = 0x200 + 0x10000 + 0x80;
    uint256 internal constant T2 = 0x200 + 0x10000 + 0xa0;
    uint256 internal constant T3 = 0x200 + 0x10000 + 0xc0;
    uint256 internal constant T4 = 0x200 + 0x10000 + 0xe0;
    uint256 internal constant T5 = 0x200 + 0x10000 + 0x100;
    uint256 internal constant B_X = 0x200 + 0x10000 + 0x120;
    uint256 internal constant B_Y = 0x200 + 0x10000 + 0x140;
    uint256 internal constant B_Z = 0x200 + 0x10000 + 0x160;
    uint256 internal constant C_POWERED = 0x200 + 0x10000 + 0x180;
    uint256 internal constant ADD_BN256_INPUT = 0x200 + 0x10000 + 0x1a0;
    uint256 internal constant ADD_BN256_OUTPUT = 0x200 + 0x10000 + 0x1c0;
    uint256 internal constant SCALAR_MUL_BN256_INPUT = 0x200 + 0x10000 + 0x1e0;
    uint256 internal constant SCALAR_MUL_BN256_OUTPUT = 0x200 + 0x10000 + 0x200;

    // Constants
    uint256 internal constant GRUMPKIN_R_MOD = 0x30644e72e131a029b85045b68181585d2833e84879b9709143e1f593f0000001;
    uint256 internal constant GRUMPKIN_P_MOD = 0x30644e72e131a029b85045b68181585d97816a916871ca8d3c208c16d87cfd47;
    uint256 internal constant BN256_P_MOD = 0x30644e72e131a029b85045b68181585d2833e84879b9709143e1f593f0000001;
    uint256 internal constant BN256_R_MOD = 0x30644e72e131a029b85045b68181585d97816a916871ca8d3c208c16d87cfd47;

    function poly_eval_assembly_bn256(Bn256.Bn256AffinePoint[] memory comm_vec, uint256[] memory eval_vec, uint256 c)
        private
        returns (uint256 c_x, uint256 c_y, uint256 e)
    {
        uint256[2][] memory _comm_vec = new uint256[2][](comm_vec.length);
        for (uint256 index = 0; index < _comm_vec.length; index++) {
            _comm_vec[index][0] = comm_vec[index].x;
            _comm_vec[index][1] = comm_vec[index].y;
        }

        uint256 gasCost = gasleft();
        (c_x, c_y, e) = poly_eval_assembly(_comm_vec, eval_vec, c, BN256_P_MOD);
        console.log("gas cost [BN256] (assembly): ", gasCost - uint256(gasleft()));
    }

    function poly_eval_assembly_grumpkin(
        Grumpkin.GrumpkinAffinePoint[] memory comm_vec,
        uint256[] memory eval_vec,
        uint256 c
    ) private returns (uint256 c_x, uint256 c_y, uint256 e) {
        uint256[2][] memory _comm_vec = new uint256[2][](comm_vec.length);
        for (uint256 index = 0; index < _comm_vec.length; index++) {
            _comm_vec[index][0] = comm_vec[index].x;
            _comm_vec[index][1] = comm_vec[index].y;
        }

        uint256 gasCost = gasleft();
        (c_x, c_y, e) = poly_eval_assembly(_comm_vec, eval_vec, c, GRUMPKIN_P_MOD);
        console.log("gas cost [Grumpkin] (assembly): ", gasCost - uint256(gasleft()));
    }

    function poly_eval_assembly(uint256[2][] memory comm_vec, uint256[] memory eval_vec, uint256 c, uint256 p_modulus)
        private
        returns (uint256 c_x, uint256 c_y, uint256 e)
    {
        assembly {
            function to_affine(_x, _y, _z, _modulus) -> ret1, ret2 {
                if eq(_z, 0) {
                    mstore(0x00, Z_EQUALS_ZERO)
                    revert(0x00, 0x04)
                }

                // invert z
                let mPtr := mload(0x40)
                mstore(mPtr, 0x20)
                mstore(add(mPtr, 0x20), 0x20)
                mstore(add(mPtr, 0x40), 0x20)
                mstore(add(mPtr, 0x60), _z)
                mstore(add(mPtr, 0x80), sub(_modulus, 2))
                mstore(add(mPtr, 0xa0), _modulus)
                if iszero(staticcall(gas(), 0x05, mPtr, 0xc0, 0x00, 0x20)) { revert(0, 0) }
                let zinv := mload(0x00)

                ret1 := mulmod(_x, zinv, _modulus)
                ret2 := mulmod(_y, zinv, _modulus)
            }

            function _identity(_x, _y) -> ret {
                ret := 0
                if iszero(eq(_x, 0)) { ret := 1 }
                if iszero(eq(_y, 0)) { ret := 1 }
            }

            function double_grumpkin(_x, _y) -> ret_x, ret_y {
                switch _identity(_x, _y)
                case 0 {
                    ret_x := _x
                    ret_y := _y
                }
                default {
                    ret_x := _x
                    ret_y := _y

                    let t0 := mulmod(ret_x, ret_x, GRUMPKIN_R_MOD)
                    let t1 := mulmod(ret_y, ret_y, GRUMPKIN_R_MOD)
                    let t2 := 1
                    let t3 := mulmod(ret_x, ret_y, GRUMPKIN_R_MOD)
                    t3 := addmod(t3, t3, GRUMPKIN_R_MOD)
                    let z3 := ret_x
                    z3 := addmod(z3, z3, GRUMPKIN_R_MOD)
                    let x3 := 0
                    let y3 :=
                        mulmod(t2, 0x30644e72e131a029b85045b68181585d2833e84879b9709143e1f593efffffce, GRUMPKIN_R_MOD)
                    y3 := addmod(x3, y3, GRUMPKIN_R_MOD)
                    x3 := addmod(t1, sub(GRUMPKIN_R_MOD, mod(y3, GRUMPKIN_R_MOD)), GRUMPKIN_R_MOD)
                    y3 := addmod(t1, y3, GRUMPKIN_R_MOD)
                    y3 := mulmod(x3, y3, GRUMPKIN_R_MOD)
                    x3 := mulmod(t3, x3, GRUMPKIN_R_MOD)
                    z3 := mulmod(z3, 0x30644e72e131a029b85045b68181585d2833e84879b9709143e1f593efffffce, GRUMPKIN_R_MOD)
                    t2 := 0
                    t3 := addmod(t0, sub(GRUMPKIN_R_MOD, mod(t2, GRUMPKIN_R_MOD)), GRUMPKIN_R_MOD)
                    t3 := 0
                    t3 := addmod(t3, z3, GRUMPKIN_R_MOD)
                    z3 := addmod(t0, t0, GRUMPKIN_R_MOD)
                    t0 := addmod(z3, t0, GRUMPKIN_R_MOD)
                    t0 := addmod(t0, t2, GRUMPKIN_R_MOD)
                    t0 := mulmod(t0, t3, GRUMPKIN_R_MOD)
                    y3 := addmod(y3, t0, GRUMPKIN_R_MOD)
                    t2 := ret_y
                    t2 := addmod(t2, t2, GRUMPKIN_R_MOD)
                    t0 := mulmod(t2, t3, GRUMPKIN_R_MOD)
                    x3 := addmod(x3, sub(GRUMPKIN_R_MOD, mod(t0, GRUMPKIN_R_MOD)), GRUMPKIN_R_MOD)
                    z3 := mulmod(t2, t1, GRUMPKIN_R_MOD)
                    z3 := addmod(z3, z3, GRUMPKIN_R_MOD)
                    z3 := addmod(z3, z3, GRUMPKIN_R_MOD)

                    ret_x, ret_y := to_affine(x3, y3, z3, GRUMPKIN_R_MOD)
                }
            }

            function add_bn256(_a_x, _a_y, _b_x, _b_y) -> _c_x, _c_y {
                mstore(ADD_BN256_INPUT, _a_x)
                mstore(add(ADD_BN256_INPUT, 32), _a_y)
                mstore(add(ADD_BN256_INPUT, 64), _b_x)
                mstore(add(ADD_BN256_INPUT, 96), _b_y)

                let success := call(gas(), 0x06, 0, ADD_BN256_INPUT, 0x80, ADD_BN256_OUTPUT, 0x40)
                switch success
                case 0 {
                    mstore(0x00, BN256_POINTS_ADDITION_ERROR)
                    revert(0x00, 0x04)
                }

                _c_x := mload(ADD_BN256_OUTPUT)
                _c_y := mload(add(ADD_BN256_OUTPUT, 32))
            }

            function add_grumpkin(_a_x, _a_y, _b_x, _b_y) -> _c_x, _c_y {
                mstore(A_X, _a_x)
                mstore(A_Y, _a_y)
                mstore(A_Z, 1)
                mstore(B_X, _b_x)
                mstore(B_Y, _b_y)
                mstore(B_Z, 1)

                if eq(_identity(_a_x, _a_y), 0) {
                    mstore(A_X, 0)
                    mstore(A_Y, 1)
                    mstore(A_Z, 0)
                }

                if eq(_identity(_b_x, _b_y), 0) {
                    mstore(B_X, 0)
                    mstore(B_Y, 1)
                    mstore(B_Z, 0)
                }

                let _c_z := 0

                mstore(T0, mulmod(mload(A_X), mload(B_X), GRUMPKIN_R_MOD))
                mstore(T1, mulmod(mload(A_Y), mload(B_Y), GRUMPKIN_R_MOD))
                mstore(T2, mulmod(mload(A_Z), mload(B_Z), GRUMPKIN_R_MOD))
                mstore(T3, addmod(mload(A_X), mload(A_Y), GRUMPKIN_R_MOD))
                mstore(T4, addmod(mload(B_X), mload(B_Y), GRUMPKIN_R_MOD))
                mstore(T3, mulmod(mload(T3), mload(T4), GRUMPKIN_R_MOD))
                mstore(T4, addmod(mload(T0), mload(T1), GRUMPKIN_R_MOD))
                mstore(T3, addmod(mload(T3), sub(GRUMPKIN_R_MOD, mod(mload(T4), GRUMPKIN_R_MOD)), GRUMPKIN_R_MOD))
                mstore(T4, addmod(mload(A_X), mload(A_Z), GRUMPKIN_R_MOD))
                mstore(T5, addmod(mload(B_X), mload(B_Z), GRUMPKIN_R_MOD))
                mstore(T4, mulmod(mload(T4), mload(T5), GRUMPKIN_R_MOD))
                mstore(T5, addmod(mload(T0), mload(T2), GRUMPKIN_R_MOD))
                mstore(T4, addmod(mload(T4), sub(GRUMPKIN_R_MOD, mod(mload(T5), GRUMPKIN_R_MOD)), GRUMPKIN_R_MOD))
                mstore(T5, addmod(mload(A_Y), mload(A_Z), GRUMPKIN_R_MOD))
                _c_x := addmod(mload(B_Y), mload(B_Z), GRUMPKIN_R_MOD)
                mstore(T5, mulmod(mload(T5), _c_x, GRUMPKIN_R_MOD))
                _c_x := addmod(mload(T1), mload(T2), GRUMPKIN_R_MOD)
                mstore(T5, addmod(mload(T5), sub(GRUMPKIN_R_MOD, mod(_c_x, GRUMPKIN_R_MOD)), GRUMPKIN_R_MOD))
                // skip c_z := A, since constant A = 0 in Grumpkin
                _c_x :=
                    mulmod(mload(T2), 0x30644e72e131a029b85045b68181585d2833e84879b9709143e1f593efffffce, GRUMPKIN_R_MOD) // mul_by_3b
                _c_z := addmod(_c_x, _c_z, GRUMPKIN_R_MOD)
                _c_x := addmod(mload(T1), sub(GRUMPKIN_R_MOD, mod(_c_z, GRUMPKIN_R_MOD)), GRUMPKIN_R_MOD)
                _c_z := addmod(mload(T1), _c_z, GRUMPKIN_R_MOD)
                _c_y := mulmod(_c_x, _c_z, GRUMPKIN_R_MOD)
                mstore(T1, addmod(mload(T0), mload(T0), GRUMPKIN_R_MOD))
                mstore(T1, addmod(mload(T1), mload(T0), GRUMPKIN_R_MOD))
                mstore(T2, 0) // since constant A = 0 in Grumpkin
                mstore(
                    T4,
                    mulmod(
                        mload(T4), 0x30644e72e131a029b85045b68181585d2833e84879b9709143e1f593efffffce, GRUMPKIN_R_MOD
                    )
                ) // mul_by_3b
                mstore(T1, addmod(mload(T1), mload(T2), GRUMPKIN_R_MOD))
                mstore(T2, addmod(mload(T0), sub(GRUMPKIN_R_MOD, mod(mload(T2), GRUMPKIN_R_MOD)), GRUMPKIN_R_MOD))
                mstore(T2, 0) // since constant A = 0 in Grumpkin
                mstore(T4, addmod(mload(T4), mload(T2), GRUMPKIN_R_MOD))
                mstore(T0, mulmod(mload(T1), mload(T4), GRUMPKIN_R_MOD))
                _c_y := addmod(_c_y, mload(T0), GRUMPKIN_R_MOD)
                mstore(T0, mulmod(mload(T5), mload(T4), GRUMPKIN_R_MOD))
                _c_x := mulmod(mload(T3), _c_x, GRUMPKIN_R_MOD)
                _c_x := addmod(_c_x, sub(GRUMPKIN_R_MOD, mod(mload(T0), GRUMPKIN_R_MOD)), GRUMPKIN_R_MOD)
                mstore(T0, mulmod(mload(T3), mload(T1), GRUMPKIN_R_MOD))
                _c_z := mulmod(mload(T5), _c_z, GRUMPKIN_R_MOD)
                _c_z := addmod(_c_z, mload(T0), GRUMPKIN_R_MOD)

                switch and(and(eq(_c_x, 0), eq(_c_y, 1)), eq(_c_z, 0))
                case 1 {
                    _c_x := 0
                    _c_y := 0
                }
                default { _c_x, _c_y := to_affine(_c_x, _c_y, _c_z, GRUMPKIN_R_MOD) }
            }

            function scalar_mul_bn256(_a_x, _a_y, _scalar) -> _c_x, _c_y {
                mstore(SCALAR_MUL_BN256_INPUT, _a_x)
                mstore(add(SCALAR_MUL_BN256_INPUT, 32), _a_y)
                mstore(add(SCALAR_MUL_BN256_INPUT, 64), _scalar)

                let success := call(gas(), 0x07, 0, SCALAR_MUL_BN256_INPUT, 0x60, SCALAR_MUL_BN256_OUTPUT, 0x40)
                switch success
                case 0 {
                    mstore(0x00, BN256_SCALAR_MUL_ERROR)
                    revert(0x00, 0x04)
                }

                _c_x := mload(SCALAR_MUL_BN256_OUTPUT)
                _c_y := mload(add(SCALAR_MUL_BN256_OUTPUT, 32))
            }

            function scalar_mul_grumpkin(_a_x, a_y, _scalar) -> _c_x, _c_y {
                let bitIndex := 0
                for {} lt(bitIndex, 255) {} {
                    _c_x, _c_y := double_grumpkin(_c_x, _c_y)
                    bitIndex := add(bitIndex, 1)

                    if eq(and(shr(sub(255, bitIndex), _scalar), 1), 1) {
                        _c_x, _c_y := add_grumpkin(_c_x, _c_y, _a_x, a_y)
                    }
                }
            }

            if iszero(eq(mload(comm_vec), mload(eval_vec))) {
                mstore(0x00, COMMS_EVALS_SIZE_MISMATCH)
                revert(0x00, 0x04)
            }

            let tmp_x := 0
            let tmp_y := 0
            mstore(C_POWERED, 1)

            e := 0
            c_x := 0
            c_y := 0

            let index := 0
            if eq(p_modulus, GRUMPKIN_P_MOD) {
                for {} lt(index, mload(comm_vec)) {} {
                    e :=
                        addmod(
                            e,
                            mulmod(mload(C_POWERED), mload(add(eval_vec, add(32, mul(32, index)))), GRUMPKIN_P_MOD),
                            GRUMPKIN_P_MOD
                        )

                    tmp_x, tmp_y :=
                        scalar_mul_grumpkin(
                            mload(add(mload(add(comm_vec, 32)), mul(64, index))),
                            mload(add(mload(add(comm_vec, 32)), add(32, mul(64, index)))),
                            mload(C_POWERED)
                        )

                    c_x, c_y := add_grumpkin(tmp_x, tmp_y, c_x, c_y)

                    mstore(C_POWERED, mulmod(mload(C_POWERED), c, GRUMPKIN_P_MOD))
                    index := add(index, 1)
                }
            }

            if eq(p_modulus, BN256_P_MOD) {
                for {} lt(index, mload(comm_vec)) {} {
                    e :=
                        addmod(
                            e,
                            mulmod(mload(C_POWERED), mload(add(eval_vec, add(32, mul(32, index)))), BN256_P_MOD),
                            BN256_P_MOD
                        )

                    tmp_x, tmp_y :=
                        scalar_mul_bn256(
                            mload(add(mload(add(comm_vec, 32)), mul(64, index))),
                            mload(add(mload(add(comm_vec, 32)), add(32, mul(64, index)))),
                            mload(C_POWERED)
                        )

                    c_x, c_y := add_bn256(tmp_x, tmp_y, c_x, c_y)

                    mstore(C_POWERED, mulmod(mload(C_POWERED), c, BN256_P_MOD))
                    index := add(index, 1)
                }
            }
        }
    }

    function testPad() public {
        PolyEvalInstanceLib.PolyEvalInstance[] memory a = new PolyEvalInstanceLib.PolyEvalInstance[](2);

        uint256[] memory x = new uint256[](10);
        for (uint256 i = 0; i < x.length; i++) {
            x[i] = 1;
        }

        a[0] = PolyEvalInstanceLib.PolyEvalInstance(0, 0, x, 0);

        x = new uint256[](20);
        for (uint256 i = 0; i < x.length; i++) {
            x[i] = 1;
        }

        a[1] = PolyEvalInstanceLib.PolyEvalInstance(0, 0, x, 0);

        PolyEvalInstanceLib.PolyEvalInstance[] memory a_padded = PolyEvalInstanceLib.pad(a);

        // they both now have max length
        assertEq(a_padded[0].x.length, 20);
        assertEq(a_padded[1].x.length, 20);

        // first 10 elements of a[0] are padded by zeroes
        for (uint256 i = 0; i < 10; i++) {
            assertEq(a_padded[0].x[i], 0);
        }
        // rest is the same
        for (uint256 i = 10; i < 20; i++) {
            assertEq(a_padded[0].x[i], 1);
        }
    }
}
