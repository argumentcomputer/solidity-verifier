pragma solidity ^0.8.0;

// This contract is for debugging/testing purposes
library PoseidonU6Bls
{
    struct HashInputs7
    {
        uint t0;
        uint t1;
        uint t2;
        uint t3;
        uint t4;
        uint t5;
        uint t6;
    }

    function mix(HashInputs7 memory i, uint q) internal pure
    {
        HashInputs7 memory o;

        o.t0 = 0;
        o.t0 = addmod(o.t0, mulmod(i.t0, 0x211f5460e751918257c7624b7077624aaa362edc49241a48db6db6db24924925, q), q);
        o.t0 = addmod(o.t0, mulmod(i.t1, 0x656ff268c469cd9f2cd29d07086d9d04a945ef829ffe907f1fffffff20000001, q), q);
        o.t0 = addmod(o.t0, mulmod(i.t2, 0x19c308bd25b13848eef068e557794c72f62a247271c6bf1c38e38e38aaaaaaab, q), q);
        o.t0 = addmod(o.t0, mulmod(i.t3, 0x22c74bcc2615a595a8f7c0cf3616f401991f4acdb332b532e66666661999999a, q), q);
        o.t0 = addmod(o.t0, mulmod(i.t4, 0x6963af62e003892a5d1d50074e93217934daf23145cff68aba2e8ba200000001, q), q);
        o.t0 = addmod(o.t0, mulmod(i.t5, 0x6a44840c3b7b082cd99fb0b208d45b5a376dd6581553d4546aaaaaa9c0000001, q), q);
        o.t0 = addmod(o.t0, mulmod(i.t6, 0x6217dc5a0f85429f8dce7bb808267bb5bd02ed3d9d88753a3b13b13a3b13b13c, q), q);

        o.t1 = 0;
        o.t1 = addmod(o.t1, mulmod(i.t0, 0x656ff268c469cd9f2cd29d07086d9d04a945ef829ffe907f1fffffff20000001, q), q);
        o.t1 = addmod(o.t1, mulmod(i.t1, 0x19c308bd25b13848eef068e557794c72f62a247271c6bf1c38e38e38aaaaaaab, q), q);
        o.t1 = addmod(o.t1, mulmod(i.t2, 0x22c74bcc2615a595a8f7c0cf3616f401991f4acdb332b532e66666661999999a, q), q);
        o.t1 = addmod(o.t1, mulmod(i.t3, 0x6963af62e003892a5d1d50074e93217934daf23145cff68aba2e8ba200000001, q), q);
        o.t1 = addmod(o.t1, mulmod(i.t4, 0x6a44840c3b7b082cd99fb0b208d45b5a376dd6581553d4546aaaaaa9c0000001, q), q);
        o.t1 = addmod(o.t1, mulmod(i.t5, 0x6217dc5a0f85429f8dce7bb808267bb5bd02ed3d9d88753a3b13b13a3b13b13c, q), q);
        o.t1 = addmod(o.t1, mulmod(i.t6, 0x4a867dda0877876545809d29bd0c9d27fef9e96fa4913b23edb6db6d12492493, q), q);

        o.t2 = 0;
        o.t2 = addmod(o.t2, mulmod(i.t0, 0x19c308bd25b13848eef068e557794c72f62a247271c6bf1c38e38e38aaaaaaab, q), q);
        o.t2 = addmod(o.t2, mulmod(i.t1, 0x22c74bcc2615a595a8f7c0cf3616f401991f4acdb332b532e66666661999999a, q), q);
        o.t2 = addmod(o.t2, mulmod(i.t2, 0x6963af62e003892a5d1d50074e93217934daf23145cff68aba2e8ba200000001, q), q);
        o.t2 = addmod(o.t2, mulmod(i.t3, 0x6a44840c3b7b082cd99fb0b208d45b5a376dd6581553d4546aaaaaa9c0000001, q), q);
        o.t2 = addmod(o.t2, mulmod(i.t4, 0x6217dc5a0f85429f8dce7bb808267bb5bd02ed3d9d88753a3b13b13a3b13b13c, q), q);
        o.t2 = addmod(o.t2, mulmod(i.t5, 0x4a867dda0877876545809d29bd0c9d27fef9e96fa4913b23edb6db6d12492493, q), q);
        o.t2 = addmod(o.t2, mulmod(i.t6, 0x3dd414f92742ed7bd70dc88cd1efeaad81febddf77769776eeeeeeee66666667, q), q);

        o.t3 = 0;
        o.t3 = addmod(o.t3, mulmod(i.t0, 0x22c74bcc2615a595a8f7c0cf3616f401991f4acdb332b532e66666661999999a, q), q);
        o.t3 = addmod(o.t3, mulmod(i.t1, 0x6963af62e003892a5d1d50074e93217934daf23145cff68aba2e8ba200000001, q), q);
        o.t3 = addmod(o.t3, mulmod(i.t2, 0x6a44840c3b7b082cd99fb0b208d45b5a376dd6581553d4546aaaaaa9c0000001, q), q);
        o.t3 = addmod(o.t3, mulmod(i.t3, 0x6217dc5a0f85429f8dce7bb808267bb5bd02ed3d9d88753a3b13b13a3b13b13c, q), q);
        o.t3 = addmod(o.t3, mulmod(i.t4, 0x4a867dda0877876545809d29bd0c9d27fef9e96fa4913b23edb6db6d12492493, q), q);
        o.t3 = addmod(o.t3, mulmod(i.t5, 0x3dd414f92742ed7bd70dc88cd1efeaad81febddf77769776eeeeeeee66666667, q), q);
        o.t3 = addmod(o.t3, mulmod(i.t6, 0x6caeccddf703a573b0063a878907ba84fe81c9c2cffe763f0fffffff10000001, q), q);

        o.t4 = 0;
        o.t4 = addmod(o.t4, mulmod(i.t0, 0x6963af62e003892a5d1d50074e93217934daf23145cff68aba2e8ba200000001, q), q);
        o.t4 = addmod(o.t4, mulmod(i.t1, 0x6a44840c3b7b082cd99fb0b208d45b5a376dd6581553d4546aaaaaa9c0000001, q), q);
        o.t4 = addmod(o.t4, mulmod(i.t2, 0x6217dc5a0f85429f8dce7bb808267bb5bd02ed3d9d88753a3b13b13a3b13b13c, q), q);
        o.t4 = addmod(o.t4, mulmod(i.t3, 0x4a867dda0877876545809d29bd0c9d27fef9e96fa4913b23edb6db6d12492493, q), q);
        o.t4 = addmod(o.t4, mulmod(i.t4, 0x3dd414f92742ed7bd70dc88cd1efeaad81febddf77769776eeeeeeee66666667, q), q);
        o.t4 = addmod(o.t4, mulmod(i.t5, 0x6caeccddf703a573b0063a878907ba84fe81c9c2cffe763f0fffffff10000001, q), q);
        o.t4 = addmod(o.t4, mulmod(i.t6, 0x1b46fa31af7059b6a2a432d4b6f8e788c868db4bffff9d2cf0f0f0f0b4b4b4b5, q), q);

        o.t5 = 0;
        o.t5 = addmod(o.t5, mulmod(i.t0, 0x6a44840c3b7b082cd99fb0b208d45b5a376dd6581553d4546aaaaaa9c0000001, q), q);
        o.t5 = addmod(o.t5, mulmod(i.t1, 0x6217dc5a0f85429f8dce7bb808267bb5bd02ed3d9d88753a3b13b13a3b13b13c, q), q);
        o.t5 = addmod(o.t5, mulmod(i.t2, 0x4a867dda0877876545809d29bd0c9d27fef9e96fa4913b23edb6db6d12492493, q), q);
        o.t5 = addmod(o.t5, mulmod(i.t3, 0x3dd414f92742ed7bd70dc88cd1efeaad81febddf77769776eeeeeeee66666667, q), q);
        o.t5 = addmod(o.t5, mulmod(i.t4, 0x6caeccddf703a573b0063a878907ba84fe81c9c2cffe763f0fffffff10000001, q), q);
        o.t5 = addmod(o.t5, mulmod(i.t5, 0x1b46fa31af7059b6a2a432d4b6f8e788c868db4bffff9d2cf0f0f0f0b4b4b4b5, q), q);
        o.t5 = addmod(o.t5, mulmod(i.t6, 0x46d8580827a75ac891152076b08d923c24f3e43ab8e28d8d9c71c71bd5555556, q), q);

        o.t6 = 0;
        o.t6 = addmod(o.t6, mulmod(i.t0, 0x6217dc5a0f85429f8dce7bb808267bb5bd02ed3d9d88753a3b13b13a3b13b13c, q), q);
        o.t6 = addmod(o.t6, mulmod(i.t1, 0x4a867dda0877876545809d29bd0c9d27fef9e96fa4913b23edb6db6d12492493, q), q);
        o.t6 = addmod(o.t6, mulmod(i.t2, 0x3dd414f92742ed7bd70dc88cd1efeaad81febddf77769776eeeeeeee66666667, q), q);
        o.t6 = addmod(o.t6, mulmod(i.t3, 0x6caeccddf703a573b0063a878907ba84fe81c9c2cffe763f0fffffff10000001, q), q);
        o.t6 = addmod(o.t6, mulmod(i.t4, 0x1b46fa31af7059b6a2a432d4b6f8e788c868db4bffff9d2cf0f0f0f0b4b4b4b5, q), q);
        o.t6 = addmod(o.t6, mulmod(i.t5, 0x46d8580827a75ac891152076b08d923c24f3e43ab8e28d8d9c71c71bd5555556, q), q);
        o.t6 = addmod(o.t6, mulmod(i.t6, 0x6dd3abfdf187ba0e815f38736770e79941dc14a486bb13c9286bca1a00000001, q), q);

        i.t0 = o.t0;
        i.t1 = o.t1;
        i.t2 = o.t2;
        i.t3 = o.t3;
        i.t4 = o.t4;
        i.t5 = o.t5;
        i.t6 = o.t6;
    }

    function ark(HashInputs7 memory i, uint q, HashInputs7 memory c) internal pure
    {
        HashInputs7 memory o;

        o.t0 = addmod(i.t0, c.t0, q);
        o.t1 = addmod(i.t1, c.t1, q);
        o.t2 = addmod(i.t2, c.t2, q);
        o.t3 = addmod(i.t3, c.t3, q);
        o.t4 = addmod(i.t4, c.t4, q);
        o.t5 = addmod(i.t5, c.t5, q);
        o.t6 = addmod(i.t6, c.t6, q);

        i.t0 = o.t0;
        i.t1 = o.t1;
        i.t2 = o.t2;
        i.t3 = o.t3;
        i.t4 = o.t4;
        i.t5 = o.t5;
        i.t6 = o.t6;
    }

    function sbox_full(HashInputs7 memory i, uint q) internal pure
    {
        HashInputs7 memory o;

        o.t0 = mulmod(i.t0, i.t0, q);
        o.t0 = mulmod(o.t0, o.t0, q);
        o.t0 = mulmod(i.t0, o.t0, q);
        o.t1 = mulmod(i.t1, i.t1, q);
        o.t1 = mulmod(o.t1, o.t1, q);
        o.t1 = mulmod(i.t1, o.t1, q);
        o.t2 = mulmod(i.t2, i.t2, q);
        o.t2 = mulmod(o.t2, o.t2, q);
        o.t2 = mulmod(i.t2, o.t2, q);
        o.t3 = mulmod(i.t3, i.t3, q);
        o.t3 = mulmod(o.t3, o.t3, q);
        o.t3 = mulmod(i.t3, o.t3, q);
        o.t4 = mulmod(i.t4, i.t4, q);
        o.t4 = mulmod(o.t4, o.t4, q);
        o.t4 = mulmod(i.t4, o.t4, q);
        o.t5 = mulmod(i.t5, i.t5, q);
        o.t5 = mulmod(o.t5, o.t5, q);
        o.t5 = mulmod(i.t5, o.t5, q);
        o.t6 = mulmod(i.t6, i.t6, q);
        o.t6 = mulmod(o.t6, o.t6, q);
        o.t6 = mulmod(i.t6, o.t6, q);

        i.t0 = o.t0;
        i.t1 = o.t1;
        i.t2 = o.t2;
        i.t3 = o.t3;
        i.t4 = o.t4;
        i.t5 = o.t5;
        i.t6 = o.t6;
    }

    function sbox_partial(HashInputs7 memory i, uint q) internal pure
    {
        HashInputs7 memory o;

        o.t0 = mulmod(i.t0, i.t0, q);
        o.t0 = mulmod(o.t0, o.t0, q);
        o.t0 = mulmod(i.t0, o.t0, q);

        i.t0 = o.t0;
    }

    function hash(HashInputs7 memory i, uint q) internal pure returns (uint)
    {
        // validate inputs
        require(i.t0 < q, "INVALID_INPUT");
        require(i.t1 < q, "INVALID_INPUT");
        require(i.t2 < q, "INVALID_INPUT");
        require(i.t3 < q, "INVALID_INPUT");
        require(i.t4 < q, "INVALID_INPUT");
        require(i.t5 < q, "INVALID_INPUT");
        require(i.t6 < q, "INVALID_INPUT");

        // round 0
        ark(i, q, HashInputs7(0x5c72d2cf405b5ee824e54cb1ff5acb1776802428b042df9b59fa85e4eb3e8f6f,
            0x624229fe6c8a33fdc6adfa1eaefb7a386f2b40c5d594f75d8381bf19d010abdf,
            0x3f3fb27ffa569ded5564b5ee766a6721716e1c116ecd368f86a7ac621199534d,
            0x6bc1c463efa733daf6b6894e11420e6bd6dc4e5a733acadc763d5b15d46d232a,
            0x53aea0de8570cc9f15d9f4583b11b26daadbb93bd8c2baf566aa0a187bcf921c,
            0x696acc17fb193072de5c433545f0965c9dfb9399ed69610dc1f1bf8cd3fd4307,
            0x38e4c6a3ba2fae3fdea2e8305a3697d400dede47e9757491dee804cb481ad3ff)
        );
        sbox_full(i, q);
        mix(i, q);
        // round 1
        ark(i, q, HashInputs7(0x1bedebbaba6bc9813a18893ae03ccc6ae4739f5b8328a0a81dab7520b732c4e4,
            0x1d872276362e1dfede391e27b07f6f2c7e1b3d16b43d36ca237327cb7bc0cc76,
            0x42e75f20845bbefe97754318d130eaf9979aa461374ff7b4e9554d3f148a6634,
            0x1378a0b5a34df9251874462d6e1c52cb1494773b44ba283a0957e8ddbe263e1a,
            0x616f1b20dc03b8f23d2556bf34fadabc0b16da6e41f2ec9de53a04d803c1fe28,
            0x0f7dd801d109c0b6ec88aff4cfeebca848d0165ac216817068cf6257b45324fe,
            0x22b1ac9391e9e5af16cff7d8be66daa4b574c43aab0faa6755a6ec5d794dd49f)
        );
        sbox_full(i, q);
        mix(i, q);
        // round 2
        ark(i, q, HashInputs7(0x5fb10032802925e008ec08495f964c8e2321c91a1918ad1e3833690026e780d2,
            0x4d68efabbca32ea14b662db0e27766ab7287b35147e0529333d8ce8a26d3d59b,
            0x56e8ac88d8742210eec3b6d874e2c2d0c88f46873babfc070d38d504345a6103,
            0x3abc7884ea607856dd0ae70ea10d6536801df175f22525c86f622375c3823e98,
            0x711ba5bc25dd7b5f2939faec9a373ef27d3e05423f0fcd26fc02e0a89e0c0495,
            0x1bb81d5ee36b82aacffe7715c3b2fe257a086548ba26e6e7b8a4eb254399aeb4,
            0x5cb8adeeab266d353ae9a44c29d37941437f7269a1e1df8ae42972b6aaf0d21a)
        );
        sbox_full(i, q);
        mix(i, q);
        // round 3
        ark(i, q, HashInputs7(0x2e1bb7a18e76e522ea0a40e4d8517c19ab2282d97f699c8863413b4dc05f0edd,
            0x32fb35bc273421f2132babdeeb29ff81a7b941e09533e419e24d5adc5771b0aa,
            0x0cc25aae40f5788291031aa89a94a8a8750ffba6a15bee00f2559a517e2f568a,
            0x6093fe672fb6d88e148b05d2d0ee5bf396007d4ba17a4eeab0335515c9ca7295,
            0x4f7325bfcc49e3df479c7a3454aa20cf900bdcd978bf6ad6c111a4ee28c2db27,
            0x52f0d8dae76bae8190d3b064cc76d7ffaff9f6cf78cebb9a3837c9d11b53adba,
            0x739010608cbefe356b06ada718e44bf93e10ff6196ac0e4e3eb372af826af69c)
        );
        sbox_full(i, q);
        mix(i, q);
        // round 4
        ark(i, q, HashInputs7(0x2973d4778f5384c8379c1b976012d4378f8a715d6b57386e2787fb10faf15dce,
            0x65d155d298c331cbf7c0a51f012fe23a14ab2054a5077dc1efe5695731efc6e0,
            0x1c3aef943907845073ea0472b6702d3df3ba495cdd9cabc3b10c6c37ae199418,
            0x538411f64c3308b1fea547cbd21ae1349a3a9e4921cbddf8dad2f5cd54a10e33,
            0x5c89134572fc17e05d5f96c88bccdc3c6a2ea65271dc24e31e317adb17fbded8,
            0x3af67ed06e0b9cf5144e885de3011e2fad8a0ce758e98a78115438d1591b2993,
            0x39be9b4bca6cff5a8b73f9d628f203b7e58e7d36dfe196cbede63071c601c94f)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 5
        ark(i, q, HashInputs7(0x57e75b2df9b240ed6930d1071c0b5cb769283101e9a666de34d422bd0dbd8e02,
            0x69cde0a34800e10bc769a117cf6e377d638eef6a2536e377dae144ae90a110f0,
            0x0d3b04e8db1a27c8ac626991bf7b07603a5defa59184af7ae83fb2441aa4e6ba,
            0x4044b3ebcddc899a2c83381837e1b8dcd081b9a1468a7a6d86fb354f502b9654,
            0x1527a95340c1764c78bb1e1d903422aeeecee2fa0451c39c073b380e287dc14c,
            0x345df9ca3f660b12d26ce42d29fc7bf4d04131b15f3bf5ed9c0ad6a9b006d114,
            0x15298ad6bd74e453a4520646da44f7b4a0ed7689397928f9e8c639316e94a43b)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 6
        ark(i, q, HashInputs7(0x22ec9bc98c699c271d4a68847bed6e90c049bfd14bce08efd11695ce619fc693,
            0x13c688bcb2f22817ef2f8d3491132846f63996883241ec19d04f64d6718379f8,
            0x477c2ae8e29642ccd72ac30fb9522efd523144e0e8a4bd39099dae4d023ae309,
            0x6e92bc1c611bc4380d29bb6d16e33ff1c16eca79baa62d6790c663bc7854782a,
            0x15760b9c01bae985b1fb1dd70a42fb6a834611556a1ae215d1e926d332d26f3d,
            0x55babeded69169ff6097a71b134785e2e463041773c75c8c7ee7efdf3ab7b3eb,
            0x193cd89d2667497806870f037d905caac1d4f424af24e11e8fcb7c6a1db57579)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 7
        ark(i, q, HashInputs7(0x327b944b8c63dda18b02a0735c8249948e248a88a71a558cfae51815d60e64f2,
            0x1de8e06f7547ac60c06725f99bd616f216d12b366b3f82b7401825f640f9467f,
            0x50bb1f5cba593bde48f42766265e109e4b5d92084158132a736bfd973350c64d,
            0x6e16682573359aa0ea60033dcf5f6f622639aef0381925aed97d113eb86ae9cd,
            0x304600389897080f0c3c4262104b2bfb66f55ae6494a2c89e00529af736b8c1d,
            0x1979eada0e4a6d3985e58368f9099f7278ca7e1cdc2e75158a3f206b1c4c6f74,
            0x41f7d5a0ad34cbab621778f6a68a8372dcd63edc2562734770f49f0566dff506)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 8
        ark(i, q, HashInputs7(0x359f51183f69a303136b61e9fa517b3fdd98f27c4a503105cc362ff814023c76,
            0x6e5e0dd024cace707d002a5597f2d4126fd4dd48de56b025a516382eaab91cce,
            0x6e95b8d1267cdd5801991b4c7c30e52321b3574d364631ca225804eaf9dd9b02,
            0x23f05778902b7404f69adc3b73df5925bad6988417dbd22b7046b9165b3acb65,
            0x04b93a637307dd55f28fb17f7bea219b95efab13699e7c8581217eecac0da583,
            0x70bed7f6fd36c6ac0e1eadeccec8a870bd1d931ac063a9ea1b2633baa447cf98,
            0x6a749cfccce93d8ddb752bd2da4b0039e5e8686e2438eba3ba792b683367c3dd)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 9
        ark(i, q, HashInputs7(0x3d02f4e35b9c909e09928051740ff5f780af8b07b4bfed1d592bbc9d183c516f,
            0x4b68b33e4f52e4be2cd0dc045d3ff0718dcbf8f92e44a7e0445e8bdb4f534dba,
            0x5dd068cdc8593c7a66aa08b38bd2fd2d9623fb14982c2786cc9887f3c36ea96a,
            0x26873db484493d526b024c426162986e9ab9dd4f0f339d9b2593fa3f8e9b0570,
            0x0cd1ec1f9a19d9682d8670a6c07d28bb0bc1015744a13fe1ddd84df1dc5083f5,
            0x4bb2268a160ed86aa34a0342dfd697b345ddee73461c708e36482319fbb71a17,
            0x12a63032ad1b5eef45f5b4d7a0c7df911438346034bd8eac51c5c0b63df0e170)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 10
        ark(i, q, HashInputs7(0x5e304ad4ba0473b8481951a5915e51ad9831313f37e8f8d696d82810c4ad3fa3,
            0x6df9a21ec96df4161df010b1d44a2ce93de5b2c1fe36af950f603ea2b989dc9b,
            0x549ecc81842c9c17db7518d6d4c2be0cf63a487724daf191a77235a62921fc7d,
            0x14db92cad4d4ff84b745951380dd4eba26bc61b61a111518d506bafbb320df18,
            0x57042eafe602a9058a5a925fadb913bf3754129d55bdc661383ad0a386625c87,
            0x1c742a1c69f1db5460bdc73eabf07a8069b449574744336f1ac5d7f52be1e9f0,
            0x6114dc82aa43bddb2b999f065771333942ffdd7cdd1873681b472cc9869b1103)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 11
        ark(i, q, HashInputs7(0x28926244a3d4dcc08304168ee32340642c1ad31ca00857bc01f2615d760d3d8d,
            0x4422858eebf559523c7f0d4f075979337d4bdf9a019a32a09fb41a28ef37b506,
            0x6892ce517bb9f57d5b6eb7789a2bca93ad33c31c4143d609d00bacbf84a6b853,
            0x6ba234bc8bb048db809532a4af40f0e69fd59331779060819335af842a4649a4,
            0x138107871f7f4c75954f837f41e250cdec3c4c726deea89d8388a880548e0826,
            0x577c3c00dd043e6801b66c751d14646526a28d07627e95326d20ca5e80e24aed,
            0x6badd0317223059a279dc7526248bed6218644a3535c639caf1e183f0531123f)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 12
        ark(i, q, HashInputs7(0x53fefbdc3d7cc36979494c5a12ed13f458f5d3d80d6c842d672b63c5b760f3f7,
            0x2789622667197bbca5a0efcd2ce26b86548b602856d106edfcf5382dfe59bf9d,
            0x04fdc544101e5f1145bb74ecbacb385b06c491964811e8ba2a27cb73f8f376b0,
            0x1b0fde1c14dcc87d7cbf7a6ce333258febca42f63b061477a6f72fbf5ad97a56,
            0x216c69eb73b49578b0165554465c327649164c168a03f87b936e60487d435a74,
            0x69a084a4ff0831cc30220cd8108d9cbe55ea8e4361ed5ba9d95c67f79d8bd711,
            0x5490a719a5584205f11ddcddf541004fcb0ba62f2c5491603fd8fa2dc653725e)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 13
        ark(i, q, HashInputs7(0x2917263200195a2a4de679f06c5f3bf26a33e246bd4fc319cc2957d2177f4780,
            0x460d2a78cb4fb119a4718bb25d47a6a82dde162b824956ee96dc3bc6fbc14c8e,
            0x0852e0d24fe0fa70026c7d4775357769459d177a8ebccde08060b9f4e4529140,
            0x19966d450ff94ef4a24a6c4b45fabd8a05768ce040eae0731a1f83d30118e818,
            0x19895fcf3d0ae5eccfcab95e50efa2bf7ec681985310ee779e37ea2ac237bb5a,
            0x66feba7baf44b0c35c59ce83aabea4cc4126c35767d0b1561ab95bc322b1f8fc,
            0x62dcb5180d5f19ef66832f2b024dc4f569a2592dd5f505bc13185294ecb4f220)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 14
        ark(i, q, HashInputs7(0x309a580c302fe68eeb0d32ae1c9b2516b1567d30a1d9ed0dc89740831393229d,
            0x0d4b4b7111269e9b228f5d1edcb5bcf0f61943f793d74cb2a2bbaef3770bab77,
            0x5719e698fed185f5bf8afe398c324f8f81ec278bc91a785cc01bb242a5afa487,
            0x4dd23f5dafec2fbc5c3ccf36b34273c64fcdc437d4dcfdf2fe2cf0ff73b8b7cc,
            0x469c9f593a7f5d5f758e345163e550e78142f8c82556dfcc0e4741c9a5bec6fb,
            0x3d7430db6d5219d81ad04262f6c50d5fc97769e6b47cf9f4ecf3902bba783312,
            0x031bf1b4a6c0ca5850f2ef4e361a8e153ac03d48a5ae7515d1ba83395cad2f1c)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 15
        ark(i, q, HashInputs7(0x36fc15ed49a5ed784c803047162f3ee73115aaea1a30d69457747d79f8ddb8c3,
            0x09c6c536d36e6ba4f5389ce7af9b3f634d2562fe299180e4094b36796f4d0ff9,
            0x0ffd78f332828d7ae44aef4d95a65336ac153f65d25abfae3a7cc7ff09b5a284,
            0x5223ff77307656b830cf245ce9c9aa250c139556f04f7ddac044922ada697684,
            0x4ad6deb4619c2ad730f17003edc63931253939cc0c4a4d2fd64da45d60ba296d,
            0x1b154ca987b8282fbb6b7d0d597033913da91e7ac1d8a19446c211e58ec3dcaf,
            0x4943b1876f7cd033311099318690dea713afe4dc811df17219d96c8ea522beef)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 16
        ark(i, q, HashInputs7(0x1a2473d6b5a621994d14f1696c05b9875c17f993151f3cda2a87b05f36299822,
            0x4e719e92531c9c8ebd113f7de8143b9f65a6a570436272be0d2e3ad7b579d220,
            0x03a9d6870b5ab5e4806108d64a16e8cd986e7ad3c3fbd36700d1ef058fb59f10,
            0x3ca889db28f96902a8174a3bb5f30fe1b430c6f114e4eca4eb8fe5907d5bad14,
            0x081bbbdac48b1d68ca72a97c9242f6826b73c3317de92abe02044aff4922cc9d,
            0x28ada06687ff095394dfa8e7f6133e4622346d08d8ce97f0abbfc5b16b801552,
            0x09ad56125945a6877390f8b260330f9bf8e22b0ee8c46dcc4a4d9e5c0af3fbcf)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 17
        ark(i, q, HashInputs7(0x70561a5c0cbccc5646c95829f8cd809bddb5b2b782599876bd617a6ef51bc15d,
            0x05b102397cfb5cc9a282a366881c4dab888225fade21a29101db0abf1f027548,
            0x2d847297fc053527b74a9445f1dbae287b52e6e81094c813d9254e37411a1d2c,
            0x0048a75b1afcca4dbee0634604d49cf0d88c55ac4427d5b20f7cfdc449f9b5e6,
            0x2a0e3e050abdb95ba7886fac1de0f061cd75b0892564a3f83b2afb433dcef822,
            0x1682ed40fe6c09e3c6cb53527b67b96809a9bf72c9ae58edf61a60f165f15c59,
            0x5902f3b0810f961edddd9625ebb0151945374f71de8d1299a3c2b317b6b21713)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 18
        ark(i, q, HashInputs7(0x471641f46a53758fda39af217c2ea5ec97c47a06eeeb42598342bd89d0b7c779,
            0x57284ed295a3c381062cda0133b63f52603ad7e15967140befa2e0a6dca6d8ec,
            0x7242d2b5d16d1df934c18c5fd2e57dbd15021e2723299e0e615b463dbe43638e,
            0x6081210a25060b56baea66d6f2fdfe77b47c1718f3bf3a18dbb0be2b64400fbb,
            0x424cc49dc44fee1ecb8d5aa04599f5b8d9d1dea7a9be928fb59982c2e9aad8ff,
            0x2da0a6240673ed74e3a9369931319bb7cf23aa1950a01371e0b2ccf05473c7e4,
            0x26d623b60da1238d8cc169233f602ba8f4882a3f47d8c8f327d8d638df69f83e)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 19
        ark(i, q, HashInputs7(0x4e2551ebc3c46ef936c53add81bee4ff3c870286355ed5e59ccdcfd10d923f6f,
            0x17d3aac7f3dcf863650a7e7ffdc29a4ce6e04787cb1413d134953e2cb6578b11,
            0x4724b06867536adf40dd813d74255e0b5b59c2be3ccf49bc08f9942f52fa5d82,
            0x6123fd7dd2952be9430b3fae971a683901baa435f4c1c2fcf72444eec15f0fb0,
            0x69857bec902027f9fd4ca4996754ec116244310dc930c5c87c72b66110c22bf1,
            0x1d9ad6fffe012430b5d4d389dcce464557892e2598cac05bd88a0c3ec9b5e4c7,
            0x5829f83d1c83952bdf2a740be9bb234526bde6d848e0da72a4a318fe5b885cb6)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 20
        ark(i, q, HashInputs7(0x23384ece6a6030521f556a30dffed62f283c75b626e48874473fb29d6f87b8ff,
            0x1d9b86a362f4b5a88eacb0ff0831b563950a2875beb2aad0a65907a003de8b77,
            0x3bb9d83a27062e4cb4f90611cf40a31958a91ed921c27764bff2e2738a0cc210,
            0x219323d36522ef8c09c4fc759a43eaa37b891f147dce00275828906b438ee001,
            0x3ad4791f92708e22d3057992d0b8154f6f46394b6e3a1eada2fcf6fa6e6b8105,
            0x48c0d3524230ab3b1078ee21f39ed4bee4d6178808b19d459d0fdb4f90f8c0d9,
            0x6c102236124f0fea0f4b2deab0125637118901c7c8c915cec2673ef843c87030)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 21
        ark(i, q, HashInputs7(0x24162f86467bb131ac05e16f09399e65533079f9e6d97455f6146dac78c30f50,
            0x5cc0bda4958c8326cee0f72f8f6eeb0dbf3012a141fa817d8c490e9ffddc30f7,
            0x3bfdff430980081aea48e20bcfe84d341f11b0ec272d5d7f338e850f09ac1692,
            0x0ae6cd569b5b92211776cb135ff3d5a1da77e152a3c032a7d5097579d4c8b7e1,
            0x66bae6d3fa902affd893f326042019780fec9fc383fb07771e93bf62a997b2fd,
            0x632288f14c075fdd8454aa31481239bc50b7097577d046a4a9c3f9f310c6ff66,
            0x2da19191768d6619e9710a944d7e93e4d05482e314474837280678a9ccae83b8)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 22
        ark(i, q, HashInputs7(0x50d2e8a62c02951032a58002dd1fda40c8a6710e6f1ec6fac1e4da6a2c846614,
            0x738bab261249f890ef73915274f9b8ef545d27eaa74f568c22f6fa53214fb2d0,
            0x32f1ddb637e0e66739eccdc4175aa08c10fe04dd844c8fbd153abe5f5a899bc0,
            0x4737c892aaac50f53c6e62336ea68dc7936551a32291a8cbe779c041a72bfe61,
            0x4322c136f8d1c3efe8d8e1ee5167c5e9b0883f8c4fc1bbcb050f31e593778a9a,
            0x720883a1c930b914299e05e381e5c8e6dbda75244c852b60f1b9de8b04b6c489,
            0x026430e9ff966cb7e8f931f019ea1ac93a35c3339de808d7eed62c4c0ea8c8ad)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 23
        ark(i, q, HashInputs7(0x5677f03c364b029215af3be688c7a04d01be4ec03b9aa62ddeb768cfefe74ac4,
            0x70484733933f49dc74d2bf40047dc817c5eed20c533f09518746d436a4cd14a7,
            0x0906517379e9f0d6146e7902fd07e3741a033df9c8ba6c880e449b40b324fe41,
            0x277c12136a480d67ceb464f22e6bad8a0b3c4d9b0ad03ebb8a97405fd64efd6c,
            0x4ece8b4fe4daa255bdd45ce83b8afd90f39962964967744b0b6e8557acce4ea3,
            0x126c2888e2680372961a558bd6c3ac26fd7b6eec032f19773c49001efb97a435,
            0x4c129648c7525f80a1661b68907e87874e451898c7efb4928b3a960952a4d4ff)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 24
        ark(i, q, HashInputs7(0x6b5c2665910d383f7fa2503dd6145b017ec60a53731d6740f40e19fd908ff0ea,
            0x5f09fb0ce18a2f7f1c6014994559dab6d20ea2227aac15e12b194fdb029e1067,
            0x39277242f5a507a53c802f72aee4ef08ea862885aa0ddce9d76c8b8278a39d03,
            0x389ef3d50e5ef6f4775cd902772098404db63672c617101e5eaaa85a4673c966,
            0x09041ca96e58b528ce7247dbe1f79ccb4638ad47d68fea57dc4dd48bafaa889f,
            0x2667434ad98d81d66c3f6a740fb8d463b253078cf6e1caeae20466daa1ab2b53,
            0x164ad0ef85fa89bd5c995517c1b03369731e0724cdb2c44c596bc14508f3a84a)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 25
        ark(i, q, HashInputs7(0x25d617011017e6a7424f295c80e215000bd77971b9f8b9d3e4b463e6d0a1f14e,
            0x1ea66f5de5cd4882842120b256a5ee2ba58e0a383eee6147d1d0b2273d5b1ba4,
            0x61f1e9f74bcaf2b136f22f0635b774f4b5e71435952caf4c564eade50d9a6a96,
            0x576a751079776b0438f842add7dfb49733ea329161f281eb93e70545925e732e,
            0x381bdb9c642716152e0fe612cc70d4b28783d31867aa739ce59b912bc4e2e105,
            0x71b49b2e551043a2fae4c4c6746fc3a4ea0e3c9d03e39edcff6aa745e29031f7,
            0x6c5dbcc85e14556e7fcb7ee4eaac8e70a27a17d17fbda486d3deec3a9a8e574b)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 26
        ark(i, q, HashInputs7(0x247e8ad917a95f96a7555e502b882c23724b89916a2bc8de066735a30ac82e2e,
            0x5b534444d44ac743ace7dc2612647985534b2db1029951c5762238850a1006d2,
            0x5d3bb071718c51786f5f316490f94122d3ba5d74da101d177717921855e5b293,
            0x463bc5322f3a95f5e147a74d214bba56d5c561eeea74cdd886d3822e5103bcd1,
            0x16069c8d455caefffa356ba8bb963a0c7da20009dce2015128c6149205777d38,
            0x1c66413dfb44862a6016aa0ef585ef3c3c56efcb47b065e351e7f56c511ad176,
            0x6471f9940eb9676eb4e9efc814799aeffb39faa5368563f06166d18842cfa568)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 27
        ark(i, q, HashInputs7(0x2d47f4c85d0ca1f778714a52b9780780502e6297a4ca127323502933e6bc1fb2,
            0x0940212d05fad8e597f558cc9dfa5009ccca21e75958ffb223530912198b8e35,
            0x3e3fcc70caa84f6b44b3e95bc95d46ebc2331294f2100e832469d95fb665e41e,
            0x422337e67be1292deeff00bb7a4928a3fad5de8fc33157b819b592c0a526fdb0,
            0x243436b2dc4dd77e180f2ffc9d9253cd3a3b273cd1884f2b0adebd0301725c26,
            0x2b1df1e78007bd70aab90c167cea453171fb38e43a90aa10af21024ff9bdb182,
            0x4b125e8cd96138dd6a64d65fe18ff1e6a0e0fc2a70fbac55b17748ec4377a9c8)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 28
        ark(i, q, HashInputs7(0x05e413aac4e994be9b4ee1d9729c847cbcc6c2e8354f8453ee705eb4dbdaaa34,
            0x1f5cc2118199ed23e24c97d8f57e8111597c617eb9ce0ff054a56d828727109d,
            0x13942e5e965aa8ba87ded881ed5f820214cebcdd74a5bd1abacef8737e1faa55,
            0x67e72334f4bfda2724495473b4eeaaf6e49eb96386e5c0d57bf4ab148b19ba73,
            0x43d3e576391141011821156f4d2cbe274af0a2d12e29b526b9a9b6092c7a84a6,
            0x49700f6109ae290a0cfa515d2f4a0c534ad9944baaefb4e7174968212f0e5503,
            0x266987167fda16a1b1b653018d53d8fbb622faf4d8a496e9f6e2e228e25bfc7f)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 29
        ark(i, q, HashInputs7(0x32efcbd3af319ecfc897c5f53e3234ab328831531b306367579e6ef4207ef72d,
            0x01b3a74cfeb0ca886aae06551053370d67e69a09286c24e265f7a694395a60f0,
            0x271b25ad2909104df50d07b50714c26a171716f52208356b67ef29ab71796a5a,
            0x24ec439f793857f3ba10a0d277ce7f0b7e39522c1ba52a04c9982ae5b5ceb581,
            0x0ffae1cc4802c2dc3ab35c7dafa0447444375ca4f9293eee944cccf87aaa4500,
            0x03725445a65a242b4ffc1a50fccf712a43cc26c200066ba9f7fabead17de9bac,
            0x305034bf64a7774f73ee82bfff103ae8183781cb5391d15d53e62a1287568584)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 30
        ark(i, q, HashInputs7(0x2e0fdb8434bf8b27dde4c9175cab1896afbf94ffdb4399f5ed1603c3cd3a8d01,
            0x3468188ba0e3d1e4c5763fe4e8e8173a678f450210bf2135f3e173cd380f3326,
            0x31d5b4783cab519a73e3d746f0558551eb18e10e0dbdab75018cf112528bfa86,
            0x6e6027a855a2b951a30af176573b758eb99cea5f48306a4a29d25fc98ce33679,
            0x18b954a2c476055f923f686188db5a2c5b8effa3115b0ec84136e50c1ab50ace,
            0x0f36664018615d3d899cf289439f6ffe6a68753b91d6e1c3a1c0ea80feda789b,
            0x4291b7af8519d6735e4024e9f5e0c9552d391bce7fea967c66369e8eaededb8b)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 31
        ark(i, q, HashInputs7(0x1133a97ce0147baa7279030cdf72cfabd3480d7f7397d0304405626b63dfd277,
            0x18eac7d914bbcaa22b88a71a4ad2b284ad77b74481fad7caf300e9bbddf5b1ad,
            0x3c4fa9dfe2dc8d223f63ac0719b9b3f0dc2456a76c0d6967bffd8798875e8d70,
            0x0aa12c3b5be2ea803f9d8b1968f4d513b1453dd94243e0d76cefc524a8d9cbc1,
            0x4e78909ef51af29cdc006aab0ada613d1d561ef3b61e7f8a4fda1d14c4c9ee69,
            0x733afba56abc39d484014ec10856f3f5c5e8c44fd577a894ee86b3482d30bbc9,
            0x0b3a4288b2dce1314eeef307483542ab4b4d830256d99f06e485a1992fbc8125)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 32
        ark(i, q, HashInputs7(0x6b8cd9b5f77ae8a2d753072aa48e2b30c7e25ae156a95df13d4af8a159a4e9a6,
            0x472c688d783ad018d8c57e540ab56f739e316f4bc5e1c0fddd83c84aaedd61f1,
            0x38e488f1ab2a83c34bc4f92f0fac49891d35dc6bc52e38712942bc75c90fe998,
            0x2660d763eaa03bdfc190b960b4cee1b337f17f63bef4ecb52a543ecb7e588fdd,
            0x4f487cd2071779c36e0e533dc659dcd729a5714d3c0c3177200ac562e8c18d7c,
            0x0b2bfbcdc20b1dae257e39b813f5cb486a7bafbe4ef9470d42c91235eee60ffe,
            0x3bd3416ddca5d36b1f5f9bf41bf64c44e43732dfe2d3b9d8a4f005ae0a200b1a)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 33
        ark(i, q, HashInputs7(0x17b8e455626b12455cacd8039dab1687d2fdac3733993c202f95f037a5cb50cc,
            0x06819b0b1f0dba234a1ecd78ba25b0a9fc8c7bd855980e12b82ecd49e2e74705,
            0x553da43be368e871144bc5f5568a34e5778cb1a01d93996722e77140c44469fa,
            0x2561f16f16f7453dbd4243ee4253ccbed9900baeb2dcb2e20806f7163ded7573,
            0x4539798aab4f069cde910e871e5304a0b12b56b6c6f9a7a0b778a85ba22129ca,
            0x147dc1237e9d511938ed85a734707e6a69f8ab655a2ea3516904e6f8eaed5df3,
            0x04795f16684d7852e2dbca42c5ded4017b4a530659e1bc63828e88a8a0316c0d)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 34
        ark(i, q, HashInputs7(0x4f176ccc383649efbf823b22dbac6d797869db252178eea13cd35107d62d96e9,
            0x56445c21e710ab86f5080f8f7ccb4497733e553a88f7b7cecd124c5a23873c05,
            0x3b2ad888ab9eb9ac57ddf070e27cbdd4050281da80963f92940661d42949cd57,
            0x1e08208685edd6decaff3ab43930c2b1f6f1656f733e76259f4097b3d1305534,
            0x43775a88e86d7914023f0d785b73ae6a7904dde972f99a6e3a2c09537f81fbc1,
            0x35a40ba4e55082a01b8892564333835e36260e0fac24ee8d75c818eaa60a8957,
            0x45b5603e4642a49c138b369afdfba800d00fcf0d5497608c29fafe335a9f8ed7)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 35
        ark(i, q, HashInputs7(0x5e17c675c83d4e4f904bc5e448a36def407d746bd4a3f0fe8abe7a49264cb041,
            0x5cd714e6d75f5905b30d587b2dc138643e0cfb355fcca7644e71335463cb4af3,
            0x1510f3cd3d0b191bd195b730572d41eee97cc6caaa66d1e2b17484c14830872e,
            0x1402e60594751fc143bc1ba2a8145a64f2f76782819fa99efefded7395db7b22,
            0x08dbf356428b8562ae869313864ba8653bd415d4c23d4a9eed9f2c3c2d9506aa,
            0x38bd79b4f7612c9bd0400032b26f151b7c66e6e0d20c10b3a8049e5f15fe8619,
            0x2373e952139425c88e48d2935700beda2ff55c025bad5226a8758d20f23002c5)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 36
        ark(i, q, HashInputs7(0x33e4229671461dd3df6f02c1671482027da40a01fa6519701142123c01f4bfd6,
            0x6c4b36db9238200a4f9d9a23f9b7a74d5bd0194b8a50e55a9147eeb5138b06da,
            0x2607a0fc0b2c2cc350c5ee023ac147c57080c78c8d6a75d5b68feecca74d709a,
            0x10ae3bb1125366994bff9e7d4e80d1afbe9580a1459b436053b49a7d1a1dd4f0,
            0x32d520f12425666a3baa848139703741648ef560988d22e223f71f5c6fd117e2,
            0x5c4dbb46aacd161534b91b634e2344666563342e8e7d67dc6b7c8fdd713cddd3,
            0x65df3056bbe466062e45cb5b54c1fbb6e731cc7925faab3c0f2e914af172b210)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 37
        ark(i, q, HashInputs7(0x3203ec8ac56bea2a827fd6f3e0521984ac328783756536a726fbcaf5dd8b926f,
            0x1df3c6f618ae43ffc5473dfa7d5314bbc83990c46f4c2c50f7aa718e8cad2653,
            0x13134104fb5e5b4b5b6fbea52d180890663650a8cfb9df7ca089bc81babc0845,
            0x278b391878d3a4c1aa6aa8fe02f6c149d7c1f2ecd8e959545d54a7941a446736,
            0x46bfbf35f2ac5afeb7b43e76f992ab7a80384496826f140e7e9926505886f6a1,
            0x42137fdfe38cca1f71e66da5e06f3c934b00b0da7af2fa7d637a332a4d5cc0ce,
            0x6df74b0235c9254cf8337f526d4ff6dd9add3d312b5051eee9e3793630e5e67f)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 38
        ark(i, q, HashInputs7(0x41ff0cadd53c66119c47381e1789e8e3b7696cc4870c23f37ee8858ef94295b4,
            0x64d2780e4c096d34456a357a095e536905325ae5a95dbf5fcd1fbd28d40674a1,
            0x3d4a480b53e0b110e103045250f7a0ee5e9838c082ce9b95b1482ae31f3c5bdc,
            0x1691f60babb47495f8fab641a6d2660990e844a5d66567eb38ac6dd3bb23386b,
            0x099b0936c963c7df5ef41929c1fa4b9bbcbf047ecd7ec46caaebb93850ce988f,
            0x0aad64d0eb2663bc886a775a4abd3e499a4e889b73f931f16bd55db103ec1ba8,
            0x60d75f54018067ee8f5a7cb567db8365fd96ae9fb16cea575c82e7b2ea6551ff)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 39
        ark(i, q, HashInputs7(0x6ca9a91700deab4747151013aebceff1b3fe1836669a8c6d309b3d5ce8150ed2,
            0x1a62bb45a8ed648bda2ec6a7fe64149c096d304f712289ce6fcf64ae9597f640,
            0x03d7e7ed4d96893da19f89ebf330a141a4001359e21c4dad87bb054f61a6f9bb,
            0x05194efdecacbb1663c681e61323eccc2ef7b90b77fd9f4f5d2fb2622cc4864d,
            0x2379e4f4303551e212267b4021cdc882807ad522cf0419c2365f17ee69ea345e,
            0x5193972b7afb2e542e2ba5c56025db372d62f5a30c684616f8149a9292e71231,
            0x14faa02d9f9d6f80922e387d90c7fe85b94576193ac888f383768ff835503a80)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 40
        ark(i, q, HashInputs7(0x403fc5582095aedb1922b32a2b211f6708c97506c0c0bee53e7646eef9d4890e,
            0x2a59726d0a4c549cba98cb4b1333934983e2934d584de40c90d40be823857f0f,
            0x38e5ee841579c144be1b02d7a1dd739fa25c994697065ed56a536cf076c39746,
            0x2c98118dfe93a0d0f63a4e3a4ae44372a02d241ef74b79d1fd84fe61e7742d38,
            0x63cf3a5c8aa0de582da4e11ceae7c239cd6b3fe15e0832faf4e9409cd7ed5eb0,
            0x54ee34666dc6b5f4acdd6b9db71c17487b363693d6a2f1c1ad52211ab813c513,
            0x483fe846438543bd744f4b75402c9df3c8907c0ebe86330a0cad0fd21aeebadd)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 41
        ark(i, q, HashInputs7(0x3cff1c4ff79f805f0efe1df7022512f4521d7240f66a32631d81576fb0a9f339,
            0x4fb7396d787cf97d2c5df0d8d02ad228e439fd72fe34aedad7ec85801dda93ba,
            0x0276b6d0fa51a795d3bb54126167e4b5b5a31c1c44ce422a57b54a3eda8c8392,
            0x168846aa4843002cba50960fda0079b968f9480199850b877b26c204bf7bdd79,
            0x4daefea9762ba07a1b4bef527b9c1d4746e19f325e265649c5be54035292c788,
            0x5a970fdce1aac9c862e28646a9f23b84863744eeadbedd258e51f591c8d97609,
            0x2fb65df0bc4b9fb014a3e8703d04ce4fda2002963635d0c24d88b086a74e0195)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 42
        ark(i, q, HashInputs7(0x1ea0e0e679e07e344dc7ebd84852ba39f5857f9a93c3d85f44b1df5ef752d9af,
            0x27f5513c7cb905c6ef1eeb7b6f71e0bb40804770ee463777909f59c0b8b8e0b1,
            0x5f0dc0e8bbc2c771e375969734c38baa959a57e2d42a1324f5b4eaa807ad4683,
            0x2bf884753091ada946ba1a1064edfd8a10c6b6aa394f5948737abfe2c55204e3,
            0x688adea42217d3ecc72b1f39428d3865670ae447824a5ecf5f9dbd33e38c9cbb,
            0x5a02e8d49ce771b0f98386bf16dbc127c3abd597abe9c05075d618cb2e11ae8c,
            0x102e211784fd1dd0f208ed044d7b69b406de12693f4d4c23785b466fee2fed98)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 43
        ark(i, q, HashInputs7(0x09e0a6cb5d36677b75525674b042e1ca134876c7e087f6cadc62049fe0cf9a8f,
            0x55dcf286f7564cc93e4887e363e25bac9200e61e26d28f2487857303fd918f7d,
            0x65fae0a59420b4af88faed58ce768aad4d0c55a374c14355128d59289ff54f13,
            0x070401dc0b422f297a123a8e7a8492d93a9ed2a7976db3b666a8d0a6df65aadc,
            0x495bd6ee6854d1ce2ec76dc61e7ad1834ec57432c0bb90269fcbe7a169ef0259,
            0x203af1fc985574cdb77972bd8568f7f7bb6fe7d3f3281af225ce517d624a140f,
            0x1955884b8ce08fe86a9651154c36126a871ccc53380b729c82fad2943bfde947)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 44
        ark(i, q, HashInputs7(0x2ea6759cb89c578c75e6eb9f449cd9a4664ac0eacfcfb2277f3c1022c792f15d,
            0x4226608339a4789befbe9412ba87e6e2cdbc4ffd0563ddd3bc726bae53434823,
            0x2ce8bdc5629c66cea588edfeb311f31722c6fb8353691a9cbd19cdc539aedf24,
            0x08aeb39f6de29749712c45f89cc33d18030cbea2d3e9660df68019d0d6026576,
            0x3026a8278f4c5c7158e0046f4bb7c3b70634b4d1c4cad057e6200059942b4b4e,
            0x541a61f9bbe21a13a1d2924aea5a634c689c67b01ac655ec7d91f386df133c31,
            0x11797e86bd7611d8eed38725a35c2ac5ed2deef9cd4966050063b01a53108dd3)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 45
        ark(i, q, HashInputs7(0x07cdeacaec4689aa70f9915e245f1478be0e92f2af997c79e82b55f145d9659e,
            0x41061b5bdb1e1b889c5523730d0d429d7bfed8611520eb0fd12b6b4defed80d2,
            0x03dace0d7a11331d690793df62243112ec18557c5d6d29573b02ebbfc50109d0,
            0x3a2e50a9e331660b9cf611edecba5da887d8d80eae37798002a19a29ec8dd9d8,
            0x58c3e2bff0119246a49604aee453bc87ea42a08f81615c77071a824441e9c0c2,
            0x3bd88753a841d4932637a17d70a45a0d6dca427291e667be73cbfb0e87c60d05,
            0x52d009831d3108e9efae89dc8cdfb91ac0f052070367783ed5bae785fab84846)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 46
        ark(i, q, HashInputs7(0x245f1b4455f6525bc6bcd578d4095bd0b305c34c1aad1133dc3b1c6172eec5bf,
            0x4233a6b02f5d94cc97815a52a3d0ea747306cf299198cb0dc421db424ea2b8cb,
            0x31e1a6ebd0bbaa21570bfe4cf82b8789d467eca1a377148249c6789eb64455bc,
            0x25ca1f027d054885735687846e22c9059ca376141b01521e5eae4731fa565596,
            0x6d5eeabfd76ce082320d6d614964c3b6071e451bb167abda7c7fe3f0f975bbda,
            0x250e148754e4d1e4fa8ea5a850d7a090d058d7cde0e498ec3bf03cab50c159ca,
            0x4cdbe4228909fe669a881ac13c43b6a50279410618b82b171ae4ad31f312ea3a)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 47
        ark(i, q, HashInputs7(0x6c3880d5454dc45fb3dc9570f76738fc57d9cec0ced317e6af55ef7869738ab5,
            0x04280634dece536517a6142af13319b2b3772e67995b635a8bd68cc1d8e8c648,
            0x1974dc8930e3abaf4cd349e21e5b098620e4dca68e47c93f0ff844f5b5313314,
            0x25fd525524232c22955d3ac72c83c01d5dca04eb89b709a86acfe3cd771a8cc8,
            0x1f6b961ade4451fcfd0933c001c23d4bc3d8f8a0d7884652b927c95e4e29a90d,
            0x3ac405adf7d501ee97f03aa9ee6e857c538bc9b13848986db0bc9a5b4a129fe9,
            0x1f0c343d0ad768660f15b6e36037f07e172f721bb31d2b100f439bfb5655ac39)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 48
        ark(i, q, HashInputs7(0x0fd4203bde0f497d62bdbff60162bfd6aa54d8d9f2d1ffefb910e2a2b7bd3779,
            0x690aa945e5c2fb9cdde7421ba90ca364adc6ca5d4addc5bf24d30b7ca3a0e447,
            0x105fb8bd09e0bf1c2ca517cd49b29518bbc5d1d654ff8c272e2944065d828a81,
            0x5e88a11449d1c1758c8229faf23e613d7aff6fdfaa133d497e1a4716a50e7803,
            0x62cf514194b8ab766a361a51e7f1ec0329c22aa86fa81f532d12e43dbd0cc05c,
            0x19a8e067ecee42bc327626174ec63658c6cf6b9160f0977ee92785b83449875f,
            0x204d7764d845d063950369827f2b0d8963371c046734b13af0efc5217c092b86)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 49
        ark(i, q, HashInputs7(0x6fbf43c21decfce768798ff4b9dfd4c1a49910576ed9fb3aca11ca7ce3de6d5c,
            0x4c849e351ca26c426bdd4b55f2d836b5717738b4203afacb67041795e11325d0,
            0x223cbd18d5e0b818b55200d8de589b5da613d935969c2accda19cc4df79b16d7,
            0x4653af954db3a0d21570e3695acfa5dd7ab25b763d94b1fec81520a0d64aeb3a,
            0x5b2dd83c3c990ab9128412ad4cb1936396dd80b7ed7751d3cde5160fa232b00d,
            0x0476a11246206c9d8db736b3a00050a6f73295c95c84a12ab2e96120be5c6df6,
            0x251af768ee42fa73f32038855fcd2f3f51994f0a961a3668b41cbbb2afe4543a)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 50
        ark(i, q, HashInputs7(0x37c617f18fcb64b807ac92a21a93645b77b32cfa66754032442178e8c092d2f0,
            0x082a550530e6f8223538c547a5134d8162a6a00c7dd3f5d6ee677f5562cf5469,
            0x72f69fa8b5a489fea378b885d0267d32b66fd7e15e8aad166841a7cf1feae6cc,
            0x11b660b465ac5d4472660dfc701a30e459ee518fcd4a616fd408ec3b2ec551f1,
            0x23b891d7779732d55fe290a3653615c03d3afbf877e8519ca8f9aedd5842b49a,
            0x1c8040c971f9d0991bc3fabfadc4056dd626ce5775ebbb0c9045897d272f4d36,
            0x06f475d3ae3d8d35f4411f4d4f6a03c9022c063f1fbb6762b85b21954e4995a0)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 51
        ark(i, q, HashInputs7(0x119e92d6f916fde7ea8eddc5617011f5f5d52928c48ded9bb9912f0bdb0f892f,
            0x65718a5a9708f19107a334d01c130c3941862c21373ae9c8e20c39b64d6e3bc5,
            0x1776af4c4f708eb38c64a16a4e104223973ee87e3ec80e5733557a35adebf17d,
            0x0296f594740cc08066b2fcfe5a832ea80ac19b74fd483b69d5df84d3a20cc199,
            0x0a40bfeb9ba8e05decb746e8111dad7d4ef1ac89741f332fb53d88f9c4f60bf1,
            0x713f1f707fa568d4d96441abe56959cb96986123a65138b65fc96679a423634c,
            0x418492bac4678705d78532bea0e2cda896fb2dfa5dd08e06c71ca65d0e63e936)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 52
        ark(i, q, HashInputs7(0x47a2be0a6483bf95fc1ce9b4522615408f8ae73094a4e4c6313fbf5fc26c530e,
            0x03b625049dcdf1fd5b772224a8fec9b9133431a289431319c061b6dcebb7f6cc,
            0x3feffae0c04ad0374564d3d2f8f086f0e4fb59eef79fec5a6647a9098f14d785,
            0x1f407d42e0e53b4a42b434517078de6bd4d9ca24a43597a840411663eceb273a,
            0x0cd8c856944f4745a3a384f5989ca13fe44baa20f903338f093a542c34affc2d,
            0x4d1bd63559712f0663895aadcb6d714338e0b23e6cb4122b7ecb5e858c4474d5,
            0x2c18b0b162e52692aba01c74b1acd71c3665f8160c8909cd00fd367e8559ab1d)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 53
        ark(i, q, HashInputs7(0x467372a04798061df27b47df8971284109764af1c12a3f403f04ca193856e253,
            0x5ae577e1d8b49119abd401612635214aefee70ee20cfc3de3895c8ba784d77e4,
            0x136316522c0031890b508350645d534117ac5ff4888ed8c30478cc17de871219,
            0x607a023ae62de7271b3f0fbd899c2aba2d3782af90300709a0cde06c5ffecafe,
            0x1dee7f28716363c5c947a6d265f2abe17d22d249cd08185a86f6435de5908fd6,
            0x4377071bf532afe790d3e10b05161fcd7093627a599b5c829667d252075c5175,
            0x52671366dc2a21a4f0743be38e4e15f5e9723a1b8965f1f243165e4424c02567)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 54
        ark(i, q, HashInputs7(0x6a7c8e39869ee3fac9bfebc906fa622eeab1c92606c0c62f0ba3c21309061d6f,
            0x5e7705d048042cac6e705c7ea50fa88019ebfc539f15d8862784bad6c85dd992,
            0x2fa7961fc3b9a524c14e70d45a5f1d917a2cde0b302a0d26b5c7bc825f51f948,
            0x737aea0ff517614c68c8a8b946e4162f64514b36e4f2a8b66332a68565e26e8f,
            0x2b08c5e52d90dbfde161460d15a8292310e846c682496e946fd2a23a702692b4,
            0x131cf25c511d0818038e212c761e2f7f2d7d90421e774bbb5e7a35b2f7e55700,
            0x09dce0916c287206eb92777de299477fb61c2ecc125885c4a7ecabe76a6d6358)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 55
        ark(i, q, HashInputs7(0x5d6d65e7bb418051d961d7d656ac03c58a06ce1aef3342c38545aa503852bcc9,
            0x358537b1a42227d94d9ccfa84e2ae8e31698de3d842a9bee3fd9f262372a6e5d,
            0x50c0262e42b86736edd53eda412a278ca74afe580f53468fe24bca4fcf58f09c,
            0x28a93f410275b5c972b63f3fffc637c848c75da7001fc5d81397ecf1296aee26,
            0x580e98332eb8d9010ab503de63e8af1cf821b2b61c0ffb98269876f2219b0d2a,
            0x2a0a39068eb60c3dd9ac91231c1acdd292526c3ee166ef53937c96c944879154,
            0x07a589a249c960b4b275766587ffc271b00212f5aca1e499b6782a83659e1ace)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 56
        ark(i, q, HashInputs7(0x11eed4829655f2af812138b0417a2c171dcc3d63479b9250cc73aad5faa7110c,
            0x73ce403bc1aaebe18d7832617d01bad005558fb9159e151a6b1cd1ab0b4ee748,
            0x2ff042dc4e9c742bacd2efd917a9cc807da2756b8caa6546fc54986c6f313a8d,
            0x41dbb2f0fa5e4673824a0cbe2993907f8760c2160c6eeefa6980b454b514e06c,
            0x381e7bef1e33205208cedc6f08402644ed7bd072d11989c6f27ef1e05c76bd20,
            0x44ce1db88d77539868ca842515d6f2b7ad3aece451aa4b1a38c873fe23ac28b0,
            0x315de80b08fc5e1c7075ab053c321eb7f880ef5176cf07064f171036e1608d38)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 57
        ark(i, q, HashInputs7(0x7063a086377493e90186b5e1411980b10bce4524a18e3b332688268c7e397c7a,
            0x4d4886813d9429d60c9292e3421ce141ab5cbc1b380a5d33b1a9bdf13f9095de,
            0x109ae0064f76789ca263a526814d2e0815c718f605af419a7cdbe1cd1deaefc3,
            0x3847b16d4eee4bbbd12260e6af01ec7bddead5bbe197281190c1264a6cc871bf,
            0x7388eb232ec810aaf72845836b31e99e7cb385ab3c783bc320b576650ef30e01,
            0x0950a9ef5e746d95df9bde1e163ded4883f2acc4b113e86b6836e0d79d33b42e,
            0x3c5b15c249928b590365bc377066d61a09bf59e549ab6f749bd4ad1591a57a19)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 58
        ark(i, q, HashInputs7(0x1dff7850d3769051fb76c7498f5e5ea05ca1ba4942167bb4df6832f174990076,
            0x47976ad1736d63051a20d6d696a0e588a5aab7becb366fd3cb482a23af091265,
            0x60d90dc9f8ac60e6d3e7a8fe208f456bf6fdcd27fa82d95d5dcaccf3775fa777,
            0x5bc168cbbb7694b13c2b49d7412ff8944184f70a5dec2624641ae62c0eeec612,
            0x023c927ae7bfe29b9cd7ba60c9bdd316e1e993a1aef63539d717b826aee15236,
            0x595adb8dca8d61b3e1d659254335ab80b748f85342daa235c87b7708aab30684,
            0x2e63e80e5bbc625d0b2713a1c659429ae01407ac220d47799bc54cb3996fff2c)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 59
        ark(i, q, HashInputs7(0x4b7c3f86c73e759e6c179f0b799c1287b14917aa0a4788a4b6c748da9bd1d425,
            0x5b03e0850587657ae3409fe74005cfe99fd116fbb86ed664e04bcea745dbea20,
            0x30c8545a8205cbd37fb269e8c49504ea0f8ec3f64b3ab8fe42e04a256460aef3,
            0x19de576070d2ddd2db484615bd58f7dfffee0ceb26c386fe131c53ef6de37e7b,
            0x3b34356e137a90cc59f0e4f878bc8159861c0d3d35745425e60ccd89ec4fd630,
            0x193a50e0a2c350c403c5b597f1d2c0f702155992023fbb3e8403f22084523db0,
            0x5026dac922fc45af8441f81b1e01e13177f1a12f7ae34cdedd903cf3b2afe18f)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 60
        ark(i, q, HashInputs7(0x22f8eb063c3238b722b0b2239b533bd8263b3925bc05f9f534c4cd3193d31b19,
            0x6451df705ebf0b37a26af65dc56c2ec7c3a2afd1680815ed8a1462122d9bb8eb,
            0x44dc765e40e4658ea9a5ca780789f3bb2960ebc8fd3d1fcd8804b330e424855d,
            0x09aa2a1d200a007982dc353103c7a1a2603aa0e7522f3f63dcec13f1b9c4befb,
            0x571451e6d14cffe4bd2b2ba8521dc7a2c5ad5ee93c4faed440193e42d4f919b1,
            0x0ef3541925a1a36c995ba702eaf03a0ac20ccb4a19d2d3ffa28564e16ad8287b,
            0x5f1e52fac92d7903dc83e291d2657d07dc3a7909ad32a9d2aa29bfcbca7b5f80)
        );
        sbox_full(i, q);
        mix(i, q);
        // round 61
        ark(i, q, HashInputs7(0x1383ff6676df1a17400590010414d4efbb719b06acbfe313f299775071a145b8,
            0x72f22b185cc08efc00cdb383ac9a3c81aaa5257e0286bf38be8fd179d0e4abfe,
            0x169a636b8c6ab9029aa6f56c4c56b7fad65b1b6b831244f1edc1bf7e6c80a28b,
            0x0e6eeaf2ffa7a836844e7dd9b43bef05831df69b31afe9043f25d8d9b22e7c6e,
            0x7300ac85c1c724276ebf1ba50e045408f0fb6a5d8e93ca1e0eab80336e10023e,
            0x2912063854bc6060a9e52507bf352eb22015b8fdbc040e2121cfb0af93a0c838,
            0x2aed68fb0cd77172905625bb55c853c359905946e0e92fdea3fe0bd2c956a220)
        );
        sbox_full(i, q);
        mix(i, q);
        // round 62
        ark(i, q, HashInputs7(0x1391038e2d8f9873de0c00973ab3a18400d8035bb89ca1c6d22b478d285e05a2,
            0x08441441373332575a4813185ec90cedcd8cc10b784700aa1a5ab33beac49aed,
            0x15faac299aeeffc1e8b2a08e41921c9ba332ceb46b916e65c8ad7993494781ef,
            0x3a37e82fadd5179855bbe4c4d30da12c7704298ce16014c8d77d7fbb6dc86ddf,
            0x65baa223e5c310f1bee707c1c2f20707e7e88235d104f270de15a3b078646e1d,
            0x7024f21d597b7f4d8a9da536ee6e8ca1f85ce560e12afc66cbc4af7f38a55493,
            0x3233b77459deb56229d9a2ccc4f89830f75037d68bb0ae851b890b2e96785301)
        );
        sbox_full(i, q);
        mix(i, q);
        // round 63
        ark(i, q, HashInputs7(0x6ac1bb81c105b2f9ef1d82ca4116b3021fe23f890b5a3243255ccfc779ea9c7c,
            0x39661628909ad370900218489f94998f6e1a42fc333a3ec398623130178ace64,
            0x050b292ff4cd04ed85951ef4c5b3975f32fc64f227c6f10a505b44bc87d8a54e,
            0x5b8ded68b5f14f9c165b21995e1b05b886934122d1f80a9abdbe8caec13d0f2a,
            0x6b7fa371c3ce3501e920cee9b0097297081368d59ca53aaa4c8e881cc4a4c508,
            0x67e56fa92dc682a1bf0f200927d654b736979e839ff37a7366c414bd606457ff,
            0x01a7f67a18ed57241d2b6202db1f222739f2c4b203f86fe0f1aa29d2338d3f38)
        );
        sbox_full(i, q);
        mix(i, q);

        return i.t1;
    }
}
