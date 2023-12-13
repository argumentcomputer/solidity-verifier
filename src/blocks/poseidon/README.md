# Poseidon Hash Implementation
## Overview
This folder contains Solidity implementations for cryptographic sponge constructions and the Poseidon hash function, 
specifically optimized for Ethereum smart contracts. The Poseidon hash function is a modern, efficient, and secure hash 
function designed for use in zero-knowledge proofs and other cryptographic applications. The sponge construction is a 
versatile method for building hash functions and pseudo-random number generators.

## Contents
- `PoseidonNeptuneU24Optimized.sol`: This file contains the optimized implementation of the Poseidon hash function with 
specific parameters for a 24-round version.
- `Sponge.sol`: This file implements a cryptographic sponge construction. It defines the core sponge operations like 
absorbing and squeezing data, which are fundamental for various cryptographic protocols, including hashing and encryption.
- `PoseidonNeptuneU24pallas.sol`: This implementation of the Poseidon hash function is tailored for the Pallas curve, a 
specific elliptic curve. It contains parameters and optimizations that make the Poseidon hash function efficient and 
secure when used in the context of the Pallas curve.
- `PoseidonNeptuneU24vesta.sol`: Similar to the Pallas implementation, this file is an adaptation of the Poseidon hash
function for the Vesta curve. The Vesta curve is another type of elliptic curve, and this implementation includes specific
parameters for optimal performance on this curve.

## Generation

`PoseidonNeptuneU24pallas.sol` and `PoseidonNeptuneU24vesta.sol` are automatically generated files. The generation script
can be found in `poseidon-contract-gen.py` and leverages the two configuration files, `neptune-constants-U24-pallas.json`
and `neptune-constants-U24-vesta.json`. 

To run it:
```shell
python poseidon-contract-gen.py neptune-constants-U24-pallas.json PoseidonU24Pallas > PoseidonNeptuneU24pallas.sol
python poseidon-contract-gen.py neptune-constants-U24-vesta.json PoseidonU24Vesta > PoseidonNeptuneU24vesta.sol
```