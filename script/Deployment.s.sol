// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.16;

import "@std/Script.sol";
import "src/NovaVerifierContractGrumpkin.sol";

contract NovaVerifierDeployer is Script {
    function run() external {
        vm.startBroadcast();
        new NovaVerifierContractGrumpkin();
        vm.stopBroadcast();
    }
}
