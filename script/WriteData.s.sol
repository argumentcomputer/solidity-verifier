// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.0;

import "@std/Script.sol";
import {StorageContract} from "src/NovaVerifierContract.sol";

contract WriteDataExampleScript is Script {
    function run() external {
        vm.startBroadcast();

        new StorageContract();

        vm.stopBroadcast();
    }
}
