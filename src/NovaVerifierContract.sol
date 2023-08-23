// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.16;

import "@std/Test.sol";
import "src/blocks/KeccakTranscript.sol";
import "src/blocks/PolyEvalInstance.sol";
import "src/verifier/Step1.sol";
import "src/verifier/Step2.sol";
import "src/verifier/Step3.sol";
import "src/NovaVerifierAbstractions.sol";

contract NovaVerifierContract {
    struct IntermediateData {
        Step3IntermediateData step3;
    }

    struct Step3IntermediateData {
        uint256[] tau;
        uint256 gamma1;
        uint256 gamma2;
        uint256[] r_sat;
        uint256[] U_X;
        uint256 U_comm_W_x;
        uint256 U_comm_W_y;
        uint256 U_comm_E_x;
        uint256 U_comm_E_y;
        uint256 U_u;
        PolyEvalInstanceLib.PolyEvalInstance u_vec_item_0;
    }

    struct Step3PrecomputeOutput {
        uint256[] tau;
        PolyEvalInstanceLib.PolyEvalInstance u_step3;
        uint256 c;
        uint256[] rand_eq;
        uint256[] coeffs;
        uint256 U_u;
        uint256[] U_X;
        uint256 U_comm_W_x;
        uint256 U_comm_W_y;
        uint256 U_comm_E_x;
        uint256 U_comm_E_y;
        uint256 gamma1;
        uint256 gamma2;
    }

    Abstractions.VerifierKey public vk;
    Abstractions.CompressedSnark public proof;

    bool private printLogs;

    KeccakTranscriptLib.KeccakTranscript private transcriptPrimary;
    KeccakTranscriptLib.KeccakTranscript private transcriptSecondary;

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

    function pushToProof(Abstractions.CompressedSnark calldata input) public {
        proof = input;
    }

    function pushToVk(Abstractions.VerifierKey calldata input) public {
        vk = input;
    }

    function verify(uint32 numSteps, uint256[] calldata z0_primary, uint256[] calldata z0_secondary, bool enableLogs)
        public
        returns (bool)
    {
        printLogs = enableLogs;

        (transcriptPrimary, transcriptSecondary) = initialize();

        IntermediateData memory primaryData;
        IntermediateData memory secondaryData;

        bool success;

        // Step 1:
        // - checks that number of steps cannot be zero (https://github.com/lurk-lab/Nova/blob/solidity-verifier-pp-spartan/src/lib.rs#L680)
        // - checks if the (relaxed) R1CS instances have two public outputs (https://github.com/lurk-lab/Nova/blob/solidity-verifier-pp-spartan/src/lib.rs#L688)
        if (!Step1Lib.verify(proof, numSteps)) {
            console.log("[Step1] false");
            return false;
        }

        // Step 2:
        // - checks if the output hashes in R1CS instances point to the right running instances (https://github.com/lurk-lab/Nova/blob/solidity-verifier-pp-spartan/src/lib.rs#L730)
        if (!Step2Lib.verify(proof, vk, numSteps, z0_primary, z0_secondary)) {
            console.log("[Step2] false");
            return false;
        }

        // Step 3:
        // - folds the running instance and last instance to get a folded instance
        // - checks the satisfiability of the folded instances using SNARKs proving the knowledge of their satisfying witnesses
        // from: https://github.com/lurk-lab/Nova/blob/solidity-verifier-pp-spartan/src/spartan/ppsnark.rs#L1565

        // Sumcheck protocol verification (secondary) part
        (secondaryData, success) = verifyStep3Secondary();
        if (!success) {
            console.log("[Step3 Secondary] false");
            return false;
        }

        // Sumcheck protocol verification (primary)
        (primaryData, success) = verifyStep3Primary();
        if (!success) {
            console.log("[Step3 Primary] false");
            return false;
        }

        return true;
    }

    function verifyStep3Primary() private returns (IntermediateData memory, bool) {
        Step3PrecomputeOutput memory precompute = verifyStep3PrecomputePrimary();

        (uint256[] memory r_sat, bool success) = verifyStep3InnerPrimary(precompute);

        IntermediateData memory primary;
        primary.step3 = Step3IntermediateData(
            precompute.tau,
            precompute.gamma1,
            precompute.gamma2,
            r_sat,
            precompute.U_X,
            precompute.U_comm_W_x,
            precompute.U_comm_W_y,
            precompute.U_comm_E_x,
            precompute.U_comm_E_y,
            precompute.U_u,
            precompute.u_step3
        );

        return (primary, success);
    }

    function verifyStep3Secondary() private returns (IntermediateData memory, bool) {
        Step3PrecomputeOutput memory precompute = verifyStep3PrecomputeSecondary();

        (uint256[] memory r_sat, bool success) = verifyStep3InnerSecondary(precompute);

        IntermediateData memory secondary;
        secondary.step3 = Step3IntermediateData(
            precompute.tau,
            precompute.gamma1,
            precompute.gamma2,
            r_sat,
            precompute.U_X,
            precompute.U_comm_W_x,
            precompute.U_comm_W_y,
            precompute.U_comm_E_x,
            precompute.U_comm_E_y,
            precompute.U_u,
            precompute.u_step3
        );

        return (secondary, success);
    }

    function verifyStep3InnerPrimary(Step3PrecomputeOutput memory precompute)
        private
        returns (uint256[] memory, bool)
    {
        uint256 claim_sat_final;
        uint256[] memory r_sat;
        (claim_sat_final, r_sat, transcriptPrimary) = Step3Lib.compute_claim_sat_final_r_sat_primary(
            proof.r_W_snark_primary,
            vk.vk_primary,
            transcriptPrimary,
            precompute.u_step3.e,
            precompute.coeffs,
            Vesta.P_MOD,
            printLogs
        );

        uint256 taus_bound_r_sat = EqPolinomialLib.evaluate(precompute.tau, r_sat, Vesta.P_MOD, Vesta.negateBase);
        uint256 rand_eq_bound_r_sat = EqPolinomialLib.evaluate(precompute.rand_eq, r_sat, Vesta.P_MOD, Vesta.negateBase);

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
            Step3Lib.compute_claim_inner_final(proof.r_W_snark_primary, precompute.c, precompute.coeffs, Vesta.P_MOD);

        uint256 claim_mem_final = Step3Lib.compute_claim_mem_final(
            proof.r_W_snark_primary, precompute.coeffs, rand_eq_bound_r_sat, Vesta.P_MOD, Vesta.negateBase
        );

        uint256 claim_outer_final = Step3Lib.compute_claim_outer_final(
            proof.r_W_snark_primary, precompute.U_u, precompute.coeffs, taus_bound_r_sat, Vesta.P_MOD, Vesta.negateBase
        );

        return (
            r_sat,
            Step3Lib.final_verification(
                claim_mem_final, claim_outer_final, claim_inner_final, claim_sat_final, Vesta.P_MOD
                )
        );
    }

    function verifyStep3InnerSecondary(Step3PrecomputeOutput memory precompute)
        private
        returns (uint256[] memory, bool)
    {
        uint256 claim_sat_final;
        uint256[] memory r_sat;
        (claim_sat_final, r_sat, transcriptSecondary) = Step3Lib.compute_claim_sat_final_r_sat_secondary(
            proof.f_W_snark_secondary,
            vk.vk_secondary,
            transcriptSecondary,
            precompute.u_step3.e,
            precompute.coeffs,
            Pallas.P_MOD,
            printLogs
        );

        uint256 taus_bound_r_sat = EqPolinomialLib.evaluate(precompute.tau, r_sat, Pallas.P_MOD, Pallas.negateBase);
        uint256 rand_eq_bound_r_sat =
            EqPolinomialLib.evaluate(precompute.rand_eq, r_sat, Pallas.P_MOD, Pallas.negateBase);

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
            proof.f_W_snark_secondary, precompute.coeffs, rand_eq_bound_r_sat, Pallas.P_MOD, Pallas.negateBase
        );

        uint256 claim_outer_final = Step3Lib.compute_claim_outer_final(
            proof.f_W_snark_secondary,
            precompute.U_u,
            precompute.coeffs,
            taus_bound_r_sat,
            Pallas.P_MOD,
            Pallas.negateBase
        );

        uint256 claim_inner_final =
            Step3Lib.compute_claim_inner_final(proof.f_W_snark_secondary, precompute.c, precompute.coeffs, Pallas.P_MOD);

        return (
            r_sat,
            Step3Lib.final_verification(
                claim_mem_final, claim_outer_final, claim_inner_final, claim_sat_final, Pallas.P_MOD
                )
        );
    }

    function verifyStep3PrecomputePrimary() private returns (Step3PrecomputeOutput memory) {
        Step3PrecomputeOutput memory precomputeOutput;
        (transcriptPrimary, precomputeOutput.tau) =
            Step3Lib.compute_tau_primary(proof, vk.vk_primary, transcriptPrimary, printLogs);

        (transcriptPrimary, precomputeOutput.c) = Step3Lib.compute_c_primary(proof.r_W_snark_primary, transcriptPrimary);

        precomputeOutput.u_step3 =
            Step3Lib.compute_u_primary(proof.r_W_snark_primary, precomputeOutput.tau, precomputeOutput.c);

        (transcriptPrimary, precomputeOutput.gamma1) = Step3Lib.compute_gamma_1_primary(transcriptPrimary);
        (transcriptPrimary, precomputeOutput.gamma2) = Step3Lib.compute_gamma_2_primary(transcriptPrimary);

        (transcriptPrimary, precomputeOutput.rand_eq) =
            Step3Lib.compute_rand_eq_primary(proof.r_W_snark_primary, vk.vk_primary, transcriptPrimary);

        (transcriptPrimary, precomputeOutput.coeffs) = Step3Lib.compute_coeffs_primary(transcriptPrimary);

        precomputeOutput.U_u = proof.r_U_primary.u;
        precomputeOutput.U_X = proof.r_U_primary.X;
        Pallas.PallasAffinePoint memory U_comm_W = Pallas.decompress(proof.r_U_primary.comm_W);
        Pallas.PallasAffinePoint memory U_comm_E = Pallas.decompress(proof.r_U_primary.comm_E);
        precomputeOutput.U_comm_W_x = U_comm_W.x;
        precomputeOutput.U_comm_W_y = U_comm_W.y;
        precomputeOutput.U_comm_W_x = U_comm_E.x;
        precomputeOutput.U_comm_W_y = U_comm_E.y;

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
            for (index = 0; index < precomputeOutput.tau.length; index++) {
                console.logBytes32(bytes32(precomputeOutput.tau[index]));
            }
            console.log("c");
            console.logBytes32(bytes32(precomputeOutput.c));
            console.log("u_step3 c");
            console.logBytes32(bytes32(precomputeOutput.u_step3.c_x));
            console.logBytes32(bytes32(precomputeOutput.u_step3.c_y));
            console.log("u_step3 x");
            for (index = 0; index < precomputeOutput.u_step3.x.length; index++) {
                console.logBytes32(bytes32(precomputeOutput.u_step3.x[index]));
            }
            console.log("u_step3 e");
            console.logBytes32(bytes32(precomputeOutput.u_step3.e));
            console.log("rand_eq");
            for (index = 0; index < precomputeOutput.rand_eq.length; index++) {
                console.logBytes32(bytes32(precomputeOutput.rand_eq[index]));
            }

            console.log("coeffs");
            for (index = 0; index < precomputeOutput.coeffs.length; index++) {
                console.logBytes32(bytes32(precomputeOutput.coeffs[index]));
            }
        }
        return precomputeOutput;
    }

    function verifyStep3PrecomputeSecondary() private returns (Step3PrecomputeOutput memory) {
        Step3PrecomputeOutput memory precomputeOutput;

        // f_U_secondary instance (RelaxedR1CSInstance with uncompressed commitments)
        Vesta.VestaAffinePoint memory f_U_secondary_comm_W;
        Vesta.VestaAffinePoint memory f_U_secondary_comm_E;
        uint256[] memory f_U_secondary_X;
        uint256 f_U_secondary_u;

        (f_U_secondary_comm_W, f_U_secondary_comm_E, f_U_secondary_X, f_U_secondary_u) =
            Step3Lib.compute_f_U_secondary(proof, vk);

        (transcriptSecondary, precomputeOutput.tau) = Step3Lib.compute_tau_secondary(
            proof,
            vk.vk_secondary,
            transcriptSecondary,
            f_U_secondary_comm_W,
            f_U_secondary_comm_E,
            f_U_secondary_X,
            f_U_secondary_u,
            printLogs
        );

        (transcriptSecondary, precomputeOutput.c) = Step3Lib.compute_c_secondary(proof, transcriptSecondary);

        precomputeOutput.u_step3 = Step3Lib.compute_u_secondary(proof, precomputeOutput.tau, precomputeOutput.c);

        (transcriptSecondary, precomputeOutput.gamma1) = Step3Lib.compute_gamma_1_secondary(transcriptSecondary);
        (transcriptSecondary, precomputeOutput.gamma2) = Step3Lib.compute_gamma_2_secondary(transcriptSecondary);

        (transcriptSecondary, precomputeOutput.rand_eq) =
            Step3Lib.compute_rand_eq_secondary(proof, vk, transcriptSecondary);

        (transcriptSecondary, precomputeOutput.coeffs) = Step3Lib.compute_coeffs_secondary(transcriptSecondary);

        precomputeOutput.U_u = f_U_secondary_u;
        precomputeOutput.U_X = f_U_secondary_X;
        precomputeOutput.U_comm_W_x = f_U_secondary_comm_W.x;
        precomputeOutput.U_comm_W_y = f_U_secondary_comm_W.y;
        precomputeOutput.U_comm_E_x = f_U_secondary_comm_E.x;
        precomputeOutput.U_comm_E_y = f_U_secondary_comm_E.y;

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
            for (index = 0; index < precomputeOutput.tau.length; index++) {
                console.logBytes32(bytes32(precomputeOutput.tau[index]));
            }
            console.log("c");
            console.logBytes32(bytes32(precomputeOutput.c));
            console.log("u_step3 c");
            console.logBytes32(bytes32(precomputeOutput.u_step3.c_x));
            console.logBytes32(bytes32(precomputeOutput.u_step3.c_y));
            console.log("u_step3 x");
            for (index = 0; index < precomputeOutput.u_step3.x.length; index++) {
                console.logBytes32(bytes32(precomputeOutput.u_step3.x[index]));
            }
            console.log("u_step3 e");
            console.logBytes32(bytes32(precomputeOutput.u_step3.e));
            console.log("rand_eq");
            for (index = 0; index < precomputeOutput.rand_eq.length; index++) {
                console.logBytes32(bytes32(precomputeOutput.rand_eq[index]));
            }
            console.log("coeffs");
            for (index = 0; index < precomputeOutput.coeffs.length; index++) {
                console.logBytes32(bytes32(precomputeOutput.coeffs[index]));
            }
        }
        return precomputeOutput;
    }
}
