# solidity-verifier

This repository will eventually contain Solidity implementation of Nova proving system.

The idea is actually to gather required cryptographic building blocks (pasta curves, Poseidon, etc.), evaluate them and check that they work as expected via test vectors provided by "trusted" Rust implementations and finally come up with working Nova verifier that can be deployed to the Filecoin network.

# Prerequisites

You need to have following installed:

- Solidity ([Foundry](https://github.com/foundry-rs/foundry#installation) framework);
- Rust;
- Python.

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

# Poseidon

Nova uses [Neptune](https://github.com/lurk-lab/neptune) as a reference Rust implementation of Poseidon hash function. As soon as Poseidon can have various instantiations depending on initial parameters,
we use a special script for generating actual Poseidon contract based on constants provided by Neptune.

### Constants generation

This application (`src/poseidon/neptune-constants-generator`) generates Poseidon's constants using Neptune (which is a reference Rust implementation of Poseidon used in Nova). The output format is JSON, as soon as
Python (the script that generates actual Poseidon contract) is very JSON friendly.

To generate and output Neptune constants (which can be then feed to contract generator):
```
cargo clean && cargo run --package neptune-constants-generator --release -- --security-level standard --hash-type sponge --out-json-path neptune-constants-U24.json
```

### Contract generation

Once constants are generated, let's feed them to the contract generator:

```
python src/poseidon/contract_codegen.py neptune-constants-U24.json > src/poseidon/PoseidonNeptuneU24.sol
```
