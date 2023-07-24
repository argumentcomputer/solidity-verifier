// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.16;

import "@std/Test.sol";
import "src/blocks/KeccakTranscript.sol";
import "src/blocks/PolyEvalInstance.sol";
import "src/verifier/Step1.sol";
import "src/verifier/Step2.sol";
import "src/verifier/Step3.sol";
import "src/verifier/Step4.sol";
import "src/NovaVerifierAbstractions.sol";

contract NovaVerifierContract {
    Abstractions.VerifierKey public vk;
    Abstractions.CompressedSnark public proof;

    KeccakTranscriptLib.KeccakTranscript private transcriptPrimary;
    KeccakTranscriptLib.KeccakTranscript private transcriptSecondary;

    bool private printLogs;

    function initialize()
        private
        pure
        returns (KeccakTranscriptLib.KeccakTranscript memory, KeccakTranscriptLib.KeccakTranscript memory)
    {
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

        KeccakTranscriptLib.KeccakTranscript memory transcriptPrimaryInstance =
            KeccakTranscriptLib.instantiate(init_input);
        KeccakTranscriptLib.KeccakTranscript memory transcriptSecondaryInstance =
            KeccakTranscriptLib.instantiate(init_input);
        return (transcriptPrimaryInstance, transcriptSecondaryInstance);
    }

    // cast send 0x0ed64d01d0b4b655e410ef1441dd677b695639e7 "pushToProof(((uint256,uint256[]),(uint256,uint256,uint256[],uint256),(uint256,uint256,uint256[],uint256),uint256[],uint256[],uint256,(uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256[],uint256[],((uint256[])[]),uint256[],uint256[],uint256[],uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256),(uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256[],uint256[],((uint256[])[]),uint256[],uint256[],uint256[],uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256)))" "((1,[1]),(1,1,[1],1),(1,1,[1],1),[1],[1],1,(1,1,1,1,1,1,1,1,[1],[1],([([1])]),[1],[1],[1],1,1,1,1,1,1,1,1,1),(1,1,1,1,1,1,1,1,[1],[1],([([1])]),[1],[1],[1],1,1,1,1,1,1,1,1,1))" --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
    function pushToProof(Abstractions.CompressedSnark calldata input) public {
        proof = input;
    }

    // cast send 0x4826533b4897376654bb4d4ad88b7fafd0c98528 "pushToVk((uint256,uint256,uint256,(uint256[],uint256[]),(uint256[],uint256[]),((uint256),uint256),(uint256,uint256,(uint256),uint256)))" "(1,1,1,([1],[1]),([1],[1]),((1),1),(1,1,(1),1))" --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
    function pushToVk(Abstractions.VerifierKey calldata input) public {
        vk = input;
    }

    // cast call 0x998abeb3e57409262ae5b751f60747921b33613e "verify(uint32,uint256[],uint256[],bool)(bool)" "3" "[1]" "[0]" "false" --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
    function verify(uint32 numSteps, uint256[] calldata z0_primary, uint256[] calldata z0_secondary, bool enableLogs)
        public
        returns (bool)
    {
        (transcriptPrimary, transcriptSecondary) = initialize();
        printLogs = enableLogs;

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
        // from: https://github.com/lurk-lab/Nova/blob/solidity-verifier-pp-spartan/src/spartan/ppsnark.rs#L1565

        // Sumcheck protocol verification (secondary) part
        if (!verifyStep3Secondary()) {
            console.log("[Step3 Secondary] false");
            return false;
        }

        // Sumcheck protocol verification (primary)
        if (!verifyStep3Primary()) {
            console.log("[Step3 Secondary] false");
            return false;
        }

        // check the required multiset relationship
        if (!Step4Lib.verify(proof)) {
            console.log("[Step4] false");
            return false;
        }

        return true;
    }

    function verifyStep3Secondary() private returns (bool) {
        uint256[] memory tau;
        uint256 c_inner;
        PolyEvalInstanceLib.PolyEvalInstance memory u_step3;
        uint256[] memory rand_eq;
        uint256[] memory coeffs;
        uint256 f_U_secondary_u;
        (tau, c_inner, u_step3, rand_eq, coeffs, f_U_secondary_u) = verifyStep3PrecomputeSecondary();

        return verifyStep3InnerSecondary(f_U_secondary_u, c_inner, u_step3, coeffs, tau, rand_eq);
    }

    function verifyStep3InnerSecondary(
        uint256 f_U_secondary_u,
        uint256 c_inner,
        PolyEvalInstanceLib.PolyEvalInstance memory u_step3,
        uint256[] memory coeffs,
        uint256[] memory tau,
        uint256[] memory rand_eq
    ) private returns (bool) {
        uint256 claim_sat_final;
        uint256[] memory r_sat;
        (claim_sat_final, r_sat, transcriptSecondary) = Step3Lib.compute_claim_sat_final_r_sat_secondary(
            proof, vk, transcriptSecondary, u_step3.e, coeffs, Pallas.P_MOD
        );

        uint256 taus_bound_r_sat = EqPolinomialLib.evaluate(tau, r_sat, Pallas.P_MOD, Pallas.negateBase);
        uint256 rand_eq_bound_r_sat = EqPolinomialLib.evaluate(rand_eq, r_sat, Pallas.P_MOD, Pallas.negateBase);

        if (printLogs) {
            console.log("------------------[verifyStep3InnerSecondary]------------------");
            console.log("claim_sat_final");
            console.logBytes32(bytes32(claim_sat_final));
            console.log("r_sat");
            for (uint256 index = 0; index < r_sat.length; index++) {
                console.logBytes32(bytes32(r_sat[index]));
            }
            console.log("taus_bound_r_sat");
            console.logBytes32(bytes32(taus_bound_r_sat));
            console.log("rand_eq_bound_r_sat");
            console.logBytes32(bytes32(rand_eq_bound_r_sat));
        }

        uint256 claim_mem_final = Step3Lib.compute_claim_mem_final(
            proof.f_W_snark_secondary, coeffs, rand_eq_bound_r_sat, Pallas.P_MOD, Pallas.negateBase
        );

        uint256 claim_outer_final = Step3Lib.compute_claim_outer_final(
            proof.f_W_snark_secondary, f_U_secondary_u, coeffs, taus_bound_r_sat, Pallas.P_MOD, Pallas.negateBase
        );

        uint256 claim_inner_final =
            Step3Lib.compute_claim_inner_final(proof.f_W_snark_secondary, c_inner, coeffs, Pallas.P_MOD);

        return Step3Lib.final_verification(
            claim_mem_final, claim_outer_final, claim_inner_final, claim_sat_final, Pallas.P_MOD
        );
    }

    function verifyStep3PrecomputeSecondary()
        private
        returns (
            uint256[] memory tau,
            uint256 c,
            PolyEvalInstanceLib.PolyEvalInstance memory u_step3,
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

        (transcriptSecondary, tau) = Step3Lib.compute_tau_secondary(
            proof,
            vk.vk_secondary,
            transcriptSecondary,
            f_U_secondary_comm_W,
            f_U_secondary_comm_E,
            f_U_secondary_X,
            f_U_secondary_u,
            printLogs
        );

        (transcriptSecondary, c) = Step3Lib.compute_c_secondary(proof, transcriptSecondary);

        u_step3 = Step3Lib.compute_u_secondary(proof, tau, c);

        // We need this in order to update state of the transcript
        (transcriptSecondary, /* gamma1*/ ) = Step3Lib.compute_gamma_1_secondary(transcriptSecondary);
        (transcriptSecondary, /* gamma2*/ ) = Step3Lib.compute_gamma_2_secondary(transcriptSecondary);
        ////////////////////////////////////////////////////////////////

        (transcriptSecondary, rand_eq) = Step3Lib.compute_rand_eq_secondary(proof, vk, transcriptSecondary);

        (transcriptSecondary, coeffs) = Step3Lib.compute_coeffs_secondary(transcriptSecondary);

        U_u = f_U_secondary_u;

        if (printLogs) {
            uint256 index = 0;
            console.log("------------------[verifyStep3PrecomputeSecondary]------------------");
            console.log("f_U_secondary_comm_W");
            console.logBytes32(bytes32(f_U_secondary_comm_W.x));
            console.logBytes32(bytes32(f_U_secondary_comm_W.y));
            console.log("f_U_secondary_comm_E");
            console.logBytes32(bytes32(f_U_secondary_comm_E.x));
            console.logBytes32(bytes32(f_U_secondary_comm_E.y));
            console.log("f_U_secondary_X");
            for (index = 0; index < f_U_secondary_X.length; index++) {
                console.logBytes32(bytes32(f_U_secondary_X[index]));
            }
            console.log("f_U_secondary_u");
            console.logBytes32(bytes32(f_U_secondary_u));
            console.log("tau");
            for (index = 0; index < tau.length; index++) {
                console.logBytes32(bytes32(tau[index]));
            }
            console.log("c");
            console.logBytes32(bytes32(c));
            console.log("u_step3 c");
            console.logBytes32(bytes32(u_step3.c_x));
            console.logBytes32(bytes32(u_step3.c_y));
            console.log("u_step3 x");
            for (index = 0; index < u_step3.x.length; index++) {
                console.logBytes32(bytes32(u_step3.x[index]));
            }
            console.log("u_step3 e");
            console.logBytes32(bytes32(u_step3.e));
            console.log("rand_eq");
            for (index = 0; index < rand_eq.length; index++) {
                console.logBytes32(bytes32(rand_eq[index]));
            }
            console.log("coeffs");
            for (index = 0; index < coeffs.length; index++) {
                console.logBytes32(bytes32(coeffs[index]));
            }
        }
    }

    function verifyStep3Primary() private returns (bool) {
        uint256[] memory tau;
        uint256 c_inner;
        PolyEvalInstanceLib.PolyEvalInstance memory u_step3;
        uint256[] memory rand_eq;
        uint256[] memory coeffs;
        uint256 r_U_primary_u;
        (tau, c_inner, u_step3, rand_eq, coeffs, r_U_primary_u) = verifyStep3PrecomputePrimary();

        return verifyStep3InnerPrimary(r_U_primary_u, c_inner, u_step3, coeffs, tau, rand_eq);
    }

    function verifyStep3InnerPrimary(
        uint256 r_U_primary_u,
        uint256 c_inner,
        PolyEvalInstanceLib.PolyEvalInstance memory u_step3,
        uint256[] memory coeffs,
        uint256[] memory tau,
        uint256[] memory rand_eq
    ) private returns (bool) {
        uint256 claim_sat_final;
        uint256[] memory r_sat;
        (claim_sat_final, r_sat, transcriptPrimary) = Step3Lib.compute_claim_sat_final_r_sat_primary(
            proof.r_W_snark_primary, vk.vk_primary, transcriptPrimary, u_step3.e, coeffs, Vesta.P_MOD, printLogs
        );

        uint256 taus_bound_r_sat = EqPolinomialLib.evaluate(tau, r_sat, Vesta.P_MOD, Vesta.negateBase);
        uint256 rand_eq_bound_r_sat = EqPolinomialLib.evaluate(rand_eq, r_sat, Vesta.P_MOD, Vesta.negateBase);

        if (printLogs) {
            console.log("------------------[verifyStep3InnerPrimary]------------------");
            console.log("claim_sat_final");
            console.logBytes32(bytes32(claim_sat_final));
            console.log("r_sat");
            for (uint256 index = 0; index < r_sat.length; index++) {
                console.logBytes32(bytes32(r_sat[index]));
            }
            console.log("taus_bound_r_sat");
            console.logBytes32(bytes32(taus_bound_r_sat));
            console.log("rand_eq_bound_r_sat");
            console.logBytes32(bytes32(rand_eq_bound_r_sat));
        }

        uint256 claim_inner_final =
            Step3Lib.compute_claim_inner_final(proof.r_W_snark_primary, c_inner, coeffs, Vesta.P_MOD);

        uint256 claim_mem_final = Step3Lib.compute_claim_mem_final(
            proof.r_W_snark_primary, coeffs, rand_eq_bound_r_sat, Vesta.P_MOD, Vesta.negateBase
        );

        uint256 claim_outer_final = Step3Lib.compute_claim_outer_final(
            proof.r_W_snark_primary, r_U_primary_u, coeffs, taus_bound_r_sat, Vesta.P_MOD, Vesta.negateBase
        );

        return Step3Lib.final_verification(
            claim_mem_final, claim_outer_final, claim_inner_final, claim_sat_final, Vesta.P_MOD
        );
    }

    function verifyStep3PrecomputePrimary()
        private
        returns (
            uint256[] memory tau,
            uint256 c,
            PolyEvalInstanceLib.PolyEvalInstance memory u_step3,
            uint256[] memory rand_eq,
            uint256[] memory coeffs,
            uint256 U_u
        )
    {
        (transcriptPrimary, tau) = Step3Lib.compute_tau_primary(proof, vk.vk_primary, transcriptPrimary, printLogs);

        (transcriptPrimary, c) = Step3Lib.compute_c_primary(proof.r_W_snark_primary, transcriptPrimary);

        u_step3 = Step3Lib.compute_u_primary(proof.r_W_snark_primary, tau, c);

        // We need this in order to update state of the transcript
        (transcriptPrimary, /* gamma1 */ ) = Step3Lib.compute_gamma_1_primary(transcriptPrimary);
        (transcriptPrimary, /* gamma2 */ ) = Step3Lib.compute_gamma_2_primary(transcriptPrimary);
        ////////////////////////////////////////////////////////////////

        (transcriptPrimary, rand_eq) =
            Step3Lib.compute_rand_eq_primary(proof.r_W_snark_primary, vk.vk_primary, transcriptPrimary);

        (transcriptPrimary, coeffs) = Step3Lib.compute_coeffs_primary(transcriptPrimary);

        U_u = proof.r_U_primary.u;

        if (printLogs) {
            uint256 index = 0;
            console.log("------------------[verifyStep3PrecomputePrimary]------------------");
            console.log("proof.r_U_primary.comm_W");
            console.logBytes32(bytes32(proof.r_U_primary.comm_W));
            console.log("proof.r_U_primary.comm_E");
            console.logBytes32(bytes32(proof.r_U_primary.comm_E));
            console.log("proof.r_U_primary.X");
            for (index = 0; index < proof.r_U_primary.X.length; index++) {
                console.logBytes32(bytes32(proof.r_U_primary.X[index]));
            }
            console.log("proof.r_U_primary.u");
            console.logBytes32(bytes32(proof.r_U_primary.u));
            console.log("tau");
            for (index = 0; index < tau.length; index++) {
                console.logBytes32(bytes32(tau[index]));
            }
            console.log("c");
            console.logBytes32(bytes32(c));
            console.log("u_step3 c");
            console.logBytes32(bytes32(u_step3.c_x));
            console.logBytes32(bytes32(u_step3.c_y));
            console.log("u_step3 x");
            for (index = 0; index < u_step3.x.length; index++) {
                console.logBytes32(bytes32(u_step3.x[index]));
            }
            console.log("u_step3 e");
            console.logBytes32(bytes32(u_step3.e));
            console.log("rand_eq");
            for (index = 0; index < rand_eq.length; index++) {
                console.logBytes32(bytes32(rand_eq[index]));
            }

            console.log("coeffs");
            for (index = 0; index < coeffs.length; index++) {
                console.logBytes32(bytes32(coeffs[index]));
            }
        }
    }
}
