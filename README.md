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
```
