// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.16;

import "src/pasta/Vesta.sol";
import "src/pasta/Pallas.sol";

library EqPolinomialLib {
    function evaluate(
        uint256[] memory r,
        uint256[] memory rx,
        uint256 modulus,
        function (uint256) returns (uint256) negateBase
    ) internal returns (uint256) {
        require(r.length == rx.length, "[EqPolinomialLib.evaluatePallas] wrong input data length");

        uint256 resultIter = 0;
        uint256 rx_inner = 0;
        uint256 r_inner = 0;
        uint256 tmp1 = 0;
        uint256 tmp2 = 0;
        uint256 tmp3 = 0;
        uint256 tmp4 = 0;
        uint256 minus_rx = 0;
        uint256 minus_r = 0;

        uint256 result = 1;
        for (uint256 i = 0; i < rx.length; i++) {
            rx_inner = rx[i];
            r_inner = r[i];
            minus_rx = negateBase(rx_inner);
            minus_r = negateBase(r_inner);
            assembly {
                // rx[i] * r[i]
                tmp1 := mulmod(rx_inner, r_inner, modulus)
                // 1 - rx[i]
                tmp2 := addmod(1, minus_rx, modulus)
                // 1 - r[i]
                tmp3 := addmod(1, minus_r, modulus)

                // tmp1 + tmp2 * tmp3
                tmp4 := addmod(tmp1, mulmod(tmp2, tmp3, modulus), modulus)

                // accumulate result
                resultIter := mulmod(tmp4, result, modulus)

                result := resultIter
            }
        }

        return result;
    }

    function evalsVesta(uint256[] memory r) public pure returns (uint256[] memory) {
        uint256[] memory evalsResult = new uint256[](2 ** r.length);
        uint256 size = 1;
        evalsResult[0] = 1;

        uint256 modulusVesta = Vesta.P_MOD;

        uint256 r_i = 0;
        uint256 x = 0;
        uint256 y = 0;
        uint256 minus_y = 0;
        for (uint256 i = 0; i < r.length; i++) {
            r_i = r[r.length - i - 1];
            for (uint256 j = 0; j < size; j++) {
                x = evalsResult[j];
                y = evalsResult[j + size];
                assembly {
                    y := mulmod(x, r_i, modulusVesta) // Vesta
                }

                minus_y = Vesta.negateBase(y); // Vesta

                assembly {
                    x := addmod(x, minus_y, modulusVesta) // Vesta
                }

                evalsResult[j] = x;
                evalsResult[j + size] = y;
            }
            size *= 2;
        }
        return evalsResult;
    }

    function evalsPallas(uint256[] memory r) public pure returns (uint256[] memory) {
        uint256[] memory evalsResult = new uint256[](2 ** r.length);
        uint256 size = 1;
        evalsResult[0] = 1;

        uint256 modulusPallas = Pallas.P_MOD;

        uint256 r_i = 0;
        uint256 x = 0;
        uint256 y = 0;
        uint256 minus_y = 0;
        for (uint256 i = 0; i < r.length; i++) {
            r_i = r[r.length - i - 1];
            for (uint256 j = 0; j < size; j++) {
                x = evalsResult[j];
                y = evalsResult[j + size];
                assembly {
                    y := mulmod(x, r_i, modulusPallas) // Pallas
                }

                minus_y = Pallas.negateBase(y); // Pallas

                assembly {
                    x := addmod(x, minus_y, modulusPallas) // Pallas
                }

                evalsResult[j] = x;
                evalsResult[j + size] = y;
            }
            size *= 2;
        }
        return evalsResult;
    }
}
