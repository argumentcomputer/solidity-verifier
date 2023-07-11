// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.0;

import "@std/Test.sol";
import "src/verifier/step4/KeccakTranscript.sol";
import "src/verifier/step4/SumcheckLogic.sol";

contract SumcheckTest is Test {
    function log2(uint256 x) public pure returns (uint256 y){
        assembly {
            let arg := x
            x := sub(x,1)
            x := or(x, div(x, 0x02))
            x := or(x, div(x, 0x04))
            x := or(x, div(x, 0x10))
            x := or(x, div(x, 0x100))
            x := or(x, div(x, 0x10000))
            x := or(x, div(x, 0x100000000))
            x := or(x, div(x, 0x10000000000000000))
            x := or(x, div(x, 0x100000000000000000000000000000000))
            x := add(x, 1)
            let m := mload(0x40)
            mstore(m,           0xf8f9cbfae6cc78fbefe7cdc3a1793dfcf4f0e8bbd8cec470b6a28a7a5a3e1efd)
            mstore(add(m,0x20), 0xf5ecf1b3e9debc68e1d9cfabc5997135bfb7a7a3938b7b606b5b4b3f2f1f0ffe)
            mstore(add(m,0x40), 0xf6e4ed9ff2d6b458eadcdf97bd91692de2d4da8fd2d0ac50c6ae9a8272523616)
            mstore(add(m,0x60), 0xc8c0b887b0a8a4489c948c7f847c6125746c645c544c444038302820181008ff)
            mstore(add(m,0x80), 0xf7cae577eec2a03cf3bad76fb589591debb2dd67e0aa9834bea6925f6a4a2e0e)
            mstore(add(m,0xa0), 0xe39ed557db96902cd38ed14fad815115c786af479b7e83247363534337271707)
            mstore(add(m,0xc0), 0xc976c13bb96e881cb166a933a55e490d9d56952b8d4e801485467d2362422606)
            mstore(add(m,0xe0), 0x753a6d1b65325d0c552a4d1345224105391a310b29122104190a110309020100)
            mstore(0x40, add(m, 0x100))
            let magic := 0x818283848586878898a8b8c8d8e8f929395969799a9b9d9e9faaeb6bedeeff
            let shift := 0x100000000000000000000000000000000000000000000000000000000000000
            let a := div(mul(x, magic), shift)
            y := div(mload(add(m,sub(255,a))), shift)
            y := add(y, mul(256, gt(arg, 0x8000000000000000000000000000000000000000000000000000000000000000)))
        }
    }

    function testComputeTauPrimary() public {
        uint8[] memory input = new uint8[](16); // b"RelaxedR1CSSNARK" in Rust
        input[0] = 0x52;
        input[1] = 0x65;
        input[2] = 0x6c;
        input[3] = 0x61;
        input[4] = 0x78;
        input[5] = 0x65;
        input[6] = 0x64;
        input[7] = 0x52;
        input[8] = 0x31;
        input[9] = 0x43;
        input[10] = 0x53;
        input[11] = 0x53;
        input[12] = 0x4e;
        input[13] = 0x41;
        input[14] = 0x52;
        input[15] = 0x4b;

        KeccakTranscriptLib.KeccakTranscript memory transcript = KeccakTranscriptLib.instantiate(input);

        uint8[] memory vk_comm = new uint8[](32);
        vk_comm[0] = 0x23; vk_comm[1] = 0xa9; vk_comm[2] = 0x65; vk_comm[3] = 0xae; vk_comm[4] = 0xf5; vk_comm[5] = 0x44; vk_comm[6] = 0x37; vk_comm[7] = 0x51;
        vk_comm[8] = 0x77; vk_comm[9] = 0xe0; vk_comm[10] = 0xae; vk_comm[11] = 0x37; vk_comm[12] = 0x26; vk_comm[13] = 0x8b; vk_comm[14] = 0x5b; vk_comm[15] = 0x32;
        vk_comm[16] = 0xca;  vk_comm[17] = 0x91; vk_comm[18] = 0x55; vk_comm[19] = 0x28; vk_comm[20] = 0xac; vk_comm[21] = 0x3b; vk_comm[22] = 0x12; vk_comm[23] = 0x23;
        vk_comm[24] = 0xe5; vk_comm[25] = 0x68; vk_comm[26] = 0xfb; vk_comm[27] = 0x1c; vk_comm[28] = 0xef; vk_comm[29] = 0x6b; vk_comm[30] = 0x41; vk_comm[31] = 0x03;

        uint8[] memory vk_comm_label = new uint8[](1); // b"C" in Rust
        vk_comm_label[0] = 0x43;

        uint8[] memory U = new uint8[](226);
        U[0] = 0xab; U[1] = 0xf4; U[2] = 0xc0; U[3] = 0x93; U[4] = 0xd7; U[5] = 0x1b; U[6] = 0xd2; U[7] = 0xab;
        U[8] = 0x61; U[9] = 0xa2; U[10] = 0x84; U[11] = 0x16; U[12] = 0x3a; U[13] = 0x36; U[14] = 0xb2; U[15] = 0x6c;
        U[16] = 0x75; U[17] = 0x42; U[18] = 0x9c; U[19] = 0x4e; U[20] = 0x0a; U[21] = 0xbe; U[22] = 0x30; U[23] = 0x25;
        U[24] = 0x86; U[25] = 0xb8; U[26] = 0x75; U[27] = 0x6f; U[28] = 0x56; U[29] = 0x1c; U[30] = 0x3b; U[31] = 0x22;
        U[32] = 0x08; U[33] = 0x4e; U[34] = 0xc4; U[35] = 0x00; U[36] = 0xc1; U[37] = 0xbc; U[38] = 0x28; U[39] = 0x22;
        U[40] = 0x6d; U[41] = 0xc7; U[42] = 0x98; U[43] = 0x66; U[44] = 0x2a; U[45] = 0x67; U[46] = 0x8d; U[47] = 0x47;
        U[48] = 0xf0; U[49] = 0x1e; U[50] = 0x0c; U[51] = 0x24; U[52] = 0xee; U[53] = 0xaa; U[54] = 0x59; U[55] = 0x69;
        U[56] = 0xf7; U[57] = 0xaa; U[58] = 0xcf; U[59] = 0x24; U[60] = 0x19; U[61] = 0x8c; U[62] = 0x21; U[63] = 0x05;
        U[64] = 0x01; U[65] = 0x94; U[66] = 0x18; U[67] = 0x0d; U[68] = 0x05; U[69] = 0x6f; U[70] = 0xf8; U[71] = 0x6d;
        U[72] = 0xd8; U[73] = 0xb2; U[74] = 0x99; U[75] = 0x7f; U[76] = 0x5f; U[77] = 0xd7; U[78] = 0xe2; U[79] = 0x53;
        U[80] = 0xd4; U[81] = 0x0d; U[82] = 0xfb; U[83] = 0xa2; U[84] = 0x7a; U[85] = 0x8b; U[86] = 0x4c; U[87] = 0xb9;
        U[88] = 0x74; U[89] = 0x62; U[90] = 0xe6; U[91] = 0xef; U[92] = 0x3a; U[93] = 0x52; U[94] = 0x2b; U[95] = 0xf0;
        U[96] = 0x15; U[97] = 0x78; U[98] = 0x01; U[99] = 0x35; U[100] = 0x68; U[101] = 0xf3; U[102] = 0x63; U[103] = 0x2c;
        U[104] = 0x36; U[105] = 0x67; U[106] = 0x02; U[107] = 0x01; U[108] = 0xea; U[109] = 0x3a; U[110] = 0x89; U[111] = 0x9f;
        U[112] = 0x60; U[113] = 0x25; U[114] = 0x05; U[115] = 0x1e; U[116] = 0x74; U[117] = 0xd3; U[118] = 0x9a; U[119] = 0x85;
        U[120] = 0x6c; U[121] = 0xf0; U[122] = 0x96; U[123] = 0x77; U[124] = 0xff; U[125] = 0xda; U[126] = 0xea; U[127] = 0x48;
        U[128] = 0x34; U[129] = 0x01; U[130] = 0x30; U[131] = 0x65; U[132] = 0xfe; U[133] = 0x20; U[134] = 0x9d; U[135] = 0x44;
        U[136] = 0xbb; U[137] = 0x99; U[138] = 0x76; U[139] = 0x58; U[140] = 0x4c; U[141] = 0xb4; U[142] = 0xea; U[143] = 0xd9;
        U[144] = 0x89; U[145] = 0xa3; U[146] = 0x01; U[147] = 0x00; U[148] = 0x00; U[149] = 0x00; U[150] = 0x00; U[151] = 0x00;
        U[152] = 0x00; U[153] = 0x00; U[154] = 0x00; U[155] = 0x00; U[156] = 0x00; U[157] = 0x00; U[158] = 0x00; U[159] = 0x00;
        U[160] = 0x00; U[161] = 0x00; U[162] = 0x6a; U[163] = 0xf4; U[164] = 0x72; U[165] = 0xae; U[166] = 0x09; U[167] = 0xba;
        U[168] = 0x90; U[169] = 0x21; U[170] = 0xc5; U[171] = 0xca; U[172] = 0xd4; U[173] = 0xa5; U[174] = 0x3d; U[175] = 0xe0;
        U[176] = 0x18; U[177] = 0x1f; U[178] = 0x07; U[179] = 0xd3; U[180] = 0xd7; U[181] = 0x18; U[182] = 0xf7; U[183] = 0x98;
        U[184] = 0x27; U[185] = 0xa1; U[186] = 0x2b; U[187] = 0x6f; U[188] = 0xa6; U[189] = 0x56; U[190] = 0x0a; U[191] = 0xd2;
        U[192] = 0x56; U[193] = 0x2e; U[194] = 0xad; U[195] = 0x9f; U[196] = 0xa6; U[197] = 0x2a; U[198] = 0x1a; U[199] = 0x9d;
        U[200] = 0x69; U[201] = 0x38; U[202] = 0xce; U[203] = 0x77; U[204] = 0xa3; U[205] = 0xd0; U[206] = 0x4b; U[207] = 0x90;
        U[208] = 0xce; U[209] = 0xf2; U[210] = 0x2b; U[211] = 0x0e; U[212] = 0x8d; U[213] = 0x05; U[214] = 0x4b; U[215] = 0x68;
        U[216] = 0x8f; U[217] = 0x47; U[218] = 0x5b; U[219] = 0x0c; U[220] = 0xa6; U[221] = 0xa1; U[222] = 0x2b; U[223] = 0xf5;
        U[224] = 0x75; U[225] = 0x28;

        uint8[] memory U_label = new uint8[](1); // b"U" in Rust
        U_label[0] = 0x55;

        transcript = KeccakTranscriptLib.absorb(transcript, vk_comm_label, vk_comm);
        transcript = KeccakTranscriptLib.absorb(transcript, U_label, U);

        uint256 num_rounds_x = log2(16384);
        //uint256 num_rounds_y = log2(16384) + 1;

        uint8[] memory squeezeLabel = new uint8[](1); // b"t" in Rust
        squeezeLabel[0] = 0x74;
        ScalarFromUniformLib.Curve curve = ScalarFromUniformLib.curveVesta();

        uint256[] memory tau = new uint256[](num_rounds_x);
        uint256 keccakOutput;
        for (uint256 index = 0; index < tau.length; index++) {
            (transcript, keccakOutput) = KeccakTranscriptLib.squeeze(transcript, curve, squeezeLabel);
            tau[index] = keccakOutput;
        }

        assertEq(tau[0], 0x327f4af4db96711d3192cee19b1946d5b9d3c61e78d6f352261e11af7cbed55a);
        assertEq(tau[1], 0x2640290b59a25f849e020cb1b0063861e35a95a8c42a9cdd63928a4ea856adbf);
        assertEq(tau[2], 0x11b72e2a69592c5545a794428674fd998d4e3fbd52f156eca4a66d54f09f775e);
        assertEq(tau[3], 0x09b0dcdd3ebe153fea39180a0f6bf9546778ffd7e288088489529aa95097fcea);
        assertEq(tau[4], 0x3757c49e53ce7f58203159e411db2fe38854df4fc7a93833f28e63960576202e);
        assertEq(tau[5], 0x362681bac77a734c4b893a2a2ff2f3cfbff469319b1a1e851c139349f1f62232);
        assertEq(tau[6], 0x3036e71d56b2ed7027b5e305dddbc94d3bae6c6afdfaec8bdcd7d05cd89fc4ef);
        assertEq(tau[7], 0x33ebf2408bbe683a2516b6e3904d95f6a99da08c27843d425bb3e781b407f812);
        assertEq(tau[8], 0x03b2369449d816527fe9f0ec97e4971a65a35f89762ae71610f06096337ea9f2);
        assertEq(tau[9], 0x38ca25021f2193df59c755dcebe90a5efb52e97c0440597915d022e9a59357bd);
        assertEq(tau[10], 0x240032a20ecb27257f7334b3f538d836f40783e9709b879bd5523f789aad0a63);
        assertEq(tau[11], 0x364f7a4b101385305529e5d5237cb71e69950f2b4ed7b4f0b160b1aa3ac71c9a);
        assertEq(tau[12], 0x3ffacadcc0e723b1fa45c1ad1b30612dc31924e6027171f0a5da6d8963671c5a);
        assertEq(tau[13], 0x25ad865935043775d676da736cc400404b1060585df1386dd4f560de4c4680bc);
    }

    function loadCompressedPolysPrimary(uint256 num_rounds_x) public pure returns (PallasPolyLib.CompressedUniPoly[] memory){
        PallasPolyLib.CompressedUniPoly[] memory compressed_polys = new PallasPolyLib.CompressedUniPoly[](num_rounds_x);

        uint256[] memory raw_poly;
        PallasPolyLib.CompressedUniPoly memory poly;

        raw_poly = new uint256[](3);
        raw_poly[0] = 0x0000000000000000000000000000000000000000000000000000000000000000;
        raw_poly[1] = 0x3156ab3e1bea772559548817e8d23e4d60a57bc280baf032420e3c6133dd7e2f;
        raw_poly[2] = 0x1dff490409def9717737be07798dad2c3a6bc952eec88937c6076da01f9d9af0;

        poly = PallasPolyLib.CompressedUniPoly(raw_poly);
        compressed_polys[0] = poly;

        raw_poly = new uint256[](3);
        raw_poly[0] = 0x2a0cd6f39b97ed92a45886a8e80a5944ed373498922050a3745f29c2ec6667ae;
        raw_poly[1] = 0x12fbd521f3fdb45f92e1bc9d045197000c74f40e67292ccac43f9b65f854b955;
        raw_poly[2] = 0x0bf922cb074481cf22bfe02c62561af632503238b4198aeb5e2bb5cf8dd0fac3;

        poly = PallasPolyLib.CompressedUniPoly(raw_poly);
        compressed_polys[1] = poly;

        raw_poly = new uint256[](3);
        raw_poly[0] = 0x1a7160ebd6e443d51da504fa28e5168868012deaacfc8188014cde90744297bc;
        raw_poly[1] = 0x281222608e87d3d0d154e6621dbe68a181e5e646bbaab420859659a0e042dd4c;
        raw_poly[2] = 0x2ae2df351788ef2c603da9501a93ea6ea1080a1742c923a56e0daa7e0599cd1e;

        poly = PallasPolyLib.CompressedUniPoly(raw_poly);
        compressed_polys[2] = poly;

        raw_poly = new uint256[](3);
        raw_poly[0] = 0x2cadc3a75b23fdebbcef67f3b2d193348ea927786e761d43406e4358d324c4d1;
        raw_poly[1] = 0x06d2d5a5f516f2734156ed7b78e9687e0a6a52c89456c09af0609fe5b27b1fca;
        raw_poly[2] = 0x0a1a4cee698d0bea9725c189f39509b1e3fb54dcbf0cfeb0ead4a679e30b6b97;

        poly = PallasPolyLib.CompressedUniPoly(raw_poly);
        compressed_polys[3] = poly;

        raw_poly = new uint256[](3);
        raw_poly[0] = 0x21d36d5eeab44b9e1dab9a1941353a9b259b0e37f8130c97ac45e7ee1ee46e5d;
        raw_poly[1] = 0x09cd8f4b3cdb357a80b6d967f5c0f33335ba536e76092ed3ac9ce4b576777817;
        raw_poly[2] = 0x047de779ead5aef11c60969244ec4bdcf2ef7e7081f734a4239cfe4607768d6c;

        poly = PallasPolyLib.CompressedUniPoly(raw_poly);
        compressed_polys[4] = poly;

        raw_poly = new uint256[](3);
        raw_poly[0] = 0x25291aac7c299b973f93613a17c13191037cb2fd01e2eccdf4697deaf0c9a04a;
        raw_poly[1] = 0x35f26c09cec10804a870e39ef1d192dd5609b1481229da10415680c367fce145;
        raw_poly[2] = 0x2b37031e0daac3039e35efc738ca354614b0263e45658a0c90de1dccd6735711;

        poly = PallasPolyLib.CompressedUniPoly(raw_poly);
        compressed_polys[5] = poly;

        raw_poly = new uint256[](3);
        raw_poly[0] = 0x02563c53bdabeb954ec43901c61cb5ad9e81c2cb7dd31b9f46f80440078fd7fd;
        raw_poly[1] = 0x0807ce199363c83d6c6fbeb708cef45c4f96236b7e861812b879de1a205db161;
        raw_poly[2] = 0x32fcb855b9dd89717b27154af419b9389ad459a36f94730efe771b0f5940f633;

        poly = PallasPolyLib.CompressedUniPoly(raw_poly);
        compressed_polys[6] = poly;

        raw_poly = new uint256[](3);
        raw_poly[0] = 0x2087b996187c4be4d5eb576a9b6d00d315ad25cee961c8f424621a41c6b0c971;
        raw_poly[1] = 0x1ef0832cd1a4ba98bf66682a990f9c56216fc31b39d2adecc94c5cc9b4031ab8;
        raw_poly[2] = 0x0b652696a88affcc0ab69d52903bcd3965f262ddf222c3fe2da3af2fa6a0f27a;

        poly = PallasPolyLib.CompressedUniPoly(raw_poly);
        compressed_polys[7] = poly;

        raw_poly = new uint256[](3);
        raw_poly[0] = 0x36a3f10a14df17c5dde2ec64df992874659af5e22e4db23ad1ea73d66807c8ef;
        raw_poly[1] = 0x09c9b72ebe89f51aec378af41815f75964c4d8f993e5f9b1681e2b21a42385f9;
        raw_poly[2] = 0x1b75c4dd2c3cb3a62b90b02ea20c4051ca98c9d9c1424a2421f947c12c7d3eb7;

        poly = PallasPolyLib.CompressedUniPoly(raw_poly);
        compressed_polys[8] = poly;

        raw_poly = new uint256[](3);
        raw_poly[0] = 0x2828a18fa8618435b512a4292b9fcea3b150859f50a3e74bb2a3ee15ae88da9c;
        raw_poly[1] = 0x1964a64964a1859af0d3d333762bbec3a22487ca091e6b89494ce72cef90130a;
        raw_poly[2] = 0x10e43d7966039b6cc7b1ced16fd886fe1ca375a8485b820f48611b822781226c;

        poly = PallasPolyLib.CompressedUniPoly(raw_poly);
        compressed_polys[9] = poly;

        raw_poly = new uint256[](3);
        raw_poly[0] = 0x3eb95a4f74af56e31c0b35fe7498c938009c9bea670a61a8383dab0c4c429bfe;
        raw_poly[1] = 0x0dff761d89b94a2551136b0f4df357b400850910295952ad9ee5c2f85123e5e5;
        raw_poly[2] = 0x13e46518e76c51be58f3748832326568b0c2cd2e683ae9bb4b1ece9b93c56376;

        poly = PallasPolyLib.CompressedUniPoly(raw_poly);
        compressed_polys[10] = poly;

        raw_poly = new uint256[](3);
        raw_poly[0] = 0x26592d33bfd615e40cfe4c9a0b8e56e88a2c8aa00c84f49b783b4f0c1c359706;
        raw_poly[1] = 0x29f1f0b13ba89df090f4d23bc74060929ca75281737b7200ec6ad66e94e3c1e2;
        raw_poly[2] = 0x36ede69bcd3a25e759a2b798f83b569a4906b688623ac23529b8cdc12355abc3;

        poly = PallasPolyLib.CompressedUniPoly(raw_poly);
        compressed_polys[11] = poly;

        raw_poly = new uint256[](3);
        raw_poly[0] = 0x05d85babbee109ab6d627a03a8e8ea0d372d96cfa1929cee86ae5af797cb9657;
        raw_poly[1] = 0x2b9ce21b23851fcce3cc996e5c80da63f8818737d35957b31b0125bccfebe967;
        raw_poly[2] = 0x15f5eb776094fbed243e952d5c3512ec31b123db1af788fa9686b8b18b7d7168;

        poly = PallasPolyLib.CompressedUniPoly(raw_poly);
        compressed_polys[12] = poly;

        raw_poly = new uint256[](3);
        raw_poly[0] = 0x07e180612d7bd63a41bd64c2e6c1b0c5edbe6fa6f318cba353edb77eecd59bac;
        raw_poly[1] = 0x1785c227874bcb2e816af7d0b1b39d6369dc3017b21cfdaccbbbdf3e9a63c9ca;
        raw_poly[2] = 0x3001d35ebe98119d070a55ea1544bcb729493df381bf7c80ffb0203b2956d7c9;

        poly = PallasPolyLib.CompressedUniPoly(raw_poly);
        compressed_polys[13] = poly;

        return compressed_polys;
    }

    function testSumcheckPrimary() public {
        uint256 e = 0;
        uint256 num_rounds_x = 14;
        uint256 degreeBound = 3;

        uint16 rounds = 14;
        uint8[] memory state = new uint8[](KeccakTranscriptLib.KECCAK_TRANSCRIPT_STATE_BYTE_LEN);
        state[0] = 0x6e; state[1] = 0x4d; state[2] = 0x2b; state[3] = 0x8b; state[4] = 0x6c; state[5] = 0x32; state[6] = 0xc7; state[7] = 0xce;
        state[8] = 0xda; state[9] = 0x36; state[10] = 0x09; state[11] = 0xca; state[12] = 0x86; state[13] = 0xe9; state[14] = 0x7b; state[15] = 0x40;
        state[16] = 0xc7; state[17] = 0x5c; state[18] = 0x3f; state[19] = 0xf4; state[20] = 0xc0; state[21] = 0xc8; state[22] = 0xde; state[23] = 0x11;
        state[24] = 0x18; state[25] = 0x3c; state[26] = 0xe5; state[27] = 0x6f; state[28] = 0x51; state[29] = 0x65; state[30] = 0xb3; state[31] = 0x00;
        state[32] = 0x97; state[33] = 0x32; state[34] = 0x29; state[35] = 0xfc; state[36] = 0xbe; state[37] = 0x23; state[38] = 0x81; state[39] = 0x62;
        state[40] = 0x89; state[41] = 0xaf; state[42] = 0xab; state[43] = 0x47; state[44] = 0xe3; state[45] = 0xd6; state[46] = 0x54; state[47] = 0xe0;
        state[48] = 0x3a; state[49] = 0xaa; state[50] = 0x9d; state[51] = 0xd4; state[52] = 0x51; state[53] = 0x7d; state[54] = 0x37; state[55] = 0x72;
        state[56] = 0x53; state[57] = 0xd0; state[58] = 0x3e; state[59] = 0x03; state[60] = 0xe7; state[61] = 0xf8; state[62] = 0xd7; state[63] = 0x50;

        uint8[] memory transcriptField = new uint8[](0);

        KeccakTranscriptLib.KeccakTranscript memory transcript = KeccakTranscriptLib.KeccakTranscript(rounds, state, transcriptField);

        //uint256 claim_outer_final_expected = 0x346b738474d5b2cda8c002566f1a7004d06cab6b467303a2b7c4b04eaa6df733;
        uint256[] memory r_x_expected = new uint256[](14 + 1);
        r_x_expected[0] = 0x265e1d73ee4ce9a23d98bf74a9807abd1c0bedf6368e8db884c05bd9336549bd;
        r_x_expected[1] = 0x3a009bec1c4dc776ba75c643de9e61b3070a4a6b3865b5751a3d6f517e483a4a;
        r_x_expected[2] = 0x3932891c1f17ba15d07baba47d6599058812a73225d11a554ced25ad00fd78dd;
        r_x_expected[3] = 0x140622b73b006b8470ed724172721f7d25f3efb2208f42c73e0658fbc493579b;
        r_x_expected[4] = 0x2516f6f6ccf854843d9319fad46a0dff2729c608af31c143590c347d0f0805c6;
        r_x_expected[5] = 0x28942f6ecc7b89c49bfaa569687a9b6902ace63343300e808e86d608eca3f9dc;
        r_x_expected[6] = 0x1ae6542e6085a0c42ae6e947813a6f701329263a1a59f823cb544e83dce0b9cf;
        r_x_expected[7] = 0x39979cf05d7d96da05aba4dd24e9f072d52e8efbf4740f1a857680a096193f8b;
        r_x_expected[8] = 0x2d887fae3954bcb89f20051c96f6812eb841ccc29c8b56e2879e445f74cb4331;
        r_x_expected[9] = 0x29fb4b14d5d53616b881719c4986e5aad92f7320fc1e6c89f301b8a81ab72896;
        r_x_expected[10] = 0x2d69fc2f360b3328cb723687589b065ff4250c414c817bd4f6b187583e103270;
        r_x_expected[11] = 0x06dc812740949078bc2487f020274042e7400e44f7a95d26c2cf6de8b7ba5099;
        r_x_expected[12] = 0x39ade5abede093bbb12d81f27c28cbc7149d1b1ad6e43c49424687fb4c29ae31;
        r_x_expected[13] = 0x3d764ae71118a8a3c653b58c534db9fae607dd9c316cdd3675de0d62e0882bf1;
        r_x_expected[14] = 0x346b738474d5b2cda8c002566f1a7004d06cab6b467303a2b7c4b04eaa6df733; // <-- include claim_outer_final_expected due to avoiding StackTooDeep

        PallasPolyLib.CompressedUniPoly[] memory compressed_polys = loadCompressedPolysPrimary(num_rounds_x);

        if (compressed_polys.length != num_rounds_x) {
            console.log("[NovaError::InvalidSumcheckProof], compressed_polys.length != num_rounds_x");
            revert();
        }

        PallasPolyLib.UniPoly memory uni_poly;
        uint8[] memory transcriptBytes;

        // use transcriptField as label
        transcriptField = new uint8[](1);

        uint256 r_i;
        for (uint256 index = 0; index < compressed_polys.length; index++) {
            uni_poly = PallasPolyLib.decompress(compressed_polys[index], e);

            if (PallasPolyLib.degree(uni_poly) != degreeBound) {
                console.log("[NovaError::InvalidSumcheckProof], PallasPolyLib.degree(uni_poly) != degreeBound");
                revert();
            }

            require(addmod(PallasPolyLib.evalAtZero(uni_poly), PallasPolyLib.evalAtOne(uni_poly), Pallas.R_MOD) == e, "evalAtZero + evalAtOne != e");

            transcriptBytes = PallasPolyLib.toTranscriptBytes(uni_poly);

            transcriptField[0] = 0x70; // b"p" in Rust
            transcript = KeccakTranscriptLib.absorb(transcript, transcriptField, transcriptBytes);

            transcriptField[0] = 0x63; // b"c" in Rust
            (transcript, r_i) = KeccakTranscriptLib.squeeze(transcript, ScalarFromUniformLib.curveVesta(), transcriptField); // Vesta

            e = PallasPolyLib.evaluate(uni_poly, r_i);

            assertEq(r_i, r_x_expected[index]);
        }

        assertEq(e, r_x_expected[r_x_expected.length - 1]);
    }

    function testPolyUncompress() public {
        uint256 e = 0;

        uint256[] memory raw_poly;
        PallasPolyLib.CompressedUniPoly memory poly;

        raw_poly = new uint256[](3);
        raw_poly[0] = 0x0000000000000000000000000000000000000000000000000000000000000000;
        raw_poly[1] = 0x3156ab3e1bea772559548817e8d23e4d60a57bc280baf032420e3c6133dd7e2f;
        raw_poly[2] = 0x1dff490409def9717737be07798dad2c3a6bc952eec88937c6076da01f9d9af0;

        poly = PallasPolyLib.CompressedUniPoly(raw_poly);

        PallasPolyLib.UniPoly memory uni_poly = PallasPolyLib.decompress(poly, e);

        assertEq(uni_poly.coeffs[0], 0x0000000000000000000000000000000000000000000000000000000000000000);
        assertEq(uni_poly.coeffs[1], 0x30aa0bbdda368f692f73b9e09da01486a97bece2a3a5d85110782c40ac84e6e3);
        assertEq(uni_poly.coeffs[2], 0x3156ab3e1bea772559548817e8d23e4d60a57bc280baf032420e3c6133dd7e2f);
        assertEq(uni_poly.coeffs[3], 0x1dff490409def9717737be07798dad2c3a6bc952eec88937c6076da01f9d9af0);
    }

    function testPolyEvalAtZero() public {
        uint256[] memory coeffs = new uint256[](4);
        coeffs[0] = 0x2a0cd6f39b97ed92a45886a8e80a5944ed373498922050a3745f29c2ec6667ae;
        coeffs[1] = 0x15d1d88908637f82529915e409c52f24dfdd0f088857a2ff9721405cbac93e42;
        coeffs[2] = 0x12fbd521f3fdb45f92e1bc9d045197000c74f40e67292ccac43f9b65f854b955;
        coeffs[3] = 0x0bf922cb074481cf22bfe02c62561af632503238b4198aeb5e2bb5cf8dd0fac3;

        PallasPolyLib.UniPoly memory uni_poly = PallasPolyLib.UniPoly(coeffs);

        assertEq(PallasPolyLib.evalAtZero(uni_poly), 0x2a0cd6f39b97ed92a45886a8e80a5944ed373498922050a3745f29c2ec6667ae);
    }

    function testPolyEvalAtOne1() public {
        uint256[] memory coeffs = new uint256[](4);
        coeffs[0] = 0x0000000000000000000000000000000000000000000000000000000000000000;
        coeffs[1] = 0x30aa0bbdda368f692f73b9e09da01486a97bece2a3a5d85110782c40ac84e6e3;
        coeffs[2] = 0x3156ab3e1bea772559548817e8d23e4d60a57bc280baf032420e3c6133dd7e2f;
        coeffs[3] = 0x1dff490409def9717737be07798dad2c3a6bc952eec88937c6076da01f9d9af0;

        PallasPolyLib.UniPoly memory uni_poly = PallasPolyLib.UniPoly(coeffs);

        assertEq(PallasPolyLib.evalAtOne(uni_poly), 0x0000000000000000000000000000000000000000000000000000000000000000);
    }

    function testPolyEvalAtOne2() public {
        uint256[] memory coeffs = new uint256[](4);
        coeffs[0] = 0x2a0cd6f39b97ed92a45886a8e80a5944ed373498922050a3745f29c2ec6667ae;
        coeffs[1] = 0x15d1d88908637f82529915e409c52f24dfdd0f088857a2ff9721405cbac93e42;
        coeffs[2] = 0x12fbd521f3fdb45f92e1bc9d045197000c74f40e67292ccac43f9b65f854b955;
        coeffs[3] = 0x0bf922cb074481cf22bfe02c62561af632503238b4198aeb5e2bb5cf8dd0fac3;

        PallasPolyLib.UniPoly memory uni_poly = PallasPolyLib.UniPoly(coeffs);

        assertEq(PallasPolyLib.evalAtOne(uni_poly), 0x1ed3a7699f3da343ac93395658773a5fe992d0ec2c26027ba1a4d0342d555a07);
    }

    function testPolyEvalAtOne3() public {
        uint256[] memory coeffs = new uint256[](4);
        coeffs[0] = 0x1a7160ebd6e443d51da504fa28e5168868012deaacfc8188014cde90744297bc;
        coeffs[1] = 0x00f74486c14ea32b0c2b2116f5bcb73950d525199ddbca495ad7685e96f22f76;
        coeffs[2] = 0x281222608e87d3d0d154e6621dbe68a181e5e646bbaab420859659a0e042dd4c;
        coeffs[3] = 0x2ae2df351788ef2c603da9501a93ea6ea1080a1742c923a56e0daa7e0599cd1e;

        PallasPolyLib.UniPoly memory uni_poly = PallasPolyLib.UniPoly(coeffs);

        assertEq(PallasPolyLib.evalAtOne(uni_poly), 0x2e5da7083e43a9fd5b62b5c356f420d1b97daa663fb77ab9c3815fecf111719b);
    }

    function testPolyToTranscriptBytes() public {
        uint256[] memory coeffs = new uint256[](4);
        coeffs[0] = 0x07e180612d7bd63a41bd64c2e6c1b0c5edbe6fa6f318cba353edb77eecd59bac;
        coeffs[1] = 0x3ebba32e8b1eb5338d437e0db1894ab6fb2c14725daeef4c6a361fce880ae0ed;
        coeffs[2] = 0x1785c227874bcb2e816af7d0b1b39d6369dc3017b21cfdaccbbbdf3e9a63c9ca;
        coeffs[3] = 0x3001d35ebe98119d070a55ea1544bcb729493df381bf7c80ffb0203b2956d7c9;

        PallasPolyLib.UniPoly memory uni_poly = PallasPolyLib.UniPoly(coeffs);

        uint8[] memory polyBytes = PallasPolyLib.toTranscriptBytes(uni_poly);

        uint8[] memory expected = new uint8[](96);
        expected[0] = 0xac; expected[1] = 0x9b; expected[2] = 0xd5; expected[3] = 0xec; expected[4] = 0x7e; expected[5] = 0xb7; expected[6] = 0xed; expected[7] = 0x53;
        expected[8] = 0xa3; expected[9] = 0xcb; expected[10] = 0x18; expected[11] = 0xf3; expected[12] = 0xa6; expected[13] = 0x6f; expected[14] = 0xbe; expected[15] = 0xed;
        expected[16] = 0xc5; expected[17] = 0xb0; expected[18] = 0xc1; expected[19] = 0xe6; expected[20] = 0xc2; expected[21] = 0x64; expected[22] = 0xbd; expected[23] = 0x41;
        expected[24] = 0x3a; expected[25] = 0xd6; expected[26] = 0x7b; expected[27] = 0x2d; expected[28] = 0x61; expected[29] = 0x80; expected[30] = 0xe1; expected[31] = 0x07;
        expected[32] = 0xca; expected[33] = 0xc9; expected[34] = 0x63; expected[35] = 0x9a; expected[36] = 0x3e; expected[37] = 0xdf; expected[38] = 0xbb; expected[39] = 0xcb;
        expected[40] = 0xac; expected[41] = 0xfd; expected[42] = 0x1c; expected[43] = 0xb2; expected[44] = 0x17; expected[45] = 0x30; expected[46] = 0xdc; expected[47] = 0x69;
        expected[48] = 0x63; expected[49] = 0x9d; expected[50] = 0xb3; expected[51] = 0xb1; expected[52] = 0xd0; expected[53] = 0xf7; expected[54] = 0x6a; expected[55] = 0x81;
        expected[56] = 0x2e; expected[57] = 0xcb; expected[58] = 0x4b; expected[59] = 0x87; expected[60] = 0x27; expected[61] = 0xc2; expected[62] = 0x85; expected[63] = 0x17;
        expected[64] = 0xc9; expected[65] = 0xd7; expected[66] = 0x56; expected[67] = 0x29; expected[68] = 0x3b; expected[69] = 0x20; expected[70] = 0xb0; expected[71] = 0xff;
        expected[72] = 0x80; expected[73] = 0x7c; expected[74] = 0xbf; expected[75] = 0x81; expected[76] = 0xf3; expected[77] = 0x3d; expected[78] = 0x49; expected[79] = 0x29;
        expected[80] = 0xb7; expected[81] = 0xbc; expected[82] = 0x44; expected[83] = 0x15; expected[84] = 0xea; expected[85] = 0x55; expected[86] = 0x0a; expected[87] = 0x07;
        expected[88] = 0x9d; expected[89] = 0x11; expected[90] = 0x98; expected[91] = 0xbe; expected[92] = 0x5e; expected[93] = 0xd3; expected[94] = 0x01; expected[95] = 0x30;

        assertEq(polyBytes.length, expected.length);
        for (uint256 index = 0; index < polyBytes.length; index++) {
            assertEq(polyBytes[index], expected[index]);
        }
    }
}