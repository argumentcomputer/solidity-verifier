pragma solidity ^0.8.0;

// This contract is for testing purposes
library PoseidonU24
{
    struct HashInputs25
    {
        uint t0;
        uint t1;
        uint t2;
        uint t3;
        uint t4;
        uint t5;
        uint t6;
        uint t7;
        uint t8;
        uint t9;
        uint t10;
        uint t11;
        uint t12;
        uint t13;
        uint t14;
        uint t15;
        uint t16;
        uint t17;
        uint t18;
        uint t19;
        uint t20;
        uint t21;
        uint t22;
        uint t23;
        uint t24;
    }

    function mix(HashInputs25 memory i, uint q) internal pure
    {
        HashInputs25 memory o;

        o.t0 = 0;
        o.t0 = addmod(o.t0, mulmod(i.t0, 0x6aa770fa96ed0cdc062af9f2ea24419e803dd454ae12f879f5c28f5b3d70a3d8, q), q);
        o.t0 = addmod(o.t0, mulmod(i.t1, 0x310bee2d07c2a14fc6e73ddc04133ddade81769ecec43a9d1d89d89d1d89d89e, q), q);
        o.t0 = addmod(o.t0, mulmod(i.t2, 0x0896583f0c9068184fa5784c727dc426520e0c2625ecea5ebda12f6838e38e39, q), q);
        o.t0 = addmod(o.t0, mulmod(i.t3, 0x5f3a1296990a8256bc5d3a98e3573a96a95bc6b95247cb9176db6db60924924a, q), q);
        o.t0 = addmod(o.t0, mulmod(i.t4, 0x6beeeb3bc5a44881038e2168963594284523521472c0aded69ee5845b08d3dcc, q), q);
        o.t0 = addmod(o.t0, mulmod(i.t5, 0x58e0de26287035620523d04a6dc8e1596ade30f13bba79baf7777776b3333334, q), q);
        o.t0 = addmod(o.t0, mulmod(i.t6, 0x21a817cdd2467f35fe5b1dafc0bb5fbf7b689af89ce6bfdead6b5ad66b5ad6b6, q), q);
        o.t0 = addmod(o.t0, mulmod(i.t7, 0x704e3a189050915df1a00947c954c945291fb6e2e7fe691f07ffffff08000001, q), q);
        o.t0 = addmod(o.t0, mulmod(i.t8, 0x706a54adbbbf813e4130555d209cf08149721367c1eee4d83e0f83e000000001, q), q);
        o.t0 = addmod(o.t0, mulmod(i.t9, 0x479a50c26c86eb7f6aef056e604d5fc70e133fa77ffefc95f8787877da5a5a5b, q), q);
        o.t0 = addmod(o.t0, mulmod(i.t10, 0x4c2e7545473b9b7896b0fbad82ac2edeede305610e9fd60df8af8af807507508, q), q);
        o.t0 = addmod(o.t0, mulmod(i.t11, 0x236c2c0413d3ad64488a903b5846c91e1279f21d5c7146c6ce38e38deaaaaaab, q), q);
        o.t0 = addmod(o.t0, mulmod(i.t12, 0x12cc97ac9ef6f1b8ae5c6838a79db453e410ea29ffffbbe42983759ef914c1bb, q), q);
        o.t0 = addmod(o.t0, mulmod(i.t13, 0x70e0a9a88d929bab5a4c883db8895fcf4accdc53c35cb7e41435e50c80000001, q), q);
        o.t0 = addmod(o.t0, mulmod(i.t14, 0x20b29ec8afd716352f44d3e802b77e91e9aba469df2d7c68be5be5be13b13b14, q), q);
        o.t0 = addmod(o.t0, mulmod(i.t15, 0x42a8a69c9e54280983dadc37d256a9031026a4b4eccbdb4c3999999906666667, q), q);
        o.t0 = addmod(o.t0, mulmod(i.t16, 0x087b891f0f8866d354eb41c2262b0fce7046123ea895bbcdf9c18f9c063e7064, q), q);
        o.t0 = addmod(o.t0, mulmod(i.t17, 0x3f7c0c646607018f283e2710978f7c6470e7d9d0e1853260f9e79e795b6db6dc, q), q);
        o.t0 = addmod(o.t0, mulmod(i.t18, 0x3e021802ced14302e5d18b5d99fd43eb0912163d23b7ae3affffffff7711dc48, q), q);
        o.t0 = addmod(o.t0, mulmod(i.t19, 0x714b295717370040bdb2b607dade2a624c04f78e9172c2a1ee8ba2e7c0000001, q), q);
        o.t0 = addmod(o.t0, mulmod(i.t20, 0x61e5213528d4a2aebf2b28344c6688e80dd3574c7d266fd1a4fa4fa422222223, q), q);
        o.t0 = addmod(o.t0, mulmod(i.t21, 0x6c5e278af4d06f8bd6d77676d15a1247c32624721bd1f1d28b21642b9642c85a, q), q);
        o.t0 = addmod(o.t0, mulmod(i.t22, 0x0766517d23564ece23f35a0b681aabbefa739815fa8d8326105726209df51b3c, q), q);
        o.t0 = addmod(o.t0, mulmod(i.t23, 0x71835e816e14e0015cd34e32896e78da8ca9b0984553ba145aaaaaa9b0000001, q), q);
        o.t0 = addmod(o.t0, mulmod(i.t24, 0x5789a824ac7c25219ed8161084a93aa0c1d857462f03fc52d6343eb0e0a72f06, q), q);

        o.t1 = 0;
        o.t1 = addmod(o.t1, mulmod(i.t0, 0x310bee2d07c2a14fc6e73ddc04133ddade81769ecec43a9d1d89d89d1d89d89e, q), q);
        o.t1 = addmod(o.t1, mulmod(i.t1, 0x0896583f0c9068184fa5784c727dc426520e0c2625ecea5ebda12f6838e38e39, q), q);
        o.t1 = addmod(o.t1, mulmod(i.t2, 0x5f3a1296990a8256bc5d3a98e3573a96a95bc6b95247cb9176db6db60924924a, q), q);
        o.t1 = addmod(o.t1, mulmod(i.t3, 0x6beeeb3bc5a44881038e2168963594284523521472c0aded69ee5845b08d3dcc, q), q);
        o.t1 = addmod(o.t1, mulmod(i.t4, 0x58e0de26287035620523d04a6dc8e1596ade30f13bba79baf7777776b3333334, q), q);
        o.t1 = addmod(o.t1, mulmod(i.t5, 0x21a817cdd2467f35fe5b1dafc0bb5fbf7b689af89ce6bfdead6b5ad66b5ad6b6, q), q);
        o.t1 = addmod(o.t1, mulmod(i.t6, 0x704e3a189050915df1a00947c954c945291fb6e2e7fe691f07ffffff08000001, q), q);
        o.t1 = addmod(o.t1, mulmod(i.t7, 0x706a54adbbbf813e4130555d209cf08149721367c1eee4d83e0f83e000000001, q), q);
        o.t1 = addmod(o.t1, mulmod(i.t8, 0x479a50c26c86eb7f6aef056e604d5fc70e133fa77ffefc95f8787877da5a5a5b, q), q);
        o.t1 = addmod(o.t1, mulmod(i.t9, 0x4c2e7545473b9b7896b0fbad82ac2edeede305610e9fd60df8af8af807507508, q), q);
        o.t1 = addmod(o.t1, mulmod(i.t10, 0x236c2c0413d3ad64488a903b5846c91e1279f21d5c7146c6ce38e38deaaaaaab, q), q);
        o.t1 = addmod(o.t1, mulmod(i.t11, 0x12cc97ac9ef6f1b8ae5c6838a79db453e410ea29ffffbbe42983759ef914c1bb, q), q);
        o.t1 = addmod(o.t1, mulmod(i.t12, 0x70e0a9a88d929bab5a4c883db8895fcf4accdc53c35cb7e41435e50c80000001, q), q);
        o.t1 = addmod(o.t1, mulmod(i.t13, 0x20b29ec8afd716352f44d3e802b77e91e9aba469df2d7c68be5be5be13b13b14, q), q);
        o.t1 = addmod(o.t1, mulmod(i.t14, 0x42a8a69c9e54280983dadc37d256a9031026a4b4eccbdb4c3999999906666667, q), q);
        o.t1 = addmod(o.t1, mulmod(i.t15, 0x087b891f0f8866d354eb41c2262b0fce7046123ea895bbcdf9c18f9c063e7064, q), q);
        o.t1 = addmod(o.t1, mulmod(i.t16, 0x3f7c0c646607018f283e2710978f7c6470e7d9d0e1853260f9e79e795b6db6dc, q), q);
        o.t1 = addmod(o.t1, mulmod(i.t17, 0x3e021802ced14302e5d18b5d99fd43eb0912163d23b7ae3affffffff7711dc48, q), q);
        o.t1 = addmod(o.t1, mulmod(i.t18, 0x714b295717370040bdb2b607dade2a624c04f78e9172c2a1ee8ba2e7c0000001, q), q);
        o.t1 = addmod(o.t1, mulmod(i.t19, 0x61e5213528d4a2aebf2b28344c6688e80dd3574c7d266fd1a4fa4fa422222223, q), q);
        o.t1 = addmod(o.t1, mulmod(i.t20, 0x6c5e278af4d06f8bd6d77676d15a1247c32624721bd1f1d28b21642b9642c85a, q), q);
        o.t1 = addmod(o.t1, mulmod(i.t21, 0x0766517d23564ece23f35a0b681aabbefa739815fa8d8326105726209df51b3c, q), q);
        o.t1 = addmod(o.t1, mulmod(i.t22, 0x71835e816e14e0015cd34e32896e78da8ca9b0984553ba145aaaaaa9b0000001, q), q);
        o.t1 = addmod(o.t1, mulmod(i.t23, 0x5789a824ac7c25219ed8161084a93aa0c1d857462f03fc52d6343eb0e0a72f06, q), q);
        o.t1 = addmod(o.t1, mulmod(i.t24, 0x3553b87d4b76866e03157cf9751220cf401eea2a57097c3cfae147ad9eb851ec, q), q);

        o.t2 = 0;
        o.t2 = addmod(o.t2, mulmod(i.t0, 0x0896583f0c9068184fa5784c727dc426520e0c2625ecea5ebda12f6838e38e39, q), q);
        o.t2 = addmod(o.t2, mulmod(i.t1, 0x5f3a1296990a8256bc5d3a98e3573a96a95bc6b95247cb9176db6db60924924a, q), q);
        o.t2 = addmod(o.t2, mulmod(i.t2, 0x6beeeb3bc5a44881038e2168963594284523521472c0aded69ee5845b08d3dcc, q), q);
        o.t2 = addmod(o.t2, mulmod(i.t3, 0x58e0de26287035620523d04a6dc8e1596ade30f13bba79baf7777776b3333334, q), q);
        o.t2 = addmod(o.t2, mulmod(i.t4, 0x21a817cdd2467f35fe5b1dafc0bb5fbf7b689af89ce6bfdead6b5ad66b5ad6b6, q), q);
        o.t2 = addmod(o.t2, mulmod(i.t5, 0x704e3a189050915df1a00947c954c945291fb6e2e7fe691f07ffffff08000001, q), q);
        o.t2 = addmod(o.t2, mulmod(i.t6, 0x706a54adbbbf813e4130555d209cf08149721367c1eee4d83e0f83e000000001, q), q);
        o.t2 = addmod(o.t2, mulmod(i.t7, 0x479a50c26c86eb7f6aef056e604d5fc70e133fa77ffefc95f8787877da5a5a5b, q), q);
        o.t2 = addmod(o.t2, mulmod(i.t8, 0x4c2e7545473b9b7896b0fbad82ac2edeede305610e9fd60df8af8af807507508, q), q);
        o.t2 = addmod(o.t2, mulmod(i.t9, 0x236c2c0413d3ad64488a903b5846c91e1279f21d5c7146c6ce38e38deaaaaaab, q), q);
        o.t2 = addmod(o.t2, mulmod(i.t10, 0x12cc97ac9ef6f1b8ae5c6838a79db453e410ea29ffffbbe42983759ef914c1bb, q), q);
        o.t2 = addmod(o.t2, mulmod(i.t11, 0x70e0a9a88d929bab5a4c883db8895fcf4accdc53c35cb7e41435e50c80000001, q), q);
        o.t2 = addmod(o.t2, mulmod(i.t12, 0x20b29ec8afd716352f44d3e802b77e91e9aba469df2d7c68be5be5be13b13b14, q), q);
        o.t2 = addmod(o.t2, mulmod(i.t13, 0x42a8a69c9e54280983dadc37d256a9031026a4b4eccbdb4c3999999906666667, q), q);
        o.t2 = addmod(o.t2, mulmod(i.t14, 0x087b891f0f8866d354eb41c2262b0fce7046123ea895bbcdf9c18f9c063e7064, q), q);
        o.t2 = addmod(o.t2, mulmod(i.t15, 0x3f7c0c646607018f283e2710978f7c6470e7d9d0e1853260f9e79e795b6db6dc, q), q);
        o.t2 = addmod(o.t2, mulmod(i.t16, 0x3e021802ced14302e5d18b5d99fd43eb0912163d23b7ae3affffffff7711dc48, q), q);
        o.t2 = addmod(o.t2, mulmod(i.t17, 0x714b295717370040bdb2b607dade2a624c04f78e9172c2a1ee8ba2e7c0000001, q), q);
        o.t2 = addmod(o.t2, mulmod(i.t18, 0x61e5213528d4a2aebf2b28344c6688e80dd3574c7d266fd1a4fa4fa422222223, q), q);
        o.t2 = addmod(o.t2, mulmod(i.t19, 0x6c5e278af4d06f8bd6d77676d15a1247c32624721bd1f1d28b21642b9642c85a, q), q);
        o.t2 = addmod(o.t2, mulmod(i.t20, 0x0766517d23564ece23f35a0b681aabbefa739815fa8d8326105726209df51b3c, q), q);
        o.t2 = addmod(o.t2, mulmod(i.t21, 0x71835e816e14e0015cd34e32896e78da8ca9b0984553ba145aaaaaa9b0000001, q), q);
        o.t2 = addmod(o.t2, mulmod(i.t22, 0x5789a824ac7c25219ed8161084a93aa0c1d857462f03fc52d6343eb0e0a72f06, q), q);
        o.t2 = addmod(o.t2, mulmod(i.t23, 0x3553b87d4b76866e03157cf9751220cf401eea2a57097c3cfae147ad9eb851ec, q), q);
        o.t2 = addmod(o.t2, mulmod(i.t24, 0x5660c2f2ab8e716d0307f64c436987dbcff6b670aaa971b8fafafafa3c3c3c3d, q), q);

        o.t3 = 0;
        o.t3 = addmod(o.t3, mulmod(i.t0, 0x5f3a1296990a8256bc5d3a98e3573a96a95bc6b95247cb9176db6db60924924a, q), q);
        o.t3 = addmod(o.t3, mulmod(i.t1, 0x6beeeb3bc5a44881038e2168963594284523521472c0aded69ee5845b08d3dcc, q), q);
        o.t3 = addmod(o.t3, mulmod(i.t2, 0x58e0de26287035620523d04a6dc8e1596ade30f13bba79baf7777776b3333334, q), q);
        o.t3 = addmod(o.t3, mulmod(i.t3, 0x21a817cdd2467f35fe5b1dafc0bb5fbf7b689af89ce6bfdead6b5ad66b5ad6b6, q), q);
        o.t3 = addmod(o.t3, mulmod(i.t4, 0x704e3a189050915df1a00947c954c945291fb6e2e7fe691f07ffffff08000001, q), q);
        o.t3 = addmod(o.t3, mulmod(i.t5, 0x706a54adbbbf813e4130555d209cf08149721367c1eee4d83e0f83e000000001, q), q);
        o.t3 = addmod(o.t3, mulmod(i.t6, 0x479a50c26c86eb7f6aef056e604d5fc70e133fa77ffefc95f8787877da5a5a5b, q), q);
        o.t3 = addmod(o.t3, mulmod(i.t7, 0x4c2e7545473b9b7896b0fbad82ac2edeede305610e9fd60df8af8af807507508, q), q);
        o.t3 = addmod(o.t3, mulmod(i.t8, 0x236c2c0413d3ad64488a903b5846c91e1279f21d5c7146c6ce38e38deaaaaaab, q), q);
        o.t3 = addmod(o.t3, mulmod(i.t9, 0x12cc97ac9ef6f1b8ae5c6838a79db453e410ea29ffffbbe42983759ef914c1bb, q), q);
        o.t3 = addmod(o.t3, mulmod(i.t10, 0x70e0a9a88d929bab5a4c883db8895fcf4accdc53c35cb7e41435e50c80000001, q), q);
        o.t3 = addmod(o.t3, mulmod(i.t11, 0x20b29ec8afd716352f44d3e802b77e91e9aba469df2d7c68be5be5be13b13b14, q), q);
        o.t3 = addmod(o.t3, mulmod(i.t12, 0x42a8a69c9e54280983dadc37d256a9031026a4b4eccbdb4c3999999906666667, q), q);
        o.t3 = addmod(o.t3, mulmod(i.t13, 0x087b891f0f8866d354eb41c2262b0fce7046123ea895bbcdf9c18f9c063e7064, q), q);
        o.t3 = addmod(o.t3, mulmod(i.t14, 0x3f7c0c646607018f283e2710978f7c6470e7d9d0e1853260f9e79e795b6db6dc, q), q);
        o.t3 = addmod(o.t3, mulmod(i.t15, 0x3e021802ced14302e5d18b5d99fd43eb0912163d23b7ae3affffffff7711dc48, q), q);
        o.t3 = addmod(o.t3, mulmod(i.t16, 0x714b295717370040bdb2b607dade2a624c04f78e9172c2a1ee8ba2e7c0000001, q), q);
        o.t3 = addmod(o.t3, mulmod(i.t17, 0x61e5213528d4a2aebf2b28344c6688e80dd3574c7d266fd1a4fa4fa422222223, q), q);
        o.t3 = addmod(o.t3, mulmod(i.t18, 0x6c5e278af4d06f8bd6d77676d15a1247c32624721bd1f1d28b21642b9642c85a, q), q);
        o.t3 = addmod(o.t3, mulmod(i.t19, 0x0766517d23564ece23f35a0b681aabbefa739815fa8d8326105726209df51b3c, q), q);
        o.t3 = addmod(o.t3, mulmod(i.t20, 0x71835e816e14e0015cd34e32896e78da8ca9b0984553ba145aaaaaa9b0000001, q), q);
        o.t3 = addmod(o.t3, mulmod(i.t21, 0x5789a824ac7c25219ed8161084a93aa0c1d857462f03fc52d6343eb0e0a72f06, q), q);
        o.t3 = addmod(o.t3, mulmod(i.t22, 0x3553b87d4b76866e03157cf9751220cf401eea2a57097c3cfae147ad9eb851ec, q), q);
        o.t3 = addmod(o.t3, mulmod(i.t23, 0x5660c2f2ab8e716d0307f64c436987dbcff6b670aaa971b8fafafafa3c3c3c3d, q), q);
        o.t3 = addmod(o.t3, mulmod(i.t24, 0x1885f71683e150a7e3739eee02099eed6f40bb4f67621d4e8ec4ec4e8ec4ec4f, q), q);

        o.t4 = 0;
        o.t4 = addmod(o.t4, mulmod(i.t0, 0x6beeeb3bc5a44881038e2168963594284523521472c0aded69ee5845b08d3dcc, q), q);
        o.t4 = addmod(o.t4, mulmod(i.t1, 0x58e0de26287035620523d04a6dc8e1596ade30f13bba79baf7777776b3333334, q), q);
        o.t4 = addmod(o.t4, mulmod(i.t2, 0x21a817cdd2467f35fe5b1dafc0bb5fbf7b689af89ce6bfdead6b5ad66b5ad6b6, q), q);
        o.t4 = addmod(o.t4, mulmod(i.t3, 0x704e3a189050915df1a00947c954c945291fb6e2e7fe691f07ffffff08000001, q), q);
        o.t4 = addmod(o.t4, mulmod(i.t4, 0x706a54adbbbf813e4130555d209cf08149721367c1eee4d83e0f83e000000001, q), q);
        o.t4 = addmod(o.t4, mulmod(i.t5, 0x479a50c26c86eb7f6aef056e604d5fc70e133fa77ffefc95f8787877da5a5a5b, q), q);
        o.t4 = addmod(o.t4, mulmod(i.t6, 0x4c2e7545473b9b7896b0fbad82ac2edeede305610e9fd60df8af8af807507508, q), q);
        o.t4 = addmod(o.t4, mulmod(i.t7, 0x236c2c0413d3ad64488a903b5846c91e1279f21d5c7146c6ce38e38deaaaaaab, q), q);
        o.t4 = addmod(o.t4, mulmod(i.t8, 0x12cc97ac9ef6f1b8ae5c6838a79db453e410ea29ffffbbe42983759ef914c1bb, q), q);
        o.t4 = addmod(o.t4, mulmod(i.t9, 0x70e0a9a88d929bab5a4c883db8895fcf4accdc53c35cb7e41435e50c80000001, q), q);
        o.t4 = addmod(o.t4, mulmod(i.t10, 0x20b29ec8afd716352f44d3e802b77e91e9aba469df2d7c68be5be5be13b13b14, q), q);
        o.t4 = addmod(o.t4, mulmod(i.t11, 0x42a8a69c9e54280983dadc37d256a9031026a4b4eccbdb4c3999999906666667, q), q);
        o.t4 = addmod(o.t4, mulmod(i.t12, 0x087b891f0f8866d354eb41c2262b0fce7046123ea895bbcdf9c18f9c063e7064, q), q);
        o.t4 = addmod(o.t4, mulmod(i.t13, 0x3f7c0c646607018f283e2710978f7c6470e7d9d0e1853260f9e79e795b6db6dc, q), q);
        o.t4 = addmod(o.t4, mulmod(i.t14, 0x3e021802ced14302e5d18b5d99fd43eb0912163d23b7ae3affffffff7711dc48, q), q);
        o.t4 = addmod(o.t4, mulmod(i.t15, 0x714b295717370040bdb2b607dade2a624c04f78e9172c2a1ee8ba2e7c0000001, q), q);
        o.t4 = addmod(o.t4, mulmod(i.t16, 0x61e5213528d4a2aebf2b28344c6688e80dd3574c7d266fd1a4fa4fa422222223, q), q);
        o.t4 = addmod(o.t4, mulmod(i.t17, 0x6c5e278af4d06f8bd6d77676d15a1247c32624721bd1f1d28b21642b9642c85a, q), q);
        o.t4 = addmod(o.t4, mulmod(i.t18, 0x0766517d23564ece23f35a0b681aabbefa739815fa8d8326105726209df51b3c, q), q);
        o.t4 = addmod(o.t4, mulmod(i.t19, 0x71835e816e14e0015cd34e32896e78da8ca9b0984553ba145aaaaaa9b0000001, q), q);
        o.t4 = addmod(o.t4, mulmod(i.t20, 0x5789a824ac7c25219ed8161084a93aa0c1d857462f03fc52d6343eb0e0a72f06, q), q);
        o.t4 = addmod(o.t4, mulmod(i.t21, 0x3553b87d4b76866e03157cf9751220cf401eea2a57097c3cfae147ad9eb851ec, q), q);
        o.t4 = addmod(o.t4, mulmod(i.t22, 0x5660c2f2ab8e716d0307f64c436987dbcff6b670aaa971b8fafafafa3c3c3c3d, q), q);
        o.t4 = addmod(o.t4, mulmod(i.t23, 0x1885f71683e150a7e3739eee02099eed6f40bb4f67621d4e8ec4ec4e8ec4ec4f, q), q);
        o.t4 = addmod(o.t4, mulmod(i.t24, 0x3f6eb7542542da4951294f907931ea1fe55e1af326a354261826a4396a439f66, q), q);

        o.t5 = 0;
        o.t5 = addmod(o.t5, mulmod(i.t0, 0x58e0de26287035620523d04a6dc8e1596ade30f13bba79baf7777776b3333334, q), q);
        o.t5 = addmod(o.t5, mulmod(i.t1, 0x21a817cdd2467f35fe5b1dafc0bb5fbf7b689af89ce6bfdead6b5ad66b5ad6b6, q), q);
        o.t5 = addmod(o.t5, mulmod(i.t2, 0x704e3a189050915df1a00947c954c945291fb6e2e7fe691f07ffffff08000001, q), q);
        o.t5 = addmod(o.t5, mulmod(i.t3, 0x706a54adbbbf813e4130555d209cf08149721367c1eee4d83e0f83e000000001, q), q);
        o.t5 = addmod(o.t5, mulmod(i.t4, 0x479a50c26c86eb7f6aef056e604d5fc70e133fa77ffefc95f8787877da5a5a5b, q), q);
        o.t5 = addmod(o.t5, mulmod(i.t5, 0x4c2e7545473b9b7896b0fbad82ac2edeede305610e9fd60df8af8af807507508, q), q);
        o.t5 = addmod(o.t5, mulmod(i.t6, 0x236c2c0413d3ad64488a903b5846c91e1279f21d5c7146c6ce38e38deaaaaaab, q), q);
        o.t5 = addmod(o.t5, mulmod(i.t7, 0x12cc97ac9ef6f1b8ae5c6838a79db453e410ea29ffffbbe42983759ef914c1bb, q), q);
        o.t5 = addmod(o.t5, mulmod(i.t8, 0x70e0a9a88d929bab5a4c883db8895fcf4accdc53c35cb7e41435e50c80000001, q), q);
        o.t5 = addmod(o.t5, mulmod(i.t9, 0x20b29ec8afd716352f44d3e802b77e91e9aba469df2d7c68be5be5be13b13b14, q), q);
        o.t5 = addmod(o.t5, mulmod(i.t10, 0x42a8a69c9e54280983dadc37d256a9031026a4b4eccbdb4c3999999906666667, q), q);
        o.t5 = addmod(o.t5, mulmod(i.t11, 0x087b891f0f8866d354eb41c2262b0fce7046123ea895bbcdf9c18f9c063e7064, q), q);
        o.t5 = addmod(o.t5, mulmod(i.t12, 0x3f7c0c646607018f283e2710978f7c6470e7d9d0e1853260f9e79e795b6db6dc, q), q);
        o.t5 = addmod(o.t5, mulmod(i.t13, 0x3e021802ced14302e5d18b5d99fd43eb0912163d23b7ae3affffffff7711dc48, q), q);
        o.t5 = addmod(o.t5, mulmod(i.t14, 0x714b295717370040bdb2b607dade2a624c04f78e9172c2a1ee8ba2e7c0000001, q), q);
        o.t5 = addmod(o.t5, mulmod(i.t15, 0x61e5213528d4a2aebf2b28344c6688e80dd3574c7d266fd1a4fa4fa422222223, q), q);
        o.t5 = addmod(o.t5, mulmod(i.t16, 0x6c5e278af4d06f8bd6d77676d15a1247c32624721bd1f1d28b21642b9642c85a, q), q);
        o.t5 = addmod(o.t5, mulmod(i.t17, 0x0766517d23564ece23f35a0b681aabbefa739815fa8d8326105726209df51b3c, q), q);
        o.t5 = addmod(o.t5, mulmod(i.t18, 0x71835e816e14e0015cd34e32896e78da8ca9b0984553ba145aaaaaa9b0000001, q), q);
        o.t5 = addmod(o.t5, mulmod(i.t19, 0x5789a824ac7c25219ed8161084a93aa0c1d857462f03fc52d6343eb0e0a72f06, q), q);
        o.t5 = addmod(o.t5, mulmod(i.t20, 0x3553b87d4b76866e03157cf9751220cf401eea2a57097c3cfae147ad9eb851ec, q), q);
        o.t5 = addmod(o.t5, mulmod(i.t21, 0x5660c2f2ab8e716d0307f64c436987dbcff6b670aaa971b8fafafafa3c3c3c3d, q), q);
        o.t5 = addmod(o.t5, mulmod(i.t22, 0x1885f71683e150a7e3739eee02099eed6f40bb4f67621d4e8ec4ec4e8ec4ec4f, q), q);
        o.t5 = addmod(o.t5, mulmod(i.t23, 0x3f6eb7542542da4951294f907931ea1fe55e1af326a354261826a4396a439f66, q), q);
        o.t5 = addmod(o.t5, mulmod(i.t24, 0x3e41ffc91b16f2b0416fa82a3e0fce15d2e5d81492f5a32eded097b39c71c71d, q), q);

        o.t6 = 0;
        o.t6 = addmod(o.t6, mulmod(i.t0, 0x21a817cdd2467f35fe5b1dafc0bb5fbf7b689af89ce6bfdead6b5ad66b5ad6b6, q), q);
        o.t6 = addmod(o.t6, mulmod(i.t1, 0x704e3a189050915df1a00947c954c945291fb6e2e7fe691f07ffffff08000001, q), q);
        o.t6 = addmod(o.t6, mulmod(i.t2, 0x706a54adbbbf813e4130555d209cf08149721367c1eee4d83e0f83e000000001, q), q);
        o.t6 = addmod(o.t6, mulmod(i.t3, 0x479a50c26c86eb7f6aef056e604d5fc70e133fa77ffefc95f8787877da5a5a5b, q), q);
        o.t6 = addmod(o.t6, mulmod(i.t4, 0x4c2e7545473b9b7896b0fbad82ac2edeede305610e9fd60df8af8af807507508, q), q);
        o.t6 = addmod(o.t6, mulmod(i.t5, 0x236c2c0413d3ad64488a903b5846c91e1279f21d5c7146c6ce38e38deaaaaaab, q), q);
        o.t6 = addmod(o.t6, mulmod(i.t6, 0x12cc97ac9ef6f1b8ae5c6838a79db453e410ea29ffffbbe42983759ef914c1bb, q), q);
        o.t6 = addmod(o.t6, mulmod(i.t7, 0x70e0a9a88d929bab5a4c883db8895fcf4accdc53c35cb7e41435e50c80000001, q), q);
        o.t6 = addmod(o.t6, mulmod(i.t8, 0x20b29ec8afd716352f44d3e802b77e91e9aba469df2d7c68be5be5be13b13b14, q), q);
        o.t6 = addmod(o.t6, mulmod(i.t9, 0x42a8a69c9e54280983dadc37d256a9031026a4b4eccbdb4c3999999906666667, q), q);
        o.t6 = addmod(o.t6, mulmod(i.t10, 0x087b891f0f8866d354eb41c2262b0fce7046123ea895bbcdf9c18f9c063e7064, q), q);
        o.t6 = addmod(o.t6, mulmod(i.t11, 0x3f7c0c646607018f283e2710978f7c6470e7d9d0e1853260f9e79e795b6db6dc, q), q);
        o.t6 = addmod(o.t6, mulmod(i.t12, 0x3e021802ced14302e5d18b5d99fd43eb0912163d23b7ae3affffffff7711dc48, q), q);
        o.t6 = addmod(o.t6, mulmod(i.t13, 0x714b295717370040bdb2b607dade2a624c04f78e9172c2a1ee8ba2e7c0000001, q), q);
        o.t6 = addmod(o.t6, mulmod(i.t14, 0x61e5213528d4a2aebf2b28344c6688e80dd3574c7d266fd1a4fa4fa422222223, q), q);
        o.t6 = addmod(o.t6, mulmod(i.t15, 0x6c5e278af4d06f8bd6d77676d15a1247c32624721bd1f1d28b21642b9642c85a, q), q);
        o.t6 = addmod(o.t6, mulmod(i.t16, 0x0766517d23564ece23f35a0b681aabbefa739815fa8d8326105726209df51b3c, q), q);
        o.t6 = addmod(o.t6, mulmod(i.t17, 0x71835e816e14e0015cd34e32896e78da8ca9b0984553ba145aaaaaa9b0000001, q), q);
        o.t6 = addmod(o.t6, mulmod(i.t18, 0x5789a824ac7c25219ed8161084a93aa0c1d857462f03fc52d6343eb0e0a72f06, q), q);
        o.t6 = addmod(o.t6, mulmod(i.t19, 0x3553b87d4b76866e03157cf9751220cf401eea2a57097c3cfae147ad9eb851ec, q), q);
        o.t6 = addmod(o.t6, mulmod(i.t20, 0x5660c2f2ab8e716d0307f64c436987dbcff6b670aaa971b8fafafafa3c3c3c3d, q), q);
        o.t6 = addmod(o.t6, mulmod(i.t21, 0x1885f71683e150a7e3739eee02099eed6f40bb4f67621d4e8ec4ec4e8ec4ec4f, q), q);
        o.t6 = addmod(o.t6, mulmod(i.t22, 0x3f6eb7542542da4951294f907931ea1fe55e1af326a354261826a4396a439f66, q), q);
        o.t6 = addmod(o.t6, mulmod(i.t23, 0x3e41ffc91b16f2b0416fa82a3e0fce15d2e5d81492f5a32eded097b39c71c71d, q), q);
        o.t6 = addmod(o.t6, mulmod(i.t24, 0x5aa28778df5f3366fe28919fe24b551b7003f93edac2354e586fb58633333334, q), q);

        o.t7 = 0;
        o.t7 = addmod(o.t7, mulmod(i.t0, 0x704e3a189050915df1a00947c954c945291fb6e2e7fe691f07ffffff08000001, q), q);
        o.t7 = addmod(o.t7, mulmod(i.t1, 0x706a54adbbbf813e4130555d209cf08149721367c1eee4d83e0f83e000000001, q), q);
        o.t7 = addmod(o.t7, mulmod(i.t2, 0x479a50c26c86eb7f6aef056e604d5fc70e133fa77ffefc95f8787877da5a5a5b, q), q);
        o.t7 = addmod(o.t7, mulmod(i.t3, 0x4c2e7545473b9b7896b0fbad82ac2edeede305610e9fd60df8af8af807507508, q), q);
        o.t7 = addmod(o.t7, mulmod(i.t4, 0x236c2c0413d3ad64488a903b5846c91e1279f21d5c7146c6ce38e38deaaaaaab, q), q);
        o.t7 = addmod(o.t7, mulmod(i.t5, 0x12cc97ac9ef6f1b8ae5c6838a79db453e410ea29ffffbbe42983759ef914c1bb, q), q);
        o.t7 = addmod(o.t7, mulmod(i.t6, 0x70e0a9a88d929bab5a4c883db8895fcf4accdc53c35cb7e41435e50c80000001, q), q);
        o.t7 = addmod(o.t7, mulmod(i.t7, 0x20b29ec8afd716352f44d3e802b77e91e9aba469df2d7c68be5be5be13b13b14, q), q);
        o.t7 = addmod(o.t7, mulmod(i.t8, 0x42a8a69c9e54280983dadc37d256a9031026a4b4eccbdb4c3999999906666667, q), q);
        o.t7 = addmod(o.t7, mulmod(i.t9, 0x087b891f0f8866d354eb41c2262b0fce7046123ea895bbcdf9c18f9c063e7064, q), q);
        o.t7 = addmod(o.t7, mulmod(i.t10, 0x3f7c0c646607018f283e2710978f7c6470e7d9d0e1853260f9e79e795b6db6dc, q), q);
        o.t7 = addmod(o.t7, mulmod(i.t11, 0x3e021802ced14302e5d18b5d99fd43eb0912163d23b7ae3affffffff7711dc48, q), q);
        o.t7 = addmod(o.t7, mulmod(i.t12, 0x714b295717370040bdb2b607dade2a624c04f78e9172c2a1ee8ba2e7c0000001, q), q);
        o.t7 = addmod(o.t7, mulmod(i.t13, 0x61e5213528d4a2aebf2b28344c6688e80dd3574c7d266fd1a4fa4fa422222223, q), q);
        o.t7 = addmod(o.t7, mulmod(i.t14, 0x6c5e278af4d06f8bd6d77676d15a1247c32624721bd1f1d28b21642b9642c85a, q), q);
        o.t7 = addmod(o.t7, mulmod(i.t15, 0x0766517d23564ece23f35a0b681aabbefa739815fa8d8326105726209df51b3c, q), q);
        o.t7 = addmod(o.t7, mulmod(i.t16, 0x71835e816e14e0015cd34e32896e78da8ca9b0984553ba145aaaaaa9b0000001, q), q);
        o.t7 = addmod(o.t7, mulmod(i.t17, 0x5789a824ac7c25219ed8161084a93aa0c1d857462f03fc52d6343eb0e0a72f06, q), q);
        o.t7 = addmod(o.t7, mulmod(i.t18, 0x3553b87d4b76866e03157cf9751220cf401eea2a57097c3cfae147ad9eb851ec, q), q);
        o.t7 = addmod(o.t7, mulmod(i.t19, 0x5660c2f2ab8e716d0307f64c436987dbcff6b670aaa971b8fafafafa3c3c3c3d, q), q);
        o.t7 = addmod(o.t7, mulmod(i.t20, 0x1885f71683e150a7e3739eee02099eed6f40bb4f67621d4e8ec4ec4e8ec4ec4f, q), q);
        o.t7 = addmod(o.t7, mulmod(i.t21, 0x3f6eb7542542da4951294f907931ea1fe55e1af326a354261826a4396a439f66, q), q);
        o.t7 = addmod(o.t7, mulmod(i.t22, 0x3e41ffc91b16f2b0416fa82a3e0fce15d2e5d81492f5a32eded097b39c71c71d, q), q);
        o.t7 = addmod(o.t7, mulmod(i.t23, 0x5aa28778df5f3366fe28919fe24b551b7003f93edac2354e586fb58633333334, q), q);
        o.t7 = addmod(o.t7, mulmod(i.t24, 0x2f9d094b4c85412b5e2e9d4c71ab9d4b54ade35ca923e5c8bb6db6db04924925, q), q);

        o.t8 = 0;
        o.t8 = addmod(o.t8, mulmod(i.t0, 0x706a54adbbbf813e4130555d209cf08149721367c1eee4d83e0f83e000000001, q), q);
        o.t8 = addmod(o.t8, mulmod(i.t1, 0x479a50c26c86eb7f6aef056e604d5fc70e133fa77ffefc95f8787877da5a5a5b, q), q);
        o.t8 = addmod(o.t8, mulmod(i.t2, 0x4c2e7545473b9b7896b0fbad82ac2edeede305610e9fd60df8af8af807507508, q), q);
        o.t8 = addmod(o.t8, mulmod(i.t3, 0x236c2c0413d3ad64488a903b5846c91e1279f21d5c7146c6ce38e38deaaaaaab, q), q);
        o.t8 = addmod(o.t8, mulmod(i.t4, 0x12cc97ac9ef6f1b8ae5c6838a79db453e410ea29ffffbbe42983759ef914c1bb, q), q);
        o.t8 = addmod(o.t8, mulmod(i.t5, 0x70e0a9a88d929bab5a4c883db8895fcf4accdc53c35cb7e41435e50c80000001, q), q);
        o.t8 = addmod(o.t8, mulmod(i.t6, 0x20b29ec8afd716352f44d3e802b77e91e9aba469df2d7c68be5be5be13b13b14, q), q);
        o.t8 = addmod(o.t8, mulmod(i.t7, 0x42a8a69c9e54280983dadc37d256a9031026a4b4eccbdb4c3999999906666667, q), q);
        o.t8 = addmod(o.t8, mulmod(i.t8, 0x087b891f0f8866d354eb41c2262b0fce7046123ea895bbcdf9c18f9c063e7064, q), q);
        o.t8 = addmod(o.t8, mulmod(i.t9, 0x3f7c0c646607018f283e2710978f7c6470e7d9d0e1853260f9e79e795b6db6dc, q), q);
        o.t8 = addmod(o.t8, mulmod(i.t10, 0x3e021802ced14302e5d18b5d99fd43eb0912163d23b7ae3affffffff7711dc48, q), q);
        o.t8 = addmod(o.t8, mulmod(i.t11, 0x714b295717370040bdb2b607dade2a624c04f78e9172c2a1ee8ba2e7c0000001, q), q);
        o.t8 = addmod(o.t8, mulmod(i.t12, 0x61e5213528d4a2aebf2b28344c6688e80dd3574c7d266fd1a4fa4fa422222223, q), q);
        o.t8 = addmod(o.t8, mulmod(i.t13, 0x6c5e278af4d06f8bd6d77676d15a1247c32624721bd1f1d28b21642b9642c85a, q), q);
        o.t8 = addmod(o.t8, mulmod(i.t14, 0x0766517d23564ece23f35a0b681aabbefa739815fa8d8326105726209df51b3c, q), q);
        o.t8 = addmod(o.t8, mulmod(i.t15, 0x71835e816e14e0015cd34e32896e78da8ca9b0984553ba145aaaaaa9b0000001, q), q);
        o.t8 = addmod(o.t8, mulmod(i.t16, 0x5789a824ac7c25219ed8161084a93aa0c1d857462f03fc52d6343eb0e0a72f06, q), q);
        o.t8 = addmod(o.t8, mulmod(i.t17, 0x3553b87d4b76866e03157cf9751220cf401eea2a57097c3cfae147ad9eb851ec, q), q);
        o.t8 = addmod(o.t8, mulmod(i.t18, 0x5660c2f2ab8e716d0307f64c436987dbcff6b670aaa971b8fafafafa3c3c3c3d, q), q);
        o.t8 = addmod(o.t8, mulmod(i.t19, 0x1885f71683e150a7e3739eee02099eed6f40bb4f67621d4e8ec4ec4e8ec4ec4f, q), q);
        o.t8 = addmod(o.t8, mulmod(i.t20, 0x3f6eb7542542da4951294f907931ea1fe55e1af326a354261826a4396a439f66, q), q);
        o.t8 = addmod(o.t8, mulmod(i.t21, 0x3e41ffc91b16f2b0416fa82a3e0fce15d2e5d81492f5a32eded097b39c71c71d, q), q);
        o.t8 = addmod(o.t8, mulmod(i.t22, 0x5aa28778df5f3366fe28919fe24b551b7003f93edac2354e586fb58633333334, q), q);
        o.t8 = addmod(o.t8, mulmod(i.t23, 0x2f9d094b4c85412b5e2e9d4c71ab9d4b54ade35ca923e5c8bb6db6db04924925, q), q);
        o.t8 = addmod(o.t8, mulmod(i.t24, 0x71e4fe36c1963c34f7f0f82bd39187e14dc7c98e2ce7ee97b823ee0800000001, q), q);

        o.t9 = 0;
        o.t9 = addmod(o.t9, mulmod(i.t0, 0x479a50c26c86eb7f6aef056e604d5fc70e133fa77ffefc95f8787877da5a5a5b, q), q);
        o.t9 = addmod(o.t9, mulmod(i.t1, 0x4c2e7545473b9b7896b0fbad82ac2edeede305610e9fd60df8af8af807507508, q), q);
        o.t9 = addmod(o.t9, mulmod(i.t2, 0x236c2c0413d3ad64488a903b5846c91e1279f21d5c7146c6ce38e38deaaaaaab, q), q);
        o.t9 = addmod(o.t9, mulmod(i.t3, 0x12cc97ac9ef6f1b8ae5c6838a79db453e410ea29ffffbbe42983759ef914c1bb, q), q);
        o.t9 = addmod(o.t9, mulmod(i.t4, 0x70e0a9a88d929bab5a4c883db8895fcf4accdc53c35cb7e41435e50c80000001, q), q);
        o.t9 = addmod(o.t9, mulmod(i.t5, 0x20b29ec8afd716352f44d3e802b77e91e9aba469df2d7c68be5be5be13b13b14, q), q);
        o.t9 = addmod(o.t9, mulmod(i.t6, 0x42a8a69c9e54280983dadc37d256a9031026a4b4eccbdb4c3999999906666667, q), q);
        o.t9 = addmod(o.t9, mulmod(i.t7, 0x087b891f0f8866d354eb41c2262b0fce7046123ea895bbcdf9c18f9c063e7064, q), q);
        o.t9 = addmod(o.t9, mulmod(i.t8, 0x3f7c0c646607018f283e2710978f7c6470e7d9d0e1853260f9e79e795b6db6dc, q), q);
        o.t9 = addmod(o.t9, mulmod(i.t9, 0x3e021802ced14302e5d18b5d99fd43eb0912163d23b7ae3affffffff7711dc48, q), q);
        o.t9 = addmod(o.t9, mulmod(i.t10, 0x714b295717370040bdb2b607dade2a624c04f78e9172c2a1ee8ba2e7c0000001, q), q);
        o.t9 = addmod(o.t9, mulmod(i.t11, 0x61e5213528d4a2aebf2b28344c6688e80dd3574c7d266fd1a4fa4fa422222223, q), q);
        o.t9 = addmod(o.t9, mulmod(i.t12, 0x6c5e278af4d06f8bd6d77676d15a1247c32624721bd1f1d28b21642b9642c85a, q), q);
        o.t9 = addmod(o.t9, mulmod(i.t13, 0x0766517d23564ece23f35a0b681aabbefa739815fa8d8326105726209df51b3c, q), q);
        o.t9 = addmod(o.t9, mulmod(i.t14, 0x71835e816e14e0015cd34e32896e78da8ca9b0984553ba145aaaaaa9b0000001, q), q);
        o.t9 = addmod(o.t9, mulmod(i.t15, 0x5789a824ac7c25219ed8161084a93aa0c1d857462f03fc52d6343eb0e0a72f06, q), q);
        o.t9 = addmod(o.t9, mulmod(i.t16, 0x3553b87d4b76866e03157cf9751220cf401eea2a57097c3cfae147ad9eb851ec, q), q);
        o.t9 = addmod(o.t9, mulmod(i.t17, 0x5660c2f2ab8e716d0307f64c436987dbcff6b670aaa971b8fafafafa3c3c3c3d, q), q);
        o.t9 = addmod(o.t9, mulmod(i.t18, 0x1885f71683e150a7e3739eee02099eed6f40bb4f67621d4e8ec4ec4e8ec4ec4f, q), q);
        o.t9 = addmod(o.t9, mulmod(i.t19, 0x3f6eb7542542da4951294f907931ea1fe55e1af326a354261826a4396a439f66, q), q);
        o.t9 = addmod(o.t9, mulmod(i.t20, 0x3e41ffc91b16f2b0416fa82a3e0fce15d2e5d81492f5a32eded097b39c71c71d, q), q);
        o.t9 = addmod(o.t9, mulmod(i.t21, 0x5aa28778df5f3366fe28919fe24b551b7003f93edac2354e586fb58633333334, q), q);
        o.t9 = addmod(o.t9, mulmod(i.t22, 0x2f9d094b4c85412b5e2e9d4c71ab9d4b54ade35ca923e5c8bb6db6db04924925, q), q);
        o.t9 = addmod(o.t9, mulmod(i.t23, 0x71e4fe36c1963c34f7f0f82bd39187e14dc7c98e2ce7ee97b823ee0800000001, q), q);
        o.t9 = addmod(o.t9, mulmod(i.t24, 0x35f7759de2d2244081c710b44b1aca142291a90a396056f6b4f72c22d8469ee6, q), q);

        o.t10 = 0;
        o.t10 = addmod(o.t10, mulmod(i.t0, 0x4c2e7545473b9b7896b0fbad82ac2edeede305610e9fd60df8af8af807507508, q), q);
        o.t10 = addmod(o.t10, mulmod(i.t1, 0x236c2c0413d3ad64488a903b5846c91e1279f21d5c7146c6ce38e38deaaaaaab, q), q);
        o.t10 = addmod(o.t10, mulmod(i.t2, 0x12cc97ac9ef6f1b8ae5c6838a79db453e410ea29ffffbbe42983759ef914c1bb, q), q);
        o.t10 = addmod(o.t10, mulmod(i.t3, 0x70e0a9a88d929bab5a4c883db8895fcf4accdc53c35cb7e41435e50c80000001, q), q);
        o.t10 = addmod(o.t10, mulmod(i.t4, 0x20b29ec8afd716352f44d3e802b77e91e9aba469df2d7c68be5be5be13b13b14, q), q);
        o.t10 = addmod(o.t10, mulmod(i.t5, 0x42a8a69c9e54280983dadc37d256a9031026a4b4eccbdb4c3999999906666667, q), q);
        o.t10 = addmod(o.t10, mulmod(i.t6, 0x087b891f0f8866d354eb41c2262b0fce7046123ea895bbcdf9c18f9c063e7064, q), q);
        o.t10 = addmod(o.t10, mulmod(i.t7, 0x3f7c0c646607018f283e2710978f7c6470e7d9d0e1853260f9e79e795b6db6dc, q), q);
        o.t10 = addmod(o.t10, mulmod(i.t8, 0x3e021802ced14302e5d18b5d99fd43eb0912163d23b7ae3affffffff7711dc48, q), q);
        o.t10 = addmod(o.t10, mulmod(i.t9, 0x714b295717370040bdb2b607dade2a624c04f78e9172c2a1ee8ba2e7c0000001, q), q);
        o.t10 = addmod(o.t10, mulmod(i.t10, 0x61e5213528d4a2aebf2b28344c6688e80dd3574c7d266fd1a4fa4fa422222223, q), q);
        o.t10 = addmod(o.t10, mulmod(i.t11, 0x6c5e278af4d06f8bd6d77676d15a1247c32624721bd1f1d28b21642b9642c85a, q), q);
        o.t10 = addmod(o.t10, mulmod(i.t12, 0x0766517d23564ece23f35a0b681aabbefa739815fa8d8326105726209df51b3c, q), q);
        o.t10 = addmod(o.t10, mulmod(i.t13, 0x71835e816e14e0015cd34e32896e78da8ca9b0984553ba145aaaaaa9b0000001, q), q);
        o.t10 = addmod(o.t10, mulmod(i.t14, 0x5789a824ac7c25219ed8161084a93aa0c1d857462f03fc52d6343eb0e0a72f06, q), q);
        o.t10 = addmod(o.t10, mulmod(i.t15, 0x3553b87d4b76866e03157cf9751220cf401eea2a57097c3cfae147ad9eb851ec, q), q);
        o.t10 = addmod(o.t10, mulmod(i.t16, 0x5660c2f2ab8e716d0307f64c436987dbcff6b670aaa971b8fafafafa3c3c3c3d, q), q);
        o.t10 = addmod(o.t10, mulmod(i.t17, 0x1885f71683e150a7e3739eee02099eed6f40bb4f67621d4e8ec4ec4e8ec4ec4f, q), q);
        o.t10 = addmod(o.t10, mulmod(i.t18, 0x3f6eb7542542da4951294f907931ea1fe55e1af326a354261826a4396a439f66, q), q);
        o.t10 = addmod(o.t10, mulmod(i.t19, 0x3e41ffc91b16f2b0416fa82a3e0fce15d2e5d81492f5a32eded097b39c71c71d, q), q);
        o.t10 = addmod(o.t10, mulmod(i.t20, 0x5aa28778df5f3366fe28919fe24b551b7003f93edac2354e586fb58633333334, q), q);
        o.t10 = addmod(o.t10, mulmod(i.t21, 0x2f9d094b4c85412b5e2e9d4c71ab9d4b54ade35ca923e5c8bb6db6db04924925, q), q);
        o.t10 = addmod(o.t10, mulmod(i.t22, 0x71e4fe36c1963c34f7f0f82bd39187e14dc7c98e2ce7ee97b823ee0800000001, q), q);
        o.t10 = addmod(o.t10, mulmod(i.t23, 0x35f7759de2d2244081c710b44b1aca142291a90a396056f6b4f72c22d8469ee6, q), q);
        o.t10 = addmod(o.t10, mulmod(i.t24, 0x5c59854aed155271ec0fb4c5516f920cebedd96edd4874acc34115b11a08ad90, q), q);

        o.t11 = 0;
        o.t11 = addmod(o.t11, mulmod(i.t0, 0x236c2c0413d3ad64488a903b5846c91e1279f21d5c7146c6ce38e38deaaaaaab, q), q);
        o.t11 = addmod(o.t11, mulmod(i.t1, 0x12cc97ac9ef6f1b8ae5c6838a79db453e410ea29ffffbbe42983759ef914c1bb, q), q);
        o.t11 = addmod(o.t11, mulmod(i.t2, 0x70e0a9a88d929bab5a4c883db8895fcf4accdc53c35cb7e41435e50c80000001, q), q);
        o.t11 = addmod(o.t11, mulmod(i.t3, 0x20b29ec8afd716352f44d3e802b77e91e9aba469df2d7c68be5be5be13b13b14, q), q);
        o.t11 = addmod(o.t11, mulmod(i.t4, 0x42a8a69c9e54280983dadc37d256a9031026a4b4eccbdb4c3999999906666667, q), q);
        o.t11 = addmod(o.t11, mulmod(i.t5, 0x087b891f0f8866d354eb41c2262b0fce7046123ea895bbcdf9c18f9c063e7064, q), q);
        o.t11 = addmod(o.t11, mulmod(i.t6, 0x3f7c0c646607018f283e2710978f7c6470e7d9d0e1853260f9e79e795b6db6dc, q), q);
        o.t11 = addmod(o.t11, mulmod(i.t7, 0x3e021802ced14302e5d18b5d99fd43eb0912163d23b7ae3affffffff7711dc48, q), q);
        o.t11 = addmod(o.t11, mulmod(i.t8, 0x714b295717370040bdb2b607dade2a624c04f78e9172c2a1ee8ba2e7c0000001, q), q);
        o.t11 = addmod(o.t11, mulmod(i.t9, 0x61e5213528d4a2aebf2b28344c6688e80dd3574c7d266fd1a4fa4fa422222223, q), q);
        o.t11 = addmod(o.t11, mulmod(i.t10, 0x6c5e278af4d06f8bd6d77676d15a1247c32624721bd1f1d28b21642b9642c85a, q), q);
        o.t11 = addmod(o.t11, mulmod(i.t11, 0x0766517d23564ece23f35a0b681aabbefa739815fa8d8326105726209df51b3c, q), q);
        o.t11 = addmod(o.t11, mulmod(i.t12, 0x71835e816e14e0015cd34e32896e78da8ca9b0984553ba145aaaaaa9b0000001, q), q);
        o.t11 = addmod(o.t11, mulmod(i.t13, 0x5789a824ac7c25219ed8161084a93aa0c1d857462f03fc52d6343eb0e0a72f06, q), q);
        o.t11 = addmod(o.t11, mulmod(i.t14, 0x3553b87d4b76866e03157cf9751220cf401eea2a57097c3cfae147ad9eb851ec, q), q);
        o.t11 = addmod(o.t11, mulmod(i.t15, 0x5660c2f2ab8e716d0307f64c436987dbcff6b670aaa971b8fafafafa3c3c3c3d, q), q);
        o.t11 = addmod(o.t11, mulmod(i.t16, 0x1885f71683e150a7e3739eee02099eed6f40bb4f67621d4e8ec4ec4e8ec4ec4f, q), q);
        o.t11 = addmod(o.t11, mulmod(i.t17, 0x3f6eb7542542da4951294f907931ea1fe55e1af326a354261826a4396a439f66, q), q);
        o.t11 = addmod(o.t11, mulmod(i.t18, 0x3e41ffc91b16f2b0416fa82a3e0fce15d2e5d81492f5a32eded097b39c71c71d, q), q);
        o.t11 = addmod(o.t11, mulmod(i.t19, 0x5aa28778df5f3366fe28919fe24b551b7003f93edac2354e586fb58633333334, q), q);
        o.t11 = addmod(o.t11, mulmod(i.t20, 0x2f9d094b4c85412b5e2e9d4c71ab9d4b54ade35ca923e5c8bb6db6db04924925, q), q);
        o.t11 = addmod(o.t11, mulmod(i.t21, 0x71e4fe36c1963c34f7f0f82bd39187e14dc7c98e2ce7ee97b823ee0800000001, q), q);
        o.t11 = addmod(o.t11, mulmod(i.t22, 0x35f7759de2d2244081c710b44b1aca142291a90a396056f6b4f72c22d8469ee6, q), q);
        o.t11 = addmod(o.t11, mulmod(i.t23, 0x5c59854aed155271ec0fb4c5516f920cebedd96edd4874acc34115b11a08ad90, q), q);
        o.t11 = addmod(o.t11, mulmod(i.t24, 0x2c706f1314381ab10291e82536e470acb56f18789ddd3cdd7bbbbbbb5999999a, q), q);

        o.t12 = 0;
        o.t12 = addmod(o.t12, mulmod(i.t0, 0x12cc97ac9ef6f1b8ae5c6838a79db453e410ea29ffffbbe42983759ef914c1bb, q), q);
        o.t12 = addmod(o.t12, mulmod(i.t1, 0x70e0a9a88d929bab5a4c883db8895fcf4accdc53c35cb7e41435e50c80000001, q), q);
        o.t12 = addmod(o.t12, mulmod(i.t2, 0x20b29ec8afd716352f44d3e802b77e91e9aba469df2d7c68be5be5be13b13b14, q), q);
        o.t12 = addmod(o.t12, mulmod(i.t3, 0x42a8a69c9e54280983dadc37d256a9031026a4b4eccbdb4c3999999906666667, q), q);
        o.t12 = addmod(o.t12, mulmod(i.t4, 0x087b891f0f8866d354eb41c2262b0fce7046123ea895bbcdf9c18f9c063e7064, q), q);
        o.t12 = addmod(o.t12, mulmod(i.t5, 0x3f7c0c646607018f283e2710978f7c6470e7d9d0e1853260f9e79e795b6db6dc, q), q);
        o.t12 = addmod(o.t12, mulmod(i.t6, 0x3e021802ced14302e5d18b5d99fd43eb0912163d23b7ae3affffffff7711dc48, q), q);
        o.t12 = addmod(o.t12, mulmod(i.t7, 0x714b295717370040bdb2b607dade2a624c04f78e9172c2a1ee8ba2e7c0000001, q), q);
        o.t12 = addmod(o.t12, mulmod(i.t8, 0x61e5213528d4a2aebf2b28344c6688e80dd3574c7d266fd1a4fa4fa422222223, q), q);
        o.t12 = addmod(o.t12, mulmod(i.t9, 0x6c5e278af4d06f8bd6d77676d15a1247c32624721bd1f1d28b21642b9642c85a, q), q);
        o.t12 = addmod(o.t12, mulmod(i.t10, 0x0766517d23564ece23f35a0b681aabbefa739815fa8d8326105726209df51b3c, q), q);
        o.t12 = addmod(o.t12, mulmod(i.t11, 0x71835e816e14e0015cd34e32896e78da8ca9b0984553ba145aaaaaa9b0000001, q), q);
        o.t12 = addmod(o.t12, mulmod(i.t12, 0x5789a824ac7c25219ed8161084a93aa0c1d857462f03fc52d6343eb0e0a72f06, q), q);
        o.t12 = addmod(o.t12, mulmod(i.t13, 0x3553b87d4b76866e03157cf9751220cf401eea2a57097c3cfae147ad9eb851ec, q), q);
        o.t12 = addmod(o.t12, mulmod(i.t14, 0x5660c2f2ab8e716d0307f64c436987dbcff6b670aaa971b8fafafafa3c3c3c3d, q), q);
        o.t12 = addmod(o.t12, mulmod(i.t15, 0x1885f71683e150a7e3739eee02099eed6f40bb4f67621d4e8ec4ec4e8ec4ec4f, q), q);
        o.t12 = addmod(o.t12, mulmod(i.t16, 0x3f6eb7542542da4951294f907931ea1fe55e1af326a354261826a4396a439f66, q), q);
        o.t12 = addmod(o.t12, mulmod(i.t17, 0x3e41ffc91b16f2b0416fa82a3e0fce15d2e5d81492f5a32eded097b39c71c71d, q), q);
        o.t12 = addmod(o.t12, mulmod(i.t18, 0x5aa28778df5f3366fe28919fe24b551b7003f93edac2354e586fb58633333334, q), q);
        o.t12 = addmod(o.t12, mulmod(i.t19, 0x2f9d094b4c85412b5e2e9d4c71ab9d4b54ade35ca923e5c8bb6db6db04924925, q), q);
        o.t12 = addmod(o.t12, mulmod(i.t20, 0x71e4fe36c1963c34f7f0f82bd39187e14dc7c98e2ce7ee97b823ee0800000001, q), q);
        o.t12 = addmod(o.t12, mulmod(i.t21, 0x35f7759de2d2244081c710b44b1aca142291a90a396056f6b4f72c22d8469ee6, q), q);
        o.t12 = addmod(o.t12, mulmod(i.t22, 0x5c59854aed155271ec0fb4c5516f920cebedd96edd4874acc34115b11a08ad90, q), q);
        o.t12 = addmod(o.t12, mulmod(i.t23, 0x2c706f1314381ab10291e82536e470acb56f18789ddd3cdd7bbbbbbb5999999a, q), q);
        o.t12 = addmod(o.t12, mulmod(i.t24, 0x4deb467f3d8b6d62e37ad026f9e249d99d018fcfa7dd52d129f79b46ac10c972, q), q);

        o.t13 = 0;
        o.t13 = addmod(o.t13, mulmod(i.t0, 0x70e0a9a88d929bab5a4c883db8895fcf4accdc53c35cb7e41435e50c80000001, q), q);
        o.t13 = addmod(o.t13, mulmod(i.t1, 0x20b29ec8afd716352f44d3e802b77e91e9aba469df2d7c68be5be5be13b13b14, q), q);
        o.t13 = addmod(o.t13, mulmod(i.t2, 0x42a8a69c9e54280983dadc37d256a9031026a4b4eccbdb4c3999999906666667, q), q);
        o.t13 = addmod(o.t13, mulmod(i.t3, 0x087b891f0f8866d354eb41c2262b0fce7046123ea895bbcdf9c18f9c063e7064, q), q);
        o.t13 = addmod(o.t13, mulmod(i.t4, 0x3f7c0c646607018f283e2710978f7c6470e7d9d0e1853260f9e79e795b6db6dc, q), q);
        o.t13 = addmod(o.t13, mulmod(i.t5, 0x3e021802ced14302e5d18b5d99fd43eb0912163d23b7ae3affffffff7711dc48, q), q);
        o.t13 = addmod(o.t13, mulmod(i.t6, 0x714b295717370040bdb2b607dade2a624c04f78e9172c2a1ee8ba2e7c0000001, q), q);
        o.t13 = addmod(o.t13, mulmod(i.t7, 0x61e5213528d4a2aebf2b28344c6688e80dd3574c7d266fd1a4fa4fa422222223, q), q);
        o.t13 = addmod(o.t13, mulmod(i.t8, 0x6c5e278af4d06f8bd6d77676d15a1247c32624721bd1f1d28b21642b9642c85a, q), q);
        o.t13 = addmod(o.t13, mulmod(i.t9, 0x0766517d23564ece23f35a0b681aabbefa739815fa8d8326105726209df51b3c, q), q);
        o.t13 = addmod(o.t13, mulmod(i.t10, 0x71835e816e14e0015cd34e32896e78da8ca9b0984553ba145aaaaaa9b0000001, q), q);
        o.t13 = addmod(o.t13, mulmod(i.t11, 0x5789a824ac7c25219ed8161084a93aa0c1d857462f03fc52d6343eb0e0a72f06, q), q);
        o.t13 = addmod(o.t13, mulmod(i.t12, 0x3553b87d4b76866e03157cf9751220cf401eea2a57097c3cfae147ad9eb851ec, q), q);
        o.t13 = addmod(o.t13, mulmod(i.t13, 0x5660c2f2ab8e716d0307f64c436987dbcff6b670aaa971b8fafafafa3c3c3c3d, q), q);
        o.t13 = addmod(o.t13, mulmod(i.t14, 0x1885f71683e150a7e3739eee02099eed6f40bb4f67621d4e8ec4ec4e8ec4ec4f, q), q);
        o.t13 = addmod(o.t13, mulmod(i.t15, 0x3f6eb7542542da4951294f907931ea1fe55e1af326a354261826a4396a439f66, q), q);
        o.t13 = addmod(o.t13, mulmod(i.t16, 0x3e41ffc91b16f2b0416fa82a3e0fce15d2e5d81492f5a32eded097b39c71c71d, q), q);
        o.t13 = addmod(o.t13, mulmod(i.t17, 0x5aa28778df5f3366fe28919fe24b551b7003f93edac2354e586fb58633333334, q), q);
        o.t13 = addmod(o.t13, mulmod(i.t18, 0x2f9d094b4c85412b5e2e9d4c71ab9d4b54ade35ca923e5c8bb6db6db04924925, q), q);
        o.t13 = addmod(o.t13, mulmod(i.t19, 0x71e4fe36c1963c34f7f0f82bd39187e14dc7c98e2ce7ee97b823ee0800000001, q), q);
        o.t13 = addmod(o.t13, mulmod(i.t20, 0x35f7759de2d2244081c710b44b1aca142291a90a396056f6b4f72c22d8469ee6, q), q);
        o.t13 = addmod(o.t13, mulmod(i.t21, 0x5c59854aed155271ec0fb4c5516f920cebedd96edd4874acc34115b11a08ad90, q), q);
        o.t13 = addmod(o.t13, mulmod(i.t22, 0x2c706f1314381ab10291e82536e470acb56f18789ddd3cdd7bbbbbbb5999999a, q), q);
        o.t13 = addmod(o.t13, mulmod(i.t23, 0x4deb467f3d8b6d62e37ad026f9e249d99d018fcfa7dd52d129f79b46ac10c972, q), q);
        o.t13 = addmod(o.t13, mulmod(i.t24, 0x10d40be6e9233f9aff2d8ed7e05dafdfbdb44d7c4e735fef56b5ad6b35ad6b5b, q), q);

        o.t14 = 0;
        o.t14 = addmod(o.t14, mulmod(i.t0, 0x20b29ec8afd716352f44d3e802b77e91e9aba469df2d7c68be5be5be13b13b14, q), q);
        o.t14 = addmod(o.t14, mulmod(i.t1, 0x42a8a69c9e54280983dadc37d256a9031026a4b4eccbdb4c3999999906666667, q), q);
        o.t14 = addmod(o.t14, mulmod(i.t2, 0x087b891f0f8866d354eb41c2262b0fce7046123ea895bbcdf9c18f9c063e7064, q), q);
        o.t14 = addmod(o.t14, mulmod(i.t3, 0x3f7c0c646607018f283e2710978f7c6470e7d9d0e1853260f9e79e795b6db6dc, q), q);
        o.t14 = addmod(o.t14, mulmod(i.t4, 0x3e021802ced14302e5d18b5d99fd43eb0912163d23b7ae3affffffff7711dc48, q), q);
        o.t14 = addmod(o.t14, mulmod(i.t5, 0x714b295717370040bdb2b607dade2a624c04f78e9172c2a1ee8ba2e7c0000001, q), q);
        o.t14 = addmod(o.t14, mulmod(i.t6, 0x61e5213528d4a2aebf2b28344c6688e80dd3574c7d266fd1a4fa4fa422222223, q), q);
        o.t14 = addmod(o.t14, mulmod(i.t7, 0x6c5e278af4d06f8bd6d77676d15a1247c32624721bd1f1d28b21642b9642c85a, q), q);
        o.t14 = addmod(o.t14, mulmod(i.t8, 0x0766517d23564ece23f35a0b681aabbefa739815fa8d8326105726209df51b3c, q), q);
        o.t14 = addmod(o.t14, mulmod(i.t9, 0x71835e816e14e0015cd34e32896e78da8ca9b0984553ba145aaaaaa9b0000001, q), q);
        o.t14 = addmod(o.t14, mulmod(i.t10, 0x5789a824ac7c25219ed8161084a93aa0c1d857462f03fc52d6343eb0e0a72f06, q), q);
        o.t14 = addmod(o.t14, mulmod(i.t11, 0x3553b87d4b76866e03157cf9751220cf401eea2a57097c3cfae147ad9eb851ec, q), q);
        o.t14 = addmod(o.t14, mulmod(i.t12, 0x5660c2f2ab8e716d0307f64c436987dbcff6b670aaa971b8fafafafa3c3c3c3d, q), q);
        o.t14 = addmod(o.t14, mulmod(i.t13, 0x1885f71683e150a7e3739eee02099eed6f40bb4f67621d4e8ec4ec4e8ec4ec4f, q), q);
        o.t14 = addmod(o.t14, mulmod(i.t14, 0x3f6eb7542542da4951294f907931ea1fe55e1af326a354261826a4396a439f66, q), q);
        o.t14 = addmod(o.t14, mulmod(i.t15, 0x3e41ffc91b16f2b0416fa82a3e0fce15d2e5d81492f5a32eded097b39c71c71d, q), q);
        o.t14 = addmod(o.t14, mulmod(i.t16, 0x5aa28778df5f3366fe28919fe24b551b7003f93edac2354e586fb58633333334, q), q);
        o.t14 = addmod(o.t14, mulmod(i.t17, 0x2f9d094b4c85412b5e2e9d4c71ab9d4b54ade35ca923e5c8bb6db6db04924925, q), q);
        o.t14 = addmod(o.t14, mulmod(i.t18, 0x71e4fe36c1963c34f7f0f82bd39187e14dc7c98e2ce7ee97b823ee0800000001, q), q);
        o.t14 = addmod(o.t14, mulmod(i.t19, 0x35f7759de2d2244081c710b44b1aca142291a90a396056f6b4f72c22d8469ee6, q), q);
        o.t14 = addmod(o.t14, mulmod(i.t20, 0x5c59854aed155271ec0fb4c5516f920cebedd96edd4874acc34115b11a08ad90, q), q);
        o.t14 = addmod(o.t14, mulmod(i.t21, 0x2c706f1314381ab10291e82536e470acb56f18789ddd3cdd7bbbbbbb5999999a, q), q);
        o.t14 = addmod(o.t14, mulmod(i.t22, 0x4deb467f3d8b6d62e37ad026f9e249d99d018fcfa7dd52d129f79b46ac10c972, q), q);
        o.t14 = addmod(o.t14, mulmod(i.t23, 0x10d40be6e9233f9aff2d8ed7e05dafdfbdb44d7c4e735fef56b5ad6b35ad6b5b, q), q);
        o.t14 = addmod(o.t14, mulmod(i.t24, 0x03ae25d1e0d02c9cb46b7cb30c7f0aebda060534ebaead96514514513cf3cf3d, q), q);

        o.t15 = 0;
        o.t15 = addmod(o.t15, mulmod(i.t0, 0x42a8a69c9e54280983dadc37d256a9031026a4b4eccbdb4c3999999906666667, q), q);
        o.t15 = addmod(o.t15, mulmod(i.t1, 0x087b891f0f8866d354eb41c2262b0fce7046123ea895bbcdf9c18f9c063e7064, q), q);
        o.t15 = addmod(o.t15, mulmod(i.t2, 0x3f7c0c646607018f283e2710978f7c6470e7d9d0e1853260f9e79e795b6db6dc, q), q);
        o.t15 = addmod(o.t15, mulmod(i.t3, 0x3e021802ced14302e5d18b5d99fd43eb0912163d23b7ae3affffffff7711dc48, q), q);
        o.t15 = addmod(o.t15, mulmod(i.t4, 0x714b295717370040bdb2b607dade2a624c04f78e9172c2a1ee8ba2e7c0000001, q), q);
        o.t15 = addmod(o.t15, mulmod(i.t5, 0x61e5213528d4a2aebf2b28344c6688e80dd3574c7d266fd1a4fa4fa422222223, q), q);
        o.t15 = addmod(o.t15, mulmod(i.t6, 0x6c5e278af4d06f8bd6d77676d15a1247c32624721bd1f1d28b21642b9642c85a, q), q);
        o.t15 = addmod(o.t15, mulmod(i.t7, 0x0766517d23564ece23f35a0b681aabbefa739815fa8d8326105726209df51b3c, q), q);
        o.t15 = addmod(o.t15, mulmod(i.t8, 0x71835e816e14e0015cd34e32896e78da8ca9b0984553ba145aaaaaa9b0000001, q), q);
        o.t15 = addmod(o.t15, mulmod(i.t9, 0x5789a824ac7c25219ed8161084a93aa0c1d857462f03fc52d6343eb0e0a72f06, q), q);
        o.t15 = addmod(o.t15, mulmod(i.t10, 0x3553b87d4b76866e03157cf9751220cf401eea2a57097c3cfae147ad9eb851ec, q), q);
        o.t15 = addmod(o.t15, mulmod(i.t11, 0x5660c2f2ab8e716d0307f64c436987dbcff6b670aaa971b8fafafafa3c3c3c3d, q), q);
        o.t15 = addmod(o.t15, mulmod(i.t12, 0x1885f71683e150a7e3739eee02099eed6f40bb4f67621d4e8ec4ec4e8ec4ec4f, q), q);
        o.t15 = addmod(o.t15, mulmod(i.t13, 0x3f6eb7542542da4951294f907931ea1fe55e1af326a354261826a4396a439f66, q), q);
        o.t15 = addmod(o.t15, mulmod(i.t14, 0x3e41ffc91b16f2b0416fa82a3e0fce15d2e5d81492f5a32eded097b39c71c71d, q), q);
        o.t15 = addmod(o.t15, mulmod(i.t15, 0x5aa28778df5f3366fe28919fe24b551b7003f93edac2354e586fb58633333334, q), q);
        o.t15 = addmod(o.t15, mulmod(i.t16, 0x2f9d094b4c85412b5e2e9d4c71ab9d4b54ade35ca923e5c8bb6db6db04924925, q), q);
        o.t15 = addmod(o.t15, mulmod(i.t17, 0x71e4fe36c1963c34f7f0f82bd39187e14dc7c98e2ce7ee97b823ee0800000001, q), q);
        o.t15 = addmod(o.t15, mulmod(i.t18, 0x35f7759de2d2244081c710b44b1aca142291a90a396056f6b4f72c22d8469ee6, q), q);
        o.t15 = addmod(o.t15, mulmod(i.t19, 0x5c59854aed155271ec0fb4c5516f920cebedd96edd4874acc34115b11a08ad90, q), q);
        o.t15 = addmod(o.t15, mulmod(i.t20, 0x2c706f1314381ab10291e82536e470acb56f18789ddd3cdd7bbbbbbb5999999a, q), q);
        o.t15 = addmod(o.t15, mulmod(i.t21, 0x4deb467f3d8b6d62e37ad026f9e249d99d018fcfa7dd52d129f79b46ac10c972, q), q);
        o.t15 = addmod(o.t15, mulmod(i.t22, 0x10d40be6e9233f9aff2d8ed7e05dafdfbdb44d7c4e735fef56b5ad6b35ad6b5b, q), q);
        o.t15 = addmod(o.t15, mulmod(i.t23, 0x03ae25d1e0d02c9cb46b7cb30c7f0aebda060534ebaead96514514513cf3cf3d, q), q);
        o.t15 = addmod(o.t15, mulmod(i.t24, 0x721df0b5dcf70753126cf0a7e97b50a53e6ead72f3fe628f03ffffff04000001, q), q);

        o.t16 = 0;
        o.t16 = addmod(o.t16, mulmod(i.t0, 0x087b891f0f8866d354eb41c2262b0fce7046123ea895bbcdf9c18f9c063e7064, q), q);
        o.t16 = addmod(o.t16, mulmod(i.t1, 0x3f7c0c646607018f283e2710978f7c6470e7d9d0e1853260f9e79e795b6db6dc, q), q);
        o.t16 = addmod(o.t16, mulmod(i.t2, 0x3e021802ced14302e5d18b5d99fd43eb0912163d23b7ae3affffffff7711dc48, q), q);
        o.t16 = addmod(o.t16, mulmod(i.t3, 0x714b295717370040bdb2b607dade2a624c04f78e9172c2a1ee8ba2e7c0000001, q), q);
        o.t16 = addmod(o.t16, mulmod(i.t4, 0x61e5213528d4a2aebf2b28344c6688e80dd3574c7d266fd1a4fa4fa422222223, q), q);
        o.t16 = addmod(o.t16, mulmod(i.t5, 0x6c5e278af4d06f8bd6d77676d15a1247c32624721bd1f1d28b21642b9642c85a, q), q);
        o.t16 = addmod(o.t16, mulmod(i.t6, 0x0766517d23564ece23f35a0b681aabbefa739815fa8d8326105726209df51b3c, q), q);
        o.t16 = addmod(o.t16, mulmod(i.t7, 0x71835e816e14e0015cd34e32896e78da8ca9b0984553ba145aaaaaa9b0000001, q), q);
        o.t16 = addmod(o.t16, mulmod(i.t8, 0x5789a824ac7c25219ed8161084a93aa0c1d857462f03fc52d6343eb0e0a72f06, q), q);
        o.t16 = addmod(o.t16, mulmod(i.t9, 0x3553b87d4b76866e03157cf9751220cf401eea2a57097c3cfae147ad9eb851ec, q), q);
        o.t16 = addmod(o.t16, mulmod(i.t10, 0x5660c2f2ab8e716d0307f64c436987dbcff6b670aaa971b8fafafafa3c3c3c3d, q), q);
        o.t16 = addmod(o.t16, mulmod(i.t11, 0x1885f71683e150a7e3739eee02099eed6f40bb4f67621d4e8ec4ec4e8ec4ec4f, q), q);
        o.t16 = addmod(o.t16, mulmod(i.t12, 0x3f6eb7542542da4951294f907931ea1fe55e1af326a354261826a4396a439f66, q), q);
        o.t16 = addmod(o.t16, mulmod(i.t13, 0x3e41ffc91b16f2b0416fa82a3e0fce15d2e5d81492f5a32eded097b39c71c71d, q), q);
        o.t16 = addmod(o.t16, mulmod(i.t14, 0x5aa28778df5f3366fe28919fe24b551b7003f93edac2354e586fb58633333334, q), q);
        o.t16 = addmod(o.t16, mulmod(i.t15, 0x2f9d094b4c85412b5e2e9d4c71ab9d4b54ade35ca923e5c8bb6db6db04924925, q), q);
        o.t16 = addmod(o.t16, mulmod(i.t16, 0x71e4fe36c1963c34f7f0f82bd39187e14dc7c98e2ce7ee97b823ee0800000001, q), q);
        o.t16 = addmod(o.t16, mulmod(i.t17, 0x35f7759de2d2244081c710b44b1aca142291a90a396056f6b4f72c22d8469ee6, q), q);
        o.t16 = addmod(o.t16, mulmod(i.t18, 0x5c59854aed155271ec0fb4c5516f920cebedd96edd4874acc34115b11a08ad90, q), q);
        o.t16 = addmod(o.t16, mulmod(i.t19, 0x2c706f1314381ab10291e82536e470acb56f18789ddd3cdd7bbbbbbb5999999a, q), q);
        o.t16 = addmod(o.t16, mulmod(i.t20, 0x4deb467f3d8b6d62e37ad026f9e249d99d018fcfa7dd52d129f79b46ac10c972, q), q);
        o.t16 = addmod(o.t16, mulmod(i.t21, 0x10d40be6e9233f9aff2d8ed7e05dafdfbdb44d7c4e735fef56b5ad6b35ad6b5b, q), q);
        o.t16 = addmod(o.t16, mulmod(i.t22, 0x03ae25d1e0d02c9cb46b7cb30c7f0aebda060534ebaead96514514513cf3cf3d, q), q);
        o.t16 = addmod(o.t16, mulmod(i.t23, 0x721df0b5dcf70753126cf0a7e97b50a53e6ead72f3fe628f03ffffff04000001, q), q);
        o.t16 = addmod(o.t16, mulmod(i.t24, 0x705c7ebaf1323e59abbdf8c4d622c58f0265190eb919faa4723723713f03f040, q), q);

        o.t17 = 0;
        o.t17 = addmod(o.t17, mulmod(i.t0, 0x3f7c0c646607018f283e2710978f7c6470e7d9d0e1853260f9e79e795b6db6dc, q), q);
        o.t17 = addmod(o.t17, mulmod(i.t1, 0x3e021802ced14302e5d18b5d99fd43eb0912163d23b7ae3affffffff7711dc48, q), q);
        o.t17 = addmod(o.t17, mulmod(i.t2, 0x714b295717370040bdb2b607dade2a624c04f78e9172c2a1ee8ba2e7c0000001, q), q);
        o.t17 = addmod(o.t17, mulmod(i.t3, 0x61e5213528d4a2aebf2b28344c6688e80dd3574c7d266fd1a4fa4fa422222223, q), q);
        o.t17 = addmod(o.t17, mulmod(i.t4, 0x6c5e278af4d06f8bd6d77676d15a1247c32624721bd1f1d28b21642b9642c85a, q), q);
        o.t17 = addmod(o.t17, mulmod(i.t5, 0x0766517d23564ece23f35a0b681aabbefa739815fa8d8326105726209df51b3c, q), q);
        o.t17 = addmod(o.t17, mulmod(i.t6, 0x71835e816e14e0015cd34e32896e78da8ca9b0984553ba145aaaaaa9b0000001, q), q);
        o.t17 = addmod(o.t17, mulmod(i.t7, 0x5789a824ac7c25219ed8161084a93aa0c1d857462f03fc52d6343eb0e0a72f06, q), q);
        o.t17 = addmod(o.t17, mulmod(i.t8, 0x3553b87d4b76866e03157cf9751220cf401eea2a57097c3cfae147ad9eb851ec, q), q);
        o.t17 = addmod(o.t17, mulmod(i.t9, 0x5660c2f2ab8e716d0307f64c436987dbcff6b670aaa971b8fafafafa3c3c3c3d, q), q);
        o.t17 = addmod(o.t17, mulmod(i.t10, 0x1885f71683e150a7e3739eee02099eed6f40bb4f67621d4e8ec4ec4e8ec4ec4f, q), q);
        o.t17 = addmod(o.t17, mulmod(i.t11, 0x3f6eb7542542da4951294f907931ea1fe55e1af326a354261826a4396a439f66, q), q);
        o.t17 = addmod(o.t17, mulmod(i.t12, 0x3e41ffc91b16f2b0416fa82a3e0fce15d2e5d81492f5a32eded097b39c71c71d, q), q);
        o.t17 = addmod(o.t17, mulmod(i.t13, 0x5aa28778df5f3366fe28919fe24b551b7003f93edac2354e586fb58633333334, q), q);
        o.t17 = addmod(o.t17, mulmod(i.t14, 0x2f9d094b4c85412b5e2e9d4c71ab9d4b54ade35ca923e5c8bb6db6db04924925, q), q);
        o.t17 = addmod(o.t17, mulmod(i.t15, 0x71e4fe36c1963c34f7f0f82bd39187e14dc7c98e2ce7ee97b823ee0800000001, q), q);
        o.t17 = addmod(o.t17, mulmod(i.t16, 0x35f7759de2d2244081c710b44b1aca142291a90a396056f6b4f72c22d8469ee6, q), q);
        o.t17 = addmod(o.t17, mulmod(i.t17, 0x5c59854aed155271ec0fb4c5516f920cebedd96edd4874acc34115b11a08ad90, q), q);
        o.t17 = addmod(o.t17, mulmod(i.t18, 0x2c706f1314381ab10291e82536e470acb56f18789ddd3cdd7bbbbbbb5999999a, q), q);
        o.t17 = addmod(o.t17, mulmod(i.t19, 0x4deb467f3d8b6d62e37ad026f9e249d99d018fcfa7dd52d129f79b46ac10c972, q), q);
        o.t17 = addmod(o.t17, mulmod(i.t20, 0x10d40be6e9233f9aff2d8ed7e05dafdfbdb44d7c4e735fef56b5ad6b35ad6b5b, q), q);
        o.t17 = addmod(o.t17, mulmod(i.t21, 0x03ae25d1e0d02c9cb46b7cb30c7f0aebda060534ebaead96514514513cf3cf3d, q), q);
        o.t17 = addmod(o.t17, mulmod(i.t22, 0x721df0b5dcf70753126cf0a7e97b50a53e6ead72f3fe628f03ffffff04000001, q), q);
        o.t17 = addmod(o.t17, mulmod(i.t23, 0x705c7ebaf1323e59abbdf8c4d622c58f0265190eb919faa4723723713f03f040, q), q);
        o.t17 = addmod(o.t17, mulmod(i.t24, 0x722bfe0072ae7f433a3516b2951f64434e97dbb560f6a06b9f07c1ef80000001, q), q);

        o.t18 = 0;
        o.t18 = addmod(o.t18, mulmod(i.t0, 0x3e021802ced14302e5d18b5d99fd43eb0912163d23b7ae3affffffff7711dc48, q), q);
        o.t18 = addmod(o.t18, mulmod(i.t1, 0x714b295717370040bdb2b607dade2a624c04f78e9172c2a1ee8ba2e7c0000001, q), q);
        o.t18 = addmod(o.t18, mulmod(i.t2, 0x61e5213528d4a2aebf2b28344c6688e80dd3574c7d266fd1a4fa4fa422222223, q), q);
        o.t18 = addmod(o.t18, mulmod(i.t3, 0x6c5e278af4d06f8bd6d77676d15a1247c32624721bd1f1d28b21642b9642c85a, q), q);
        o.t18 = addmod(o.t18, mulmod(i.t4, 0x0766517d23564ece23f35a0b681aabbefa739815fa8d8326105726209df51b3c, q), q);
        o.t18 = addmod(o.t18, mulmod(i.t5, 0x71835e816e14e0015cd34e32896e78da8ca9b0984553ba145aaaaaa9b0000001, q), q);
        o.t18 = addmod(o.t18, mulmod(i.t6, 0x5789a824ac7c25219ed8161084a93aa0c1d857462f03fc52d6343eb0e0a72f06, q), q);
        o.t18 = addmod(o.t18, mulmod(i.t7, 0x3553b87d4b76866e03157cf9751220cf401eea2a57097c3cfae147ad9eb851ec, q), q);
        o.t18 = addmod(o.t18, mulmod(i.t8, 0x5660c2f2ab8e716d0307f64c436987dbcff6b670aaa971b8fafafafa3c3c3c3d, q), q);
        o.t18 = addmod(o.t18, mulmod(i.t9, 0x1885f71683e150a7e3739eee02099eed6f40bb4f67621d4e8ec4ec4e8ec4ec4f, q), q);
        o.t18 = addmod(o.t18, mulmod(i.t10, 0x3f6eb7542542da4951294f907931ea1fe55e1af326a354261826a4396a439f66, q), q);
        o.t18 = addmod(o.t18, mulmod(i.t11, 0x3e41ffc91b16f2b0416fa82a3e0fce15d2e5d81492f5a32eded097b39c71c71d, q), q);
        o.t18 = addmod(o.t18, mulmod(i.t12, 0x5aa28778df5f3366fe28919fe24b551b7003f93edac2354e586fb58633333334, q), q);
        o.t18 = addmod(o.t18, mulmod(i.t13, 0x2f9d094b4c85412b5e2e9d4c71ab9d4b54ade35ca923e5c8bb6db6db04924925, q), q);
        o.t18 = addmod(o.t18, mulmod(i.t14, 0x71e4fe36c1963c34f7f0f82bd39187e14dc7c98e2ce7ee97b823ee0800000001, q), q);
        o.t18 = addmod(o.t18, mulmod(i.t15, 0x35f7759de2d2244081c710b44b1aca142291a90a396056f6b4f72c22d8469ee6, q), q);
        o.t18 = addmod(o.t18, mulmod(i.t16, 0x5c59854aed155271ec0fb4c5516f920cebedd96edd4874acc34115b11a08ad90, q), q);
        o.t18 = addmod(o.t18, mulmod(i.t17, 0x2c706f1314381ab10291e82536e470acb56f18789ddd3cdd7bbbbbbb5999999a, q), q);
        o.t18 = addmod(o.t18, mulmod(i.t18, 0x4deb467f3d8b6d62e37ad026f9e249d99d018fcfa7dd52d129f79b46ac10c972, q), q);
        o.t18 = addmod(o.t18, mulmod(i.t19, 0x10d40be6e9233f9aff2d8ed7e05dafdfbdb44d7c4e735fef56b5ad6b35ad6b5b, q), q);
        o.t18 = addmod(o.t18, mulmod(i.t20, 0x03ae25d1e0d02c9cb46b7cb30c7f0aebda060534ebaead96514514513cf3cf3d, q), q);
        o.t18 = addmod(o.t18, mulmod(i.t21, 0x721df0b5dcf70753126cf0a7e97b50a53e6ead72f3fe628f03ffffff04000001, q), q);
        o.t18 = addmod(o.t18, mulmod(i.t22, 0x705c7ebaf1323e59abbdf8c4d622c58f0265190eb919faa4723723713f03f040, q), q);
        o.t18 = addmod(o.t18, mulmod(i.t23, 0x722bfe0072ae7f433a3516b2951f64434e97dbb560f6a06b9f07c1ef80000001, q), q);
        o.t18 = addmod(o.t18, mulmod(i.t24, 0x46f0f3c415a52674c77774ea2c1a71165d4632b198d4f75744c6afc240f4898e, q), q);

        o.t19 = 0;
        o.t19 = addmod(o.t19, mulmod(i.t0, 0x714b295717370040bdb2b607dade2a624c04f78e9172c2a1ee8ba2e7c0000001, q), q);
        o.t19 = addmod(o.t19, mulmod(i.t1, 0x61e5213528d4a2aebf2b28344c6688e80dd3574c7d266fd1a4fa4fa422222223, q), q);
        o.t19 = addmod(o.t19, mulmod(i.t2, 0x6c5e278af4d06f8bd6d77676d15a1247c32624721bd1f1d28b21642b9642c85a, q), q);
        o.t19 = addmod(o.t19, mulmod(i.t3, 0x0766517d23564ece23f35a0b681aabbefa739815fa8d8326105726209df51b3c, q), q);
        o.t19 = addmod(o.t19, mulmod(i.t4, 0x71835e816e14e0015cd34e32896e78da8ca9b0984553ba145aaaaaa9b0000001, q), q);
        o.t19 = addmod(o.t19, mulmod(i.t5, 0x5789a824ac7c25219ed8161084a93aa0c1d857462f03fc52d6343eb0e0a72f06, q), q);
        o.t19 = addmod(o.t19, mulmod(i.t6, 0x3553b87d4b76866e03157cf9751220cf401eea2a57097c3cfae147ad9eb851ec, q), q);
        o.t19 = addmod(o.t19, mulmod(i.t7, 0x5660c2f2ab8e716d0307f64c436987dbcff6b670aaa971b8fafafafa3c3c3c3d, q), q);
        o.t19 = addmod(o.t19, mulmod(i.t8, 0x1885f71683e150a7e3739eee02099eed6f40bb4f67621d4e8ec4ec4e8ec4ec4f, q), q);
        o.t19 = addmod(o.t19, mulmod(i.t9, 0x3f6eb7542542da4951294f907931ea1fe55e1af326a354261826a4396a439f66, q), q);
        o.t19 = addmod(o.t19, mulmod(i.t10, 0x3e41ffc91b16f2b0416fa82a3e0fce15d2e5d81492f5a32eded097b39c71c71d, q), q);
        o.t19 = addmod(o.t19, mulmod(i.t11, 0x5aa28778df5f3366fe28919fe24b551b7003f93edac2354e586fb58633333334, q), q);
        o.t19 = addmod(o.t19, mulmod(i.t12, 0x2f9d094b4c85412b5e2e9d4c71ab9d4b54ade35ca923e5c8bb6db6db04924925, q), q);
        o.t19 = addmod(o.t19, mulmod(i.t13, 0x71e4fe36c1963c34f7f0f82bd39187e14dc7c98e2ce7ee97b823ee0800000001, q), q);
        o.t19 = addmod(o.t19, mulmod(i.t14, 0x35f7759de2d2244081c710b44b1aca142291a90a396056f6b4f72c22d8469ee6, q), q);
        o.t19 = addmod(o.t19, mulmod(i.t15, 0x5c59854aed155271ec0fb4c5516f920cebedd96edd4874acc34115b11a08ad90, q), q);
        o.t19 = addmod(o.t19, mulmod(i.t16, 0x2c706f1314381ab10291e82536e470acb56f18789ddd3cdd7bbbbbbb5999999a, q), q);
        o.t19 = addmod(o.t19, mulmod(i.t17, 0x4deb467f3d8b6d62e37ad026f9e249d99d018fcfa7dd52d129f79b46ac10c972, q), q);
        o.t19 = addmod(o.t19, mulmod(i.t18, 0x10d40be6e9233f9aff2d8ed7e05dafdfbdb44d7c4e735fef56b5ad6b35ad6b5b, q), q);
        o.t19 = addmod(o.t19, mulmod(i.t19, 0x03ae25d1e0d02c9cb46b7cb30c7f0aebda060534ebaead96514514513cf3cf3d, q), q);
        o.t19 = addmod(o.t19, mulmod(i.t20, 0x721df0b5dcf70753126cf0a7e97b50a53e6ead72f3fe628f03ffffff04000001, q), q);
        o.t19 = addmod(o.t19, mulmod(i.t21, 0x705c7ebaf1323e59abbdf8c4d622c58f0265190eb919faa4723723713f03f040, q), q);
        o.t19 = addmod(o.t19, mulmod(i.t22, 0x722bfe0072ae7f433a3516b2951f64434e97dbb560f6a06b9f07c1ef80000001, q), q);
        o.t19 = addmod(o.t19, mulmod(i.t23, 0x46f0f3c415a52674c77774ea2c1a71165d4632b198d4f75744c6afc240f4898e, q), q);
        o.t19 = addmod(o.t19, mulmod(i.t24, 0x5dc3fc0acb123463cf146ebb34f79be630e871d53ffeac4a7c3c3c3b6d2d2d2e, q), q);

        o.t20 = 0;
        o.t20 = addmod(o.t20, mulmod(i.t0, 0x61e5213528d4a2aebf2b28344c6688e80dd3574c7d266fd1a4fa4fa422222223, q), q);
        o.t20 = addmod(o.t20, mulmod(i.t1, 0x6c5e278af4d06f8bd6d77676d15a1247c32624721bd1f1d28b21642b9642c85a, q), q);
        o.t20 = addmod(o.t20, mulmod(i.t2, 0x0766517d23564ece23f35a0b681aabbefa739815fa8d8326105726209df51b3c, q), q);
        o.t20 = addmod(o.t20, mulmod(i.t3, 0x71835e816e14e0015cd34e32896e78da8ca9b0984553ba145aaaaaa9b0000001, q), q);
        o.t20 = addmod(o.t20, mulmod(i.t4, 0x5789a824ac7c25219ed8161084a93aa0c1d857462f03fc52d6343eb0e0a72f06, q), q);
        o.t20 = addmod(o.t20, mulmod(i.t5, 0x3553b87d4b76866e03157cf9751220cf401eea2a57097c3cfae147ad9eb851ec, q), q);
        o.t20 = addmod(o.t20, mulmod(i.t6, 0x5660c2f2ab8e716d0307f64c436987dbcff6b670aaa971b8fafafafa3c3c3c3d, q), q);
        o.t20 = addmod(o.t20, mulmod(i.t7, 0x1885f71683e150a7e3739eee02099eed6f40bb4f67621d4e8ec4ec4e8ec4ec4f, q), q);
        o.t20 = addmod(o.t20, mulmod(i.t8, 0x3f6eb7542542da4951294f907931ea1fe55e1af326a354261826a4396a439f66, q), q);
        o.t20 = addmod(o.t20, mulmod(i.t9, 0x3e41ffc91b16f2b0416fa82a3e0fce15d2e5d81492f5a32eded097b39c71c71d, q), q);
        o.t20 = addmod(o.t20, mulmod(i.t10, 0x5aa28778df5f3366fe28919fe24b551b7003f93edac2354e586fb58633333334, q), q);
        o.t20 = addmod(o.t20, mulmod(i.t11, 0x2f9d094b4c85412b5e2e9d4c71ab9d4b54ade35ca923e5c8bb6db6db04924925, q), q);
        o.t20 = addmod(o.t20, mulmod(i.t12, 0x71e4fe36c1963c34f7f0f82bd39187e14dc7c98e2ce7ee97b823ee0800000001, q), q);
        o.t20 = addmod(o.t20, mulmod(i.t13, 0x35f7759de2d2244081c710b44b1aca142291a90a396056f6b4f72c22d8469ee6, q), q);
        o.t20 = addmod(o.t20, mulmod(i.t14, 0x5c59854aed155271ec0fb4c5516f920cebedd96edd4874acc34115b11a08ad90, q), q);
        o.t20 = addmod(o.t20, mulmod(i.t15, 0x2c706f1314381ab10291e82536e470acb56f18789ddd3cdd7bbbbbbb5999999a, q), q);
        o.t20 = addmod(o.t20, mulmod(i.t16, 0x4deb467f3d8b6d62e37ad026f9e249d99d018fcfa7dd52d129f79b46ac10c972, q), q);
        o.t20 = addmod(o.t20, mulmod(i.t17, 0x10d40be6e9233f9aff2d8ed7e05dafdfbdb44d7c4e735fef56b5ad6b35ad6b5b, q), q);
        o.t20 = addmod(o.t20, mulmod(i.t18, 0x03ae25d1e0d02c9cb46b7cb30c7f0aebda060534ebaead96514514513cf3cf3d, q), q);
        o.t20 = addmod(o.t20, mulmod(i.t19, 0x721df0b5dcf70753126cf0a7e97b50a53e6ead72f3fe628f03ffffff04000001, q), q);
        o.t20 = addmod(o.t20, mulmod(i.t20, 0x705c7ebaf1323e59abbdf8c4d622c58f0265190eb919faa4723723713f03f040, q), q);
        o.t20 = addmod(o.t20, mulmod(i.t21, 0x722bfe0072ae7f433a3516b2951f64434e97dbb560f6a06b9f07c1ef80000001, q), q);
        o.t20 = addmod(o.t20, mulmod(i.t22, 0x46f0f3c415a52674c77774ea2c1a71165d4632b198d4f75744c6afc240f4898e, q), q);
        o.t20 = addmod(o.t20, mulmod(i.t23, 0x5dc3fc0acb123463cf146ebb34f79be630e871d53ffeac4a7c3c3c3b6d2d2d2e, q), q);
        o.t20 = addmod(o.t20, mulmod(i.t24, 0x219a37eb955675efd37c5c4c885b6ed8bb84e1a067e1d7e2076b981d642c8591, q), q);

        o.t21 = 0;
        o.t21 = addmod(o.t21, mulmod(i.t0, 0x6c5e278af4d06f8bd6d77676d15a1247c32624721bd1f1d28b21642b9642c85a, q), q);
        o.t21 = addmod(o.t21, mulmod(i.t1, 0x0766517d23564ece23f35a0b681aabbefa739815fa8d8326105726209df51b3c, q), q);
        o.t21 = addmod(o.t21, mulmod(i.t2, 0x71835e816e14e0015cd34e32896e78da8ca9b0984553ba145aaaaaa9b0000001, q), q);
        o.t21 = addmod(o.t21, mulmod(i.t3, 0x5789a824ac7c25219ed8161084a93aa0c1d857462f03fc52d6343eb0e0a72f06, q), q);
        o.t21 = addmod(o.t21, mulmod(i.t4, 0x3553b87d4b76866e03157cf9751220cf401eea2a57097c3cfae147ad9eb851ec, q), q);
        o.t21 = addmod(o.t21, mulmod(i.t5, 0x5660c2f2ab8e716d0307f64c436987dbcff6b670aaa971b8fafafafa3c3c3c3d, q), q);
        o.t21 = addmod(o.t21, mulmod(i.t6, 0x1885f71683e150a7e3739eee02099eed6f40bb4f67621d4e8ec4ec4e8ec4ec4f, q), q);
        o.t21 = addmod(o.t21, mulmod(i.t7, 0x3f6eb7542542da4951294f907931ea1fe55e1af326a354261826a4396a439f66, q), q);
        o.t21 = addmod(o.t21, mulmod(i.t8, 0x3e41ffc91b16f2b0416fa82a3e0fce15d2e5d81492f5a32eded097b39c71c71d, q), q);
        o.t21 = addmod(o.t21, mulmod(i.t9, 0x5aa28778df5f3366fe28919fe24b551b7003f93edac2354e586fb58633333334, q), q);
        o.t21 = addmod(o.t21, mulmod(i.t10, 0x2f9d094b4c85412b5e2e9d4c71ab9d4b54ade35ca923e5c8bb6db6db04924925, q), q);
        o.t21 = addmod(o.t21, mulmod(i.t11, 0x71e4fe36c1963c34f7f0f82bd39187e14dc7c98e2ce7ee97b823ee0800000001, q), q);
        o.t21 = addmod(o.t21, mulmod(i.t12, 0x35f7759de2d2244081c710b44b1aca142291a90a396056f6b4f72c22d8469ee6, q), q);
        o.t21 = addmod(o.t21, mulmod(i.t13, 0x5c59854aed155271ec0fb4c5516f920cebedd96edd4874acc34115b11a08ad90, q), q);
        o.t21 = addmod(o.t21, mulmod(i.t14, 0x2c706f1314381ab10291e82536e470acb56f18789ddd3cdd7bbbbbbb5999999a, q), q);
        o.t21 = addmod(o.t21, mulmod(i.t15, 0x4deb467f3d8b6d62e37ad026f9e249d99d018fcfa7dd52d129f79b46ac10c972, q), q);
        o.t21 = addmod(o.t21, mulmod(i.t16, 0x10d40be6e9233f9aff2d8ed7e05dafdfbdb44d7c4e735fef56b5ad6b35ad6b5b, q), q);
        o.t21 = addmod(o.t21, mulmod(i.t17, 0x03ae25d1e0d02c9cb46b7cb30c7f0aebda060534ebaead96514514513cf3cf3d, q), q);
        o.t21 = addmod(o.t21, mulmod(i.t18, 0x721df0b5dcf70753126cf0a7e97b50a53e6ead72f3fe628f03ffffff04000001, q), q);
        o.t21 = addmod(o.t21, mulmod(i.t19, 0x705c7ebaf1323e59abbdf8c4d622c58f0265190eb919faa4723723713f03f040, q), q);
        o.t21 = addmod(o.t21, mulmod(i.t20, 0x722bfe0072ae7f433a3516b2951f64434e97dbb560f6a06b9f07c1ef80000001, q), q);
        o.t21 = addmod(o.t21, mulmod(i.t21, 0x46f0f3c415a52674c77774ea2c1a71165d4632b198d4f75744c6afc240f4898e, q), q);
        o.t21 = addmod(o.t21, mulmod(i.t22, 0x5dc3fc0acb123463cf146ebb34f79be630e871d53ffeac4a7c3c3c3b6d2d2d2e, q), q);
        o.t21 = addmod(o.t21, mulmod(i.t23, 0x219a37eb955675efd37c5c4c885b6ed8bb84e1a067e1d7e2076b981d642c8591, q), q);
        o.t21 = addmod(o.t21, mulmod(i.t24, 0x26173aa2a39dcdbc4b587dd6c156176f76f182b0874feb06fc57c57c03a83a84, q), q);

        o.t22 = 0;
        o.t22 = addmod(o.t22, mulmod(i.t0, 0x0766517d23564ece23f35a0b681aabbefa739815fa8d8326105726209df51b3c, q), q);
        o.t22 = addmod(o.t22, mulmod(i.t1, 0x71835e816e14e0015cd34e32896e78da8ca9b0984553ba145aaaaaa9b0000001, q), q);
        o.t22 = addmod(o.t22, mulmod(i.t2, 0x5789a824ac7c25219ed8161084a93aa0c1d857462f03fc52d6343eb0e0a72f06, q), q);
        o.t22 = addmod(o.t22, mulmod(i.t3, 0x3553b87d4b76866e03157cf9751220cf401eea2a57097c3cfae147ad9eb851ec, q), q);
        o.t22 = addmod(o.t22, mulmod(i.t4, 0x5660c2f2ab8e716d0307f64c436987dbcff6b670aaa971b8fafafafa3c3c3c3d, q), q);
        o.t22 = addmod(o.t22, mulmod(i.t5, 0x1885f71683e150a7e3739eee02099eed6f40bb4f67621d4e8ec4ec4e8ec4ec4f, q), q);
        o.t22 = addmod(o.t22, mulmod(i.t6, 0x3f6eb7542542da4951294f907931ea1fe55e1af326a354261826a4396a439f66, q), q);
        o.t22 = addmod(o.t22, mulmod(i.t7, 0x3e41ffc91b16f2b0416fa82a3e0fce15d2e5d81492f5a32eded097b39c71c71d, q), q);
        o.t22 = addmod(o.t22, mulmod(i.t8, 0x5aa28778df5f3366fe28919fe24b551b7003f93edac2354e586fb58633333334, q), q);
        o.t22 = addmod(o.t22, mulmod(i.t9, 0x2f9d094b4c85412b5e2e9d4c71ab9d4b54ade35ca923e5c8bb6db6db04924925, q), q);
        o.t22 = addmod(o.t22, mulmod(i.t10, 0x71e4fe36c1963c34f7f0f82bd39187e14dc7c98e2ce7ee97b823ee0800000001, q), q);
        o.t22 = addmod(o.t22, mulmod(i.t11, 0x35f7759de2d2244081c710b44b1aca142291a90a396056f6b4f72c22d8469ee6, q), q);
        o.t22 = addmod(o.t22, mulmod(i.t12, 0x5c59854aed155271ec0fb4c5516f920cebedd96edd4874acc34115b11a08ad90, q), q);
        o.t22 = addmod(o.t22, mulmod(i.t13, 0x2c706f1314381ab10291e82536e470acb56f18789ddd3cdd7bbbbbbb5999999a, q), q);
        o.t22 = addmod(o.t22, mulmod(i.t14, 0x4deb467f3d8b6d62e37ad026f9e249d99d018fcfa7dd52d129f79b46ac10c972, q), q);
        o.t22 = addmod(o.t22, mulmod(i.t15, 0x10d40be6e9233f9aff2d8ed7e05dafdfbdb44d7c4e735fef56b5ad6b35ad6b5b, q), q);
        o.t22 = addmod(o.t22, mulmod(i.t16, 0x03ae25d1e0d02c9cb46b7cb30c7f0aebda060534ebaead96514514513cf3cf3d, q), q);
        o.t22 = addmod(o.t22, mulmod(i.t17, 0x721df0b5dcf70753126cf0a7e97b50a53e6ead72f3fe628f03ffffff04000001, q), q);
        o.t22 = addmod(o.t22, mulmod(i.t18, 0x705c7ebaf1323e59abbdf8c4d622c58f0265190eb919faa4723723713f03f040, q), q);
        o.t22 = addmod(o.t22, mulmod(i.t19, 0x722bfe0072ae7f433a3516b2951f64434e97dbb560f6a06b9f07c1ef80000001, q), q);
        o.t22 = addmod(o.t22, mulmod(i.t20, 0x46f0f3c415a52674c77774ea2c1a71165d4632b198d4f75744c6afc240f4898e, q), q);
        o.t22 = addmod(o.t22, mulmod(i.t21, 0x5dc3fc0acb123463cf146ebb34f79be630e871d53ffeac4a7c3c3c3b6d2d2d2e, q), q);
        o.t22 = addmod(o.t22, mulmod(i.t22, 0x219a37eb955675efd37c5c4c885b6ed8bb84e1a067e1d7e2076b981d642c8591, q), q);
        o.t22 = addmod(o.t22, mulmod(i.t23, 0x26173aa2a39dcdbc4b587dd6c156176f76f182b0874feb06fc57c57c03a83a84, q), q);
        o.t22 = addmod(o.t22, mulmod(i.t24, 0x414fce0acbba141a40ea80eb49ef02b7486ad6fe15a154478c9ea5db615a240f, q), q);

        o.t23 = 0;
        o.t23 = addmod(o.t23, mulmod(i.t0, 0x71835e816e14e0015cd34e32896e78da8ca9b0984553ba145aaaaaa9b0000001, q), q);
        o.t23 = addmod(o.t23, mulmod(i.t1, 0x5789a824ac7c25219ed8161084a93aa0c1d857462f03fc52d6343eb0e0a72f06, q), q);
        o.t23 = addmod(o.t23, mulmod(i.t2, 0x3553b87d4b76866e03157cf9751220cf401eea2a57097c3cfae147ad9eb851ec, q), q);
        o.t23 = addmod(o.t23, mulmod(i.t3, 0x5660c2f2ab8e716d0307f64c436987dbcff6b670aaa971b8fafafafa3c3c3c3d, q), q);
        o.t23 = addmod(o.t23, mulmod(i.t4, 0x1885f71683e150a7e3739eee02099eed6f40bb4f67621d4e8ec4ec4e8ec4ec4f, q), q);
        o.t23 = addmod(o.t23, mulmod(i.t5, 0x3f6eb7542542da4951294f907931ea1fe55e1af326a354261826a4396a439f66, q), q);
        o.t23 = addmod(o.t23, mulmod(i.t6, 0x3e41ffc91b16f2b0416fa82a3e0fce15d2e5d81492f5a32eded097b39c71c71d, q), q);
        o.t23 = addmod(o.t23, mulmod(i.t7, 0x5aa28778df5f3366fe28919fe24b551b7003f93edac2354e586fb58633333334, q), q);
        o.t23 = addmod(o.t23, mulmod(i.t8, 0x2f9d094b4c85412b5e2e9d4c71ab9d4b54ade35ca923e5c8bb6db6db04924925, q), q);
        o.t23 = addmod(o.t23, mulmod(i.t9, 0x71e4fe36c1963c34f7f0f82bd39187e14dc7c98e2ce7ee97b823ee0800000001, q), q);
        o.t23 = addmod(o.t23, mulmod(i.t10, 0x35f7759de2d2244081c710b44b1aca142291a90a396056f6b4f72c22d8469ee6, q), q);
        o.t23 = addmod(o.t23, mulmod(i.t11, 0x5c59854aed155271ec0fb4c5516f920cebedd96edd4874acc34115b11a08ad90, q), q);
        o.t23 = addmod(o.t23, mulmod(i.t12, 0x2c706f1314381ab10291e82536e470acb56f18789ddd3cdd7bbbbbbb5999999a, q), q);
        o.t23 = addmod(o.t23, mulmod(i.t13, 0x4deb467f3d8b6d62e37ad026f9e249d99d018fcfa7dd52d129f79b46ac10c972, q), q);
        o.t23 = addmod(o.t23, mulmod(i.t14, 0x10d40be6e9233f9aff2d8ed7e05dafdfbdb44d7c4e735fef56b5ad6b35ad6b5b, q), q);
        o.t23 = addmod(o.t23, mulmod(i.t15, 0x03ae25d1e0d02c9cb46b7cb30c7f0aebda060534ebaead96514514513cf3cf3d, q), q);
        o.t23 = addmod(o.t23, mulmod(i.t16, 0x721df0b5dcf70753126cf0a7e97b50a53e6ead72f3fe628f03ffffff04000001, q), q);
        o.t23 = addmod(o.t23, mulmod(i.t17, 0x705c7ebaf1323e59abbdf8c4d622c58f0265190eb919faa4723723713f03f040, q), q);
        o.t23 = addmod(o.t23, mulmod(i.t18, 0x722bfe0072ae7f433a3516b2951f64434e97dbb560f6a06b9f07c1ef80000001, q), q);
        o.t23 = addmod(o.t23, mulmod(i.t19, 0x46f0f3c415a52674c77774ea2c1a71165d4632b198d4f75744c6afc240f4898e, q), q);
        o.t23 = addmod(o.t23, mulmod(i.t20, 0x5dc3fc0acb123463cf146ebb34f79be630e871d53ffeac4a7c3c3c3b6d2d2d2e, q), q);
        o.t23 = addmod(o.t23, mulmod(i.t21, 0x219a37eb955675efd37c5c4c885b6ed8bb84e1a067e1d7e2076b981d642c8591, q), q);
        o.t23 = addmod(o.t23, mulmod(i.t22, 0x26173aa2a39dcdbc4b587dd6c156176f76f182b0874feb06fc57c57c03a83a84, q), q);
        o.t23 = addmod(o.t23, mulmod(i.t23, 0x414fce0acbba141a40ea80eb49ef02b7486ad6fe15a154478c9ea5db615a240f, q), q);
        o.t23 = addmod(o.t23, mulmod(i.t24, 0x4bace9ab9eb895563de23421b0f45091b31bcb102e37d162e71c71c675555556, q), q);

        o.t24 = 0;
        o.t24 = addmod(o.t24, mulmod(i.t0, 0x5789a824ac7c25219ed8161084a93aa0c1d857462f03fc52d6343eb0e0a72f06, q), q);
        o.t24 = addmod(o.t24, mulmod(i.t1, 0x3553b87d4b76866e03157cf9751220cf401eea2a57097c3cfae147ad9eb851ec, q), q);
        o.t24 = addmod(o.t24, mulmod(i.t2, 0x5660c2f2ab8e716d0307f64c436987dbcff6b670aaa971b8fafafafa3c3c3c3d, q), q);
        o.t24 = addmod(o.t24, mulmod(i.t3, 0x1885f71683e150a7e3739eee02099eed6f40bb4f67621d4e8ec4ec4e8ec4ec4f, q), q);
        o.t24 = addmod(o.t24, mulmod(i.t4, 0x3f6eb7542542da4951294f907931ea1fe55e1af326a354261826a4396a439f66, q), q);
        o.t24 = addmod(o.t24, mulmod(i.t5, 0x3e41ffc91b16f2b0416fa82a3e0fce15d2e5d81492f5a32eded097b39c71c71d, q), q);
        o.t24 = addmod(o.t24, mulmod(i.t6, 0x5aa28778df5f3366fe28919fe24b551b7003f93edac2354e586fb58633333334, q), q);
        o.t24 = addmod(o.t24, mulmod(i.t7, 0x2f9d094b4c85412b5e2e9d4c71ab9d4b54ade35ca923e5c8bb6db6db04924925, q), q);
        o.t24 = addmod(o.t24, mulmod(i.t8, 0x71e4fe36c1963c34f7f0f82bd39187e14dc7c98e2ce7ee97b823ee0800000001, q), q);
        o.t24 = addmod(o.t24, mulmod(i.t9, 0x35f7759de2d2244081c710b44b1aca142291a90a396056f6b4f72c22d8469ee6, q), q);
        o.t24 = addmod(o.t24, mulmod(i.t10, 0x5c59854aed155271ec0fb4c5516f920cebedd96edd4874acc34115b11a08ad90, q), q);
        o.t24 = addmod(o.t24, mulmod(i.t11, 0x2c706f1314381ab10291e82536e470acb56f18789ddd3cdd7bbbbbbb5999999a, q), q);
        o.t24 = addmod(o.t24, mulmod(i.t12, 0x4deb467f3d8b6d62e37ad026f9e249d99d018fcfa7dd52d129f79b46ac10c972, q), q);
        o.t24 = addmod(o.t24, mulmod(i.t13, 0x10d40be6e9233f9aff2d8ed7e05dafdfbdb44d7c4e735fef56b5ad6b35ad6b5b, q), q);
        o.t24 = addmod(o.t24, mulmod(i.t14, 0x03ae25d1e0d02c9cb46b7cb30c7f0aebda060534ebaead96514514513cf3cf3d, q), q);
        o.t24 = addmod(o.t24, mulmod(i.t15, 0x721df0b5dcf70753126cf0a7e97b50a53e6ead72f3fe628f03ffffff04000001, q), q);
        o.t24 = addmod(o.t24, mulmod(i.t16, 0x705c7ebaf1323e59abbdf8c4d622c58f0265190eb919faa4723723713f03f040, q), q);
        o.t24 = addmod(o.t24, mulmod(i.t17, 0x722bfe0072ae7f433a3516b2951f64434e97dbb560f6a06b9f07c1ef80000001, q), q);
        o.t24 = addmod(o.t24, mulmod(i.t18, 0x46f0f3c415a52674c77774ea2c1a71165d4632b198d4f75744c6afc240f4898e, q), q);
        o.t24 = addmod(o.t24, mulmod(i.t19, 0x5dc3fc0acb123463cf146ebb34f79be630e871d53ffeac4a7c3c3c3b6d2d2d2e, q), q);
        o.t24 = addmod(o.t24, mulmod(i.t20, 0x219a37eb955675efd37c5c4c885b6ed8bb84e1a067e1d7e2076b981d642c8591, q), q);
        o.t24 = addmod(o.t24, mulmod(i.t21, 0x26173aa2a39dcdbc4b587dd6c156176f76f182b0874feb06fc57c57c03a83a84, q), q);
        o.t24 = addmod(o.t24, mulmod(i.t22, 0x414fce0acbba141a40ea80eb49ef02b7486ad6fe15a154478c9ea5db615a240f, q), q);
        o.t24 = addmod(o.t24, mulmod(i.t23, 0x4bace9ab9eb895563de23421b0f45091b31bcb102e37d162e71c71c675555556, q), q);
        o.t24 = addmod(o.t24, mulmod(i.t24, 0x261d096bffa780dc1ede6a17af009b2f5725ccb757ab4bd596cb65b28542a151, q), q);

        i.t0 = o.t0;
        i.t1 = o.t1;
        i.t2 = o.t2;
        i.t3 = o.t3;
        i.t4 = o.t4;
        i.t5 = o.t5;
        i.t6 = o.t6;
        i.t7 = o.t7;
        i.t8 = o.t8;
        i.t9 = o.t9;
        i.t10 = o.t10;
        i.t11 = o.t11;
        i.t12 = o.t12;
        i.t13 = o.t13;
        i.t14 = o.t14;
        i.t15 = o.t15;
        i.t16 = o.t16;
        i.t17 = o.t17;
        i.t18 = o.t18;
        i.t19 = o.t19;
        i.t20 = o.t20;
        i.t21 = o.t21;
        i.t22 = o.t22;
        i.t23 = o.t23;
        i.t24 = o.t24;
    }

    function ark(HashInputs25 memory i, uint q, HashInputs25 memory c) internal pure
    {
        HashInputs25 memory o;

        o.t0 = addmod(i.t0, c.t0, q);
        o.t1 = addmod(i.t1, c.t1, q);
        o.t2 = addmod(i.t2, c.t2, q);
        o.t3 = addmod(i.t3, c.t3, q);
        o.t4 = addmod(i.t4, c.t4, q);
        o.t5 = addmod(i.t5, c.t5, q);
        o.t6 = addmod(i.t6, c.t6, q);
        o.t7 = addmod(i.t7, c.t7, q);
        o.t8 = addmod(i.t8, c.t8, q);
        o.t9 = addmod(i.t9, c.t9, q);
        o.t10 = addmod(i.t10, c.t10, q);
        o.t11 = addmod(i.t11, c.t11, q);
        o.t12 = addmod(i.t12, c.t12, q);
        o.t13 = addmod(i.t13, c.t13, q);
        o.t14 = addmod(i.t14, c.t14, q);
        o.t15 = addmod(i.t15, c.t15, q);
        o.t16 = addmod(i.t16, c.t16, q);
        o.t17 = addmod(i.t17, c.t17, q);
        o.t18 = addmod(i.t18, c.t18, q);
        o.t19 = addmod(i.t19, c.t19, q);
        o.t20 = addmod(i.t20, c.t20, q);
        o.t21 = addmod(i.t21, c.t21, q);
        o.t22 = addmod(i.t22, c.t22, q);
        o.t23 = addmod(i.t23, c.t23, q);
        o.t24 = addmod(i.t24, c.t24, q);

        i.t0 = o.t0;
        i.t1 = o.t1;
        i.t2 = o.t2;
        i.t3 = o.t3;
        i.t4 = o.t4;
        i.t5 = o.t5;
        i.t6 = o.t6;
        i.t7 = o.t7;
        i.t8 = o.t8;
        i.t9 = o.t9;
        i.t10 = o.t10;
        i.t11 = o.t11;
        i.t12 = o.t12;
        i.t13 = o.t13;
        i.t14 = o.t14;
        i.t15 = o.t15;
        i.t16 = o.t16;
        i.t17 = o.t17;
        i.t18 = o.t18;
        i.t19 = o.t19;
        i.t20 = o.t20;
        i.t21 = o.t21;
        i.t22 = o.t22;
        i.t23 = o.t23;
        i.t24 = o.t24;
    }

    function sbox_full(HashInputs25 memory i, uint q) internal pure
    {
        HashInputs25 memory o;

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
        o.t7 = mulmod(i.t7, i.t7, q);
        o.t7 = mulmod(o.t7, o.t7, q);
        o.t7 = mulmod(i.t7, o.t7, q);
        o.t8 = mulmod(i.t8, i.t8, q);
        o.t8 = mulmod(o.t8, o.t8, q);
        o.t8 = mulmod(i.t8, o.t8, q);
        o.t9 = mulmod(i.t9, i.t9, q);
        o.t9 = mulmod(o.t9, o.t9, q);
        o.t9 = mulmod(i.t9, o.t9, q);
        o.t10 = mulmod(i.t10, i.t10, q);
        o.t10 = mulmod(o.t10, o.t10, q);
        o.t10 = mulmod(i.t10, o.t10, q);
        o.t11 = mulmod(i.t11, i.t11, q);
        o.t11 = mulmod(o.t11, o.t11, q);
        o.t11 = mulmod(i.t11, o.t11, q);
        o.t12 = mulmod(i.t12, i.t12, q);
        o.t12 = mulmod(o.t12, o.t12, q);
        o.t12 = mulmod(i.t12, o.t12, q);
        o.t13 = mulmod(i.t13, i.t13, q);
        o.t13 = mulmod(o.t13, o.t13, q);
        o.t13 = mulmod(i.t13, o.t13, q);
        o.t14 = mulmod(i.t14, i.t14, q);
        o.t14 = mulmod(o.t14, o.t14, q);
        o.t14 = mulmod(i.t14, o.t14, q);
        o.t15 = mulmod(i.t15, i.t15, q);
        o.t15 = mulmod(o.t15, o.t15, q);
        o.t15 = mulmod(i.t15, o.t15, q);
        o.t16 = mulmod(i.t16, i.t16, q);
        o.t16 = mulmod(o.t16, o.t16, q);
        o.t16 = mulmod(i.t16, o.t16, q);
        o.t17 = mulmod(i.t17, i.t17, q);
        o.t17 = mulmod(o.t17, o.t17, q);
        o.t17 = mulmod(i.t17, o.t17, q);
        o.t18 = mulmod(i.t18, i.t18, q);
        o.t18 = mulmod(o.t18, o.t18, q);
        o.t18 = mulmod(i.t18, o.t18, q);
        o.t19 = mulmod(i.t19, i.t19, q);
        o.t19 = mulmod(o.t19, o.t19, q);
        o.t19 = mulmod(i.t19, o.t19, q);
        o.t20 = mulmod(i.t20, i.t20, q);
        o.t20 = mulmod(o.t20, o.t20, q);
        o.t20 = mulmod(i.t20, o.t20, q);
        o.t21 = mulmod(i.t21, i.t21, q);
        o.t21 = mulmod(o.t21, o.t21, q);
        o.t21 = mulmod(i.t21, o.t21, q);
        o.t22 = mulmod(i.t22, i.t22, q);
        o.t22 = mulmod(o.t22, o.t22, q);
        o.t22 = mulmod(i.t22, o.t22, q);
        o.t23 = mulmod(i.t23, i.t23, q);
        o.t23 = mulmod(o.t23, o.t23, q);
        o.t23 = mulmod(i.t23, o.t23, q);
        o.t24 = mulmod(i.t24, i.t24, q);
        o.t24 = mulmod(o.t24, o.t24, q);
        o.t24 = mulmod(i.t24, o.t24, q);

        i.t0 = o.t0;
        i.t1 = o.t1;
        i.t2 = o.t2;
        i.t3 = o.t3;
        i.t4 = o.t4;
        i.t5 = o.t5;
        i.t6 = o.t6;
        i.t7 = o.t7;
        i.t8 = o.t8;
        i.t9 = o.t9;
        i.t10 = o.t10;
        i.t11 = o.t11;
        i.t12 = o.t12;
        i.t13 = o.t13;
        i.t14 = o.t14;
        i.t15 = o.t15;
        i.t16 = o.t16;
        i.t17 = o.t17;
        i.t18 = o.t18;
        i.t19 = o.t19;
        i.t20 = o.t20;
        i.t21 = o.t21;
        i.t22 = o.t22;
        i.t23 = o.t23;
        i.t24 = o.t24;
    }

    function sbox_partial(HashInputs25 memory i, uint q) internal pure
    {
        HashInputs25 memory o;

        o.t0 = mulmod(i.t0, i.t0, q);
        o.t0 = mulmod(o.t0, o.t0, q);
        o.t0 = mulmod(i.t0, o.t0, q);

        i.t0 = o.t0;
    }

    function hash(HashInputs25 memory i, uint q) internal pure returns (uint)
    {
        // validate inputs
        require(i.t0 < q, "INVALID_INPUT");
        require(i.t1 < q, "INVALID_INPUT");
        require(i.t2 < q, "INVALID_INPUT");
        require(i.t3 < q, "INVALID_INPUT");
        require(i.t4 < q, "INVALID_INPUT");
        require(i.t5 < q, "INVALID_INPUT");
        require(i.t6 < q, "INVALID_INPUT");
        require(i.t7 < q, "INVALID_INPUT");
        require(i.t8 < q, "INVALID_INPUT");
        require(i.t9 < q, "INVALID_INPUT");
        require(i.t10 < q, "INVALID_INPUT");
        require(i.t11 < q, "INVALID_INPUT");
        require(i.t12 < q, "INVALID_INPUT");
        require(i.t13 < q, "INVALID_INPUT");
        require(i.t14 < q, "INVALID_INPUT");
        require(i.t15 < q, "INVALID_INPUT");
        require(i.t16 < q, "INVALID_INPUT");
        require(i.t17 < q, "INVALID_INPUT");
        require(i.t18 < q, "INVALID_INPUT");
        require(i.t19 < q, "INVALID_INPUT");
        require(i.t20 < q, "INVALID_INPUT");
        require(i.t21 < q, "INVALID_INPUT");
        require(i.t22 < q, "INVALID_INPUT");
        require(i.t23 < q, "INVALID_INPUT");
        require(i.t24 < q, "INVALID_INPUT");

        // round 0
        ark(i, q, HashInputs25(0x2c21df040fb486eda5e1b307392ad7917e2ae2eff450fd49a0f58b056dceb6b1,
            0x06dd0930c41e65275f824307c57550b7712f02affcc2b202ff65458152f81e5b,
            0x53f66db5a1fe1d564904d554a3797dd9137f5cb6992a3b4155c5d42551de4918,
            0x0f86feed14cf5ca45e38f023fe7d21bfeedab7cbc8ff68a194eb462acb868fed,
            0x04e38ddcaf70374cd798d71b838412f3b685c12d0b8567ff1a849694626c0136,
            0x3137015ea0699e21dc15eaea588aa6476babfff62c69a648930d6f599dbfd98a,
            0x27b4ee7fcad7373eaf24dcc0d5ca838d5b2b67ffcc30320f913aba0099ba23b4,
            0x0b25d3b8417075fe6fa1819f8252912b7cc2642c72e225dc6c3e59eb1014cb39,
            0x1077a74d28bec60bbcebb879ed8778209a314827fdcbb838cf5fa396844cc744,
            0x3020f64d9081ab756563512341a3cad5f74fbc0635421032ad15e8b0592d8f07,
            0x5f8b3aa4ba893d608ab12143177cc0334df8a117ec3e545edfb7468f4a25d758,
            0x3bb4d029a81d20c6c79f657b080d30f65ecd31d3ed47c963709364dceb5491ee,
            0x5f26741b26a7f4b450be748b9c478953f79baa978102cefb2cca14d7ced176cc,
            0x486bcae25a107b5fed76e3004791c91069a2e6a2c5178ff36cccd61dd9e99036,
            0x4c1a382c02dd744b325e3b6838f22d9d242dba5d9ef831c8b8a105c8a4010b07,
            0x3446e2e18ae8f55e4e51e1f8dcc93a0733dc01d37c68ff39773e6f18024953e2,
            0x5ff235de7b049336f5355eff913e5554eac1691c9e99a784b5c1d529fea49358,
            0x49abe43d1d110053ce808d378edef51acefdee908f9097ed32d6ffdd38de46af,
            0x20193dec48c8686b543bb3561193df86675a449f01dc1daced860373f3b0ca07,
            0x38767b551e6ab98296fb149d39792dc00ff333ab99562a5f5859cffd00f4127e,
            0x53a43523f7e48ef3e7b0fa466fdbfecaf20242922215ba2cc94f9b0f6f17cbd8,
            0x22e00037b03a4bff29c042f5d5a5f66220f0296895d6699250b8820ba904e947,
            0x2340cc0dc53743a48dae0f62420598c543b1ccd9b06885ab90c5bee68697de4f,
            0x6cdd221959e2332221ead4edcd20482ba4305948f71af2d64b935041083afab5,
            0x5536e9cfe26304a56a572af2cb91a9111bffaa5c07269eff7ce5d7df2fde8a48)
        );
        sbox_full(i, q);
        mix(i, q);
        // round 1
        ark(i, q, HashInputs25(0x0912c078ff3316f34d17e8fd81dff91e754d03f2e71c2fc0077c8011a4c0a43b,
            0x5a60690eb4b4af3aba51091dbebe996c3eee2a9f59f66d4f1bcdde47b419bdda,
            0x1befc1dc02a5153ccf17fa1fedce0e141a5639414d37190d03315d1a93376874,
            0x67ecbad6a6cf79e18919ea2fcfec686f4be7f5f38d7be7a6e844194ababad95c,
            0x59bb13df8c45849d349a81ebb81831d3121e7824af230b3740dfaf35da771fe0,
            0x2da148454a1783e8da2944df41c285ba76426d7dbee627d1c17af160d1bcce01,
            0x4248ade055b8c522430335ff0410775a9c041d0e38b57ea97fbd3ef65592a911,
            0x73208ef6bae5e9d7f6b91668ec8d3ecf7807c2eb0899f304bb70ebd7552205ac,
            0x1bc7f3d8f64effde6c9cfac1fcabf471d443ab4106c85c3d7f0e671eba1ac20f,
            0x4a1fa4df9ba64bf3c2d964695628a615367e168b8d53ffc8c7f767331a2629a2,
            0x4338bdd6c8549ba60311222d7cdd51556997d2d4338ff680c8bdda96e07f0c64,
            0x3d5a6dc890f4fecf6d3a9960ffc6d6754a5dbf88a0250e3358aa40ce63382ae0,
            0x1f569abd6fc91f4a5e009ae3d8a6d0170ec74c986ef91d34299681e90aac79b3,
            0x233e1bf16944f2889c616777c1b072202e42b7b216b8d4c9973157ecea58487a,
            0x091c5fd8c64a3fa466d33c38303cfb0f07c141e4a8848ef899fb91385d62eaba,
            0x71287e609a3cca3e519ef1a58d39bc87edee193d278460f4e151988e86be8a86,
            0x4eb1dac3e550a6d5c506464b984eab0f6f04afcaf52a045d52ce16262dddeea8,
            0x3bdac8c3cda0b615c6f58c0d16ed58b8cf349b69f101925881f8b62d1fe6ca91,
            0x512770e3ebb8c65b6784380c8695fe54d609afa35538abc848a7aac832fe7752,
            0x02d9fc7d215eab28d1fb7c066fb9cb0c590ea899c10b3bd7a94394a732a23584,
            0x66988a2e7b962fb02ef6deb05dda7a65f63f844122b140bc141a3f69e0250c1a,
            0x22afb7a9642afa2cface51c836c3b70748e6d2384582e184bae3a041618648fc,
            0x2276b834efd2e34d8339382811d676bae26a3dfade4e7ce53421a39d463dc06f,
            0x2568575a2cbdb467a6b0cf1c64bfd26284a29561bd29ac16d598c11ecf8d9792,
            0x2b2e6665e91fe716f7a89090f431162d8f97e24da595d0d19bae85de9756d110)
        );
        sbox_full(i, q);
        mix(i, q);
        // round 2
        ark(i, q, HashInputs25(0x5e874db057e3171bd63b79368d1643a144afb8010e9bed3efc01821ce4ae557c,
            0x10d4b9ef1698d4d65866c0defb347cd36bba04bbe7b0acebf9bd1e20f6ae76bf,
            0x66a52be34f40245c9e030d612f66da405899d10e268a0b20378dfe0378fcce8a,
            0x1d108e29ae7a500c433ad10c26ea8310ba13dc80710f3a39faf6dbaa87682b77,
            0x402c5b5384713dc9bbd57b3b8706d98215e493b9d62e16d7e002a47f33970dfb,
            0x6c62c785467b2fb3fde16e1bbdefdef0fe2c5b2e2dbf01e4e3de1693d8918903,
            0x57c58368e066cb8b4eea5447b6427490250c48dc7ec1f80c411cad499112915a,
            0x0edca6c0491be1ed44ee3290c583d05e007e49c2cdc7435bb98144c39ca7865f,
            0x27d9bbeb1ba521ac2af4396ad41b99dd32fd267a114cc2ebe7cd83d6a414578b,
            0x51913d5d90ccd9619549b0ce1dd02bb20900c8f7509ecda80c5a0848c8fb77e5,
            0x670d1b0bdc360c7a772add37ca218b82958765b1c16f6bfced46f78a875c8ddf,
            0x53140e9840cdb743cd49f432717c4eeb58a53ed65685dfce96e47417afade669,
            0x0aa3b27a9c955fe6a16af64ba99631a931cceae7a67a5054c7970eb441c899cb,
            0x30d622ef1f4d0d6697b27cb27e35bbf5311311349a983e6a39a6e60558ad999c,
            0x4561e495ffe3f09e171be916082bd495bbddd00927efa62f902f9f961b978157,
            0x4733a4fe6c3608ee1bae4cfd49bec4af9aacc4c65de8ca31d10984d5c8683c2c,
            0x17782f643cbb4003bbe6cdd5e0fc5118c1cc0d3ab07951601103da9679923dac,
            0x733ab9502452440460c7340df6b9be03bd19ee3d3c13716ec2695a12ac9aa958,
            0x5286a97abe34989147d1bb54feb6b6705e2fe5987fb463304fb87afe2ce89341,
            0x6f7641e5071902c1cad6d8c3058468f8977910fbc4ebd943193ce43c5c390dd3,
            0x1bcb3ee24843f69a8316e74bedb26b639a62a24171137673c3a2bf0bfd408cc1,
            0x2440b7336f1e5a65146daeed9ba3bd4f0f239d49eb57d11b9ea958cc4b8ea7cf,
            0x181117719ef7a6af56cfad1b99957c4d5cf62b113424de5208fa614afba5cc7e,
            0x315680e8d1b7085b283052ad19675aa3e960f91aaf25d3906f433c9f6b25785c,
            0x4950b930723cc0f97f7a14c1d925f50007fb48d4026752230ea8ca94fefbe3fe)
        );
        sbox_full(i, q);
        mix(i, q);
        // round 3
        ark(i, q, HashInputs25(0x2c43b8feefec6fb2317d9ac8e83337adfb5825af5a186d6a4d6310f5eacf0b29,
            0x32904bbedd2fd515dd43c549718f74c8afe5a8ad731c9baa73e1283cd08be364,
            0x2c4bd4d34a05a80c0d8bcdff66cfed3e6ca9be4b095f4067a64af2bcfd10a6d4,
            0x4f4001e67860667eba60e49194f34942dc1c42914b7e47351d88c75ee72c91e8,
            0x2eafd28935acd5e2837fff7b1c9275dae74cdb9f6366a2ff732ebb271190f779,
            0x14658fcafefbce393c50242fc88d4b8616352696c02689a8ab240e36aa09e265,
            0x1fc25029f6a6efb2303fc84046ce785b7bae2ebfd885faf478196ccbe48573ca,
            0x6893358c20533d9b3a5407a5ffeeb7da219b34f0efda02bb85deba4665055be1,
            0x39c7be56b15c1579aacfdc2cb58c15dbfab96374be26b34d3903ff3085210b6a,
            0x668c6462c715bc4b8c7cd020d44f96ebce93dbddff03636d89023297e40f7c86,
            0x02b906bca8427c2848e36edf3de517f18b437708cf3bb0c179cc583148126ea0,
            0x0e494be674ad248c67583053c45668c0cb9d5a5bcd3658c624c41438780cc194,
            0x5fd1802e39556749fe9a40a176c53d860affaf3a45bbaf00fbb7c64d1661b64d,
            0x1fec3f077cb693d38d9b598c44460d25cbd1f9aac3515034a5ef317a1a62f5ed,
            0x5f8348d0d186c4cef784012d7edcdd4082fde4a5ee7ac71121ee610969328353,
            0x66915050107a58e8bb214c416fb354bc564dacb1bd1a73001120a4986831aed7,
            0x0b141c9b6232e45a1af23db06f473d692b745e48e9c7eeaa96066a362b46f678,
            0x24817be51f5ac8da1407db8f296862e6dbaa0de892781854b6a76e24dafca1fb,
            0x1fbdd0437c8205467d329f0957c50df4167793799d0ab5e0f99338b97bf9b023,
            0x00e5478309ce349bc0e4c85fa5fb6fd22ad9432a55efabd2bc1513754bc1780f,
            0x5c91d085fb7a65193ce81691573656afb2dcde66420b2d3d7e2d6734dc4d2e8e,
            0x31a2c9b201b2a6a27662d8491288b2c7a6af0c58168dc389f1055b1fcea7e89d,
            0x55c65c52c21f3ae77fc6f3a28b1d79b462783cdf21719c967f8cbcb5b4d9e678,
            0x0a2daa56a30fd90cb02fe5b6da4f144b3fd47d451b29f5938ef9cdfd8a689835,
            0x625efff1b5d02d34db13b1782ae4e7e46cbee41f79905de1fa4c56d783f7c974)
        );
        sbox_full(i, q);
        mix(i, q);
        // round 4
        ark(i, q, HashInputs25(0x04ba445a7578221610fa9999ca0eef6b5416c6ee8d6bec27bd852d81250f261e,
            0x50d683c4dbba241ffcd50f107f128be65f085977f65f258dfce4b6edc6f8d120,
            0x6b5ebf0dc91e5f5cba832875f536be2e63370d0c90c4ba244b5e4b97c0face33,
            0x41d9b1e21470dcf39828415c6127a434585310b2789fc9415ae13854760a20c0,
            0x35336d15055b05f038f5a1cab5fa7fe83a58d3c4d92ae7c7d5b5654caa9e8781,
            0x4b856c7818f04aaadf984ae976edb54bd2d36fa061f1313e6ab7503e5ad0baef,
            0x1fa47e35da1c3743071c16de701beff262ecd548c330fb10f8fb66393c3a8da8,
            0x1b5d41c8b3cdfd16b989e10a4e386da830250b7a001b1b0655a85fcecde4e4bc,
            0x5e618d00bf501cce46394e2df1f0b2077888ec8304a9bedc38152792bf80d611,
            0x59265d4e2599c62846c3645f50b0a5e5b848dcdbadc7f9baa224781788151467,
            0x6592bfb6b03ded54e307fd75a165b2e38af1ae36c7631f03a980a67d84a43180,
            0x5b03f0dc7fff38d5ec4cf303e073795e1d0a1b9dbd419bb11f463f67877e956c,
            0x3bf2955c3858fab0044538dffc4a541e16564932fe9e74996107b8de700b8dc7,
            0x3550860ae2070c060bf93f6cb3f9739439ee51c23f0fc4c57d185632642e505f,
            0x66fb7ddfff104a2edd31b7f48ca7186709ff2a064cd74357abfe2a3e5e72edf4,
            0x5f1865c052431acbfa735ad804e2c0986cebb6d98ccd55d7882929c0d449beb8,
            0x5c7c724eec9de2148fdaa4349e6b9ee61bb974c36081b395dc648400b72688de,
            0x68360166b3e25fcb3be39f1d9ad98fc443dc9f1780925131025226a48788db09,
            0x11f6182565f46cb6dce5e15f5695a03e5f6bb141ee401b3945dadd56520528b5,
            0x4f8030b2d679c01a7bfeb0a3f2e25b20cd335bc0974585cfd80f7f8addf03dd8,
            0x371b36a5c5515b5d574a6e6a232594a2a2eb49a5f5a57ab5def450e563752136,
            0x689683be0f006b124a59b1799f6d7f0924715a4cc08276ac39d49f42890fe054,
            0x294f15defd8a69a92468344ae37dca727937c47e1253c67b1a77d70424272a13,
            0x3dab3b8c7394cd3418323ded31cf25e37c75af96c957af72e51786546a908d38,
            0x6c1e477e668e7c3fbf5b9e53963c1fbeb0e21c08881e8f7caa348f6555b1aa37)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 5
        ark(i, q, HashInputs25(0x16ac7a2332cc865db93e0eac7a86a04ea27985d56850d16b4b22045c3515ad21,
            0x246b076ebfe400e4b57df6589fd073d134218c0bd952e95f4e925c5fee06103a,
            0x5034e983e0ff2ee55d26715171e61efc1c446cf3a595f82c09cbad1997dfb183,
            0x3370813a3b9bf4ad978428990dab92f676f4ffc7b79ecdd0c44de86c7e376864,
            0x14c18c266cf67905384a818188b579ac6562953fde9796e6721330089ba692e6,
            0x543133dcafdabe8c7ba669065759456d1482c837ab5cd7d3a46d787087d72ae4,
            0x685ac394b9601431cc11d27df8656c7cc2b176e637d2187596a22dc93bccb932,
            0x4ddaff448282e611402847fcc08cf29435d448957125ea8f34c23c39730abeb3,
            0x4d2ca9f170050c0e9bfcd46fd1bb5f0a3ce33de5702493623b66b7c03fbf810c,
            0x310cb9a54e4404a57e4ae5cc8fde1a746f73fce20897e3ba8e815161b7e0a4a0,
            0x549c6bb70a2c9970f0ee128148c1f1348039950055166f1149da0e77aaa89c56,
            0x41ca49793e2646c513e5293a73b5f21fc6c3996ad51ada9abec386afa12e4bf8,
            0x4d2bd5958bec0296202a5700669f1e9fed2ee73581afeac99aab61b55786903d,
            0x1c9caa1793e051c7d40c448283283754151301ba718fc4be9a3690c5b803560b,
            0x19ab92870315cfe6900979726b042fa20c4cd35caf1d56902420de7c3e3e886b,
            0x6016dcc65b791b72fca8e075f2cd97669ba0e4608fd5a7ca89d08885410b004d,
            0x6bd9ca84bcc778aaa409905ce13422516b78bbddf9f382bb456d020a1d5f8e5f,
            0x6a4802a7379345cbe767ca7c2cd3d83f41976446355db843b2591a7d67c303d4,
            0x35a0161063498b292d407070e566aa93828feeb07ed056d8f2b8e4564ac23a29,
            0x38b34a66709f1535c9e16ffaf0d4f81ae646d0e0dd21ba34dcfb6f72c3064e6d,
            0x5d9bd0f3e7001cd69dc93ab6ac76f5ee436c8642229dd2657364f00186c0689b,
            0x723c59af4928666322d4aa530378cda246338d90f59badc1fe906fb2a252c597,
            0x32c70e6eb3fcb07e4f89d6401a50c4a78212a8afd8eecdf775f7daae69517390,
            0x683f395fb8a5cdc8255a3c4d58c0e5bfc0e3cc87d89e688b124071dca416ec87,
            0x59314ceb38d7db3512f8a35c930760ae5493d130aff8e7ece2cf5813d3e22e06)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 6
        ark(i, q, HashInputs25(0x6067881344b3a72ee41bb6065ede7f9f52d8d1580b3cf1f901a5c53401bb2b02,
            0x65c6055ed4475d72f496a8b27ee7a3033fe9c7e9aa2100b33b29be8b919d6f02,
            0x44fbe90da2127623f5d504d52ebea8e5ba2478dd1db08fa76d2131bbb9450bad,
            0x548937e4f1cdc24fee2e0b4d9285d37de4212e8230fccb40236b28c0b20a3b59,
            0x7369a0db27add1783bc91ae790fd5f197a19f9c5e4d2d7bb98d9f2466b1656bd,
            0x4188b0cf957cd1cbd74a0e148f0164cc219b4c9e8546bd53cd141a5d7900fa5e,
            0x502fb2d9f3e807ce53512818a5fa457e00e4af2db293857ab1f1f7dde95af2e2,
            0x570f05b675c79783aa1bba79ff3678901efde5c64433d329eb0a8367255dbcc4,
            0x641f7d380aeab98dd9b171a37577d7fa75500baa133e328365e882705667bac8,
            0x6a00ce4ec9a64c3c7841739b54ac92ee48a551e7067dafa2eea4e8ecdd70768f,
            0x44757e254469fe041915366fb86562eca5a3cbe304fa4fbad3df69226119c1d6,
            0x4feb918c09515d6529a3933e2871d702ee50629118aa595f6f9d5027c51a857d,
            0x7254a74a9c9a5807e9b2eb19d9552ee53ce1f50174364379423506c2ab4ff637,
            0x427ca63dd69fe9ddad0abead5b89f8ed1cf4f59b389370da911ca6196f1827b0,
            0x1189ca47df68e5a4a156d8bca6665bd97bc86ce78c3763b0f7adedc5281fc591,
            0x051e28094432aa9cc01b0fb771f686a523f52ac5a0972f898baa5ddee5774584,
            0x6c1f21384b849889a9b207b2b9308a741b2ed33d274062a9430172615814c692,
            0x6a7efbd860edaa62218f753e804694c69b3f6c8749bd2ca40951b7f0f3bf6d32,
            0x4196b502408afc75f8676421e542acb1dffb457f2e15d28dc3195e4d3d1c1a64,
            0x557d863f397191139eca626d7156d57e503d684fca2c49f2a1044c3125383192,
            0x2669cad08133349935ac4873a3eb2aefd967caadc4a6a4fac2e875120f5a5374,
            0x31abe6442a4f5059c25b486d1903a39092b9ec683ecd411815bcc6eb1bfc45a6,
            0x28281eaacc900dc5dad0938030046c137a363cf4605cbefd3c1e1c42369c4638,
            0x1eede78440cf67641c3806c916d1d5b8f22e4b4ca67b2bffea94c3a5b9b6312f,
            0x1f6951e483a8649ba3d0336e01fe199b1de09f992b4a3819ac32355def56492d)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 7
        ark(i, q, HashInputs25(0x1fa8487047a2a02521aaf1874d8450d43d26571e145124e22bb35d4e28002bcd,
            0x24e26ade0fbaf0387d41a08de5fb4f5dfc1f5533f582c8a2d712584970257676,
            0x4ed5e5439b15e71de79352e0285c719d1628d16d7d1a3c595c6e4858f6e80b73,
            0x2a79b1d5a0158b9d0d393a469313ad1b0c6d000a043ca72f2281144907640e41,
            0x69ce3b10e96d7a9e3702745d71f50e34fce4f85f7830d0d3598492b8aea64e17,
            0x64c99c3148d295e9ef45c4538f01101324f2a8b8a5a769812c2798a7afdbafb5,
            0x62b8fb7c0f8ebee819afcd18b58541d379a40ba819fcd16161abe011ec7297df,
            0x4d1f8f1238c751e89d563dedc2b1befb073bee6f131ac5ccc6bf4b4847f9703c,
            0x6909aee90dca9067e307a948ca7fc391d191a01e01852c28635616b931c66af1,
            0x64df715ad46a79202c37db4281c1dd77052467c5837a6853f7c1fd21e6604fe9,
            0x5528a5b33c206d56caac122243ad9440a0c12d5febe1a49f5e82ac9f5054d8bf,
            0x5d157e4ccd3f0858f422fecda931502140f8b2e269aec143dc08b46478cac5bf,
            0x0d6d0aee06b2e977a1d9fb67fe45e4b4795a3afd4b7c1570b98c414cc3fdd9ec,
            0x640a7a80d59a66fd34c7805c37f6ff0317b14e32a2dffe8d1ad46936d2106412,
            0x0c8211f8fafbf71536ac0f7bf1d198153c3bb3aef7f9785c6682afbae6100191,
            0x539c0f235de5c9a88c515ba1265abd870aa98b40934ff7741f3bd709e48af1cf,
            0x20753ca3529503fbb63513e6544dc2ac5a36117ec10dd0f7680ebfce63b29b05,
            0x02d8666184cde93423293fe159af30e0bd5ae217c6c24f6e8fbee9ae84975dba,
            0x5a99e8b6260edecbf86b4e423230938428f997c8f7dc02304723e50012e0dce2,
            0x104c7a15f810d6b6d0aec91a23723f5ca2552366010162656cf3994675a62fa0,
            0x0b0469da613e2ef95ecc7a3b5131c1be19a968d7c806b4e6207400a87f7f9f63,
            0x4edfa1906449b96ee2bdf46eb467c1b3f43f1c91ba503cafab7d3d93864f77e1,
            0x4e9ebd82c720096fada91f5cf5f71482739f49ce2fecb107f3c6ad770f5ee04a,
            0x51ea543a701c3a0761d323d3d6c2c8a5e40050448f58be3d4be25f91e1c33f2b,
            0x3268b6728f4994945b04812c88727af8a7ad6e64c95b0dba9fe2dd13788672fb)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 8
        ark(i, q, HashInputs25(0x082628364d8bc95d6ea7a945e509e78674d9d39ca2a41ddb777cdabda5858e09,
            0x36cf79e8a8925df05805fbff755c629ef40a4bcf124ae48983ba363f1085abc6,
            0x4c3e7c8987717e2f8931da0ab44e7102eacb91d43d34444eb933f2783145de0d,
            0x1983685893524772218a7ebc091b5baf3cd8ed2146b7136ce1d40c20c22a57e6,
            0x268ff30f0fbb3db847d601c43ab5248f6d5ad3489aafedcc54c36bb5599b1acb,
            0x1e33a88e215324bbda09be8754816d489c36105e599a1e9e189a570f4c193ef3,
            0x7065ae7866f76206087a3ba772a465088c7ffde5683c2fd4b5fae0758872c12b,
            0x3ccf0536afd65bb8c40e026571f2ee887722428816c5a5435e0d05b27906a482,
            0x33a5fd2515a2de5d5dbbf705573199ec8b23182ca91661f477a1c476419da5c0,
            0x656ecc1065c169f2f0c29c9dabd7a4ae7231f3b6cead43709f266f1be646e225,
            0x5a6efb325cdf3e38dae8b15d31844a0dc9d4b4c647baa0f30ca28cde883f73cc,
            0x0e2c04491f873fd7d5ed7fa80baa88b75936f5420f4e9b5dd916f1921d76ce98,
            0x002a0327d572745dfa3008811c413c7821bac93209375adc2a7070371f804beb,
            0x638459bbd703634b06a6da79a56910a5633a5de863c184127ebd4511e5e12b10,
            0x46c950756234a3035000252229fe107bab8905a26106a93f560f1b580698b936,
            0x2a454d5644dd06e4dcf88307bde1912bd71d3b914bea00ec4f9b1dcacbf8179b,
            0x4510a16e6d05db1f96a101fd5465166420455123aeb713c0e34cc8ca55c0d561,
            0x5c5c1a8196e60a87189719fb9d90348eb180b5813735a64332115bb33873de19,
            0x07e81498e4e7d84870f6b02643a85179061f4e19316d393bf5ad5ee3a24629bb,
            0x65b96f289381208d8f508c2d267e189ba1d426f4fd3e5b12991b8994e6e4ea39,
            0x4f2c5492626d972ea4dc8baa18500878e527443bc4ce05551998aa03e715c813,
            0x6de37a1c8b29f7d19fc8c9b2e12c0e6ff2e28e29927fc7051a37fe5d8c6be9ac,
            0x73a8788c195267beb45acab6e24237d7014043fe1a769f41aadfeaa35e23c78c,
            0x0f7b79f42c08465339c8e78f3fff8d97417af4bf2afeb4729e574dd779d1a67f,
            0x4e9960ce839e868a331c9eada8eb3c15d6349ceecd7f6c342dfacb91321fe7c9)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 9
        ark(i, q, HashInputs25(0x64bdae06b77ee9565d6e25cede5e006ed5ca17aa553fa15ad82e43d2a5bbd175,
            0x2ee4b315eec4b060a66c8c0f4b266313539864c3e45eb0d50ba5f7b71d656ccf,
            0x01bb4540ea152e715614c00c83f868e6e90e56cc48f5ba2a8c458fb0375ec10a,
            0x54f41c10fd15a797591fe7b9b6011392323a1c8fcd92428e15106f3d7bec1093,
            0x221fc360f3ad8fdfd4afefa8e10d088e88815188cd952d9a0347a90c61e1587a,
            0x22b7183cf6ccf70e20d1b1f1ceae61ec8871d2dfe5503110c55b6346dcf93a89,
            0x6ca85978deebe1720f36f5b43077deca7f32ea4ec6d049dd5bfd42678dc3a6e0,
            0x54cc62655721f4283050ed141b34e2fdf91d69b16638fa3115b099c580dfd9ff,
            0x577ff0e2533070b0806b59d702a878ce14215448bcc0c962cb0ffe34d5b29532,
            0x1842ab45da7b26904b83a4c5f9c96747990687abc9a4cfb2f204ad079ec3328c,
            0x288021f24cb39b4ab84adb991686bcf4feebea319184186f7a43d1704bd52925,
            0x5033fc12aa7543e50560459a1134d64b73d5b188f5ad264120e5e20c57ee507b,
            0x582f2024331ff4428d95134b211dc408f22d7b32ca403e25e0395258f494e88b,
            0x32af4576b7dc2336f30cdabb975c76bd0dc5efa5b9708aa7f026f261683111f5,
            0x726b253276e404515d8019b04949eac5d2856a3939cd89619c20e006715a54d0,
            0x28fc2aae3476803972c25747cca9ea9ec6a5c18ac964581b599414f052dd43e5,
            0x0f639f38c06db87e31924496fcfe2b80853af02778fa42cae2fe81e6355eae69,
            0x50ed9a1228cfba501a129092563d276cdce1397b7972e8d1fe758aeaad9a5347,
            0x4c6509094a8c53803d9e5ebca7d2fa328b506e607cbbe1b40b2126cd09bfd0d3,
            0x6f5dbafa4a623e860852e393476e1a1687910f2e8bde0379f711bf83bbece052,
            0x30aee1a62e0ce3bcff4b6ddcaf78f17eeb89fcd186293df80da3820ff36e09aa,
            0x44f3899331ac4c7b92945dde685cbcf07ae2a2ff9747438285d08499bf3381c8,
            0x5b0d2c84f405761f97615eab66e28be7b0b435c2c4648f27774ae30e9a71c9c8,
            0x703097e124c3bd0462b6ed95a38d447f769796365f11436f64cacb2564f1eb32,
            0x6309987b61088b43ecab93eef572f6453c34bc69ecf88a3d481b6bad0f3849a5)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 10
        ark(i, q, HashInputs25(0x2fa1382fdae81e52e470abb5f8028ec0cff46710d8e95010a562a97f00514f98,
            0x184b2317880a119f280bff213e5556e5040c3667b928d74efc53baa975ab626b,
            0x259f0435ecf8080d553f181c223869fc5e4edb2775714c21961ac191bb03eb9b,
            0x237f4717661e302777beb6c06c0ae0ae396ffc012752831159a15b1745d79c26,
            0x3226c2cf78edd46eaac7818943c1d0d81495122f2e06ee90addb3aabd98ab38d,
            0x71b4650a9920af64fc08670285c80e50d56cd1ba4e08c25b7bde410c78a49963,
            0x079c7486c8df9cb67490cbd649b5ef865d0150868eaec035b7b7eed3e7d5af82,
            0x34801b50585fa4e0ef6154c5316fa3d1ca59e4c1a24ab2dd6f277990f70cb4f8,
            0x17bf16132b015d63dd900b30bbfa0f63d047bd95aa8562461277e7f411d25956,
            0x15ba8c5e5ab8909569128119974c3759ad41c01ea1c9d239ef1f7f1a5a2fc788,
            0x37503fec304db31326bb4d8ab56b46e5bca83607d4b275bcc7b078c918c21767,
            0x072fd7cbcbc1796c3013c15b80319ddd006af3f25414c3d201b777858ff6a394,
            0x45b6f8c470384e20e70749dd6136855a3bb13846baecd64f9a32e3eb3976d52f,
            0x2b1bd6298a77893f7e795c7b9a4de0c345785e3a8b947f4415e350c9b796dfa6,
            0x600337eafc3daf7ae528c9ed4f2cb2962015b9294cf2dc9a83b43a89d7a7c346,
            0x5cd83ce80cd353a254a147b8294e116dce29198808a32b2b9e647274fad78e6f,
            0x32e1f026f038260cb6ae4bce0cd61d5a73cb5abc77a1a494b8f6424d81a53e1c,
            0x571a21821fca0725be1051a8e4226282b39acf2f555d1e07baa088c1a35b28b7,
            0x33f34899ff26267c8c4d1b9be08b05d80c8de86aca9666679b322af59796eb16,
            0x04c76911349ecdc025eb920fce5c5a5a4f2353a21a289e3d98f7310fc8f42ffa,
            0x175be67c6a13caab3bea17bd0d0da453e7dc70bb61ea6deffd1fa6b35a7b8fb7,
            0x18affa849aa39d0c38ab25632120fa03a146ab3afb3b777df7d8e99a38d4cc30,
            0x3c9c02a7f40c5ed83725e1f65ca1ee3cd604164e233c86763abeb950e68eff0f,
            0x5e1647896a79bbc34db12968878109e4f25d1d6804fccc9aea5eace9b44821cc,
            0x3ecaa53bd47c3b95bf6385a5616d32eeaec2480c307fac39697f7523c9232cce)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 11
        ark(i, q, HashInputs25(0x0a68fbbca880b146f0a6bf0de537c82acf3cb1c952539cb88ec613635a7f456d,
            0x16af1409522fb5a89445103a52f4aef860487246d0517dba55693b31d91ab93b,
            0x0853f8eedd64af64e2c8e96a2febc753cf600401c6af59fba5ce5b4ae67f2b31,
            0x4455af50c251dc6739625638cf10a92384a9d769f14e00a48a1875be9beae1b4,
            0x489c24972fec180e62fc588b7a1a86523c45ac8244b07d9354405c54688e95a0,
            0x19055f92ae1e6894e40b663def10bed0f90ef75ec51b209e483e6eedf39e83c9,
            0x0a26ec29ad95dadd525c3ff12fb3ca48fae2211356439ddf500b49b80348cdcf,
            0x3969aeb28f22614e7f5a43a218493b0b55ede659ae3ba6e370c302f9a3426cd4,
            0x70f3e0e7377961ed7fa819cdb35439b874104ed5213ea242f1c201f83c982244,
            0x534e0cac915c8267357ed85085af19fe2271030a54888a0f8865702d10649b9b,
            0x40d8cbdb14bbfa03fd2dd7d59b8c57c2f897f16bdf4a33093eebe9d5fef58da8,
            0x5ea7813bda88be1729afc8b949009038584d18944e9d1882a85ebd09fc5989ed,
            0x57c68d01173a750f41d4993d901e68cf85976a140295ae9f876c01a1e46c5869,
            0x1b4fb047f1ea3ec5810b21980ffc2cdb685055d9fa9cf5c8e566388f9b72b855,
            0x63e7ceed6f4e5495433ee88f6f50511ae9f82eca95d9b8a927ffb5f0b3be81be,
            0x54ae6d562a82b5c713e1468a9264724229d797d4b43fa24492da8a7afa6bab94,
            0x04166f6cd94dbbe7a0f20898ae80e2b584676be4bc284f17c67d3fe1630c6091,
            0x6b6b70e488bd08509741606f949ead932265e56fb883e865e4840616ceeedc13,
            0x4e6f90c05026883c0e7d6f51e34bda214d3220c81a26b9ecb9dcb3b7bcd80ca5,
            0x6476ca786d705b5268a1b82cf837c9d894fadfbc6a5db45daeb8544870712097,
            0x509ce71d4e68b8c6c4dff52d67bd9b3ccb241c047e0ed7d58e72ac1241ea1282,
            0x3d44cf4deb67944c660a39e6a9e2f26f91e030fc7120b0c7cd6322b08a734e53,
            0x0b77902ed3431086d8018c3ef194487f568dd1e92f07cf359c49cd7c9044bf7e,
            0x6f176bd18bf9a353bddb261e07fd7c41e46c4d647bddab9bea3005815b56c3b9,
            0x30675db4a4abe5e80f90ed75e15ed248f7eab3bb38b4047a017ca0e6464a71de)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 12
        ark(i, q, HashInputs25(0x55df67407230882f106d4e26da34d6908372bc1b390066a2a51010f1c70e66ba,
            0x63704841e8622d740b409d0689ad0eb1086caab65b21d8feb2c7049ac1b2b775,
            0x1367df6a36f3fca55598d00207aa76a88d466d876de5cba69fde6577f59285f9,
            0x196e88ae2eb08c788963d0a2b9542cd986569b78e4480f9dc4027317aee15365,
            0x619446f889c9fce5a7d927036217ac2998bfe8cf0e375d5bacdedd983d038abd,
            0x0af4bdf17bffe408d4ef2511f42badd08512405ef37b07eb6b5bf27f8136dbaf,
            0x3795ba36ceb47e281a397541418a0efdb25b9545cfc20ca5edb943933a031741,
            0x5655d11710ef07cfd77beeac66935136377754b0875dd5dfbedfc86e46381582,
            0x552fe2cc6379e1274992c8f69ce9f816d3864e5dafd42319cab813f66583b374,
            0x47b2132f12f3f9e5d85602d2342052a2c8bfcd3e0d115e32f5264f933e647a65,
            0x6c4458099d1b16ea2a5fe4b478ce3549379e245f6ad379d67b2cf17fe3a6d264,
            0x50683f07302f1bbf627265c5b911d47bed0df6eb2b6e55b47d53d1547025f9fc,
            0x2444f8a78958251c8e5a02f1ff1dbee893f6ee6c06173d2cbdb36feffa1904b5,
            0x6c4b9163e99f1e2a01d3f4300fce38bacf5cac6f334659e044ef0a11a8c07cbc,
            0x4f5edfaae7386884f52851bcec6bb89b9a171cb8cf2c52deec4befe3fc55042b,
            0x1fede49a1e6028763653eb60fc8532feb65c03ab8371a7bf42c2330de18ac2b1,
            0x221f7156b76217b6e05addcb67974f0ed0861279cad44b90109e12e9af352ac5,
            0x718890e5e0dad5da547b1b8900cb0fc8d749ee588c1fbe14acade86d71b0113f,
            0x54e8348f1c6cdd73d2826aa817e7e74bcde33bfafabe0fcb2315a9aaa84021e8,
            0x6a9913f6a8d44abc80b89b4b9da8cdf1eeb90f2832c6d681240936f469c27790,
            0x35e84008df3bd9fc606ab22d9af5d4ced34a5b45581759f7ae0603293847174e,
            0x213e2a523c4ef3daa8324a91e644dc00054439d3cb5b53cc18cced6c4340585c,
            0x6cbc6cda9b91b0c1234c4828e4c5f09b85dfb5a15addd3f58c365e8683eb8be1,
            0x4058e4345c12aa9108e561f9a8f877667c78083992b0b05500559df968dc060f,
            0x46595e9754b75d805d83a784c5956d7173f187184ed765a3079f5ae6ce2cfd3f)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 13
        ark(i, q, HashInputs25(0x0762059a81039ed05b0b5e450d51e77748e94c038267d80aaaf3c7293bdf6b7e,
            0x517b9ec6b296c171f46b19b41f5888afcc6918c9ed3786da9eb35fd4ec619de5,
            0x5b3b4e88257131296a6b34949888ff1ffce975f52e2365e917684b1b0e3f6363,
            0x3b4fecd9b870cb5d7294a8e63b32e6a7f6ae587a02e7b8b8e521b2d3bf5aa836,
            0x09e3f65af52b4cd907b400690a5ec3a16da0c47d048be315838e03bb70b9ab72,
            0x73ab19efb19adc5e7eed51577649d2f6c556be80144ba75e9550f5943deaa277,
            0x364c9ee733fc6b962aca39e8ef0fe38f418e9dc3941b5f199362bc79f367eb88,
            0x5e8c892245a22c4d9552828087d302dde81ce9412b2499e3cf678ba5daf7a6a8,
            0x0d3a7989d787e4ad62e29347112f9d0bb3d0945378891492a5a1cfc0ada7d207,
            0x5b3984c5548f3bf7cd781ad8077b2415e26b32185e07ae6ed225f5598cbc0445,
            0x23e4102a01e4d572d1052b85f76500caae7a22b83631aedc5b5d67313ee629d6,
            0x5e727fe6cc09b103f08d916a69c709380734644dd0cf94c1648ddfd06bdb317e,
            0x2efe4ec8bfc90fe696e355c49a92bd010dbfb31eb12951dae3c41d5cecea9ea0,
            0x0b159ca6646cd0318a02c841e9b126f8a4301a3e82dc2f8bb3f11486b3fd275c,
            0x5d0977b76c742b35e97e243825c67a31c66b141846ab5700d62f6060d79a07f0,
            0x6801ec0a7c36e8647e51440cc9f65e825b82fbf3f72e9c84037d083bc440ac49,
            0x0350cd265f375b91f77de61874d9570a28e649cc72a9de24e05b4f37eb29865b,
            0x54eaf9acc342ec67a62acc3dae1b3d075b63b9b5165df006217054f54a791b7e,
            0x199b70ab621a83576fbf591318a4d003b37553e568f032c2445af0f7a260b673,
            0x717736782fbb3fa27a91e35525df46aacc8ee60ad5e9455043b00090e312b58b,
            0x0118d8a197dbfb73ab85141f3052fd8371395c3085c7a5816f9fe7e317baa09e,
            0x10b714b2460020f0974a02afcb65f9f7d541077ba2aee75c434c88a1f2197f3a,
            0x458e738dbcab1d483414a6df26c157eeab1a04e949329cd87bf55ea3cc401f90,
            0x2cc850ebb574dca2852fbc42d2862ac848acfca892f24381c60b48532c5f9ff6,
            0x64f859a198408022c61dcc8ff5bd502d1bae83c0e5d75d1d1f7317e97d7cb8f4)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 14
        ark(i, q, HashInputs25(0x69af903136c91d1eec49cf2e42ee060fcbd3bf92121a0bc49604494321f28cb9,
            0x497914ed02fe49ec640a10c56f1ecfa00db126322455461647dd16f5ff1ba062,
            0x6d25d9e2e339f51459560a05c346e3d1cc1b8cea4a7a6ac63cd8717eee506edc,
            0x27ef7cdc5d96580eab128b8217f5defd1176240e2c817f087fb350ab4fca92b4,
            0x4896935c02d4ad99cd1d8a5a1a97025c5de76da2ebcfdcb5a0e265dada8463a8,
            0x273b6462d5389177b5dd5313eb4b93b42abd14b4edc2968fc9dddddac75ad3bb,
            0x49cc4439efa5cbd54e121f4cbaa10da6983b947c8a42b82d48de81dc4b44550e,
            0x075b2551efa53f61364d294227f92112c36af96727a4b3c88e3477a5ed13cffb,
            0x5855da7e1067e8425223829abba0c3943de6d983717663fcc3cdbe0ae28970ec,
            0x34af8ab17228a5c11f835ec397f83dde42d811475a8daf02c29764a384d4c59c,
            0x6d1940888e47bcdfb4b32a4cf93538cf57d20ec6947aeb187e1cb54666f900d3,
            0x73251f4228e68b92defc682ddf346b38c6bfc9e8df5f249ba5b5f99dc2387a32,
            0x1f973b79ee449cf3cd10457380972ef0413305bfaed61407c93f7ef6fce2bdbe,
            0x1f92e21b492445e8aea68ee271e52134bf931cea01151cb254ed405d936e9c95,
            0x26580ce98554af9d07e2687e119fccc1cf43ecf3d844589e8a3ec0f494bbaeb5,
            0x15530f98b4a5d4552b04bd71ad56894461afa93266bd855162385c23b8691fb5,
            0x162571d372ffb7e3688b994fe47fca1e364cd3be449ef9f794822786cf95db0f,
            0x2d5af31b2f17e9018992ed3f78c8177e707396a4fefd05918506009f15a10fb7,
            0x2e30dbfafdc70629a96d8a636f18413436071304de18e7f01c80b6d049ac7d28,
            0x01591768ccae78331ff113f1c727bbcc0722fd9704a72d297956936d64cc76c4,
            0x496e3fbe2adb755b34f574b12955dc6cf9c6e3d4b4d26d7b5163a15572dc80d6,
            0x6a3b68f66e31b5a7fb70943addba773f16486ce7e082cc1b8f98a0ef3fa986c1,
            0x42bcd03cff12cce0648add5c90a4209970ee1837f3dc90504b071c4038c8498a,
            0x1fda357e03a2f1eb4e2192c99ec8fd115d56a32b55d71654cbe13ce2ff3a33e3,
            0x57ca5fd812299b2616f8d639acd5b12d826a432d9557b7315c4b3157e029f8cf)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 15
        ark(i, q, HashInputs25(0x5a9fb94edde8586d591acf709d69ae8b97141c0c1a6d40f835ae261915e033d2,
            0x3e3487f6704d7f09590804de607d561850387f7e62731e2f4b45b8863c48d289,
            0x284d61426254d89582a5f6f09590e9359ad1fb94a24d1ae18eaec73cf214d035,
            0x1997cfc4071f1c5059796b34219616c9931a5b449c6ec127ab77bc39841f9863,
            0x07f1459adc0f5baf146d2a60e930bec874cf87e03f4831a2a07c37b2143dab75,
            0x5baa982fd384e95991be5b9e1ccb5c28272f06ec458ff8c09c4ff996dbfbf9ce,
            0x437130e11903911748b42fe9513c7b8b0f815cd0d7b8d44957393097d8b56711,
            0x1cbccdd614938014e14a9b5cbbb4cb3f334eedbd93b75a17fdaaf0b3dd334c1d,
            0x21c0a6a064fa69f30f3de3ca31c4bb8fe8593d1247ab3904e1f8bad07f922f8d,
            0x2b70cabab3e9c83b2f579a40d4feea08b5b910195adef1a7a2b7376480ad0d8a,
            0x2613ae5952beee92262f0e743f2b5ecfc9bd912c0127863de6290a132616f28a,
            0x3fe3c2532bac425b527f78f7f9ba710eaf293d8d7976d31ab770640e2339555d,
            0x4c0da52ed4620458276c6e5597105e2b8798ec438531213dbca2a1c2069ebeb1,
            0x505d95494b94498258eb94bd7e1adfb88838b1985f3640074ec1dc999344a5dc,
            0x51e4e1cad08c955f6adcddec1873271715dc5c7665108436d7cb609e830cd982,
            0x4bd1bd5f6cc193da036c0d32546d764d1371f338ffffc2502181009e69902dbf,
            0x4c087e9d7046314828ef3d14cf5a15c567f6f4e9400343a2a9e3e55d2f67d194,
            0x2defb6152c0c66bf9f267cdd41b3cce6f6f074fda174f9bd1ce49311f8b9ddb6,
            0x0bbac64f63f4bb2600c768108a7675bc3ad34e77e6b502821eaa3a09185f86d5,
            0x3c6da091b7425d89fb9e6f96fa077c574d33cae62133d147ce6dd52a8c063105,
            0x5014748f5c1a1168fe26b8562cc9a4f45c582bc962fb2f6ee5f0b2dcdba7adc1,
            0x2fb562f950b8591117fcfb3c6ea52149f6ab7e5db139922582ee8a9db9d0ce16,
            0x21b0593d8fc52738457b116155f4a6f4503b39ab9a7941a27f42060cbc414100,
            0x5c603f0525e587ee36fa155c419eb2bf629e87dd9bdde15501edea885df2aae0,
            0x46c64d709f59e8c2e8716d1f6bfc38d00297e11cb7aac68e2f78a00d6f64a6e4)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 16
        ark(i, q, HashInputs25(0x465a49094d23ae7150c0b5ab40bb24eb41518654867ce41d252f3f06e5f857d1,
            0x3529d86d076e9b18b66b163687a8755c55eda47e9d0480bcd841bc8909101d9d,
            0x3c9f6385b4f824fe9a4ccbdf06dac4d4c376847d1e7c7956d468d82266b5b1dd,
            0x450df34e845ab2c4e3366ac990f66bdfc5dd6b1e0658206299b0f2be79bfd628,
            0x2c40cc81d7a03a396f96695611651214f96d26ca7702444ecb0bd3c8bb1f47bb,
            0x42b003ffa9d70d86097b7a655edb52aa58dae77a66dd92d1e9aa4c46eb2de636,
            0x46987cf14f060587216d384651964741b86c643741a642e6395365e50b676576,
            0x70b63f381a092577ea2b101281fc5410e0072e8307390010b0019292aec9017b,
            0x3d0ae1806990ad4a43153a22698e9ab0c78d71dd9f8a1a4674b5f6b23ef877ed,
            0x53e6934c6e923d33f1ede3bb83619e23b90845dff708a8f32add093977545815,
            0x177f7c5c87595ee3629315a8ce46d6bcdc15fbbc788e6e836f0c05a2c41b05ff,
            0x08fa1bd682c1db3392b44c300331528b0ebb216df29c0dc9b54839a3a23fab3d,
            0x443177831293d0b899b1a74939b49f4bd1eda2e97aaff760d2cdd36afc144fa8,
            0x1c82b3bd1bff305b543fce7ac9d08076fb836c0914f0f756359229d2d77626cd,
            0x01138b448aab90caa1a835ec851f2a98bcce8333c114d18a3498e99d340861d8,
            0x5fa690185eade2eca7ea5c8cc7b960c1e5e43e0eb1689ffa8a0caf9c161797c4,
            0x1f221a0ec43b5bc41661a73dce3a1d3a3b6facd3e1487741832df19924a849f2,
            0x46eb4c4b1b12d429016835ff898881ed8c2f1efa8f9cd0e69ffede9108c4f731,
            0x0d80cbdffff0a1d1d8500f2037abd1fe8afa72fd2ad54f6347091c87de8a8ce2,
            0x11d328a6fcb420480a97128ec61a0ca2dff8661c680c109b3e17bed03be62907,
            0x3836f26094328b4733a4eb3236e540e518040bf7c0a5ce06f268610eba0d95b5,
            0x2fac9c23240847a07611367582cc5cf56e4c073aef48b69f1137ed632ec19b19,
            0x5a2db296cf1fbbcf324cc4c8733471e725ee19c899560f4a4342f0b0c1e0cedb,
            0x7140c800fbc35513b9bb4addf6ef82fec28e914281002a4883a5117f2d854a27,
            0x060b38f74328ac30bbd1356d1ec7710e2abc63a2850841ab157f487c409caa54)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 17
        ark(i, q, HashInputs25(0x66de95e8018c0407a3eae8cc737950c740c44012358182a08fb354800934d220,
            0x020d15b31d74d7b8bf9ffc34421a79d7e87de0ad42d18404e2258ef9ed7e8788,
            0x15152d4a18dafffc4662f535dc674ef0266dfb0b9f94d8a94c89415ac33d95c6,
            0x3dfbae01d615561bd85d120ca9a5aa752c890fe1becb2075f8620ec36178dd8e,
            0x1d2e7baf8524755aa4cba6c4596c2ed6fb9f837623df1e18a448877313890655,
            0x554e5e8ae9773e950fe10ce1d6d4f41e3653887f000d8eb517fb96018d36af3e,
            0x1a484f70bc1ed91842801a87a10443e5e5b75589aa1bbce08da5ce52c105f4bb,
            0x417b427db2f6667eb11f03ecb30055268cc6848b40213fb51dc7e692fb7f9c97,
            0x01d3da65c352e3e849a25563b8abda2039fb458d5b2f61e60828b75014fbd2ce,
            0x38e680ccef2df5f21ab8655d18b542b0856a21d6df24ba2ec21f662167c7fe71,
            0x6b5cd1054dea6505e27c97e46ae8cb25f5f365a8803f4cc17bda6b2a723f3e70,
            0x6a2a8cbedc8ec1837730d0d04923b535cdaadf3afaa230cfc60d48e717955f35,
            0x3e11ad1a961453b3b2e9629307bace815b40aa1032fa3b10077cd2ba769de2a1,
            0x4b840e4be1c9dbd8d8e188728318082751cd7384da7274586c5882452ab12740,
            0x3f1e759e88fd2c2acb2f0127ae2f3f46fdb9c7ce934cb10a10ef05a7b257c488,
            0x0f6606092599cafe4eda01a2ae963896bf5814fa15f04c96b9698e52968fa486,
            0x68ab53641cbb36c9705fa3b969801264f82cc4eaab570f2dc1a6663493279642,
            0x14e15be33cb449f7aa12306e675af8ad6799dd5276829cb5b8371a9d6298129d,
            0x4ecc3d2f12ec3c84d6f125fe82a96387b0913ef972d0e7e187b16d2bc69f3efe,
            0x34c73840197cf9ac81f02dc40c7d569ad8f4222f6b7fb2c9ff6a29e18de7aeb3,
            0x0cc3fa8bcd9249966ceb4e24621c92c1a79e9784dc8d09d90482e0263e0395c3,
            0x2691b4f7e953acea4b8a99e05dc6d3a35adf1184b25db9cda1c4232027860931,
            0x5b24cb2240f0503d6215cb6e4f20497e048bbdcc26e8318a46e034d10a850dda,
            0x324afcb4c7cbb1c27a09f17446e743e5cfadcf3fed5b7b1ea488b9c211f4ca6f,
            0x4b4ed28e6c220effc5a94aeef7a0481fb3c1e116dfdc35f6be8f45d3f235a40d)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 18
        ark(i, q, HashInputs25(0x528465e9e31f9acbfc8fb1781cf99c60b72b83cd83ab453e002e248952b52f29,
            0x564179816f264a5c55a09906fceec2b79d8bac6c08061f3b3dd3d81e906a6b98,
            0x0e40cf3b8c1227f4daa76a4c5fe7b8924df54086b4393e2902fa6ba075505b7a,
            0x5cc68b87a868c0e2ffc338bc994c4e3ef57050bedf1ba14065905486c9c8dac7,
            0x3059cec172477dc0656cdccdc7e5b815d1dd402e0b42e86198704e3a5edc3179,
            0x11e9b88c6af9d71edff4b04169a1d728c221dc089acfb0b1d7c37674e938d8e1,
            0x70e2cce4b8919c23fe408730a91ac341ffa596f226a4b9ea8dddbef8c16cda26,
            0x48c1f790fc510c8d447b8bef35e7a07b43869e98ce8bdce5a6ad9a8b82dd2a52,
            0x18f98a4959fffc141249e9d6cd028febfef4eeabc8d6ad9568c0e1e2095ff71d,
            0x6890cfb01d2e2c95f535b07f632dbb049ab58da132fe6ebca4e8b6c571653dfd,
            0x4f5bc964ed2ab4ccd8277833c09e73307b863c66b22a32bb2345f98cb7d228f9,
            0x595d0f5784449324dae1456adc5cc51a7911d6d1da4ca76604b0bc5a96f8c49b,
            0x0781b273820f9b825584bfa0abacca2d4beb64e51a06404fc82b2d10dc62edab,
            0x3639673871cdb0215b9ee509d44712addb47d32c22840157fc99cbd00280eabc,
            0x49dc9fa3602aea87c5fb5b66055a441aaac52118f3fe99cb337ec16f9676c515,
            0x58978c2cec103c8b0b922ce8fecee82612e23e7d2f589ff1f597fa17d6755758,
            0x50e1d7cbe5fdce8474045a0a86b85f5c068b5a7cf39665761d76c52b589aed36,
            0x2d8b519a6f4fdcb4e594b9c1f6b902e5c284afd3512c4e0e758b21f2bd485489,
            0x1dee3119ef722782d7bf8c9d3cfa8cc7fa07548db51cd3af67767b7b3af77052,
            0x1e17ab7b89a68d7b5007258cd90a369051e4a26ea3c58e27b3dbe2309ea3a27e,
            0x5a260ea4f346f1fad6eb1249b4670bd053fc0c29f0d2f21d66e730cac5c5b0f6,
            0x5febed8237fdb74b33e6e345f2bdfe470c071a13b95d27c697edc216b1079906,
            0x4976c2941f3cf84d5ce953343c6b8d386f4e80cb191fa55723ee4f7b845e7169,
            0x524c028ebef4042e2e67379278e41b060b15f19fe9c201a138cb6243be2f473b,
            0x712d2cdbb2ab8bab572e97b5d533278145b4cc3e45b485f10c893c440c908e23)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 19
        ark(i, q, HashInputs25(0x242ee6b0177555aa01522f6101dcd01c40e45f6efe3a7ec3fc71ae6aeffea957,
            0x18358b3332026855b71079c49294d7f954f97731bc717a0e5ace1925959a897a,
            0x14e6d8684cfd0f674f74647e1ea9560d0c82273b16a7fa576cce1194dbfcc97b,
            0x125230997123bcde207d7912547bcceeca14e8b13970f0f6c7c28b923700fa88,
            0x01584bdf1439e76932687999502d0a6b6c593447f34aa73c7ccc95d3b79e1419,
            0x54dbc0a22fb9676b1ced9c538134e38def084c536daf87e873e8cde74df2126c,
            0x640ddda09a2d68bd15b3f6b8dbf5786ba0eadba9ab62f33435b415457782053c,
            0x3004d45876042fe6093dc74e3edcfb7db14198fcd87320af8aee73bd6e9bdbc8,
            0x24905e7fc84050ff1f31af5e06c274ede19d54342355b9439a67cdeccc108ce8,
            0x71882d4f0b261b9a8751aa829f8a811045e55dda92eece8cd7d261729e5f703d,
            0x31d82f2476944ddd85f11cc7a7dbe7b272bc0459cd1bc1adb072173e411e9d1a,
            0x5188a10f028dbcaba88800e7a7a84c6da8838ba97d54c5c3e9178cef1c71c854,
            0x0a656f12992e816afa2ce118457a39c0a36fb7210b0dcd418db8fd76b0f31b85,
            0x10944bee80cbf4911d646be66b7e88b1848775a4d8b88702c31cd79bebd60916,
            0x1ccdb9fa36b3fed186c0752aecb18d3eea055389388b0a08c980fefb03da42a1,
            0x0846792a2ffd40aa2a19debd04c6f8558f23f634b305278f8c6f2bc70b8235a1,
            0x3eca6bcdf1421212085cb1db017b7f198da835efca48dd00d7ba1393b326b4b6,
            0x3e353364959187eb6ab8d6eb7711425140f945e8e2bf97018a84f4c09056f36a,
            0x0bbc7e0a5b0b5b522c62e17c294535002613f04e6b400b9ffe36aa62372b0886,
            0x17e41d058c8710d4f9061f7cd1876a74b9282448a49fd1072f82ae743eab801d,
            0x1170ba832ede439990c32f71bd63b8854738b23b8f65f641b4c216fdc34bfc32,
            0x4231d11ad479fa54c982c0752f94a6960f519fd1d1c240ac7b614f13eb90d206,
            0x43a9625a7ef94193c5393c2ead3330400d9e769414efe1a33ba302c143142094,
            0x39543ecb496fdabeadbb71e5299085389a3f2b7d0e60ae29983818e4957e2bc6,
            0x04440587d4d93718847222346e782b6cea47de4fa6fcbaccd964e3807f33311a)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 20
        ark(i, q, HashInputs25(0x40d2d89e5e6994ce73108c623c4c2513968c01778621e93f9ebb2a79dd418ff5,
            0x0c8e27670c9ce4a6a42219fbd5780f68b7fe791bc2b4ff2565969df928a9f061,
            0x05234401b2c8e3edce08e1bda8d5c1aa4bc69b54be265f3f6d95c84aa6f85e75,
            0x34e61afcf76fe22bac22c6bd044460130551c4c8b08db7e08ad639acf8fe8851,
            0x40fed6afa034aeafe205e1ed14b73a1c05640b8c0396518d7f8e7aa9873ceced,
            0x525b89b048eaf4eb33d407ccddbd2f09ec915e7b4f5cc485d093a48411f41c85,
            0x6bdae11997f70b9c1502c802ad0d30ed049841fda107f5579eb93d1dd1e44b8f,
            0x67a209e51b0cd32a3a1196e4dda33b8c6fcc9905a6d38dde39636d84bc528f85,
            0x4fb4d9c3f0b604061997ad9d2fa33a522a888ba48195c5f5377c5327ac7b7905,
            0x07994340133809977a89b5470a71e12728d35fa71dc0ec0555d8f7abdfaafd5b,
            0x41d74e8d8785ea479a5661df769347da2da9d30e39b9d98e849be4ea22ac5eb4,
            0x56607f3d58be40af51b6770768beb8b9b84ccd42e0d382df9ac86a93d90beb0a,
            0x49bb65b95f9b6a51c91d634d47f5f9f091f48471c0860a20bc181bc4deda8c56,
            0x362f0c4c1e6930944c4211efdaa4efddfc96afe462e488481acd05e0b51c3d5e,
            0x271fe09b89977a3f9163356f04033108dc393a93d13ef44e5e857bc95893a888,
            0x19ba1ba288eb1f7ab0e133f3697fa135136bb0cd3edd7ad317b28d60a5420c20,
            0x678ec531f2b36d70cde2923c3fe455606f86b37d47fc9d8709f6fbd3b3813b99,
            0x63985dfdc5add5e2acb2c8db11c446711477e543fe45a1ba72540e6e5b20d787,
            0x16e1257623fc77de71f9a9294b6c10b632ea525ee1e5031b5045a9d1e02e4a16,
            0x0c4fbb3e65d2c2964190164248866ba765b9aa2f7b11e8db427cc627fb12c33c,
            0x486d0f50649f054df8d431fa7ee654b4402fc8fa51fff8e12b8b2c444b2d400b,
            0x5e43acfe628f0d9dedd0cf9e1b062f51a90e976fda247e78017cd846eb0bf685,
            0x6f03c35ee42deb6de05e8a55dff6fbf7328aae2060b99402ac68a155282531e4,
            0x3b95f4d3592584e20af854b0d529d54204fe305e5575b1ef7252c244a2114bda,
            0x0ca5fb678590438e02a075f24c4ae789e34b1219f5ee0d698c73fc516e146ec1)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 21
        ark(i, q, HashInputs25(0x1f9b8c6b0b25a37c4bc75535ed4750253f9d009dfa9eae315ca1f312fb49792c,
            0x62734df392d9ebc829fe9021d38caa5b195997776f3342c380cac5f014903089,
            0x1b8dee4b83897cc6a8519c1d5f9822107bea13db0457ee622f2c3146520f2ebb,
            0x1551e1b7ef2d81a5eb430adf996a2b18aa19548fac21f2c1a5afbc2b697c1eb9,
            0x2cfb6bcb6e64ee30893a56730113a75a99d9693d5ce5ff385d78079d589b6e63,
            0x70358c3b7bc42452d486ec9a6dafe9856d213ac63e0e57bdfb49e9de2f5d19ea,
            0x6fde73dcadf2e01aca25a8c5bbdd398898364da65723197bf3dab4d1c7027d78,
            0x61280e2d17ce7bce946bc8cf0f55ea802dd1386307a65cf5fe16984aa1d22b4f,
            0x6a7042840464015d40b2a47d0cb0ddbb8dc06dfab4ff1bd37e476b05d9ef4389,
            0x1161b2c96fd158828bbf8d8e900291e030218c333555ca373c9eaee11d43a16e,
            0x0ecc391654d125b5289943ef0a8e84715a2acd43587d4aec33b14855335420d9,
            0x21095250b7b6b21b145f0314d97091a25ab2d9b6fc3a78c0b9a07e906ed21f39,
            0x5417d7f68817cb1db807c6d25f0426e7db94559479c3c2c7ad697262d835c1cf,
            0x53bd8f580651338e92b2c714ae0acc232749016dae45999b7a31d2742698daca,
            0x433660894665f5e399c1826f1b8b76696f7cfdc0e416b3c236ea4b85190316b3,
            0x6d964634763d7e93cdfe7c6494d31cff6ccc79f55b4acee15efe894c229e9409,
            0x003a4c40777f7be7b804e4f4ae89b861fc069eb64ed66fe3f6db10021b8c1470,
            0x0885c90cb883996e85843fe2c41ab77f42b3222d388afefd78c238ba23aaf641,
            0x1a0413d57f3ccd07b75428ac1438ba1adb69a5a4c83d3b01fbbeb19b6dc2f872,
            0x5d8d82b2bb7b55ab8882652fde2b5f102cfd4c54d1c5de45fc334be1cab50f11,
            0x72b051dac72759396dd16d6d85b509db895343ccba561746b17f956308fd8a0f,
            0x4b343c3029acee60bd8e062f8d3d0ef7be8f48d919c85b59ba8136ee7378818e,
            0x73b835cdea50dd3527eabbece66511bf25cff9be6f42dbe8cdfee9652004c423,
            0x529dc831aa5c59ba4a8b3302a23dd4429e9c2bb33e1d109aef78dc32f1dcd8d3,
            0x2d3de7ffeac1f809bdd2fd8a3783b2c1df5c568fab3617df94a0ca31dd2e55d9)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 22
        ark(i, q, HashInputs25(0x226b9701639db4768814ddd59f3532173a5df005b7a651cfe49c3fc644962a78,
            0x3c83176e6e20de377435c6843657087a69b176df9e3a5beed7c9ec9439f15857,
            0x287d83aa980388ebb56ad479ef79eeb18b3d8c37b18201812409a934792bab1a,
            0x4cd32467054795fbe0ffe0a902bf46c4e0319499f049edb20a8a7b4d4bd14e60,
            0x036822873b0c7bfa3a8f05ce92decf023939f390b3671ff45a8421a463cf4223,
            0x04414170430eda3f5c4439e4faac9a876fa996845459fa0a03dca9ff9f64ce91,
            0x4145fbcc9228c2679b1db763fc117d413f0bc652093687bab8376f6ad9a25c36,
            0x62c87ba9e56843002fcead129a28d5fbd1b3650d7988fdaf90fbbb671b8794d6,
            0x50545947d46313ff07b5d0ff71baeba3961df7d7fcef032d54563a3af0c953e2,
            0x461fd9e6904940c20daea30db668803ce5b8029192c04f105f02e36b60c6b071,
            0x157597824e03754284c853116312ab415445c9e236fbf128ad2d17a35a75a368,
            0x3bc335e12e3cbd3b79013d9e1e6f38904e23cca67517d41711fa5819352f0f72,
            0x6a0045d833cc52f2d081e67584c87c1dd13da77802d7476454f3459d5814f536,
            0x30a56f29d8e9faeef0a9a67a90026e055073a51aba9720769abeeea77b79592d,
            0x11b72b52f992b346fdc8cbfbe81f957d6ee90e529d84a0af2dd8ead4242b0bd1,
            0x2f0c705d5bc532bf76f294f4f1a0608a9c8d10723d2043502899db27c0e15e72,
            0x02b5c3f4015e903da30fd8122a9998c3a253896d888494e8f7b1c2649472bd4f,
            0x68cf0991eb1ec706c96a2d8e1c3ff918c83f16bdf1f9fae89c649840d7a0b83c,
            0x080e6bdcaa17523d8c7c8313cbcae651df32c004cca7412890557ddefb3fb068,
            0x475d2951d4f1d1b0f70b443da41ee6f3226f2ed2ba6b33b8d81b9aa01c22db84,
            0x72b9c909aeb080f94b14ec48157e1b9fc6ca225184a27379293d05d8b434c891,
            0x136ec09c4e16048fc07223d7c88f3edbc4bc274c5522921025db03914f0cacee,
            0x41f47b168fcf1d29667a93059eda14f4591b0eb5c657079084d6024a1f36a446,
            0x38a3f13740aad99215e2b4340bd5b4f4706b1c58308dd14b7d54b6c9405df999,
            0x41ae27872746ace0e3631bf6b15f4d488c49ce7961ab4ac744676275cfa840c1)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 23
        ark(i, q, HashInputs25(0x2172b9354d9eddfa50eb5c727964f57d5ecbc7736e5c2b9deec2c18adaa5cb2b,
            0x21e67b6090274d489dec642a7662236775f4869c6acf7ecd0790b6af4718700f,
            0x732799cb6f78705933373917cb80974887a87f577429f3a1ed2924cd84fbd4c3,
            0x6002ee77242c0454e4a754f990ab8d5ff086db55b155cc7942e20ce817401761,
            0x09a2d8d951c6166e62e16223eb7a70e9b3e8aff19a61dbbcdc932704efb9166c,
            0x608369bb0d83bf51582391e89c4e682695a8fb9b2aba98a368c43265587d0611,
            0x5f993db1da79f411b5cdb4487f3b79cc734a515932178c9cb0a2ae216d066e7f,
            0x3f69df2c92f1b9381e1f1ceab25070148aa94a8ecf6d450cbf6450e35f1d352f,
            0x4d10343e9617b13bb57bda62f4e994dc0c299dfaeb2a7c22c225c0e505fcee47,
            0x6294a74b20fe1001dbc80f61550c9b3fac543dfba1c909d9301afd983759931c,
            0x038d6a514d868c13cad876aa81e17e65b3b155dee9771584edbb216e83b6660a,
            0x5d03c6ebc3ec66fa1390367e344b5476da067cb5e32e0d35f9ae169af26f5239,
            0x41364c35986c1ef04cf346ab4b573f9b23c3c8cf951f0d679df7da7da9a7c3f4,
            0x3bc1d0594f51927662718ce1fbe4d16c9a3d0c81888024870bd4d271ff091667,
            0x28fefc090aee99d76e8b07588aa62432daad412322a2678f2224f3bc71911a1d,
            0x0538d3912e322a5873eebc42dce227f3fed0df320feda903a6b28d00974d10e8,
            0x1baba992e25efd6cd4909568d6953dffc7e337da804890bba1c678f3505ca794,
            0x451381dce5a50295874ef1534104fe6178a39cf078ab0d02b9a3fbebae6ae801,
            0x6e6aa6aa93e38b1e9a249357ef5d3b530d38806d49779e8c8941203d5e65c0d8,
            0x03eff512d4a652df94b16c0bdef376b218d63c2575c4990b72eec6c7daf49ef4,
            0x2bf3bcd69538608ec51a363eeac9811902af403bbde3c6eeefb179118dc95c91,
            0x0368d5f40f889632a46543827912dae6d40a4086fe8fdb59bdb79a1ed5c36baa,
            0x196cda52bdd6ffc5c3ae7dd87f750479bbcfb4b56828dfb5eeeaeeb953b4e0e1,
            0x485065cd9d50749e0e209f08be8cd8877b852821e6cd731fefd7891b2b339a79,
            0x19de5e9720390f7bf74e392b4e518fa06d7fc15a7c5fc6a3aba5930d46e09b7a)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 24
        ark(i, q, HashInputs25(0x34e6401b0b971590bd595b9517fbebf2027a83ace68804f586b58e030edc019c,
            0x4c1fcbb785539d631c82dbba0ae56b8268197ee5a9047872d587c21b22bdc3d9,
            0x50dd6fd1f25db7a7e81de954489bd4737d122a878efbf94dbf7ab6124bcf6854,
            0x7043002b95b46026bd1f6301f62b6944ddd04ce93e6b4ed816e7c8b3a8b9e241,
            0x6829e2cf3d1e2289030228603823333902679e816f25f8fc02b13cbe0b3333df,
            0x14561bff95d07f599a1129ab5593372bce720373413255ed0affb88b99157756,
            0x0095dc455e177bbced06b27fa92ffac3a3a4e800ad83a9557f1159c23242bf0c,
            0x6a0c9c4f74e47ef7452630e1ccca0e80d226eea35f186ca9e84086d90095515c,
            0x4196a5d4e24adeae329f867c4cfae6f21cc468f1a4c338061e02adc692e2b1e1,
            0x3125c6c7ef2271118b829f8ac38e030f93de448e5daef0abec844e3c3d318840,
            0x4e1f2966e32f6648717b67a643bb5b87d8a981361fdeaf8a92086b9b87afb044,
            0x49c04a0a336a989ec8c6d4a2254bd2cdab717e80aa4ad169dbc630faeadac23c,
            0x7014062fc94d0df403e84a192229982f6738929eb268010eadbebd9134e75f5e,
            0x51cad3c4297a5bc642f06fc22142dd0ca0b8cece0acfb4d1f14dc39a041610e3,
            0x4fd749e80f8210fa8b9859d2c81a23c821dd931365149724a543528acc9a0c61,
            0x53874743c63fea6726e72eb1ca421ae0a4887fa5c2fc65f86bf4c545b2b423ca,
            0x2ec31ef2458a8cd03f7d5c4e7601967b223b68a356357dde09282be0a1c40d8c,
            0x524bd527fcf39ef29901b7627e864863dc88021db5846f285431889f5a5d997a,
            0x5d6f22fd06a378776a619618744d8b7ac8ab80f1b4ea75e046caebf0c1e9075d,
            0x5148f74ac16572717b0d63f68c6edf5ceb643712b0cba6b563b466826f138b21,
            0x1147eaad18e3574d989e2a4fbbc12eb548bbda2f34363e46dd82582f5f6bc75c,
            0x4fd9dd35c10ab1828bea21f2baaeb3eec08614bcb387dcfda1046611d9f5969c,
            0x028d90679588b3eecec5f45dda625e794bdba05d5eebaf5414fb93bda40debf6,
            0x0026d8a11d98a3366576ee2f6e46fe25dc7a3f9616207db35f353d139caa2d48,
            0x32a70304dd437de0840d5858be77144730bcfd1f227a0c9d5a721316101c3314)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 25
        ark(i, q, HashInputs25(0x3c4cfc22e1e30e116fab6cbca2cbcd4106638c6de8885d0e105cfe2c35994b5b,
            0x2e54aad766d026b73ea50491e9709fa772cf6339414910576277b8318f2e7ff2,
            0x49a6d8d2b21870346da46e1ab27814f752aa4f7a3576dc1996902aee2b8edbbc,
            0x14a6e54d30b0fc2cbdd13b0d831c8be730058da147a5a28890ba4b589b5ca305,
            0x328f846fa2fbc68b2767ef8d8f6eacdf302a9d8346c4970844753d69cd825d6a,
            0x49f5a59aa6b8bc677b3ffec44143e205d0e384fd160207bfac219f672c632283,
            0x199566d99f77702fb0334dcf0d58f4ba0e90607dece0029a749e460f5f9ef7cd,
            0x4dec519633482d9b9407869faed9624be9ff7d45182cca3998d20938016ead2b,
            0x256be171a04e49b5165cbd2d18e201131170559e2b1757032bc195d911a22b41,
            0x2022f3783a72ea867579a9ad2ba3159228f6011aa1a65496da71615bcf5c12e9,
            0x2313f4699699ea8029430180337a90104766faf8967369c6a016c9fc2bb5cbde,
            0x41f15de93432ffb41fa14de08cfe772166c1afb8df9d66889eb514155cae19f2,
            0x045334dcf66bc0f39ef1f9482db4533b9093cf483d3db55f6d21a7d32aea285c,
            0x55623ca8a060dbe641f618ee6842294cd28f1d6530a628314cc2ef7840715202,
            0x1af1e0c857023dc8ccecdf315aedbf5444e55a4368ce7b44f1569c64dc4bec01,
            0x50b9f3a0a548e36e9e58a65fce676c310ff6da8d52b01569aba7815a31c6cb6f,
            0x63dd6b4194139daf20d6cc2a0a8302547ebf7be0d8111c4cb771e130c9b02dd8,
            0x20fb6f849b40e6cdfd2c063fde6cd34e0c560ecf19b350b87a1f6ca56ad61698,
            0x421df36d6181a15696979e6df9a03bfe4bce08bfbba1947da2c8d00b8e4f4820,
            0x3946e642619a24e35c10e51e698da016fcf198106346e0d2ee35bbb0e31f5168,
            0x536347ccd631b326124390be5c9046b55cbb039046536ab0015ac6e9c981dca0,
            0x53edc37b5cc28aaebbac1d1732ef1877c294e5ead227e8460762832e667c8c90,
            0x47a476c031b862756f257683d9d82e9208376a90957b88c8b83b82b6efe9a132,
            0x5a48014bedd27853f680427711678966d20b5fe7ea6e73b8a2427a5ee7f3c405,
            0x611b2ac79ca165cca5c865bb746e625c11965d9cf81425054e154ec32cc4e6c9)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 26
        ark(i, q, HashInputs25(0x332ea23656c732ecf798d3e8f5e56315a14fc9fc818ee9878b1c0ca6dfea53c1,
            0x7277cb3649162d204c9eceac01d8ee45347da767ee2b901b19f8371148196df1,
            0x65651a8270af7b68f39ed9d6b5270cf671953b9e3e8bd9f64efb7f8e58199217,
            0x5a073da96fa05f324ae73f88d8c206affac632538113424479d0fb6bd0ec0856,
            0x5f36186bd2c4c7b6b85f5401359a3b4f590183ec296d17ff5184754957faf931,
            0x613945a396946f1526f9d56776fed804eb3ab4b215e3c99794fcdbbfd1142440,
            0x6fffe086386387f76e910735ed912b1c64f2a0d5d245aa21dba08bba47efc47c,
            0x49be1e4b13b8831f43b7e0c21658ab085f33fa88358a4853e1f4738aa0fb9141,
            0x686c9c3bbc52395ed9714c4ae78fd873ded90dcbf5fa84ab197d4c53b2d33a7a,
            0x0f7ce87ccf0290708f8ec92ca09f79a4e3efb95b5fc152fb66dab0f7c7e29db0,
            0x491a8210684dca40d5da3a79d6f775aa50ba30645d5378236df98c35c291788e,
            0x66f9754bf2e98417484d8b76992310fbf80853fd147d5da893c7ba3e185ba668,
            0x14393bba02f22b25f68f718750e809c7e2197e9e1c34320742074f1efaf1a77d,
            0x0e28c69bbd698ab48f2ded54bcf3d5cd07e26612fc869e1490c1b2914d45f8a0,
            0x4b711f70b05ea5516efb3eabe93b1b768d0c2ab15b9ee7086d69d0bb466ee4c8,
            0x43bf350786f103e9ee92ed2804c0b48b946a8dc3d8df180e5e6f7a5821828462,
            0x4aec920536d8418ddb95b244c311cd5c80ef57ad206b549c1c1063ed346df85b,
            0x685215e7ba25a3c2cf6c94c41bcfffe988db44b23662234f09001868df9627e4,
            0x727599c790f2ca72c1c3bb0fd59e953e31593e8167f174e0cda3349d8a430f7c,
            0x12154c010cbbf3620b2aa19eacb2056dcf3711398ea95a050150430048397747,
            0x32d1697c03621949fb1a771feb216106d649f4cb9270a0aa9fc67cb9a185232b,
            0x63cb120fca3397c11928ca3271f72db2590e25333ab4055b97f621e798ca684a,
            0x707833d5154a2827f03af54448326e2537a4d7ebfbfbd94021c525015bc4c5d2,
            0x5be18bb4450898432f7841748301f31d4e6dbc8b44dd11f04c502f30f56045e3,
            0x4fbdd21d6d5d1825d767224d96910458fa460fb0ceb9d7f96df1b3b8db14791f)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 27
        ark(i, q, HashInputs25(0x6e390e2526df69ef62a6cb24ea8a1b308324ba5a4f4cc7ee7abdb29980f343e9,
            0x3443c3867dd75c90e0874c41cad585eeff2c9fb8317e638ced326f5efc502683,
            0x632e5b5a4fd1ed0d5766ec819837a2f415bd1f1c4273407110b93f54e452ace0,
            0x5d6f1aba6087aafedf29932d136ade54748bb2cf226dd68e316e5879e4595d45,
            0x17e47a156c5d1d796280a15519e55fde2bc07b90c5aa4df9f926ffc9c6cee3b6,
            0x4476fc42eef8d67bd1536a039465a51e1e2dcb3dd0a981abcd5a8b4cbee64ca9,
            0x327a8fc0ea3ade9bb67667906c502719512390d0a5e0857377200734c290f85c,
            0x707423279fbe055523d5b57251f489dd9e1efc7b9a6ae4290bb2c59a5feccd3d,
            0x6e823d21e5452f4ecff526bb7959194d61717112b8bdccdfce8e08744c411699,
            0x1b8cbc88a89d8969a146c7f91cf6e875c9d5512ad89f38ca2bb4162f775fb19c,
            0x311b35e82754413d8b122f788e31217d6212125f5aeb2bb3a8aeb5643cd7bedb,
            0x2434b6caf3f19f8904d0bbd33418c7b621803c8efdb322391f4c7af596867e9b,
            0x449c902cbdbc1ec17b8f5159b2390e094bc6424c76654d60dd13da6327e745c1,
            0x1467cf82ec8d7413280f609b364d7f89dcd3a72ed1ac6c964394dd1145943695,
            0x0053a0d0fc7a57dbd95deb6ddf5680d07438c07fdafdf772487bec6d266a9bcc,
            0x4ad1c7b769c1071652ed2de4ee3475f3b208f1f3a570a6e80fde33b99bf8253e,
            0x48a0347cc095fe32fe18576a506f6be0f807711ac33a66d193e5e7bfb234cfbe,
            0x3e0d0ed3c1c42a435c94de0b875494f1f18ddd411cc4104e30d3e83ca6f8db39,
            0x0cd3ea604b017f8e45c83698f14b9b33913886e90ab5f4068b47c9f005f3ea15,
            0x39e146a0cb5bb2e5020e3ff57cd6b1c328f26d05590c1701119c7a1909d88858,
            0x4b097b8cab7a478094da646d0ca8430d288cdb3cbd0b1e87d64f4e519b953b9a,
            0x6ab9c94b43506faf45dc95c951504154c4dbf4c6c1abc1110501e3a316e4d471,
            0x306a291116f488a16a65f2f080b79b04bfa25f3caf276fb1b66e67cc72211efb,
            0x1d00dd486feeb47042779d01d7e457595b35178b10855e7122edb5e54f243854,
            0x612e9b98520c6030088cfe136e153be474278ad2ce42b35dce7a66c5af160335)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 28
        ark(i, q, HashInputs25(0x03db6a419a7606768685b7e34e81a55a29e6e67b6c292e47fc682f14eb6264b8,
            0x12217d6b675aa74aac91f870c7be3a06c7659192a7cd76f9881e677147e06c5c,
            0x04dc76b27fc1505f3b8a8ba118aca89d06b170af74ee854f95147f6bcc0f7ac6,
            0x6c1032c7e17850daaf64d922091fb66f8140a93f2ea8fc52e72e014327c0db4a,
            0x0cbf84522f643e8da991389d38da1a783075ca1de9f8ae8371346c51692d9a9b,
            0x3670823d900bcf58cb8053eab5764f93b8eebd009e4c0c63f14d8ffa88e5e194,
            0x00c254dec0ef600cd65ee71c32f32c1f73d93cb03cb12d2e1cb45fce59f40926,
            0x4a035d066454316ea445573ea5e2059192511721b98e4c98bcb7dc754857c2bd,
            0x52afe2a41ff959652aaaa0d0d23b0c5cb854c0621aee53beea5979308c7806ae,
            0x4c97f21cc76d5607dbd2095bd21936f40466f0938cb22f3448851790fb1f5441,
            0x0c2105c7b23eef4b59c51f68c07f0389404cfe5aced2a3d83ab2607efc0ab3d4,
            0x5fcc004341be5b17418834da7aba2d4f6cccf426a57b4f9a2bbd684d7c974538,
            0x4dae2534e79b47d1b8b38a77cdff86c47dcabd47d5dbb3b6b9dd988af741ee94,
            0x1caaf11397c0751b5ce0c8cea8c24e743e34ab8dc598296dae00d0905a67bdfe,
            0x2373b1d70890fc97974a83432e429010c8d7d435bd3ce8faf78eb219ea82e031,
            0x2f41b8d27b6c44db59c11909328b7a67e32a80a6d73b0f339a7ebb85553f4ce4,
            0x3fa1cf60bf741d2b5046a6f40c644cd58053ca6627c2678b8abd627eca58ab75,
            0x1ce4f195b59ad66ff4ff95e09336be494f1b75e3a16205a07216ce3bd4dd7306,
            0x36609bdff41a91a8820e53c494969954d71657d487fb9d328cc194f60d8d8547,
            0x5d39cdbf64144ef7cb2cc5cae8b508530c1be5745b8ba3c2aec70d59e4fab6f8,
            0x11e3b46927de729de5817d7511d898132557c6af84098145ce2c5fe093d7a7fa,
            0x6a90016685e317660d9650b18dea984879382a25fbb294d8bc4429d50b36afc2,
            0x43d03fd14d3d7eb01cc48345c933fac22931dcb8f8a0c5fc89c0da5a3c0c3905,
            0x53d747fa8764049185cd13eb76d42accc56b6fbf3c27c540c78cd0e5d0a2770b,
            0x065aefb69169c650a9c1cef0c5844cc08eae24754c4da5153cfad88d401e5f7b)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 29
        ark(i, q, HashInputs25(0x048bcd729ac9eb68bafde78120a7932b4cd1b244c809552aa25089d7a31eee6b,
            0x5c4004f75ac5610ce5326ae1450e2c85764f1944bfef65b0d9aca721d8f336e2,
            0x6e67d6debd478fcf8cb9569850b40f7d96097634e27caa6f2557d87b920c7765,
            0x46e93293dad1a5bb2ca2b221ccaf151efdd8df468dee62c2f242efc2f70abe72,
            0x673a6834fb90df008a9a9d143b404fa60660b0c2838a0d51717adb21419b530e,
            0x17b2f7712ee84c2d4ebccb2eeced044772f546dc236f8c1c192b04c0c389b6a2,
            0x3b6c7f436812c448b0fffb678bfbf7416b62fe8b444eb6ece6540406536a3640,
            0x663ce4bd677f999a27763655551d8a6bcaae12eba92fe873f5bbcdf989268a55,
            0x734fb2f7222bf7f2df881f85acda9a3a97751bacab11eef081a9c737a13af110,
            0x2609d50c8d9423d5f7186f666ac36307e021ab20369cc034e3bc42fb581fc941,
            0x52025098d9779f420f64837ce4973b8c12de1c379c045471e15080e849e8a400,
            0x619c305550960e1bbbc81174b2625e93f7c467f31d1830f3c98102d5496cfbb3,
            0x696a5f30ff6d28376d3e85db8d36888eb181bd34dc6282ad352579845daf4641,
            0x56c70eaef4d61703260b17e6472d45612233048ef52c2d2620003492b4ae5528,
            0x6d2d48bb8c8e0f81f997b9bb22254a87815cfc11620a9422b06a3893e7550382,
            0x7330ea63cdb0308a21dbd2e717df4563995c5b264aece83971511d466c000da6,
            0x5f4595c1468323713e57e2d99a4774fc9c84ae839f449a75e9389933623c7f3a,
            0x22e1e47116f8c0c41dd5d7d6e4101605803fe70d38d4a0ac9728ec486e9c04c4,
            0x4e2c004985585c645ac1650d7e2071e3c7eac2e1e5a8b50d5b3f988910eb7237,
            0x70f8c972b2ffa041d93403f14be163ddef5e7b4759ca87e195cfe8c1a1c1f6d3,
            0x29cae36bc6af51a25bd9482b77de6d2f64c31f94afcfbc10fced6450a9971f19,
            0x011961e3008709c73790a360b7540be35c148a34a74a4eddd9c24231e12d840c,
            0x2adf0c368665a3226cc04905333aa59f01675cdfb5781407a8922405955c601b,
            0x2016cb528eda2cad108dcb08d0821adeb17716dff6726c5552992a11e7326182,
            0x4b17719a5962415189dc0457ae3abb70be788802f6f82c79d54fcba35ec41396)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 30
        ark(i, q, HashInputs25(0x6c094f67193f1042d7bf0006bc77a2f11cdacf4e0ab8e58b2a35bb943b1f53bb,
            0x5c3a4442de1a1712d9e3dbafb7a5922655f99724afc09cef6727b19c3a1cdb61,
            0x43622ea8491238dd6aa254dcfaf8fe8af7b2f025d106dfd402e3dd8c0be4e80c,
            0x5140062a6b304f0a6fcc71d6f1952564dbbf59a48810faab952796d2a4b8cf6d,
            0x59ff637899fe89d97296e1763855bc732e963617ee559abe2b35cf65e5887689,
            0x266a3acf6d95ac86934645553f0f9f3ceff6c99246a7f91df8aac2590363bd30,
            0x540e9bb960705251a1b54749aa53a68978e2167adb2e2dee4f4434868f2342d8,
            0x0837f869b9208afb5bc3f5feb20011a75dbf2cdaacaaee2b2c332ac1a7d3a321,
            0x36487fe92d4bc0dcb5bf9fdddb6870995896cd2996066659c047c4db822e22ce,
            0x630dc90818d975b49651a8143ea49f32b625e5b1d929d6281d7a91eefd64aff3,
            0x4c41a2cedda83faeb3338e78366a8c05d948664b8f616bd64eb2bf12eb4c1b10,
            0x1bde9f395ef69f042c9fde68a01c77159af067370cb41fbe9b3be00ce85dbe4c,
            0x0a557cc7276f466f0e7dec0803a815a1d91c7516f4db15a9a6a47905ed12d54e,
            0x33009faf0fbb7752dfc1d112d474377f10f6a112884b45fc137acf73c28f3ae3,
            0x700fdd5e041b72ef7068da7ddb4894e274f0984602142fd8733a61bc725616fe,
            0x0584b1ca5a1be53bd315e3d4d9b5c824d3c5b19417787ca1d22a51d7266195e4,
            0x41d01a12f4b5c614171610458d32b05d6277e2ae3923b71a0f12b020949f76c3,
            0x4dec8ec81df9718cd47e388910ac6bf97894eebc66ec7f063fcb57fe6792e6d8,
            0x26fb6fc96c6cef71a8363986ddafb2368aece7d3b1d93fe9995862dfa776273b,
            0x703e1848c2ecde02d7cb8d4bc01ef386e34a4f8d23be7076f7980edd5b56ef8e,
            0x42413696473bd9423d664b8e7c2850e529cc14fddfc5249ba8be9368db6fe874,
            0x29ba1219dedfd87c79650a1376ab63d3c7482033a56f5bf6c1ffb3470bc51e92,
            0x4afb8857b1996ef2421eacf001570a091f038e5a1bea429826d3b736fe1709c3,
            0x1ab16906f3ea0b18cd4de1c795de63b627b2e1112bf50dc99c06063f705fcd99,
            0x564536aec3940998ce19422c52856ae71fc736230a990af8b6e6a546f9b2f94c)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 31
        ark(i, q, HashInputs25(0x516fe79a867e634a8381cced9c521ae58cdd6c845daf4aeee936e937bec48e0e,
            0x10f0187dd17804414c8c32918c35bba736c973db7badc2e566727cfa510b89b8,
            0x44ed4f4327c803e6504ad6ba89ce3faab6fe3e19407b7f735ddb3de7fa7d32fa,
            0x0d5041c23ddb1a56a142a0f62a0bd0e3d8128251b54e4669f9dc31d023c97045,
            0x07addc7b64f584b0ad0e6a636a56507e78e3e00ad195948bce017999c0e1fbca,
            0x66d452191be1cb7ef54040e894e2e53c83cfa73f875c66e99cdce646b0930fb5,
            0x39ec6011e5fa3f39cde2aae57e691b62821bc252f88bd4ebb6d7b8946d113a45,
            0x134a99973b250f2736dcb98571994d59e71ae8a48c187c2267eeb59022078e72,
            0x2a01aaf39398b4127152a0edcee02500daf2df1d79aa48a84a2064e4e9ad39ff,
            0x28d750d17667d761f98c49b8f330e1e64d91a746666dbad26e29710c4cfa5cdf,
            0x50c44e973535d896c353c20a84f5b8dc21aa00787dfd3f45aa75581258838e23,
            0x5fac7334bf8a90fce50fd80364b4afbbc6797c992099a7ef1c581a3b2cc4689a,
            0x6bc42eed964e4bc1a3eecf3c65ee6ca1e5026d656cfb3c2a80da942844b9dc24,
            0x64d800c2b1c8bf656146f03a8b532ebc3f6e690c2192326824be4ea79d4339a1,
            0x669888797ef35af878e038dc3f6f2c181c6d754e51a3d7ac492b0a0b8c321379,
            0x5372d733b62e0240efd1c0fbf0a18c64bd3c3e88cf4e50ddfef88ec3308f7668,
            0x4b5d6abf84ba1d56c207f004f3157d5c8a52b8b05e0a2c344d5f77cd6c69f748,
            0x6f5a6a3b6d88ba2da95775cc5ed5ce87cae8d8ee85a11762c53fe05f599c3a6d,
            0x14f981763b242f20c9a4b19328c287e737771c87185865ed6b53b6e59849dd4e,
            0x4f4c7e4a3e25776947068e4fb4e53c415c01e022948795e5b6954b1f8008df99,
            0x284fb4d80bc79fa9d1b0df5b290d8866505a6809973f5c13f90c94ae0153e8ab,
            0x0dc8da8019301152971d0f32f8adac0cb486d3ca0280f1f02801fc937142db2b,
            0x5958bf625fa23fda79fae0bed1c0b14be1feec5a2d48db75cbbbf36f2825487f,
            0x088dcc82f01141d587bdc1218f1d5ea02ff85b338b8ff237757d23c9f51e6caf,
            0x4a7509fe25893fd2cae05ce39a5cde96c54fc7e287641fb5ae90b32b2a380e12)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 32
        ark(i, q, HashInputs25(0x587107f53f273aae756ef91fb1057cfd1e6a923250c97c196e581aee251c247f,
            0x103ceebf2d11bc58945c7364ab098cc863f9fda281813de3ca262a290c3b0ee0,
            0x51353907a3ae6036775c6bd10ac049144b439d3ec8513f03c9ef1aa47f2b1b78,
            0x3741178054d61f1c34fe12ea9c030da1c4777019f0ab69b60895cade0b3f1135,
            0x2b595fb8d0e9796f1338fa5efe3ebadaeb8095c6403531d7d58306150b942e65,
            0x25c31a93a8c3b1792cc38024f03b5059755429692b54a21acb3de2efbc179862,
            0x1aadc95f99d369ec702a3ab83864654ab8e58e6ad2dc5fd22b03cd5b4b471ae5,
            0x0ec18d3a803a6661ceee57276a01406b352845fc3906d3d1bbf083a7e44a197a,
            0x403fb10c7a230e6bacda46bc7fe0c12da413f170ab3e3703c01c9e63bef9c89b,
            0x3af641e69eeafbfd25d1dd5ef86c1db9fc77da0d4a7611c21fbc6c52bc93e729,
            0x5605acb85497be26764f4e5c73fada14935e0396cbd0edda562c28f68e3395e4,
            0x05acbde5a10cdc364f977df2903a4c8fc2d63aeaf17b5eea0161ee6e074a5a52,
            0x049757b2b8911058f0be662463f2d42d4257759cba717fb2ad0396a72cf5408b,
            0x108e7549c1fc6ba78fcb9eeb2c8bf673076b5ae9f43a9d89a21d0086d475169e,
            0x0b15c946ddae387daa21f36652b0607767d4b37ae52d3898d02c4327f6e6a321,
            0x3dd7c5e4d9ae2dbae9c899780189c9db701b57f0bdfd316be7740a17b05e2671,
            0x616896e2e9d0f0b3b43528b77f88ca120fb86ab2e1158838612a0e7fffe1cbb4,
            0x71d230ea5b59b033cfb27557f7d9148bc2d95c13f291ab73fcf8b406dc6b7eff,
            0x070f88fa89cb3785c271f1d3cd3a3aa5064e20fcd44d647c5641eb0fcf031325,
            0x3b93aca7c41d22eca1496bcd67677312654fc39a0f422213525eb46822347354,
            0x45535cd183dc55a1a2a424c15809b0f3ac6001d9cdb8b726e6f026189905e6bd,
            0x19f61bfffb0a81aef0566091017c52b6226dd179aad5c0d86df2a2e698d612ce,
            0x58b8a3603f8ada0e4a768053683972e9b5b209cf7baedf6a768565aa13f6bec5,
            0x0fff426654d5ebb74e4f0905c9900ec6540c680f8241e10b0f2b1fdf8d52a200,
            0x2f934ccc9d09a7543886297a1b0c604d5280ada86a8297405edfca2a97d92139)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 33
        ark(i, q, HashInputs25(0x6e2dc60e2360004750cbf0ed70c9ed6fdc8299f10586bbc892166b7836f786c4,
            0x03ced994ede16b3182dda50d7ddda4728f633d55cbee58b4556eddb11a0a5a52,
            0x4d46ba1a8dd9036316c734828b6db90a2569205db1cab0851e6945344f76cd61,
            0x41cb98ca23d93dce2106542b01104450c3899e8d58ed50327d2fdb393ea12d28,
            0x39428ad799d5291bc3f2f982e6d438007f6c0f39a0fa74d32507ed89748b23c0,
            0x5c43e0115821a4634c43f45e619d887b68fb0d88ea7ef941100fec72b3f65a9d,
            0x5085fe5941cc3ed56a0ca11f01461bdbf58b0ea77db1457d3bda77c2322a2157,
            0x04fe5807483af611ca36b371d07ca63d319c4ab84e876d725ea08e52043c18b5,
            0x315ba86cd66333c0e2306ec658a1a5d5bd6f69e87388c6c822e885067af206d0,
            0x1508f032972b589f109d2822942fd2e401d545568da2325c8ac4d4fa864a844c,
            0x703b47e7f58ee45054d474b0e4db6c916387c1a2224cfa426c5345ce445e14dc,
            0x43a07422fed04689afe9bb2753aea052a2ef8ba0ea0aed6e52358282c36b6d7e,
            0x3abc5f9d41bba4abed5a18e596abd39e59cf17207cf6698e615b00b72308ef47,
            0x724a313c9c7dbcfd1db00955d2ebde093cfeb567109f0f57cd8959903ceff549,
            0x0cc1e745e7f69b63d3c96d32dba2c883e99dc3448ab8a99a4e0b1a068ca81762,
            0x4f5565f9ed20efc8380aa9e9898c1d47cfd92d4712011046d0943e67f4f26f8c,
            0x65e2bd6925daad63fa80600599fcbb3eaf4bd7250d536b7062f0964159da0e08,
            0x43c084998ffef64ac37c5edbaefcfa7b9aea49ccab5e94372f32cd28e98618d4,
            0x38792fc15cf4b55c69f121bf828122328d676509c36680d8a008156014b09e25,
            0x257a3f5246d6b6619cbb8803fa2ee29a1bcf315029cc3cb370748f266c67e23d,
            0x5d2836be0ecf958b88b9c327c0bc64d967da9356059b25e9ec111869b8aa7ff4,
            0x3da919357862ffe21b4faa240c1adcaa9b971bea746224863d41c905d6e9ecfe,
            0x560af3f48e4fe2ba9f4e5b2a21019aafd1c8e03082f200d28faa66c05f8476b6,
            0x01c41995b781a24be7c6d5572f009b0b53c6be262209ef79bb23f51ef9a62a96,
            0x6cecf68ebc0cd2713c65ffda793d3642ce3f40afb066c630a35474e24db61793)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 34
        ark(i, q, HashInputs25(0x27b871b15c9bd76dff4751336148b23bdcc76070111fe0cf49eaa59943dd4891,
            0x5c925aa14c495f43151bc832c934a8f554a0aa69aa180e63a0e7b67593972597,
            0x4eb9d5a2e64196fe18dcfcd7771d044efcba4b1d92d0493da82bf0fa62047757,
            0x4be9c8c38d9bf714696b4fad317bd07502aff865caad95b330316de7e9d9f071,
            0x5377c98c9399d0ba23666ca7ecdcd8622d55b34cee01956fef4323db63cfeb30,
            0x021646320448834d683e7807e52924f848617114ab85d88e836031ac6ba0031f,
            0x649409f5793bd8ca40a3d6875fe6842c8600248c4c56e51ce085c2845c8ffbf9,
            0x08c3a786853d95eb08cb292af0dcb5de446df787477b7386b5d872fbee78b03e,
            0x4652465af7bf2906b270a5ee525822a70cc5039c64222e418d4d2043dda717ed,
            0x2613f97a1b8646b812aaa616a2e4222d760834b66b68fbdecb623b4fc99c4367,
            0x2e0a37de822f736c17f25b107128eff7a931e27f1b89e0c29d32d25c3bef60d1,
            0x69f80109f2f7add79f2d17b8b563c37e223a9aa2d9c12d4dadd67171a947f0df,
            0x2cf2e0c079022142e2485d78785500940646d33975a1803de1c09d4660bb1966,
            0x35c8abaf11d57a611dfabe18cdc685c9dfb9294f76eab5823649ab8045717d53,
            0x3b5bf0e1b6e43ab8435bd679e6a8cb21645850f9ff5cd4df128b7de7dddf2573,
            0x6e0b861faf5e56a4744d443a70fcfd16e53ef8d6e51a1e507dce47b786b380f5,
            0x5c1ed680a8aa022392fe02439456fe8924907581dd8b735e3ae12f1521aa46c5,
            0x3653d263c9e84a3d280a8059e29e02a43c565a3ff4124c81fe9d0ceaf66a6d40,
            0x5088656d64a603ac730e6885904ef974dce98949bac7abc38a6fe14a5c1ffc41,
            0x66121b0733f79b6e0ee4c1f1d098f36a80b55865f554a194cbb3399a4f5691ce,
            0x2174bd4adfff87cd59822cc47607f45b7a39f8551269d2ae42781490dd04a075,
            0x066280b65800aab93b13dd1adf4d588516e1fb48ce4a7730dc61721d3f22be0a,
            0x04a778284b16ca45dadb3fb89e22ac946fa78f699754ddd442df4e6948fe159c,
            0x6a90686a579cb8cb09f8dd872da800de96b9f52408182ab10d955e3c1789d779,
            0x49e2a3cf019bd92bc345b2fa928fdcb48aaa4e2cffea1f7b80c259af4dd97d22)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 35
        ark(i, q, HashInputs25(0x621405fcb777513d689d0dd9c85b89ef44a233bc700ece3b320aaf31c505e53f,
            0x66079c23de545a83dd79e90c734e7ff603fc9719fe6eb705338462dc3a58cd55,
            0x5efcff015b05b54a2c6553d63d5674f2770ee4d210523013c8b31d5f6be5cf78,
            0x08373fdf58ec3b719db87c9eb546c0253c2b378b2c988e8dacf96ac1f4565241,
            0x2711e9c891d55187662716109997b61baa4aa1086770564fbffe3ebf7ffc0b60,
            0x1d6130da0799db6d0d2c580e70231064eb692e6e3a6f9303fbd0d7101ee8c2a6,
            0x65367d9c2394b0c13b147f1b5bbdbcd3859ca081fed3e9af10275903bf89d326,
            0x24df65e6632f5138914e0f5cfd8e5e5d4ba5883f5f6d9f04eb4ec588702b6e4b,
            0x681c8a443d4e64fb533c6f3dbe53e01cef75ad7ee080683b009a3ffa0f5c36d0,
            0x21c3a8c89b6856bfb54c14404f9fc7c2e7142d9f689f3e46f8a81542af13e1c8,
            0x0f5dc2e4b78e51c902909f9befc2e772ed2a0aefcf3d2b9ec1375471d31334a1,
            0x6aca7a06f4c1aab632b40d5487cdfc8d5d298812048d2da29d8f82d906839869,
            0x576aa486868cbeefc8e197a4834c5517db9ca07726b4662bf9c8524d8679a238,
            0x6370394a1806954e6ec68ec026d4c30c11ee3ce08cd8e406f888632584c6ebd8,
            0x0255be985915f32de3425c12893ab7dbc52c0f9fbf2011c19af3f9edea80db28,
            0x698cf77bd249837ec6b43474d8bcdabd60cfa91e36d69397c0c73856df7171db,
            0x2db989606896ffcd2ac63819bf1d836e436057b87c45f78f0051a5b77adb1d6a,
            0x42cdac224a60bf2a8b6b7d16e5d87055313a51e63d683b22aead1f11a0dee150,
            0x5eefd49f69abda1d9be9f1f25e6af820a6bb5d6db73927e9821c2b065da77bb3,
            0x551d88239750e7d796f1482e1a9858be6320ca491c94fa49c3ebf7c7218c4f29,
            0x38307c788b570ba85858065b9594a60bd253d4fb155080dcc5b86ad8fbe7a056,
            0x2a6e239dde82dc6081047f5d2b253a15e60bcff41c5810b3856ae5f1b9f50476,
            0x2d42ee57c3f081751b7eb1731565487d01d8a7ef97afb474ab8a958121518d4d,
            0x44672b1203ac081ce3e562f47e91074fac7daf0d494d186554e9de6c2c1e81cc,
            0x3afaf805dc6371581da4130e7e97aeaa7bf2a19774a532c2082d2459f40fcf2a)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 36
        ark(i, q, HashInputs25(0x19406a08d3598539ad9c37b773e4fbafc7b3872b70fa64e35699c9343079dcd7,
            0x34df9ff6a00b11a5fa568d93eda017c31965be230f48f7aa8a8bac733dbb20ab,
            0x1f0faa7e91f30711a7beaff3df01c4a1875a10bc8cd53f79fde9221b8245473a,
            0x045d473b56d9b49b998cbc13f385e2522ee8500eae538466bcf9ef7ccd87e0c2,
            0x187d5824c4b02f155ffa1c3f33cc0c3c6c01c52efa4c3210749a4cea1b027843,
            0x1cae473d6244a8c6c9fb568070c8042f3471f8ae9b1aad9425ddffe4b771851a,
            0x62cc5e2d06dbaac34022420d4d1e7d1b72070c733333c5436562a17c646f682e,
            0x3afcaef66f9a8a2ef8aab675caf219e0c90b1b7ef7b517fd510e3488ebefb5b1,
            0x22ba1387e8d714bf9ec98ce55e6e35fe055bc9fcafe7b9cfab790630c07d1968,
            0x3c4d04e8db4fc0e53e5cdd0271621b69437f977e0e93f3c4af1b779a92b40cf1,
            0x49c7244c563a76cb75bb29c8b0f005a0424198b28d9dae409cfb8cd487e02f9e,
            0x36d8c1701083c1f50f58da12a4aff2b891690df9005f5756ac0ac9e13afe8d77,
            0x6ba352e6689a79161f60b01166e88ca41c2250cb94dec593e4bedbf1c9e3c635,
            0x56e9099014f8b88571c3940d8fef940e06d7db00ebcbcb565055865df681f7ca,
            0x1b4b7827245d2c44c877fdb5386a15faae7d6f6062793656e26bd5fcf45c6cc3,
            0x02eb095d7274070db4095502eb684c0b88a02d4751db9c20edbab90d61d294fd,
            0x44ed6ea3e7450e7e085fed491e1f605d7e1f1697cf548a9842b6640b9207bd70,
            0x373f9c3a230a93816c54af393f8cf7dc757fdae3d9de82ec1669e250e95dca2d,
            0x31b1e971c97b67157986d4658bce73660606e8bce3891b46fe96c3cde20d19a7,
            0x3d1a75d4b5029573e3cfa6c98310ea416c88eb83990352b88906232975cc99d5,
            0x118d195febda8143240ec01b01d70cfd8b5d5eb8585ab1e84d08363d066a040e,
            0x46894b431bf0161d1aacc924dabcebdf7841bfd930926783991d4388ea2812c8,
            0x30689092c96a54ddd4c4482677dfbb3e7e2d585e5d7032aa28f0a723a07f49b0,
            0x194d0036d6948132290b1f44c84cf38406b4a7a3d5e16ce38ac0e22369a82bb4,
            0x150aec01b622c2b7689d3bfb61146bd7103e160cbef88cd6c1ed17238237e0da)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 37
        ark(i, q, HashInputs25(0x5b026749633f3bc1f29e3da37ad433dce2df3b171b0fef7b6811f0b050c598f7,
            0x4d352b198eeef08951b605538128fe134631838dc023aa06666bba3f1d1f3e73,
            0x3e95250cddd59bd03c4decf7a36637cd61aad7d77063b89621363033fe60c5a8,
            0x3a4b9790763eccafe0186867aa9483b4cbf13de362a3d815d1589b838b43fe61,
            0x408b1a3ae006ccc33ac53f98ed45ffa2c77b5284ade09650a2772c80551bf613,
            0x140c82e86474a93393b64f309b82cb8b462b996783df933c93fef1aebda152c0,
            0x3565dfeab50b895a5d105f1a68fa1814dbcdad41b3f0ed38595ef7e31bd420da,
            0x6239535551b90529bca958ce3a5a15757a1284cf8ffc6fb4a2173ee4e634a008,
            0x39970b5c5a8f996f5341e2e109c8a9b9e65f1f7759d15e6b220f75cbbbd7e8ca,
            0x52e96c6ef4bdabda364360d79c7dcc624d0fe6e4899c0dc0b30a5c866e3efd0e,
            0x23adf50f010ccfd6433f0314f416c9b0698d12ce607e41a58495f3e0eac4b7f8,
            0x07679fc05a617aa9717c5c335271105316976a05bfb4f98ab785473180c8658b,
            0x57b1666fe0d75021dc53e7bc0859c81c90f099ac8b173d2d6343daff50932af1,
            0x73230a1b9193e49bfac3d5650a6a9a5c0a4952849a1ed29bba20fcf5bfca53ce,
            0x4f6f11cab9a0db5725ef5d9c3c870364870c560b0ab9a63bd5079288f5e014b0,
            0x60cbb2b11418cf7fd1228d07533f7268464e1f8db1e5dc1b3c1dcb1a8d5b3559,
            0x4d0f911bf4412b5fa09f8a27c55898f7ca811308841bdc692af0d6274fd683cc,
            0x42b2a8c91e1de66fa02989175f78e2e62390a3eb74e17de96e5a9e7162b74de8,
            0x20f5404875f3aa0afefc7c5a21c4a91a556bc43dba9e31e89c9d03f58db7bb85,
            0x17733e9c4f3e272bba0421fbf5ddb1bf7650d48d8f47ed2623996af040160510,
            0x6c8d4b289457a1cd67799cea2099f9406d04bace68919dd1163c49841157e874,
            0x560c386b141a36878dcf719c5b5a1bb1a1cb7f8929985ffe7ec460e0a45155ed,
            0x73ed59c776afdd8f03f8e477b5f826b4d81fad6689d51dab819def041b774165,
            0x2a034b677c82fc5aec036ddb0ea2dc0175ab2cfc2663aab89a08ac397cf4efd3,
            0x427f4335777a1dd956f91ff1fc7d30a977ba4371f7061813cd6dd12c23bbc8ad)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 38
        ark(i, q, HashInputs25(0x02c01023afe454916d8b224c92ee975d80a9df8a11c48f8e0960db306b34b4e8,
            0x1877b1ade5ca8defc34d379b18aeb7ca909a085f13eade9f5a0a4debbeb4f564,
            0x5f2272eaa7c862d612974e4c7917a7d81f30f20a809038b2b86b53308ac23441,
            0x0e07e4babf3c0cbc64dc7cd275da04d2d2e927c5b229a9ba950d217bd9cf72d6,
            0x60092d0302da8ca8a5050fc795f388cd89b62031f738e637ed2568b6e0392231,
            0x04fffb5546066f0088d56c595893a669679461ad5510b307a06c49d58bc1eb14,
            0x52c496f9ff68982e1b37935688745f6c54955952eb96965c45844d8fffbef024,
            0x65bdbfd53b5cae272003aeab23ab109f01cd8251d5ef87596f8456802c65c075,
            0x3f8e3caa77ebd56d7be7069834a2652aea0042deda8b51abbcc6484403e29b72,
            0x3e40cfd63eb9bd20d5364a5ad0b0109fe1c1dfbe052a14e71c1cec40b67c8a17,
            0x14c9199f7c1e1bcd49a89903b7d4e5ad1c2273764d0688840ca982b421b7ccc0,
            0x23e96050e18f43d8646f15cdcc8bf285475c24c054ffa92aca2804da21cb0d02,
            0x174e586d137578ddfcc487bd720a951361b2c63c003053ee13d3d4d7b6478349,
            0x17698fc9f0cb465c4ef9e67ada5e14998d6cccd26871354d4c9d7f7792318f19,
            0x56c011dde103d46b9d07bfa37fa94eeaa8e572b19ebe1ad5fe27aff9641c1b8f,
            0x0d25bb198b3f39c607e4c091542b1285db6ac533b0ed3242f8ae2a800a62a379,
            0x2964601bb39f76fd59ead36bcebcfec3994807e561da8526faa9d3e7d018b832,
            0x043a10750e5a723aa7cdc69de097d2bd263dba79ff4f30f97ae92c86579bf2ec,
            0x4f413c00ad72cc6f09fa9fed53de3c281332f7af62c1cf4899df984b8ce91ff1,
            0x0f5cad43cda0dd190e01fcbb210728e9d816ed96a2068ffaaa10b9a2a460f4c4,
            0x5a91c5ddd8b9733155b5dc19c27fc079fa130b6cc4a0730cada0418252914db2,
            0x7312ac4afd9f2829f9367e2f530c29a91085b4f9724fe60504ab8ad45dcc05f2,
            0x052b1750f60c9bb60cc2a80c0def0fcdf911db9a23c35ed40fbe32f38be27e79,
            0x56dd7bdd2a2ed012351c5833ab8b31aa21d2d613fb1a511c5b5ab5db0d80638a,
            0x013db1ae4b19027c92213a44f022e306f79a0a959ee551c9201e1727e72ea687)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 39
        ark(i, q, HashInputs25(0x20d521c382af34ffb494005988da0fafb0018f733912c325bae8fa36f1a849fa,
            0x09bf09b575fcc7b5a664bb8b43a58815c1be4af6a94e1cbf46bbae821f975f9f,
            0x4b0631b0f238c59c73df9ad96ad51762178cfd06464a56bd7ddb792e792e4670,
            0x0e97b51537b277e00f7221143d27f23a9a19e4b1faf0d2a6e2cdc6b12929fbde,
            0x681e0ffea997e81c6ff277e69aaa6bf293626fdaa04b3552478d1055d50c04a5,
            0x1461fd2ae3edcbb5121bf3e953c517d278adfc66206768e0545185174572eb88,
            0x31a27eac981af1834e64e443035e4159dba3a08c8cc3fffec983e9386799c59d,
            0x27cd2a967fcaa6cad37eb89e912796a7d4df03da6009f58f5144dc6912966a93,
            0x481169d09615dcd05e480f53430f8acd7024c57c90b743f2be98903922344078,
            0x4fa164b0f2fdf5fee59d9ea4ec0592bb187a4c3c1f17251ac1192017d3309c1c,
            0x206208de8a5a64fe5f4b6c5ac56ecdb64d1aa3758d18e88275073c81b4d1b0b0,
            0x20ad298f8629cc3a8673e5ffbad1e9e998b36c833ef10c151cb9cedaa08ee954,
            0x58a7177adeaae0884118821f6cc61ac21f7044a05ccd86abe138ef2be6d59fdc,
            0x5d90816b0173e64262b969c1193551f2e166acdb01abe56efbfb516a1a0998fc,
            0x22f092e90bd971e09f33f279bf21ea6c77b43a0f253013ae8c751250d46b961d,
            0x1a1c8b49c4e74379cf98fa194fe698be2b011e97b84ce095643c7b0a9c3276db,
            0x5a21aec37def37be2eba7623d46ffaa462a9578c0de0154041086357fde575e6,
            0x2c46588804c4806447f2ff8c6fe3fd87ec8c3ea1ae05de05c034c82e98b5773b,
            0x12d81313ae531a4ffbf1800438ad54a91e333e0cc5bc58b1afdf62fb70998b69,
            0x55d358da8cecec5718a148e66d45ffd6e885cbf772f3bb06a98a5f18c14ab4cd,
            0x6a87db80bfeb7dde15e5dd607f11a7562091fe32d433b5f7556628c539776ad1,
            0x03ada9df28a10f3470af9cec982d56b137dba99e46971a2c547b382aef3996cb,
            0x46c991e23b0a7173c7312c2f3cc23088bf1f2104177a57d170dad1929727f226,
            0x5ec8e0e6eb1ecfa50a24952d167a2bc9da0538794fbb6421325a5a3e0c5792d5,
            0x0024505d55094ef11dd786544bb883d35e96d958a419214ae355cd89223bcba2)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 40
        ark(i, q, HashInputs25(0x44f4ed4e065461b9c50f7239b6f17bea90194a56ba54cef7a14db6aa19591402,
            0x344886b10895753aea1bbecafc3fee34140874f358ea6d3a9829584430b8ca57,
            0x39ee71e0eb6e8a93833a35d58371ed08009f49e9eafa0687351c911447ac09d2,
            0x6a4b31fd5d785cfb5de8efc396c78131d92f01f68ed9bd3f754f16b16dfec818,
            0x35bcc8bae3ad5bd269b35d1d94fe158aab338dd4b19d5aa8919612d0d73c3e21,
            0x04bbac9f5bdb4dc38070b875fe375901e41e43db8f1c800a4f437d5b842e807e,
            0x2c8bb6c89dd7d0bf96977fdf088f0bb11dd304ab82116f141b3993d909d5bb0b,
            0x719e8bd535cee4ce5f282433188ff4a1634d74199bf085cdf810d980247d3443,
            0x67ceb9926e097c11dbfec8e987e96e25ff880b58ac3a76a91dfb8e4eb54f309b,
            0x1adc650249a3e7ece36a3082796edac4a64fdd56064a988e8ddb112f0ef05080,
            0x4e8418ffea1ef1e71d663e34c7ae2908000d146c48a98eaa28d6dfd80b4b2ff0,
            0x5142f2182356a51eab3b0694638a2711d17db6143ff4df0908cf11b88232024f,
            0x49340266d2fbfa32d3a2c203a96f8a1310863761dadaa54c2bd24db2c11b41c1,
            0x1096f677f31dbbd0d27fbbdc015343b65050431be5bbe3858b6fa9439bf990f6,
            0x0ab43fb53e635305546d418d1193555c9e52a8e92df39ebe068223935c534038,
            0x4c5e4b37e7885ae10207ad6bd0dc538a11037471e9687ee33d9edd6e98ccef16,
            0x59e848262c8ff9410a1e8a3fa22f0c727cf1c1fa21a1800af50295f153c130b7,
            0x2631179488292c3e1bb370d95864f4f5ccc74881d6cd9c7a9ce93e699d6f664b,
            0x1e3f61a7d23aa33cdc5448a40cfaa854c3fa123518f58ec3048b7c6f2a81ab63,
            0x381650a4453e6b4f46fab29a67bf41dfba3a664abb5c455d08972965264a29b0,
            0x0e3200f974c284fe81d5b08d5fe188ff6ba9b01fed2b28f608135310d20db64e,
            0x53d21b7e1063ca0105992230e07bfe4f3822eeb91382377365d6cc5f2da79fd0,
            0x67e6f5a7456a145a64e37a10c783138f500ebed3e28bbbce4874dc30eab30237,
            0x4920cb59e4b20cd242806ae229e5dae9fd9b520bfb05e51322f6f1a00a4a5a2f,
            0x3fd26fe284866ea43901c5709cd7ef99869128bdef4e7420550983836448ad0c)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 41
        ark(i, q, HashInputs25(0x5f65f6b3e6e4c6fb881fd416183a1ee7b4aac616f6a4118705685db4626f99a6,
            0x6602ca162f22262067f38e515974b97a5451398d44014134b1520de25743ba0a,
            0x1187229d8b99cc51b4da9b438682804e9c7712c9d8d19d96a267c5ee25979aad,
            0x0687aa3594b4f1884ec6cc04783e0e7fc8f296f3821092d32ba9610296c6ab60,
            0x09265f69268c2117a110ab9d5fcf27630440906a51c5a590f796556b5179bc43,
            0x090b919cf93bdc70cf626a8360f6103f40942fffcb5e513836ebaaa02eda7d56,
            0x363d31d691bdefd6d272ba8f17a8e02af197eb0b4f80ac99c8faf064503b9430,
            0x03ee4157730b5292853068f905e545fc0c85e7f11a5be0a8940b5e13e7728061,
            0x0380f4aaa74cfa9b3031fb56299abd894041f7f3c9818d19c3481985befde053,
            0x0c8b415af35b6b091b67776739b04bb3705d4cdee7dbf742e98a35793fa8d87d,
            0x5d3436d1e27af05d93acdf8c1a8670666dbcb2170bef272fe4fc815f0fd91737,
            0x5241cf04f194ecb26a8e1ebe13ca6072e1489c06e3a53d92aa053b514c0aa3b1,
            0x23dde56da93b8b6f976e50e1e4dc705dd00ab1ffe1a94e1aeb22a2e5370307a1,
            0x0a816ad57e6d6f78b18d775d85f4545aea047059a9ea42aa442eaf16de9fa2bc,
            0x0ea7cf800feb5919580647b0d4ca2d265f24e8ac85d9bb574cc9c16d08f5204c,
            0x3da91558f633aea81b268caca04ce9a4b87b30a2de19216eb5b3c233186c73cc,
            0x460283b012c780c8ecc87e42274edd785ec5c76e1ced7c7f2d7346c96a0065b4,
            0x4825bc926c36058a3f947cd7154d92fb319f4bf02e9cad6928c8288301f191ea,
            0x19896d094c3518743c62b5a63d6125efa7891526b6029c9ddd8492d92a32c84b,
            0x0e667cfe8af2661bac6faa6e664c9240e2d8b75f0ca4ab180b92ba05748ac553,
            0x0a7e1760dfc6dbf23d2de9296f8698244762edb8920754c09e1252131ccfe1c4,
            0x1d33981e887cf05e0cdaa5e955ca2f5ecbf43016121ff8d64aa5d4ca67c87aa8,
            0x40730a75f651ae7ae9da873c1e50fc9a7e0a83f0dcd5feb0289b724d2e70c191,
            0x37be5b571f8ba7868d1482dc147b8d9cb135da05fca9625149b602ba22eec013,
            0x1d0480a3440473df9bdbcc92ac8312683a4b551c27aa347dc453225da33b191a)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 42
        ark(i, q, HashInputs25(0x19ef722957189377b0a386f04200098c05b0af349d849a89695da27bd85c96b7,
            0x1dd435b204d106be54d794b423ea26cb909a58c9d507956747a0a39665b6c17e,
            0x07a599d25c39aa9ef9844560b791209ea7f65dba1b25f1219bf50750d3342a91,
            0x4015c0c6934bff64728cab6a652cc2c785992c1c9edc2935631cd7cd286545bd,
            0x2fae29d90086610daf5f00f028c21010ce70a12930b82e452d860246627e010e,
            0x14880ec61b3b0b54f34d45048e7196bf0e9eceaab00f2654a63db20fc18b07eb,
            0x2f0fe06bd86ebf1653483df43a598dc45698d9b20364e886e06f45073a5cedb2,
            0x5da58e83ccae29f41b4ed2798a3d6e4aced177e5e2dcb84ba0ea4ffb9a71181e,
            0x569cb4411c98e08c8367d8ed0f4cf9070bb58fc7071159a5feba4b2aeca1a8eb,
            0x25d82e4e678412a47e7c7bd8dbf756475db55505f9db9a20acbb11068339e892,
            0x6b3b727050a17f0f4c4193af4044320ca4ec88c8c3add5e39767cc1ddd98ca63,
            0x6161ac8f1d1fe6439110ee78d9f3c000b4c90480f7bbad0ee8c891818e20ce2e,
            0x58b4039c11eae9ab94bea86ba019f1ef8ec1df668433cf5394408f816ca71933,
            0x1a9916242a7096075b8dbef6ec58a86aaa14922d2b364f82bf12ccc5c835c983,
            0x2f88e480ad711a62a0182d4ee0d9362b302a80a8da6b28db563ee8bc5be572cf,
            0x4c8428398e789f82e62cc99027a3e9a8bbf9ebd6ef4b138cfbb59482b7d58fdb,
            0x0ad5b6be6c12fa37a04a4de87f8aeaed3579a160d81728d4b4e8e8b4f3165733,
            0x577fdf4483460eaf39f7d35d8c5ad747e36a8d7b20c1a50c60dc404b92dda1f5,
            0x5e664337d1a6ee19963394dc003400fa2fbb75591e2806c7188973c2a82d4206,
            0x5bbe993b7e19317de341f0d49f8dcabfc0f88e4401639f73460609c51ea443f5,
            0x0cbaedfaf96f1410be72b40ecf62e652e6b57e95b4fd7ab8c235e54130f00be8,
            0x6f0d6024bfa8e57e968ec78b00661e233271f5783c840b6acf8aeb79716723a5,
            0x55e7eca7cb770c8e65ed7bd67139b7e24a80bb7e470ca31b2c7ea31643caf7e2,
            0x232a1f5c9ed25325ebb6fd1fee5b06d08b7e23a0a8bb7534ef6190024569444d,
            0x3e7e0e40ed9f48044d2d230267a1d17960dbb3eff0272744d336e5fd435d8ba1)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 43
        ark(i, q, HashInputs25(0x7214bf5f3d3e40b2e90153bea45ada793d072b52169289a96cfbb32b5a09f297,
            0x10983849a3951b9b7075b92b43ab244fb89a63804d176c35f5885ac0bbdc3405,
            0x5fc0056c35a7020c0b7d6d73388916632d10adce01dd2240bcec502862679cad,
            0x45b801f62b9c24cb6b47c43119d3f0a306a379fe83d52daec2d0edcefc87bd70,
            0x0952668f9af061bc40d21b34448ff67bbfdabaff27a08957cc5c05328f8bb1be,
            0x4e16e39a67665b161cc876e22543368dc2da7c874708ad62b86c1626261b53db,
            0x534e12c1d55a02ba6f8fae92f10c6340c045a2c5c017cd4a36a68bb8fe7af154,
            0x25ed2c0e28123968866e88c8697dc0ec0e51fd609b2d03b8da36d1b8250ced97,
            0x0fea6bea136ec47580b041b5e067be389fcaaadb1ee3e75373fc1935d5a203bd,
            0x503caf294550dd18856cc3cdac1c682d3d80e9c5f60d581beab6d9e18eca2f16,
            0x2e5109cf397da468f967c4bdd4006d78c27f42aec73e69927860a61bbd91b076,
            0x342cecade75c8bcde4d185889a156e0caa77e9ddd2aa64f7272703698d1f8d4c,
            0x5f36abc0edaf0f350f556860d699a5a40121a1501af7fd7cf553848e6e3be2ff,
            0x3f0922208a7e9088b6fc98e7e91ecc0c71fea48f0548850600c256f78d94b2ac,
            0x4ba70179a8feba94cea6bfba59c99cb0ba9bfc06c997b57b3c12c875bc554cbc,
            0x1203df46b741f4f17628997b76f3aa3b123291ab20aee70d91228975a0cab666,
            0x5d7bb0f170ac492ccd9cbf43848297837f29ca6f0fd367d969f2d09ae747759b,
            0x3e925a1055f5d3bc1eec1d4cf587e5b889f1568fa7d5e8e4304ea0f8dddf179d,
            0x1588dec815ad55924faf4311b9a9c7408f5c4c406dbe67ffbc63885e690ab2d0,
            0x15fa0efb1384538ec6d6802dfeea659632ca1ead1ce1d98bf4ac33cf9249b9a6,
            0x4722c4ff0f1fc9152d8f0fde76dbe3d2d05303aa366a46fc26cfc1038250b16a,
            0x131e35f758c72e41778a429f7bcc85c8ebb650d37b400a97782caf880ebca0ac,
            0x70a910e49d481f2b536362875571ad72cc4a79e30bba471c2c5bddaf6b050502,
            0x012fdc66a08e27770dd91128c116ae0e4369c53fe2cad07a97083250d0f56bcf,
            0x336e88472726f996467a40bee84cb9806e2481788c5b11d72c34c32e7ac141eb)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 44
        ark(i, q, HashInputs25(0x3916bdc37b365b1c1c8ab2ec649194a4abd144159332d863a69265ccfe874d31,
            0x3083cb5ca9113addcbc21e8c0f43417c7173dababa56c71d18b14ff9afa2e268,
            0x21aec285a2c3ceefc8bb6792d52bc186d0cdf1412811de4fd855cd287908980f,
            0x595121cd84a1ed3a04a2f46e51c76d658e788a6e5b7e964a4871167506a623f8,
            0x31d57652d0123eb80b950c9d2abe3f5bfd9d95a20415e58410cd545b73ce5e3e,
            0x4929488e95bb6bf2417c995a1c205e9d2b68aa294b06efde33df6c2514e99078,
            0x52148b9a11274f1b81a50ae3a10f5b54a333e8c32afc1b12ac5d8a185fc3236c,
            0x3a607b62eb52af0302c0a35197903624b5f832a9b399e71fedc35fb2b2101b4f,
            0x46e08ea22fb3b9ee293d415865a50ce0fb87c74cd4489e50a1eeaf6acdb239d1,
            0x546440ac09be5c47d8e57d4a62111215fce2cf8a0fb4fd782dd08c5d75978bee,
            0x151228b240c1b5a22acd037ac061e18a161511e2cabe425ac8bc28f0359c46f9,
            0x051cc11fd9abf515c570c2d1bd4630689d860e3b3b22af108446dffd6925b475,
            0x3748300a13eaecd334e3632009f3c506ebfceeb426fc70890c778cae4683bce8,
            0x08c1ba5c379ff5112db778f3d1b2c9b35fe71f68a460633dceeb8f868626564c,
            0x180cb86571dfb2d17ce694cf826ec78085f5a52c0c853ebeefc5476c4bf12d4e,
            0x0e80d380899c619246bd4ae01c2c397d774bf9bbd853b8364655207ba2959587,
            0x1125aa730f478f53e0fd7825efca68f6a63e25c5b97be93dc795a67c2b107b8a,
            0x30ced236b6d094cf44f1393cfdcda025e6715f4405287efd1e0d8b32dc5ab5f3,
            0x250a75179d7d02ec1b38b228a07f121f971bd39b84d64f1d32a0f1b7f2e0dbbf,
            0x21118a0beaddfc3918e3594e11610288b895a8fd78d00cc63cecf2390c0ad366,
            0x3675d11f136b4845cd8fa967641e5a0d809f2c4964cfb0995b32940df21e3be9,
            0x61647bfe7a97c11e6df87d32c704ad0170fa28bb036543ff7ea6ec9551d6ae22,
            0x235aff6f66bdcf2a29dfa061f089bc9ed6c34ddce04970d694b01a974c019d92,
            0x38e9c5de16f04d4a5ba37851441fc27f628f4a9bc32e268e6ea9bda9117f2a5e,
            0x0c72988b5817d2acd5ce0cdd9b5fee25486c3b0c6a3ad73a4be3af8e843b9fac)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 45
        ark(i, q, HashInputs25(0x6b8d9a7737a09828c375abc8bcc8601884bfbe0b8dc3ea0d80a635a99ebb0feb,
            0x0437ba3b52b6de0c331878a3876ea536c6f82760a1a7d1d2297e2fc73e3eb543,
            0x42011850c299bd6b476dcd5a8fa34921c99e5ff2d4552e75cdfd912472101db4,
            0x193480db261b5b5514dc907a12659edeba5da83399c5b690d4946e1ec6654f55,
            0x25a305b05e42e20f65ad0b4917086eab9b6d34fb51caab9965a01f85331d2570,
            0x3fc66026c9da26dd8bf5957edfe5963c5ee7cf02d5212518f5434e91ae7a6c32,
            0x5f2ecb3c50da085a054ff6d54696800e191129fd975cfce0bebc170443e80b87,
            0x00f72628997480e90a7c9c03c92b34f75cec48ac2e85388d8a89467463bba495,
            0x076b16a91c726aac8802cbbf13de1159242542755ce8fb54ca027704c53492e1,
            0x34c70d9b171897d92251d8d201bfd24a2142dba00b032e38beb417e2b3870e5e,
            0x0fd6c2c373a9f2570d1d417189a9ffa32b2078b4b82e8c6778b288a6cf5f6390,
            0x46899c9533dcc5e741b3fd8ef63042b72b5f085bf14535b8cd27b899a5e59282,
            0x4d28f1034c70cf464916f410bd75e26ffe72f1841cedb36aa087b7db60374bd2,
            0x126000eb250b29cb5ded999dd730c1ee0182e8272cf57657a62e5fb4550d5c7f,
            0x5e8d4cb7220333170ae338654c7fa5797a23cd13d781317097f4a2d21d5acd8f,
            0x1449e1b94270a2563bc34e5f5bd8e60ca3fe946ff20f7445ade9f1a804d4b942,
            0x67a6777ce380b3c1134ecba03c43d790327123dcb97d2d63ff9266cd6e7bcca3,
            0x72e8bccfa3afb83e98acef2a828879a351f4a26a4a131ee708e62dc59f54d826,
            0x279f6fb9b5f8db661c6e93a8434b3103e69dad9d12cec74f8cabe71e9c0ba4d1,
            0x6aa25659df50fba6010dc5b1e823afdf80d6370311d0d6bfde9bdd1195e3df27,
            0x573d3b8252174031a51661bfd6f06bd2f5605fbb194e236e253ed22c4caa24c7,
            0x21f5b294426c5ad00dc2f5ba3734150cb83336d4b3a9f679b6c3de5fb05827eb,
            0x4ea103c7301f3ea1fde76d678da81c3453911e4ef064e42de14117c29603b7d8,
            0x5db511cb681eae73d4ce85c9e9fb55a7b96e913510899eb29a4b1e40cb4dc819,
            0x49e561e7ea8d993d1769b1cd2d6761676c4b844351b109c850b53325b590a4ca)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 46
        ark(i, q, HashInputs25(0x50fdefdcf0c81e644593d89339ac9b89ac7f9235666f9175f517963fc5c72854,
            0x6a7030028f4483ba66680397afb6517b6964a86c983cb181abfd0c20cdd08592,
            0x46a9e6c29ada8ad9cbe86598f5e67616acb53906c38a4eebe173c8c2107babaf,
            0x2e52c8d91e4b5c0026592efe4eeff40a9b3a367b333e4d7aabf9d2b91f31872c,
            0x5d4d0c0fb062ddf5a6f2333afb79b299a8e7900f4a91c4d9bec6737d2fcb383d,
            0x7113c2c41522527d1e6a904ef6b8c41b0aa1017de960499509e90988c89a482a,
            0x5f54e969f42a510eee04b9f5f26ae2e994aa64cb5c33f91da75724e4043963e4,
            0x04ab57907cfb636a12f30b9823f4b5d03fa9d0222aefcfc3a4942e392fb933c6,
            0x21de00356f1d1a41c9b2902316377caec95b65124de7fda7c841e7713882d73a,
            0x4fdf9cf6caaf7518717d84244eeaeca55903c565b87cc1df0b1bbd1810ee01b5,
            0x0758bc095459c8a0c1e5fc714948e9f8f064603b4751b3e1a240271499d155de,
            0x3689b042e1d5fcd0f1834f41e622e0936a6312642371ae0ec43bb4f844264342,
            0x07d7916e8a2c56448cf5b1764620ec63743d93590c9bc23d035e14c02656da53,
            0x53862313ce7181db9d98a1173ae633abae4ce5f4e0dbdcab5b6c0062dbf6d6b0,
            0x03dec6fadd9af60d2416043ad6753d37ffdd1b8f489b0b87de1c5bd38c93667a,
            0x41623b7cf1b11b3075baeaff6730d79d9fe0114a83dea4ebcaeb3ce1af5ef2a8,
            0x1977976947532277a5b299bbf118114c96add4683cab5585797014e0b7429530,
            0x4cb83df881fd3762063b0d72fee4912af88f82f9d3052065c8ca24e4b57b6be0,
            0x66b5e819906fc43c3712c115441ba34e474081c8d79db4dd974b8bf8f51cc2ef,
            0x1a1eb281e9a06de71d1755c88f34ee1c3f74535dcedd47e132ea230392c47246,
            0x299ab5607675659531648fe6b195eddba7e4460db8e333dd0cc04ccdd709b8f6,
            0x2c9e89f8aabf61c197fda4a1082922009a638fa630f8994dbb9a66dbe5b3616b,
            0x3500815118566584e0b777912342254de4b4fcae90bcb83444cef226d9e8fa1b,
            0x703a0b8b7fc0e9ba2159fc5a06d646910a2d7e9e1c0e672109b1e926769ff3aa,
            0x57a95126467ddb5b48c83f1bbfce7fb85580371c1eed5791fa34865dd0a91158)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 47
        ark(i, q, HashInputs25(0x24782c363ad4c41997b903917f1482fa92bbf7ab8da0725f9b9dce5434ededbd,
            0x152f72c02e5da8264c98bb5c1aefa0fa741d641681f5e17bb2ed295910b1b4a6,
            0x12b6a7a32af8532f4de0ff02f2efe301d737f97ddafb62fc71c9d4646bfa22b6,
            0x4283e0487e49949d441eb86feb3277fb2384689bad02be2ff524708b50fe50c6,
            0x201464f2a9260f5a0eac9ff953fff06aea70b20d04c6227f3c9c424cf90f397f,
            0x1e6c7c562f5bfc15acf11af4adf0c77fc5eef8bc8c0bd561078c3c30010af44e,
            0x5a392826f577e08c8f8a18f735f214a3bf4ae7e16889f2e4fe9ad6d77a0faee6,
            0x2a74d3e39e4b8af3c326d289804896aa47c9c432ecbc06081265885f7c10a367,
            0x06a1920cc5d010a2e7eb9a0966f4ab131a9fb627234007b0453d23c45ccb9df8,
            0x1ece7cc3ff790651551b217ebbaf3b1581bad742a2312c85ebe790d335f74869,
            0x1e1c530f7b6695ee34111bd64ede10c1556ac4c5f275da16a958641a13c86fd6,
            0x0b84e988ecde5d5b108d2c1c1815ae67a55053e3af6a694a8b4cb46927396dd5,
            0x48cb2a319a39f462b5e75048b51deeb41ce321e6a394eab0a0aa9f5ff8549cc5,
            0x22c5825ae59c0820e2b232ac08e11927548cc8fd5a67c1063ed20b21f594f3d2,
            0x4ad7efce54329a1782d955f0d8e9152caaa938e7fedc28609842d97942ba0ebb,
            0x3495a41836e0ccb88be96516a4a2b64b83a2be6175281217279fba6e206e4a8c,
            0x70e655cdb1e25fc308322d5f67f2fcaba3ee47732e56deaa18263962b32e628e,
            0x05b6ae4e6b48ca3831b9aa544485b058075094d9f89373a52af2619d7999d01b,
            0x25041d8467593d8ee5f0037861abfb65aad5b4be35afd1324cc99a59ff01a3a4,
            0x538df0c6696ecddab7279fdaac2003d09a7c555e6231b2a47ccf0829e7d1e2ea,
            0x0fae8399932980cf09e295ce24581a840da6b0ebb4aefbf0fc6c68de00b26020,
            0x2fc007c40530eff0679f332af45ecb5521027a61a38c1ac1aa7da88f6d4ffbe8,
            0x096d1cb5bc249a2168446d6700351f22aa9eb664ec62e606273333f9d132680c,
            0x09aeb402f831acd774264da4ec15ecc31678ab161acd2de9c3e71fc6d0b811cc,
            0x4b96c231ec14f39a3898d3c2c308757fef1c36926358b4f74032c707f6668e53)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 48
        ark(i, q, HashInputs25(0x637ef61eecbcc3ae99e47d3dd44002a76885343ae6662085df1b5ff06c80e363,
            0x0c9f77ad8fd867ac5a02401402307f12491d28c115096eb220c51dd9ec6a6096,
            0x19091122dcdfe4021eb2364e64ed0e6b8f9ff6450eba145ff49d68281c6deab1,
            0x1c5b7350b82b8d0cba9935c9364b5d0e13dc32ef9fa612b0f31e49364c1e5d69,
            0x18528f49776b4b7866aa57107c719d994eaccb28a2f36532b250848dcbbdfe1a,
            0x26cecb3d623df1d77407cfd1c695f0dbc224f46f2962f253c8277a16b74f13a2,
            0x4ab8a66a2be44e30a440d78786d9fb493cea953582ffd521719721aa9ae5fd15,
            0x1f60c4d2a0a412129fb797b84be19d9d88fe14e51525299b2878c6904b0ceb73,
            0x211ef00099a17de2a06cffb7b5342ecf2234a0caf5050dc1919581e2cbb1dee5,
            0x1486302255fed4ef5ab283a2a78bed60160a35b993d3630532f3851f91442bd4,
            0x0bf08c455401cecbd6487a63cb3f1cc9d22433b49d6309f709634d4031d8b740,
            0x6fa30c6bb033f1cf438c99ad68cd9ba2862faeaead86ebce860074fa0d5029eb,
            0x5ca3dd881056795f25eb9ff63258e995b93bb63b795ef1b15b2e6cc338bcba8e,
            0x33253023b649b07d985966c6a70f640c68d86611b6784e064b7477d1ccaa13e3,
            0x52d4a3301794dacf85b44a13412e0e261ee9aa7a6d245f1c41f52e768dc4d35e,
            0x235ad828eca23a57d95580b1db5a5ab12f74940dd4a59937af1135dc83b623b4,
            0x578fe854f5dfea561ee426a398f3d3a794a88c314dd2dd4c39140a4eaab9f56b,
            0x04615feae04ecfd5e6b4c2551c12fbfa1a752547ba92551265eafd72ae027a7b,
            0x50bae3875bd5de4754f6cf83a12a3b4b3145d6380ea250af78831a83f1969406,
            0x15b7267d5751ca6232f73659db6977da567e2458f03bbbc3ee32dc12ca8d8110,
            0x03ae69e52e004a7a3b64c9d979aa3ac8956af19d0a453d688eb7d4c785e2d1e7,
            0x22687c80948805569ebb516d970f4cc68cc7e0756a8ef75c8bfb9dbb7aea4c35,
            0x37367b8004c19ada79fa29cd8f2a9f39a7f58a110c7791eace4c85a63a33ca14,
            0x0552e8d32872b66ad0a8eb5d82eacd72b1fcc881fc1ad3ee9556250f5195ada2,
            0x55c57341df677e975e13bc011ab131263c37605cc469fbf3832bc0186f3d0658)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 49
        ark(i, q, HashInputs25(0x36a82cb7303ded6cea058d880280f128d7650fec6af5a27eba9f260244582f17,
            0x4077a85112e18b3038990eab54e6b5e3d53514f724037015ae315ef318b73d65,
            0x00702e83aecd6019b9e0c42fbcac240b653e593409fbf4a5146b5f0a6dfab57f,
            0x672d2119878002ce4266c316b9a2991174da04fddd492eb9ad8a1bdc52d02bb9,
            0x061a1400636cd7783ab52917fc0d4c7c61ce622df77c3074e89ce05826ccc00f,
            0x2dbd0e0670cd692c57535f4e0da98d095e2281bf8596c9d7adf05dd76e28a9d3,
            0x4a38ace0f0cf97564e9117bc4336eec807b1aca7a479dbae7ab0fc4628a8752b,
            0x33b032e67ec00a5bb2e857b41aa75c375fb81265d34dc3e7a154a21f91c32ea0,
            0x5444b5ed59ec6220b179086cb5ea606f9c5e043b85c069b7c56f73161dcfd820,
            0x2996c7419cc158f6aff2ee0556d38e816e7937549a8aebd9df0ef850a5a55a77,
            0x3bc54738af4f46d7c366612437980bf0741b69decd43972ad6e3c8d7516adea8,
            0x44c393d70be7293c6d07304d1a03cab12f947b0cb1e1724d55482c7ba80b2611,
            0x4f9b1a06e649906073e62672cd4dbc8418822e5d45a4ae281656a5b4e8e5fc7c,
            0x1e21492b3522c2e2bbc7ddfb464181ac916f69a45921081dafbbab057819b30f,
            0x5ef818fc4f0d51a3e037d55ef9baffcbf053ad6c8424b7651de5352acd9acdc1,
            0x619d92d6ede448f933a45d1d6a4e405dc6f13b0fa7f3cf6cc43f2a99922b5186,
            0x30a07dc43e3b5cc8ee7b91e9461b5b78ebcd20a31be623ac8469743fa04de84b,
            0x6c1a702461d7a7c9e212066853e402b1297607cbcbf1ff8287fa31ed2e8ae1e1,
            0x5e9c64f2769c73e1f9f5fd6dd4b38d37983410dc404a2b4846de30e1cb106e28,
            0x710a1c5a3a39b412ba49cfbe37886fef5dfd02df1d9744914a74e09d3967624e,
            0x09d66267c2537af69192bd58727e07952e345e4a166aece24162b7b3ca8148c1,
            0x01a78c8ddba5331bd508a8e8147a5aa3a5d1f9b2ccae9ce05b0c40fc72fb5e17,
            0x2cd1621a6f7243a5c83093f2ce24fc205b5a8376fa741c87a9d038df8df8b200,
            0x3a5f8f8d2767b50a4c4e8ba102638f80954bca1eaf59fdefe8b5f0c278f1594c,
            0x0bf162c49591e915fdd0333f18911528867542c8d000e239d42e6d4c0c5144b7)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 50
        ark(i, q, HashInputs25(0x03b6fd90df7eb1399fc39f63ae55cadc0a4da1c9ed96dcbe6a511437487aaddc,
            0x2ac7248fec3f2b0677c8de9e60fda082603f1a198cb305908ef10a7af21ec1fb,
            0x024baf239e8e167c7c540fc61c3deec55b7a412cd370d27f7a1745bbdedbadf4,
            0x386401957f2d2ef9d7f792e425f5871e75f550970a29342ba96e86d03381d477,
            0x6700a939fa73c10485da86dfffaeb5f02c2e2d2d8944d5f910b6ce288b5b8d6f,
            0x0690593b84b60799bd01d02f62fef93934c7b859db3b7d1a06134d9a742855e5,
            0x03966fd9c04c0586d02c8e19c8c82a35c54a289f8f49ee7b28d85071337b8b8b,
            0x03e2725e1e915bcdea6e1115e371691edbd2498ac3d8591d466bc1e64a0952b8,
            0x2849cb8db5b90da41b45e7d830b8bb0887120286107f990d139c9f5b38cbfe0a,
            0x6608b9692de73e4e5b2073271d02899849b6795c280cc47d6f0e5dc13cdea5ae,
            0x5f3d8c24225ffa9dabcddc2e4dd3a7ef9c5c0018896c754e1db3608271f7b85a,
            0x58ad15047f8a8f96801d4b988150345f7a8982a63c8ba911bb27119b3d3b4ba2,
            0x3054cf1d0a769bfff368f4ff70ff888f920a9139857fcf65346faefc58f96d1c,
            0x4f42ba2270fb4afdeba4fb7bbdcd722b78b5a27e56d91a92f9564dda912be56d,
            0x396fafe4642279f0b31a633e804d775559a0129f16bddd4acd41cc7b97606712,
            0x18c638dd96956e061db8283ffe06111d5d40ba288d35b7daabbfdaf1552d4fab,
            0x5d7aa85355198e08669075850d2c36f0db3d3e0c6a490039f5d82cfab8eb230d,
            0x0ca669f8410f688bd1ea12b71317fbaa86f3f5f337bb21d69d91e8229c258b32,
            0x3e9089004202159be84b30140802300f23a0d96ca8b3154460e09dfe41fb11ad,
            0x2bba603bfaeb4a9e15615b519a43090e2b66b07267863116a8c78fd490b96af2,
            0x71c420d48c3b63a18cc5843f3f4a862827eda09d2b1001716742b3e25f57b1af,
            0x20cfee9bc29fa618095136c814805ae43bbad95692cc2e31cd9697f0acc74f6a,
            0x4f6e5ff7236a6c5b9844022f609510221c634867c7e713477c613c93278cc398,
            0x18d23064b955e32de7af0a05b36e0efd98e579b8e650c3089707a609950ffb99,
            0x35a6ba59ebfaac547bd02bc277d6f75a230f79d03c50ba6f749832ecab35101d)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 51
        ark(i, q, HashInputs25(0x2f6660584f59977a1c0806d55f0165bfb719cc82661cb0610ff88d997979462a,
            0x1612142e527e63294de307cb5fea32b58a9e49b22c2a9b6cff72a2abcc735a37,
            0x2af8aa821767feed8f590972fe80c5d16caab67880db3ba1dffc5a7541f8243e,
            0x2ca84dbb2b2b406ac1529d5c61246757c8b9117b4c8bd1c92b844c76ac32d1b5,
            0x66b0d2992ec28732ae60121eb978fd417308ecc5b0fc781019ba5bd75a1b96d1,
            0x2d4ca8207d11262deb4a3ddfb79a8535f2689056ba3426c5867a561de3c41b09,
            0x550ccc08d7e8814a03c6836352d9037a392bc493cc04cfbaf89fe204adaa81dc,
            0x53e74a7d36343bfc4fc8246bbdea9bdc5a484e62e7faca11b421b765e260fd8e,
            0x4ffcf2ea63eb638040247f0247f06986bf448bb369c88ccc547f65ec0d3528a3,
            0x1da97d12ecf9e497e6c58645171e5769dbf1c4526f68d7a8323333c572487a74,
            0x124630f14dc41e80a2432830a3f5ffb88ca531b40412a9b38edf7100f36fff15,
            0x5354ca8f28d73cce6546ea238ee73d8f8b09e9ec6f8f554f2ffd0c0073f7f971,
            0x4a40be863e3703bd7f080fa3ae5964ecda9ce85ba4be3e8b001041e86d573d99,
            0x721f407ddf1f3291a8dc17f4f28b0c9d31c0b37171247422059f93c673ce4da7,
            0x07b83dc7116a94c5e5cf1d7e306401183503fbf2a6c589636f25fa3a662d9fd2,
            0x27e674d0ecc697e1af6e34ae32ebe9d8f2f6817e01ae6c59183bf59bf05608ab,
            0x16070ae6f3d1aacaacf15e2e7540c745c7fac3d7e739f755466e76938d1ee527,
            0x3c50e992af1fc5c49b70883ed277450da0330d3759dc7d28f9af45e8410ec0cd,
            0x566d7524ec163d1ead08eb95e5ea25d65bc85cd1c131c5327b054d44bd217a86,
            0x5e84b2cfed2f5ad84a8ac26ac1abd4e8cdb19435aed3c07bfa67ee18c3998b92,
            0x19cba71c8c191798e45ba547be0a1b3e424a2aae7ec5242b1b232dde81ef9600,
            0x2532eeda1dd090a48d7ff08483b533426f7b3ae04e6a0f9f640613d1ab64edd7,
            0x307fc647b9ef3c54ba54c3986bf5930035c513f36f1b5df84083c0227301d391,
            0x2d92e718f5549b0af02d3ac3922d8bb8a972e7dc72b328f4e184d35432e64b57,
            0x2fb19109636cb703821bb17be0afe67f406efe3978257d410b2a24e710bd0015)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 52
        ark(i, q, HashInputs25(0x053ca4e78f3b067fd18fe0817809f9cb16d82160c1c6ddf9ef0cfdac1198d996,
            0x612ab58ab2d029f6b979bb829a482f10fc802552e044bb8365a811d8abcbbcb3,
            0x061a28f0a324e57bb6b0ed0e94c2102a84a5ea9e902a96755182ec494335e74a,
            0x69b54306cc968dc8041b0270fe20ad67b906116d75c0c3fdb0333bcecb56c281,
            0x5377d5e07dfc0a35fc57259e84a0a95a9b8068f19f19132c0e25649dcffc270b,
            0x2153e1fdbbe59debb2ccad1573a4cc3b68420ec262b5f361d6b8dc846ec437c5,
            0x154dff816bc8996a2c0cdd17d0e3675e3b33f01196c8e4fcfca56a9fa3f2bd9c,
            0x4b40e4363d24e1a91da775751badc7e83abe71f52bda2756d765a8fc47373058,
            0x6e8540a9a4f75b725323fa87acca3f41ea97347850a5c0b39dd0d011ad51a18b,
            0x549ff8010fb5634c17fa3e6d29708ebed0513ddb0d72e8fd00b2936cdc6e9454,
            0x4d15acb1af3203561c1efe66598568bc5dbec99b68d02b1f3dc76341ae8e8b46,
            0x1645798c0b44b89fdbce587691ceb270ad2d170d5b44a2ddf11edf0894a1835e,
            0x054df46a89e2a54023618cffe6e95914bda247ffe2d2b518e1a8a24f246548a1,
            0x5248683d6402567bc5729659681527a759622aa193b668dc56615e9ab7e8a0d9,
            0x02aa791ab5cd84868562014884c9fd0614b89cf32e28e8dd56cd1742f80dc6c1,
            0x40bfc34c879ed5eed4c3957666dbc0b2b9f7fef5452553359258dc3738567799,
            0x61a8da14d935422c7ab530145b232ad95823ce673906f1db6d7ba72748bf4198,
            0x5158c1c8f01b9ca7e893a588ec88e403543d848a16426275a0f895bc0aae2a7f,
            0x716c3437e74721ee2c00c0a1bb9bf0ddd46fb3e1eaa329074729b20ffc567724,
            0x44918a4113e5155f2b9aa70d0551fb102944aa71b696b18800d229264ba6ad4d,
            0x54cb84139f61a68f6f66145a2411787a980b3cb9604030023cc5f38fa72a73b9,
            0x6d7dcc220ebfd6914761caeea2f2ce52149815751a7eea5d25167f3579c74697,
            0x2d69cb15fc0cb3f24c9b942209d2809d4f03f224423c9d8e4fee067f69ddabc1,
            0x40544c26211974d1dc610f356fd3bc9dd489571eb6d2cb16542b9dab02979198,
            0x4768c132ba92746e3e845daeaaba101d50b3356ba41ea2061ecc12222ae34ec2)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 53
        ark(i, q, HashInputs25(0x5f85b2e6bcbfb1e84f5b83df3aa7612fff7a629b50175283b122da07d15c24df,
            0x05e751d8091a3e25df8908dab5c7491245fe8fad77a67e6465de2c24f126eaf9,
            0x10287232b1d7b058fa0b45069743d32813912d98153aabe4aa6296f313b858e0,
            0x6e8b22fb52044bb3c0932e25d34683c7bc28f39424250be87f9a7c11eb3952f2,
            0x6d09a7b4fbdaaa026262e1cf28a74b0bd75ea2fec8d588874486909f556e85c2,
            0x4417dd2674f63f6cdf8f51602dec65dfcf9f5e40c9130e9283232779abacdfa3,
            0x67e615f7c2c673c3451e51f79ebf0fb3b08776b8fe066ffb36eadb908982b2c0,
            0x16bd929d71c31646122cefbcc95fb2d1d07bcdb4fc305b18393eba1fa2254dee,
            0x275a7b0b628711dce4964075d82f63b4128c94119145943f694b10673190d93b,
            0x0e064d6bdf6c33e12c9805bafab2eb2dbad9383f05aa1fb87a37894f71469caa,
            0x5c93da63176b000b0959312fbdd3b69e2e2301b359d4ede0a1834c7b96442d97,
            0x3c1b8ea90632352a20abcb8f350c8b072544860e7542adb845c67c9707f80522,
            0x56dad71ccd89ef656e1f1bd14814df5a17f3c1950ed7aa7ecf274b765ad83912,
            0x571d628d7ef92810a4ab6d8aabef423c86cb6d019cbce9f5a778abc7127dcc19,
            0x51cdc2413ae4dc9b7149bdfdc381394ce39f691f266fb840c13da7245f9a20ad,
            0x2be11809258594b85770e6240ca1828a81ab42f7b04ab4127161661925daaf5c,
            0x0a20ad07c59c765b0a9d1700ec8ed107b28428aeda0d734f73ea4f32d39ce55b,
            0x10681cff306b2de642fbafb68a0f056f773a651b33b2cf455b01f6519ed911ea,
            0x699367d53aa13f8bf9a7edafd0ffb354776a700ca7446aeb760de270373b3161,
            0x5c97e8a0574833ad418bc08d072fde97fabfa37ea748bda5041630b5ae20142a,
            0x5c3399281509fe8f7f19043d84e0530c5ffc7e65acc79f062d34e0a0e6dc3c24,
            0x1d0377d80fa4aa59bce3b3cbc74879b7c04f1648443934ca24591523be6c7199,
            0x4e16268ff08a549374b2263d7dd86defd21fd49153f8b44f2060a2a21bc2cac1,
            0x08bf2687e2eda33c2e3411001dfe4241968705d226456c8eb11d9a583bfe615d,
            0x4722d880b3b4b3c229801fe1eb1e317fb11d97e9263c15d683dbfbd8e10eab8e)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 54
        ark(i, q, HashInputs25(0x633c596beac7cd7254124feea98dbd56c68a09a1eb765758250466930c29077a,
            0x0a53208492c027c7d971f9c53f6a38f6f9eca388ca44dc96d73eb7b23cbd90a4,
            0x43c24f73b44c3da80c24c7b7c88b6a7209d3b0dca3844b1f0ed5c0b35b13b677,
            0x3dcd11b3c1e02790407f77f8b5ff3472c4e2b53e7f7def4a64e75de02fb27226,
            0x0ceb41ca6ebe8b8ea254e4bf2541db9a69ece91d33e91f6e9f8534bbc52aa22c,
            0x463fc22e6a9a2563a84be9a634e9c095db81eaedc9d985fd8b777f46490f25e5,
            0x65f1cd80d00634c4538d0cfd08f4199f26b9d10b02c17ac5051caf44954c100d,
            0x62ed248f8d9e5b509766a156b72bdd167d82d2e9aeaddc588a5eda592154ac24,
            0x26d576cc7e450baa7ccfbcd3166114ec8c91e6ba09443470c3f71d6420d23bfe,
            0x3272f035c3f8eb9459c77a0fe3bc14f12a7b901c8369cd7ae83d0f9e2a1f89ca,
            0x071440f25ede6ec28749567b8f0a61234b95f6ba6083fc4ebde20b060c56edaf,
            0x13dfa2e85b0ed4144429deb751610dc9555c6c3a7e742c43e5d402194fd44535,
            0x6918f0a5990adc470b25f7814dd379dced85a241dce86f49a7e2685c462cabcb,
            0x2d31627729151a52899128775a5fb23b26c08fa098f9cada7e4eb3ece4b5e971,
            0x038ad34f36bbaeef126e1bded2d217d786e471b07a3d82ade100ed955d295dee,
            0x437d3733f402d5bef5aa7b27ef8929f538269dca8616d91af3a198f71e1dd2bc,
            0x53560dd9b7a006c8528779dc9c1898a104a0dbd812e0d6d3190aa21598ab443c,
            0x5f176596e68d32f529803fc802c26a38d06302fd8be21dd1b82b76aab8101f09,
            0x26b2d8dd11b31df141728c5d757ff4ebcb6689703012ee71198fc4164ec6e2ae,
            0x0d3e7162508aafdfd4ceeee5c4b2511e3249380bf8dadd9366d9cc500df9a7c2,
            0x0ff68846e55215cd1544cd60c5ea698638b0c960bf65a16b99d66f086b200c18,
            0x0cd1dedfcaf86640679823397e2dbc529d97bac3c8d79930dcd98567900f9888,
            0x32298602d42811377f31a6a3e20f7425796b383c621d1144b3624f0116c07041,
            0x125fc3342136d1674d4024dd3600205ead4135f4fffd7b3fd14d263411470dff,
            0x35803abe44ba38b075c68b40a997b779c686b44c3c9ab0f5e84f3d6bbad93046)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 55
        ark(i, q, HashInputs25(0x5a3bbe3ad5539a3cd3ae38411b7456834783cfad96993316c4fe2da233c1be05,
            0x579637581bcac04d9fdcd2f612867ac31280ac6eb468b621671d37bd3b73c5f6,
            0x6e9d3d816828c2a81caf300a21437ba736f278b96f0e68c703a2a780f1c78c06,
            0x3a270d4ad9185eb3da62a0bb971420fd75c6832509a2275ce12947dcd2e0c6d3,
            0x360d0ae4b1b7bf437bf16e3cbb6e484c5bac0c2d2a5cdc4832b43396f0f686b7,
            0x66ed15f71bfb8fed905e5b3b6dce6e09433f0474456aeb65b4613d9749b2f707,
            0x0f8e3b0a874fd726a98f258821019aa8d51a03467b2f5076085b9247c306d67d,
            0x431c2590246494a80a3b9ff228ee2afd618fd2dfa8d3aeb62b779762f0ebb7d0,
            0x611e23135a00cf889fccfe746587d7c608905f38f33258fd83a5f9523c59cc4f,
            0x5e7d01afff780ce74bff5e2d29d8c8435e374b53f6d58da34bbd186106960f03,
            0x64be757f9a8b1c6facc7712dd7442b4ae462a0e8a89df6d3c0623c03ac53dce3,
            0x3a53cd61768907514a5c0ad378ae8224685ac94f73c85751c8378b9609fba7da,
            0x5e65a77c80de981c4d0368d58effbb57bc9436295921a8e376c2687ec1fe833b,
            0x6c20e798d102ad2d32c329e47eb098a0c960a38884b92fdffb213f46ede0a5ae,
            0x5a27ce7580a41e76603b990090682070aa2165f3d5736a3e10dfcdb5609e2ed0,
            0x1299597497e7b85d8d95a56c31c65a82192d22e095463cc1e364da8b4ae55202,
            0x412d51837638c0dc0da3344ac3c2305943cc23afdc8f2b43ef2ce762561b4791,
            0x5909dda54447b6c442c654a8e16a6c4011482b2b72efb92176aab091c25f27bc,
            0x66f1f11effba9bfad2e00f1c652f06a6bbce22bd003c5d54a16e1082bf564734,
            0x5de1a6c25c0ed44965b68dbbf1fd920f942f19ec9a27027d3d25d5388f20fa9a,
            0x413a9ba960e4397e2f0da3dd9919646ebeee546c5d23181e7b5f85dcc0b03e6b,
            0x470a43b82844a59b09ce75b48799860c38e4b212f85f5eb71849535046b0d127,
            0x11ed3991695c77d572f175982ec55cb58c5811a6c096ca1181073602f55f68a0,
            0x2a5c26fce8ce4beff4160ff2ba7c009c56998069a248a9a710c3f890e4aaff34,
            0x3e301d57a99e01e9911f82ccbeaa83a1b18e637a3be0370715477649a4dd66c1)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 56
        ark(i, q, HashInputs25(0x1c8b2b535232f2cc5da61ed786240006b41fa575ba530c290cacd0b8cd4c2bb5,
            0x0030b512054216f5c413f1f693fa00bf588fc2fc0a5dde27f8f4c5916ba4c57e,
            0x3f59bad5298cebb48d3ba4ef9e7e59685a2003c1e2024b9a86725a87f4b8bdef,
            0x627ff4380b9c0955fc7001fd6b23dc8d194b0f696943bff046ede36423d1a838,
            0x00de9b55682efd1da64973c044d95a02e924e4daf78366b34c2cf853302c2ec8,
            0x3d570b7f219685661ed80349e7be0b6d7fbc2d2ea10d0d8ebf856cd590e0ff99,
            0x369c0bcb5301588d10ddaeda4a7fcbccc7de11e10877aaf933700dc65325c859,
            0x18ef9e932125703e6ca4c30342f50fb4598b4550f79fd934ad2714f90ba212c1,
            0x106cfff99fc903a285a6b2b6a9aac855cef16b7ef144c52d445c07aaea42f190,
            0x29803d243809dcfb09cb968ab426698e65b3a3cf7c47a071cd8cdfd02bcd69dc,
            0x5fe88e363433451b3d2207325706de00dfeccf8f070607649e1dcc67461ff2ca,
            0x37a5867dfc06741faaea7557d46b967e521ace9be79cd92a5796eab7e8434dde,
            0x162f5cdd36cb7dbc39aeb9b8b2bd7565aee4f1b9d39575fab927886a3d992f90,
            0x56047eb46175b5442da03d5dad7c3e6a99f702c89a24e724f04c12ed6ded95e2,
            0x1e098cfcf86f709936a909de7a4cfd3243d31068f50d590420c97a4375da17c4,
            0x03bab461e47a5fbdfce219933733cae830aae631c7b4fe877ecf2b75c126e2bd,
            0x1efd6e6c20573afaf5063f0e6bde445674ee90bc32ebdb1e5155a544a8c65e9c,
            0x4bc48a63e923b14f260505e3e6e1d0980b42b07d07ea2313a1fd2adff20245e9,
            0x3580cd5d7d7d02c8a3e0177288739fa9dba75fef42eb70ec98d71e50ce7bde2f,
            0x46e245535efe22788d2590a8ae81191f8da9e338143ede63b6c072e1afdb0b0f,
            0x5cb5e68a2971037566def26455e15c5eca769562b397b833794eca945d3e251a,
            0x672c699bbe93062872b253309843b781b9017ebeac1db06a0f95dc58192b0212,
            0x3a332da5052fbc36a8b810ad94cc7d2795f0da20017513b21b0a1982df9ed949,
            0x040b8c88372bb932e75997f0c3f11c6d66a8a33177c60ff400c1423c29f499af,
            0x10014638128faabd2f23836ed493fa6f886e277318814d41dcc8ec0232c4087c)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 57
        ark(i, q, HashInputs25(0x7115c31ad77874a1bc2b55d63a6fb2840f1266e5c9a4ee9ee5e126a64e3e2b12,
            0x6def454914eff66cd9a6643204b6b9d30f693f87c423db027fe8016a8ae9ee5c,
            0x564e959403a62f56ec9c25faaf3540b0b36f073f69aece4a57b7915000d658fa,
            0x30bcd0cf51aba1f3d2786510b5a7bf820f22aba50c21f89bfe626c280204b47a,
            0x29b4826cbad2e619c95cc8369f18a6df5dd5cf32ccdd954fe837eda06d959556,
            0x615372e4c815bb177244805fb50fc808ab1d9261cf25160784da9946270ffa19,
            0x2ae7900f36e34e6e0f9345b44990bb7ce0700687d0bd412a8509418d7d71ef3c,
            0x529a24bd3daa5e29b55e78d07982dbd7736814f16112ebcd62b755e5c740f5f9,
            0x1f536d77a9bdd6d3cd4389f57be10017e148e888f4c5b1127d7cab89e14431a6,
            0x465aa900252880020140fc5e0143fec008bca6f659c739326f554e85b6d6e346,
            0x14cca4b6a93c1f770e68a092b4dbce996124f626345a9ac2a648094547dc16e8,
            0x13e3893218dee74971bece32937c247fb0f3c10c9cbd4ae1d66841e568d1ca7b,
            0x5613f97e229f36c810a04f91897a5838d92451813d9c32166d7fdbb90c2c8009,
            0x5155db1a4450e9acfc75a461d2f148afab6930ebb7a284188080f1772ee8d7d3,
            0x1a717b83c4bbe9daec11853cbfa1c303e180c2e25d4de599bb68a4760745abcb,
            0x27f9d6f876e72b90063e376888ae521f8136be67d6c87e138295b9d6b4812549,
            0x67ba9d17c85bba03aa676627f9a4b654ce8d88551a575f61011887dc93bf9aee,
            0x5d27ba10cb87fbe039ca099cb03e712e36ad63622716de4489ee754be1e80750,
            0x6db9d13f2535b633c8dc396ff574b52026a9b4a1ffcee884fb6b30ef4b35cfe7,
            0x638784daf0b1241e0c43fa30945e99616b5b35969a4492b3c03fc102c1110dfe,
            0x0bc6a832642cef007b5c086eb333613f08124013829de20eb1da0518bd28761a,
            0x63cbf61e1d209c37285b193d07a19bfc1ddd77a2d82e2904200986daf9a5b486,
            0x083b5ed895eb25372b6281f46be96657fd5617a84b527702be073f5b178d5b82,
            0x1850b32d3cd404ce50ee68eb63677f0f1296291991c77543ec3bc150926e4ac0,
            0x6a0392fe3caf2762e9997166b633f719ecd23c48b31e61884e84c6db562857dd)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 58
        ark(i, q, HashInputs25(0x332645edaf323a6cd199b998c199cd522a66baca34b410f7bba0063e47d6b738,
            0x063177e030daa230ef5c1c9c0ce0868c27d19b584791af832a6ec3357f55eb3c,
            0x58dda9d5a3e7923569afcd536692a727941bfffd59538bfd6e4f71a7a1b55cda,
            0x2157d00bd683c5424e3d1e225dff513d352a86f11c8898447d5976683ef6eb53,
            0x2c7f179f0aaa3059c0ce132c53d0d64cb463c74a8caaea42a80e9d9c236bf984,
            0x1578c6150c4c11ea2e9b20aa8a8aa997b38153c22401b9e5db20bb1dc97832c3,
            0x1e86ead9bb57d628efca47f1ed6b531ee03113bf7144b39c05e4f3ef888572d0,
            0x2184cde3d3bdc4248e1d9048ace106813c24d0a86459a1609a407a6d976c450b,
            0x719b8ef32ad9b625e6e9dd784ce5b6060a41797cc479bac4aa60103da84623d2,
            0x0bf27b65168d8d3d6f1ecb7a8539bce38311b50d37ca0323d094eb778be897ec,
            0x55e1850a825456d58f5a8377714031768015039499535a8f313195dbcd38ed5d,
            0x2c721203cfba96875df49dc70d7e673aa83bc43b78ca45151cafc4978492a994,
            0x35b1348062e7aa1a1f08bfbb659c259f6f3bddf9d19c05b11d0c51ff41ab54a4,
            0x40f2b1c34fa0771e011654b5720ba195810c3bc4169c44fcc798010ea5fa105f,
            0x437a3655f79b4611c611be6638cb3f5e94677dfbfa6737c4efd430214391bc88,
            0x6125af8fa3daed72d451d5534d9153eafcb68f22ed54046ecdfddd805c9249da,
            0x15bfe4556470892695f86579c40e29336165fd4535baf1c16fd325b561c06847,
            0x5c3af3c2e8c3edf507daea674ef11ad30d36a43b53e8305bf75a09ab76ab13db,
            0x0c09b4cdada1771c8f182b1da00a676431ab45298c7f8fe8f6f6b9f8d4838263,
            0x4e17af85b523b7c18653411aab2ae94454bdbfd16877dd209fbf03577ce47513,
            0x6ba2bc752d84e16f33b36bf56239ec589d4be634a49329e0bab4da7615c5d407,
            0x4f6fa52818649996f2c3d04d926b036e343edd389d9b3a3e82024cf1f55e9439,
            0x7122f208e4def9178b3d23fad5504802bdecbb0c4f09e395c70489a2db927c0a,
            0x5137865dc70f1f76ecef269280d6bbcad94ee8009162864425a53bd3fa8bdfe3,
            0x6a3760630e6ae128a65b3257a22107eb606290090952e0ce379afbea1b7ac4a8)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 59
        ark(i, q, HashInputs25(0x5e3ae2dde915b84120898faed2e3727ed012e217bbbdc3cc0500b1b822d6ab53,
            0x55d752fe9be5f350607d9aa69c27db714e4acb8a8fb7b6c42150c855c6b4ba3c,
            0x1257bf95f584adc5ce814261cca6936198360e2e07fd0d8c7d25f74fd5c5e8e1,
            0x499105231d47e81b7d995fecc35eb4d2f1fdd302cc4a4ab82a4a733e622eaa85,
            0x1c03c8739c01d05ef4d433812f56645bc0f333d9d41f7676ad7400d4449b3c95,
            0x3e7d846b141add0f295453a1e18bb946616f22cd43e157b9f6c5970bdde6713c,
            0x08b32fbfb4991708cdd7c057f7cd97b6463ef5acbc2e357dee5ed77cfef61976,
            0x5f6901f25c00c02ad9fc75cde4069c15c6754e2b07b16dd5433c9f8655dc35e4,
            0x36e7bdc800256f03b42f0e29b42371411b0ba9a047c9e24f61e7b08059429f0b,
            0x0ec9dd6580a85c4a48b80f189ec4c93f742ca1044e871086b5a5585705b57c45,
            0x4dadbdba329cc09bc9b6f6f534b7648bfebc25e0b650299af04219bb9f64ad8b,
            0x0779c301da407b44edcbb1a77c6550d43bae9b123e8a9c0aece48fb842764747,
            0x5e1df59fecbbdbbb540f86276b18c612212d336d172a2ab8dbd7848e1cb6be29,
            0x55b6005452c22d3bf42e56bab723fb677ddba49607ce9af52ed1fd0abef3c7c6,
            0x212b85ba4be56353d4c53f4ce7cdd940e4f5838fde5328623119d7add8ad11b2,
            0x4ca1373b7110cd5e59412f111808e1c2daaf67cd59735512e391a47b6800840a,
            0x60f8d340a0e1e6ca9143eed496d1b43c7cd5f0dda67133161a635c52cd30e203,
            0x401adf5f81a6c76fd14ebc5abc8caeac92020d0184a7aed9027378a6996bd6ab,
            0x4ed80feb8f4e4524b8b84a15d2a006e234aefea2761249a7cf62dedb8e4450e5,
            0x1b29e9b5dd39e39528e25fa4c8681298972886d416092a568fa32650d80e334f,
            0x3b999af24a3b709726010f9c6b9f3cc9f785ae67b8a2ab91b890bb8c2b0ef84b,
            0x723d7fdb631845e054837ef4725cb2d64612c7175e13cdd2343ad810f5e5e68c,
            0x4d4e1ae671a70d7ba5f8e8340d669d7fcd7171d707714bb85531465e452bacf7,
            0x72355a05b0359765dee1e886cf20b61c5821ba338e302a3e6bf7bef25720be9e,
            0x71ce0f38d294494c75ac1959cc5c8da7f354ad46aac2508d4a73b954c398caa5)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 60
        ark(i, q, HashInputs25(0x49d4e48b6bcfe79e7a305300466a7d92cbf4712e05143a04a899e2138d8c3524,
            0x0ffa866e36f24b81214ee400c8894e3dc1dd2ec60dd248992824b1c6fd03537e,
            0x38c0656c6a62f45e393b5fdff3e8efa4b8dbafc1da48a2f03e3b41bf4b273d8c,
            0x231e84aa4a4d3142af63a55454f526936c209cb57bc58c3fa83b04943685980f,
            0x435de9f5a2e8f569cf5821a9ffaf7e63e90996b11c79f5439b247696211afa6b,
            0x62c8ebb4cc83aaabc63ae8aec1879d4be946f5ad1a808fe60f3442319bf82c05,
            0x23c2e23b4678751d13031110c2b0b48f4f3ab0522968e0b614e2d43db21fe68a,
            0x2297b91da044ea3d96d7da34d9d2e74d5d2f3081ecf95aae34aaac61864a4e0f,
            0x1deb39aca7d6da940b0fd265e2e3551e53be347f773dfc213768eccf0cff466f,
            0x47a7039ab667739f5f074561d51c8884348a0fd085bba6e2716cd6ae4aa3d618,
            0x03cfa6104d374a2643b0ab51f21b2bd170325c0964e34d5dc18dab0ba3096a23,
            0x46459dc42951a821b6811bd08e52e18466750c8c4eeb67cec7d97dc0893bfdb0,
            0x2b91f59024e515ff85966f49e70308614aa20df5d514e7cb3abd22ba1bcbc62b,
            0x42b11fcad22585ca6e03471311cd591e9db9b25343150b16f61e8efbd89880f9,
            0x51d74232c64a5caf9acac29fa7cee54af38aad7f50b70db1ea14ac11feb0b798,
            0x18db15ccc141d41501982c850fef48d8a3324e9d3ca1aabb4b39283be7b50892,
            0x34e03d1aee46a9e43c010ae7cb33e19550313c686cf7c544c3e6e2b7071260c0,
            0x1e013f7e5817c5c07084e391c2398238732533290e923e8e9ee7b6dcd4b037a4,
            0x49652e8698d5374de1ee3406c0a42ae1e57688cf0205da9665e8261417bf32c8,
            0x01efa76c3eb32ccf79cf04220e04f1ab205f743b784477b8a7f917596d368d95,
            0x18c723d52840a67478666f7408a2d7376a856347b3debead0f2d18e58438ab1a,
            0x01d441d96b13c7e0bbd72e54ef9fd4c24635e6e2118edb731456c53ce9b1b125,
            0x4f250067c2dc40484b6b69727715574eceb9fb45490392069e0b8654b88138eb,
            0x51197f8bf70bbb68f619cd11e91cbc06b37cfedcbce1b1131f4661c7ddcff5a7,
            0x0cc92651250db47ea72fbdfc5e9cad3a604601dbc6ef20630572de9af951f368)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 61
        ark(i, q, HashInputs25(0x240fd041c313c5a1db2e9b714fa1817f6faf1eea0fd43ec3204ce3068110e14d,
            0x23dd2f1f7ece336bbd01505468e07e17bd529747615ffeea35764d8b02436188,
            0x4a367ac91cf1cdc55f887a9c7eab3f5619f0ba02df1f1ef72b0f954c74ca11ec,
            0x568c6e24e6677bccb34779428a49e7e28127dbc4c8f94155c00e15a7698850d6,
            0x3deef7e1a27548157cf18b29a974c9e035a3337ddb5a9706e77778d5d1d7a799,
            0x29bd769982c7bb56da7e8637f20e4b39e29e21ecb5d25d0bd7ca12ee4c719883,
            0x5a99fae146a993407637c3fcb63d39d171ac5fd5a20d31936bbcf207dd829645,
            0x6662eff88deaa46fee4cbd9ba2d14f80958e6f42ba1389f2aa47e088e11e73e0,
            0x295e35bc5554db3955815f63a0b5c6939b5fdb173cd89cbb71d5b9da14e92b9d,
            0x629826344bcf7b4a668cef602295976ceac56576bd5c4806e880f0bb66f92093,
            0x1c45a785c97117a3740517b919ba9b6814d19baf5610e3e693237f6e99950c7a,
            0x0d742e2bb4c505c85b86627e0424090c1a6e3342ce887b2850e94751cfb03865,
            0x5b4b2641529abe3a97b3f8b338dca6a9df11515ac773dacf9a75f13fa302b2b0,
            0x5fc503ab2b2b2b0f0d99997dabdf79a5269adfe837b02b5d1059944b6c26ac16,
            0x3fd2c6cee651c529efed624859b367198fcdc0a0233fba40e1a235a853fd13b0,
            0x66d1f3dbc9eada3410d8227a3825a075ec9bbcddcc0a79032b0bbc0a827ab0e1,
            0x6c2a2d54cb5352878880e2b50e3da7190de4f7db24b8a7aadffda22635103394,
            0x1b7ca657daa0ae381375d24ead8373f9fde8deadf4a53563c908fde7b58d4709,
            0x05eb16768806bdb9fcad46abcf21f9c29f9e42b29404abe3008e72334aac3f16,
            0x42e31815e19463589c474aa01916fe6469baa9194f3eb5935cdd93c682083707,
            0x35c3cb1bd83b44ec071e4215505df8b21abf457f3f51c2bb2f67454b947b9c24,
            0x651004715bf320d7aa1399e74f078e00632fd9a9f9753ec339b823e9c0a1a58d,
            0x53f6d372681247805ea3b05a09dbfda260ef55f43596e1f7fa925e8944e506d5,
            0x239a92a996b07e8c006c7c689244a76d8957bcca08789f8f26de775ee89ed308,
            0x448fd9e0b8f0e1d207cfba10a9b0e24535119bd393a5039840dcf9fae621c10b)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 62
        ark(i, q, HashInputs25(0x62e777c2510204f101f85bb9336d59421bc163b58efbbfd1f9319d3a664b65f1,
            0x374946cba4784f3cea90d1b5821cc320a47a9cd0e82932ae8591e1b640c06821,
            0x5f160f36bf0e653123e46881bca00c819350b27927fc72e0252eb3a95a23c8b3,
            0x3b5a5910b878e786cddb298637167120be49c258661a0cbda2f8a50797753eb4,
            0x34420baf4885752b28d40e54343a29909646f5ecb63834b918df22b9bddc87f9,
            0x47dc05a7305d5dc8179f33c4e4b956f1114d0f87c2074f9ffd1fda913ad9f83a,
            0x0d52a8fab375ca60013caf214d3e9a8662712f5f245e41058bfd48fe860802ea,
            0x435427257bd6eec3aa478ece04ab8324342170fcc1c10fc90f36c0bb6d296859,
            0x3b85e1b9cb1bd41f8970adb361f5d69bee3c9e18763f72ed193bafacb3b76945,
            0x177ab2eab8e57d4e918c05d7ed87530f3b6cf716980647320065beeec9b27f43,
            0x4e193ee77431f3bf2a51f8fb3feb0074dab082774666ae5b2db25fe801dc78a2,
            0x205949ae81f261dba00ea5f64739cbe7dd6f49d370128aaac1a8b522242ff574,
            0x5d64c0859ee340b11330eb31a2160dfea1e98cf9ec0ec2ae7006a842541c01db,
            0x66fade4711595ed124b418dc4e3ea7d083dbbe9c1bb7b49eeb31b3868a78f4fd,
            0x08ccdb11c61a0e4788a56173fde5939c77de75b34d8765666f1e99750cbdc9dd,
            0x08dc3e89c7f3fa7da5d80503197dbb851d10558aaf77d53b85b9e700fe94af01,
            0x1f21cf5713d411bc81af7dfd7c2b6ff370f82b613af547816513b01edc9df959,
            0x31b8be0c89b58c9bdafc0317da7dcd61d300f57745b43c3ca1ab258cc188a355,
            0x6285bd09082a9ac148251f1754fee9565071969c331100cab216269bd7978427,
            0x67b0d7c824a1815bf62f357d64d4f986e1002188a24e14532db5a099663e7a11,
            0x5e998e9c65789903a23e0d11ad1454abd22b0e60ce02f90bfc680b119a1276ca,
            0x2025f72eff1448d9cd9eeb73c22691a2a87af6afb809d59d8c56fd8a22a3007c,
            0x55966a613de546f25445b861d04206e69a88a612be5bec649c7fa0c07e5ea64a,
            0x6983339d584ba50fc2873dff0b1fbdf0edf08532232e0383f90cce3554ecb292,
            0x00115471ec03f16dc61976fe06abd2c5a0b8d85423fffb69c964a472c6ad6b44)
        );
        sbox_partial(i, q);
        mix(i, q);
        // round 63
        ark(i, q, HashInputs25(0x02500c8ad01d4e13152aef010cf787284e976d7d6a622d4dc25b641986cbeb64,
            0x1c64ca89e65c141eb1db9581898a60ed27ce3dfd618673f618af113a450c1854,
            0x2b52fd767b09470ecb7d1091445d96b3f55eeffa359ed7946204377aa5529037,
            0x6e93b15b533da75af9c4696d0a5551a72c1e44372582eae62431e5ce5761ec68,
            0x21089f8eead4f5e580f025f57977bcd2e42f7b14c4751f4297a1949eb3b0b061,
            0x6876230ac793ff13b8b152e30fcedc6ef86d11abab9c9b08a874e2cef272074e,
            0x3d804c636cec6a4da1f7a259625a27ec6acb2e8c8dca07a5570d5c3d2fe48338,
            0x12d15c93f6c2c51f0f5bf0134e7f28d3f6b3d0b727d0abe74d250ac3406861d9,
            0x3f6db0c48c3359c6202234afa6e37de3058f6a8d5fcf4d6a0f81897aaae13a69,
            0x57dae85484e200fec817744c9243309e5b6972b33456814e6aa65c8542a55244,
            0x69934fa657df5c30e2d53a7b3357e42a809e244c40be19e98dd429d26619d6ad,
            0x5acf7d8d79b440164c1d771c91f7744a182911448359093226e0335add171a99,
            0x3208ce7e47cec0a702caf02b8252799be11ec4d295aef43dd1ec49e4d147c735,
            0x0884c8135cf4440aca90fdf39c6510790d136e2b7bfc0a6d79cc79642899d0c7,
            0x68ee3461744f2d824edbaca524586557f676aacef628da5125560912470abf3c,
            0x0ffdca827673ff13dd195d78c261c0af9715976fbdc4d92759f64ce7ecfbc0d7,
            0x3fa3a302801887a5dbed47ae3befda8c16130fdf28a8b202d88a8b22d2e49f1e,
            0x1a5758183e92942ae8cbd18f7f8ac924aa1f4a9a2a9a89b7b659a372944f3881,
            0x54dafb1a9c30effd5c6c43c13c05899a6c3878e5efec4700e5fa4d38624f9db8,
            0x14ed7f056dff597b15953b68730f9b8f96f9eb2c860cb8a6f7bcbb57c4c0f6b6,
            0x573da59b4375043d710aa2d02f1919084d8aa8ab542fbb5a04c6f394a182434e,
            0x1acb9b44ff437fc86b14fe147d146f7481800a9d078db13db91387a7f9a03463,
            0x608a81dc2e890acce5a8a1babcff9a1c7350b2c66b77d907953b59924c7aa4bf,
            0x4b69d854377b10ab3fc09b76b4a28648d10997c9c16aa9c256f94f807c0004d8,
            0x107168d98961d3c08f26caaa52458a606d156b27f7232d7c856ba765c95a39d4)
        );
        sbox_full(i, q);
        mix(i, q);
        // round 64
        ark(i, q, HashInputs25(0x285bb2696dc5ff0086f6d22684dd9c898b60b704f984a9d9b751d3830ff7ee5a,
            0x24a5d854254c0b9318f524fd0e06667901d68567ac91d05628884f6bde8c078a,
            0x65020a9cde3e2762be3e506c75bda87d38556df627a8c8e590f355aafde041f6,
            0x0f042f661ca6e9b0c03f5fdf3937e1772946d56ffe9addc26850681687b782fc,
            0x351d34dec6414220f1b3be6fc99b52497f5e7e563de1e24b7cd2bcc55eb7f5eb,
            0x59e277c5048d562fd6b78a13183201dc9391c5d2fd9dec56e1669934a61d869e,
            0x162389df3d183dc52118ed52a68f93a6f769347fa56d5470977a361ae5d86418,
            0x26777287432052471c53f35d2db6ce96b8b6641b334e1e1088ecf5bb2e44b412,
            0x39af455e2b2a4c35dc25c00161a9891c387ef586f6da41ac4faca6139a11fe26,
            0x6a89f6148335e6b0f5e0a32bcc156a32330844e2030585294c7985decad6197f,
            0x18482df6b43b283ae5a6bfda077c48994717934e6c3e95d9edf55a5a57385827,
            0x1632ffbbfa17c21891f0b64ece7e42c47012a7506713a433a4c6c93c88ae9d53,
            0x47924778ff6028b455151676987138f27dc54efdc217682290e6cb4a1adbee23,
            0x70f50f7158b9a45b5d00e91e4814e33f6970dfab94f2b362d1cc633ef2ddbbbe,
            0x3a755a4efcf6874a259cee1f16e880b3ce97b1aa91b35e195d33d6d444216a81,
            0x2a629352d8c0252b2dc5e6b33562f0975985a90bbe954d97fc33765b7ed8afe8,
            0x407c65605185333388cffaf348894689ce4fa3ca36ec9875da83b28f5fedb961,
            0x56acd97a2f65633094f93584661f0e0285ec1ded74e5681a79e38d6885872052,
            0x50751275f19a69c6c1f1473d6bbb24a4f167a8f7e12647db357fb63b6a8c5c1a,
            0x51367557d68ddf40232883561ccb71a515b31ca3029a6c925e2ff129e7ca010a,
            0x14043f4bae17c73931a86d6fc24262a0a1aa58f1f2701656dcc130eba7aaa375,
            0x25e328702b17660a4bdcf23f24e60734fd9a9d80c466493c940e17e8e349e17c,
            0x2984f1d569efc6c2cfdfb283bc446d619f08f9ed4059eb421e98960901bcaeb4,
            0x362ba59bd67abc670ca7e09a9c62abbb57f7ee674014b2b5c68f2e1f6d7542ce,
            0x56f6da96255182b36f00f4250b5924e696fbd944391a3c85b92451dc3abe9efc)
        );
        sbox_full(i, q);
        mix(i, q);
        // round 65
        ark(i, q, HashInputs25(0x0a8ba019901457f7c5be303462fd6e1bc4b928681a40a76fe511c5193f6c43cc,
            0x476e2ed66a443dcacfc7728304e063f28f33a397f5d84c04f6bb3e12da8e0485,
            0x2954902e1aac134a27a67f82d5a910fad8af7249b31af9ec0a7156952b2b6494,
            0x060cc1660c338c002c293c0eae23fc6ef5c6cf6d629b40fe9b636ed13e053360,
            0x624d28c98fa7c2fee46d2d6b4cb37bda87f41569fc5bfcc5a213c11e3e61fb73,
            0x6a86b70cc18455c7be799589392a9a52073715107f177faaab59903ea2bc637c,
            0x6c250dce1175b4ac6405f595022bdc50c15975de98e30d08442ff31ca9164cc0,
            0x0ea09f0141fa638fd0960a75bdfbecdeb24422db381519cd4193527fe152b78a,
            0x5047698f0b27aafd10e06de90fd8a20295e92e5b706d5a117558a1289e853735,
            0x092535701f0c0220a6ecfd28992d4f24eef004018982aaae5bb86f7c7ffe6652,
            0x5a43a98f7f6645340ca6600f7cafce7be2e11ea6c4f91537de3da22082e368e3,
            0x43edb0eb6a3d66f85dc4c103cd6549b2fde233e2af7f2c6bd105f4e57960ac4c,
            0x2d5cd8050712693c52d77713f6fa2eeff0ddfe7aeb9b777aa70802c15381a08f,
            0x1bf1ad5b2552dd43acda533025e188fb7b7482876fc3397b64def9c801378014,
            0x502bb2956f54511e5f209306a23acebc1b48a7b0fa3c8d60d7a0714a2010f6d9,
            0x1750d7d62bf4b4992959bcdf4cb9c3fdc55f0d23004069fea62ffc3bc4ff5c05,
            0x00b732b77184f1e8f8fd8cb687acb62bf8e9c9a9f9bdef380231cc07deab3f81,
            0x235768271a5b8bd84c2da554f1f793482401a4020b2eae063edcfddbe8b9180d,
            0x2a16e5f3c52a3366fd15981ea904a94bdbe86a911d9f9441cf1483fce23801bc,
            0x2345f76c0c7047d829a254eb8c60a0c6bc6455322734331d9324dbe73483f88d,
            0x3386e0d7c41bbfc6436ed4196968fb7655ffa73acf11f1db40e96ba6f7a07b00,
            0x1d691730934c21ad6ec94b218164e54f64388378a806437cb1f048c21181ca25,
            0x330062b7855f2a5ac5b876c2b01d3801bb612a1ac880b087637a5fc68e9c5f74,
            0x62ddfb6101b57ddea53406dcedd6fbcaf25012771be9f000821f881243347c54,
            0x3899cc9f2c490b8e0b4432c4787cd5699de451f910fc7a6b4acde3d879d00271)
        );
        sbox_full(i, q);
        mix(i, q);
        // round 66
        ark(i, q, HashInputs25(0x35aa14ec1cf7c7340948e83d155266f526799ac5cd4ace02e7a35f376f69af46,
            0x4cb9ca9ec6d286c893604697b8b76cc73ab24178202deadd38e60bc4e474a6da,
            0x1da6c8ffd01b5262417ef6e9c2ddf5da1f15c161485c659df6f06a932c08f911,
            0x20f8dca982cb0fd674c947c3f38ef4d4c7c8a309c7a1d1339f929680fb507323,
            0x5161e07066d385a5f532dc602bd961e9a8b70c7e56c13b513c7e3ce8a8091a19,
            0x38f579f8e2df1d9d5ee6a09614e7c6add95732251be3fb38664cb37370ef45bf,
            0x435b01d8ae4b2cad6a88299be0234d0ba638a521961fc855022b7c6b90531e4d,
            0x297937227213de51c1883c24ac4250cbd9b5ffeea0265a6bc410a3d0a151b846,
            0x4d3e16a92ac553726f35152e048ff941baa6a4858ebe60a1d3a8e895a4c15185,
            0x0d3a15d6b49998659e83a1d9da7a866daab0751cdb75f15effb64fca8cf0332c,
            0x663dbd7c4d32ca272b4b24a231fecfdcb90c64e95a22351bf7aecfc13445e9ec,
            0x19926323a54455d94f77ae273d87f43dda35d883c41168183c14dbe7303d60de,
            0x29a2a50533e3f722ec8592eeffa669142dcb12f94ea5a78d0915016d8439d96c,
            0x670df96e875fd3aca5ae33a411256bb15164b1876b5050a02e93fb4e03d8eb8a,
            0x1fefe619134a3a31b493ad8793ce9221491953380c508696ec9019a44bba37e8,
            0x1320daaa547d0ae800c162e3355d11de7e39fa6cd37a524a9dd2221da8786ee7,
            0x47270c93bb127c06163b8fc84d07296c2eb3f1f2229efc4de76771c0998e3a81,
            0x261c2262e6cc5b9372f3b3aee72c48586f9deec7118b30dd9cbfd9abc0798bc4,
            0x652942e457e4827ed17ce2f1953aa8c5fa05ff70761bf4568ab498af957da48d,
            0x49dfd3d3d536dd79671b8fb4d6e397e8b1e6a0e24e639a05fa9af34bd10c37b9,
            0x709ab615c7b40d45feeec65509eb6fb820cf4a741767d1364a2ed36d6c2cc1d4,
            0x15a007b91236ec862240720bd3ef74bc6f2ff624b33de67778870933796784a0,
            0x4991b4bbf313f53f91120b0cc6c15fcfac3f061677681dd11d7acc03dc31c1c6,
            0x6d774a03dec14a18fba28097cd5c5bdaf68ee3333ca5f288d3d1cfbbe1c2001a,
            0x31c4b1ab46a795b261e61fbf92c2d007d16442ea6a2d7f41fc2402b7babfdc7f)
        );
        sbox_full(i, q);
        mix(i, q);

        return i.t1;
    }
}
