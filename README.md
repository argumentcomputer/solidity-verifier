# solidity-verifier

This repository contains Solidity implementation of Nova-based proving system

The idea is actually to gather required cryptographic building blocks (Pasta / Grumpkin curve operations, Poseidon, KeccakTranscript, Sumcheck protocol, etc.) in `main` branch, 
evaluate them and check that they work as expected via test vectors provided by "trusted" reference Rust implementation ([Arecibo](https://github.com/lurk-lab/arecibo)).
Since reference proving system is under active development, the original end-to-end verification flow is a subject of changes, that is why, full e2e contracts are located in various branches,
depending on the Nova cryptographic feature. See [pasta](https://github.com/lurk-lab/solidity-verifier/tree/pasta) [grumpkin](https://github.com/lurk-lab/solidity-verifier/tree/grumpkin), [zeromorph](https://github.com/lurk-lab/solidity-verifier/tree/zeromorph), [gas-optimizing](https://github.com/lurk-lab/solidity-verifier/tree/gas-optimizing) branches for more details.

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

# Repository structure

```
├── lib
|   └── forge-std       # Forge standard library for testing utilities.
├── src
|   ├── blocks          # Cryptographic building blocks shared between all our features.
|   └── Utilities.sol   # Mostly Mathematical building blocks such as Field operations or Polynomial-related methods. 
└── test                # Unit test for our contracts.
```

# Features

This section aims to describe the main features currently being developed and outline their specificities. It has to be
noted that each of these branches have dedicated e2e testing, documented in their respective README.

## Pasta

[Feature branch: `pasta`](https://github.com/lurk-lab/solidity-verifier/tree/pasta)

Orignal feature branch, implementing the [Nova](https://github.com/microsoft/Nova) Verifier over
[Pallas/Vesta (Pasta) curve cycles](https://electriccoin.co/blog/the-pasta-curves-for-halo-2-and-beyond/).

Development is nearly finalized but there are some compatibility checks to be run between the latest version of [Arecibo](https://github.com/lurk-lab/arecibo)
and our solidity verifier.

## Grumpkin

[Feature branch: `grumpkin`](https://github.com/lurk-lab/solidity-verifier/tree/grumpkin)

Feature branch aiming to implement our Nova Verifier over BN254/Grumpkin curve cycle instead of Pasta, to keep up with the
development on the Rust implementation side.

Development is nearly finalized but there are some compatibility checks to be run between the latest version of [Arecibo](https://github.com/lurk-lab/arecibo)
and our solidity verifier.

## Zeromorph

[Feature branch: `zeromorph`](https://github.com/lurk-lab/solidity-verifier/tree/zeromorph)

The goal is to take into account the [Zeromorph](https://eprint.iacr.org/2023/917.pdf) feature done in Arecibo. Zeromorph
impacts how we generate prover randomness at proving time, and allows us to have a new (and faster) Polynomial Commitment
Scheme (PCS).

The branch needs to integrate the [lastest updates pushed over Arecibo](https://github.com/lurk-lab/arecibo/pull/145) and will
most likely need some development in Assembly to properly work.

## Gas Optimization

[Feature branch: `gas-optimizing`](https://github.com/lurk-lab/solidity-verifier/tree/gas-optimizing)

This last branch contains development in [Assembly](https://docs.soliditylang.org/en/latest/assembly.html), leveraging 
[Yul](https://docs.soliditylang.org/en/latest/yul.html). This development will allow optimization on gas consumption, readying
our contracts for production. In the end, it should implement a Grumpkin contract in Yul.

The verification steps 1 and 2 have been implemented but the rest of the steps need to be developed.

# Solidity contracts generation

Poseidon contracts in this repository have been generated with a help of correspondent Python scripts.

To re-generate them (for Pallas and Vesta curves) compatible to Neptune and "sharpened" for usage in Nova:

```
python src/blocks/poseidon/poseidon-contract-gen.py src/blocks/poseidon/neptune-constants-U24-pallas.json PoseidonU24Pallas > src/blocks/poseidon/PoseidonNeptuneU24pallas.sol
python src/blocks/poseidon/poseidon-contract-gen.py src/blocks/poseidon/neptune-constants-U24-vesta.json PoseidonU24Vesta > src/blocks/poseidon/PoseidonNeptuneU24vesta.sol
```
