// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.16;

import "@std/Test.sol";
import "src/blocks/KeccakTranscript.sol";
import "src/blocks/PolyEvalInstance.sol";
import "src/verifier/Step1.sol";
import "src/verifier/Step2.sol";
import "src/verifier/Step3.sol";
import "src/verifier/Step4.sol";
import "src/verifier/Step5.sol";
import "src/verifier/Step6.sol";
import "src/NovaVerifierAbstractions.sol";

contract NovaVerifierContract {
    struct Step5IntermediateData {
        uint256[] r_prod;
    }

    struct Step3IntermediateData {
        uint256[] tau;
        uint256 gamma1;
        uint256 gamma2;
        uint256[] r_sat;
        uint256[] U_X;
        uint256 U_u;
    }

    struct Step3PrecomputeOutput {
        uint256[] tau;
        PolyEvalInstanceLib.PolyEvalInstance u_step3;
        uint256 c;
        uint256[] rand_eq;
        uint256[] coeffs;
        uint256 U_u;
        uint256[] U_X;
        uint256 gamma1;
        uint256 gamma2;
    }

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

    // cast send 0xc351628eb244ec633d5f21fbd6621e1a683b1181 "pushToProof(((uint256,uint256[]),(uint256,uint256,uint256[],uint256),(uint256,uint256,uint256[],uint256),uint256[],uint256[],uint256,(uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256[],uint256[],((uint256[])[]),uint256[],uint256[],uint256[],uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256[],uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256),(uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256[],uint256[],((uint256[])[]),uint256[],uint256[],uint256[],uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256[],uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256)))" "((1,[1]),(1,1,[1],1),(1,1,[1],1),[1],[1],1,(1,1,1,1,1,1,1,1,[1],[1],([([1])]),[1],[1],[1],1,1,1,1,1,1,1,1,1,[1],1,1,1,1,1,1,1,1,1),(1,1,1,1,1,1,1,1,[1],[1],([([1])]),[1],[1],[1],1,1,1,1,1,1,1,1,1,[1],1,1,1,1,1,1,1,1,1))" --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
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

        Step3IntermediateData memory step3PrimaryOutput;
        Step3IntermediateData memory step3SecondaryOutput;
        Step5IntermediateData memory step5PrimaryOutput;
        Step5IntermediateData memory step5SecondaryOutput;
        bool success;

        // fold the running instance and last instance to get a folded instance
        // check the satisfiability of the folded instances using SNARKs proving the knowledge of their satisfying witnesses
        // from: https://github.com/lurk-lab/Nova/blob/solidity-verifier-pp-spartan/src/spartan/ppsnark.rs#L1565

        // Sumcheck protocol verification (secondary) part
        (step3SecondaryOutput, success) = verifyStep3Secondary();
        if (!success) {
            console.log("[Step3 Secondary] false");
            return false;
        }

        // Sumcheck protocol verification (primary)
        (step3PrimaryOutput, success) = verifyStep3Primary();
        if (!success) {
            console.log("[Step3 Primary] false");
            return false;
        }

        // check the required multiset relationship
        if (!Step4Lib.verify(proof)) {
            console.log("[Step4] false");
            return false;
        }

        // multiset check for the row
        (step5PrimaryOutput, success) = verifyStep5Primary(step3PrimaryOutput);
        if (!success) {
            console.log("[Step5 Primary] false");
            return false;
        }

        (step5SecondaryOutput, success) = verifyStep5Secondary(step3SecondaryOutput);
        if (!success) {
            console.log("[Step5 Secondary] false");
            return false;
        }

        // multiset check for the col
        if (!verifyStep6Primary(step5PrimaryOutput, step3PrimaryOutput)) {
            console.log("[Step6 Primary] false");
            return false;
        }

        if (!verifyStep6Secondary(step5SecondaryOutput, step3SecondaryOutput)) {
            console.log("[Step6 Secondary] false");
            return false;
        }

        return true;
    }

    function verifyStep6Secondary(Step5IntermediateData memory step5Output, Step3IntermediateData memory step3Output)
        public
        returns (bool)
    {
        uint256[] memory r_prod = step5Output.r_prod;
        uint256 gamma1 = step3Output.gamma1;
        uint256 gamma2 = step3Output.gamma2;
        uint256[] memory U_X = step3Output.U_X;
        uint256 U_u = step3Output.U_u;

        uint256 eval_Z = Step6Lib.compute_eval_Z(
            proof.f_W_snark_secondary,
            U_X,
            U_u,
            vk.vk_primary.S_comm.N,
            vk.vk_primary.num_vars,
            r_prod,
            Pallas.P_MOD,
            Pallas.negateBase
        );

        (uint256 claim_init_expected_col, uint256 claim_audit_expected_col) = Step6Lib.compute_claims_init_audit(
            proof.f_W_snark_secondary, gamma1, gamma2, eval_Z, r_prod, Pallas.P_MOD, Pallas.negateBase
        );

        (uint256 claim_read_expected_col, uint256 claim_write_expected_col) = Step6Lib.compute_claims_read_write(
            proof.f_W_snark_secondary, gamma1, gamma2, Pallas.P_MOD, Pallas.negateBase
        );

        return Step6Lib.finalVerification(
            proof.f_W_snark_secondary,
            claim_init_expected_col,
            claim_read_expected_col,
            claim_write_expected_col,
            claim_audit_expected_col
        );
    }

    function verifyStep6Primary(Step5IntermediateData memory step5Output, Step3IntermediateData memory step3Output)
        private
        returns (bool)
    {
        uint256[] memory r_prod = step5Output.r_prod;
        uint256 gamma1 = step3Output.gamma1;
        uint256 gamma2 = step3Output.gamma2;
        uint256[] memory U_X = step3Output.U_X;
        uint256 U_u = step3Output.U_u;

        uint256 eval_Z = Step6Lib.compute_eval_Z(
            proof.r_W_snark_primary,
            U_X,
            U_u,
            vk.vk_primary.S_comm.N,
            vk.vk_primary.num_vars,
            r_prod,
            Vesta.P_MOD,
            Vesta.negateBase
        );

        (uint256 claim_init_expected_col, uint256 claim_audit_expected_col) = Step6Lib.compute_claims_init_audit(
            proof.r_W_snark_primary, gamma1, gamma2, eval_Z, r_prod, Vesta.P_MOD, Vesta.negateBase
        );

        (uint256 claim_read_expected_col, uint256 claim_write_expected_col) =
            Step6Lib.compute_claims_read_write(proof.r_W_snark_primary, gamma1, gamma2, Vesta.P_MOD, Vesta.negateBase);

        return Step6Lib.finalVerification(
            proof.r_W_snark_primary,
            claim_init_expected_col,
            claim_read_expected_col,
            claim_write_expected_col,
            claim_audit_expected_col
        );
    }

    function verifyStep5Primary(Step3IntermediateData memory step3PrimaryOutput)
        private
        returns (Step5IntermediateData memory, bool)
    {
        uint256 c;
        (transcriptPrimary, c) = Step5Lib.compute_c_primary(proof.r_W_snark_primary, transcriptPrimary);

        uint256[] memory r_prod = Step5Lib.compute_r_prod(c, step3PrimaryOutput.r_sat);

        (uint256 claim_init_expected_row, uint256 claim_audit_expected_row) = Step5Lib.compute_claims_init_audit(
            proof.r_W_snark_primary.eval_row_audit_ts,
            step3PrimaryOutput.gamma1,
            step3PrimaryOutput.gamma2,
            r_prod,
            step3PrimaryOutput.tau,
            Vesta.P_MOD,
            Vesta.negateBase
        );

        (uint256 claim_read_expected_row, uint256 claim_write_expected_row) = Step5Lib.compute_claims_read_write(
            proof.r_W_snark_primary, step3PrimaryOutput.gamma1, step3PrimaryOutput.gamma2, Vesta.P_MOD, Vesta.negateBase
        );

        return (
            Step5IntermediateData(r_prod),
            Step5Lib.final_verification(
                proof.r_W_snark_primary,
                claim_init_expected_row,
                claim_read_expected_row,
                claim_write_expected_row,
                claim_audit_expected_row
                )
        );
    }

    function verifyStep5Secondary(Step3IntermediateData memory step3SecondaryOutput)
        private
        returns (Step5IntermediateData memory, bool)
    {
        uint256 c;
        (transcriptSecondary, c) = Step5Lib.compute_c_secondary(proof.f_W_snark_secondary, transcriptSecondary);

        uint256[] memory r_prod = Step5Lib.compute_r_prod(c, step3SecondaryOutput.r_sat);

        (uint256 claim_init_expected_row, uint256 claim_audit_expected_row) = Step5Lib.compute_claims_init_audit(
            proof.f_W_snark_secondary.eval_row_audit_ts,
            step3SecondaryOutput.gamma1,
            step3SecondaryOutput.gamma2,
            r_prod,
            step3SecondaryOutput.tau,
            Pallas.P_MOD,
            Pallas.negateBase
        );

        (uint256 claim_read_expected_row, uint256 claim_write_expected_row) = Step5Lib.compute_claims_read_write(
            proof.f_W_snark_secondary,
            step3SecondaryOutput.gamma1,
            step3SecondaryOutput.gamma2,
            Pallas.P_MOD,
            Pallas.negateBase
        );

        return (
            Step5IntermediateData(r_prod),
            Step5Lib.final_verification(
                proof.f_W_snark_secondary,
                claim_init_expected_row,
                claim_read_expected_row,
                claim_write_expected_row,
                claim_audit_expected_row
                )
        );
    }

    function verifyStep3Primary() private returns (Step3IntermediateData memory output, bool) {
        Step3PrecomputeOutput memory precompute = verifyStep3PrecomputePrimary();

        (uint256[] memory r_sat, bool success) = verifyStep3InnerPrimary(precompute);

        return (
            Step3IntermediateData(
                precompute.tau, precompute.gamma1, precompute.gamma2, r_sat, precompute.U_X, precompute.U_u
                ),
            success
        );
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

    function verifyStep3Secondary() private returns (Step3IntermediateData memory, bool) {
        Step3PrecomputeOutput memory precompute = verifyStep3PrecomputeSecondary();

        (uint256[] memory r_sat, bool success) = verifyStep3InnerSecondary(precompute);

        return (
            Step3IntermediateData(
                precompute.tau, precompute.gamma1, precompute.gamma2, r_sat, precompute.U_X, precompute.U_u
                ),
            success
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
