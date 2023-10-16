// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.16;

import "@std/Test.sol";
import "src/blocks/IdentityPolynomial.sol";
import "src/blocks/grumpkin/Bn256.sol";
import "src/blocks/grumpkin/Grumpkin.sol";

contract IdentityPolyEvaluationTest is Test {
    function testIdentityPolyEvaluatePrimary() public {
        uint256[] memory r_prod = new uint256[](17);
        r_prod[0] = 0x1e525e8eb5732494ab1aebe43df1d2a0150badb04db05681409c612429cea8ac;
        r_prod[1] = 0x317b05d9d1941be2116f250a8aad1932d009cec690d12ef463fe64c5efadc978;
        r_prod[2] = 0x13493a5dc4e2513470e1749fdb37b41e3836364d77d7eb8b5a81b985bfe7333a;
        r_prod[3] = 0x05499a9b11713b3371978cf62676fc88bbd1784df341575d88c183fe7d2baec2;
        r_prod[4] = 0x304fd43c6453b62cfe98bc726e458208edf3754b58a1b96b48baedb08dc231b6;
        r_prod[5] = 0x2d5ce24c1355a2428de1d5411ecebd98b1328b5b6f87dcc9ecb573252d6cf30d;
        r_prod[6] = 0x2d6762046fc5ca62b436c758321b1844ac5cf096e30085cb81ddd076138d7163;
        r_prod[7] = 0x3ec3a1be092aa81390fb585c46fd3774b20febd739904f20c99ab2c9d0f3ef46;
        r_prod[8] = 0x382b206460e5706009787007b6e484e80423783762ebac703d3cbb9c2615e7b2;
        r_prod[9] = 0x1c9118d02c7792a8728fa7a879687962ae5a1b5aa9942420d239ada6cef57149;
        r_prod[10] = 0x39672312a3af1dadc7dd77703cef7487ae0f27634ce37faba6e81f0b7eae3d25;
        r_prod[11] = 0x0ec9a8b069eed91e089a03c0f47615fe04742b8c1159a10dde4129b71fc65687;
        r_prod[12] = 0x3998456c5125913b2489869938b5b0d98e7f5c87327af98b9dc619fe54fd26c1;
        r_prod[13] = 0x08a01a276934627dad600b53978bd5d64de6090ecb2bef2b73c3d6e346e5c096;
        r_prod[14] = 0x394edaa7014bdeed61ad362a7d9ec5877ad82777dd131489152c96b848a05d78;
        r_prod[15] = 0x0ede18a94d3bdf5f9ee7a7ae19c34315d98847bc4086c9d81f5264b1e127ec78;
        r_prod[16] = 0x1741b54a11d0633c0349b0e317ced512a59ef40b772fbe94415e42af34a25c99;

        uint256 expected = 0x0bf146bb9b77dd4f7fb855514d9af822f907e580a1b71b4ac9141f994dd422a1;

        uint256 actual = IdentityPolynomialLib.evaluate(r_prod, Vesta.P_MOD);

        assertEq(actual, expected);
    }

    function testIdentityPolyEvaluateSecondary() public {
        uint256[] memory r_prod = new uint256[](17);
        r_prod[0] = 0x12356e9d5716fbc87d57127bf033d6c944a469d3594be6690ebea874852df9a2;
        r_prod[1] = 0x11920f58b99610ea1e7df2b95803ac51e568be3261d8c57e53c5e7232b6a8100;
        r_prod[2] = 0x07669895060aa6d19a26a3ca15b66c653f057411e3e249ad032bd4c3d454dd2c;
        r_prod[3] = 0x1529ed49bcf02d198015331aaceda91523d4cb6480bf88ece2b9fdcb7455318d;
        r_prod[4] = 0x1a143c3ea3b03de4235858e759e5a5f145becbe09e73034bc5deae7b448dafcd;
        r_prod[5] = 0x33b78932e8c0a8560c559f8c6ffb88f47355f01af8d4db106cbfd0bb6813b48f;
        r_prod[6] = 0x28137caa1e6c94ba725683445a2fda31dde080460f1194927ea3d705e4a2b4cc;
        r_prod[7] = 0x2a1dc1db6e9d737c435c9c5f1e99a82ef22909045565c1d3d4a70e7f3476ddd0;
        r_prod[8] = 0x1980c374b3934f56f94174320f07a2086f723271f06ec0341619e804fe0af261;
        r_prod[9] = 0x3c13da89c92bed75f7441764335289c8688dbaad7592ffa27fc4af6c76234b9a;
        r_prod[10] = 0x0821d484a68f72a551207bf5a27a57dddbe4f6c1352fce1210ac8139c5b4b423;
        r_prod[11] = 0x1d70c72ceb8af51ff89f5b520643d1dcc35393e1255e9476b7ad4987324c467a;
        r_prod[12] = 0x1cbcf9e4c122e494679ad733c241d0e908d2a3c9fdb65cafea3a8c6ff72e2517;
        r_prod[13] = 0x0ef3b3e72135c28d158b117f3733d291c4789c2ac9c754bfe1e90a8fc5fbb208;
        r_prod[14] = 0x17e5a84f6bbdd8e53f5ec117374d39b6a23fe37a58571e95da5b4c1820608245;
        r_prod[15] = 0x3492aaf8252e21df8a00c0febe0c2c2476008b7210edc742afd161f7439adb4f;
        r_prod[16] = 0x0cc2c6fcd1096bda0da207001f725b19e32f770124ad40a31b6f2a88c3300fc8;

        uint256 expected = 0x3dc6c9e9ceaac83025adf867950052b6a80cda96990af6a8c762c07a4ac3df66;

        uint256 actual = IdentityPolynomialLib.evaluate(r_prod, Pallas.P_MOD);

        assertEq(actual, expected);
    }

    function testIdentityPolyEvaluateBn256() public {
        uint256[] memory r_prod = new uint256[](17);
        r_prod[0] = 0x05837413e5049a37ef21bc91fd21fcce3f89e80202ec70aa01872cc9221d95cd;
        r_prod[1] = 0x17430b827b82e51b14fcdf9511b6a8061d1392d4589b8221dafbae759dd6e070;
        r_prod[2] = 0x0256f4d5674a529ec39e0afba3738d0263cb1d385a563ce608edad719f47d5fd;
        r_prod[3] = 0x00f87554a6caed435bb9e714a355fa73cfd359d5dd8b31fc172ada8cecd7ee30;
        r_prod[4] = 0x29b4dbb7be87a4961e21fe447b03125469077ba2bad896ac2c374aa55be358ab;
        r_prod[5] = 0x1493591a52ded39471fbcd9937537aae9023e77080708f790798671aaa268fc9;
        r_prod[6] = 0x046d5e95bee7ea383f29e0ffa2a6e2816d5b82a75283265e2bc17e63d6ecaeee;
        r_prod[7] = 0x0ea46d83cda8cac4084d937137ab451e89d3fef4b6e25ec00e80fcb8bf8a5308;
        r_prod[8] = 0x26d16ee1e12b5e781327f54a2b89bb7f397e500ec503066b4e37c5e59c372aa1;
        r_prod[9] = 0x2826c37882e6cec0184d476e6e14ac3cb48aee6e233a1ee085c174d53cf1f419;
        r_prod[10] = 0x1b054f124db95f87ec662a5b8ddf47f2b0264e97ef866a05e2a3e0335bce3b16;
        r_prod[11] = 0x0fd296132bf7fc749c44059331d68c735b05f8f746c26e0bf25c3e0a0e6b17b1;
        r_prod[12] = 0x2aede350fab3723fb2ed55ed281f40e4a718f43237901e99264cb09a586661ef;
        r_prod[13] = 0x1a99798029810bbe8a2a5e0d738e8a7c54c010acf84892178463c3222d08b351;
        r_prod[14] = 0x01611bd374a32895d454f4fbe32f051f82e1fef13242ee7951dc6df7848cef97;
        r_prod[15] = 0x019b91a9d375fe46af22a415a0cba65d78d7a605eecf99b3eff27cd508e6282c;
        r_prod[16] = 0x0780ddd1b7bae1a8aff7cf5a352412e2956c573041e9ec3557bca02d7a2e78a1;

        uint256 expected = 0x2fb845b1e95db8f9b947d9f569955c15c891df75549330fc41097b0128a537dd;

        uint256 gasCost = gasleft();
        uint256 actual = IdentityPolynomialLib.evaluate(r_prod, Bn256.R_MOD);
        console.log("gas cost: ", gasCost - uint256(gasleft()));
        assertEq(actual, expected);

        gasCost = gasleft();
        uint256 actual_assembly = id_evaluate(r_prod, Bn256.R_MOD);
        console.log("gas cost (assembly): ", gasCost - uint256(gasleft()));

        assertEq(actual_assembly, expected);
    }

    function testIdentityPolyEvaluateGrumpkin() public {
        uint256[] memory r_prod = new uint256[](17);
        r_prod[0] = 0x1725a070098a94cf768334d9b0c3ac4a261682687b39c8e6db7ad3c2901d5e24;
        r_prod[1] = 0x26b72d7895ccf170139a9a71e7da7431d81afd3cd5223969d4794ca8b1366241;
        r_prod[2] = 0x2c9493e9d5b214b3cad4bb621544e6001cb1dc10421ede559fb937d89568cd01;
        r_prod[3] = 0x1334cd36b6c002cd14bd1ac0e19bfca3b7fe600634fa22ac5d6fc6b271c50ea1;
        r_prod[4] = 0x24e56409afcdd7500f2608d82db8f7a607cb1c5246aaa03cb30fdab50e6b0131;
        r_prod[5] = 0x27ee3e707f58a066bd5c0c4078fc690de3d108a7f759884c0d890dcf9c71d0ae;
        r_prod[6] = 0x12060dfdd8c1fceaba38ac16288cd391e1bd33e08476edde5dafa859d2bc20c3;
        r_prod[7] = 0x1715421e99f5091ab24230608160f638748e685707ded14d8df5e502eff1c726;
        r_prod[8] = 0x21225c719bfbac3279313676bb52f31d166432319612381d19e29680a23a9e54;
        r_prod[9] = 0x1f5f277e7a112badb02d8cd4794afac553a48acec6eb4895fd4ac287309e0766;
        r_prod[10] = 0x01c6ef7072eae3366e9bac92954116f78dba97d93b34943cdbca7473e03c303c;
        r_prod[11] = 0x2d724a66a4244a6a493bbf6f10e9a1aefce0702e21bc3d1995f4741e0d20e0b6;
        r_prod[12] = 0x287e29cb6788fd94d01ef493dbff1e658619a05ce4fdd1541726bff3cbe8b33b;
        r_prod[13] = 0x106e96134b2e80dc2b4691a8c3ecfc2ea1ef0ab294c5f708cd6774bfeb403009;
        r_prod[14] = 0x2fe84884f541263540ef28f6f103eeccb2413af5378e27d63469466568f56e84;
        r_prod[15] = 0x19a2ee861704322444687829379a8303142709c02feb0f0d56de44c5ab0540e2;
        r_prod[16] = 0x053328f9153fa2d3455c13a25004acd66102e6596877a4952854ee2401233022;

        uint256 expected = 0x1abd738cc5f6956b8bb48f38abee3422dd877599c18804f94a1d037b1aaf7b58;

        uint256 gasCost = gasleft();
        uint256 actual = IdentityPolynomialLib.evaluate(r_prod, Grumpkin.P_MOD);
        console.log("gas cost: ", gasCost - uint256(gasleft()));
        assertEq(actual, expected);

        gasCost = gasleft();
        uint256 actual_assembly = id_evaluate(r_prod, Grumpkin.P_MOD);
        console.log("gas cost (assembly): ", gasCost - uint256(gasleft()));
        assertEq(actual_assembly, expected);
    }

    function id_evaluate(uint256[] memory r, uint256 modulus) private returns (uint256) {
        uint256 output;
        assembly {
            let tmp := 0
            let length := mload(r)
            let index := 0
            for {} lt(index, length) {} {
                tmp := shl(sub(sub(length, index), 1), 1)
                tmp := and(tmp, 0x000000000000000000000000000000000000000000000000ffffffffffffffff)
                tmp := mulmod(tmp, mload(add(r, add(32, mul(32, index)))), modulus)
                output := addmod(tmp, output, modulus)
                index := add(index, 1)
            }
        }

        return output;
    }
}
