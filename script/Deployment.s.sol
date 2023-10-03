// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.16;

import "@std/Script.sol";
import "src/NovaVerifierContractPasta.sol";
import "src/NovaVerifierContractGrumpkin.sol";
import "src/AssemblyGrumpkin.sol";

contract NovaPastaVerifierDeployer is Script {
    function run() external {
        vm.startBroadcast();
        new NovaVerifierContract();
        vm.stopBroadcast();
    }
}

contract NovaGrumpkinVerifierDeployer is Script {
    function run() external {
        vm.startBroadcast();
        new NovaVerifierContractGrumpkin();
        vm.stopBroadcast();
    }
}

contract AssemblyGrumpkinDeployer is Script {
    function run() external {
        vm.startBroadcast();
        new AssemblyGrumpkinContract();
        vm.stopBroadcast();
    }
}
