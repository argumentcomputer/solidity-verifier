# solidity-verifier

This repository will eventually contain Solidity implementation of Nova proving system.

The idea is actually to gather required cryptographic building blocks (pasta curves, Poseidon, etc.), evaluate them and check that they work as expected via test vectors provided by "trusted" Rust implementations and finally come up with working Nova verifier that can be deployed to the Filecoin network.

# Commands to play with

To cleanup current build artifacts:
```
forge clean
```

To build contracts:
```
forge build
```

To run Solidity unit-tests:
```
forge test --match-path test/* -vv
```

To deploy the contract (pasta curves) to the Hyperspace test network of Filecoin:
```
export PRIVATE_KEY='<YOUR PRIVATE KEY>'
forge create --rpc-url https://api.hyperspace.node.glif.io/rpc/v1 --private-key $PRIVATE_KEY --contracts src/pasta/PastaContracts.sol PallasContract
```

This requires getting private key with some tokens (TFIL) allocated. More details [here](https://github.com/filecoin-project/fevm-foundry-kit).

To interact with the deployed contract:

```
forge script script/PastaInteraction.s.sol:PastaInteraction --rpc-url https://api.hyperspace.node.glif.io/rpc/v1 --broadcast -g 10000
```

More details about Foundry tooling is [here](https://book.getfoundry.sh/).

# Solidity contracts generation

Some contracts in this repository have been generated with a help of correspondent Python scripts.

To re-generate Poseidon contracts (for Pallas and Vesta curves) compatible to Neptune and "sharpened" for usage in Nova:

```
python src/poseidon/poseidon-contract-gen.py neptune-constants-U24-pallas.json PoseidonU24Pallas > src/poseidon/PoseidonNeptuneU24pallas.sol
python src/poseidon/poseidon-contract-gen.py neptune-constants-U24-vesta.json PoseidonU24Vesta > src/poseidon/PoseidonNeptuneU24vesta.sol
```

To re-generate contract-helper for correspondent step of Nova verification:

```
python src/verifier/step1/step1-data-contract-gen.py compressed-snark.json > src/verifier/step1/Step1Data.sol
python src/verifier/step2/step2-data-contract-gen.py verifier-key.json compressed-snark.json > src/verifier/step2/Step2Data.sol
python src/verifier/step3/step3-data-contract-gen.py verifier-key.json compressed-snark.json > src/verifier/step3/Step3Data.sol
python src/verifier/step4/sumcheck-data-contract-gen.py verifier-key.json compressed-snark.json > src/verifier/step4/SumcheckData.sol
```

# Integration tests and unit-tests

Unit-tests are located in `test/unit-tests`. These tests are being created while debugging and while deriving the Solidity initial implementation
of particular building block or step of Nova verifier. Currently, they use hardcoded values (over Pasta curves) including values of intermediate variables
obtained while running reference Nova verifier in Rust. Our goal is eventual having the tests (test vectors) that will use input only from committed JSONs,
without any relations on intermediate variables. Another direction for improving the unit-testing system is synthesizing the tests for verifier parameterized by particular curves (Pasta, Grumpkin, etc.). The [switch-json](https://github.com/lurk-lab/solidity-verifier/tree/switch-json) branch can provide some more concrete
details on this.

Integration tests are located in `test/integration-tests`. These tests rely on the infrastructure (namely running Ethereum node and RPC client that uploads proving data from JSONs to the global state). We use `anvil` as an Ethereum node and `cast` as RPC client from [Foundry](https://github.com/foundry-rs/foundry/tree/master) development framework. Since Nova's public parameters are quite big, we cannot use only internal VM's memory for keeping the entire verifier key, so for integration testing purposes, before executing particular verification, we perform public parameters loading into the blockchain. For example, for Spark multi-evaluation we can
perform verification using following algorithm:

1) (Terminal A) Run `anvil` node with maximum gas limit and deployed contract size (global state will be dumped into `state.json` file):
```
anvil --order fifo --gas-limit 18446744073709551615 --code-size-limit 18446744073709551615 --state state.json
```

2) (Terminal B) Deploy the Spark contract (located in `src/verifier/step4/spark/SparkMultiEvaluationContract.sol`) to running `anvil` instance:
```
forge script script/Spark.s.sol:SparkVerificationDeployer --fork-url http://127.0.0.1:8545 --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 --broadcast
```

3) (Terminal B) Load the data from the precommitted `verifier-key.json` into the blockchain:
```
python test/integration-tests/integration-tests.py verifier-key.json
```

Note, that private key and deployed contract address are hardcoded inside `integration-tests.py`.

4) (Terminal A) Stop `anvil` node and alter the state using `test/integration-tests/state-modifier.py` (the last argument is the address of deployed contract):
```
Ctrl + C
python test/integration-tests/state-modifier.py state.json 0xe7f1725e7734ce288f8367e1bb143e90bb3f0512
```

This step is required currently, since there is a [confirmed](https://github.com/foundry-rs/foundry/issues/5302) bug in `cast` parser, that is why some values from JSONs are not correctly loaded into the blockchain,
which may cause verification failures. So, `state-modifier.py` just replaces some values in `state.json` that were manually detected by careful analysis to the expected ones. Probably with another JSONs, more such values will be detected.

5) (Terminal A) Run `anvil` node once again, using altered state:
```
anvil --order fifo --gas-limit 18446744073709551615 --code-size-limit 18446744073709551615 --state state.json
```

6) Finally execute primary and secondary verifications:

```
cast call 0xe7f1725e7734ce288f8367e1bb143e90bb3f0512 "verifyPrimary(uint256,uint256,uint256) (bool)" "0x07122b66b54727bf8bebec13052121d753589eb15040a49cb2ee5884810dc0a4" "0x339a352816f770e1bb7437e5cdd54bee76ed9ff13d1d7e9246f33e1a9dbc2656" "0x1ee416e56d10079af3a1785954078120077c6e428269fa00527b0e6a61d3d320" --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
cast call 0xe7f1725e7734ce288f8367e1bb143e90bb3f0512 "verifySecondary(uint256,uint256,uint256) (bool)" "0x267c7eb46d40984b873837e3eb10319b67245557e8f49efceaed4836f1cc05ee" "0x08250c7a9ba4b363fde20f4f77a5d5634401c952e71556af1d17682322153b43" "0x0a01229ad7bbad1e74f05f55c482b1e9ecf2a8b81ed95a4cecc9d78c8f925224" --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
```

You should see `true` in both outputs.
