// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@std/Script.sol";
import "src/pasta/Pallas.sol";

contract PastaInteraction is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(deployerPrivateKey);

        uint256 x = 0x3f2c8a8b8128a470f4f9231d9c9361bbbbbcde77b44c9e0a2e3bb46ce24beb7f;
        uint256 y = 0x01519840885e662c3cec5b77dd4869ad67c6c20f4b9bbb0ad2aaca8ac5a3c574;
        uint256 z = 0x0000000000000000000000000000000000000000000000000000000000000001;

        Pallas.PallasProjectivePoint memory pointPallasFromXYZ = Pallas.PallasProjectivePoint(x, y, z);

        assert(x == pointPallasFromXYZ.x);
        assert(y == pointPallasFromXYZ.y);
        assert(z == 1);

        Pallas.PallasAffinePoint memory pointPallasFromXYZAffine = Pallas.IntoAffine(pointPallasFromXYZ);
        Pallas.validateCurvePoint(pointPallasFromXYZAffine);

        vm.stopBroadcast();
    }
}
