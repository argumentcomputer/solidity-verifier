// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.16;

import "@std/Test.sol";
import "src/blocks/PolyEvalInstance.sol";
import "src/blocks/EqPolynomial.sol";
import "src/blocks/pasta/Vesta.sol";
import "src/blocks/pasta/Pallas.sol";
import "src/blocks/KeccakTranscript.sol";
import "src/blocks/Sumcheck.sol";
import "src/NovaVerifierAbstractions.sol";

contract PpSpartanStep7Computations is Test {
    function finalVerification(uint256 left, uint256 right) private pure returns (bool) {
        return left == right;
    }

    function testFinalVerification() public pure {
        uint256 claim_batch_final = 0x03c54cc9b90ea2e26e195ebf06841c63239b4f29f1fe29acf76db79efa88c58c;
        uint256 claim_batch_final_expected = 0x03c54cc9b90ea2e26e195ebf06841c63239b4f29f1fe29acf76db79efa88c58c;

        assert(finalVerification(claim_batch_final, claim_batch_final_expected));
    }

    function load_data_for_claim_batch_final_right()
        public
        pure
        returns (uint256[] memory, PolyEvalInstanceLib.PolyEvalInstance[] memory, uint256[] memory, uint256[] memory)
    {
        uint256[] memory r_z = new uint256[](17);
        r_z[0] = 0x360e45747b7daf1f8673e13ccd8cba6503e39a3a45bee91865f88054c146714c;
        r_z[1] = 0x397603913645a71771f9ab4ee13a556cc89f6f56589e8a221d259787b76aff6c;
        r_z[2] = 0x28d504729547b8996a6b0ad01edb0df72db32f8df1a0a0723274ff4e70d60a2f;
        r_z[3] = 0x01b98f014abbd3c04fc2da7a9122b850f0f38080e331d60f481de13862154543;
        r_z[4] = 0x3e3c0515fad7a1ed2b2e497533b21c9c60bd24c5da116ad1e855be99b9892902;
        r_z[5] = 0x284ec30ee4bc16000e33824f2ee9799d785049a2cdeb51204aa52f24e863427f;
        r_z[6] = 0x1d105833755841cfbf294fbd63bcb347fdca5fa98f5b5bd7459f117ec67173e8;
        r_z[7] = 0x2645a676f3e73e7a3199b10eb836b618a151456b7a1d5a0783c142418be2220b;
        r_z[8] = 0x32aba40d95f78a365e91c57c703aadd3a46723c3540b63dca4cafba9ceafb7ed;
        r_z[9] = 0x0344d7957d1dbc6da5507c2bfd5cdb6d20afdcf10fd8a069f78bd399e0ce06c6;
        r_z[10] = 0x263ea44c652a27c26b7b05be033da52d626fe7d2050b4384ff5e8de6aee0a339;
        r_z[11] = 0x1a8678712b4d32fae0a9de9be1684b80e6376ad5ae326b90f04ab91f58302085;
        r_z[12] = 0x39beeb3c7fd00ec376d94aec13ae2306f48fb5e51cdb43f15d0c2256e2f57a39;
        r_z[13] = 0x2e373ddfb55728b667c0a0030247b6e531c707172076086b1a3424f5afabf93c;
        r_z[14] = 0x060ff746a7e39200aa9282d926f4e32f2b04b55fbcd0a923470c1d899b4a030c;
        r_z[15] = 0x0f38719526b1f2a5e1e2c29c6eb7c0ca752087e00a369690f11910f6bece7ba0;
        r_z[16] = 0x12406206573908ce0b646dd32ec85642072f2d306e64a0d737f6b6e9d40e81e0;

        uint256[] memory x = new uint256[](17);
        PolyEvalInstanceLib.PolyEvalInstance[] memory u_vec_padded = new PolyEvalInstanceLib.PolyEvalInstance[](7);

        x = new uint256[](17);
        x[0] = 0x15f5e9f471c313af5c8190c109c3a1fe9cee73d035bcd08a204898e795d8e497;
        x[1] = 0x026bc743ada824501ac59409a022aeaba83ebe9c6fe153969c47d3dbcba1be20;
        x[2] = 0x0235a660a3f8c7aa923e90ef914634b078bec35cd1b1ed8d763735655f16c86b;
        x[3] = 0x06b9cd3880fe5f9881f9fd2b0f15eaa134f0271faa129290886932018371f6a4;
        x[4] = 0x369f08f9d3a1b649e724e2ded5d88ae935ee5128bfc966a33b09fd298ce1f4f9;
        x[5] = 0x17c2194712668c76ac2ac0d4ddc7ae50995905fa689a153b3a46b539a40a0cb8;
        x[6] = 0x0416682dc67529249a90de425db7b2f08a44eefa18ff9a42dae68dd77e001d23;
        x[7] = 0x08414bd36fb4ec48989f9922cd0fa9ab1e1414d9bc3e7be4dd87166124351a6c;
        x[8] = 0x3714b73daef1dd873e79a9b670c7f403a506aaec54666f2a9daa8805ce3fa7df;
        x[9] = 0x3c23643dd2a5d6b64ba3f86d6ea4c347db24e45163421b450b20dc44e502da77;
        x[10] = 0x219bd827a1a9cfcbacb2d66370f8ab9af8449f0e779eeb441b0cc3e46ac24408;
        x[11] = 0x2a99b7d2d92e7ce4b1a5bb9893a58c94525afcc43ca64c9579217d5db1980289;
        x[12] = 0x244902bf184af91659be921be063244f4d9aacf94e19fd121446104850f2b1d9;
        x[13] = 0x1594eeac26b85866f2cf09dea1c5ee8920e8b4bfde8edba325f5e89ac9995ab6;
        x[14] = 0x2e6dee8a44ef6d3058da01d7e90582d1f5d6b2fd8f05eea54540fe77a8444f12;
        x[15] = 0x17798e8f0e66b1d6e1f53871eeaaabb28f680fda97a9ae07eb833be231310035;
        x[16] = 0x2a7e0ec4192134bc0102de30940d4fd26bb0cd60e11f74519f9d9a90bebeaf5f;
        u_vec_padded[0] = PolyEvalInstanceLib.PolyEvalInstance(
            0x27f23d4d7603ec8b206a427a04da21bf3282a95e114447aee4a1ac76e4aacb4d,
            0x209850df39cd098612ab3329da5e21001c81c08b9be94d2bc90833cf7bde14e7,
            x,
            0x2b005e5de5ae62075c66de1c5343c86a235ffc0184fd317079c6687f53596bd4
        );

        x = new uint256[](17);
        x[0] = 0x066b998f211c11d58f5c4ce0eb59a7ba543bdab2c99b5061c097723eb0ed8ff9;
        x[1] = 0x1e525e8eb5732494ab1aebe43df1d2a0150badb04db05681409c612429cea8ac;
        x[2] = 0x317b05d9d1941be2116f250a8aad1932d009cec690d12ef463fe64c5efadc978;
        x[3] = 0x13493a5dc4e2513470e1749fdb37b41e3836364d77d7eb8b5a81b985bfe7333a;
        x[4] = 0x05499a9b11713b3371978cf62676fc88bbd1784df341575d88c183fe7d2baec2;
        x[5] = 0x304fd43c6453b62cfe98bc726e458208edf3754b58a1b96b48baedb08dc231b6;
        x[6] = 0x2d5ce24c1355a2428de1d5411ecebd98b1328b5b6f87dcc9ecb573252d6cf30d;
        x[7] = 0x2d6762046fc5ca62b436c758321b1844ac5cf096e30085cb81ddd076138d7163;
        x[8] = 0x3ec3a1be092aa81390fb585c46fd3774b20febd739904f20c99ab2c9d0f3ef46;
        x[9] = 0x382b206460e5706009787007b6e484e80423783762ebac703d3cbb9c2615e7b2;
        x[10] = 0x1c9118d02c7792a8728fa7a879687962ae5a1b5aa9942420d239ada6cef57149;
        x[11] = 0x39672312a3af1dadc7dd77703cef7487ae0f27634ce37faba6e81f0b7eae3d25;
        x[12] = 0x0ec9a8b069eed91e089a03c0f47615fe04742b8c1159a10dde4129b71fc65687;
        x[13] = 0x3998456c5125913b2489869938b5b0d98e7f5c87327af98b9dc619fe54fd26c1;
        x[14] = 0x08a01a276934627dad600b53978bd5d64de6090ecb2bef2b73c3d6e346e5c096;
        x[15] = 0x394edaa7014bdeed61ad362a7d9ec5877ad82777dd131489152c96b848a05d78;
        x[16] = 0x0ede18a94d3bdf5f9ee7a7ae19c34315d98847bc4086c9d81f5264b1e127ec78;

        u_vec_padded[1] = PolyEvalInstanceLib.PolyEvalInstance(
            0x0515cf0297f7c59bf3c1f7907ebf8b65819a29d97d041e14e0d9169b4a927274,
            0x3aba6d837219f6260d1fd5983b9aba80c730e853aac36e0b4636cc1163a0bab2,
            x,
            0x129dc2a992af808d8530bb9d4c72b3c51694d532906fa0f903ca4bf4f0b7fe22
        );

        x = new uint256[](17);
        x[0] = 0x0000000000000000000000000000000000000000000000000000000000000001;
        x[1] = 0x0000000000000000000000000000000000000000000000000000000000000001;
        x[2] = 0x0000000000000000000000000000000000000000000000000000000000000001;
        x[3] = 0x0000000000000000000000000000000000000000000000000000000000000001;
        x[4] = 0x0000000000000000000000000000000000000000000000000000000000000001;
        x[5] = 0x0000000000000000000000000000000000000000000000000000000000000001;
        x[6] = 0x0000000000000000000000000000000000000000000000000000000000000001;
        x[7] = 0x0000000000000000000000000000000000000000000000000000000000000001;
        x[8] = 0x0000000000000000000000000000000000000000000000000000000000000001;
        x[9] = 0x0000000000000000000000000000000000000000000000000000000000000001;
        x[10] = 0x0000000000000000000000000000000000000000000000000000000000000001;
        x[11] = 0x0000000000000000000000000000000000000000000000000000000000000001;
        x[12] = 0x0000000000000000000000000000000000000000000000000000000000000001;
        x[13] = 0x0000000000000000000000000000000000000000000000000000000000000001;
        x[14] = 0x0000000000000000000000000000000000000000000000000000000000000001;
        x[15] = 0x0000000000000000000000000000000000000000000000000000000000000001;
        x[16] = 0x0000000000000000000000000000000000000000000000000000000000000000;

        u_vec_padded[2] = PolyEvalInstanceLib.PolyEvalInstance(
            0x0515cf0297f7c59bf3c1f7907ebf8b65819a29d97d041e14e0d9169b4a927274,
            0x3aba6d837219f6260d1fd5983b9aba80c730e853aac36e0b4636cc1163a0bab2,
            x,
            0x398befc342d12138f515ffc7ab7cab11ca2788e21e99f0e2f48b8c10b89e9dab
        );

        x = new uint256[](17);
        x[0] = 0x1e525e8eb5732494ab1aebe43df1d2a0150badb04db05681409c612429cea8ac;
        x[1] = 0x317b05d9d1941be2116f250a8aad1932d009cec690d12ef463fe64c5efadc978;
        x[2] = 0x13493a5dc4e2513470e1749fdb37b41e3836364d77d7eb8b5a81b985bfe7333a;
        x[3] = 0x05499a9b11713b3371978cf62676fc88bbd1784df341575d88c183fe7d2baec2;
        x[4] = 0x304fd43c6453b62cfe98bc726e458208edf3754b58a1b96b48baedb08dc231b6;
        x[5] = 0x2d5ce24c1355a2428de1d5411ecebd98b1328b5b6f87dcc9ecb573252d6cf30d;
        x[6] = 0x2d6762046fc5ca62b436c758321b1844ac5cf096e30085cb81ddd076138d7163;
        x[7] = 0x3ec3a1be092aa81390fb585c46fd3774b20febd739904f20c99ab2c9d0f3ef46;
        x[8] = 0x382b206460e5706009787007b6e484e80423783762ebac703d3cbb9c2615e7b2;
        x[9] = 0x1c9118d02c7792a8728fa7a879687962ae5a1b5aa9942420d239ada6cef57149;
        x[10] = 0x39672312a3af1dadc7dd77703cef7487ae0f27634ce37faba6e81f0b7eae3d25;
        x[11] = 0x0ec9a8b069eed91e089a03c0f47615fe04742b8c1159a10dde4129b71fc65687;
        x[12] = 0x3998456c5125913b2489869938b5b0d98e7f5c87327af98b9dc619fe54fd26c1;
        x[13] = 0x08a01a276934627dad600b53978bd5d64de6090ecb2bef2b73c3d6e346e5c096;
        x[14] = 0x394edaa7014bdeed61ad362a7d9ec5877ad82777dd131489152c96b848a05d78;
        x[15] = 0x0ede18a94d3bdf5f9ee7a7ae19c34315d98847bc4086c9d81f5264b1e127ec78;
        x[16] = 0x1741b54a11d0633c0349b0e317ced512a59ef40b772fbe94415e42af34a25c99;

        u_vec_padded[3] = PolyEvalInstanceLib.PolyEvalInstance(
            0x0515cf0297f7c59bf3c1f7907ebf8b65819a29d97d041e14e0d9169b4a927274,
            0x3aba6d837219f6260d1fd5983b9aba80c730e853aac36e0b4636cc1163a0bab2,
            x,
            0x14ad3f45a2143b4c46c99cc3580551ca2d0349f3502eabaddf04aade50ad55e5
        );

        x = new uint256[](17);
        x[0] = 0x1e525e8eb5732494ab1aebe43df1d2a0150badb04db05681409c612429cea8ac;
        x[1] = 0x317b05d9d1941be2116f250a8aad1932d009cec690d12ef463fe64c5efadc978;
        x[2] = 0x13493a5dc4e2513470e1749fdb37b41e3836364d77d7eb8b5a81b985bfe7333a;
        x[3] = 0x05499a9b11713b3371978cf62676fc88bbd1784df341575d88c183fe7d2baec2;
        x[4] = 0x304fd43c6453b62cfe98bc726e458208edf3754b58a1b96b48baedb08dc231b6;
        x[5] = 0x2d5ce24c1355a2428de1d5411ecebd98b1328b5b6f87dcc9ecb573252d6cf30d;
        x[6] = 0x2d6762046fc5ca62b436c758321b1844ac5cf096e30085cb81ddd076138d7163;
        x[7] = 0x3ec3a1be092aa81390fb585c46fd3774b20febd739904f20c99ab2c9d0f3ef46;
        x[8] = 0x382b206460e5706009787007b6e484e80423783762ebac703d3cbb9c2615e7b2;
        x[9] = 0x1c9118d02c7792a8728fa7a879687962ae5a1b5aa9942420d239ada6cef57149;
        x[10] = 0x39672312a3af1dadc7dd77703cef7487ae0f27634ce37faba6e81f0b7eae3d25;
        x[11] = 0x0ec9a8b069eed91e089a03c0f47615fe04742b8c1159a10dde4129b71fc65687;
        x[12] = 0x3998456c5125913b2489869938b5b0d98e7f5c87327af98b9dc619fe54fd26c1;
        x[13] = 0x08a01a276934627dad600b53978bd5d64de6090ecb2bef2b73c3d6e346e5c096;
        x[14] = 0x394edaa7014bdeed61ad362a7d9ec5877ad82777dd131489152c96b848a05d78;
        x[15] = 0x0ede18a94d3bdf5f9ee7a7ae19c34315d98847bc4086c9d81f5264b1e127ec78;
        x[16] = 0x1741b54a11d0633c0349b0e317ced512a59ef40b772fbe94415e42af34a25c99;

        u_vec_padded[4] = PolyEvalInstanceLib.PolyEvalInstance(
            0x0fa6f8f2ed2c476ea93e0571b09d389c2534bd7075d201d174c413ddcb3d909d,
            0x06dbbac77d49d6f4dbab8cc4760907d371c0f7fb2a053bdb71b8c6ca8443e3c4,
            x,
            0x155a87c951e6c2f8c604d69a840e2b822236824525ac2f59b0bae47996ec86ab
        );

        x = new uint256[](17);
        x[0] = 0x0000000000000000000000000000000000000000000000000000000000000000;
        x[1] = 0x0000000000000000000000000000000000000000000000000000000000000000;
        x[2] = 0x0000000000000000000000000000000000000000000000000000000000000000;
        x[3] = 0x05499a9b11713b3371978cf62676fc88bbd1784df341575d88c183fe7d2baec2;
        x[4] = 0x304fd43c6453b62cfe98bc726e458208edf3754b58a1b96b48baedb08dc231b6;
        x[5] = 0x2d5ce24c1355a2428de1d5411ecebd98b1328b5b6f87dcc9ecb573252d6cf30d;
        x[6] = 0x2d6762046fc5ca62b436c758321b1844ac5cf096e30085cb81ddd076138d7163;
        x[7] = 0x3ec3a1be092aa81390fb585c46fd3774b20febd739904f20c99ab2c9d0f3ef46;
        x[8] = 0x382b206460e5706009787007b6e484e80423783762ebac703d3cbb9c2615e7b2;
        x[9] = 0x1c9118d02c7792a8728fa7a879687962ae5a1b5aa9942420d239ada6cef57149;
        x[10] = 0x39672312a3af1dadc7dd77703cef7487ae0f27634ce37faba6e81f0b7eae3d25;
        x[11] = 0x0ec9a8b069eed91e089a03c0f47615fe04742b8c1159a10dde4129b71fc65687;
        x[12] = 0x3998456c5125913b2489869938b5b0d98e7f5c87327af98b9dc619fe54fd26c1;
        x[13] = 0x08a01a276934627dad600b53978bd5d64de6090ecb2bef2b73c3d6e346e5c096;
        x[14] = 0x394edaa7014bdeed61ad362a7d9ec5877ad82777dd131489152c96b848a05d78;
        x[15] = 0x0ede18a94d3bdf5f9ee7a7ae19c34315d98847bc4086c9d81f5264b1e127ec78;
        x[16] = 0x1741b54a11d0633c0349b0e317ced512a59ef40b772fbe94415e42af34a25c99;

        u_vec_padded[5] = PolyEvalInstanceLib.PolyEvalInstance(
            0x20b8f422ff4d669f6c21a872547e6cc1f456c814128f0cec5ae8c1041308633f,
            0x1c99056155380248020b612dba4012faaebe3b37d695b46d1dd77e5ed6afdbf6,
            x,
            0x17938b6eba9ed44f2cc8f93d2b529b20c957e8f6e3a043300e304930614b564e
        );

        x = new uint256[](17);
        x[0] = 0x066b998f211c11d58f5c4ce0eb59a7ba543bdab2c99b5061c097723eb0ed8ff9;
        x[1] = 0x1e525e8eb5732494ab1aebe43df1d2a0150badb04db05681409c612429cea8ac;
        x[2] = 0x317b05d9d1941be2116f250a8aad1932d009cec690d12ef463fe64c5efadc978;
        x[3] = 0x13493a5dc4e2513470e1749fdb37b41e3836364d77d7eb8b5a81b985bfe7333a;
        x[4] = 0x05499a9b11713b3371978cf62676fc88bbd1784df341575d88c183fe7d2baec2;
        x[5] = 0x304fd43c6453b62cfe98bc726e458208edf3754b58a1b96b48baedb08dc231b6;
        x[6] = 0x2d5ce24c1355a2428de1d5411ecebd98b1328b5b6f87dcc9ecb573252d6cf30d;
        x[7] = 0x2d6762046fc5ca62b436c758321b1844ac5cf096e30085cb81ddd076138d7163;
        x[8] = 0x3ec3a1be092aa81390fb585c46fd3774b20febd739904f20c99ab2c9d0f3ef46;
        x[9] = 0x382b206460e5706009787007b6e484e80423783762ebac703d3cbb9c2615e7b2;
        x[10] = 0x1c9118d02c7792a8728fa7a879687962ae5a1b5aa9942420d239ada6cef57149;
        x[11] = 0x39672312a3af1dadc7dd77703cef7487ae0f27634ce37faba6e81f0b7eae3d25;
        x[12] = 0x0ec9a8b069eed91e089a03c0f47615fe04742b8c1159a10dde4129b71fc65687;
        x[13] = 0x3998456c5125913b2489869938b5b0d98e7f5c87327af98b9dc619fe54fd26c1;
        x[14] = 0x08a01a276934627dad600b53978bd5d64de6090ecb2bef2b73c3d6e346e5c096;
        x[15] = 0x394edaa7014bdeed61ad362a7d9ec5877ad82777dd131489152c96b848a05d78;
        x[16] = 0x0ede18a94d3bdf5f9ee7a7ae19c34315d98847bc4086c9d81f5264b1e127ec78;

        u_vec_padded[6] = PolyEvalInstanceLib.PolyEvalInstance(
            0x109c41eb278e0a4b727cc12a218151042f08696f70136c9ef935fcca7be561ac,
            0x1ab3acc2bdaceca93d7be63a6519f9dd9598fa7241038d3b61b7d932e6b5497f,
            x,
            0x3c09f5dab41d63e613e02db417c19923e6a8e487b3acc95a30b7865e293fb002
        );

        uint256[] memory self_evals_batch_arr = new uint256[](7);
        self_evals_batch_arr[0] = 0x03b628b210342d6a82d8cd5ba4514c69b6b6f02860aacb44d0aae064b189bcb0;
        self_evals_batch_arr[1] = 0x05f2403ddae738105256cc07d24b4bc5bd924375988029e7228a7d3bbc77a877;
        self_evals_batch_arr[2] = 0x05f2403ddae738105256cc07d24b4bc5bd924375988029e7228a7d3bbc77a877;
        self_evals_batch_arr[3] = 0x05f2403ddae738105256cc07d24b4bc5bd924375988029e7228a7d3bbc77a877;
        self_evals_batch_arr[4] = 0x0a8d508206c30d57feb08d7e7d6498826d25b1947912f0331f23b61c6182bd63;
        self_evals_batch_arr[5] = 0x2af49f28df5809c9c71289be9a562494a3856d51f866a6d9fe8100d0c2cb5122;
        self_evals_batch_arr[6] = 0x1e1c0aec3f969e00241291670714a59491af1ee9268554a113c3b31f8b06b685;

        uint256[] memory powers_of_rho = new uint256[](7);
        powers_of_rho[0] = 0x0000000000000000000000000000000000000000000000000000000000000001;
        powers_of_rho[1] = 0x05c4163df6bb178cdf253644914336ac52e20ffa4eefe1baf2fef386f519c1ca;
        powers_of_rho[2] = 0x0d55aaa27f3a08125b8d79e704aa224cbcb9bb61888275dd6507d06c99cddb20;
        powers_of_rho[3] = 0x16e9d5ded9cc2e912562f764ff4fe42d597fe7cfc655f8b300613eb388d0b75e;
        powers_of_rho[4] = 0x32a47fe3ae5f4ccc7360025a258f66d707002f74a73f7c2c41cb2cc330b777b6;
        powers_of_rho[5] = 0x25574d92788bb846a8991a9744c2f3f0b809ccde8dc4eb6cb80698514f1dd277;
        powers_of_rho[6] = 0x124d16c79c168c9b89dd74cfd7fa3b94af20272fbf7fed786c4a09947e485754;

        return (r_z, u_vec_padded, self_evals_batch_arr, powers_of_rho);
    }

    function compute_claim_batch_final_right(
        uint256[] memory r_z,
        PolyEvalInstanceLib.PolyEvalInstance[] memory u_vec_padded,
        uint256[] memory self_evals_batch_arr,
        uint256[] memory powers_of_rho,
        uint256 modulus,
        function (uint256) returns (uint256) negateBase
    ) private returns (uint256) {
        require(u_vec_padded.length == self_evals_batch_arr.length);
        require(powers_of_rho.length == self_evals_batch_arr.length);

        uint256[] memory evals = new uint256[](u_vec_padded.length);
        uint256 index = 0;
        for (index = 0; index < u_vec_padded.length; index++) {
            evals[index] = EqPolinomialLib.evaluate(r_z, u_vec_padded[index].x, modulus, negateBase);
        }

        uint256 result;
        uint256 e_i;
        uint256 p_i;
        uint256 rho_i;
        for (index = 0; index < evals.length; index++) {
            e_i = evals[index];
            p_i = self_evals_batch_arr[index];
            rho_i = powers_of_rho[index];
            assembly {
                e_i := mulmod(e_i, p_i, modulus)
                e_i := mulmod(e_i, rho_i, modulus)
                result := addmod(e_i, result, modulus)
            }
        }
        return result;
    }

    function test_compute_claim_batch_final_right() public {
        uint256 expected = 0x03c54cc9b90ea2e26e195ebf06841c63239b4f29f1fe29acf76db79efa88c58c;

        uint256[] memory r_z;
        PolyEvalInstanceLib.PolyEvalInstance[] memory u_vec_padded;
        uint256[] memory self_evals_batch_arr;
        uint256[] memory powers_of_rho;
        (r_z, u_vec_padded, self_evals_batch_arr, powers_of_rho) = load_data_for_claim_batch_final_right();

        uint256 actual = compute_claim_batch_final_right(
            r_z, u_vec_padded, self_evals_batch_arr, powers_of_rho, Vesta.P_MOD, Vesta.negateBase
        );

        assertEq(actual, expected);
    }

    function loadTranscriptSumcheckComputation() private pure returns (KeccakTranscriptLib.KeccakTranscript memory) {
        uint16 rounds = 60;
        uint8[] memory state = new uint8[](64);
        state[0] = 0xea;
        state[1] = 0xdd;
        state[2] = 0xd1;
        state[3] = 0xfe;
        state[4] = 0x95;
        state[5] = 0x79;
        state[6] = 0x69;
        state[7] = 0x6e;
        state[8] = 0xb3;
        state[9] = 0x02;
        state[10] = 0xf1;
        state[11] = 0xac;
        state[12] = 0xda;
        state[13] = 0x39;
        state[14] = 0xf8;
        state[15] = 0xfd;
        state[16] = 0x6e;
        state[17] = 0xa6;
        state[18] = 0xa5;
        state[19] = 0x36;
        state[20] = 0x12;
        state[21] = 0xec;
        state[22] = 0x5a;
        state[23] = 0x81;
        state[24] = 0x09;
        state[25] = 0x3c;
        state[26] = 0x33;
        state[27] = 0x83;
        state[28] = 0x89;
        state[29] = 0xe9;
        state[30] = 0xf8;
        state[31] = 0x10;
        state[32] = 0xd5;
        state[33] = 0x81;
        state[34] = 0xc5;
        state[35] = 0xe5;
        state[36] = 0xd7;
        state[37] = 0x03;
        state[38] = 0xea;
        state[39] = 0x2b;
        state[40] = 0x3c;
        state[41] = 0x15;
        state[42] = 0xd9;
        state[43] = 0x84;
        state[44] = 0x3f;
        state[45] = 0xdb;
        state[46] = 0xd6;
        state[47] = 0x56;
        state[48] = 0x9d;
        state[49] = 0xb2;
        state[50] = 0x94;
        state[51] = 0x2c;
        state[52] = 0x97;
        state[53] = 0xe1;
        state[54] = 0xf4;
        state[55] = 0x5c;
        state[56] = 0xa5;
        state[57] = 0xb4;
        state[58] = 0x07;
        state[59] = 0x28;
        state[60] = 0x9c;
        state[61] = 0x34;
        state[62] = 0x79;
        state[63] = 0xa6;

        uint8[] memory transcript = new uint8[](0);

        return KeccakTranscriptLib.KeccakTranscript(rounds, state, transcript);
    }

    function loadSumcheckProof() private pure returns (PolyLib.SumcheckProof memory) {
        PolyLib.CompressedUniPoly[] memory polys = new PolyLib.CompressedUniPoly[](17);

        uint256[] memory poly = new uint256[](2);
        poly[0] = 0x243107521a53a96fed2883902626ea41fd0abe99ddb536cc9d7f1a8048849194;
        poly[1] = 0x2ebb06123e87c75049edbc0f961da709762426abc5c1ae42b35c2aee2cc93b2c;
        polys[0] = PolyLib.CompressedUniPoly(poly);

        poly = new uint256[](2);
        poly[0] = 0x1c8f2a2ec6b66f35b65e65122e5b0c637e0d808f9ff627028fd8c2109f02c100;
        poly[1] = 0x23262edf7ec93b9c7c7945f315e79e0e786b0322d63585cbc171e639887664ce;

        polys[1] = PolyLib.CompressedUniPoly(poly);

        poly = new uint256[](2);
        poly[0] = 0x2b75cf7b3715d7d6e53e38e595697b4663bcb2c823a777b353f304c38ade4a6a;
        poly[1] = 0x11421c251bdbcccc7f2fd1d8628c8a864f9e56c779acb51bbb720a273d65ef7e;

        polys[2] = PolyLib.CompressedUniPoly(poly);

        poly = new uint256[](2);
        poly[0] = 0x3804bc557f1e81843bee36a6e9084eee17825fa8833f358a229e03063104c5da;
        poly[1] = 0x1b981e3e8986d7bc6d0d1d84c64b059264dddbf6f8a32bc0790795cd78cc8d9c;

        polys[3] = PolyLib.CompressedUniPoly(poly);

        poly = new uint256[](2);
        poly[0] = 0x385226b371c63f77b6ecfe9a019cc17fdc4f05d15a1e105580211a7c16b65448;
        poly[1] = 0x14a0e942b853825a2c3b702e4af08168b8d8002a87d0aa5dbc518ba8f46b0f71;

        polys[4] = PolyLib.CompressedUniPoly(poly);

        poly = new uint256[](2);
        poly[0] = 0x0a5ae6490635cb30ce096cfc45acc28a31530e63a1a4275696a7f88365360fd0;
        poly[1] = 0x096a8f0b7ae559d9d96bba334d54ad4ea7b60c97cb0d9f0cfbe0daa6ce2c4457;

        polys[5] = PolyLib.CompressedUniPoly(poly);

        poly = new uint256[](2);
        poly[0] = 0x13b1985b67c46d093196f554d07124af3eec8b35ffec474f78f0c124052b3de6;
        poly[1] = 0x210c315789af500941f62318add9cc59dde9b35dc5fba7ddc0ec7024567d02bf;

        polys[6] = PolyLib.CompressedUniPoly(poly);

        poly = new uint256[](2);
        poly[0] = 0x1f5c6772d5eb80d51d0bfa3f74f08f8dd565d3e9c963be734f8ec18458dad3b7;
        poly[1] = 0x1b76a0833b4598506331907125fa05f26190ac6820ac22a2c30a466c08cd2cdd;

        polys[7] = PolyLib.CompressedUniPoly(poly);

        poly = new uint256[](2);
        poly[0] = 0x1aa484b678d2b3d649559666e7b7fe18b64da33ea430d04a2c2171d85e984035;
        poly[1] = 0x2fcb862d5ae1bda1284066d656ac7bbfdbdf97becf9895380c4f6d5f42038690;

        polys[8] = PolyLib.CompressedUniPoly(poly);

        poly = new uint256[](2);
        poly[0] = 0x18ed73ba7ae2273258ac3933a0475cb65fe61eb71040fd0161eeadadb7e9d323;
        poly[1] = 0x1e869fab5cbe242b6230331adf49e6013561f7c364262cd176f08c3c8fd7f11a;

        polys[9] = PolyLib.CompressedUniPoly(poly);

        poly = new uint256[](2);
        poly[0] = 0x28e08c76107bbb51cc122409aa4a12dfc9cf042d822a703c1c55284b894f14f9;
        poly[1] = 0x3c4250ff109ffd75ce61bf9fefee5cb2d92a77cdd731eb73c07b9120e7f67a61;

        polys[10] = PolyLib.CompressedUniPoly(poly);

        poly = new uint256[](2);
        poly[0] = 0x0c1dcee2f313eda0f60ee713be339a5933862b88b88d3d896462a9ea129b6362;
        poly[1] = 0x25256d20b46183d8acf9c2a169b6a1d4ac5e8bfae37eed17828c6de3feb6686c;

        polys[11] = PolyLib.CompressedUniPoly(poly);

        poly = new uint256[](2);
        poly[0] = 0x086226c7c23422f40d6747d2d402eb6a52792582a5ebc38ac6fb10db1720fc06;
        poly[1] = 0x30898dc18254624ac23ed613bb1e6a4d9bcbaacbecd0de9eb4c076c94b27f8bb;

        polys[12] = PolyLib.CompressedUniPoly(poly);

        poly = new uint256[](2);
        poly[0] = 0x33823358918a57fa0176c9bdd70bb08e3ce5d2d012152d8c5e3534afc128b600;
        poly[1] = 0x3dc0ed8a0ef0736637db12b541bb64e6f5124e1380dbf60fc1a81e081ee42b27;

        polys[13] = PolyLib.CompressedUniPoly(poly);

        poly = new uint256[](2);
        poly[0] = 0x2e1bf02931594ab24760649e810e16aa268c7de4251e7f812f22cb238e9daccd;
        poly[1] = 0x149a5e2a18e241ae7579f1225141ac96262253a0e621628d76afe3a35a4e8daf;

        polys[14] = PolyLib.CompressedUniPoly(poly);

        poly = new uint256[](2);
        poly[0] = 0x38f40fdfecb16fb3f212e90921ad01f3fc00470079d3432866480c4afa5eb830;
        poly[1] = 0x28525ddd56e3ec65bb031107784b40806546ed2db39b0a4a8b047f42f34da580;

        polys[15] = PolyLib.CompressedUniPoly(poly);

        poly = new uint256[](2);
        poly[0] = 0x16764bc7333bfd10a55b6c9776e1ef8ee96bb389c364780c8a0fb5af93629b54;
        poly[1] = 0x26b17d78497f90443a4d370d37d3c061714f037787eb9430f2daa49c306180c0;

        polys[16] = PolyLib.CompressedUniPoly(poly);

        return PolyLib.SumcheckProof(polys);
    }

    function test_compute_claim_batch_final_left() public {
        KeccakTranscriptLib.KeccakTranscript memory transcript = loadTranscriptSumcheckComputation();
        uint256 claim_batch_joint = 0x00e9c130b0bf24ada9d20e31a28770e83e03e1a5d22b6241c14ff820169c008e;
        uint256 num_rounds_z = 17;
        uint256 degreeBound = 2;

        PolyLib.SumcheckProof memory sumcheckProof = loadSumcheckProof();

        uint256 claim_batch_final_left;
        uint256[] memory r_z_actual;
        (claim_batch_final_left, r_z_actual, transcript) =
            PrimarySumcheck.verify(sumcheckProof, claim_batch_joint, num_rounds_z, degreeBound, transcript);

        uint256 expected = 0x03c54cc9b90ea2e26e195ebf06841c63239b4f29f1fe29acf76db79efa88c58c;
        assertEq(claim_batch_final_left, expected);

        uint256[] memory r_z = new uint256[](17);
        r_z[0] = 0x360e45747b7daf1f8673e13ccd8cba6503e39a3a45bee91865f88054c146714c;
        r_z[1] = 0x397603913645a71771f9ab4ee13a556cc89f6f56589e8a221d259787b76aff6c;
        r_z[2] = 0x28d504729547b8996a6b0ad01edb0df72db32f8df1a0a0723274ff4e70d60a2f;
        r_z[3] = 0x01b98f014abbd3c04fc2da7a9122b850f0f38080e331d60f481de13862154543;
        r_z[4] = 0x3e3c0515fad7a1ed2b2e497533b21c9c60bd24c5da116ad1e855be99b9892902;
        r_z[5] = 0x284ec30ee4bc16000e33824f2ee9799d785049a2cdeb51204aa52f24e863427f;
        r_z[6] = 0x1d105833755841cfbf294fbd63bcb347fdca5fa98f5b5bd7459f117ec67173e8;
        r_z[7] = 0x2645a676f3e73e7a3199b10eb836b618a151456b7a1d5a0783c142418be2220b;
        r_z[8] = 0x32aba40d95f78a365e91c57c703aadd3a46723c3540b63dca4cafba9ceafb7ed;
        r_z[9] = 0x0344d7957d1dbc6da5507c2bfd5cdb6d20afdcf10fd8a069f78bd399e0ce06c6;
        r_z[10] = 0x263ea44c652a27c26b7b05be033da52d626fe7d2050b4384ff5e8de6aee0a339;
        r_z[11] = 0x1a8678712b4d32fae0a9de9be1684b80e6376ad5ae326b90f04ab91f58302085;
        r_z[12] = 0x39beeb3c7fd00ec376d94aec13ae2306f48fb5e51cdb43f15d0c2256e2f57a39;
        r_z[13] = 0x2e373ddfb55728b667c0a0030247b6e531c707172076086b1a3424f5afabf93c;
        r_z[14] = 0x060ff746a7e39200aa9282d926f4e32f2b04b55fbcd0a923470c1d899b4a030c;
        r_z[15] = 0x0f38719526b1f2a5e1e2c29c6eb7c0ca752087e00a369690f11910f6bece7ba0;
        r_z[16] = 0x12406206573908ce0b646dd32ec85642072f2d306e64a0d737f6b6e9d40e81e0;

        assertEq(r_z.length, r_z_actual.length);
        for (uint256 index = 0; index < r_z.length; index++) {
            assertEq(r_z[index], r_z_actual[index]);
        }
    }

    function loadTranscriptCComputation() private pure returns (KeccakTranscriptLib.KeccakTranscript memory) {
        uint16 rounds = 58;
        uint8[] memory state = new uint8[](64);
        state[0] = 0x17;
        state[1] = 0x1b;
        state[2] = 0x55;
        state[3] = 0x6c;
        state[4] = 0x46;
        state[5] = 0x43;
        state[6] = 0x2b;
        state[7] = 0xe4;
        state[8] = 0x1b;
        state[9] = 0x97;
        state[10] = 0x0d;
        state[11] = 0x2e;
        state[12] = 0x56;
        state[13] = 0x0f;
        state[14] = 0xf9;
        state[15] = 0x4f;
        state[16] = 0x78;
        state[17] = 0x30;
        state[18] = 0xca;
        state[19] = 0xc0;
        state[20] = 0x2f;
        state[21] = 0xc6;
        state[22] = 0x93;
        state[23] = 0xda;
        state[24] = 0x15;
        state[25] = 0x23;
        state[26] = 0x08;
        state[27] = 0x7c;
        state[28] = 0x6e;
        state[29] = 0xac;
        state[30] = 0xe6;
        state[31] = 0xd8;
        state[32] = 0x57;
        state[33] = 0x3f;
        state[34] = 0x96;
        state[35] = 0x5d;
        state[36] = 0x92;
        state[37] = 0x8c;
        state[38] = 0xa5;
        state[39] = 0xde;
        state[40] = 0xfc;
        state[41] = 0x15;
        state[42] = 0x74;
        state[43] = 0x19;
        state[44] = 0x5b;
        state[45] = 0x9b;
        state[46] = 0xe2;
        state[47] = 0x7c;
        state[48] = 0xf5;
        state[49] = 0x87;
        state[50] = 0x86;
        state[51] = 0x31;
        state[52] = 0xff;
        state[53] = 0xa5;
        state[54] = 0xe2;
        state[55] = 0xe1;
        state[56] = 0x29;
        state[57] = 0xd2;
        state[58] = 0x8e;
        state[59] = 0x6e;
        state[60] = 0xea;
        state[61] = 0x6c;
        state[62] = 0x37;
        state[63] = 0x44;

        uint8[] memory transcript = new uint8[](0);

        return KeccakTranscriptLib.KeccakTranscript(rounds, state, transcript);
    }

    function compute_c(KeccakTranscriptLib.KeccakTranscript memory transcript, uint256[] memory eval_vec)
        private
        pure
        returns (KeccakTranscriptLib.KeccakTranscript memory, uint256)
    {
        uint8[] memory label = new uint8[](1);
        label[0] = 0x65; // Rust's b"e"

        transcript = KeccakTranscriptLib.absorb(transcript, label, eval_vec);

        label[0] = 0x63; // Rust's b"c"

        uint256 c;
        (transcript, c) = KeccakTranscriptLib.squeeze(transcript, ScalarFromUniformLib.curveVesta(), label);

        return (transcript, c);
    }

    function compute_rho(KeccakTranscriptLib.KeccakTranscript memory transcript)
        private
        pure
        returns (KeccakTranscriptLib.KeccakTranscript memory, uint256)
    {
        uint8[] memory label = new uint8[](1);
        label[0] = 0x72; // Rust's b"r"

        uint256 rho;
        (transcript, rho) = KeccakTranscriptLib.squeeze(transcript, ScalarFromUniformLib.curveVesta(), label);

        return (transcript, rho);
    }

    function test_compute_c_rho() public {
        KeccakTranscriptLib.KeccakTranscript memory transcript = loadTranscriptCComputation();
        uint256[] memory eval_vec = new uint256[](9);
        eval_vec[0] = 0x040472c4f10b22a2743de027827847e9f1e21e7e523f133b8adaa4da8c95be98; // eval_Az
        eval_vec[1] = 0x3214bea2fc2c1a5b398af55ecbb96fecec912c00a4bab43a9d9e3509c3a3f83f; // eval_Bz
        eval_vec[2] = 0x0143a288d31527e4844c85c488b954daa941db5db11b9ca5be82ceb8343e0464; // eval_Cs
        eval_vec[3] = 0x384918480ef2f4adc3d8ffe130fb26003e83d997de344cefec47680cc014e2a7; // eval_E
        eval_vec[4] = 0x0ae4efa04fe7b3aabb07a164ae2329c6cb11d76b19cfe1e8e3b165a2a2e4958d; // eval_E_row
        eval_vec[5] = 0x3a6ada7aa60646269cb376ab6881116450b75feeb1a4dbeb4f03c2943d8cf0bc; // eval_E_col
        eval_vec[6] = 0x2da7601269ec68bbbbf62ad60c435c569ff2a9fe7fc5d5f607b251524ec0cedd; // eval_val_A
        eval_vec[7] = 0x02e55245edda3017d3cf133264ad42a2acfe8c829d269aa694db1e0b80b53119; // eval_val_B
        eval_vec[8] = 0x22eff8048b72e6536edd0e678c0158596e1414e66d133e9436b921254dcb33f3; // eval_val_C

        uint256 c;
        (transcript, c) = compute_c(transcript, eval_vec);

        uint256 expected = 0x269a3d2eece71077976037f946dcb7ef75b11c917346f95a9eba4c966cb2fcf8;
        assertEq(expected, c);

        uint256 rho;
        (transcript, rho) = compute_rho(transcript);

        expected = 0x05c4163df6bb178cdf253644914336ac52e20ffa4eefe1baf2fef386f519c1ca;
        assertEq(expected, rho);
    }

    function load_u_vec() private pure returns (PolyEvalInstanceLib.PolyEvalInstance[] memory) {
        uint256[] memory x;
        PolyEvalInstanceLib.PolyEvalInstance[] memory u_vec = new PolyEvalInstanceLib.PolyEvalInstance[](7);

        x = new uint256[](17);
        x[0] = 0x15f5e9f471c313af5c8190c109c3a1fe9cee73d035bcd08a204898e795d8e497;
        x[1] = 0x026bc743ada824501ac59409a022aeaba83ebe9c6fe153969c47d3dbcba1be20;
        x[2] = 0x0235a660a3f8c7aa923e90ef914634b078bec35cd1b1ed8d763735655f16c86b;
        x[3] = 0x06b9cd3880fe5f9881f9fd2b0f15eaa134f0271faa129290886932018371f6a4;
        x[4] = 0x369f08f9d3a1b649e724e2ded5d88ae935ee5128bfc966a33b09fd298ce1f4f9;
        x[5] = 0x17c2194712668c76ac2ac0d4ddc7ae50995905fa689a153b3a46b539a40a0cb8;
        x[6] = 0x0416682dc67529249a90de425db7b2f08a44eefa18ff9a42dae68dd77e001d23;
        x[7] = 0x08414bd36fb4ec48989f9922cd0fa9ab1e1414d9bc3e7be4dd87166124351a6c;
        x[8] = 0x3714b73daef1dd873e79a9b670c7f403a506aaec54666f2a9daa8805ce3fa7df;
        x[9] = 0x3c23643dd2a5d6b64ba3f86d6ea4c347db24e45163421b450b20dc44e502da77;
        x[10] = 0x219bd827a1a9cfcbacb2d66370f8ab9af8449f0e779eeb441b0cc3e46ac24408;
        x[11] = 0x2a99b7d2d92e7ce4b1a5bb9893a58c94525afcc43ca64c9579217d5db1980289;
        x[12] = 0x244902bf184af91659be921be063244f4d9aacf94e19fd121446104850f2b1d9;
        x[13] = 0x1594eeac26b85866f2cf09dea1c5ee8920e8b4bfde8edba325f5e89ac9995ab6;
        x[14] = 0x2e6dee8a44ef6d3058da01d7e90582d1f5d6b2fd8f05eea54540fe77a8444f12;
        x[15] = 0x17798e8f0e66b1d6e1f53871eeaaabb28f680fda97a9ae07eb833be231310035;
        x[16] = 0x2a7e0ec4192134bc0102de30940d4fd26bb0cd60e11f74519f9d9a90bebeaf5f;
        u_vec[0] = PolyEvalInstanceLib.PolyEvalInstance(
            0x27f23d4d7603ec8b206a427a04da21bf3282a95e114447aee4a1ac76e4aacb4d,
            0x209850df39cd098612ab3329da5e21001c81c08b9be94d2bc90833cf7bde14e7,
            x,
            0x2b005e5de5ae62075c66de1c5343c86a235ffc0184fd317079c6687f53596bd4
        );

        x = new uint256[](17);
        x[0] = 0x066b998f211c11d58f5c4ce0eb59a7ba543bdab2c99b5061c097723eb0ed8ff9;
        x[1] = 0x1e525e8eb5732494ab1aebe43df1d2a0150badb04db05681409c612429cea8ac;
        x[2] = 0x317b05d9d1941be2116f250a8aad1932d009cec690d12ef463fe64c5efadc978;
        x[3] = 0x13493a5dc4e2513470e1749fdb37b41e3836364d77d7eb8b5a81b985bfe7333a;
        x[4] = 0x05499a9b11713b3371978cf62676fc88bbd1784df341575d88c183fe7d2baec2;
        x[5] = 0x304fd43c6453b62cfe98bc726e458208edf3754b58a1b96b48baedb08dc231b6;
        x[6] = 0x2d5ce24c1355a2428de1d5411ecebd98b1328b5b6f87dcc9ecb573252d6cf30d;
        x[7] = 0x2d6762046fc5ca62b436c758321b1844ac5cf096e30085cb81ddd076138d7163;
        x[8] = 0x3ec3a1be092aa81390fb585c46fd3774b20febd739904f20c99ab2c9d0f3ef46;
        x[9] = 0x382b206460e5706009787007b6e484e80423783762ebac703d3cbb9c2615e7b2;
        x[10] = 0x1c9118d02c7792a8728fa7a879687962ae5a1b5aa9942420d239ada6cef57149;
        x[11] = 0x39672312a3af1dadc7dd77703cef7487ae0f27634ce37faba6e81f0b7eae3d25;
        x[12] = 0x0ec9a8b069eed91e089a03c0f47615fe04742b8c1159a10dde4129b71fc65687;
        x[13] = 0x3998456c5125913b2489869938b5b0d98e7f5c87327af98b9dc619fe54fd26c1;
        x[14] = 0x08a01a276934627dad600b53978bd5d64de6090ecb2bef2b73c3d6e346e5c096;
        x[15] = 0x394edaa7014bdeed61ad362a7d9ec5877ad82777dd131489152c96b848a05d78;
        x[16] = 0x0ede18a94d3bdf5f9ee7a7ae19c34315d98847bc4086c9d81f5264b1e127ec78;

        u_vec[1] = PolyEvalInstanceLib.PolyEvalInstance(
            0x0515cf0297f7c59bf3c1f7907ebf8b65819a29d97d041e14e0d9169b4a927274,
            0x3aba6d837219f6260d1fd5983b9aba80c730e853aac36e0b4636cc1163a0bab2,
            x,
            0x129dc2a992af808d8530bb9d4c72b3c51694d532906fa0f903ca4bf4f0b7fe22
        );

        x = new uint256[](17);
        x[0] = 0x0000000000000000000000000000000000000000000000000000000000000001;
        x[1] = 0x0000000000000000000000000000000000000000000000000000000000000001;
        x[2] = 0x0000000000000000000000000000000000000000000000000000000000000001;
        x[3] = 0x0000000000000000000000000000000000000000000000000000000000000001;
        x[4] = 0x0000000000000000000000000000000000000000000000000000000000000001;
        x[5] = 0x0000000000000000000000000000000000000000000000000000000000000001;
        x[6] = 0x0000000000000000000000000000000000000000000000000000000000000001;
        x[7] = 0x0000000000000000000000000000000000000000000000000000000000000001;
        x[8] = 0x0000000000000000000000000000000000000000000000000000000000000001;
        x[9] = 0x0000000000000000000000000000000000000000000000000000000000000001;
        x[10] = 0x0000000000000000000000000000000000000000000000000000000000000001;
        x[11] = 0x0000000000000000000000000000000000000000000000000000000000000001;
        x[12] = 0x0000000000000000000000000000000000000000000000000000000000000001;
        x[13] = 0x0000000000000000000000000000000000000000000000000000000000000001;
        x[14] = 0x0000000000000000000000000000000000000000000000000000000000000001;
        x[15] = 0x0000000000000000000000000000000000000000000000000000000000000001;
        x[16] = 0x0000000000000000000000000000000000000000000000000000000000000000;

        u_vec[2] = PolyEvalInstanceLib.PolyEvalInstance(
            0x0515cf0297f7c59bf3c1f7907ebf8b65819a29d97d041e14e0d9169b4a927274,
            0x3aba6d837219f6260d1fd5983b9aba80c730e853aac36e0b4636cc1163a0bab2,
            x,
            0x398befc342d12138f515ffc7ab7cab11ca2788e21e99f0e2f48b8c10b89e9dab
        );
        x = new uint256[](17);
        x[0] = 0x1e525e8eb5732494ab1aebe43df1d2a0150badb04db05681409c612429cea8ac;
        x[1] = 0x317b05d9d1941be2116f250a8aad1932d009cec690d12ef463fe64c5efadc978;
        x[2] = 0x13493a5dc4e2513470e1749fdb37b41e3836364d77d7eb8b5a81b985bfe7333a;
        x[3] = 0x05499a9b11713b3371978cf62676fc88bbd1784df341575d88c183fe7d2baec2;
        x[4] = 0x304fd43c6453b62cfe98bc726e458208edf3754b58a1b96b48baedb08dc231b6;
        x[5] = 0x2d5ce24c1355a2428de1d5411ecebd98b1328b5b6f87dcc9ecb573252d6cf30d;
        x[6] = 0x2d6762046fc5ca62b436c758321b1844ac5cf096e30085cb81ddd076138d7163;
        x[7] = 0x3ec3a1be092aa81390fb585c46fd3774b20febd739904f20c99ab2c9d0f3ef46;
        x[8] = 0x382b206460e5706009787007b6e484e80423783762ebac703d3cbb9c2615e7b2;
        x[9] = 0x1c9118d02c7792a8728fa7a879687962ae5a1b5aa9942420d239ada6cef57149;
        x[10] = 0x39672312a3af1dadc7dd77703cef7487ae0f27634ce37faba6e81f0b7eae3d25;
        x[11] = 0x0ec9a8b069eed91e089a03c0f47615fe04742b8c1159a10dde4129b71fc65687;
        x[12] = 0x3998456c5125913b2489869938b5b0d98e7f5c87327af98b9dc619fe54fd26c1;
        x[13] = 0x08a01a276934627dad600b53978bd5d64de6090ecb2bef2b73c3d6e346e5c096;
        x[14] = 0x394edaa7014bdeed61ad362a7d9ec5877ad82777dd131489152c96b848a05d78;
        x[15] = 0x0ede18a94d3bdf5f9ee7a7ae19c34315d98847bc4086c9d81f5264b1e127ec78;
        x[16] = 0x1741b54a11d0633c0349b0e317ced512a59ef40b772fbe94415e42af34a25c99;

        u_vec[3] = PolyEvalInstanceLib.PolyEvalInstance(
            0x0515cf0297f7c59bf3c1f7907ebf8b65819a29d97d041e14e0d9169b4a927274,
            0x3aba6d837219f6260d1fd5983b9aba80c730e853aac36e0b4636cc1163a0bab2,
            x,
            0x14ad3f45a2143b4c46c99cc3580551ca2d0349f3502eabaddf04aade50ad55e5
        );

        x = new uint256[](17);
        x[0] = 0x1e525e8eb5732494ab1aebe43df1d2a0150badb04db05681409c612429cea8ac;
        x[1] = 0x317b05d9d1941be2116f250a8aad1932d009cec690d12ef463fe64c5efadc978;
        x[2] = 0x13493a5dc4e2513470e1749fdb37b41e3836364d77d7eb8b5a81b985bfe7333a;
        x[3] = 0x05499a9b11713b3371978cf62676fc88bbd1784df341575d88c183fe7d2baec2;
        x[4] = 0x304fd43c6453b62cfe98bc726e458208edf3754b58a1b96b48baedb08dc231b6;
        x[5] = 0x2d5ce24c1355a2428de1d5411ecebd98b1328b5b6f87dcc9ecb573252d6cf30d;
        x[6] = 0x2d6762046fc5ca62b436c758321b1844ac5cf096e30085cb81ddd076138d7163;
        x[7] = 0x3ec3a1be092aa81390fb585c46fd3774b20febd739904f20c99ab2c9d0f3ef46;
        x[8] = 0x382b206460e5706009787007b6e484e80423783762ebac703d3cbb9c2615e7b2;
        x[9] = 0x1c9118d02c7792a8728fa7a879687962ae5a1b5aa9942420d239ada6cef57149;
        x[10] = 0x39672312a3af1dadc7dd77703cef7487ae0f27634ce37faba6e81f0b7eae3d25;
        x[11] = 0x0ec9a8b069eed91e089a03c0f47615fe04742b8c1159a10dde4129b71fc65687;
        x[12] = 0x3998456c5125913b2489869938b5b0d98e7f5c87327af98b9dc619fe54fd26c1;
        x[13] = 0x08a01a276934627dad600b53978bd5d64de6090ecb2bef2b73c3d6e346e5c096;
        x[14] = 0x394edaa7014bdeed61ad362a7d9ec5877ad82777dd131489152c96b848a05d78;
        x[15] = 0x0ede18a94d3bdf5f9ee7a7ae19c34315d98847bc4086c9d81f5264b1e127ec78;
        x[16] = 0x1741b54a11d0633c0349b0e317ced512a59ef40b772fbe94415e42af34a25c99;

        u_vec[4] = PolyEvalInstanceLib.PolyEvalInstance(
            0x0fa6f8f2ed2c476ea93e0571b09d389c2534bd7075d201d174c413ddcb3d909d,
            0x06dbbac77d49d6f4dbab8cc4760907d371c0f7fb2a053bdb71b8c6ca8443e3c4,
            x,
            0x155a87c951e6c2f8c604d69a840e2b822236824525ac2f59b0bae47996ec86ab
        );
        x = new uint256[](14);
        x[0] = 0x05499a9b11713b3371978cf62676fc88bbd1784df341575d88c183fe7d2baec2;
        x[1] = 0x304fd43c6453b62cfe98bc726e458208edf3754b58a1b96b48baedb08dc231b6;
        x[2] = 0x2d5ce24c1355a2428de1d5411ecebd98b1328b5b6f87dcc9ecb573252d6cf30d;
        x[3] = 0x2d6762046fc5ca62b436c758321b1844ac5cf096e30085cb81ddd076138d7163;
        x[4] = 0x3ec3a1be092aa81390fb585c46fd3774b20febd739904f20c99ab2c9d0f3ef46;
        x[5] = 0x382b206460e5706009787007b6e484e80423783762ebac703d3cbb9c2615e7b2;
        x[6] = 0x1c9118d02c7792a8728fa7a879687962ae5a1b5aa9942420d239ada6cef57149;
        x[7] = 0x39672312a3af1dadc7dd77703cef7487ae0f27634ce37faba6e81f0b7eae3d25;
        x[8] = 0x0ec9a8b069eed91e089a03c0f47615fe04742b8c1159a10dde4129b71fc65687;
        x[9] = 0x3998456c5125913b2489869938b5b0d98e7f5c87327af98b9dc619fe54fd26c1;
        x[10] = 0x08a01a276934627dad600b53978bd5d64de6090ecb2bef2b73c3d6e346e5c096;
        x[11] = 0x394edaa7014bdeed61ad362a7d9ec5877ad82777dd131489152c96b848a05d78;
        x[12] = 0x0ede18a94d3bdf5f9ee7a7ae19c34315d98847bc4086c9d81f5264b1e127ec78;
        x[13] = 0x1741b54a11d0633c0349b0e317ced512a59ef40b772fbe94415e42af34a25c99;

        u_vec[5] = PolyEvalInstanceLib.PolyEvalInstance(
            0x20b8f422ff4d669f6c21a872547e6cc1f456c814128f0cec5ae8c1041308633f,
            0x1c99056155380248020b612dba4012faaebe3b37d695b46d1dd77e5ed6afdbf6,
            x,
            0x17938b6eba9ed44f2cc8f93d2b529b20c957e8f6e3a043300e304930614b564e
        );

        x = new uint256[](17);
        x[0] = 0x066b998f211c11d58f5c4ce0eb59a7ba543bdab2c99b5061c097723eb0ed8ff9;
        x[1] = 0x1e525e8eb5732494ab1aebe43df1d2a0150badb04db05681409c612429cea8ac;
        x[2] = 0x317b05d9d1941be2116f250a8aad1932d009cec690d12ef463fe64c5efadc978;
        x[3] = 0x13493a5dc4e2513470e1749fdb37b41e3836364d77d7eb8b5a81b985bfe7333a;
        x[4] = 0x05499a9b11713b3371978cf62676fc88bbd1784df341575d88c183fe7d2baec2;
        x[5] = 0x304fd43c6453b62cfe98bc726e458208edf3754b58a1b96b48baedb08dc231b6;
        x[6] = 0x2d5ce24c1355a2428de1d5411ecebd98b1328b5b6f87dcc9ecb573252d6cf30d;
        x[7] = 0x2d6762046fc5ca62b436c758321b1844ac5cf096e30085cb81ddd076138d7163;
        x[8] = 0x3ec3a1be092aa81390fb585c46fd3774b20febd739904f20c99ab2c9d0f3ef46;
        x[9] = 0x382b206460e5706009787007b6e484e80423783762ebac703d3cbb9c2615e7b2;
        x[10] = 0x1c9118d02c7792a8728fa7a879687962ae5a1b5aa9942420d239ada6cef57149;
        x[11] = 0x39672312a3af1dadc7dd77703cef7487ae0f27634ce37faba6e81f0b7eae3d25;
        x[12] = 0x0ec9a8b069eed91e089a03c0f47615fe04742b8c1159a10dde4129b71fc65687;
        x[13] = 0x3998456c5125913b2489869938b5b0d98e7f5c87327af98b9dc619fe54fd26c1;
        x[14] = 0x08a01a276934627dad600b53978bd5d64de6090ecb2bef2b73c3d6e346e5c096;
        x[15] = 0x394edaa7014bdeed61ad362a7d9ec5877ad82777dd131489152c96b848a05d78;
        x[16] = 0x0ede18a94d3bdf5f9ee7a7ae19c34315d98847bc4086c9d81f5264b1e127ec78;

        u_vec[6] = PolyEvalInstanceLib.PolyEvalInstance(
            0x109c41eb278e0a4b727cc12a218151042f08696f70136c9ef935fcca7be561ac,
            0x1ab3acc2bdaceca93d7be63a6519f9dd9598fa7241038d3b61b7d932e6b5497f,
            x,
            0x3c09f5dab41d63e613e02db417c19923e6a8e487b3acc95a30b7865e293fb002
        );
        return u_vec;
    }

    function load_u_vec_padded() private pure returns (PolyEvalInstanceLib.PolyEvalInstance[] memory) {
        uint256[] memory x;
        PolyEvalInstanceLib.PolyEvalInstance[] memory u_vec_padded = new PolyEvalInstanceLib.PolyEvalInstance[](7);

        x = new uint256[](17);
        x[0] = 0x15f5e9f471c313af5c8190c109c3a1fe9cee73d035bcd08a204898e795d8e497;
        x[1] = 0x026bc743ada824501ac59409a022aeaba83ebe9c6fe153969c47d3dbcba1be20;
        x[2] = 0x0235a660a3f8c7aa923e90ef914634b078bec35cd1b1ed8d763735655f16c86b;
        x[3] = 0x06b9cd3880fe5f9881f9fd2b0f15eaa134f0271faa129290886932018371f6a4;
        x[4] = 0x369f08f9d3a1b649e724e2ded5d88ae935ee5128bfc966a33b09fd298ce1f4f9;
        x[5] = 0x17c2194712668c76ac2ac0d4ddc7ae50995905fa689a153b3a46b539a40a0cb8;
        x[6] = 0x0416682dc67529249a90de425db7b2f08a44eefa18ff9a42dae68dd77e001d23;
        x[7] = 0x08414bd36fb4ec48989f9922cd0fa9ab1e1414d9bc3e7be4dd87166124351a6c;
        x[8] = 0x3714b73daef1dd873e79a9b670c7f403a506aaec54666f2a9daa8805ce3fa7df;
        x[9] = 0x3c23643dd2a5d6b64ba3f86d6ea4c347db24e45163421b450b20dc44e502da77;
        x[10] = 0x219bd827a1a9cfcbacb2d66370f8ab9af8449f0e779eeb441b0cc3e46ac24408;
        x[11] = 0x2a99b7d2d92e7ce4b1a5bb9893a58c94525afcc43ca64c9579217d5db1980289;
        x[12] = 0x244902bf184af91659be921be063244f4d9aacf94e19fd121446104850f2b1d9;
        x[13] = 0x1594eeac26b85866f2cf09dea1c5ee8920e8b4bfde8edba325f5e89ac9995ab6;
        x[14] = 0x2e6dee8a44ef6d3058da01d7e90582d1f5d6b2fd8f05eea54540fe77a8444f12;
        x[15] = 0x17798e8f0e66b1d6e1f53871eeaaabb28f680fda97a9ae07eb833be231310035;
        x[16] = 0x2a7e0ec4192134bc0102de30940d4fd26bb0cd60e11f74519f9d9a90bebeaf5f;
        u_vec_padded[0] = PolyEvalInstanceLib.PolyEvalInstance(
            0x27f23d4d7603ec8b206a427a04da21bf3282a95e114447aee4a1ac76e4aacb4d,
            0x209850df39cd098612ab3329da5e21001c81c08b9be94d2bc90833cf7bde14e7,
            x,
            0x2b005e5de5ae62075c66de1c5343c86a235ffc0184fd317079c6687f53596bd4
        );

        x = new uint256[](17);
        x[0] = 0x066b998f211c11d58f5c4ce0eb59a7ba543bdab2c99b5061c097723eb0ed8ff9;
        x[1] = 0x1e525e8eb5732494ab1aebe43df1d2a0150badb04db05681409c612429cea8ac;
        x[2] = 0x317b05d9d1941be2116f250a8aad1932d009cec690d12ef463fe64c5efadc978;
        x[3] = 0x13493a5dc4e2513470e1749fdb37b41e3836364d77d7eb8b5a81b985bfe7333a;
        x[4] = 0x05499a9b11713b3371978cf62676fc88bbd1784df341575d88c183fe7d2baec2;
        x[5] = 0x304fd43c6453b62cfe98bc726e458208edf3754b58a1b96b48baedb08dc231b6;
        x[6] = 0x2d5ce24c1355a2428de1d5411ecebd98b1328b5b6f87dcc9ecb573252d6cf30d;
        x[7] = 0x2d6762046fc5ca62b436c758321b1844ac5cf096e30085cb81ddd076138d7163;
        x[8] = 0x3ec3a1be092aa81390fb585c46fd3774b20febd739904f20c99ab2c9d0f3ef46;
        x[9] = 0x382b206460e5706009787007b6e484e80423783762ebac703d3cbb9c2615e7b2;
        x[10] = 0x1c9118d02c7792a8728fa7a879687962ae5a1b5aa9942420d239ada6cef57149;
        x[11] = 0x39672312a3af1dadc7dd77703cef7487ae0f27634ce37faba6e81f0b7eae3d25;
        x[12] = 0x0ec9a8b069eed91e089a03c0f47615fe04742b8c1159a10dde4129b71fc65687;
        x[13] = 0x3998456c5125913b2489869938b5b0d98e7f5c87327af98b9dc619fe54fd26c1;
        x[14] = 0x08a01a276934627dad600b53978bd5d64de6090ecb2bef2b73c3d6e346e5c096;
        x[15] = 0x394edaa7014bdeed61ad362a7d9ec5877ad82777dd131489152c96b848a05d78;
        x[16] = 0x0ede18a94d3bdf5f9ee7a7ae19c34315d98847bc4086c9d81f5264b1e127ec78;

        u_vec_padded[1] = PolyEvalInstanceLib.PolyEvalInstance(
            0x0515cf0297f7c59bf3c1f7907ebf8b65819a29d97d041e14e0d9169b4a927274,
            0x3aba6d837219f6260d1fd5983b9aba80c730e853aac36e0b4636cc1163a0bab2,
            x,
            0x129dc2a992af808d8530bb9d4c72b3c51694d532906fa0f903ca4bf4f0b7fe22
        );

        x = new uint256[](17);
        x[0] = 0x0000000000000000000000000000000000000000000000000000000000000001;
        x[1] = 0x0000000000000000000000000000000000000000000000000000000000000001;
        x[2] = 0x0000000000000000000000000000000000000000000000000000000000000001;
        x[3] = 0x0000000000000000000000000000000000000000000000000000000000000001;
        x[4] = 0x0000000000000000000000000000000000000000000000000000000000000001;
        x[5] = 0x0000000000000000000000000000000000000000000000000000000000000001;
        x[6] = 0x0000000000000000000000000000000000000000000000000000000000000001;
        x[7] = 0x0000000000000000000000000000000000000000000000000000000000000001;
        x[8] = 0x0000000000000000000000000000000000000000000000000000000000000001;
        x[9] = 0x0000000000000000000000000000000000000000000000000000000000000001;
        x[10] = 0x0000000000000000000000000000000000000000000000000000000000000001;
        x[11] = 0x0000000000000000000000000000000000000000000000000000000000000001;
        x[12] = 0x0000000000000000000000000000000000000000000000000000000000000001;
        x[13] = 0x0000000000000000000000000000000000000000000000000000000000000001;
        x[14] = 0x0000000000000000000000000000000000000000000000000000000000000001;
        x[15] = 0x0000000000000000000000000000000000000000000000000000000000000001;
        x[16] = 0x0000000000000000000000000000000000000000000000000000000000000000;

        u_vec_padded[2] = PolyEvalInstanceLib.PolyEvalInstance(
            0x0515cf0297f7c59bf3c1f7907ebf8b65819a29d97d041e14e0d9169b4a927274,
            0x3aba6d837219f6260d1fd5983b9aba80c730e853aac36e0b4636cc1163a0bab2,
            x,
            0x398befc342d12138f515ffc7ab7cab11ca2788e21e99f0e2f48b8c10b89e9dab
        );

        x = new uint256[](17);
        x[0] = 0x1e525e8eb5732494ab1aebe43df1d2a0150badb04db05681409c612429cea8ac;
        x[1] = 0x317b05d9d1941be2116f250a8aad1932d009cec690d12ef463fe64c5efadc978;
        x[2] = 0x13493a5dc4e2513470e1749fdb37b41e3836364d77d7eb8b5a81b985bfe7333a;
        x[3] = 0x05499a9b11713b3371978cf62676fc88bbd1784df341575d88c183fe7d2baec2;
        x[4] = 0x304fd43c6453b62cfe98bc726e458208edf3754b58a1b96b48baedb08dc231b6;
        x[5] = 0x2d5ce24c1355a2428de1d5411ecebd98b1328b5b6f87dcc9ecb573252d6cf30d;
        x[6] = 0x2d6762046fc5ca62b436c758321b1844ac5cf096e30085cb81ddd076138d7163;
        x[7] = 0x3ec3a1be092aa81390fb585c46fd3774b20febd739904f20c99ab2c9d0f3ef46;
        x[8] = 0x382b206460e5706009787007b6e484e80423783762ebac703d3cbb9c2615e7b2;
        x[9] = 0x1c9118d02c7792a8728fa7a879687962ae5a1b5aa9942420d239ada6cef57149;
        x[10] = 0x39672312a3af1dadc7dd77703cef7487ae0f27634ce37faba6e81f0b7eae3d25;
        x[11] = 0x0ec9a8b069eed91e089a03c0f47615fe04742b8c1159a10dde4129b71fc65687;
        x[12] = 0x3998456c5125913b2489869938b5b0d98e7f5c87327af98b9dc619fe54fd26c1;
        x[13] = 0x08a01a276934627dad600b53978bd5d64de6090ecb2bef2b73c3d6e346e5c096;
        x[14] = 0x394edaa7014bdeed61ad362a7d9ec5877ad82777dd131489152c96b848a05d78;
        x[15] = 0x0ede18a94d3bdf5f9ee7a7ae19c34315d98847bc4086c9d81f5264b1e127ec78;
        x[16] = 0x1741b54a11d0633c0349b0e317ced512a59ef40b772fbe94415e42af34a25c99;

        u_vec_padded[3] = PolyEvalInstanceLib.PolyEvalInstance(
            0x0515cf0297f7c59bf3c1f7907ebf8b65819a29d97d041e14e0d9169b4a927274,
            0x3aba6d837219f6260d1fd5983b9aba80c730e853aac36e0b4636cc1163a0bab2,
            x,
            0x14ad3f45a2143b4c46c99cc3580551ca2d0349f3502eabaddf04aade50ad55e5
        );

        x = new uint256[](17);
        x[0] = 0x1e525e8eb5732494ab1aebe43df1d2a0150badb04db05681409c612429cea8ac;
        x[1] = 0x317b05d9d1941be2116f250a8aad1932d009cec690d12ef463fe64c5efadc978;
        x[2] = 0x13493a5dc4e2513470e1749fdb37b41e3836364d77d7eb8b5a81b985bfe7333a;
        x[3] = 0x05499a9b11713b3371978cf62676fc88bbd1784df341575d88c183fe7d2baec2;
        x[4] = 0x304fd43c6453b62cfe98bc726e458208edf3754b58a1b96b48baedb08dc231b6;
        x[5] = 0x2d5ce24c1355a2428de1d5411ecebd98b1328b5b6f87dcc9ecb573252d6cf30d;
        x[6] = 0x2d6762046fc5ca62b436c758321b1844ac5cf096e30085cb81ddd076138d7163;
        x[7] = 0x3ec3a1be092aa81390fb585c46fd3774b20febd739904f20c99ab2c9d0f3ef46;
        x[8] = 0x382b206460e5706009787007b6e484e80423783762ebac703d3cbb9c2615e7b2;
        x[9] = 0x1c9118d02c7792a8728fa7a879687962ae5a1b5aa9942420d239ada6cef57149;
        x[10] = 0x39672312a3af1dadc7dd77703cef7487ae0f27634ce37faba6e81f0b7eae3d25;
        x[11] = 0x0ec9a8b069eed91e089a03c0f47615fe04742b8c1159a10dde4129b71fc65687;
        x[12] = 0x3998456c5125913b2489869938b5b0d98e7f5c87327af98b9dc619fe54fd26c1;
        x[13] = 0x08a01a276934627dad600b53978bd5d64de6090ecb2bef2b73c3d6e346e5c096;
        x[14] = 0x394edaa7014bdeed61ad362a7d9ec5877ad82777dd131489152c96b848a05d78;
        x[15] = 0x0ede18a94d3bdf5f9ee7a7ae19c34315d98847bc4086c9d81f5264b1e127ec78;
        x[16] = 0x1741b54a11d0633c0349b0e317ced512a59ef40b772fbe94415e42af34a25c99;

        u_vec_padded[4] = PolyEvalInstanceLib.PolyEvalInstance(
            0x0fa6f8f2ed2c476ea93e0571b09d389c2534bd7075d201d174c413ddcb3d909d,
            0x06dbbac77d49d6f4dbab8cc4760907d371c0f7fb2a053bdb71b8c6ca8443e3c4,
            x,
            0x155a87c951e6c2f8c604d69a840e2b822236824525ac2f59b0bae47996ec86ab
        );

        x = new uint256[](17);
        x[0] = 0x0000000000000000000000000000000000000000000000000000000000000000;
        x[1] = 0x0000000000000000000000000000000000000000000000000000000000000000;
        x[2] = 0x0000000000000000000000000000000000000000000000000000000000000000;
        x[3] = 0x05499a9b11713b3371978cf62676fc88bbd1784df341575d88c183fe7d2baec2;
        x[4] = 0x304fd43c6453b62cfe98bc726e458208edf3754b58a1b96b48baedb08dc231b6;
        x[5] = 0x2d5ce24c1355a2428de1d5411ecebd98b1328b5b6f87dcc9ecb573252d6cf30d;
        x[6] = 0x2d6762046fc5ca62b436c758321b1844ac5cf096e30085cb81ddd076138d7163;
        x[7] = 0x3ec3a1be092aa81390fb585c46fd3774b20febd739904f20c99ab2c9d0f3ef46;
        x[8] = 0x382b206460e5706009787007b6e484e80423783762ebac703d3cbb9c2615e7b2;
        x[9] = 0x1c9118d02c7792a8728fa7a879687962ae5a1b5aa9942420d239ada6cef57149;
        x[10] = 0x39672312a3af1dadc7dd77703cef7487ae0f27634ce37faba6e81f0b7eae3d25;
        x[11] = 0x0ec9a8b069eed91e089a03c0f47615fe04742b8c1159a10dde4129b71fc65687;
        x[12] = 0x3998456c5125913b2489869938b5b0d98e7f5c87327af98b9dc619fe54fd26c1;
        x[13] = 0x08a01a276934627dad600b53978bd5d64de6090ecb2bef2b73c3d6e346e5c096;
        x[14] = 0x394edaa7014bdeed61ad362a7d9ec5877ad82777dd131489152c96b848a05d78;
        x[15] = 0x0ede18a94d3bdf5f9ee7a7ae19c34315d98847bc4086c9d81f5264b1e127ec78;
        x[16] = 0x1741b54a11d0633c0349b0e317ced512a59ef40b772fbe94415e42af34a25c99;

        u_vec_padded[5] = PolyEvalInstanceLib.PolyEvalInstance(
            0x20b8f422ff4d669f6c21a872547e6cc1f456c814128f0cec5ae8c1041308633f,
            0x1c99056155380248020b612dba4012faaebe3b37d695b46d1dd77e5ed6afdbf6,
            x,
            0x17938b6eba9ed44f2cc8f93d2b529b20c957e8f6e3a043300e304930614b564e
        );

        x = new uint256[](17);
        x[0] = 0x066b998f211c11d58f5c4ce0eb59a7ba543bdab2c99b5061c097723eb0ed8ff9;
        x[1] = 0x1e525e8eb5732494ab1aebe43df1d2a0150badb04db05681409c612429cea8ac;
        x[2] = 0x317b05d9d1941be2116f250a8aad1932d009cec690d12ef463fe64c5efadc978;
        x[3] = 0x13493a5dc4e2513470e1749fdb37b41e3836364d77d7eb8b5a81b985bfe7333a;
        x[4] = 0x05499a9b11713b3371978cf62676fc88bbd1784df341575d88c183fe7d2baec2;
        x[5] = 0x304fd43c6453b62cfe98bc726e458208edf3754b58a1b96b48baedb08dc231b6;
        x[6] = 0x2d5ce24c1355a2428de1d5411ecebd98b1328b5b6f87dcc9ecb573252d6cf30d;
        x[7] = 0x2d6762046fc5ca62b436c758321b1844ac5cf096e30085cb81ddd076138d7163;
        x[8] = 0x3ec3a1be092aa81390fb585c46fd3774b20febd739904f20c99ab2c9d0f3ef46;
        x[9] = 0x382b206460e5706009787007b6e484e80423783762ebac703d3cbb9c2615e7b2;
        x[10] = 0x1c9118d02c7792a8728fa7a879687962ae5a1b5aa9942420d239ada6cef57149;
        x[11] = 0x39672312a3af1dadc7dd77703cef7487ae0f27634ce37faba6e81f0b7eae3d25;
        x[12] = 0x0ec9a8b069eed91e089a03c0f47615fe04742b8c1159a10dde4129b71fc65687;
        x[13] = 0x3998456c5125913b2489869938b5b0d98e7f5c87327af98b9dc619fe54fd26c1;
        x[14] = 0x08a01a276934627dad600b53978bd5d64de6090ecb2bef2b73c3d6e346e5c096;
        x[15] = 0x394edaa7014bdeed61ad362a7d9ec5877ad82777dd131489152c96b848a05d78;
        x[16] = 0x0ede18a94d3bdf5f9ee7a7ae19c34315d98847bc4086c9d81f5264b1e127ec78;

        u_vec_padded[6] = PolyEvalInstanceLib.PolyEvalInstance(
            0x109c41eb278e0a4b727cc12a218151042f08696f70136c9ef935fcca7be561ac,
            0x1ab3acc2bdaceca93d7be63a6519f9dd9598fa7241038d3b61b7d932e6b5497f,
            x,
            0x3c09f5dab41d63e613e02db417c19923e6a8e487b3acc95a30b7865e293fb002
        );
        return u_vec_padded;
    }

    function test_compute_u_vec_padded() public {
        PolyEvalInstanceLib.PolyEvalInstance[] memory u_vec = load_u_vec();
        PolyEvalInstanceLib.PolyEvalInstance[] memory u_vec_padded_expected = load_u_vec_padded();
        PolyEvalInstanceLib.PolyEvalInstance[] memory u_vec_padded_actual = PolyEvalInstanceLib.pad(u_vec);

        assertEq(u_vec_padded_expected.length, u_vec_padded_actual.length);
        for (uint256 i = 0; i < u_vec_padded_actual.length; i++) {
            assertEq(u_vec_padded_expected[i].e, u_vec_padded_actual[i].e);
            assertEq(u_vec_padded_expected[i].c_x, u_vec_padded_actual[i].c_x);
            assertEq(u_vec_padded_expected[i].c_y, u_vec_padded_actual[i].c_y);

            assertEq(u_vec_padded_expected[i].x.length, u_vec_padded_actual[i].x.length);
            for (uint256 j = 0; j < u_vec_padded_expected[i].x.length; j++) {
                assertEq(u_vec_padded_expected[i].x[j], u_vec_padded_actual[i].x[j]);
            }
        }
    }

    function test_compute_u() public {
        uint256[] memory r_sat = new uint256[](17);
        r_sat[0] = 0x066b998f211c11d58f5c4ce0eb59a7ba543bdab2c99b5061c097723eb0ed8ff9;
        r_sat[1] = 0x1e525e8eb5732494ab1aebe43df1d2a0150badb04db05681409c612429cea8ac;
        r_sat[2] = 0x317b05d9d1941be2116f250a8aad1932d009cec690d12ef463fe64c5efadc978;
        r_sat[3] = 0x13493a5dc4e2513470e1749fdb37b41e3836364d77d7eb8b5a81b985bfe7333a;
        r_sat[4] = 0x05499a9b11713b3371978cf62676fc88bbd1784df341575d88c183fe7d2baec2;
        r_sat[5] = 0x304fd43c6453b62cfe98bc726e458208edf3754b58a1b96b48baedb08dc231b6;
        r_sat[6] = 0x2d5ce24c1355a2428de1d5411ecebd98b1328b5b6f87dcc9ecb573252d6cf30d;
        r_sat[7] = 0x2d6762046fc5ca62b436c758321b1844ac5cf096e30085cb81ddd076138d7163;
        r_sat[8] = 0x3ec3a1be092aa81390fb585c46fd3774b20febd739904f20c99ab2c9d0f3ef46;
        r_sat[9] = 0x382b206460e5706009787007b6e484e80423783762ebac703d3cbb9c2615e7b2;
        r_sat[10] = 0x1c9118d02c7792a8728fa7a879687962ae5a1b5aa9942420d239ada6cef57149;
        r_sat[11] = 0x39672312a3af1dadc7dd77703cef7487ae0f27634ce37faba6e81f0b7eae3d25;
        r_sat[12] = 0x0ec9a8b069eed91e089a03c0f47615fe04742b8c1159a10dde4129b71fc65687;
        r_sat[13] = 0x3998456c5125913b2489869938b5b0d98e7f5c87327af98b9dc619fe54fd26c1;
        r_sat[14] = 0x08a01a276934627dad600b53978bd5d64de6090ecb2bef2b73c3d6e346e5c096;
        r_sat[15] = 0x394edaa7014bdeed61ad362a7d9ec5877ad82777dd131489152c96b848a05d78;
        r_sat[16] = 0x0ede18a94d3bdf5f9ee7a7ae19c34315d98847bc4086c9d81f5264b1e127ec78;

        uint256 c = 0x269a3d2eece71077976037f946dcb7ef75b11c917346f95a9eba4c966cb2fcf8;

        uint256[] memory eval_vec = new uint256[](9);
        eval_vec[0] = 0x040472c4f10b22a2743de027827847e9f1e21e7e523f133b8adaa4da8c95be98; // eval_Az
        eval_vec[1] = 0x3214bea2fc2c1a5b398af55ecbb96fecec912c00a4bab43a9d9e3509c3a3f83f; // eval_Bz
        eval_vec[2] = 0x0143a288d31527e4844c85c488b954daa941db5db11b9ca5be82ceb8343e0464; // eval_Cs
        eval_vec[3] = 0x384918480ef2f4adc3d8ffe130fb26003e83d997de344cefec47680cc014e2a7; // eval_E
        eval_vec[4] = 0x0ae4efa04fe7b3aabb07a164ae2329c6cb11d76b19cfe1e8e3b165a2a2e4958d; // eval_E_row
        eval_vec[5] = 0x3a6ada7aa60646269cb376ab6881116450b75feeb1a4dbeb4f03c2943d8cf0bc; // eval_E_col
        eval_vec[6] = 0x2da7601269ec68bbbbf62ad60c435c569ff2a9fe7fc5d5f607b251524ec0cedd; // eval_val_A
        eval_vec[7] = 0x02e55245edda3017d3cf133264ad42a2acfe8c829d269aa694db1e0b80b53119; // eval_val_B
        eval_vec[8] = 0x22eff8048b72e6536edd0e678c0158596e1414e66d133e9436b921254dcb33f3; // eval_val_C

        Pallas.PallasAffinePoint[] memory comm_vec = new Pallas.PallasAffinePoint[](9);
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
        comm_vec[3] = Pallas.PallasAffinePoint(
            0x161bf0cde96f801ced5cf0dc4b19a3dd19cbaa1fc580beb924e9fd743287aef9,
            0x2eba9ec00f619ef4b27ee7d4ff64b7f5aebe7a6828c09e74e69843c26370123f
        );
        comm_vec[4] = Pallas.PallasAffinePoint(
            0x00ef7c3d197618250aaf818054394f1b3dec874b64967a1be94218debebc9d5e,
            0x06169c7b462b764cf54f696959377513c2aab736c36d681cdeb64ca128e66c0c
        );
        comm_vec[5] = Pallas.PallasAffinePoint(
            0x1052c7c7b9fd74fbeef912aee7cc942dfe03197c30de448325fb887bb2cbbec9,
            0x029ea3cf93ed13e8055dde8e4e2a8e030369d2f740ec8165e6549c343275ae63
        );
        comm_vec[6] = Pallas.PallasAffinePoint(
            0x39a1a1ca8febc341c748bb466788b1ac3f4679d88ad08cce7460ff75fc4d851a,
            0x313431834a1344637617bbb05de78bac7278cdba9c0e895e7002f3162addd85f
        );
        comm_vec[7] = Pallas.PallasAffinePoint(
            0x3ee94a6808d6c8d8b9fcee490f1611b43cfdb275fd33007b146cde080e2503be,
            0x387434b61313b24bcd63dda8d90bfb0cc8f5e83a8c2685b93bf10dfc30cda841
        );
        comm_vec[8] = Pallas.PallasAffinePoint(
            0x213ef116b4b7d5387267837f7d0f94d3e471f3f8c3cb534d31c0a2a580df3208,
            0x36687f6c5920e04e136fd1a0287d962a44e8648c4de1fae77e74320fff306d64
        );

        PolyEvalInstanceLib.PolyEvalInstance memory u = PolyEvalInstanceLib.batchPrimary(comm_vec, r_sat, eval_vec, c);

        assertEq(u.c_x, 0x109c41eb278e0a4b727cc12a218151042f08696f70136c9ef935fcca7be561ac);
        assertEq(u.c_y, 0x1ab3acc2bdaceca93d7be63a6519f9dd9598fa7241038d3b61b7d932e6b5497f);
        assertEq(u.e, 0x3c09f5dab41d63e613e02db417c19923e6a8e487b3acc95a30b7865e293fb002);
    }

    function compute_sc_proof_batch_verification_input(
        PolyEvalInstanceLib.PolyEvalInstance[] memory u_vec_padded,
        uint256 rho
    ) private pure returns (uint256, uint256) {
        require(u_vec_padded.length >= 1, "u_vec_padded.length is empty");

        uint256 num_rounds_z = u_vec_padded[0].x.length;

        uint256 num_claims = u_vec_padded.length;

        uint256 modulus = Vesta.P_MOD;

        uint256[] memory powers_of_rho = CommonUtilities.powers(rho, num_claims, modulus);

        require(powers_of_rho.length == u_vec_padded.length, "powers_of_rho.length != u_vec_padded.length");

        uint256 u_vec_padded_e_item;
        uint256 powers_of_rho_item;
        uint256 claim_batch_joint;

        for (uint256 index = 0; index < u_vec_padded.length; index++) {
            u_vec_padded_e_item = u_vec_padded[index].e;
            powers_of_rho_item = powers_of_rho[index];
            assembly {
                u_vec_padded_e_item := mulmod(u_vec_padded_e_item, powers_of_rho_item, modulus)
                claim_batch_joint := addmod(u_vec_padded_e_item, claim_batch_joint, modulus)
            }
        }

        return (claim_batch_joint, num_rounds_z);
    }

    function test_compute_sc_proof_batch_verification_input() public {
        PolyEvalInstanceLib.PolyEvalInstance[] memory u_vec_padded = load_u_vec_padded();

        uint256 rho = 0x05c4163df6bb178cdf253644914336ac52e20ffa4eefe1baf2fef386f519c1ca;

        uint256 claim_batch_joint;
        uint256 num_rounds_z;
        (claim_batch_joint, num_rounds_z) = compute_sc_proof_batch_verification_input(u_vec_padded, rho);

        assertEq(claim_batch_joint, 0x00e9c130b0bf24ada9d20e31a28770e83e03e1a5d22b6241c14ff820169c008e);
        assertEq(num_rounds_z, 17);
    }
}
