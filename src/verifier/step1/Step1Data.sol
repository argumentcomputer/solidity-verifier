pragma solidity ^0.8.0;
library NovaVerifierStep1DataLib {
function get_r_u_primary_X() public pure returns (uint256[] memory) {
uint256[] memory r_u_primary_X = new uint256[](2);
r_u_primary_X[0] = 0x41f52b545540cd8add35b444bcdcc9561fd1539f35948171c13baa4e8bccfc1a;
r_u_primary_X[1] = 0xe9185e4eaa0785785f5f740f93cb93c7a308c10eab09ca527ae13dca87633f0b;
return r_u_primary_X;
}
function get_l_u_primary_X() public pure returns (uint256[] memory) {
uint256[] memory l_u_primary_X = new uint256[](2);
l_u_primary_X[0] = 0xca7562fbd1521f53030240a9ebc049769c81aa100d3c3d4b4aad6cdd381dd402;
l_u_primary_X[1] = 0x324a23526a206e6ea1077a87c58b61d1a9207365802bc67b9caf559f03218203;
return l_u_primary_X;
}
function get_r_u_secondary_X() public pure returns (uint256[] memory) {
uint256[] memory r_u_secondary_X = new uint256[](2);
r_u_secondary_X[0] = 0x1a44725ed27e9ad353e1b3a69be5a2139170149bd7f133e84df85b73e10a7b10;
r_u_secondary_X[1] = 0x231df3a0a02a8a332d3b0e76e357bb5a5ecc7d5e4e480f00317e56bc5aab1b17;
return r_u_secondary_X;
}
function get_l_u_secondary_X() public pure returns (uint256[] memory) {
uint256[] memory l_u_secondary_X = new uint256[](2);
l_u_secondary_X[0] = 0x324a23526a206e6ea1077a87c58b61d1a9207365802bc67b9caf559f03218203;
l_u_secondary_X[1] = 0xae0c4e14393eca8b2a1264b082a3471eb440cc07f42ea9761bbd041ebf69ce03;
return l_u_secondary_X;
}
}
