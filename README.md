# solidity-verifier

This repository contains Solidity implementation of Nova-based proving system

The idea is actually to gather required cryptographic building blocks (Pasta / Grumpkin curve operations, Poseidon, KeccakTranscript, Sumcheck protocol, etc.) in `main` branch, 
evaluate them and check that they work as expected via test vectors provided by "trusted" reference Rust implementation ([Arecibo](https://github.com/lurk-lab/arecibo)).
Since reference proving system is under active development, the original end-to-end verification flow is a subject of changes, that is why, full e2e contracts are located in various branches,
depending on the Nova cryptographic feature. See [pasta](https://github.com/lurk-lab/solidity-verifier/tree/pasta), [grumpkin](https://github.com/lurk-lab/solidity-verifier/tree/grumpkin), [zeromorph](https://github.com/lurk-lab/solidity-verifier/tree/zeromorph), [gas-optimizing](https://github.com/lurk-lab/solidity-verifier/tree/gas-optimizing) branches for more details.

# Commands to play with

To cleanup current build artifacts:
```
forge clean
```

To build:
```
forge build
```

To run Solidity unit-tests:
```
forge test --match-path test/* -vv
```

More details about Foundry tooling is [here](https://book.getfoundry.sh/).

# Solidity contracts generation

Poseidon contracts in this repository have been generated with a help of correspondent Python scripts.

To re-generate them (for Pallas and Vesta curves) compatible to Neptune and "sharpened" for usage in Nova:

```
python src/blocks/poseidon/poseidon-contract-gen.py src/blocks/poseidon/neptune-constants-U24-pallas.json PoseidonU24Pallas > src/blocks/poseidon/PoseidonNeptuneU24pallas.sol
python src/blocks/poseidon/poseidon-contract-gen.py src/blocks/poseidon/neptune-constants-U24-vesta.json PoseidonU24Vesta > src/blocks/poseidon/PoseidonNeptuneU24vesta.sol
```
