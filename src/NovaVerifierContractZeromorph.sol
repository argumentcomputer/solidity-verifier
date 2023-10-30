// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.16;

import "@std/Test.sol";
import "src/blocks/KeccakTranscript.sol";
import "src/blocks/PolyEvalInstance.sol";
import "src/blocks/poseidon/PoseidonNeptuneU24Optimized.sol";
import "src/verifier/Step1.sol";
import "src/verifier/Step2.sol";
import "src/verifier/Step3.sol";
import "src/verifier/Step4.sol";
import "src/verifier/Step5.sol";
import "src/verifier/Step6.sol";
import "src/verifier/Step7.sol";
import "src/verifier/Step2Grumpkin.sol";
import "src/verifier/Step3Grumpkin.sol";
import "src/verifier/Step5Grumpkin.sol";
import "src/verifier/Step6Grumpkin.sol";
import "src/verifier/Step7Grumpkin.sol";
import "src/verifier/zeromorph/Step2Zeromorph.sol";
import "src/verifier/zeromorph/Step3Zeromorph.sol";
import "src/verifier/zeromorph/Step5Zeromorph.sol";
import "src/verifier/zeromorph/Step7Zeromorph.sol";
import "src/NovaVerifierAbstractions.sol";
import "test/utils.t.sol";

contract NovaVerifierContractGrumpkinZeromorph {
    struct IntermediateData {
        Step3IntermediateData step3;
        Step5IntermediateData step5;
        Step6IntermediateData step6;
    }

    struct Step6IntermediateData {
        PolyEvalInstanceLib.PolyEvalInstance u_vec_item_5;
    }

    struct Step5IntermediateData {
        uint256[] r_prod;
        PolyEvalInstanceLib.PolyEvalInstance u_vec_item_1;
        PolyEvalInstanceLib.PolyEvalInstance u_vec_item_2;
        PolyEvalInstanceLib.PolyEvalInstance u_vec_item_3;
        PolyEvalInstanceLib.PolyEvalInstance u_vec_item_4;
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

    Abstractions.VerifierKeyZeromorph public vk;
    Abstractions.CompressedSnark public proof;
    Abstractions.ROConstants public poseidonConstantsPrimary;
    Abstractions.ROConstants public poseidonConstantsSecondary;

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

    // cast send 0xd84379ceae14aa33c123af12424a37803f885889 "pushToProof(((uint256,uint256[]),(uint256,uint256,uint256[],uint256),(uint256,uint256,uint256[],uint256),uint256[],uint256[],uint256,(uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256[],uint256[],((uint256[])[]),uint256[],uint256[],uint256[],uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256[],uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256[],((uint256[])[]),uint256[]),(uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256[],uint256[],((uint256[])[]),uint256[],uint256[],uint256[],uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256[],uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256[],((uint256[])[]),uint256[])))" "((1,[1]),(1,1,[1],1),(1,1,[1],1),[1],[1],1,(1,1,1,1,1,1,1,1,[1],[1],([([1])]),[1],[1],[1],1,1,1,1,1,1,1,1,1,[1],1,1,1,1,1,1,1,1,1,[1],([([1])]),[1]),(1,1,1,1,1,1,1,1,[1],[1],([([1])]),[1],[1],[1],1,1,1,1,1,1,1,1,1,[1],1,1,1,1,1,1,1,1,1,[1],([([1])]),[1]))" --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
    function pushToProof(Abstractions.CompressedSnark calldata input) public {
        proof = input;
    }

    // cast send 0x9E545E3C0baAB3E08CdfD552C960A1050f373042 "pushToVk((uint256,uint256,uint256,(uint256,uint256,(uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256)),(uint256,uint256,(uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256))))" "(1,1,1,(1,1,(1,1,1,1,1,1,1,1,1,1)),(1,1,(1,1,1,1,1,1,1,1,1,1)))" --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 --rpc-url http://127.0.0.1:8545
    function pushToVk(Abstractions.VerifierKeyZeromorph calldata input) public {
        vk = input;
    }

    function pushToPoseidonConstantsPrimaryM(Abstractions.M[] calldata input) public {
        for (uint256 index = 0; index < input.length; index++) {
            poseidonConstantsPrimary.m.push(input[index]);
        }
    }

    function pushToPoseidonConstantsPrimaryPSM(Abstractions.PSM[] calldata input) public {
        for (uint256 index = 0; index < input.length; index++) {
            poseidonConstantsPrimary.psm.push(input[index]);
        }
    }

    function pushToPoseidonConstantsPrimaryWHAT(Abstractions.W_HAT[] calldata input) public {
        for (uint256 index = 0; index < input.length; index++) {
            poseidonConstantsPrimary.w_hats.push(input[index]);
        }
    }

    function pushToPoseidonConstantsPrimaryVREST(Abstractions.V_REST[] calldata input) public {
        for (uint256 index = 0; index < input.length; index++) {
            poseidonConstantsPrimary.v_rests.push(input[index]);
        }
    }

    // cast send 0xE6E340D132b5f46d1e472DebcD681B2aBc16e57E "pushToPoseidonConstantsPrimary(uint256[],uint256,uint256)" "[1]" "1" "1" --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
    function pushToPoseidonConstantsPrimary(
        uint256[] calldata round_constants,
        uint256 partial_rounds,
        uint256 full_rounds
    ) public {
        poseidonConstantsPrimary.addRoundConstants = round_constants;
        poseidonConstantsPrimary.partial_rounds = partial_rounds;
        poseidonConstantsPrimary.full_rounds = full_rounds;
    }

    function pushToPoseidonConstantsSecondaryM(Abstractions.M[] calldata input) public {
        for (uint256 index = 0; index < input.length; index++) {
            poseidonConstantsSecondary.m.push(input[index]);
        }
    }

    function pushToPoseidonConstantsSecondaryPSM(Abstractions.PSM[] calldata input) public {
        for (uint256 index = 0; index < input.length; index++) {
            poseidonConstantsSecondary.psm.push(input[index]);
        }
    }

    function pushToPoseidonConstantsSecondaryWHAT(Abstractions.W_HAT[] calldata input) public {
        for (uint256 index = 0; index < input.length; index++) {
            poseidonConstantsSecondary.w_hats.push(input[index]);
        }
    }

    function pushToPoseidonConstantsSecondaryVREST(Abstractions.V_REST[] calldata input) public {
        for (uint256 index = 0; index < input.length; index++) {
            poseidonConstantsSecondary.v_rests.push(input[index]);
        }
    }

    // cast send 0xE6E340D132b5f46d1e472DebcD681B2aBc16e57E "pushToPoseidonConstantsSecondary(uint256[],uint256,uint256)" "[1]" "1" "1" --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
    function pushToPoseidonConstantsSecondary(
        uint256[] calldata round_constants,
        uint256 partial_rounds,
        uint256 full_rounds
    ) public {
        poseidonConstantsSecondary.addRoundConstants = round_constants;
        poseidonConstantsSecondary.partial_rounds = partial_rounds;
        poseidonConstantsSecondary.full_rounds = full_rounds;
    }

    // cast call 0x998abeb3e57409262ae5b751f60747921b33613e "verify(uint32,uint256[],uint256[],bool)(bool)" "3" "[1]" "[0]" "false" --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
    function verify(uint32 numSteps, uint256[] calldata z0_primary, uint256[] calldata z0_secondary, bool enableLogs)
        public
        returns (bool)
    {
        printLogs = enableLogs;

        (transcriptPrimary, transcriptSecondary) = initialize();

        IntermediateData memory primaryData;
        IntermediateData memory secondaryData;

        bool success;

        // number of steps cannot be zero
        if (!Step1Lib.verify(proof, numSteps)) {
            console.log("[Step1] false");
            return false;
        }

        // check if the output hashes in R1CS instances point to the right running instances
        if (
            !Step2GrumpkinZeromorphLib.verify(
                proof, vk, poseidonConstantsPrimary, poseidonConstantsSecondary, numSteps, z0_primary, z0_secondary
            )
        ) {
            console.log("[Step2] false");
            return false;
        }

        // fold the running instance and last instance to get a folded instance
        // check the satisfiability of the folded instances using SNARKs proving the knowledge of their satisfying witnesses
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

        // check the required multiset relationship
        if (!Step4Lib.verify(proof, Bn256.R_MOD, Grumpkin.P_MOD)) {
            console.log("[Step4] false");
            return false;
        }

        // multiset check for the row
        (primaryData, success) = verifyStep5Primary(primaryData);
        if (!success) {
            console.log("[Step5 Primary] false");
            return false;
        }

        (secondaryData, success) = verifyStep5Secondary(secondaryData);
        if (!success) {
            console.log("[Step5 Secondary] false");
            return false;
        }

        // multiset check for the col
        (primaryData, success) = verifyStep6Primary(primaryData);
        if (!success) {
            console.log("[Step6 Primary] false");
            return false;
        }

        (secondaryData, success) = verifyStep6Secondary(secondaryData);
        if (!success) {
            console.log("[Step6 Secondary] false");
            return false;
        }

        // batched claims verification
        success = verifyStep7Primary(primaryData);
        if (!success) {
            console.log("[Step7 Primary] false");
            return false;
        }

        success = verifyStep7Secondary(secondaryData);
        if (!success) {
            console.log("[Step7 Secondary] false");
            return false;
        }

        return true;
    }

    function verifyStep7Primary(IntermediateData memory primary) private returns (bool) {
        uint256 c;
        (transcriptPrimary, c) = Step7GrumpkinLib.compute_c_primary(proof.r_W_snark_primary, transcriptPrimary);

        PolyEvalInstanceLib.PolyEvalInstance memory u = Step7GrumpkinZeromorphLib.compute_u_primary(
            proof.r_W_snark_primary,
            vk.vk_primary,
            primary.step3.U_comm_E_x,
            primary.step3.U_comm_E_y,
            primary.step3.r_sat,
            c
        );

        // constructing u_vec using items computed on previous steps
        PolyEvalInstanceLib.PolyEvalInstance[] memory u_vec = new PolyEvalInstanceLib.PolyEvalInstance[](7);
        u_vec[0] = primary.step3.u_vec_item_0;
        u_vec[1] = primary.step5.u_vec_item_1;
        u_vec[2] = primary.step5.u_vec_item_2;
        u_vec[3] = primary.step5.u_vec_item_3;
        u_vec[4] = primary.step5.u_vec_item_4;
        u_vec[5] = primary.step6.u_vec_item_5;
        u_vec[6] = u;

        u_vec = Step7Lib.compute_u_vec_padded(u_vec);

        // tmp = rho
        uint256 tmp;
        (transcriptPrimary, tmp) = Step7GrumpkinLib.compute_rho_primary(transcriptPrimary);

        // claim_batch_final_left = claim_batch_join
        (uint256 claim_batch_final_left, uint256 num_rounds_z, uint256[] memory powers_of_rho) =
            Step7Lib.compute_sc_proof_batch_verification_input(u_vec, tmp, Bn256.R_MOD);

        uint256[] memory r_z;
        (transcriptPrimary, claim_batch_final_left, r_z) = Step7GrumpkinLib.compute_claim_batch_final_left_primary(
            proof.r_W_snark_primary.sc_proof_batch, transcriptPrimary, claim_batch_final_left, num_rounds_z
        );

        if (
            claim_batch_final_left
                != Step7Lib.compute_claim_batch_final_right(
                    proof.r_W_snark_primary, r_z, u_vec, powers_of_rho, Bn256.R_MOD, Bn256.negateScalar
                )
        ) {
            return false;
        }

        return true;
    }

    function verifyStep7Secondary(IntermediateData memory secondary) private returns (bool) {
        uint256 c;
        (transcriptSecondary, c) = Step7GrumpkinLib.compute_c_secondary(proof.f_W_snark_secondary, transcriptSecondary);

        PolyEvalInstanceLib.PolyEvalInstance memory u = Step7GrumpkinZeromorphLib.compute_u_secondary(
            proof.f_W_snark_secondary,
            vk.vk_secondary,
            secondary.step3.U_comm_E_x,
            secondary.step3.U_comm_E_y,
            secondary.step3.r_sat,
            c
        );

        // constructing u_vec using items computed on previous steps
        PolyEvalInstanceLib.PolyEvalInstance[] memory u_vec = new PolyEvalInstanceLib.PolyEvalInstance[](7);
        u_vec[0] = secondary.step3.u_vec_item_0;
        u_vec[1] = secondary.step5.u_vec_item_1;
        u_vec[2] = secondary.step5.u_vec_item_2;
        u_vec[3] = secondary.step5.u_vec_item_3;
        u_vec[4] = secondary.step5.u_vec_item_4;
        u_vec[5] = secondary.step6.u_vec_item_5;
        u_vec[6] = u;

        u_vec = Step7Lib.compute_u_vec_padded(u_vec);

        // tmp = rho
        uint256 tmp;
        (transcriptSecondary, tmp) = Step7GrumpkinLib.compute_rho_secondary(transcriptSecondary);

        // claim_batch_final_left = claim_batch_join
        (uint256 claim_batch_final_left, uint256 num_rounds_z, uint256[] memory powers_of_rho) =
            Step7Lib.compute_sc_proof_batch_verification_input(u_vec, tmp, Grumpkin.P_MOD);

        uint256[] memory r_z;
        (transcriptSecondary, claim_batch_final_left, r_z) = Step7GrumpkinLib.compute_claim_batch_final_left_secondary(
            proof.f_W_snark_secondary.sc_proof_batch, transcriptSecondary, claim_batch_final_left, num_rounds_z
        );

        if (
            claim_batch_final_left
                != Step7Lib.compute_claim_batch_final_right(
                    proof.f_W_snark_secondary, r_z, u_vec, powers_of_rho, Grumpkin.P_MOD, Grumpkin.negateBase
                )
        ) {
            return false;
        }

        return true;
    }

    function verifyStep6Secondary(IntermediateData memory secondary) private returns (IntermediateData memory, bool) {
        uint256 eval_Z;
        uint256[] memory r_prod_unpad;
        (eval_Z, r_prod_unpad) = Step6GrumpkinLib.compute_eval_Z(
            proof.f_W_snark_secondary,
            secondary.step3.U_X,
            secondary.step3.U_u,
            vk.vk_secondary.S_comm.N,
            vk.vk_secondary.num_vars,
            secondary.step5.r_prod,
            Grumpkin.P_MOD,
            Grumpkin.negateBase
        );

        (uint256 claim_init_expected_col, uint256 claim_audit_expected_col) = Step6Lib.compute_claims_init_audit(
            proof.f_W_snark_secondary,
            secondary.step3.gamma1,
            secondary.step3.gamma2,
            eval_Z,
            secondary.step5.r_prod,
            Grumpkin.P_MOD,
            Grumpkin.negateBase
        );

        (uint256 claim_read_expected_col, uint256 claim_write_expected_col) = Step6Lib.compute_claims_read_write(
            proof.f_W_snark_secondary,
            secondary.step3.gamma1,
            secondary.step3.gamma2,
            Grumpkin.P_MOD,
            Grumpkin.negateBase
        );

        uint256 comm_W_x;
        uint256 comm_W_y;
        secondary.step6 =
            Step6IntermediateData(Step6Lib.compute_u_vec_5(proof.f_W_snark_secondary, r_prod_unpad, comm_W_x, comm_W_y));

        return (
            secondary,
            Step6Lib.finalVerification(
                proof.f_W_snark_secondary,
                claim_init_expected_col,
                claim_read_expected_col,
                claim_write_expected_col,
                claim_audit_expected_col
                )
        );
    }

    function verifyStep6Primary(IntermediateData memory primary) private returns (IntermediateData memory, bool) {
        uint256 eval_Z;
        uint256[] memory r_prod_unpad;
        (eval_Z, r_prod_unpad) = Step6GrumpkinLib.compute_eval_Z(
            proof.r_W_snark_primary,
            primary.step3.U_X,
            primary.step3.U_u,
            vk.vk_primary.S_comm.N,
            vk.vk_primary.num_vars,
            primary.step5.r_prod,
            Bn256.R_MOD,
            Bn256.negateScalar
        );

        (uint256 claim_init_expected_col, uint256 claim_audit_expected_col) = Step6Lib.compute_claims_init_audit(
            proof.r_W_snark_primary,
            primary.step3.gamma1,
            primary.step3.gamma2,
            eval_Z,
            primary.step5.r_prod,
            Bn256.R_MOD,
            Bn256.negateScalar
        );

        (uint256 claim_read_expected_col, uint256 claim_write_expected_col) = Step6Lib.compute_claims_read_write(
            proof.r_W_snark_primary, primary.step3.gamma1, primary.step3.gamma2, Bn256.R_MOD, Bn256.negateScalar
        );

        uint256 comm_W_x = primary.step3.U_comm_W_x;
        uint256 comm_W_y = primary.step3.U_comm_W_y;

        primary.step6 =
            Step6IntermediateData(Step6Lib.compute_u_vec_5(proof.r_W_snark_primary, r_prod_unpad, comm_W_x, comm_W_y));

        return (
            primary,
            Step6Lib.finalVerification(
                proof.r_W_snark_primary,
                claim_init_expected_col,
                claim_read_expected_col,
                claim_write_expected_col,
                claim_audit_expected_col
                )
        );
    }

    function verifyStep5Primary(IntermediateData memory primary) private returns (IntermediateData memory, bool) {
        uint256 c;
        (transcriptPrimary, c) = Step5GrumpkinLib.compute_c_primary(proof.r_W_snark_primary, transcriptPrimary);

        if (printLogs) {
            console.log("------------------[Step5Primary]------------------");
            console.log("c");
            console.logBytes32(bytes32(c));
        }

        uint256[] memory r_prod = Step5Lib.compute_r_prod(c, primary.step3.r_sat);
        if (printLogs) {
            console.log("r_prod");
            for (uint256 index = 0; index < r_prod.length; index++) {
                console.logBytes32(bytes32(r_prod[index]));
            }
        }

        (uint256 claim_init_expected_row, uint256 claim_audit_expected_row) = Step5Lib.compute_claims_init_audit(
            proof.r_W_snark_primary.eval_row_audit_ts,
            primary.step3.gamma1,
            primary.step3.gamma2,
            r_prod,
            primary.step3.tau,
            Bn256.R_MOD,
            Bn256.negateScalar
        );

        if (printLogs) {
            console.log("compute_claims_init_audit was successful");
        }

        (uint256 claim_read_expected_row, uint256 claim_write_expected_row) = Step5Lib.compute_claims_read_write(
            proof.r_W_snark_primary, primary.step3.gamma1, primary.step3.gamma2, Bn256.R_MOD, Bn256.negateScalar
        );

        if (printLogs) {
            console.log("compute_claims_read_write was successful");
        }

        // compute u_vec items
        PolyEvalInstanceLib.PolyEvalInstance[] memory u_vec_items;
        (transcriptPrimary, u_vec_items) = Step5GrumpkinZeromorphLib.compute_u_vec_items_primary(
            proof.r_W_snark_primary, vk.vk_primary, transcriptPrimary, primary.step3.r_sat, r_prod, printLogs
        );

        if (printLogs) {
            console.log("compute_u_vec_items_primary was successful");
        }

        require(u_vec_items.length == 4, "[verifyStep5Primary] u_vec_items.length != 4");

        primary.step5 = Step5IntermediateData(r_prod, u_vec_items[0], u_vec_items[1], u_vec_items[2], u_vec_items[3]);

        return (
            primary,
            Step5Lib.final_verification(
                proof.r_W_snark_primary,
                claim_init_expected_row,
                claim_read_expected_row,
                claim_write_expected_row,
                claim_audit_expected_row,
                printLogs
                )
        );
    }

    function verifyStep5Secondary(IntermediateData memory secondary) private returns (IntermediateData memory, bool) {
        uint256 c;
        (transcriptSecondary, c) = Step5GrumpkinLib.compute_c_secondary(proof.f_W_snark_secondary, transcriptSecondary);

        uint256[] memory r_prod = Step5Lib.compute_r_prod(c, secondary.step3.r_sat);

        (uint256 claim_init_expected_row, uint256 claim_audit_expected_row) = Step5Lib.compute_claims_init_audit(
            proof.f_W_snark_secondary.eval_row_audit_ts,
            secondary.step3.gamma1,
            secondary.step3.gamma2,
            r_prod,
            secondary.step3.tau,
            Grumpkin.P_MOD,
            Grumpkin.negateBase
        );

        (uint256 claim_read_expected_row, uint256 claim_write_expected_row) = Step5Lib.compute_claims_read_write(
            proof.f_W_snark_secondary,
            secondary.step3.gamma1,
            secondary.step3.gamma2,
            Grumpkin.P_MOD,
            Grumpkin.negateBase
        );

        // compute u_vec items
        PolyEvalInstanceLib.PolyEvalInstance[] memory u_vec_items;
        (transcriptSecondary, u_vec_items) = Step5GrumpkinZeromorphLib.compute_u_vec_items_secondary(
            proof.f_W_snark_secondary, vk.vk_secondary, transcriptSecondary, secondary.step3.r_sat, r_prod
        );
        require(u_vec_items.length == 4, "[verifyStep5Secondary] u_vec_items.length != 4");

        secondary.step5 = Step5IntermediateData(r_prod, u_vec_items[0], u_vec_items[1], u_vec_items[2], u_vec_items[3]);

        return (
            secondary,
            Step5Lib.final_verification(
                proof.f_W_snark_secondary,
                claim_init_expected_row,
                claim_read_expected_row,
                claim_write_expected_row,
                claim_audit_expected_row,
                printLogs
                )
        );
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
        (claim_sat_final, r_sat, transcriptPrimary) = Step3GrumpkinZeromorphLib.compute_claim_sat_final_r_sat_primary(
            proof.r_W_snark_primary,
            vk.vk_primary,
            transcriptPrimary,
            precompute.u_step3.e,
            precompute.coeffs,
            Bn256.R_MOD,
            printLogs
        );

        uint256 taus_bound_r_sat = EqPolinomialLib.evaluate(precompute.tau, r_sat, Bn256.R_MOD, Bn256.negateScalar);
        uint256 rand_eq_bound_r_sat =
            EqPolinomialLib.evaluate(precompute.rand_eq, r_sat, Bn256.R_MOD, Bn256.negateScalar);

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
            Step3Lib.compute_claim_inner_final(proof.r_W_snark_primary, precompute.c, precompute.coeffs, Bn256.R_MOD);

        uint256 claim_mem_final = Step3Lib.compute_claim_mem_final(
            proof.r_W_snark_primary, precompute.coeffs, rand_eq_bound_r_sat, Bn256.R_MOD, Bn256.negateScalar
        );

        uint256 claim_outer_final = Step3Lib.compute_claim_outer_final(
            proof.r_W_snark_primary,
            precompute.U_u,
            precompute.coeffs,
            taus_bound_r_sat,
            Bn256.R_MOD,
            Bn256.negateScalar
        );

        return (
            r_sat,
            Step3Lib.final_verification(
                claim_mem_final, claim_outer_final, claim_inner_final, claim_sat_final, Bn256.R_MOD
                )
        );
    }

    function verifyStep3InnerSecondary(Step3PrecomputeOutput memory precompute)
        private
        returns (uint256[] memory, bool)
    {
        uint256 claim_sat_final;
        uint256[] memory r_sat;
        (claim_sat_final, r_sat, transcriptSecondary) = Step3GrumpkinZeromorphLib
            .compute_claim_sat_final_r_sat_secondary(
            proof.f_W_snark_secondary,
            vk.vk_secondary,
            transcriptSecondary,
            precompute.u_step3.e,
            precompute.coeffs,
            Grumpkin.P_MOD,
            printLogs
        );

        uint256 taus_bound_r_sat = EqPolinomialLib.evaluate(precompute.tau, r_sat, Grumpkin.P_MOD, Grumpkin.negateBase);
        uint256 rand_eq_bound_r_sat =
            EqPolinomialLib.evaluate(precompute.rand_eq, r_sat, Grumpkin.P_MOD, Grumpkin.negateBase);

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
            proof.f_W_snark_secondary, precompute.coeffs, rand_eq_bound_r_sat, Grumpkin.P_MOD, Grumpkin.negateBase
        );

        uint256 claim_outer_final = Step3Lib.compute_claim_outer_final(
            proof.f_W_snark_secondary,
            precompute.U_u,
            precompute.coeffs,
            taus_bound_r_sat,
            Grumpkin.P_MOD,
            Grumpkin.negateBase
        );

        uint256 claim_inner_final = Step3Lib.compute_claim_inner_final(
            proof.f_W_snark_secondary, precompute.c, precompute.coeffs, Grumpkin.P_MOD
        );

        return (
            r_sat,
            Step3Lib.final_verification(
                claim_mem_final, claim_outer_final, claim_inner_final, claim_sat_final, Grumpkin.P_MOD
                )
        );
    }

    function verifyStep3PrecomputePrimary() private returns (Step3PrecomputeOutput memory) {
        Step3PrecomputeOutput memory precomputeOutput;
        (transcriptPrimary, precomputeOutput.tau) = Step3GrumpkinZeromorphLib.compute_tau_primary(
            proof,
            vk.vk_primary,
            0x0100b65fab13124f70f5ae6e341172d028a985d4a36ed91aa6308556d290410c,
            transcriptPrimary,
            printLogs
        );

        (transcriptPrimary, precomputeOutput.c) = Step3GrumpkinLib.compute_c_primary(proof, transcriptPrimary);

        precomputeOutput.u_step3 = Step3GrumpkinLib.compute_u_primary(proof, precomputeOutput.tau, precomputeOutput.c);

        (transcriptPrimary, precomputeOutput.gamma1) = Step3GrumpkinLib.compute_gamma_1_primary(transcriptPrimary);
        (transcriptPrimary, precomputeOutput.gamma2) = Step3GrumpkinLib.compute_gamma_2_primary(transcriptPrimary);

        (transcriptPrimary, precomputeOutput.rand_eq) =
            Step3GrumpkinZeromorphLib.compute_rand_eq_primary(proof, vk, transcriptPrimary);

        (transcriptPrimary, precomputeOutput.coeffs) = Step3GrumpkinLib.compute_coeffs_primary(transcriptPrimary);

        precomputeOutput.U_u = proof.r_U_primary.u;
        precomputeOutput.U_X = proof.r_U_primary.X;
        Bn256.Bn256AffinePoint memory U_comm_W = Bn256.decompress(proof.r_U_primary.comm_W);
        Bn256.Bn256AffinePoint memory U_comm_E = Bn256.decompress(proof.r_U_primary.comm_E);
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
        Grumpkin.GrumpkinAffinePoint memory f_U_secondary_comm_W;
        Grumpkin.GrumpkinAffinePoint memory f_U_secondary_comm_E;
        uint256[] memory f_U_secondary_X;
        uint256 f_U_secondary_u;

        (f_U_secondary_comm_W, f_U_secondary_comm_E, f_U_secondary_X, f_U_secondary_u) =
            Step3GrumpkinZeromorphLib.compute_f_U_secondary(proof, vk, poseidonConstantsSecondary);

        (transcriptSecondary, precomputeOutput.tau) = Step3GrumpkinZeromorphLib.compute_tau_secondary(
            proof,
            vk.vk_secondary,
            0x015e93fd40eb5b63f0aa65fbb8c93cd922caa158f4e334374f22f26958bcbeec,
            transcriptSecondary,
            f_U_secondary_comm_W,
            f_U_secondary_comm_E,
            f_U_secondary_X,
            f_U_secondary_u,
            printLogs
        );

        (transcriptSecondary, precomputeOutput.c) = Step3GrumpkinLib.compute_c_secondary(proof, transcriptSecondary);

        precomputeOutput.u_step3 = Step3GrumpkinLib.compute_u_secondary(proof, precomputeOutput.tau, precomputeOutput.c);

        (transcriptSecondary, precomputeOutput.gamma1) = Step3GrumpkinLib.compute_gamma_1_secondary(transcriptSecondary);
        (transcriptSecondary, precomputeOutput.gamma2) = Step3GrumpkinLib.compute_gamma_2_secondary(transcriptSecondary);

        (transcriptSecondary, precomputeOutput.rand_eq) =
            Step3GrumpkinZeromorphLib.compute_rand_eq_secondary(proof, vk, transcriptSecondary);

        (transcriptSecondary, precomputeOutput.coeffs) = Step3GrumpkinLib.compute_coeffs_secondary(transcriptSecondary);

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
