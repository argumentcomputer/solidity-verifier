// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "./Field.sol";

contract NIFS {
    uint256 private MOD;

    struct R1CSWitness {
        uint256[] W;
    }

    struct RelaxedR1CSWitness {
        uint256[] W;
        uint256[] E;
    }

    Field field = new Field(MOD);

    constructor(uint256 _MOD) {
        MOD = _MOD;
    }

    function fold(RelaxedR1CSWitness memory acc, 
                  R1CSWitness memory witness, 
                  uint256[] memory T, uint256 r) 
                  public view returns (RelaxedR1CSWitness memory) {
        uint256 witnessLength = acc.W.length;

        require(witnessLength == witness.W.length, "InvalidWitnessLength");

        uint256[] memory W = new uint256[](witnessLength);
        uint256[] memory E = new uint256[](witnessLength);

        for (uint i = 0; i < witnessLength; i++) {
            W[i] = field.add(acc.W[i], field.mul(r, witness.W[i])); 
        }
        
        for (uint i = 0; i < witnessLength; i++) {
            E[i] = field.add(acc.E[i], field.mul(r, T[i])); 
        }

        return RelaxedR1CSWitness(W, E);

    }

}