// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.16;

import "@std/Test.sol";
import "src/NovaVerifierAbstractions.sol";
import "src/blocks/poseidon/PoseidonNeptuneU24Optimized.sol";
import "src/verifier/Step3.sol";
import "src/verifier/Step3Grumpkin.sol";

import "test/utils.t.sol";

contract PpSpartanStep3Computations is Test {
    function loadScSatSecondary() private returns (Abstractions.CompressedPolys[] memory) {
        Abstractions.CompressedPolys[] memory polys = new Abstractions.CompressedPolys[](17);
        uint256[] memory raw_poly = new uint256[](3);
        raw_poly[0] = 0x1a92153cd8f297b34a72db4d128b1159add5031194cf982141cc54182391d4d5;
        raw_poly[1] = 0x2416d0adb8fae80048f2c91e65a3f6ed839667b61d51109724ce0f93d1dbcbb3;
        raw_poly[2] = 0x1147a5d1ee0aae83b63d2c3520581454d4d50b2efb56350cc74d99a14bb83926;
        polys[0] = Abstractions.CompressedPolys(raw_poly);

        raw_poly = new uint256[](3);
        raw_poly[0] = 0x284a32b6aba84bfde8527f6b491372677bd019850283894e5fe9548cd799a896;
        raw_poly[1] = 0x116510db69dc4fc80b9144953bd935805e6e4e25401d42c00d3e51f411e9adcb;
        raw_poly[2] = 0x169086ce61545550f14b997a53696fe090bdf377cec850f01c08f2bc3caeb0fd;
        polys[1] = Abstractions.CompressedPolys(raw_poly);

        raw_poly = new uint256[](3);
        raw_poly[0] = 0x178cdad7d83b1ff3e70cc3592d1be7f924c1f05b81830b0301621eb73c101699;
        raw_poly[1] = 0x128a976e640fac8125aed40630fda1b0c922bc9b1f68533e88fac8b7e1590041;
        raw_poly[2] = 0x054234f4d3df01c9fc776d10cc10e7664ed90ebd4561bdc0884b3745deff4314;
        polys[2] = Abstractions.CompressedPolys(raw_poly);

        raw_poly = new uint256[](3);
        raw_poly[0] = 0x0a455249512e8c5e8336a8182ccba7f6ac74d7480bc3c481e141cd52e52b0794;
        raw_poly[1] = 0x244e38efafb27d0813071980e6eb67398241b354dca2d38387837ebc02b5c705;
        raw_poly[2] = 0x2c72266d79eda8b1eb8da9e102eb3ac2e149ef0c7732d35093987524ec9bad50;
        polys[3] = Abstractions.CompressedPolys(raw_poly);

        raw_poly = new uint256[](3);
        raw_poly[0] = 0x03555160a10d45114210b4eab4f7d17a5dc3b16b64ee48e10f4d35ca4e5ee6f8;
        raw_poly[1] = 0x0fa9fd1b94f1dbe9a44338c8a4e2876f24cb06c08ff025bd2689414ec01f2fd1;
        raw_poly[2] = 0x1a765015315a9636e6e7f266b3d03ffa69dba3a65a9735f5558cefdf5b6f3946;
        polys[4] = Abstractions.CompressedPolys(raw_poly);

        raw_poly = new uint256[](3);
        raw_poly[0] = 0x27e2c7440967c20b9accd2718151e990d02997ee85a1be97b5dcccce21be1c44;
        raw_poly[1] = 0x2e32f4d3561966823c6993628bf6f2053edb083a432986ff7ef38858d66daf89;
        raw_poly[2] = 0x16f51a641ea532002223aa58b6b9662296c01aa76a80142ddb5a155e2c5011f5;
        polys[5] = Abstractions.CompressedPolys(raw_poly);

        raw_poly = new uint256[](3);
        raw_poly[0] = 0x21437d787c532c41b8226abc56d1ad41e8b171270ea24b0846a6955a82606013;
        raw_poly[1] = 0x19ffcd70c5c8f090e99b9c299ad4de7d4398ec52eac6fff29f8dbd3f05f054a4;
        raw_poly[2] = 0x179f6041820970bf9e18fcfbcf8ef7c5db3c59f7be67e2c33465ce6e0e9aef3a;
        polys[6] = Abstractions.CompressedPolys(raw_poly);

        raw_poly = new uint256[](3);
        raw_poly[0] = 0x099786913b502dc1805b6e0d05f726e30a9ee0bce6af2a60b20e5829da17c2ec;
        raw_poly[1] = 0x104c508ea3c9a9eb07de02594004c8cc7d6c3bbc1308c7492ba2847756bda507;
        raw_poly[2] = 0x29564071ec86c3bb8aa7f79798712456edc0f62fd2d1e8135de0deff03079999;
        polys[7] = Abstractions.CompressedPolys(raw_poly);

        raw_poly = new uint256[](3);
        raw_poly[0] = 0x143c517fe4506d3c000170566037e38dbeb5b0c325021857e9aa6cfe4cb1294f;
        raw_poly[1] = 0x1ac117fd678d3dac7a4d2f1a863bbec04bcfd3f6ec9f52322e654f32f48ff0af;
        raw_poly[2] = 0x12034986615915a9016150fe42ea5e9c32bc92095f713bcffc419d01e6f8d2b2;
        polys[8] = Abstractions.CompressedPolys(raw_poly);

        raw_poly = new uint256[](3);
        raw_poly[0] = 0x22c88e34fa5358bec9a767c993433943a49535d0f7540ca1cf862382b77c3ce8;
        raw_poly[1] = 0x104c60e9e5f9af2966cb602f0ed9468dd0e32cc07b1cef2ca7fb57736a179208;
        raw_poly[2] = 0x1f222f6efd3b3c4ad3cc19105d374736bd11309a4def5fc0f2cef34075690e7c;
        polys[9] = Abstractions.CompressedPolys(raw_poly);

        raw_poly = new uint256[](3);
        raw_poly[0] = 0x1f425850504aeae2c486d788aeca63e6f747eadea34abb5d8cb985611c9528c6;
        raw_poly[1] = 0x0ba59c4e5c829816fc4d653c55cfcb742d6fef927048da1253a1ea317039facd;
        raw_poly[2] = 0x0ad8de4d690ce18039785296022a9325f2d1ed3e48b29676ae2c57727e459626;
        polys[10] = Abstractions.CompressedPolys(raw_poly);

        raw_poly = new uint256[](3);
        raw_poly[0] = 0x1b052334b5c290018760bd3aee193827f9381c54883a16d7d5c90ee2ee4db0a2;
        raw_poly[1] = 0x0a183874a63fbe73ace4bb1e4e306162903166eef4773d81e710a4a8c3db0b53;
        raw_poly[2] = 0x22f1cc8a9f3ee25a899f88c48337b0f9f1ea970215f8c0e35dd23ff04ba96751;
        polys[11] = Abstractions.CompressedPolys(raw_poly);

        raw_poly = new uint256[](3);
        raw_poly[0] = 0x11d1e298414c4237e50c90f8dd649c2a8081fd153480ac672ad6c218679c799f;
        raw_poly[1] = 0x21084d370f3ad6d76f5c8cc7177516055a52df8ff7772d54c13c140e8a918b67;
        raw_poly[2] = 0x247925afcb0c8f4e6815ccd3eaf355aa35b24551a51941d413ad759eab06d862;
        polys[12] = Abstractions.CompressedPolys(raw_poly);

        raw_poly = new uint256[](3);
        raw_poly[0] = 0x21c70d5fc387bb88c271d16ac2c2108d274d7dead0b16362e4158c400352cd3c;
        raw_poly[1] = 0x1922a3d05002ca9a61c76f7a9cd9687ef1ca8150c3187deb51103f37ed393947;
        raw_poly[2] = 0x02bd34d0089f196771a95c798bc076d19cd358ade572314a0f6f6ddbfd3cb691;
        polys[13] = Abstractions.CompressedPolys(raw_poly);

        raw_poly = new uint256[](3);
        raw_poly[0] = 0x1e34b6316ff24ae3b8f3564422c0a21971fa575cb9ca287d1bf27a1d1ee043f2;
        raw_poly[1] = 0x089700fd9af2772effc1483c8697e9265e612b10c73da79168aa05928f230c2c;
        raw_poly[2] = 0x08d2db108f23a7031e04360f7fd7b39c92c89f7df3388de21580ed09487166ec;
        polys[14] = Abstractions.CompressedPolys(raw_poly);

        raw_poly = new uint256[](3);
        raw_poly[0] = 0x2b7a418cdeedf13cfb5b466487ca6aaa096c0e8717973e6dc272d25ff2cbe42f;
        raw_poly[1] = 0x16df58a46d3a88a7f89c4c61c515ac60561f509f08049f7492c5d3107504aecc;
        raw_poly[2] = 0x288ce510c9c9134613d1a5b17d84843dd7a240beb015130ccee7dde78832ebf4;
        polys[15] = Abstractions.CompressedPolys(raw_poly);

        raw_poly = new uint256[](3);
        raw_poly[0] = 0x2bc6eb266ca0e251634b6e8a0aafe08b93fa02b40847c020cf326eb7ae9011e8;
        raw_poly[1] = 0x2183c791c9f3e698ce0ba6d44ed7236873932c2bce37cc7f9e85f877f3d2449c;
        raw_poly[2] = 0x0d2e7c533a4974068ff229ae5cb952bea221109b69634bc717a66e1364a0b3c8;
        polys[16] = Abstractions.CompressedPolys(raw_poly);

        return polys;
    }

    function loadScSatPrimary() private returns (Abstractions.CompressedPolys[] memory) {
        Abstractions.CompressedPolys[] memory polys = new Abstractions.CompressedPolys[](17);
        uint256[] memory raw_poly = new uint256[](3);
        raw_poly[0] = 0x04307958956afc72bb453365f15a82322f0f7cd90849dbcb1e12938461edd382;
        raw_poly[1] = 0x17cdb1e00a7a6405d31f227482f66662117a325d2d5b6341051084b91127cec2;
        raw_poly[2] = 0x2a4adf108d69284dc79c3c12a7967a9a4257d722606104d535dfc69fc626e0f7;
        polys[0] = Abstractions.CompressedPolys(raw_poly);

        raw_poly = new uint256[](3);
        raw_poly[0] = 0x1aa1069ddd0a332245670850350326b02a0b6fb5938f07d5959dc765c7d29b22;
        raw_poly[1] = 0x0f158d4ef268c5dfe92380c9ef0d229670ea04148dfbeaaa4102751e3e8dc589;
        raw_poly[2] = 0x0440f5dfc284463fe7e2e805d875cacffdd0f1baf884cbc794b1ed51c9f4887a;
        polys[1] = Abstractions.CompressedPolys(raw_poly);

        raw_poly = new uint256[](3);
        raw_poly[0] = 0x00a5957f0395f79a4394f38ff664907deeeb08cb00669e8dfe99861d8b314949;
        raw_poly[1] = 0x0108e8858068f21f28d6902e4874cc9fb37fa6dcd10c93749cef61c27bb8b4b9;
        raw_poly[2] = 0x1f7e366996de9b0fb20f4e966c7150a5f16ebd1f8717ccbe5b649a9bd18c1dac;
        polys[2] = Abstractions.CompressedPolys(raw_poly);

        raw_poly = new uint256[](3);
        raw_poly[0] = 0x1419f8a9ab83b8eb59b1f1f72dc8c98de6f09fa140958b8c8ddb803cb82af264;
        raw_poly[1] = 0x2681974b0904e3706aae16bfb8c942c6d827a9da042e7f65a30cd92cdcd46018;
        raw_poly[2] = 0x032a6f8abed1b8c3df509f62e570cec40674f27e817f79434fc4eb6815e32035;
        polys[3] = Abstractions.CompressedPolys(raw_poly);

        raw_poly = new uint256[](3);
        raw_poly[0] = 0x105f93302b96b1532100b8aa6f2e03c71ab000d1e43748dbf3366864382ed91b;
        raw_poly[1] = 0x1ddfd9d946e26f23ae2d158c4f6deb609e2ec1a81c75b91ccb1d42d6990814b6;
        raw_poly[2] = 0x03e5c41479c0ef26c88beb723534e71af61ff62c8a43ccedf2eb8173ec7a2bae;
        polys[4] = Abstractions.CompressedPolys(raw_poly);

        raw_poly = new uint256[](3);
        raw_poly[0] = 0x27a32fe9339ae7ccd6df1a690f36fd6a101cfa0e4e6384dcb756639f6aca64b1;
        raw_poly[1] = 0x1435036832f8eb0c93c89db5fac69b8712d17baa190637dd19e8832e41c1a14b;
        raw_poly[2] = 0x2226c8117dea29019439be63ee4feab6ee9b2dd1ddf3134f1e11b51a5d86cb72;
        polys[5] = Abstractions.CompressedPolys(raw_poly);

        raw_poly = new uint256[](3);
        raw_poly[0] = 0x2b9e178fbc15b776eb3a98ba5278c71b4bf3e7d8bbbf39f2aa566c0f3ca373db;
        raw_poly[1] = 0x1eba37dbd4219c4eb8e8016c5bfd553029fcf26a7a5503fb25f5935d155b2677;
        raw_poly[2] = 0x203bccda5d3e9e162d8f586e0032f50ebc4042e5810a6a445b9003a88686b5e6;
        polys[6] = Abstractions.CompressedPolys(raw_poly);

        raw_poly = new uint256[](3);
        raw_poly[0] = 0x070d06ceebc2c30f786533c5c889d37a265dae572d01008d5986ba7417063cd0;
        raw_poly[1] = 0x1d2455519fe8dbf55e8c147c5522ec4230a304404c013f052e7bc6ca23d187a5;
        raw_poly[2] = 0x1e9d39750bdf8c30af499f1bace88fb1fdeb35347118b7b7ac4f417be03c54a2;
        polys[7] = Abstractions.CompressedPolys(raw_poly);

        raw_poly = new uint256[](3);
        raw_poly[0] = 0x0a6afb289757c1a82f2c00ddb16f3cff12059c1a813ee86713e937e5513e1b7a;
        raw_poly[1] = 0x2481748ac59cede267a591c2c23aad85d77fb8fccc274ed6d80f995a2052a421;
        raw_poly[2] = 0x12753b28dc1fefeb12a34002581b7686ee13c68e82f5be77ce017e423706b2fc;
        polys[8] = Abstractions.CompressedPolys(raw_poly);

        raw_poly = new uint256[](3);
        raw_poly[0] = 0x197d5a1a67529a05024648d97add5c68d4c58f4ba3372cc2786056057a917a85;
        raw_poly[1] = 0x2c56bde4dda09632e10edf38a09c567b7b63c689f631c7852926bca24de69872;
        raw_poly[2] = 0x06a2b0d09931ff4ece0a71f5efedfb6fbf8f82ae42d3301457c7de66d4d614a4;
        polys[9] = Abstractions.CompressedPolys(raw_poly);

        raw_poly = new uint256[](3);
        raw_poly[0] = 0x04d6eb7ce38b2d9d6b0b453bb6382b936417ba87cd2e8aa40f90ecb15ba8af6b;
        raw_poly[1] = 0x26d5d377faa1f9659b21f55062fceaef750c568c5aca9b5d0632c75bda8bf6ce;
        raw_poly[2] = 0x2ad16d9fbf4e6d7828c765fb4e44a5f9690a15ca252d6b7a5fda9be0485a59e2;
        polys[10] = Abstractions.CompressedPolys(raw_poly);

        raw_poly = new uint256[](3);
        raw_poly[0] = 0x2a4b75396e57eff44b2484c55c64fe80f99aadde25a6047c760c5a649187b506;
        raw_poly[1] = 0x1ee206befdd62021e311a16904b8ffb8236a7c1adb129bace94e55c3bf20330a;
        raw_poly[2] = 0x03a459c09dd330aa43c4e4df0d2776143c60a0470db7f2cfbb564e8a41866665;
        polys[11] = Abstractions.CompressedPolys(raw_poly);

        raw_poly = new uint256[](3);
        raw_poly[0] = 0x0b52dc9c5a018c166d74c3b4b7404fd1538b44706531ed7e4d87b25f698cc873;
        raw_poly[1] = 0x0232ad15e6648179c4374958e70b68eee4b40baa5742c7ab8f98218821583bd2;
        raw_poly[2] = 0x007f6edadcdb930a3bd4d533f343d7621f23036c4508e747cc43abe735eaf74a;
        polys[12] = Abstractions.CompressedPolys(raw_poly);

        raw_poly = new uint256[](3);
        raw_poly[0] = 0x2956ffc94b243c1a10f8143bdf140b13a000b92f0bd85e40fce6fc02cc1c2f38;
        raw_poly[1] = 0x2ed41e9ecc003b5edbab96f31d6589570a8e32048f488fe2df09fbc82c470911;
        raw_poly[2] = 0x1b6a95c9905965ebe17dd892806d41d46a7dddf7a395467a9d945bf4c82bc951;
        polys[13] = Abstractions.CompressedPolys(raw_poly);

        raw_poly = new uint256[](3);
        raw_poly[0] = 0x07ffa1abba9fde23ed3371afef2ccdb348ea456d75a6ff5b721aa293656829ea;
        raw_poly[1] = 0x1c73702c8cac73c0a09b10cee534d168bb5fd66201d9113849451c147e8f76ef;
        raw_poly[2] = 0x033ace5995e6f77016619846889b9ea6ebe4ffbf88a519cf0b1255edc4c0f2c3;
        polys[14] = Abstractions.CompressedPolys(raw_poly);

        raw_poly = new uint256[](3);
        raw_poly[0] = 0x185b84987e940ab0c3d29e9904b1eae645bf54da78ad14b93b6914d2c5742245;
        raw_poly[1] = 0x04d91349e02f45a0918fbbff73cb87fae20ccd51db42440ad15a501695bfed66;
        raw_poly[2] = 0x0205b6957fe051a9616fd8636c6193e8854edc6f2b6482c8c42461c1c8aa109a;
        polys[15] = Abstractions.CompressedPolys(raw_poly);

        raw_poly = new uint256[](3);
        raw_poly[0] = 0x1b04d58f255ef73a43e1877f72634f0a2e81e3048747b89928f9f79b3ee05753;
        raw_poly[1] = 0x177b8012744569f1f13f1619c7ac116e86d29d41a5440abf113a139b221770c4;
        raw_poly[2] = 0x02e939722530244b02e8c51d173e454ad81ee3a59ab11d3dc5180245f74af9a8;
        polys[16] = Abstractions.CompressedPolys(raw_poly);

        return polys;
    }

    function loadProof() private returns (Abstractions.CompressedSnark memory) {
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
            Field.reverse256(0x9a139e5911fa3cbb24e8dd66a7e6ad54057e5895adaa43be5b2cc8c1f7d8081e), l_u_secondary_X
        );
        proof.r_U_primary = Abstractions.RelaxedR1CSInstance(
            Field.reverse256(0x2515118a9651a9fbbb31e98929e94cf118f973f8227e4f5e3e19e8f86306fa07),
            Field.reverse256(0x576283d72a0a70468e57b0b0b163e2313bbc66a0c5fdb2a8f7a5126c10acc74d),
            r_u_primary_X,
            0x000000000000000000000000000000010a3cb5af114bc6094024d5e8b5817038
        );
        proof.r_U_secondary = Abstractions.RelaxedR1CSInstance(
            Field.reverse256(0x88bed3689a94506fe46065e5600749882804d3bf4793864638f641b3b2325157),
            Field.reverse256(0x924c225b250e5c8ad64bf84be692ab94a868f40c730086344eea3e979979d727),
            r_u_secondary_X,
            0x0000000000000000000000000000000178199520d5ba0196f34b2ac2a3e306f4
        );

        proof.zn_primary = new uint256[](1);
        proof.zn_primary[0] = 0x0000000000000000000000000000000000000000000000000000000000000001;

        proof.zn_secondary = new uint256[](1);
        proof.zn_secondary[0] = 0x0000000000000000000000000000000000000000000000000000000000258b63;

        proof.f_W_snark_secondary.sc_sat = Abstractions.SumcheckProof(loadScSatSecondary());

        proof.r_W_snark_primary.sc_sat = Abstractions.SumcheckProof(loadScSatPrimary());
        proof.r_W_snark_primary.eval_left_arr = new uint256[](8);
        proof.r_W_snark_primary.eval_left_arr[0] = 0x0ef000b81276352b38cb3d3e7234a7179804d62adb638d83f562edee497f2b6d;
        proof.r_W_snark_primary.eval_left_arr[1] = 0x117a66530f9bb91dfa70919d19dbaf358cc2a58b1330ad23f63db9441280a6c7;
        proof.r_W_snark_primary.eval_left_arr[2] = 0x18ea545d4586fed67f14b4d98be725eeaeda5236df68a6eaa0382a56d2943e20;
        proof.r_W_snark_primary.eval_left_arr[3] = 0x1bce95154441a8e07740d865c0b317fd2882248164c7baaec275d47da86eff09;
        proof.r_W_snark_primary.eval_left_arr[4] = 0x04abcf280503bc9a66657b8886ea7215df74575c6467a6b0b64c1b37fe5936c2;
        proof.r_W_snark_primary.eval_left_arr[5] = 0x0087ec02b6336c0370531e21c0a7ffd180244662785f144aa7b240b88a32e79b;
        proof.r_W_snark_primary.eval_left_arr[6] = 0x140a36ae7bc87a389af2915b9693d7d314169a3a2529465770a47d6b6103aab9;
        proof.r_W_snark_primary.eval_left_arr[7] = 0x182a8cb8bf58591bca0529935782760e035a7580f2e12b4eae7928f9e630ff71;

        proof.r_W_snark_primary.eval_right_arr = new uint256[](8);
        proof.r_W_snark_primary.eval_right_arr[0] = 0x0a0b46614dc65b9505af442bf6039df262d64ac0344705cc52a2ca7ffb6113b8;
        proof.r_W_snark_primary.eval_right_arr[1] = 0x1b9a3962d192653a9de75aafd715bfa0c988d7d84bbed2c3964f71bf93a39e51;
        proof.r_W_snark_primary.eval_right_arr[2] = 0x000d6f42a497dd23037e15b60796f9f25ad37d35cd3d25f8560ff7b446643700;
        proof.r_W_snark_primary.eval_right_arr[3] = 0x051f7d4269a87c6ec64be5625955e5ad240ca8de2012dbba328777a61c8161d4;
        proof.r_W_snark_primary.eval_right_arr[4] = 0x14e10eac716c6b83dd38974ff0a9ee5805749fe943e86183737c4e5bd9e9e44f;
        proof.r_W_snark_primary.eval_right_arr[5] = 0x2270610eeb59acc74d07f9d3340c04770824533394b3d4a458cda1fb75d6a851;
        proof.r_W_snark_primary.eval_right_arr[6] = 0x19aabebed2857fc58a19b02bfa8d8a7780caabde3e1ef04763abafecee116b1e;
        proof.r_W_snark_primary.eval_right_arr[7] = 0x163d41d8d013c2603624cedb7264ec815e58432dd96883069b46eafc89221dce;

        proof.r_W_snark_primary.eval_output_arr = new uint256[](8);
        proof.r_W_snark_primary.eval_output_arr[0] = 0x292663aafdc07100f088ec727fcd91e2895a8127b3d12bf54fc2ee98257abe91;
        proof.r_W_snark_primary.eval_output_arr[1] = 0x27f660a81d1453c38ae7dfab253a33434895222c121260ace32cfd12aec7b72c;
        proof.r_W_snark_primary.eval_output_arr[2] = 0x21677752a590d4a3920f561e474727383cc980973d00a4bcf5427add2d082e31;
        proof.r_W_snark_primary.eval_output_arr[3] = 0x22d860aefe3df0a262e7f1c06ed735b7b9bb3dfd574cfc3f342db845c6989991;
        proof.r_W_snark_primary.eval_output_arr[4] = 0x29a38d8a408b082340864809bb3bf3b984cf7f989ee93b70ebe21abd669f34be;
        proof.r_W_snark_primary.eval_output_arr[5] = 0x17bdfd62c6f3b6a3654bc9b62735edd8e0aa4a299a79915cdccfbc6c87f82cd4;
        proof.r_W_snark_primary.eval_output_arr[6] = 0x178d3f27b58cc3c478a05da31d79e7d6ce5fe94d96fe1ac9efd61739ccad18cd;
        proof.r_W_snark_primary.eval_output_arr[7] = 0x10cb56f93a46073caf9adec2d740a38339609feba8f640f5fa8e495645656019;

        proof.r_W_snark_primary.eval_Az = 0x1869c92844ee39c772ada2ff95041cfd30d520c02c2b6fd36957769338dc642e;
        proof.r_W_snark_primary.eval_Bz = 0x06294f00889dbe513fa56b4333b61b9929bae58203ebdf5022c5f50a5214d419;
        proof.r_W_snark_primary.eval_Cz = 0x2e853d4cce3097a6cc3ce6308a033f635b83706b762d0bb8b5f372daa90019db;
        proof.r_W_snark_primary.eval_E = 0x011bde0bb1a59fc9630ffabef3a13fe6a5d5e8c424ce36ecb66e3f73f222c844;

        proof.r_W_snark_primary.eval_E_row = 0x00ecd149fca8636f1ab0dec1093267aadc8048a235599a4e58511351de79bfb4;
        proof.r_W_snark_primary.eval_E_col = 0x07141dd079428a72a7f9ea25742d9f533d7c72909d37840673dcd9c2d0a6ceb0;
        proof.r_W_snark_primary.eval_val_A = 0x0f00fa9ce009193f1639936a4f2ada76bb13239a4e9f492a49643e3984928c04;
        proof.r_W_snark_primary.eval_val_B = 0x1ffe417d0bb8f7a36ec208ea1bcfc085f746cbcc64bd61756247be41d9986251;
        proof.r_W_snark_primary.eval_val_C = 0x2af914dc2e54d9dc1294d8517951f5438a3fe7a8b6eca78479652d42b20c9b34;

        proof.r_W_snark_primary.comm_Az =
            Field.reverse256(0xdf098f029e37047eae575b23452601bfbbd9564b579849db96ba82cbc59b5207);
        proof.r_W_snark_primary.comm_Bz =
            Field.reverse256(0x8fa380a96bd5d63d509012c97b83561cc6985e7a46aba2400638f1890eadd66b);
        proof.r_W_snark_primary.comm_Cz =
            Field.reverse256(0xa41d93e6b95748b81144dc6404251e9e588fb5471d43bd8378be79916b021f1d);

        proof.r_W_snark_primary.eval_Az_at_tau = 0x097d2f0f04da76f89507aee14f81cd17ef5336ccfd0671e28d800ddf2699e901;
        proof.r_W_snark_primary.eval_Bz_at_tau = 0x1a6e57b7624d8faea799b2cdb6bc38c9605cca7de025ee4e1e0fa72fec4bc62f;
        proof.r_W_snark_primary.eval_Cz_at_tau = 0x2bb867ad76aa20d64b96d05b9aae0b1be19f929d97a1a7d3dd785359866d39d7;
        proof.r_W_snark_primary.comm_E_row =
            Field.reverse256(0xf05f8ccfd418b65f97232bccd99f31cdd76d609deab93b6ad1480c2f9a77cb62);
        proof.r_W_snark_primary.comm_E_col =
            Field.reverse256(0xe47e9d2254e213adf96aae19aa8819b878596632ea400c1972e7f59cbfdae854);

        proof.r_W_snark_primary.claims_product_arr = new uint256[](8);
        proof.r_W_snark_primary.claims_product_arr[0] =
            0x0201a09a626851d4ef8791321138a1f3d7a14a845a9bdc96e20fbdda16e6ba7a;
        proof.r_W_snark_primary.claims_product_arr[1] =
            0x06d2db7d9f90f279981e63001babeadb5746ff5deb312636868975b22e2d7c21;
        proof.r_W_snark_primary.claims_product_arr[2] =
            0x1cc9b4253e2625e9ad6553072cfca4122a3c7b889503f98c0cb7f78a1299f03f;
        proof.r_W_snark_primary.claims_product_arr[3] =
            0x1286e6986c75f9a2945d7304b875f081a8a38b9199f0d102feb865d9e7e17ac8;
        proof.r_W_snark_primary.claims_product_arr[4] =
            0x28d26db13ee0eb81591e6a6d4a2269c6252335e18fd67499bed16f6babb9958a;
        proof.r_W_snark_primary.claims_product_arr[5] =
            0x23346e21193152b7add1886c932cccf64eef83c9adba3ff5d576cc234b8fde2e;
        proof.r_W_snark_primary.claims_product_arr[6] =
            0x005116fdc67e4e6654515a1d5895d73ac3aee1467f05cd43a14922fa5cdc0551;
        proof.r_W_snark_primary.claims_product_arr[7] =
            0x019c1f78dd1dc2096ba9e3b1b8842cc828982b50dfad09084580f1c9ce72ec03;

        proof.r_W_snark_primary.comm_output_arr = new uint256[](8);
        proof.r_W_snark_primary.comm_output_arr[0] =
            Field.reverse256(0x8207afd3c22f6e32a10f4a9a3654fbb4396f3dc1037c9936bad0187d5e55cc44);
        proof.r_W_snark_primary.comm_output_arr[1] =
            Field.reverse256(0xe3531f7702b6e544c6979161371e005e237f08b8f6299479ec4029fde453f32b);
        proof.r_W_snark_primary.comm_output_arr[2] =
            Field.reverse256(0x945184b555c7abf0eaedba972f986d5acdf5eb5b5efadc9b5ae5557c0f2f8213);
        proof.r_W_snark_primary.comm_output_arr[3] =
            Field.reverse256(0x4b06555fb822fa402194341239e4a449c5a305857aab196cd1f5389e525b7700);
        proof.r_W_snark_primary.comm_output_arr[4] =
            Field.reverse256(0x8a98c7f5274dbad12c87d2dedb2a4da6b1607c264d77b88a97fc42c9a49f160e);
        proof.r_W_snark_primary.comm_output_arr[5] =
            Field.reverse256(0xdac8f007925d3151d6f40b6af2f73c0f08d27d521f1f15b1fd63657d6b9c5d05);
        proof.r_W_snark_primary.comm_output_arr[6] =
            Field.reverse256(0xda938f3ec9f68493e05698ec5dbe2bcea97f2c8bd901bf9230c65c6510c31664);
        proof.r_W_snark_primary.comm_output_arr[7] =
            Field.reverse256(0x6442326799bae8fd718752de74057b6d7a74ccc9373e9607b19ea8f2524e6b2a);

        proof.f_W_snark_secondary.eval_left_arr = new uint256[](8);
        proof.f_W_snark_secondary.eval_left_arr[0] = 0x25fb4b748551171f8c709173c983be713bc4728243d8a81ae83f3b038953ef3d;
        proof.f_W_snark_secondary.eval_left_arr[1] = 0x16415fde97fa76eaa7f4f37a7a9af3e2b1406c0492e88aed6dd2f4f5f3f9e6d3;
        proof.f_W_snark_secondary.eval_left_arr[2] = 0x1caf6407dfa56818d2b4a466a49458183e64b673aa1c1f7b514b9606ad7e761c;
        proof.f_W_snark_secondary.eval_left_arr[3] = 0x09b716a7bdc1872989f25728ab3be170d9d42d27f4c4995f6fb3eb2e21262a13;
        proof.f_W_snark_secondary.eval_left_arr[4] = 0x09dbaaba3efdfce1ba21d954fd8d2c770b7e926de103dd022a93d1fbef34ed4e;
        proof.f_W_snark_secondary.eval_left_arr[5] = 0x257e5abab02753594b43642244d943e0b62c6f69ecdb9edd50de4570e1d56cbf;
        proof.f_W_snark_secondary.eval_left_arr[6] = 0x17da0d5ee21a31637594d3158d5761da772410b1cc155236a8c4b473d5e207a3;
        proof.f_W_snark_secondary.eval_left_arr[7] = 0x06f159eb0698a62cdc3de8654feaeb91a8ebcd6f4ae080a9a28af8365523d71a;

        proof.f_W_snark_secondary.eval_right_arr = new uint256[](8);
        proof.f_W_snark_secondary.eval_right_arr[0] = 0x17f014db8c797ae3df688e23fcfead1babfe9d162a4cd748f11f7e718ba0f06c;
        proof.f_W_snark_secondary.eval_right_arr[1] = 0x200b4c0cbb3a21eb84b6cee946f3d99625ffaf321f890bdb1c0f2c69d136ea65;
        proof.f_W_snark_secondary.eval_right_arr[2] = 0x2dfaa34eddab6c619093e6d0dc1f769c8ea95a445779371a0d4a60f9edac94e0;
        proof.f_W_snark_secondary.eval_right_arr[3] = 0x1d5b4d6bb5fbcd39bc4624512539f2e2b080bbe9de588754166e5d18994eb5dd;
        proof.f_W_snark_secondary.eval_right_arr[4] = 0x2720bbdfc2f7c19617741fe4e2189686c8bf8a4849a5f51e7857bf9a86eee150;
        proof.f_W_snark_secondary.eval_right_arr[5] = 0x220c22230d6121df08aa7915503b05b3735db61f6c7089fd2af8e41bb6953fb6;
        proof.f_W_snark_secondary.eval_right_arr[6] = 0x218ffb6f1b2d239b30c7243a8bbcad6bd45ebd7e47f2ffbf4c3e4979ffb1e1dc;
        proof.f_W_snark_secondary.eval_right_arr[7] = 0x0bc89e5f4820dc4e43ea5d3fa2ced37f8fc849506d09a4cc6e626a3aa200d70f;

        proof.f_W_snark_secondary.eval_output_arr = new uint256[](8);
        proof.f_W_snark_secondary.eval_output_arr[0] =
            0x22f60a9ca0c0bb086bb59cfc8c26a1952c14dfbd41a9fb812a6f5b163a0043fa;
        proof.f_W_snark_secondary.eval_output_arr[1] =
            0x16ab81080a358cc335fa13524b1a4f1088597106fa42375e2884aefcf76dd3c5;
        proof.f_W_snark_secondary.eval_output_arr[2] =
            0x088f3d784385edf07cdfd6b4d8d4d6ffd9103cdf5297d3d519fdf784149bc3c0;
        proof.f_W_snark_secondary.eval_output_arr[3] =
            0x1af37f26f584dae6d8407e00e60c0422d93e0291a4d7b2469d0bfa487cf56564;
        proof.f_W_snark_secondary.eval_output_arr[4] =
            0x0863619c2addf1fe325f35e082a246a25515b6fc2685555249b62b9777e03ab5;
        proof.f_W_snark_secondary.eval_output_arr[5] =
            0x0f9fd1704a83c3be74e2cf1cf17931f8e02cde13d7799a18c6777afca975fa1e;
        proof.f_W_snark_secondary.eval_output_arr[6] =
            0x09ff85fd2291d902b7450a8b1c8384ac4b6215bf7c785951cc1a7e75de7142fd;
        proof.f_W_snark_secondary.eval_output_arr[7] =
            0x01cba7922145bd0a470c62236a7c85913c48c9f0fe4b3d3e007ee56af773c9fe;

        proof.f_W_snark_secondary.eval_Az = 0x061152dfca99a38e7c0f33e7bf37232e30775a541c5c695799d111e8e815d70d;
        proof.f_W_snark_secondary.eval_Bz = 0x11a2669b59ea53e92bcd84311ac04a2f06ea2df2cc6c0c26f170b24e2b27b2f9;
        proof.f_W_snark_secondary.eval_Cz = 0x0d3a3e3e7c117e3c5d081099a5dbe33450eac5b779fda5454a8d871bb1efb705;
        proof.f_W_snark_secondary.eval_E = 0x2ad024657205bb9046e2b5c9e8d7f645449df1497cf08e44adbe64f3baf100dd;

        proof.f_W_snark_secondary.eval_E_row = 0x13eb9b4d9cd546509f9bbd6776e869b25e825220b13d8a8f058e059691f557dd;
        proof.f_W_snark_secondary.eval_E_col = 0x0836f29dba76b5306d17d9e86ea76824a342c8aa124d8c49645128167066a71c;
        proof.f_W_snark_secondary.eval_val_A = 0x0cf93bd2d1465cadb1e7577a09166857378c2422f34f24df0ecabfc6141f5721;
        proof.f_W_snark_secondary.eval_val_B = 0x1b25d17955a5dbbfa7584d1eabe26b37b072d154e0c950a17034475f7155d83c;
        proof.f_W_snark_secondary.eval_val_C = 0x10753e7c91f0aba812b52e835b3a427de7824b4716c054345ec419832be3a8dd;

        proof.nifs_compressed_comm_T =
            Field.reverse256(0xc0b26879c0a5912d9d85cd81be8ebe3398fb6ee3a9af76d7f4146f8bc81f9768);

        proof.f_W_snark_secondary.comm_Az =
            Field.reverse256(0xdca16971a206ef75dedcb488bc0530031460f9e20c1157a9e20797590a5c720e);
        proof.f_W_snark_secondary.comm_Bz =
            Field.reverse256(0x851fe771399c781fdea430a9569dd40fff0130238666246466b6a4763802371d);
        proof.f_W_snark_secondary.comm_Cz =
            Field.reverse256(0x0dd3e71c4e4e035b38e8708f2075eaef69eabb7fe3c591009d45f265311ab654);

        proof.f_W_snark_secondary.eval_Az_at_tau = 0x24bc61f0b6913ec61647989e9eb39a168a2a2b6d05f2e099bb07242f1127e63f;
        proof.f_W_snark_secondary.eval_Bz_at_tau = 0x13f6efaa3fde0c6ff835f00448b307b9403ac20ba47b7915fca6e02c3018c395;
        proof.f_W_snark_secondary.eval_Cz_at_tau = 0x0f23073b528563adab10909f2a2b207ff1e1a40d8205df05acb8924e80c9156c;
        proof.f_W_snark_secondary.comm_E_row =
            Field.reverse256(0xde19f4ead2f447cf55053bc84ddea67501e25fb5ff250511734f8f69357bf765);
        proof.f_W_snark_secondary.comm_E_col =
            Field.reverse256(0xded41621a1c4bbc89271526938742e4a7932e07d2917767473976668c969f063);

        proof.f_W_snark_secondary.claims_product_arr = new uint256[](8);
        proof.f_W_snark_secondary.claims_product_arr[0] =
            0x23beefb3ce026f18b3972eeada581ac2f7415c52810d85f54b2d80dac1f4636e;
        proof.f_W_snark_secondary.claims_product_arr[1] =
            0x2347884fb000f6654566e2c52f544bb17d01e1c72bf01049f4bfd797d244ac59;
        proof.f_W_snark_secondary.claims_product_arr[2] =
            0x2cc9ceb9aa0a0a7519c311d4cf9bd49cf4e2e61d4eca324a4d02f2803d4c7318;
        proof.f_W_snark_secondary.claims_product_arr[3] =
            0x1472e71646360c655f1010e9b52dc7773ab8a24e750308281f608bfd0b63b7d4;
        proof.f_W_snark_secondary.claims_product_arr[4] =
            0x16ec59f754f13dd9e84d00c67ec8b0002d755fb5c062e73842d0b7c7e4acb037;
        proof.f_W_snark_secondary.claims_product_arr[5] =
            0x0eb4780e996313051e35c09178dc85f387f507a7f116868f7be302c942a201b6;
        proof.f_W_snark_secondary.claims_product_arr[6] =
            0x1c8e1f79e27395ef092ee76fea91e3f284ad79cabe56914c786eb824d39b9c29;
        proof.f_W_snark_secondary.claims_product_arr[7] =
            0x2bbe0401fc98e5ec9251dab3e11eeb7fb3ac22284f3a97dce2c12cedd91d76f0;

        proof.f_W_snark_secondary.comm_output_arr = new uint256[](8);
        proof.f_W_snark_secondary.comm_output_arr[0] =
            Field.reverse256(0xd5c9dbeffc61e4250c921b000997ce6af68f02aaa20a07ce5f66a1723fc90e1d);
        proof.f_W_snark_secondary.comm_output_arr[1] =
            Field.reverse256(0xe71504e3e4666cabe33fd97064a6d37f4540bba66b516d3a05687ce0455f056f);
        proof.f_W_snark_secondary.comm_output_arr[2] =
            Field.reverse256(0xc4588ecac01048d575eb8014cd53d64f3b0d3fc7cb4fdf4a7d79f0da1fbaf222);
        proof.f_W_snark_secondary.comm_output_arr[3] =
            Field.reverse256(0xafddf998213180de1968e305f2eca877041821414cf325d2ac6886e240212a61);
        proof.f_W_snark_secondary.comm_output_arr[4] =
            Field.reverse256(0xd7527c4a14dcd56e042c8713ce125e348a553173eec3777a51288ec830f18b15);
        proof.f_W_snark_secondary.comm_output_arr[5] =
            Field.reverse256(0x5718aa0cd2185b108c01f3bde8736fe30acf1497581b69cf763255b55dcf0442);
        proof.f_W_snark_secondary.comm_output_arr[6] =
            Field.reverse256(0x03cfecdb80f69725d116984a46b6bc128496d7913c048122f540b26f752bf00b);
        proof.f_W_snark_secondary.comm_output_arr[7] =
            Field.reverse256(0x1317160bd8930efe857d8c38d2ce2ac4da31cbcf6503f6cfe44cd4e91fcfca07);

        return proof;
    }

    function loadPublicParameters() private returns (Abstractions.VerifierKey memory) {
        Abstractions.VerifierKey memory vk;

        vk.f_arity_primary = 1;
        vk.digest = 0x03e0cc9d0a2e880508793f5f2b0e202504238d16bede6fba0c963b3842ec2d78;
        vk.f_arity_secondary = 1;

        vk.vk_secondary.S_comm.N = 131072;
        vk.vk_secondary.digest = 0x0128d4daf76a6843c8e5f0b3107402752bfcb1df7544eda6ff310aae6dc70461;
        vk.vk_primary.S_comm.N = 131072;
        vk.vk_primary.digest = 0x007d6ee1d4f8d6837799de0fd3918e08a9ed40d6c0dd19683a70db98655d84be;

        return vk;
    }

    function load_transcript_claim_sat_final_r_sat_secondary()
        private
        returns (KeccakTranscriptLib.KeccakTranscript memory)
    {
        uint16 rounds = 38;
        uint8[] memory state = new uint8[](64);
        state[0] = 0xde;
        state[1] = 0xbd;
        state[2] = 0xdf;
        state[3] = 0x8e;
        state[4] = 0x62;
        state[5] = 0xec;
        state[6] = 0x69;
        state[7] = 0x23;
        state[8] = 0x51;
        state[9] = 0x1a;
        state[10] = 0xae;
        state[11] = 0xbe;
        state[12] = 0x34;
        state[13] = 0x7b;
        state[14] = 0x44;
        state[15] = 0x4a;
        state[16] = 0x09;
        state[17] = 0x06;
        state[18] = 0xa0;
        state[19] = 0x73;
        state[20] = 0xe4;
        state[21] = 0x1c;
        state[22] = 0x2f;
        state[23] = 0x0a;
        state[24] = 0x02;
        state[25] = 0xb8;
        state[26] = 0x99;
        state[27] = 0x5c;
        state[28] = 0xf5;
        state[29] = 0xc5;
        state[30] = 0x5a;
        state[31] = 0x8e;
        state[32] = 0x3c;
        state[33] = 0xbb;
        state[34] = 0xb2;
        state[35] = 0x39;
        state[36] = 0x0d;
        state[37] = 0x0a;
        state[38] = 0x8f;
        state[39] = 0xc0;
        state[40] = 0x39;
        state[41] = 0x77;
        state[42] = 0x37;
        state[43] = 0x42;
        state[44] = 0x96;
        state[45] = 0x26;
        state[46] = 0x24;
        state[47] = 0x19;
        state[48] = 0x28;
        state[49] = 0x46;
        state[50] = 0xfa;
        state[51] = 0x41;
        state[52] = 0xf4;
        state[53] = 0xbb;
        state[54] = 0xff;
        state[55] = 0x72;
        state[56] = 0x0a;
        state[57] = 0x82;
        state[58] = 0xdc;
        state[59] = 0x16;
        state[60] = 0xab;
        state[61] = 0x74;
        state[62] = 0xd5;
        state[63] = 0x93;

        uint8[] memory transcript = new uint8[](0);

        return KeccakTranscriptLib.KeccakTranscript(rounds, state, transcript);
    }

    function load_transcript_claim_sat_final_r_sat_primary()
        private
        returns (KeccakTranscriptLib.KeccakTranscript memory)
    {
        uint16 rounds = 38;
        uint8[] memory state = new uint8[](64);
        state[0] = 0xc6;
        state[1] = 0xbe;
        state[2] = 0x8c;
        state[3] = 0x76;
        state[4] = 0x60;
        state[5] = 0x1e;
        state[6] = 0x19;
        state[7] = 0x40;
        state[8] = 0x55;
        state[9] = 0x00;
        state[10] = 0xe1;
        state[11] = 0x4c;
        state[12] = 0x32;
        state[13] = 0x11;
        state[14] = 0xe2;
        state[15] = 0xfa;
        state[16] = 0x60;
        state[17] = 0x1b;
        state[18] = 0x74;
        state[19] = 0x24;
        state[20] = 0x13;
        state[21] = 0xaa;
        state[22] = 0x08;
        state[23] = 0x15;
        state[24] = 0x84;
        state[25] = 0xb7;
        state[26] = 0x27;
        state[27] = 0xf4;
        state[28] = 0x29;
        state[29] = 0x0f;
        state[30] = 0x2a;
        state[31] = 0x9c;
        state[32] = 0xff;
        state[33] = 0x9a;
        state[34] = 0x1d;
        state[35] = 0x36;
        state[36] = 0x6c;
        state[37] = 0x4f;
        state[38] = 0x4b;
        state[39] = 0x32;
        state[40] = 0xac;
        state[41] = 0xd3;
        state[42] = 0xbf;
        state[43] = 0x85;
        state[44] = 0x85;
        state[45] = 0xb8;
        state[46] = 0xb1;
        state[47] = 0x78;
        state[48] = 0x52;
        state[49] = 0x5f;
        state[50] = 0x74;
        state[51] = 0xd5;
        state[52] = 0x5f;
        state[53] = 0xec;
        state[54] = 0xcc;
        state[55] = 0x4a;
        state[56] = 0x35;
        state[57] = 0x3c;
        state[58] = 0x04;
        state[59] = 0x33;
        state[60] = 0x5b;
        state[61] = 0x05;
        state[62] = 0x30;
        state[63] = 0x9f;

        uint8[] memory transcript = new uint8[](0);

        return KeccakTranscriptLib.KeccakTranscript(rounds, state, transcript);
    }

    function test_compute_claim_sat_final_r_sat_secondary() public {
        Abstractions.CompressedSnark memory proof = loadProof();
        Abstractions.VerifierKey memory public_parameters = loadPublicParameters();
        KeccakTranscriptLib.KeccakTranscript memory transcript = load_transcript_claim_sat_final_r_sat_secondary();

        uint256[] memory coeffs = new uint256[](10);
        coeffs[0] = 0x06b9fdfdd087e70a4406bda6c64e0f963ce7c3a9bf0138bb1e0e927f79c93fc6;
        coeffs[1] = 0x00112af6f9b3b907841a027f3313cfc6b25002f4a27e6ab351975e4bb253bc6c;
        coeffs[2] = 0x05087e8b190a9bc530fc26d3d1bc51232d3b5a46b1de2448c989afcb777e8c27;
        coeffs[3] = 0x022e6cc28339a6b0d4a2f0a6e9c72c0f96ef496b456447eb6bf4c96883214cce;
        coeffs[4] = 0x0e139d556747dec01f825f2aa90fc51e3554a06c6a2f4ac3c80e033f0065f912;
        coeffs[5] = 0x1086ff53d9bffe3547bba12fda6c540ae8b455a8bf63940288d962ef228c39a4;
        coeffs[6] = 0x16d46121abb741e67efac4d370948215f616e23a9f8b0ead8e12b2abdc4d6b15;
        coeffs[7] = 0x207712552990c20dc5bed713b0d494d6c361e7f85bf905ea71268c4fac80f52d;
        coeffs[8] = 0x167e7264ac46492506b6e851d4296de177e826d99eb27916267069f42c021f42;
        coeffs[9] = 0x1ef00a82010cd1db42e84b414588c50e07a6b66c6d74caff6c50c2b4bd162538;

        uint256 claim_inner = 0x208f3bc09df6f6eb01595a7d7708a2f7d8dafff813f123a4abdd99dfef2ff3aa;
        uint256 num_rounds_sat = 131072;

        uint256 claim_set_final;
        uint256[] memory r_sat;
        (claim_set_final, r_sat, transcript) = Step3GrumpkinLib.compute_claim_sat_final_r_sat_secondary(
            proof.f_W_snark_secondary,
            public_parameters.vk_secondary,
            transcript,
            claim_inner,
            coeffs,
            Grumpkin.P_MOD,
            false
        );

        assertEq(claim_set_final, 0x20861acdc6acbe72e35b394b175cc90d29c8cc5e6c42ed919f96737eefb0081e);
        assertEq(r_sat[0], 0x25172cbbd1289dde3d5a3ec6806b7408475968df10e71565ca1ba3579b950bab);
        assertEq(r_sat[1], 0x1725a070098a94cf768334d9b0c3ac4a261682687b39c8e6db7ad3c2901d5e24);
        assertEq(r_sat[2], 0x26b72d7895ccf170139a9a71e7da7431d81afd3cd5223969d4794ca8b1366241);
        assertEq(r_sat[3], 0x2c9493e9d5b214b3cad4bb621544e6001cb1dc10421ede559fb937d89568cd01);
        assertEq(r_sat[4], 0x1334cd36b6c002cd14bd1ac0e19bfca3b7fe600634fa22ac5d6fc6b271c50ea1);
        assertEq(r_sat[5], 0x24e56409afcdd7500f2608d82db8f7a607cb1c5246aaa03cb30fdab50e6b0131);
        assertEq(r_sat[6], 0x27ee3e707f58a066bd5c0c4078fc690de3d108a7f759884c0d890dcf9c71d0ae);
        assertEq(r_sat[7], 0x12060dfdd8c1fceaba38ac16288cd391e1bd33e08476edde5dafa859d2bc20c3);
        assertEq(r_sat[8], 0x1715421e99f5091ab24230608160f638748e685707ded14d8df5e502eff1c726);
        assertEq(r_sat[9], 0x21225c719bfbac3279313676bb52f31d166432319612381d19e29680a23a9e54);
        assertEq(r_sat[10], 0x1f5f277e7a112badb02d8cd4794afac553a48acec6eb4895fd4ac287309e0766);
        assertEq(r_sat[11], 0x01c6ef7072eae3366e9bac92954116f78dba97d93b34943cdbca7473e03c303c);
        assertEq(r_sat[12], 0x2d724a66a4244a6a493bbf6f10e9a1aefce0702e21bc3d1995f4741e0d20e0b6);
        assertEq(r_sat[13], 0x287e29cb6788fd94d01ef493dbff1e658619a05ce4fdd1541726bff3cbe8b33b);
        assertEq(r_sat[14], 0x106e96134b2e80dc2b4691a8c3ecfc2ea1ef0ab294c5f708cd6774bfeb403009);
        assertEq(r_sat[15], 0x2fe84884f541263540ef28f6f103eeccb2413af5378e27d63469466568f56e84);
        assertEq(r_sat[16], 0x19a2ee861704322444687829379a8303142709c02feb0f0d56de44c5ab0540e2);
    }

    function test_compute_claim_sat_final_r_sat_primary() public {
        Abstractions.CompressedSnark memory proof = loadProof();
        Abstractions.VerifierKey memory public_parameters = loadPublicParameters();
        KeccakTranscriptLib.KeccakTranscript memory transcript = load_transcript_claim_sat_final_r_sat_primary();

        uint256[] memory coeffs = new uint256[](10);
        coeffs[0] = 0x0e19eb06be084639c9a38e2a2b7af3cab93019ddfe9ad10246aeeb4e3adfdae2;
        coeffs[1] = 0x04dcaf34a19e10fa1f30facfb9b45321985e9c74afd17ba1d388a2c64045716d;
        coeffs[2] = 0x20aaee132183c23f1b760d945209c606c4f2a50a49e930af0fb069ff1b0edf5c;
        coeffs[3] = 0x23d9953ef7a418e92db1be9fd9e2c6f9610ef3c0be8209194936b87c825ba766;
        coeffs[4] = 0x09468bff657b77d3e4eae5a3a4b9540ac3c3749e092e1b6b4e21eb43ed55b8df;
        coeffs[5] = 0x19f2d55ce1ff0283abfca94e2bbc81e5225b45eeb5d961f4409f1d4d08010ea0;
        coeffs[6] = 0x1958537551667ec0c0eef109115b24b406fc1be51a60c9de452b72730a72166f;
        coeffs[7] = 0x237e6312c199f1745c02d486d863d2c71e09df3cd4e45184581b406254b11e90;
        coeffs[8] = 0x0f06e6e56929291faa5298bcdeab3d24be04d97a43570bc71e71c567c021d0e0;
        coeffs[9] = 0x2caf452f74e4f5dca0a18764e9a3a289c9a894f826dd791faafc409a46f94b94;

        uint256 claim_inner = 0x08353df9bb3663c3258222e99684ee10f83abc2931f0c4e1918a49e75498fc1d;
        uint256 num_rounds_sat = 131072;

        uint256 claim_set_final;
        uint256[] memory r_sat;
        (claim_set_final, r_sat, transcript) = Step3GrumpkinLib.compute_claim_sat_final_r_sat_primary(
            proof.r_W_snark_primary, public_parameters.vk_primary, transcript, claim_inner, coeffs, Bn256.R_MOD, false
        );

        assertEq(claim_set_final, 0x022651e7f1606e914295e5345ee9bad95a4dd1100ae7b797c617d47871eb1088);
        assertEq(r_sat[0], 0x144454412fd8764e4aaf2cec1546f1a9f1f154e7de160d033a632ecdfdd5964d);
        assertEq(r_sat[1], 0x05837413e5049a37ef21bc91fd21fcce3f89e80202ec70aa01872cc9221d95cd);
        assertEq(r_sat[2], 0x17430b827b82e51b14fcdf9511b6a8061d1392d4589b8221dafbae759dd6e070);
        assertEq(r_sat[3], 0x0256f4d5674a529ec39e0afba3738d0263cb1d385a563ce608edad719f47d5fd);
        assertEq(r_sat[4], 0x00f87554a6caed435bb9e714a355fa73cfd359d5dd8b31fc172ada8cecd7ee30);
        assertEq(r_sat[5], 0x29b4dbb7be87a4961e21fe447b03125469077ba2bad896ac2c374aa55be358ab);
        assertEq(r_sat[6], 0x1493591a52ded39471fbcd9937537aae9023e77080708f790798671aaa268fc9);
        assertEq(r_sat[7], 0x046d5e95bee7ea383f29e0ffa2a6e2816d5b82a75283265e2bc17e63d6ecaeee);
        assertEq(r_sat[8], 0x0ea46d83cda8cac4084d937137ab451e89d3fef4b6e25ec00e80fcb8bf8a5308);
        assertEq(r_sat[9], 0x26d16ee1e12b5e781327f54a2b89bb7f397e500ec503066b4e37c5e59c372aa1);
        assertEq(r_sat[10], 0x2826c37882e6cec0184d476e6e14ac3cb48aee6e233a1ee085c174d53cf1f419);
        assertEq(r_sat[11], 0x1b054f124db95f87ec662a5b8ddf47f2b0264e97ef866a05e2a3e0335bce3b16);
        assertEq(r_sat[12], 0x0fd296132bf7fc749c44059331d68c735b05f8f746c26e0bf25c3e0a0e6b17b1);
        assertEq(r_sat[13], 0x2aede350fab3723fb2ed55ed281f40e4a718f43237901e99264cb09a586661ef);
        assertEq(r_sat[14], 0x1a99798029810bbe8a2a5e0d738e8a7c54c010acf84892178463c3222d08b351);
        assertEq(r_sat[15], 0x01611bd374a32895d454f4fbe32f051f82e1fef13242ee7951dc6df7848cef97);
        assertEq(r_sat[16], 0x019b91a9d375fe46af22a415a0cba65d78d7a605eecf99b3eff27cd508e6282c);
    }

    function test_compute_claim_mem_final_primary() public {
        Abstractions.CompressedSnark memory proof = loadProof();

        uint256[] memory coeffs = new uint256[](10);
        coeffs[0] = 0x0e19eb06be084639c9a38e2a2b7af3cab93019ddfe9ad10246aeeb4e3adfdae2;
        coeffs[1] = 0x04dcaf34a19e10fa1f30facfb9b45321985e9c74afd17ba1d388a2c64045716d;
        coeffs[2] = 0x20aaee132183c23f1b760d945209c606c4f2a50a49e930af0fb069ff1b0edf5c;
        coeffs[3] = 0x23d9953ef7a418e92db1be9fd9e2c6f9610ef3c0be8209194936b87c825ba766;
        coeffs[4] = 0x09468bff657b77d3e4eae5a3a4b9540ac3c3749e092e1b6b4e21eb43ed55b8df;
        coeffs[5] = 0x19f2d55ce1ff0283abfca94e2bbc81e5225b45eeb5d961f4409f1d4d08010ea0;
        coeffs[6] = 0x1958537551667ec0c0eef109115b24b406fc1be51a60c9de452b72730a72166f;
        coeffs[7] = 0x237e6312c199f1745c02d486d863d2c71e09df3cd4e45184581b406254b11e90;
        coeffs[8] = 0x0f06e6e56929291faa5298bcdeab3d24be04d97a43570bc71e71c567c021d0e0;
        coeffs[9] = 0x2caf452f74e4f5dca0a18764e9a3a289c9a894f826dd791faafc409a46f94b94;

        uint256 rand_eq_bound_r_sat = 0x068e5f0276fc2c444801d9001999d65176cbf7ba8be3d57ccb2f517e03d6438f;
        uint256 expected = Step3GrumpkinLib.compute_claim_mem_final(
            proof.r_W_snark_primary, coeffs, rand_eq_bound_r_sat, Bn256.R_MOD, Bn256.negateScalar
        );
        assertEq(expected, 0x24fea9bfdc4e5678471d48bbf380e7740f095cf53e39e0b41ea40d9f4e28c7c4);
    }

    function test_compute_claim_mem_final_secondary() public {
        Abstractions.CompressedSnark memory proof = loadProof();

        uint256[] memory coeffs = new uint256[](10);
        coeffs[0] = 0x06b9fdfdd087e70a4406bda6c64e0f963ce7c3a9bf0138bb1e0e927f79c93fc6;
        coeffs[1] = 0x00112af6f9b3b907841a027f3313cfc6b25002f4a27e6ab351975e4bb253bc6c;
        coeffs[2] = 0x05087e8b190a9bc530fc26d3d1bc51232d3b5a46b1de2448c989afcb777e8c27;
        coeffs[3] = 0x022e6cc28339a6b0d4a2f0a6e9c72c0f96ef496b456447eb6bf4c96883214cce;
        coeffs[4] = 0x0e139d556747dec01f825f2aa90fc51e3554a06c6a2f4ac3c80e033f0065f912;
        coeffs[5] = 0x1086ff53d9bffe3547bba12fda6c540ae8b455a8bf63940288d962ef228c39a4;
        coeffs[6] = 0x16d46121abb741e67efac4d370948215f616e23a9f8b0ead8e12b2abdc4d6b15;
        coeffs[7] = 0x207712552990c20dc5bed713b0d494d6c361e7f85bf905ea71268c4fac80f52d;
        coeffs[8] = 0x167e7264ac46492506b6e851d4296de177e826d99eb27916267069f42c021f42;
        coeffs[9] = 0x1ef00a82010cd1db42e84b414588c50e07a6b66c6d74caff6c50c2b4bd162538;

        uint256 rand_eq_bound_r_sat = 0x1b54facee683a1558bf5a6a4ead11246c3c1a6d7b852aa6335836502badbc588;
        uint256 expected = Step3GrumpkinLib.compute_claim_mem_final(
            proof.f_W_snark_secondary, coeffs, rand_eq_bound_r_sat, Grumpkin.P_MOD, Grumpkin.negateBase
        );
        assertEq(expected, 0x251d3ac8e236c65a4ced88ea672bc78906650b68c43627db9686096681d97b38);
    }

    function test_compute_claim_outer_final_primary() public {
        Abstractions.CompressedSnark memory proof = loadProof();
        uint256 r_U_primary_u = 0x000000000000000000000000000000010a3cb5af114bc6094024d5e8b5817038;
        uint256 taus_bound_r_sat = 0x0d3df376a736ac4d9ebfa86607dbdba7fdcc91cc5da7e1c4e61534f825d84fa4;
        uint256[] memory coeffs = new uint256[](10);
        coeffs[0] = 0x0e19eb06be084639c9a38e2a2b7af3cab93019ddfe9ad10246aeeb4e3adfdae2;
        coeffs[1] = 0x04dcaf34a19e10fa1f30facfb9b45321985e9c74afd17ba1d388a2c64045716d;
        coeffs[2] = 0x20aaee132183c23f1b760d945209c606c4f2a50a49e930af0fb069ff1b0edf5c;
        coeffs[3] = 0x23d9953ef7a418e92db1be9fd9e2c6f9610ef3c0be8209194936b87c825ba766;
        coeffs[4] = 0x09468bff657b77d3e4eae5a3a4b9540ac3c3749e092e1b6b4e21eb43ed55b8df;
        coeffs[5] = 0x19f2d55ce1ff0283abfca94e2bbc81e5225b45eeb5d961f4409f1d4d08010ea0;
        coeffs[6] = 0x1958537551667ec0c0eef109115b24b406fc1be51a60c9de452b72730a72166f;
        coeffs[7] = 0x237e6312c199f1745c02d486d863d2c71e09df3cd4e45184581b406254b11e90;
        coeffs[8] = 0x0f06e6e56929291faa5298bcdeab3d24be04d97a43570bc71e71c567c021d0e0;
        coeffs[9] = 0x2caf452f74e4f5dca0a18764e9a3a289c9a894f826dd791faafc409a46f94b94;

        uint256 expected = Step3GrumpkinLib.compute_claim_outer_final(
            proof.r_W_snark_primary, r_U_primary_u, coeffs, taus_bound_r_sat, Bn256.R_MOD, Bn256.negateScalar
        );
        assertEq(expected, 0x19519a6219996bc7036849a928da6d92b99e3aab2e23c741b0c68160ace8d0c6);
    }

    function test_compute_claim_outer_final_secondary() public {
        Abstractions.CompressedSnark memory proof = loadProof();
        uint256 f_U_secondary_u = 0x00000000000000000000000000000001d523e9da28bbf206fe50868f52ca6334;
        uint256 taus_bound_r_sat = 0x12cfbfe7452ad6c7ce007bf542b0f869bc3924ef822732e8a727f87517af7463;
        uint256[] memory coeffs = new uint256[](10);
        coeffs[0] = 0x06b9fdfdd087e70a4406bda6c64e0f963ce7c3a9bf0138bb1e0e927f79c93fc6;
        coeffs[1] = 0x00112af6f9b3b907841a027f3313cfc6b25002f4a27e6ab351975e4bb253bc6c;
        coeffs[2] = 0x05087e8b190a9bc530fc26d3d1bc51232d3b5a46b1de2448c989afcb777e8c27;
        coeffs[3] = 0x022e6cc28339a6b0d4a2f0a6e9c72c0f96ef496b456447eb6bf4c96883214cce;
        coeffs[4] = 0x0e139d556747dec01f825f2aa90fc51e3554a06c6a2f4ac3c80e033f0065f912;
        coeffs[5] = 0x1086ff53d9bffe3547bba12fda6c540ae8b455a8bf63940288d962ef228c39a4;
        coeffs[6] = 0x16d46121abb741e67efac4d370948215f616e23a9f8b0ead8e12b2abdc4d6b15;
        coeffs[7] = 0x207712552990c20dc5bed713b0d494d6c361e7f85bf905ea71268c4fac80f52d;
        coeffs[8] = 0x167e7264ac46492506b6e851d4296de177e826d99eb27916267069f42c021f42;
        coeffs[9] = 0x1ef00a82010cd1db42e84b414588c50e07a6b66c6d74caff6c50c2b4bd162538;

        uint256 expected = Step3GrumpkinLib.compute_claim_outer_final(
            proof.f_W_snark_secondary, f_U_secondary_u, coeffs, taus_bound_r_sat, Grumpkin.P_MOD, Grumpkin.negateBase
        );
        assertEq(expected, 0x2f45328586b29dfb5a3feeeba4922647b06c9f34d9f703d09cb61b521604a694);
    }

    function test_compute_claim_inner_final_primary() public {
        Abstractions.CompressedSnark memory proof = loadProof();

        uint256 c_inner = 0x2f605dd314f54ceca331da1c09337e0a1e92df731c8e641ad7b7dd4d19f5a0c0;

        uint256[] memory coeffs = new uint256[](10);
        coeffs[0] = 0x0e19eb06be084639c9a38e2a2b7af3cab93019ddfe9ad10246aeeb4e3adfdae2;
        coeffs[1] = 0x04dcaf34a19e10fa1f30facfb9b45321985e9c74afd17ba1d388a2c64045716d;
        coeffs[2] = 0x20aaee132183c23f1b760d945209c606c4f2a50a49e930af0fb069ff1b0edf5c;
        coeffs[3] = 0x23d9953ef7a418e92db1be9fd9e2c6f9610ef3c0be8209194936b87c825ba766;
        coeffs[4] = 0x09468bff657b77d3e4eae5a3a4b9540ac3c3749e092e1b6b4e21eb43ed55b8df;
        coeffs[5] = 0x19f2d55ce1ff0283abfca94e2bbc81e5225b45eeb5d961f4409f1d4d08010ea0;
        coeffs[6] = 0x1958537551667ec0c0eef109115b24b406fc1be51a60c9de452b72730a72166f;
        coeffs[7] = 0x237e6312c199f1745c02d486d863d2c71e09df3cd4e45184581b406254b11e90;
        coeffs[8] = 0x0f06e6e56929291faa5298bcdeab3d24be04d97a43570bc71e71c567c021d0e0;
        coeffs[9] = 0x2caf452f74e4f5dca0a18764e9a3a289c9a894f826dd791faafc409a46f94b94;

        uint256 expected = Step3Lib.compute_claim_inner_final(proof.r_W_snark_primary, c_inner, coeffs, Bn256.R_MOD);
        assertEq(expected, 0x249eaaabbddbeca568b0de3c4591168ce20e0a0091fcf0c47e7130a056d97800);
    }

    function test_compute_claim_inner_final_secondary() public {
        Abstractions.CompressedSnark memory proof = loadProof();

        uint256 c_inner = 0x0f704aab173727749094c0ca0df2e5a783c6a0b21cbde7783daa8e77a71b393d;

        uint256[] memory coeffs = new uint256[](10);
        coeffs[0] = 0x06b9fdfdd087e70a4406bda6c64e0f963ce7c3a9bf0138bb1e0e927f79c93fc6;
        coeffs[1] = 0x00112af6f9b3b907841a027f3313cfc6b25002f4a27e6ab351975e4bb253bc6c;
        coeffs[2] = 0x05087e8b190a9bc530fc26d3d1bc51232d3b5a46b1de2448c989afcb777e8c27;
        coeffs[3] = 0x022e6cc28339a6b0d4a2f0a6e9c72c0f96ef496b456447eb6bf4c96883214cce;
        coeffs[4] = 0x0e139d556747dec01f825f2aa90fc51e3554a06c6a2f4ac3c80e033f0065f912;
        coeffs[5] = 0x1086ff53d9bffe3547bba12fda6c540ae8b455a8bf63940288d962ef228c39a4;
        coeffs[6] = 0x16d46121abb741e67efac4d370948215f616e23a9f8b0ead8e12b2abdc4d6b15;
        coeffs[7] = 0x207712552990c20dc5bed713b0d494d6c361e7f85bf905ea71268c4fac80f52d;
        coeffs[8] = 0x167e7264ac46492506b6e851d4296de177e826d99eb27916267069f42c021f42;
        coeffs[9] = 0x1ef00a82010cd1db42e84b414588c50e07a6b66c6d74caff6c50c2b4bd162538;

        uint256 expected =
            Step3Lib.compute_claim_inner_final(proof.f_W_snark_secondary, c_inner, coeffs, Grumpkin.P_MOD);
        assertEq(expected, 0x2cec4a6520269a70acce4ce20ea18bf7a1f9f6e39ef956ffe49b66f408cbe0e0);
    }

    function test_final_verification_primary() public {
        uint256 claim_mem_final_expected = 0x24fea9bfdc4e5678471d48bbf380e7740f095cf53e39e0b41ea40d9f4e28c7c4;
        uint256 claim_outer_final_expected = 0x19519a6219996bc7036849a928da6d92b99e3aab2e23c741b0c68160ace8d0c6;
        uint256 claim_inner_final_expected = 0x249eaaabbddbeca568b0de3c4591168ce20e0a0091fcf0c47e7130a056d97800;
        uint256 claim_sat_final = 0x022651e7f1606e914295e5345ee9bad95a4dd1100ae7b797c617d47871eb1088;
        assert(
            Step3Lib.final_verification(
                claim_mem_final_expected,
                claim_outer_final_expected,
                claim_inner_final_expected,
                claim_sat_final,
                Bn256.R_MOD
            )
        );
    }

    function test_final_verification_secondary() public {
        uint256 claim_mem_final_expected = 0x251d3ac8e236c65a4ced88ea672bc78906650b68c43627db9686096681d97b38;
        uint256 claim_outer_final_expected = 0x2f45328586b29dfb5a3feeeba4922647b06c9f34d9f703d09cb61b521604a694;
        uint256 claim_inner_final_expected = 0x2cec4a6520269a70acce4ce20ea18bf7a1f9f6e39ef956ffe49b66f408cbe0e0;
        uint256 claim_sat_final = 0x20861acdc6acbe72e35b394b175cc90d29c8cc5e6c42ed919f96737eefb0081e;
        assert(
            Step3Lib.final_verification(
                claim_mem_final_expected,
                claim_outer_final_expected,
                claim_inner_final_expected,
                claim_sat_final,
                Grumpkin.P_MOD
            )
        );
    }

    function test_compute_r_secondary() public {
        uint256[] memory elements_to_hash = new uint256[](24);
        elements_to_hash[0] = 0x03e0cc9d0a2e880508793f5f2b0e202504238d16bede6fba0c963b3842ec2d78;
        elements_to_hash[1] = 0x175132b2b341f63846869347bfd3042888490760e56560e46f50949a68d3be88;
        elements_to_hash[2] = 0x2f7039df869b2f301490e03faedf85d7b6079ee4e389fb09e87425446ec2133d;
        elements_to_hash[3] = 0x0000000000000000000000000000000000000000000000000000000000000000;
        elements_to_hash[4] = 0x27d77999973eea4e348600730cf468a894ab92e64bf84bd68a5c0e255b224c92;
        elements_to_hash[5] = 0x19bda2d6e591bb4f335e7737c7ed6be7f6c03848bbbe28aa648f2e4031d6ddc2;
        elements_to_hash[6] = 0x0000000000000000000000000000000000000000000000000000000000000000;
        elements_to_hash[7] = 0x0000000000000000000000000000000178199520d5ba0196f34b2ac2a3e306f4;
        elements_to_hash[8] = 0x000000000000000000000000000000000000000000000000d7733e3a76c5ebd4;
        elements_to_hash[9] = 0x0000000000000000000000000000000000000000000000007db93f1017a028da;
        elements_to_hash[10] = 0x00000000000000000000000000000000000000000000000051a5c0de405bc575;
        elements_to_hash[11] = 0x000000000000000000000000000000000000000000000000061a2f5f4992d13d;
        elements_to_hash[12] = 0x0000000000000000000000000000000000000000000000008a8a6a280b5c968a;
        elements_to_hash[13] = 0x000000000000000000000000000000000000000000000000e93af2df4e3b9e80;
        elements_to_hash[14] = 0x00000000000000000000000000000000000000000000000039c8896b472ffe00;
        elements_to_hash[15] = 0x00000000000000000000000000000000000000000000000022d8987b56519e98;
        elements_to_hash[16] = 0x1e08d8f7c1c82c5bbe43aaad95587e0554ade6a766dde824bb3cfa11599e139a;
        elements_to_hash[17] = 0x1391a4796ecd142d01a3894cd4cb835d8ed84b15b984f0d584e3e63082191b10;
        elements_to_hash[18] = 0x0000000000000000000000000000000000000000000000000000000000000000;
        elements_to_hash[19] = 0x023361c80ce57f1f312081a10254e699c0f148a7ece8d685656549c78bea18ef;
        elements_to_hash[20] = 0x00730e25342e24057fcd53fc978b7d6e60159e67cdeec13a53c5abea8b261540;
        elements_to_hash[21] = 0x28971fc88b6f14f4d776afa9e36efb9833be8ebe81cd859d2d91a5c07968b2c0;
        elements_to_hash[22] = 0x0aeede417aac0192af82bc801044ecf5a56aaf96627211baf4a45afd3bee109b;
        elements_to_hash[23] = 0x0000000000000000000000000000000000000000000000000000000000000000;

        uint256 expected =
            Step3GrumpkinLib.compute_r_secondary(elements_to_hash, TestUtilities.loadBn256Constants(), Bn256.R_MOD);
        assertEq(expected, 0x000000000000000000000000000000005d0a54b95301f0700b055bccaee75c40);
    }

    function test_prepare_elements_to_r_computing() public {
        Abstractions.CompressedSnark memory proof = loadProof();
        Abstractions.VerifierKey memory public_parameters = loadPublicParameters();

        uint256[] memory expected_elements;
        Grumpkin.GrumpkinAffinePoint memory commT;

        (expected_elements, commT) = Step3GrumpkinLib.prepareElementsToHashSecondary(proof, public_parameters);
        assertEq(commT.x, 0x28971fc88b6f14f4d776afa9e36efb9833be8ebe81cd859d2d91a5c07968b2c0);
        assertEq(commT.y, 0x0aeede417aac0192af82bc801044ecf5a56aaf96627211baf4a45afd3bee109b);
        assertEq(expected_elements[0], 0x03e0cc9d0a2e880508793f5f2b0e202504238d16bede6fba0c963b3842ec2d78);
        assertEq(expected_elements[1], 0x175132b2b341f63846869347bfd3042888490760e56560e46f50949a68d3be88);
        assertEq(expected_elements[2], 0x2f7039df869b2f301490e03faedf85d7b6079ee4e389fb09e87425446ec2133d);
        assertEq(expected_elements[3], 0x0000000000000000000000000000000000000000000000000000000000000000);
        assertEq(expected_elements[4], 0x27d77999973eea4e348600730cf468a894ab92e64bf84bd68a5c0e255b224c92);
        assertEq(expected_elements[5], 0x19bda2d6e591bb4f335e7737c7ed6be7f6c03848bbbe28aa648f2e4031d6ddc2);
        assertEq(expected_elements[6], 0x0000000000000000000000000000000000000000000000000000000000000000);
        assertEq(expected_elements[7], 0x0000000000000000000000000000000178199520d5ba0196f34b2ac2a3e306f4);
        assertEq(expected_elements[8], 0x000000000000000000000000000000000000000000000000d7733e3a76c5ebd4);
        assertEq(expected_elements[9], 0x0000000000000000000000000000000000000000000000007db93f1017a028da);
        assertEq(expected_elements[10], 0x00000000000000000000000000000000000000000000000051a5c0de405bc575);
        assertEq(expected_elements[11], 0x000000000000000000000000000000000000000000000000061a2f5f4992d13d);
        assertEq(expected_elements[12], 0x0000000000000000000000000000000000000000000000008a8a6a280b5c968a);
        assertEq(expected_elements[13], 0x000000000000000000000000000000000000000000000000e93af2df4e3b9e80);
        assertEq(expected_elements[14], 0x00000000000000000000000000000000000000000000000039c8896b472ffe00);
        assertEq(expected_elements[15], 0x00000000000000000000000000000000000000000000000022d8987b56519e98);
        assertEq(expected_elements[16], 0x1e08d8f7c1c82c5bbe43aaad95587e0554ade6a766dde824bb3cfa11599e139a);
        assertEq(expected_elements[17], 0x1391a4796ecd142d01a3894cd4cb835d8ed84b15b984f0d584e3e63082191b10);
        assertEq(expected_elements[18], 0x0000000000000000000000000000000000000000000000000000000000000000);
        assertEq(expected_elements[19], 0x023361c80ce57f1f312081a10254e699c0f148a7ece8d685656549c78bea18ef);
        assertEq(expected_elements[20], 0x00730e25342e24057fcd53fc978b7d6e60159e67cdeec13a53c5abea8b261540);
        assertEq(expected_elements[21], 0x28971fc88b6f14f4d776afa9e36efb9833be8ebe81cd859d2d91a5c07968b2c0);
        assertEq(expected_elements[22], 0x0aeede417aac0192af82bc801044ecf5a56aaf96627211baf4a45afd3bee109b);
        assertEq(expected_elements[23], 0x0000000000000000000000000000000000000000000000000000000000000000);
    }

    function test_folding_instance_secondary() public {
        Abstractions.CompressedSnark memory proof = loadProof();

        uint256 r = 0x000000000000000000000000000000005d0a54b95301f0700b055bccaee75c40;
        Grumpkin.GrumpkinAffinePoint memory commT = Grumpkin.GrumpkinAffinePoint(
            0x28971fc88b6f14f4d776afa9e36efb9833be8ebe81cd859d2d91a5c07968b2c0,
            0x0aeede417aac0192af82bc801044ecf5a56aaf96627211baf4a45afd3bee109b
        );

        (
            Grumpkin.GrumpkinAffinePoint memory expected1,
            Grumpkin.GrumpkinAffinePoint memory expected2,
            uint256[] memory expected3,
            uint256 expected4
        ) = Step3GrumpkinLib.foldInstanceSecondary(proof.r_U_secondary, proof.l_u_secondary, commT, r);

        assertEq(expected1.x, 0x3019a8c784334c0aaf50696e207ffd698bd60a364038a76ac3399250f56d8b54);
        assertEq(expected1.y, 0x26b53798d836b6632563da0058df951fc3b5b282876347560145fdc00331c7e1);
        assertEq(expected2.x, 0x1a36a923eb54c2958c1d8f71a8c0a5cbf23fd14b97171736c92de181a2c2271a);
        assertEq(expected2.y, 0x2c00e3ae72c8f5121351cbc7059eeb7e8f98e93c74812429cdcac2397b51843d);
        assertEq(expected3[0], 0x03b173e20dfa9ec307f5eb55a0f8da20620d9e184dc69395a7d92cc30551728d);
        assertEq(expected3[1], 0x25049ad98282284f65ff8435aec45c47f9a39123eb6a33e8499ae079c504507a);
        assertEq(expected4, 0x00000000000000000000000000000001d523e9da28bbf206fe50868f52ca6334);
    }

    function test_compute_f_U_secondary() public {
        Abstractions.CompressedSnark memory proof = loadProof();
        Abstractions.VerifierKey memory public_parameters = loadPublicParameters();
        (
            Grumpkin.GrumpkinAffinePoint memory expected1,
            Grumpkin.GrumpkinAffinePoint memory expected2,
            uint256[] memory expected3,
            uint256 expected4
        ) = Step3GrumpkinLib.compute_f_U_secondary(proof, public_parameters);

        assertEq(expected1.x, 0x3019a8c784334c0aaf50696e207ffd698bd60a364038a76ac3399250f56d8b54);
        assertEq(expected1.y, 0x26b53798d836b6632563da0058df951fc3b5b282876347560145fdc00331c7e1);
        assertEq(expected2.x, 0x1a36a923eb54c2958c1d8f71a8c0a5cbf23fd14b97171736c92de181a2c2271a);
        assertEq(expected2.y, 0x2c00e3ae72c8f5121351cbc7059eeb7e8f98e93c74812429cdcac2397b51843d);
        assertEq(expected3[0], 0x03b173e20dfa9ec307f5eb55a0f8da20620d9e184dc69395a7d92cc30551728d);
        assertEq(expected3[1], 0x25049ad98282284f65ff8435aec45c47f9a39123eb6a33e8499ae079c504507a);
        assertEq(expected4, 0x00000000000000000000000000000001d523e9da28bbf206fe50868f52ca6334);
    }

    function test_compute_tau_secondary() public {
        KeccakTranscriptLib.KeccakTranscript memory transcript = TestUtilities.loadTranscript();
        Abstractions.CompressedSnark memory proof = loadProof();
        Abstractions.VerifierKey memory public_parameters = loadPublicParameters();

        (
            Grumpkin.GrumpkinAffinePoint memory commW,
            Grumpkin.GrumpkinAffinePoint memory commE,
            uint256[] memory X,
            uint256 u
        ) = Step3GrumpkinLib.compute_f_U_secondary(proof, public_parameters);

        uint256[] memory expected;
        (, expected) = Step3GrumpkinLib.compute_tau_secondary(
            proof, public_parameters.vk_secondary, transcript, commW, commE, X, u, false
        );
        assertEq(expected[0], 0x1267f50e1d36c3869b23a88ba2e3e6b8046ecaf4c97466284b1acea3d12e40ae);
        assertEq(expected[1], 0x20eeca082ad550aceb4ea48aff07fca4b18f2c9b07f8abb6dcfa18a7a68b2177);
        assertEq(expected[2], 0x2ff410e0edb1b52f1a525739674ff462a429b63de86ef9f0aba7ea5a1d8edbbd);
        assertEq(expected[3], 0x3049f9d9d6a7edead836c0d8b2ec18cfa6c32cf04d6b86c3ba69c9f8fea1030e);
        assertEq(expected[4], 0x27fb4d075a305bfb22f2a17235e73c60f8eb90674ef6e730929951a60d4ff29d);
        assertEq(expected[5], 0x304ef556679ef95f89b46285aea3c488a9dbd3f883be0c862288032e38f56740);
        assertEq(expected[6], 0x0e13a25d86fd10b0c116bad0fe5c8fe093a85e0d5c412d775632729c750e0f4f);
        assertEq(expected[7], 0x0832f12f3d7e019a82d6b57317269a584dcca3577311aa8855aa09721f4414da);
        assertEq(expected[8], 0x13d5c871aa4865f1ddf690d34c2e7d83c3e026b2b2c00ad280c8dd91849464aa);
        assertEq(expected[9], 0x2453c440114ddc0ad7eead8672c14b26da7d3e86a1689c97a49944f12d57ec83);
        assertEq(expected[10], 0x2bb71aafb19142aabb9c8a0085e55e6d6f8ba9fc04a9d77cbd03fe65bbad339e);
        assertEq(expected[11], 0x0592b27c6e3e7a59ad6701ed27bc4285115098237dbd65b2cf18b1beb42a7b89);
        assertEq(expected[12], 0x12cb49defc02cb1fb4eac54d852b139a1a4b4f409e9a02c3fcfce5315039908f);
        assertEq(expected[13], 0x112ac9a6d39dbe3e98ddbdcbe35eb8fe014c245513f98074c1e34f8ed1d8c16b);
        assertEq(expected[14], 0x1888112a08ecbc29f7d3212e52cff7b57a08ed945ada88c35738b7824c08272d);
        assertEq(expected[15], 0x227a2b43ee513e8e880741190db9f37d801cd332f59d5a08a06cb4ede201d589);
        assertEq(expected[16], 0x2c363a743c3118e6486e7a66a8dd4c02a904051fe0241bb01df569c10015a8dd);
    }

    function test_compute_tau_primary() public {
        KeccakTranscriptLib.KeccakTranscript memory transcript = TestUtilities.loadTranscript();
        Abstractions.CompressedSnark memory proof = loadProof();
        Abstractions.VerifierKey memory public_parameters = loadPublicParameters();

        uint256[] memory expected;
        (, expected) = Step3GrumpkinLib.compute_tau_primary(proof, public_parameters.vk_primary, transcript, false);
        assertEq(expected[0], 0x1695fc0c0698b7e920d417e58174c018754f581f9044cd68c11cc2363005e185);
        assertEq(expected[1], 0x0a6ccda86e557ab8b5e59b7a8c7846f5f0566f3400abec27642881fda5081265);
        assertEq(expected[2], 0x0460b24e8674040141696541a62f2b6dfcfbaa97708ab547bc07f32ba186024e);
        assertEq(expected[3], 0x04109fec011ecc9677d7a3e349b785743fa0b1dc96b97781ae2ac8627a37f083);
        assertEq(expected[4], 0x200ab93f588f3912d94a4553e9c2ae6ee35996c33c41d12d37b387121a2be6d1);
        assertEq(expected[5], 0x263c8dc77149bdd56e11eb6fc11eeea047eebeb8be056e1b160004160808af65);
        assertEq(expected[6], 0x0cf3a930fcc8e93caad2c5eec517ff5006d4be7254221fff85c58c97f6d35ee5);
        assertEq(expected[7], 0x2ba2ec16f6cce727119850fd8b058382a31c326105fe1063f4736b11062df644);
        assertEq(expected[8], 0x140bedef3716eff22e6e35591c5a54c6cd7aae70c800183ec559a2ce7302fd6a);
        assertEq(expected[9], 0x033f543b39164994196e6186c8dd6ff338eaa9f4fde0da6f969502a75399299f);
        assertEq(expected[10], 0x2a6e10ef6ab883dc64c45ebcc6efd99ea862f508b121b1f0ceecf1c77e181769);
        assertEq(expected[11], 0x19cce4de222eb81d4dd537befeab6e42d32f810b3360cd3247e39d82c6cf37a2);
        assertEq(expected[12], 0x1f12d996682184b2b8df7e855cab2231e22613b95ca3f2fdc0650809e22350df);
        assertEq(expected[13], 0x220fe2f07d75e0cc580cf11dc16611f583cc5384842904a98e45cef3b7f409b9);
        assertEq(expected[14], 0x2612eb3431d63727a69d698bb7278ddff6214191d842de7d6558a6637cd0efcb);
        assertEq(expected[15], 0x05b94d437287ba864fe667b76b45342b7a01de764d49bd8cb3d4c37ceb9ed6f6);
        assertEq(expected[16], 0x2e986437477a974632e0ffcd780ddc863a63d78f83c5c9666ebc792ade06dc85);
    }

    function load_transcript_c_secondary() private returns (KeccakTranscriptLib.KeccakTranscript memory) {
        uint16 rounds = 17;
        uint8[] memory state = new uint8[](64);
        state[0] = 0xe3;
        state[1] = 0x7e;
        state[2] = 0xc9;
        state[3] = 0x04;
        state[4] = 0x6a;
        state[5] = 0xec;
        state[6] = 0x7b;
        state[7] = 0x0f;
        state[8] = 0xe6;
        state[9] = 0xcd;
        state[10] = 0xc8;
        state[11] = 0x05;
        state[12] = 0x85;
        state[13] = 0xc1;
        state[14] = 0x46;
        state[15] = 0xc8;
        state[16] = 0x14;
        state[17] = 0x67;
        state[18] = 0x6b;
        state[19] = 0x2e;
        state[20] = 0x05;
        state[21] = 0x91;
        state[22] = 0x8f;
        state[23] = 0x59;
        state[24] = 0xb2;
        state[25] = 0xb5;
        state[26] = 0xa3;
        state[27] = 0x02;
        state[28] = 0x28;
        state[29] = 0x5f;
        state[30] = 0x3e;
        state[31] = 0xd6;
        state[32] = 0x37;
        state[33] = 0x48;
        state[34] = 0xfc;
        state[35] = 0x8d;
        state[36] = 0xd0;
        state[37] = 0x1f;
        state[38] = 0x1e;
        state[39] = 0xce;
        state[40] = 0xb0;
        state[41] = 0xa0;
        state[42] = 0xfc;
        state[43] = 0x9f;
        state[44] = 0x9b;
        state[45] = 0x35;
        state[46] = 0x9f;
        state[47] = 0x44;
        state[48] = 0x84;
        state[49] = 0xf5;
        state[50] = 0xfd;
        state[51] = 0x00;
        state[52] = 0xd9;
        state[53] = 0x73;
        state[54] = 0xa7;
        state[55] = 0x5f;
        state[56] = 0xce;
        state[57] = 0xb5;
        state[58] = 0x2e;
        state[59] = 0x7d;
        state[60] = 0x17;
        state[61] = 0x91;
        state[62] = 0xc0;
        state[63] = 0xd6;

        uint8[] memory transcript = new uint8[](0);

        return KeccakTranscriptLib.KeccakTranscript(rounds, state, transcript);
    }

    function test_compute_c_secondary() public {
        KeccakTranscriptLib.KeccakTranscript memory transcript = load_transcript_c_secondary();
        Abstractions.CompressedSnark memory proof = loadProof();

        (, uint256 c) = Step3GrumpkinLib.compute_c_secondary(proof, transcript);
        assertEq(c, 0x0f704aab173727749094c0ca0df2e5a783c6a0b21cbde7783daa8e77a71b393d);
    }

    function load_transcript_c_primary() private returns (KeccakTranscriptLib.KeccakTranscript memory) {
        uint16 rounds = 17;
        uint8[] memory state = new uint8[](64);
        state[0] = 0x58;
        state[1] = 0x91;
        state[2] = 0xe8;
        state[3] = 0xae;
        state[4] = 0x6f;
        state[5] = 0xa5;
        state[6] = 0x9c;
        state[7] = 0xf4;
        state[8] = 0xbc;
        state[9] = 0xe9;
        state[10] = 0x5e;
        state[11] = 0xa0;
        state[12] = 0x0c;
        state[13] = 0xfd;
        state[14] = 0x1f;
        state[15] = 0xff;
        state[16] = 0x20;
        state[17] = 0x04;
        state[18] = 0x31;
        state[19] = 0x1b;
        state[20] = 0x90;
        state[21] = 0x7c;
        state[22] = 0x14;
        state[23] = 0x74;
        state[24] = 0x7f;
        state[25] = 0x14;
        state[26] = 0x08;
        state[27] = 0x83;
        state[28] = 0x6b;
        state[29] = 0x32;
        state[30] = 0xa4;
        state[31] = 0x4a;
        state[32] = 0x13;
        state[33] = 0xec;
        state[34] = 0x71;
        state[35] = 0xe8;
        state[36] = 0xb8;
        state[37] = 0x45;
        state[38] = 0xe4;
        state[39] = 0x5d;
        state[40] = 0x6a;
        state[41] = 0x7c;
        state[42] = 0x40;
        state[43] = 0x5f;
        state[44] = 0x7b;
        state[45] = 0x9b;
        state[46] = 0x02;
        state[47] = 0xb1;
        state[48] = 0x54;
        state[49] = 0x5c;
        state[50] = 0x4e;
        state[51] = 0xa5;
        state[52] = 0xfd;
        state[53] = 0x24;
        state[54] = 0x94;
        state[55] = 0xd5;
        state[56] = 0x7b;
        state[57] = 0x0f;
        state[58] = 0xde;
        state[59] = 0xe7;
        state[60] = 0x35;
        state[61] = 0xc1;
        state[62] = 0x1b;
        state[63] = 0xac;

        uint8[] memory transcript = new uint8[](0);

        return KeccakTranscriptLib.KeccakTranscript(rounds, state, transcript);
    }

    function test_compute_c_primary() public {
        KeccakTranscriptLib.KeccakTranscript memory transcript = load_transcript_c_primary();
        Abstractions.CompressedSnark memory proof = loadProof();

        (, uint256 c) = Step3GrumpkinLib.compute_c_primary(proof, transcript);
        assertEq(c, 0x2f605dd314f54ceca331da1c09337e0a1e92df731c8e641ad7b7dd4d19f5a0c0);
    }

    function test_compute_u_secondary() public {
        Abstractions.CompressedSnark memory proof = loadProof();
        uint256[] memory tau = new uint256[](17);
        tau[0] = 0x1267f50e1d36c3869b23a88ba2e3e6b8046ecaf4c97466284b1acea3d12e40ae;
        tau[1] = 0x20eeca082ad550aceb4ea48aff07fca4b18f2c9b07f8abb6dcfa18a7a68b2177;
        tau[2] = 0x2ff410e0edb1b52f1a525739674ff462a429b63de86ef9f0aba7ea5a1d8edbbd;
        tau[3] = 0x3049f9d9d6a7edead836c0d8b2ec18cfa6c32cf04d6b86c3ba69c9f8fea1030e;
        tau[4] = 0x27fb4d075a305bfb22f2a17235e73c60f8eb90674ef6e730929951a60d4ff29d;
        tau[5] = 0x304ef556679ef95f89b46285aea3c488a9dbd3f883be0c862288032e38f56740;
        tau[6] = 0x0e13a25d86fd10b0c116bad0fe5c8fe093a85e0d5c412d775632729c750e0f4f;
        tau[7] = 0x0832f12f3d7e019a82d6b57317269a584dcca3577311aa8855aa09721f4414da;
        tau[8] = 0x13d5c871aa4865f1ddf690d34c2e7d83c3e026b2b2c00ad280c8dd91849464aa;
        tau[9] = 0x2453c440114ddc0ad7eead8672c14b26da7d3e86a1689c97a49944f12d57ec83;
        tau[10] = 0x2bb71aafb19142aabb9c8a0085e55e6d6f8ba9fc04a9d77cbd03fe65bbad339e;
        tau[11] = 0x0592b27c6e3e7a59ad6701ed27bc4285115098237dbd65b2cf18b1beb42a7b89;
        tau[12] = 0x12cb49defc02cb1fb4eac54d852b139a1a4b4f409e9a02c3fcfce5315039908f;
        tau[13] = 0x112ac9a6d39dbe3e98ddbdcbe35eb8fe014c245513f98074c1e34f8ed1d8c16b;
        tau[14] = 0x1888112a08ecbc29f7d3212e52cff7b57a08ed945ada88c35738b7824c08272d;
        tau[15] = 0x227a2b43ee513e8e880741190db9f37d801cd332f59d5a08a06cb4ede201d589;
        tau[16] = 0x2c363a743c3118e6486e7a66a8dd4c02a904051fe0241bb01df569c10015a8dd;

        uint256 c = 0x0f704aab173727749094c0ca0df2e5a783c6a0b21cbde7783daa8e77a71b393d;

        PolyEvalInstanceLib.PolyEvalInstance memory expected = Step3GrumpkinLib.compute_u_secondary(proof, tau, c);
        assertEq(expected.c_x, 0x0e8422ef20e671749e06a46ae15ba1e703b55a1d8737c5e6a8f5dd216e3a6822);
        assertEq(expected.c_y, 0x275b128cdcaba9c86c30fc720bd10824cc932b8d3a1020d4f04ecafa5d3280d5);
        assertEq(expected.e, 0x208f3bc09df6f6eb01595a7d7708a2f7d8dafff813f123a4abdd99dfef2ff3aa);
    }

    function test_compute_u_primary() public {
        Abstractions.CompressedSnark memory proof = loadProof();
        uint256[] memory tau = new uint256[](17);
        tau[0] = 0x1695fc0c0698b7e920d417e58174c018754f581f9044cd68c11cc2363005e185;
        tau[1] = 0x0a6ccda86e557ab8b5e59b7a8c7846f5f0566f3400abec27642881fda5081265;
        tau[2] = 0x0460b24e8674040141696541a62f2b6dfcfbaa97708ab547bc07f32ba186024e;
        tau[3] = 0x04109fec011ecc9677d7a3e349b785743fa0b1dc96b97781ae2ac8627a37f083;
        tau[4] = 0x200ab93f588f3912d94a4553e9c2ae6ee35996c33c41d12d37b387121a2be6d1;
        tau[5] = 0x263c8dc77149bdd56e11eb6fc11eeea047eebeb8be056e1b160004160808af65;
        tau[6] = 0x0cf3a930fcc8e93caad2c5eec517ff5006d4be7254221fff85c58c97f6d35ee5;
        tau[7] = 0x2ba2ec16f6cce727119850fd8b058382a31c326105fe1063f4736b11062df644;
        tau[8] = 0x140bedef3716eff22e6e35591c5a54c6cd7aae70c800183ec559a2ce7302fd6a;
        tau[9] = 0x033f543b39164994196e6186c8dd6ff338eaa9f4fde0da6f969502a75399299f;
        tau[10] = 0x2a6e10ef6ab883dc64c45ebcc6efd99ea862f508b121b1f0ceecf1c77e181769;
        tau[11] = 0x19cce4de222eb81d4dd537befeab6e42d32f810b3360cd3247e39d82c6cf37a2;
        tau[12] = 0x1f12d996682184b2b8df7e855cab2231e22613b95ca3f2fdc0650809e22350df;
        tau[13] = 0x220fe2f07d75e0cc580cf11dc16611f583cc5384842904a98e45cef3b7f409b9;
        tau[14] = 0x2612eb3431d63727a69d698bb7278ddff6214191d842de7d6558a6637cd0efcb;
        tau[15] = 0x05b94d437287ba864fe667b76b45342b7a01de764d49bd8cb3d4c37ceb9ed6f6;
        tau[16] = 0x2e986437477a974632e0ffcd780ddc863a63d78f83c5c9666ebc792ade06dc85;

        uint256 c = 0x2f605dd314f54ceca331da1c09337e0a1e92df731c8e641ad7b7dd4d19f5a0c0;

        PolyEvalInstanceLib.PolyEvalInstance memory expected = Step3GrumpkinLib.compute_u_primary(proof, tau, c);
        assertEq(expected.c_x, 0x0de07d3056f2ec32860a2e01306327438a0da14baef711eb336692e4e2a57cfb);
        assertEq(expected.c_y, 0x133f96cda3cacff0d041d21ffdd96763158f0cdbe4779c71fccba5e02071de01);
        assertEq(expected.e, 0x08353df9bb3663c3258222e99684ee10f83abc2931f0c4e1918a49e75498fc1d);
    }

    function test_compute_gamma_1_secondary() public {
        uint16 rounds = 18;
        uint8[] memory state = new uint8[](64);
        state[0] = 0xa4;
        state[1] = 0xb7;
        state[2] = 0x45;
        state[3] = 0x01;
        state[4] = 0xb3;
        state[5] = 0xf6;
        state[6] = 0xbf;
        state[7] = 0x8e;
        state[8] = 0xc0;
        state[9] = 0xdd;
        state[10] = 0xe2;
        state[11] = 0xf1;
        state[12] = 0xe5;
        state[13] = 0x92;
        state[14] = 0x01;
        state[15] = 0x4a;
        state[16] = 0xb5;
        state[17] = 0x80;
        state[18] = 0xa9;
        state[19] = 0x71;
        state[20] = 0xca;
        state[21] = 0x9b;
        state[22] = 0x3b;
        state[23] = 0x4a;
        state[24] = 0x97;
        state[25] = 0xfd;
        state[26] = 0x27;
        state[27] = 0x4d;
        state[28] = 0xf6;
        state[29] = 0x64;
        state[30] = 0xed;
        state[31] = 0x87;
        state[32] = 0x92;
        state[33] = 0xa5;
        state[34] = 0x18;
        state[35] = 0xaf;
        state[36] = 0xc8;
        state[37] = 0x0e;
        state[38] = 0x7d;
        state[39] = 0xc9;
        state[40] = 0x20;
        state[41] = 0x53;
        state[42] = 0x1c;
        state[43] = 0xf5;
        state[44] = 0xcb;
        state[45] = 0x88;
        state[46] = 0xe3;
        state[47] = 0x81;
        state[48] = 0xeb;
        state[49] = 0x9a;
        state[50] = 0xa4;
        state[51] = 0x1b;
        state[52] = 0xfe;
        state[53] = 0xd1;
        state[54] = 0x90;
        state[55] = 0x89;
        state[56] = 0x02;
        state[57] = 0x2f;
        state[58] = 0xdf;
        state[59] = 0x37;
        state[60] = 0x37;
        state[61] = 0x29;
        state[62] = 0x73;
        state[63] = 0x78;

        KeccakTranscriptLib.KeccakTranscript memory transcript =
            KeccakTranscriptLib.KeccakTranscript(rounds, state, new uint8[](0));

        (, uint256 expected) = Step3GrumpkinLib.compute_gamma_1_secondary(transcript);
        assertEq(expected, 0x0cfd566d496cc7d7a714981ac92b8c30666f85ebb8cf92eb25893379a45997f6);
    }

    function test_compute_gamma_1_primary() public {
        uint16 rounds = 18;
        uint8[] memory state = new uint8[](64);
        state[0] = 0x47;
        state[1] = 0x7b;
        state[2] = 0x29;
        state[3] = 0x3c;
        state[4] = 0xbc;
        state[5] = 0x07;
        state[6] = 0x30;
        state[7] = 0x83;
        state[8] = 0x15;
        state[9] = 0x08;
        state[10] = 0xc4;
        state[11] = 0xe6;
        state[12] = 0x7d;
        state[13] = 0xca;
        state[14] = 0x93;
        state[15] = 0xa8;
        state[16] = 0xf2;
        state[17] = 0x1e;
        state[18] = 0xee;
        state[19] = 0xb5;
        state[20] = 0x46;
        state[21] = 0xd3;
        state[22] = 0x2e;
        state[23] = 0x6e;
        state[24] = 0x66;
        state[25] = 0x6f;
        state[26] = 0x05;
        state[27] = 0xa2;
        state[28] = 0xc6;
        state[29] = 0xd7;
        state[30] = 0x0d;
        state[31] = 0x04;
        state[32] = 0x12;
        state[33] = 0x52;
        state[34] = 0x77;
        state[35] = 0x1f;
        state[36] = 0xfa;
        state[37] = 0x31;
        state[38] = 0xca;
        state[39] = 0x96;
        state[40] = 0xed;
        state[41] = 0x3e;
        state[42] = 0x56;
        state[43] = 0xa9;
        state[44] = 0xee;
        state[45] = 0x5f;
        state[46] = 0xc2;
        state[47] = 0xec;
        state[48] = 0xbd;
        state[49] = 0x1f;
        state[50] = 0x47;
        state[51] = 0xae;
        state[52] = 0x04;
        state[53] = 0xd2;
        state[54] = 0x40;
        state[55] = 0xfa;
        state[56] = 0x21;
        state[57] = 0x6f;
        state[58] = 0x34;
        state[59] = 0x18;
        state[60] = 0xa6;
        state[61] = 0xce;
        state[62] = 0x4f;
        state[63] = 0xc9;

        KeccakTranscriptLib.KeccakTranscript memory transcript =
            KeccakTranscriptLib.KeccakTranscript(rounds, state, new uint8[](0));

        (, uint256 expected) = Step3GrumpkinLib.compute_gamma_1_primary(transcript);
        assertEq(expected, 0x03d5af9141c819677a8e1a3da3e2eefa429ccd3a8dda73108b90adc0de8ae3ff);
    }

    function test_compute_gamma_2_secondary() public {
        uint16 rounds = 19;
        uint8[] memory state = new uint8[](64);
        state[0] = 0x8b;
        state[1] = 0x80;
        state[2] = 0xaa;
        state[3] = 0x8c;
        state[4] = 0x90;
        state[5] = 0x58;
        state[6] = 0xae;
        state[7] = 0x19;
        state[8] = 0xda;
        state[9] = 0xdc;
        state[10] = 0x23;
        state[11] = 0x8e;
        state[12] = 0x6e;
        state[13] = 0x6e;
        state[14] = 0xd1;
        state[15] = 0xa2;
        state[16] = 0x38;
        state[17] = 0x35;
        state[18] = 0x80;
        state[19] = 0xa5;
        state[20] = 0xdf;
        state[21] = 0x43;
        state[22] = 0x43;
        state[23] = 0xd3;
        state[24] = 0xed;
        state[25] = 0x50;
        state[26] = 0x65;
        state[27] = 0x67;
        state[28] = 0xd2;
        state[29] = 0x20;
        state[30] = 0x30;
        state[31] = 0x05;
        state[32] = 0xeb;
        state[33] = 0xf5;
        state[34] = 0x6f;
        state[35] = 0x27;
        state[36] = 0x5b;
        state[37] = 0xac;
        state[38] = 0xf3;
        state[39] = 0x03;
        state[40] = 0x14;
        state[41] = 0x5c;
        state[42] = 0x90;
        state[43] = 0x9b;
        state[44] = 0x58;
        state[45] = 0x37;
        state[46] = 0x23;
        state[47] = 0xa3;
        state[48] = 0x5e;
        state[49] = 0xf1;
        state[50] = 0x30;
        state[51] = 0x5b;
        state[52] = 0xf7;
        state[53] = 0x4d;
        state[54] = 0xd5;
        state[55] = 0xe5;
        state[56] = 0x16;
        state[57] = 0x9e;
        state[58] = 0xb4;
        state[59] = 0x95;
        state[60] = 0xf6;
        state[61] = 0x1a;
        state[62] = 0x80;
        state[63] = 0xf4;

        KeccakTranscriptLib.KeccakTranscript memory transcript =
            KeccakTranscriptLib.KeccakTranscript(rounds, state, new uint8[](0));

        (, uint256 expected) = Step3GrumpkinLib.compute_gamma_2_secondary(transcript);
        assertEq(expected, 0x157291f097a16f6b025a7a880f2439d50fb9b6aee03fb40b07ef1471f848fce5);
    }

    function test_compute_gamma_2_primary() public {
        uint16 rounds = 19;
        uint8[] memory state = new uint8[](64);
        state[0] = 0xde;
        state[1] = 0x3b;
        state[2] = 0x18;
        state[3] = 0x89;
        state[4] = 0x0f;
        state[5] = 0x0a;
        state[6] = 0x54;
        state[7] = 0x59;
        state[8] = 0x1d;
        state[9] = 0x26;
        state[10] = 0x86;
        state[11] = 0x24;
        state[12] = 0x54;
        state[13] = 0x34;
        state[14] = 0x7a;
        state[15] = 0x56;
        state[16] = 0x6e;
        state[17] = 0xee;
        state[18] = 0x3e;
        state[19] = 0x45;
        state[20] = 0xc3;
        state[21] = 0xcd;
        state[22] = 0xe5;
        state[23] = 0xe8;
        state[24] = 0x46;
        state[25] = 0x85;
        state[26] = 0xf9;
        state[27] = 0x81;
        state[28] = 0x42;
        state[29] = 0xa8;
        state[30] = 0xa9;
        state[31] = 0x06;
        state[32] = 0x33;
        state[33] = 0x74;
        state[34] = 0x8c;
        state[35] = 0x74;
        state[36] = 0x31;
        state[37] = 0x45;
        state[38] = 0xbd;
        state[39] = 0x57;
        state[40] = 0x43;
        state[41] = 0x74;
        state[42] = 0xbb;
        state[43] = 0x8e;
        state[44] = 0x30;
        state[45] = 0xec;
        state[46] = 0x32;
        state[47] = 0x60;
        state[48] = 0xcd;
        state[49] = 0x2b;
        state[50] = 0xb9;
        state[51] = 0x4c;
        state[52] = 0x52;
        state[53] = 0x43;
        state[54] = 0x28;
        state[55] = 0x1c;
        state[56] = 0x9e;
        state[57] = 0x98;
        state[58] = 0x31;
        state[59] = 0x15;
        state[60] = 0x3e;
        state[61] = 0xc0;
        state[62] = 0xc4;
        state[63] = 0x94;

        KeccakTranscriptLib.KeccakTranscript memory transcript =
            KeccakTranscriptLib.KeccakTranscript(rounds, state, new uint8[](0));

        (, uint256 expected) = Step3GrumpkinLib.compute_gamma_2_primary(transcript);
        assertEq(expected, 0x2439af69afca5c5c4c76eadebc767d89c5eb001f41245d65cd232643ed497998);
    }

    function test_compute_rand_eq_secondary() public {
        Abstractions.CompressedSnark memory proof = loadProof();
        Abstractions.VerifierKey memory public_parameters = loadPublicParameters();
        uint16 rounds = 20;
        uint8[] memory state = new uint8[](64);
        state[0] = 0x01;
        state[1] = 0x8e;
        state[2] = 0xcb;
        state[3] = 0x19;
        state[4] = 0x2c;
        state[5] = 0x63;
        state[6] = 0x0b;
        state[7] = 0xd4;
        state[8] = 0x3a;
        state[9] = 0x6a;
        state[10] = 0x25;
        state[11] = 0xa3;
        state[12] = 0xbd;
        state[13] = 0x6b;
        state[14] = 0x1c;
        state[15] = 0x64;
        state[16] = 0xb8;
        state[17] = 0x04;
        state[18] = 0x4e;
        state[19] = 0x8e;
        state[20] = 0xc5;
        state[21] = 0xf3;
        state[22] = 0x4c;
        state[23] = 0x55;
        state[24] = 0x0e;
        state[25] = 0x67;
        state[26] = 0xe8;
        state[27] = 0xb3;
        state[28] = 0x69;
        state[29] = 0x6f;
        state[30] = 0x2e;
        state[31] = 0xe5;
        state[32] = 0xdb;
        state[33] = 0xfc;
        state[34] = 0xbc;
        state[35] = 0x30;
        state[36] = 0xa7;
        state[37] = 0x4f;
        state[38] = 0x7a;
        state[39] = 0x8b;
        state[40] = 0x33;
        state[41] = 0xac;
        state[42] = 0xd5;
        state[43] = 0xda;
        state[44] = 0xcb;
        state[45] = 0xc6;
        state[46] = 0x20;
        state[47] = 0x55;
        state[48] = 0xb8;
        state[49] = 0xa3;
        state[50] = 0x5d;
        state[51] = 0x89;
        state[52] = 0x75;
        state[53] = 0x20;
        state[54] = 0x7e;
        state[55] = 0x4b;
        state[56] = 0x7d;
        state[57] = 0x2e;
        state[58] = 0x6a;
        state[59] = 0xb4;
        state[60] = 0x60;
        state[61] = 0x8b;
        state[62] = 0xd6;
        state[63] = 0x6b;

        KeccakTranscriptLib.KeccakTranscript memory transcript =
            KeccakTranscriptLib.KeccakTranscript(rounds, state, new uint8[](0));

        (, uint256[] memory expected) = Step3GrumpkinLib.compute_rand_eq_secondary(proof, public_parameters, transcript);
        assertEq(expected[0], 0x2d6afe48d07107b37f561b07b81c143a1dc7bd4fcec11a0e383a85f559575075);
        assertEq(expected[1], 0x10adc3f96601d3d18640acee696e30422d6d2201b5952182ec3b16b2407a06b4);
        assertEq(expected[2], 0x2cff3f5f81fcb7614b587be4bb478c061f4b6f89064c941292b9b88bfa6b1540);
        assertEq(expected[3], 0x291f02d206565ea7f715ee46bf202e47bc6ca70748a7f6426fb4d315125e57b5);
        assertEq(expected[4], 0x29f1baa7d4ba01a53d0a1a8250c314747f69574d5db99631eea2e7bfd3b60265);
        assertEq(expected[5], 0x1d66cd71fec9f831507144f9cc0bb79d509d52a8d77c747404b3f6c742c7e3af);
        assertEq(expected[6], 0x10a4223777f3c3d2070c09e7248275dfcde4c652ce0ab26db3e065f467aa92e3);
        assertEq(expected[7], 0x20acf355b39ca7458bb6993717fd7cecbef5fe104f8da2c093a6f9a6a365396c);
        assertEq(expected[8], 0x27a75e18bc7d3b01af1efecc769d2f27ff48e4484e3d18507db273aac8a00a93);
        assertEq(expected[9], 0x014e96c061c51f20f44de6e2a0e737c823d171e41c751b824964118f46bdfbdc);
        assertEq(expected[10], 0x1ed0ff9b647ed945f3e19e227f9a1e3ed994344f5117358e03c47418c15106bd);
        assertEq(expected[11], 0x16bf6adac7167a4a9ccb17f7e106d96d5b190718626146d15dcdbee341af1b3e);
        assertEq(expected[12], 0x049c223302f73c24363f51c6afd1a145e77b36cec6118de8df67b2a4ac0e1031);
        assertEq(expected[13], 0x2f78d147faf967e5c922f7e1ae11878658c6d555f1dc4b4b6e6114d1f2ac8948);
        assertEq(expected[14], 0x020d41fd0f2e426d3251737b3833b4fd30720bc73262d817ec7ddcfc001401ee);
        assertEq(expected[15], 0x15d846c60d6c504d3717c4188e52e5be02b336f29e265d2edf188382e7750564);
        assertEq(expected[16], 0x2b036764c660492fc3709d33d2a12416ac22bae921e6037e5da2b96ebc8e6ab7);
    }

    function test_compute_rand_eq_primary() public {
        Abstractions.CompressedSnark memory proof = loadProof();
        Abstractions.VerifierKey memory public_parameters = loadPublicParameters();
        uint16 rounds = 20;
        uint8[] memory state = new uint8[](64);
        state[0] = 0x21;
        state[1] = 0x4d;
        state[2] = 0x22;
        state[3] = 0x3b;
        state[4] = 0xf4;
        state[5] = 0x76;
        state[6] = 0x54;
        state[7] = 0x9b;
        state[8] = 0x4f;
        state[9] = 0x5f;
        state[10] = 0x7a;
        state[11] = 0x41;
        state[12] = 0xe5;
        state[13] = 0x53;
        state[14] = 0x2d;
        state[15] = 0x6f;
        state[16] = 0xfb;
        state[17] = 0x0d;
        state[18] = 0xa7;
        state[19] = 0x7d;
        state[20] = 0xe2;
        state[21] = 0x3e;
        state[22] = 0x6f;
        state[23] = 0xf1;
        state[24] = 0x8b;
        state[25] = 0x71;
        state[26] = 0x7b;
        state[27] = 0xa8;
        state[28] = 0xf4;
        state[29] = 0xe2;
        state[30] = 0x64;
        state[31] = 0x45;
        state[32] = 0x17;
        state[33] = 0x62;
        state[34] = 0x34;
        state[35] = 0x77;
        state[36] = 0x4e;
        state[37] = 0x3b;
        state[38] = 0xab;
        state[39] = 0x66;
        state[40] = 0x44;
        state[41] = 0xe8;
        state[42] = 0x7b;
        state[43] = 0xb1;
        state[44] = 0xa8;
        state[45] = 0xc9;
        state[46] = 0xef;
        state[47] = 0xce;
        state[48] = 0xd0;
        state[49] = 0x48;
        state[50] = 0x59;
        state[51] = 0x64;
        state[52] = 0xb4;
        state[53] = 0x99;
        state[54] = 0x56;
        state[55] = 0xbe;
        state[56] = 0xe3;
        state[57] = 0xad;
        state[58] = 0xfd;
        state[59] = 0xd7;
        state[60] = 0x92;
        state[61] = 0x2f;
        state[62] = 0x0d;
        state[63] = 0x5c;

        KeccakTranscriptLib.KeccakTranscript memory transcript =
            KeccakTranscriptLib.KeccakTranscript(rounds, state, new uint8[](0));

        (, uint256[] memory expected) = Step3GrumpkinLib.compute_rand_eq_primary(proof, public_parameters, transcript);
        assertEq(expected[0], 0x12ff2a3d6525078d591d69ee9946d17626059ba66c78f2a7b0139b2c2f9d433b);
        assertEq(expected[1], 0x1811c719cf4f53567a2132f7d7a65acf1735a40f2124c014871424e2c3babff8);
        assertEq(expected[2], 0x0606d9466622218a523c291e8e3d98a9d7923685023b7c30ff201e7adb2989ad);
        assertEq(expected[3], 0x302462ce46334069f01b8653536a316cede873ff8c2976c1e73d684489053414);
        assertEq(expected[4], 0x037f982b775ebbab9d953538f4d6160db4dd9a6de92cbc1129ef9ac009932860);
        assertEq(expected[5], 0x0a9404da5ec2df1370bc0dbc40f96751c0aefbd58f9d787613ceb8ba54fe49d4);
        assertEq(expected[6], 0x06ed1601252e18bf5bd9f2d18a8cb45b4088c9e408b2c62235cc584ef5e8c90a);
        assertEq(expected[7], 0x10d01fbd4a3617bb8b4e32998d3050962861105dbb8c8d5b4091ebbb89920e2f);
        assertEq(expected[8], 0x216da3cad7c41753a9391a1969b0d09f019723fd8a9954de3546d4a81d8a5da9);
        assertEq(expected[9], 0x1c750340d6222324589e8cf6cc4fe43cc4bfe5be4eb20d7301576a2a66fd7e23);
        assertEq(expected[10], 0x22b11f0a11c5fffc36c7d12f5f3671e03be093e60da84fa22088293ad4b1bdf9);
        assertEq(expected[11], 0x2ed00368c4555efe29c628658364ff66456ba2c80e5db736de09a869c7cfc745);
        assertEq(expected[12], 0x3062431c8da6100c4da5cecb2d4456a8ea1da6b8e7cd9b05cddde682e112c15c);
        assertEq(expected[13], 0x112936feb3042c1f4f375e45a84a5e30ee191499e437f7021b3d64905154584e);
        assertEq(expected[14], 0x2465f8af91f94ced21272db61b0705d844ebe3b00ad610fee8b2e6d5f7372251);
        assertEq(expected[15], 0x01b0e4a2ecb86772b74eaebed2e424529ec043e9f0faa09c664ece08fb5858e7);
        assertEq(expected[16], 0x06cd3af3518558c5ae086acc47fce1487dd828ee74e748178376ec6ca45f875c);
    }

    function test_compute_coeffs_primary() public {
        uint16 rounds = 37;
        uint8[] memory state = new uint8[](64);
        state[0] = 0x49;
        state[1] = 0xef;
        state[2] = 0x26;
        state[3] = 0xde;
        state[4] = 0x5a;
        state[5] = 0xdf;
        state[6] = 0xd3;
        state[7] = 0xbf;
        state[8] = 0x6f;
        state[9] = 0xd8;
        state[10] = 0x7b;
        state[11] = 0xbe;
        state[12] = 0xfe;
        state[13] = 0x0d;
        state[14] = 0xce;
        state[15] = 0xf2;
        state[16] = 0xb6;
        state[17] = 0xc3;
        state[18] = 0xc0;
        state[19] = 0xc1;
        state[20] = 0x82;
        state[21] = 0x08;
        state[22] = 0xf3;
        state[23] = 0xee;
        state[24] = 0x45;
        state[25] = 0x9b;
        state[26] = 0xa1;
        state[27] = 0x78;
        state[28] = 0xab;
        state[29] = 0xa6;
        state[30] = 0x2a;
        state[31] = 0xae;
        state[32] = 0x26;
        state[33] = 0x63;
        state[34] = 0x28;
        state[35] = 0xc6;
        state[36] = 0xe7;
        state[37] = 0xa7;
        state[38] = 0x8f;
        state[39] = 0x28;
        state[40] = 0x1b;
        state[41] = 0x5e;
        state[42] = 0x67;
        state[43] = 0x64;
        state[44] = 0xf7;
        state[45] = 0xfd;
        state[46] = 0xa6;
        state[47] = 0xd0;
        state[48] = 0xf4;
        state[49] = 0x86;
        state[50] = 0x74;
        state[51] = 0xe0;
        state[52] = 0x73;
        state[53] = 0x52;
        state[54] = 0x24;
        state[55] = 0x35;
        state[56] = 0xe7;
        state[57] = 0x0f;
        state[58] = 0x11;
        state[59] = 0xa2;
        state[60] = 0xf5;
        state[61] = 0x4f;
        state[62] = 0x86;
        state[63] = 0xe3;

        KeccakTranscriptLib.KeccakTranscript memory transcript =
            KeccakTranscriptLib.KeccakTranscript(rounds, state, new uint8[](0));

        (, uint256[] memory coeffs) = Step3GrumpkinLib.compute_coeffs_primary(transcript);
        assertEq(coeffs[0], 0x0e19eb06be084639c9a38e2a2b7af3cab93019ddfe9ad10246aeeb4e3adfdae2);
        assertEq(coeffs[1], 0x04dcaf34a19e10fa1f30facfb9b45321985e9c74afd17ba1d388a2c64045716d);
        assertEq(coeffs[2], 0x20aaee132183c23f1b760d945209c606c4f2a50a49e930af0fb069ff1b0edf5c);
        assertEq(coeffs[3], 0x23d9953ef7a418e92db1be9fd9e2c6f9610ef3c0be8209194936b87c825ba766);
        assertEq(coeffs[4], 0x09468bff657b77d3e4eae5a3a4b9540ac3c3749e092e1b6b4e21eb43ed55b8df);
        assertEq(coeffs[5], 0x19f2d55ce1ff0283abfca94e2bbc81e5225b45eeb5d961f4409f1d4d08010ea0);
        assertEq(coeffs[6], 0x1958537551667ec0c0eef109115b24b406fc1be51a60c9de452b72730a72166f);
        assertEq(coeffs[7], 0x237e6312c199f1745c02d486d863d2c71e09df3cd4e45184581b406254b11e90);
        assertEq(coeffs[8], 0x0f06e6e56929291faa5298bcdeab3d24be04d97a43570bc71e71c567c021d0e0);
        assertEq(coeffs[9], 0x2caf452f74e4f5dca0a18764e9a3a289c9a894f826dd791faafc409a46f94b94);
    }

    function test_compute_coeffs_secondary() public {
        uint16 rounds = 37;
        uint8[] memory state = new uint8[](64);
        state[0] = 0x10;
        state[1] = 0x87;
        state[2] = 0x08;
        state[3] = 0x9a;
        state[4] = 0x80;
        state[5] = 0x26;
        state[6] = 0x34;
        state[7] = 0xf3;
        state[8] = 0x59;
        state[9] = 0x81;
        state[10] = 0x72;
        state[11] = 0x02;
        state[12] = 0xd3;
        state[13] = 0xbb;
        state[14] = 0x21;
        state[15] = 0xd4;
        state[16] = 0xa4;
        state[17] = 0xd9;
        state[18] = 0x85;
        state[19] = 0x9a;
        state[20] = 0x1e;
        state[21] = 0x31;
        state[22] = 0xe6;
        state[23] = 0x98;
        state[24] = 0x3f;
        state[25] = 0x07;
        state[26] = 0xa0;
        state[27] = 0xc1;
        state[28] = 0xf9;
        state[29] = 0x59;
        state[30] = 0x76;
        state[31] = 0x87;
        state[32] = 0xb0;
        state[33] = 0x8b;
        state[34] = 0x6f;
        state[35] = 0x06;
        state[36] = 0xf1;
        state[37] = 0x9e;
        state[38] = 0xe5;
        state[39] = 0xe2;
        state[40] = 0x7a;
        state[41] = 0x07;
        state[42] = 0xbb;
        state[43] = 0x68;
        state[44] = 0xb4;
        state[45] = 0x6e;
        state[46] = 0x70;
        state[47] = 0xac;
        state[48] = 0x82;
        state[49] = 0xc0;
        state[50] = 0x58;
        state[51] = 0xb6;
        state[52] = 0x8f;
        state[53] = 0xc3;
        state[54] = 0x12;
        state[55] = 0x31;
        state[56] = 0x31;
        state[57] = 0x5e;
        state[58] = 0x41;
        state[59] = 0x00;
        state[60] = 0xc9;
        state[61] = 0x21;
        state[62] = 0x5e;
        state[63] = 0x89;

        KeccakTranscriptLib.KeccakTranscript memory transcript =
            KeccakTranscriptLib.KeccakTranscript(rounds, state, new uint8[](0));

        (, uint256[] memory coeffs) = Step3GrumpkinLib.compute_coeffs_secondary(transcript);
        assertEq(coeffs[0], 0x06b9fdfdd087e70a4406bda6c64e0f963ce7c3a9bf0138bb1e0e927f79c93fc6);
        assertEq(coeffs[1], 0x00112af6f9b3b907841a027f3313cfc6b25002f4a27e6ab351975e4bb253bc6c);
        assertEq(coeffs[2], 0x05087e8b190a9bc530fc26d3d1bc51232d3b5a46b1de2448c989afcb777e8c27);
        assertEq(coeffs[3], 0x022e6cc28339a6b0d4a2f0a6e9c72c0f96ef496b456447eb6bf4c96883214cce);
        assertEq(coeffs[4], 0x0e139d556747dec01f825f2aa90fc51e3554a06c6a2f4ac3c80e033f0065f912);
        assertEq(coeffs[5], 0x1086ff53d9bffe3547bba12fda6c540ae8b455a8bf63940288d962ef228c39a4);
        assertEq(coeffs[6], 0x16d46121abb741e67efac4d370948215f616e23a9f8b0ead8e12b2abdc4d6b15);
        assertEq(coeffs[7], 0x207712552990c20dc5bed713b0d494d6c361e7f85bf905ea71268c4fac80f52d);
        assertEq(coeffs[8], 0x167e7264ac46492506b6e851d4296de177e826d99eb27916267069f42c021f42);
        assertEq(coeffs[9], 0x1ef00a82010cd1db42e84b414588c50e07a6b66c6d74caff6c50c2b4bd162538);
    }
}
