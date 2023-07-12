// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.0;

import "@std/Test.sol";
import "src/verifier/step1/Step1.sol";
import "src/verifier/step2/Step2.sol";
import "src/verifier/step3/Step3.sol";
import "src/NovaVerifierAbstractions.sol";

contract NovaVerifierContract {
    Abstractions.VerifierKey public vk;
    Abstractions.CompressedSnark public proof;

    uint256 public comm_W_x;
    uint256 public comm_W_y;
    uint256 public comm_E_x;
    uint256 public comm_E_y;
    uint256[] public X;
    uint256 public u;

    function pushToProof(Abstractions.CompressedSnark calldata input) public {
        proof = input;
    }

    function pushToVk(Abstractions.VerifierKey calldata input) public {
        vk = input;
    }

    function pushToNifsOutputExpected(
        uint256 comm_W_x_input,
        uint256 comm_W_y_input,
        uint256 comm_E_x_input,
        uint256 comm_E_y_input,
        uint256[] calldata X_input,
        uint256 u_input
    ) public {
        comm_W_x = comm_W_x_input;
        comm_W_y = comm_W_y_input;
        comm_E_x = comm_E_x_input;
        comm_E_y = comm_E_y_input;
        X = X_input;
        u = u_input;
    }

    function verify(uint32 numSteps, uint256[] calldata z0_primary, uint256[] calldata z0_secondary)
        public
        view
        returns (bool)
    {
        // number of steps cannot be zero
        if (!Step1Lib.verify(proof, numSteps)) {
            console.log("[Step1] false");
            return false;
        }

        // check if the output hashes in R1CS instances point to the right running instances
        if (!Step2Lib.verify(proof, vk, numSteps, z0_primary, z0_secondary)) {
            console.log("[Step2] false");
            return false;
        }

        return true;
    }

    // https://github.com/lurk-lab/Nova/blob/solidity-verifier-pp-spartan/src/spartan/ppsnark.rs#L1565
    function verifyStep3() public returns (bool) {
        Step3Lib.RelaxedR1CSInstance memory f_U_secondary = Step3Lib.compute_f_U_secondary(proof, vk);

        // TODO add rest of Step 3 verification logic

        if (f_U_secondary.comm_W.x != comm_W_x) {
            console.log("f_U_secondary.comm_W.x != comm_W_x");
            return false;
        }

        if (f_U_secondary.comm_W.y != comm_W_y) {
            console.log("f_U_secondary.comm_W.y != comm_W_y");
            return false;
        }

        if (f_U_secondary.comm_E.x != comm_E_x) {
            console.log("f_U_secondary.comm_W.x != comm_W_x");
            return false;
        }

        if (f_U_secondary.comm_E.y != comm_E_y) {
            console.log("f_U_secondary.comm_W.y != comm_W_y");
            return false;
        }

        if (f_U_secondary.X.length != X.length) {
            console.log("f_U_secondary.X.length != X.length");
            return false;
        }

        for (uint256 index = 0; index < f_U_secondary.X.length; index++) {
            if (f_U_secondary.X[index] != X[index]) {
                console.log("f_U_secondary.X != X at position: ", index);
                return false;
            }
        }

        if (f_U_secondary.u != u) {
            console.log("f_U_secondary.u != u");
            return false;
        }

        return true;
    }
}
