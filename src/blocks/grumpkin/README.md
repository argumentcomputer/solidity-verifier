# Ethereum Elliptic Curve Libraries: Grumpkin and BN256

## Overview

This repository contains two Solidity libraries, `Grumpkin.sol` and `BN256.sol`, which provide functionalities for 
elliptic curve operations on the Ethereum blockchain.

By using the pair Bn254/Grumpkin in the context of our Nova Verifier, we can leverage the pre-compiled contract available
for `Bn256` to optimize our verification process on the Ethereum chain.

## `Grumpkin.sol`
`Grumpkin.sol` is a Solidity library for elliptic curve operations on the Grumpkin curve. This library includes functions
for basic elliptic curve arithmetic, point manipulation, and cryptographic operations specific to the Grumpkin curve.

### Key Features
- Curve Parameters: Defines crucial parameters such as `P_MOD` (the prime modulus), `R_MOD` (order of the base point), and `B` (curve coefficient).
- Point Operations: Includes functions for point addition (`add`), point doubling (`double`), and scalar multiplication (`mul_by_3b`).
- Specialized Functions: Functions for negating points (`negate`), base points (`negateBase`), and scalars (`negateScalar`).
- Utility Functions: Features like checking if a point is the identity element (`is_identity`) and converting between different coordinate systems (`to_affine`, `decompress`).

## `BN256.sol`
`BN256.sol` is a Solidity library focused on the BN256 elliptic curve, widely used in cryptographic applications. It *
heavily relies on the pre-compiles already available on the network.

### Key Features
- Curve Constants: Defines constants `P_MOD`, `R_MOD`, and `B` for the BN256 curve.
- Elliptic Curve Arithmetic: Functions for point addition, doubling, and scalar multiplication specific to BN256.
- Curve Point Management: Functions for negating points and scalars, as well as verifying curve points.
- Conversion Utilities: Includes functionality for compressing and decompressing points on the curve.

## Usage
These libraries are intended for use in smart contracts that require advanced elliptic curve operations and cryptographic
functionalities on the Ethereum blockchain. They are particularly useful in applications involving digital signatures,
zero-knowledge proofs, and other advanced cryptographic protocols.