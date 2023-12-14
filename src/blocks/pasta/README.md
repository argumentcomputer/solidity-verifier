# Ethereum Elliptic Curve Libraries: Pallas and Vesta
## Overview
This folder contains two Solidity libraries, `Pallas.sol` and `Vesta.sol`, designed for elliptic curve operations on the
Ethereum blockchain. These libraries facilitate cryptographic functions and computations on the Pallas and Vesta curves,
respectively, which are crucial in advanced blockchain and cryptographic applications.

These two curves are also known as [Pasta elliptic curve constructions](https://electriccoin.co/blog/the-pasta-curves-for-halo-2-and-beyond/).

## `Pallas.sol`
### `Pallas.sol` provides functionalities for elliptic curve operations on the Pallas curve. This curve is known for its 
cryptographic applications, particularly in zero-knowledge proofs and other privacy-oriented protocols.

Key Features
- Curve Point Operations: Includes essential functions for point addition, doubling, and negation on the Pallas curve.
- Scalar Multiplication: Facilitates scalar multiplication, which is fundamental in cryptographic schemes like digital 
signatures and key generation.
- Conversion Utilities: Functions to convert points between different coordinate systems 
(affine and projective coordinates) for efficiency.
- Validation and Decompression: Methods to validate curve points and decompress points from a compressed format.

## `Vesta.sol`
`Vesta.sol` is a companion library for elliptic curve operations on the Vesta curve. It parallels `Pallas.sol` in 
functionality but is tailored for the Vesta curve.

### Key Features
- Elliptic Curve Arithmetic: Provides point addition, doubling, and negation specific to Vesta.
- Scalar Operations: Includes scalar multiplication and multi-scalar multiplication, essential for various cryptographic 
algorithms.
- Point Conversion and Validation: Similar to `Pallas.sol`, it offers point conversion and validation functions, ensuring
points lie on the Vesta curve.
- Efficient Implementations: Focus on gas-efficient implementations suitable for Ethereum smart contracts.