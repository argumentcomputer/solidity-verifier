// SPDX-License-Identifier: Apache-2.0
// Do not change manually. This contract has been auto-generated by src/verifier/step3/step3-data-contractgen.py
pragma solidity ^0.8.0;

library Step3Data {
/* This function returns the following results in order:
* pp_digest, NIFS instance, r_U comm_W, r_U comm_E, r_U X, r_U u
* l_u comm_W, l_u X
*/
function returnPrimaryData() public pure returns (uint256, uint256[] memory, uint256, uint256, uint256[] memory, uint256, uint256, uint256[] memory) {
uint256 u  = 0xdca18ed3cacabc2daf70380c287c0840b694735dcc63375d49912a5676d5f300;
uint256[] memory nifs = uint256[](32)
nifs[0] = 129
nifs[1] = 78
nifs[2] = 43
nifs[3] = 114
nifs[4] = 14
nifs[5] = 217
nifs[6] = 55
nifs[7] = 0
nifs[8] = 141
nifs[9] = 134
nifs[10] = 81
nifs[11] = 102
nifs[12] = 170
nifs[13] = 237
nifs[14] = 6
nifs[15] = 198
nifs[16] = 55
nifs[17] = 200
nifs[18] = 187
nifs[19] = 76
nifs[20] = 24
nifs[21] = 102
nifs[22] = 243
nifs[23] = 155
nifs[24] = 138
nifs[25] = 115
nifs[26] = 129
nifs[27] = 71
nifs[28] = 160
nifs[29] = 43
nifs[30] = 56
nifs[31] = 24
uint256 r_U_comm_W = 0x1b76eba7530b994f67164777aae37817048460b0849628e9981dcf9b39a431ac;
uint256 r_U_comm_E = 0xa92e17aa8e3e813b25db0821f1d0cf57318ace70937d7ccb2b60e68e2967fdbb;
uint256[] memory r_U_X = uint256[](2)
r_U_X[0] = 0x41f52b545540cd8add35b444bcdcc9561fd1539f35948171c13baa4e8bccfc1a
r_U_X[1] = 0xe9185e4eaa0785785f5f740f93cb93c7a308c10eab09ca527ae13dca87633f0b
uint256 r_U_u = 0xebb5df91f82f07ccef5a3f3b56546bcc00000000000000000000000000000000;
uint256 l_u_comm_W = 0x73cb2576d50f1f5e74dce3cf18a48deb5ee483e870d5e8e8a8605b07dfe1920c;
uint256[] memory l_u_X = uint256[](2);
l_u_X[0] = 0xca7562fbd1521f53030240a9ebc049769c81aa100d3c3d4b4aad6cdd381dd402
l_u_X[1] = 0x324a23526a206e6ea1077a87c58b61d1a9207365802bc67b9caf559f03218203
return (u, nifs, r_U_comm_W, r_U_comm_E, r_U_X, r_U_u, l_u_comm_W, l_u_X);
}

/* This function returns the following results in order:
* pp_digest, NIFS instance, r_U comm_W, r_U comm_E, r_U X, r_U u
* l_u comm_W, l_u X
*/
function returnSecondaryData() public pure returns (uint256, uint256[] memory, uint256, uint256, uint256[] memory, uint256, uint256, uint256[] memory) {
uint256 u  = 0x34bd6851e96eefff978d32646f1b9073fdd364b702cd242e1cb594348450b703;
uint256[] memory nifs = uint256[](32)
nifs[0] = 51
nifs[1] = 28
nifs[2] = 184
nifs[3] = 191
nifs[4] = 145
nifs[5] = 149
nifs[6] = 208
nifs[7] = 155
nifs[8] = 200
nifs[9] = 88
nifs[10] = 188
nifs[11] = 40
nifs[12] = 1
nifs[13] = 24
nifs[14] = 67
nifs[15] = 125
nifs[16] = 209
nifs[17] = 153
nifs[18] = 46
nifs[19] = 23
nifs[20] = 49
nifs[21] = 243
nifs[22] = 244
nifs[23] = 155
nifs[24] = 67
nifs[25] = 33
nifs[26] = 24
nifs[27] = 58
nifs[28] = 215
nifs[29] = 175
nifs[30] = 103
nifs[31] = 6
uint256 r_U_comm_W = 0xfeb641951cb4c21bdc4906f57b46942c0ae22b6c852266f64a4e0b77de5c4432;
uint256 r_U_comm_E = 0x8412865c490c9e1219066e4e257f3bb28e00db31736251586c86197f6ec866a2;
uint256[] memory r_U_X = uint256[](2)
r_U_X[0] = 0x1a44725ed27e9ad353e1b3a69be5a2139170149bd7f133e84df85b73e10a7b10
r_U_X[1] = 0x231df3a0a02a8a332d3b0e76e357bb5a5ecc7d5e4e480f00317e56bc5aab1b17
uint256 r_U_u = 0x611f57f1585849b2ac46347128c2041801000000000000000000000000000000;
uint256 l_u_comm_W = 0xd07c3b4dd208f32a9e2d16213a976ad6f61dbdba7760478a85726dee9475e989;
uint256[] memory l_u_X = uint256[](2);
l_u_X[0] = 0x324a23526a206e6ea1077a87c58b61d1a9207365802bc67b9caf559f03218203
l_u_X[1] = 0xae0c4e14393eca8b2a1264b082a3471eb440cc07f42ea9761bbd041ebf69ce03
return (u, nifs, r_U_comm_W, r_U_comm_E, r_U_X, r_U_u, l_u_comm_W, l_u_X);
}

}
