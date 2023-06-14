// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

library Field {
    function reverse256(uint256 input) public pure returns (uint256 v) {
        v = input;

        // swap bytes
        v = ((v & 0xFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00) >> 8) |
        ((v & 0x00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF) << 8);

        // swap 2-byte long pairs
        v = ((v & 0xFFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000) >> 16) |
        ((v & 0x0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF) << 16);

        // swap 4-byte long pairs
        v = ((v & 0xFFFFFFFF00000000FFFFFFFF00000000FFFFFFFF00000000FFFFFFFF00000000) >> 32) |
        ((v & 0x00000000FFFFFFFF00000000FFFFFFFF00000000FFFFFFFF00000000FFFFFFFF) << 32);

        // swap 8-byte long pairs
        v = ((v & 0xFFFFFFFFFFFFFFFF0000000000000000FFFFFFFFFFFFFFFF0000000000000000) >> 64) |
        ((v & 0x0000000000000000FFFFFFFFFFFFFFFF0000000000000000FFFFFFFFFFFFFFFF) << 64);

        // swap 16-byte long pairs
        v = (v >> 128) | (v << 128);
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
