pragma solidity ^0.8.0;

import "src/pasta/Vesta.sol";
import "src/pasta/Pallas.sol";

library EqPolinomialLib {
    function evaluateVesta(uint256[] memory r, uint256[] memory rx) public pure returns (uint256){
        require(r.length == rx.length, "[EqPolinomialLib.evaluateVesta] wrong input data length");


        uint256 modulusVesta = Vesta.P_MOD;
        uint256 modulusPallas = Pallas.P_MOD;

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
            minus_rx = Pallas.negate(rx_inner);
            minus_r = Pallas.negate(r_inner);
            assembly {
            // rx[i] * r[i] (Vesta!)
                tmp1 := mulmod(rx_inner, r_inner, modulusVesta)
            // 1 - rx[i] (Pallas!)
                tmp2 := addmod(1, minus_rx, modulusPallas)
            // 1 - r[i] (Pallas!)
                tmp3 := addmod(1, minus_r, modulusPallas)

            // tmp1 + tmp2 * tmp3 (Vesta!)
                tmp4 := addmod(tmp1, mulmod(tmp2, tmp3, modulusVesta), modulusVesta)

            // accumulate result (Vesta!)
                resultIter := mulmod(tmp4, result, modulusVesta)

                result := resultIter
            }
        }

        return result;
    }

    function evaluatePallas(uint256[] memory r, uint256[] memory rx) public pure returns (uint256){
        require(r.length == rx.length, "[EqPolinomialLib.evaluatePallas] wrong input data length");

        uint256 modulusVesta = Vesta.P_MOD;
        uint256 modulusPallas = Pallas.P_MOD;

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
            minus_rx = Vesta.negate(rx_inner);
            minus_r = Vesta.negate(r_inner);
            assembly {
            // rx[i] * r[i] (Pallas!)
                tmp1 := mulmod(rx_inner, r_inner, modulusPallas)
            // 1 - rx[i] (Vesta!)
                tmp2 := addmod(1, minus_rx, modulusVesta)
            // 1 - r[i] (Vesta!)
                tmp3 := addmod(1, minus_r, modulusVesta)

            // tmp1 + tmp2 * tmp3 (Pallas!)
                tmp4 := addmod(tmp1, mulmod(tmp2, tmp3, modulusPallas), modulusPallas)

            // accumulate result (Pallas!)
                resultIter := mulmod(tmp4, result, modulusPallas)

                result := resultIter
            }
        }

        return result;
    }

    function evals(uint256[] memory r) public pure returns (uint256[] memory) {
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

                minus_y = Pallas.negate(y); // Pallas

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
}