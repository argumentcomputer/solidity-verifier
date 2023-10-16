// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.16;

import "@std/Test.sol";
import "src/blocks/SparsePolynomial.sol";
import "src/blocks/pasta/Vesta.sol";
import "src/blocks/pasta/Pallas.sol";
import "src/blocks/grumpkin/Bn256.sol";
import "src/blocks/grumpkin/Grumpkin.sol";

contract SparseEvaluationTest is Test {
    function setupPoly_X(
        SparsePolynomialLib.Z memory z0,
        SparsePolynomialLib.Z memory z1,
        SparsePolynomialLib.Z memory z2
    ) public pure returns (SparsePolynomialLib.Z[] memory) {
        SparsePolynomialLib.Z[] memory poly_X = new SparsePolynomialLib.Z[](3);
        poly_X[0] = z0;
        poly_X[1] = z1;
        poly_X[2] = z2;

        return poly_X;
    }

    function testSparseEvaluationPrimary() public {
        // in Nova implementation r_y[0] is ignored (https://github.com/microsoft/Nova/blob/main/src/spartan/mod.rs#L511)
        uint256[] memory r_y = new uint256[](14);
        // 0x08012c1590c5127d3c6b4fe392b59fb476e4a480929e986393183a712bf11df9;
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

        SparsePolynomialLib.Z memory z0 =
            SparsePolynomialLib.Z(0, 0x00000000000000000000000000000001a389d9eab44c587699bb449d20fe6530);
        SparsePolynomialLib.Z memory z1 =
            SparsePolynomialLib.Z(1, 0x2e56d20a56a66f2ba12798f718d7d3071f18e03da5d4cac52190ba09ae72f46a);
        SparsePolynomialLib.Z memory z2 =
            SparsePolynomialLib.Z(2, 0x2875f52ba1a60c5b478f684b058d0e2bf2ce904bd0a377ce38699d1a2aa69fad);

        SparsePolynomialLib.Z[] memory poly_X = setupPoly_X(z0, z1, z2);

        uint256 num_vars = r_y.length;

        uint256 eval_X_expected = 0x0529a26b256de07461339aff1ae1572655ae78c8578adeae7de834d804749230;
        uint256 eval_X = SparsePolynomialLib.evaluate(num_vars, poly_X, r_y, Vesta.P_MOD, Vesta.negateBase);
        assertEq(eval_X, eval_X_expected);
    }

    function testSparseEvaluationSecondary() public {
        // in Nova implementation r_y[0] is ignored (https://github.com/microsoft/Nova/blob/main/src/spartan/mod.rs#L511)
        uint256[] memory r_y = new uint256[](14);
        // 0x133d7ae3ae852269542c5198e6d1054dfc720f32dc111075699e40f4bed9dc98;
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

        SparsePolynomialLib.Z memory z0 =
            SparsePolynomialLib.Z(0, 0x00000000000000000000000000000001e4444ecefc90a788e6a520cdef7c6e46);
        SparsePolynomialLib.Z memory z1 =
            SparsePolynomialLib.Z(1, 0x32d8d912584abe410b9c9c56cc9efdb0261ed5a636e0fc823bd5b427cf9fcbee);
        SparsePolynomialLib.Z memory z2 =
            SparsePolynomialLib.Z(2, 0x25b86df67043654b4f2becbaf1ea152688dfeffdb1de89cdf0164c59b0330198);

        SparsePolynomialLib.Z[] memory poly_X = setupPoly_X(z0, z1, z2);

        uint256 num_vars = r_y.length;

        uint256 eval_X_expected = 0x1f7d55bb4d7ae09307a68da12fe43fef3acf3dcb0c88929bfdcb6b52c3a8e454;
        uint256 eval_X = SparsePolynomialLib.evaluate(num_vars, poly_X, r_y, Pallas.P_MOD, Pallas.negateBase);
        assertEq(eval_X, eval_X_expected);
    }

    function testSparseEvaluateBn256() public {
        SparsePolynomialLib.Z memory z0 =
            SparsePolynomialLib.Z(0, 0x000000000000000000000000000000010a3cb5af114bc6094024d5e8b5817038);
        SparsePolynomialLib.Z memory z1 =
            SparsePolynomialLib.Z(1, 0x08f230d21087f2e0ea33703b5a0de3b92ff58b09b8bdbcee2016f70d7699cbd9);
        SparsePolynomialLib.Z memory z2 =
            SparsePolynomialLib.Z(2, 0x1e7d17e953a2bee716b7139675a0fc9c1a3d34f00c1c071eac84e21f33841927);

        SparsePolynomialLib.Z[] memory poly_X = setupPoly_X(z0, z1, z2);

        uint256[] memory r_prod_unpad = new uint256[](14);
        // 0x0256f4d5674a529ec39e0afba3738d0263cb1d385a563ce608edad719f47d5fd;
        r_prod_unpad[0] = 0x00f87554a6caed435bb9e714a355fa73cfd359d5dd8b31fc172ada8cecd7ee30;
        r_prod_unpad[1] = 0x29b4dbb7be87a4961e21fe447b03125469077ba2bad896ac2c374aa55be358ab;
        r_prod_unpad[2] = 0x1493591a52ded39471fbcd9937537aae9023e77080708f790798671aaa268fc9;
        r_prod_unpad[3] = 0x046d5e95bee7ea383f29e0ffa2a6e2816d5b82a75283265e2bc17e63d6ecaeee;
        r_prod_unpad[4] = 0x0ea46d83cda8cac4084d937137ab451e89d3fef4b6e25ec00e80fcb8bf8a5308;
        r_prod_unpad[5] = 0x26d16ee1e12b5e781327f54a2b89bb7f397e500ec503066b4e37c5e59c372aa1;
        r_prod_unpad[6] = 0x2826c37882e6cec0184d476e6e14ac3cb48aee6e233a1ee085c174d53cf1f419;
        r_prod_unpad[7] = 0x1b054f124db95f87ec662a5b8ddf47f2b0264e97ef866a05e2a3e0335bce3b16;
        r_prod_unpad[8] = 0x0fd296132bf7fc749c44059331d68c735b05f8f746c26e0bf25c3e0a0e6b17b1;
        r_prod_unpad[9] = 0x2aede350fab3723fb2ed55ed281f40e4a718f43237901e99264cb09a586661ef;
        r_prod_unpad[10] = 0x1a99798029810bbe8a2a5e0d738e8a7c54c010acf84892178463c3222d08b351;
        r_prod_unpad[11] = 0x01611bd374a32895d454f4fbe32f051f82e1fef13242ee7951dc6df7848cef97;
        r_prod_unpad[12] = 0x019b91a9d375fe46af22a415a0cba65d78d7a605eecf99b3eff27cd508e6282c;
        r_prod_unpad[13] = 0x0780ddd1b7bae1a8aff7cf5a352412e2956c573041e9ec3557bca02d7a2e78a1;

        uint256 eval_X_expected = 0x150bdf49815f761a709a60620133c9173e54c66514cb3b2bd3ff9dabfa24870d;

        uint256 gasCost = gasleft();
        uint256 eval_X =
            SparsePolynomialLib.evaluate(r_prod_unpad.length, poly_X, r_prod_unpad, Bn256.R_MOD, Bn256.negateScalar);
        console.log("gas cost: ", gasCost - gasleft());
        assertEq(eval_X, eval_X_expected);

        gasCost = gasleft();
        uint256 eval_X_assembly = sparse_evaluate(r_prod_unpad, poly_X, Bn256.R_MOD);
        console.log("gas cost (assembly): ", gasCost - gasleft());

        assertEq(eval_X_assembly, eval_X_expected);
    }

    function testSparseEvaluateGrumpkin() public {
        SparsePolynomialLib.Z memory z0 =
            SparsePolynomialLib.Z(0, 0x00000000000000000000000000000001d523e9da28bbf206fe50868f52ca6334);
        SparsePolynomialLib.Z memory z1 =
            SparsePolynomialLib.Z(1, 0x03b173e20dfa9ec307f5eb55a0f8da20620d9e184dc69395a7d92cc30551728d);
        SparsePolynomialLib.Z memory z2 =
            SparsePolynomialLib.Z(2, 0x25049ad98282284f65ff8435aec45c47f9a39123eb6a33e8499ae079c504507a);

        SparsePolynomialLib.Z[] memory poly_X = setupPoly_X(z0, z1, z2);

        uint256[] memory r_prod_unpad = new uint256[](14);
        // 0x2c9493e9d5b214b3cad4bb621544e6001cb1dc10421ede559fb937d89568cd01;
        r_prod_unpad[0] = 0x1334cd36b6c002cd14bd1ac0e19bfca3b7fe600634fa22ac5d6fc6b271c50ea1;
        r_prod_unpad[1] = 0x24e56409afcdd7500f2608d82db8f7a607cb1c5246aaa03cb30fdab50e6b0131;
        r_prod_unpad[2] = 0x27ee3e707f58a066bd5c0c4078fc690de3d108a7f759884c0d890dcf9c71d0ae;
        r_prod_unpad[3] = 0x12060dfdd8c1fceaba38ac16288cd391e1bd33e08476edde5dafa859d2bc20c3;
        r_prod_unpad[4] = 0x1715421e99f5091ab24230608160f638748e685707ded14d8df5e502eff1c726;
        r_prod_unpad[5] = 0x21225c719bfbac3279313676bb52f31d166432319612381d19e29680a23a9e54;
        r_prod_unpad[6] = 0x1f5f277e7a112badb02d8cd4794afac553a48acec6eb4895fd4ac287309e0766;
        r_prod_unpad[7] = 0x01c6ef7072eae3366e9bac92954116f78dba97d93b34943cdbca7473e03c303c;
        r_prod_unpad[8] = 0x2d724a66a4244a6a493bbf6f10e9a1aefce0702e21bc3d1995f4741e0d20e0b6;
        r_prod_unpad[9] = 0x287e29cb6788fd94d01ef493dbff1e658619a05ce4fdd1541726bff3cbe8b33b;
        r_prod_unpad[10] = 0x106e96134b2e80dc2b4691a8c3ecfc2ea1ef0ab294c5f708cd6774bfeb403009;
        r_prod_unpad[11] = 0x2fe84884f541263540ef28f6f103eeccb2413af5378e27d63469466568f56e84;
        r_prod_unpad[12] = 0x19a2ee861704322444687829379a8303142709c02feb0f0d56de44c5ab0540e2;
        r_prod_unpad[13] = 0x053328f9153fa2d3455c13a25004acd66102e6596877a4952854ee2401233022;

        uint256 eval_X_expected = 0x090edee35dda0b8a23da057d53201d4bd171b00405f04a4562777f60898718bd;

        uint256 gasCost = gasleft();
        uint256 eval_X =
            SparsePolynomialLib.evaluate(r_prod_unpad.length, poly_X, r_prod_unpad, Grumpkin.P_MOD, Grumpkin.negateBase);
        console.log("gas cost: ", gasCost - gasleft());
        assertEq(eval_X, eval_X_expected);

        gasCost = gasleft();
        uint256 eval_X_assembly = sparse_evaluate(r_prod_unpad, poly_X, Grumpkin.P_MOD);
        console.log("gas cost: ", gasCost - gasleft());

        assertEq(eval_X_assembly, eval_X_expected);
    }

    function sparse_evaluate(uint256[] memory r_prod_unpad, SparsePolynomialLib.Z[] memory poly_X, uint256 modulus)
        private
        returns (uint256)
    {
        uint256 output;
        assembly {
            let poly_X_len := mload(poly_X)
            let r_prod_unpad_length := mload(r_prod_unpad)

            let index := 0
            for {} lt(index, poly_X_len) {} {
                let chi := 1
                let r_y_index := 0
                let poly_X_pointer := mload(add(poly_X, add(32, mul(32, index))))
                let z := mload(poly_X_pointer)

                let j := 0
                for {} lt(j, r_prod_unpad_length) {} {
                    switch eq(and(shr(sub(sub(r_prod_unpad_length, j), 1), z), 1), 1)
                    case 1 {
                        r_y_index := mload(add(r_prod_unpad, add(32, mul(32, j))))
                        chi := mulmod(chi, r_y_index, modulus)
                    }
                    default {
                        r_y_index := sub(modulus, mod(mload(add(r_prod_unpad, add(32, mul(32, j)))), modulus))
                        chi := mulmod(chi, addmod(1, r_y_index, modulus), modulus)
                    }

                    j := add(j, 1)
                }
                // accumulate result
                z := mload(add(poly_X_pointer, 32))
                chi := mulmod(chi, z, modulus)
                output := addmod(output, chi, modulus)

                index := add(index, 1)
            }
        }
        return output;
    }
}
