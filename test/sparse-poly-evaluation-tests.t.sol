// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.0;

import "@std/Test.sol";
import "src/verifier/step4/SparsePolynomial.sol";
import "src/blocks/pasta/Vesta.sol";
import "src/blocks/pasta/Pallas.sol";

contract SparseEvaluationTest is Test {
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

        SparsePolynomialLib.Z[] memory poly_X = SparsePolynomialLib.setupPoly_X(z0, z1, z2);

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

        SparsePolynomialLib.Z[] memory poly_X = SparsePolynomialLib.setupPoly_X(z0, z1, z2);

        uint256 num_vars = r_y.length;

        uint256 eval_X_expected = 0x1f7d55bb4d7ae09307a68da12fe43fef3acf3dcb0c88929bfdcb6b52c3a8e454;
        uint256 eval_X = SparsePolynomialLib.evaluate(num_vars, poly_X, r_y, Pallas.P_MOD, Pallas.negateBase);
        assertEq(eval_X, eval_X_expected);
    }
}
