// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.16;

import "@std/Test.sol";
import "src/blocks/pasta/Pallas.sol";
import "src/blocks/pasta/Vesta.sol";
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
