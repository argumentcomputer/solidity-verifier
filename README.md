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

To run Anvil node locally (with maximum gas-limit and code-size-limit):

```
anvil --gas-limit 18446744073709551615 --code-size-limit 18446744073709551615
```

To deploy the e2e verification contract to locally running Anvil node (`PRIVATE_KEY` can be obtained from output of running Anvil):

```
forge script script/Deployment.s.sol:NovaVerifierDeployer --fork-url http://127.0.0.1:8545 --private-key <PRIVATE_KEY> --broadcast
```

To load proof and verifier-key into the blockchain (`CONTRACT_ADDRESS` can be obtained from the output of previous step):

```
python loader.py pp-verifier-key.json pp-compressed-snark.json <CONTRACT_ADDRESS>
```

To run the verification logic:

```
cast call <CONTRACT_ADDRESS> "verify(uint32,uint256[],uint256[])(bool)" "3" "[1]" "[0]" --private-key <PRIVATE_KEY>
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
