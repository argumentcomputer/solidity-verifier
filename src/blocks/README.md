## Overview
This folder contains a collection of Solidity libraries and contracts essential for implementing advanced cryptographic 
protocols and computations, primarily focused on elliptic curve operations, polynomial evaluations, and cryptographic 
pairings. Below is an overview of each file and its role in the project.

## File Descriptions
- `EqPolynomial.sol`: This library provides functionalities for evaluating equality polynomials over a given field. It 
is crucial for cryptographic protocols that require polynomial computations.
- `IdentityPolynomial.sol`: Implements routines for evaluating identity polynomials. This is a core component in systems
that need to verify identities or perform consistency checks through polynomial operations.
- `KeccakTranscript.sol`: Offers a library for managing and manipulating Keccak transcript hashes. It plays a vital role
in cryptographic protocols where secure, verifiable hashing is required.
- `PolyEvalInstance.sol`: Contains functions for creating and managing polynomial evaluation instances. It's used in 
algorithms that require the evaluation of polynomials at specific points or sets of points.
- `SparsePolynomial.sol`: Provides tools for working with sparse polynomials. These polynomials are used in various 
cryptographic schemes due to their efficiency in representing and computing certain types of data.
- `Sumcheck.sol`: This file includes logic for verifying sumcheck protocols, a fundamental part of interactive proofs in
cryptography.
- `ZeromorphEngine.sol`: Focuses on implementing the [Zeromorph](https://eprint.iacr.org/2023/917.pdf) cryptographic protocol, including operations like pairings
and elliptic curve computations, particularly on the Bn256 curve.