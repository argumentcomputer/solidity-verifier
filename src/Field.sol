// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

library Field {
    uint256 constant ZERO = 0;
    uint256 constant ONE = 1;

    /// @dev Compute f^-1 for f \in Fr scalar field
    /// @notice credit: Aztec, Spilsbury Holdings Ltd
    function invert(uint256 _x, uint256 _mod) public view returns (uint256 output) {
        bool success;
        assembly {
            let mPtr := mload(0x40)
            mstore(mPtr, 0x20)
            mstore(add(mPtr, 0x20), 0x20)
            mstore(add(mPtr, 0x40), 0x20)
            mstore(add(mPtr, 0x60), _x)
            mstore(add(mPtr, 0x80), sub(_mod, 2))
            mstore(add(mPtr, 0xa0), _mod)
            if iszero(staticcall(gas(), 0x05, mPtr, 0xc0, 0x00, 0x20)) {
                revert(0, 0)
            }
            output := mload(0x00)
        }
        require(success, "Pallas: pow precompile failed!");
    }

    function fieldpow(uint256 _base, uint256 _exp, uint256 _mod) public view returns (uint256 result) {
        assembly {
            // Free memory pointer
            let pointer := mload(0x40)
            // Define length of base, exponent and modulus. 0x20 == 32 bytes
            mstore(pointer, 0x20)
            mstore(add(pointer, 0x20), 0x20)
            mstore(add(pointer, 0x40), 0x20)
            // Define variables base, exponent and modulus
            mstore(add(pointer, 0x60), _base)
            mstore(add(pointer, 0x80), _exp)
            mstore(add(pointer, 0xa0), _mod)
            // Store the result
            let value := mload(0xc0)
            // Call the precompiled contract 0x05 = bigModExp
            if iszero(staticcall(not(0), 0x05, pointer, 0xc0, value, 0x20)) {
                revert(0, 0)
            }
            result := mload(value)
        }
    }

    function sqrt(uint256 _x, uint256 _mod) public view returns (uint256) {
        assembly {
            function pow_mod(base, exponent, modulus) -> answer 
            {
                let pointer := mload(0x40)
                mstore(pointer, 0x20)
                mstore(add(pointer, 0x20), 0x20)
                mstore(add(pointer, 0x40), 0x20)
                mstore(add(pointer, 0x60), base)
                mstore(add(pointer, 0x80), exponent)
                mstore(add(pointer, 0xa0), modulus)

                let result_ptr := mload(0x40)
                if iszero(staticcall(not(0), 0x05, pointer, 0xc0, result_ptr, 0x20)) {
                    revert(0, 0)
                }
                answer := mload(result_ptr)
            }

            function is_square(base, modulus) -> isSquare
            {
                let exponent := div(sub(modulus, 1),2)
                let exp_result := pow_mod(base, exponent, modulus)
                isSquare := iszero(sub(exp_result, 1))
            }

            function require(condition) {
                if iszero(condition) { revert(0, 0) }
            }

            require(is_square(_x, _mod))

            if iszero(sub(mod(_mod, 4),3)) {
                let exponent := div(add(_mod, 1), 4)
                let answer_ptr := mload(0x40)
                mstore(answer_ptr, pow_mod(_x, exponent,_mod))
                return(answer_ptr, 0x20)
            }

            let s := sub(_mod, 1)
            let e := 0
            for { } iszero(mod(s, 2)) { } {
                s := div(s, 2)
                e := add(e, 1)
            }

            let n := 2
            for { } is_square(n, _mod) {} {
                n := add(n, 1)
            }

            let x := pow_mod(_x, div(add(s, 1), 2), _mod)
            let b := pow_mod(_x, s, _mod)
            let g := pow_mod(n, s, _mod)
            let r := e

            for { } 1 { } {
                let t := b
                let m := 0
                for { } lt(m, r) { m := add(m, 1) } {
                    if eq(t, 1) {
                        break
                    }
                    t := mulmod(t, t, _mod)
                }

                if iszero(m) {
                    let return_ptr := mload(0x40)
                    mstore(return_ptr, x)
                    return(return_ptr, 0x20)
                }

                let gs := pow_mod(g, exp(2, sub(r, add(m, 1))), _mod)
                g := mulmod(gs, gs, _mod)
                x := mulmod(x, gs, _mod)
                b := mulmod(b, g, _mod)
                r := m
            }
        }
        revert();
    }
}
