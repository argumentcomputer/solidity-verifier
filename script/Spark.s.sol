// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.0;

import "@std/Script.sol";
import "src/verifier/step4/spark/SparkMultiEvaluationContract.sol";

contract SparkVerificationDeployer is Script {
    function run() external {
        vm.startBroadcast();
        new SparkMultiEvaluationContract();
        vm.stopBroadcast();
    }
}
