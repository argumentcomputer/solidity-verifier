// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.0;

import "@std/Test.sol";
import "src/blocks/KeccakTranscript.sol";
import "src/blocks/PolyEvalInstance.sol";
import "src/verifier/Step1.sol";
import "src/verifier/Step2.sol";
import "src/verifier/Step3.sol";
import "src/NovaVerifierAbstractions.sol";

contract NovaVerifierContract {
    Abstractions.VerifierKey public vk;
    Abstractions.CompressedSnark public proof;

    KeccakTranscriptLib.KeccakTranscript private transcript;

    constructor() {
        uint8[] memory init_input = new uint8[](16); // Rust's b"RelaxedR1CSSNARK"
        init_input[0] = 0x52;
        init_input[1] = 0x65;
        init_input[2] = 0x6c;
        init_input[3] = 0x61;
        init_input[4] = 0x78;
        init_input[5] = 0x65;
        init_input[6] = 0x64;
        init_input[7] = 0x52;
        init_input[8] = 0x31;
        init_input[9] = 0x43;
        init_input[10] = 0x53;
        init_input[11] = 0x53;
        init_input[12] = 0x4e;
        init_input[13] = 0x41;
        init_input[14] = 0x52;
        init_input[15] = 0x4b;

        transcript = KeccakTranscriptLib.instantiate(init_input);
    }

    // cast send 0x0ed64d01d0b4b655e410ef1441dd677b695639e7 "pushToProof(((uint256,uint256[]),(uint256,uint256,uint256[],uint256),(uint256,uint256,uint256[],uint256),uint256[],uint256[],uint256,(uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256[],uint256[],((uint256[])[]),uint256[],uint256[],uint256[],uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256)))" "((1,[1]),(1,1,[1],1),(1,1,[1],1),[1],[1],1,(1,1,1,1,1,1,1,1,[1],[1],([([1])]),[1],[1],[1],1,1,1,1,1,1,1,1,1))" --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
    function pushToProof(Abstractions.CompressedSnark calldata input) public {
        proof = input;
    }

    // cast send 0x7a2088a1bfc9d81c55368ae168c2c02570cb814f "pushToVk((uint256,uint256,uint256,(uint256[],uint256[]),(uint256[],uint256[]),((uint256),uint256)))" "(1,1,1,([1],[1]),([1],[1]),((1),1))" --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
    function pushToVk(Abstractions.VerifierKey calldata input) public {
        vk = input;
    }

    // cast call 0x7a2088a1bfc9d81c55368ae168c2c02570cb814f "verify(uint32,uint256[],uint256[])(bool)" "3" "[1]" "[0]" --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
    function verify(uint32 numSteps, uint256[] calldata z0_primary, uint256[] calldata z0_secondary)
        public
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

        // fold the running instance and last instance to get a folded instance
        // check the satisfiability of the folded instances using SNARKs proving the knowledge of their satisfying witnesses

        // Sumcheck protocol verification (secondary) part from: https://github.com/lurk-lab/Nova/blob/solidity-verifier-pp-spartan/src/spartan/ppsnark.rs#L1565
        if (!verifyStep3Secondary()) {
            console.log("[Step3 Secondary] false");
            return false;
        }

        return true;
    }

    function verifyStep3InnerSecondary(
        uint256 f_U_secondary_u,
        uint256 c_inner,
        PolyEvalInstanceLib.PolyEvalInstanceVesta memory u_step3,
        uint256[] memory coeffs,
        uint256[] memory tau,
        uint256[] memory rand_eq
    ) private returns (bool) {
        uint256 claim_sat_final;
        uint256[] memory r_sat;
        (claim_sat_final, r_sat, transcript) =
            Step3Lib.compute_claim_sat_final_r_sat(proof, vk, transcript, u_step3.e, coeffs);

        uint256 taus_bound_r_sat = EqPolinomialLib.evaluatePallas(tau, r_sat);
        uint256 rand_eq_bound_r_sat = EqPolinomialLib.evaluatePallas(rand_eq, r_sat);

        uint256 claim_mem_final = Step3Lib.compute_claim_mem_final(proof, coeffs, rand_eq_bound_r_sat);

        uint256 claim_outer_final = Step3Lib.compute_claim_outer_final(proof, f_U_secondary_u, coeffs, taus_bound_r_sat);

        uint256 claim_inner_final = Step3Lib.compute_claim_inner_final(proof, c_inner, coeffs);

        return Step3Lib.final_verification(claim_mem_final, claim_outer_final, claim_inner_final, claim_sat_final);
    }

    function verifyStep3PrecomputeSecondary()
        private
        returns (
            uint256[] memory tau,
            uint256 c,
            PolyEvalInstanceLib.PolyEvalInstanceVesta memory u_step3,
            uint256[] memory rand_eq,
            uint256[] memory coeffs,
            uint256 U_u
        )
    {
        // f_U_secondary instance (RelaxedR1CSInstance with uncompressed commitments)
        Vesta.VestaAffinePoint memory f_U_secondary_comm_W;
        Vesta.VestaAffinePoint memory f_U_secondary_comm_E;
        uint256[] memory f_U_secondary_X;
        uint256 f_U_secondary_u;

        (f_U_secondary_comm_W, f_U_secondary_comm_E, f_U_secondary_X, f_U_secondary_u) =
            Step3Lib.compute_f_U_secondary(proof, vk);

        (transcript, tau) = Step3Lib.compute_tau(
            proof, vk, transcript, f_U_secondary_comm_W, f_U_secondary_comm_E, f_U_secondary_X, f_U_secondary_u
        );

        (transcript, c) = Step3Lib.compute_c(proof, transcript);

        u_step3 = Step3Lib.compute_u(proof, tau, c);

        // We need this in order to update state of the transcript
        (transcript, /* gamma1*/ ) = Step3Lib.compute_gamma_1(transcript);
        (transcript, /* gamma2*/ ) = Step3Lib.compute_gamma_2(transcript);
        ////////////////////////////////////////////////////////////////

        (transcript, rand_eq) = Step3Lib.compute_rand_eq(proof, vk, transcript);

        (transcript, coeffs) = Step3Lib.compute_coeffs(transcript);

        U_u = f_U_secondary_u;
    }

    function verifyStep3Secondary() private returns (bool) {
        uint256[] memory tau;
        uint256 c_inner;
        PolyEvalInstanceLib.PolyEvalInstanceVesta memory u_step3;
        uint256[] memory rand_eq;
        uint256[] memory coeffs;
        uint256 f_U_secondary_u;
        (tau, c_inner, u_step3, rand_eq, coeffs, f_U_secondary_u) = verifyStep3PrecomputeSecondary();

        return verifyStep3InnerSecondary(f_U_secondary_u, c_inner, u_step3, coeffs, tau, rand_eq);
    }
}
