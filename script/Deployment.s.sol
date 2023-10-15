// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.0;

import "@std/Script.sol";
import "src/NovaVerifierContract.sol";

contract NovaVerifierDeployer is Script {
    function run() external {
        vm.startBroadcast();
        new NovaVerifierContract();
        vm.stopBroadcast();
    }
}
