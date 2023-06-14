pragma solidity ^0.8.0;

import "@std/Test.sol";
import "src/verifier/step4/EqPolynomial.sol";
import "src/verifier/step2/Step2Data.sol";
import "src/verifier/step4/KeccakTranscript.sol";
import "src/pasta/Field.sol";

library InnerProductArgumentLib {
    uint24 private constant PROTOCOL_NAME = 0x495041;
    uint8 private constant ABSORB_U = 0x55;
    uint8 private constant SQUEEZE_r = 0x72;
    uint8 private constant ABSORB_L = 0x4c;
    uint8 private constant ABSORB_R = 0x52;
    uint8 private constant ABSORB_r = SQUEEZE_r;

    struct InnerProductInstance {
        CommitmentLib.Commitment comm;
        uint256[] b_vec;
        uint256 eval;
    }

    function precomputePPrimary(Pallas.PallasAffinePoint[] memory ck_c_input, uint256 r, InnerProductInstance memory u) private view returns (Pallas.PallasAffinePoint memory) {
        Pallas.PallasAffinePoint[] memory ck_c_output = scalePallas(ck_c_input, r); // Pallas

        uint256[] memory commit_scalars = new uint256[](1);
        commit_scalars[0] = u.eval;

        // let P = U.comm_a_vec + CE::<G>::commit(&ck_c, &[U.c]);
        Pallas.PallasAffinePoint memory P = Pallas.add(
            Pallas.IntoAffine(Pallas.PallasProjectivePoint(u.comm.X, u.comm.Y, u.comm.Z)),
            commitPallas(ck_c_output, commit_scalars)
        ); // Pallas

        return P;
    }

    function precomputePublicCoinVectorPrimary(KeccakTranscriptLib.KeccakTranscript memory transcript, uint256[] memory L_vec, uint256[] memory R_vec) private pure returns (KeccakTranscriptLib.KeccakTranscript memory, uint256[] memory) {
        uint256[] memory r_items = new uint256[](L_vec.length);
        uint256 r;
        uint8[] memory label = new uint8[](1);
        for (uint256 index = 0; index < L_vec.length; index++) {
            label[0] = ABSORB_L;
            transcript = KeccakTranscriptLib.absorb(transcript, label, Field.reverse256(L_vec[index]));

            label[0] = ABSORB_R;
            transcript = KeccakTranscriptLib.absorb(transcript, label, Field.reverse256(R_vec[index]));

            label[0] = SQUEEZE_r;
            (transcript, r) = KeccakTranscriptLib.squeeze(transcript, ScalarFromUniformLib.curveVesta(), label); // Vesta

            r_items[index] = r;
        }
        return (transcript, r_items);
    }

    function precomputeSinnerPrimary(uint256[]memory r_inverted, uint256[] memory r_squared, uint256 pointLength) private pure returns (uint256[] memory) {
        uint256 modulusVesta = Vesta.P_MOD;

        uint256 r_i;
        uint256 index;
        uint256 tmp = 1;
        uint256[] memory s = new uint256[](2 ** pointLength);
        for (index = 0; index < r_inverted.length; index++) {
            r_i = r_inverted[index];
            assembly {
                tmp := mulmod(tmp, r_i, modulusVesta)
            }
        }
        s[0] = tmp;


        uint256 pos_in_r = 0;
        uint256 i = 1;
        uint256 j_bound = 1;

        uint256 s_i;
        for (index = 1; index < pointLength + 1; index++) {
            for (uint256 j = 0; j < j_bound; j++) {
                s_i = s[i - (1 << pos_in_r)];
                r_i = r_squared[(pointLength - 1) - pos_in_r];
                assembly{
                    tmp := mulmod(s_i, r_i, modulusVesta)
                }
                s[i] = tmp;
                i++;
            }
            j_bound = 2 ** index;
            pos_in_r++;
        }
        return s;
    }

    function precomputeSPrimary(uint256[] memory r, uint256 pointLength) public view returns (uint256[]memory, uint256[]memory, uint256[] memory){
        uint256 modulusVesta = Vesta.P_MOD;
        uint256 tmp;
        uint256 r_i;
        uint256[] memory r_squared = new uint256[](r.length);

        uint256 index;
        for (index = 0; index < r_squared.length; index++) {
            r_i = r[index];
            assembly {
                tmp := mulmod(r_i, r_i, modulusVesta) // Vesta
            }
            r_squared[index] = tmp;
        }

        // Nova (in Rust) uses so-called batched inversion:
        // https://github.com/lurk-lab/Nova/blob/solidity-verifier/src/provider/ipa_pc.rs#L325,
        // which may be more performant
        uint256[] memory r_inverted = new uint256[](r.length);
        for (index = 0; index < r_inverted.length; index++) {
            r_inverted[index] = Pallas.invert(r[index], Pallas.R_MOD); // Pallas
        }

        uint256[] memory r_inverted_squared = new uint256[](r.length);
        for (index = 0; index < r_inverted_squared.length; index++) {
            r_i = r_inverted[index];
            assembly {
                tmp := mulmod(r_i, r_i, modulusVesta) // Vesta
            }
            r_inverted_squared[index] = tmp;
        }

        uint256[] memory s = precomputeSinnerPrimary(r_inverted, r_squared, pointLength);

        return (s, r_squared, r_inverted_squared);
    }

    function precomputeBhatPrimary(uint256[] memory b_vec, uint256[] memory s) private pure returns (uint256){
        uint256 modulusVesta = Vesta.P_MOD;

        uint256 b_vec_i;
        uint256 s_i;
        uint256 tmp;
        uint256 b_hat = 0;
        uint256 index;
        for (index = 0; index < s.length; index++){
            b_vec_i = b_vec[index];
            s_i = s[index];
            assembly {
                tmp := mulmod(b_vec_i, s_i, modulusVesta) // Vesta
                b_hat := addmod(b_hat, tmp, modulusVesta) // Vesta
            }
        }

        return b_hat;
    }

    function verifyPrimaryPart4(Pallas.PallasAffinePoint memory P_hat, Pallas.PallasAffinePoint memory ck_hat, Pallas.PallasAffinePoint memory ck_c, uint256 a_hat, uint256 b_hat) public view {
        uint256 msm_len = 2;
        Pallas.PallasAffinePoint[] memory bases = new Pallas.PallasAffinePoint[](msm_len);
        uint256[] memory scalars = new uint256[](msm_len);

        bases[0] = ck_hat;
        bases[1] = ck_c;

        scalars[0] = a_hat;

        uint256 modulusVesta = Vesta.P_MOD;
        assembly {
            a_hat := mulmod(a_hat, b_hat, modulusVesta) // Vesta
        }

        scalars[1] = a_hat;

        Pallas.PallasAffinePoint memory expected = Pallas.multiScalarMul(bases, scalars);

        require(P_hat.x == expected.x, "[InnerProductArgumentLib.verifyPrimaryPart4] unexpected P_hat.x");
        require(P_hat.y == expected.y, "[InnerProductArgumentLib.verifyPrimaryPart4] unexpected P_hat.y");
    }

    function verifyPrimaryPart3(uint256[] memory point, uint256[] memory r, uint256[] memory L_vec, uint256[] memory R_vec, Pallas.PallasAffinePoint memory P) public view returns (uint256, Pallas.PallasAffinePoint memory){
        // TODO: think over how to eliminate this two computations, since it was already computed while 'verifyPrimaryPart1' and 'verifyPrimaryPart2'
        uint256[] memory b_vec = EqPolinomialLib.evalsVesta(point); // Vesta
        (uint256[] memory s, uint256[] memory r_squared, uint256[] memory r_inverse_squared) = precomputeSPrimary(r, point.length);

        require(b_vec.length == s.length, "[InnerProductArgumentLib.verifyPrimaryPart3] InvalidInputLength: b_vec.length != s.length");

        uint256 b_hat = precomputeBhatPrimary(b_vec, s);

        Pallas.PallasAffinePoint[] memory ck_folded = new Pallas.PallasAffinePoint[](L_vec.length + R_vec.length + 1);
        uint256 msm_index = 0;
        uint256 index = 0;
        for (index = 0; index < L_vec.length; index++) {
            ck_folded[msm_index] = Pallas.decompress(L_vec[index]);
            msm_index++;
        }
        for (index = 0; index < R_vec.length; index++) {
            ck_folded[msm_index] = Pallas.decompress(R_vec[index]);
            msm_index++;
        }
        ck_folded[msm_index] = P;

        uint256[] memory P_hat_scalars = new uint256[](r_squared.length + r_inverse_squared.length + (ck_folded.length - r_squared.length - r_inverse_squared.length));
        msm_index = 0;
        for (index = 0; index < r_squared.length; index++) {
            P_hat_scalars[msm_index] = r_squared[index];
            msm_index++;
        }
        for (index = 0; index < r_inverse_squared.length; index++) {
            P_hat_scalars[msm_index] = r_inverse_squared[index];
            msm_index++;
        }
        for (index = 0; index < (ck_folded.length - r_squared.length - r_inverse_squared.length); index++) {
            P_hat_scalars[msm_index] = 1;
            msm_index++;
        }

        return (b_hat, Pallas.multiScalarMul(ck_folded, P_hat_scalars));
    }

    function verifyPrimaryPart2(KeccakTranscriptLib.KeccakTranscript memory transcript, uint256 pointLength, uint256[] memory L_vec, uint256[] memory R_vec, Pallas.PallasAffinePoint[] memory ck_full) public view returns (KeccakTranscriptLib.KeccakTranscript memory, uint256[] memory, uint256[] memory, uint256[] memory, Pallas.PallasAffinePoint memory){
        // Original assertion in Nova is '2 ** pointLength == 1 << L_vec.length' (https://github.com/lurk-lab/Nova/blob/solidity-verifier/src/provider/ipa_pc.rs#L309),
        // but it essentially means that 'pointLength' should be equal to 'L_vec.length'
        require(pointLength == L_vec.length, "[InnerProductArgumentLib.verifyPrimary] InvalidInputLength: pointLength != L_vec.length");
        require(L_vec.length == R_vec.length, "[InnerProductArgumentLib.verifyPrimary] InvalidInputLength: L_vec.length != R_vec.length");
        require(L_vec.length < 32, "[InnerProductArgumentLib.verifyPrimary] InvalidInputLength: L_vec.length >= 32");
        require(ck_full.length > 0, "[InnerProductArgumentLib.verifyPrimary] InvalidInputLength: ck_full.length <= 0");

        uint256[] memory r;
        (transcript, r) = precomputePublicCoinVectorPrimary(transcript, L_vec, R_vec);


        (uint256[] memory s, uint256[] memory r_squared, uint256[] memory r_inverted_squared) = precomputeSPrimary(r, pointLength);

        // TODO: Nova uses MSM with 2 ^ 14 points / scalars, which causes OutOfGas exception in EVM.
        // TODO: In current settings, with gas_limit = MAX, only 2 ^ 8 points / scalars is possible to use.
        //Pallas.PallasAffinePoint[] memory ck = new Pallas.PallasAffinePoint[](2 ** pointLength);
        //uint256[] memory s_tmp = new uint256[](2 ** pointLength / 64);
        //Pallas.PallasAffinePoint[] memory ck = new Pallas.PallasAffinePoint[](s_tmp.length);
        //for (uint256 i = 0; i < s_tmp.length; i++) {
        //    ck[i] = ck_full[i];
        //    s_tmp[i] = s[i];
        //}
        //return (transcript, s, r_squared, r_inverted_squared, Pallas.multiScalarMul(ck, s_tmp));

        return (transcript, s, r_squared, r_inverted_squared, Pallas.PallasAffinePoint(1, 1));
    }

    function verifyPrimaryPart1(KeccakTranscriptLib.KeccakTranscript memory transcript, uint256[] memory point, CommitmentLib.Commitment memory comm, uint256 eval, Pallas.PallasAffinePoint[] memory ck_c_input) public view returns (KeccakTranscriptLib.KeccakTranscript memory, Pallas.PallasAffinePoint memory){
        uint256[] memory b_vec = EqPolinomialLib.evalsVesta(point); // Vesta

        InnerProductInstance memory u = InnerProductInstance(comm, b_vec, eval);

        uint8[] memory protocolName = new uint8[](3);
        protocolName[0] = uint8((PROTOCOL_NAME >> 16) & 0xFF);
        protocolName[1] = uint8((PROTOCOL_NAME >> 8) & 0xFF);
        protocolName[2] = uint8(PROTOCOL_NAME & 0xFF);

        transcript = KeccakTranscriptLib.dom_sep(transcript, protocolName);

        require(u.b_vec.length == 2**point.length, "[InnerProductArgumentLib.verifyPrimary] InvalidInputLength: u.b_vec.length != 2**point.length");

        uint8[] memory label = new uint8[](1);
        label[0] = ABSORB_U;
        uint8[] memory input = innerProductInstanceToTranscriptBytesPallas(u); // Pallas

        transcript = KeccakTranscriptLib.absorbBytes(transcript, label, input);

        label[0] = SQUEEZE_r;

        uint256 r;
        (transcript, r) = KeccakTranscriptLib.squeeze(transcript, ScalarFromUniformLib.curveVesta(), label); // Vesta

        return (transcript, precomputePPrimary(ck_c_input, r, u));
    }

    function commitPallas(Pallas.PallasAffinePoint[] memory ck, uint256[] memory v) private view returns (Pallas.PallasAffinePoint memory) {
        // G::vartime_multiscalar_mul(v, &ck.ck[..v.len()])
        require(ck.length >= v.length, "[InnerProductArgumentLib.commitPallas] ck.length < v.length");
        Pallas.PallasAffinePoint[] memory bases = new Pallas.PallasAffinePoint[](v.length);
        for (uint256 index = 0; index < v.length; index++) {
            bases[index] = ck[index];
        }

        return Pallas.multiScalarMul(bases, v);
    }

    function scalePallas(Pallas.PallasAffinePoint[] memory ck_c, uint256 r) private view returns (Pallas.PallasAffinePoint[] memory){
        /*
            let ck_scaled = self
                .ck
                .clone()
                .into_par_iter()
                .map(|g| G::vartime_multiscalar_mul(&[*r], &[g]).preprocessed())
                .collect();
        */
        uint256 msm_index = 0;
        uint256[] memory scalars = new uint[](1);
        Pallas.PallasAffinePoint[] memory bases = new Pallas.PallasAffinePoint[](1);
        Pallas.PallasAffinePoint[] memory output = new Pallas.PallasAffinePoint[](ck_c.length);
        for (uint256 index = 0; index < ck_c.length; index++) {
            scalars[msm_index] = r;
            bases[msm_index] = ck_c[index];
            output[index] = Pallas.multiScalarMul(bases, scalars);
            msm_index++;
        }
        return output;
    }

    function affineCoordinatesToArray(uint256 x, uint256 y, uint256 eval) private pure returns (uint8[]memory) {
        uint8[] memory output = new uint8[](32 + 32 + 1 + 32);
        // handle infinity point case
        if (x == 0 && y == 0) {
            return output;
        }
        uint256 outputIndex = 0;
        // write x
        for (uint256 index = 0; index < 32; index++) {
            output[outputIndex] = uint8((x >> (index * 8)) & 0xFF);
            outputIndex++;
        }
        // write y
        for (uint256 index = 0; index < 32; index++) {
            output[outputIndex] = uint8((y >> (index * 8)) & 0xFF);
            outputIndex++;
        }

        // set byte indicating that point is not infinity, after writing coordinates
        output[outputIndex] = 0x01;
        outputIndex++;

        // write eval
        for (uint256 index = 0; index < 32; index++) {
            output[outputIndex] = uint8((eval >> (index * 8)) & 0xFF);
            outputIndex++;
        }

        return output;
    }

    function innerProductInstanceToTranscriptBytesPallas(InnerProductInstance memory c) public view returns (uint8[] memory) {
        Pallas.PallasAffinePoint memory cAffine = Pallas.IntoAffine(Pallas.PallasProjectivePoint(c.comm.X, c.comm.Y, c.comm.Z));
        return affineCoordinatesToArray(cAffine.x, cAffine.y, c.eval);
    }

    function innerProductInstanceToTranscriptBytesVesta(InnerProductInstance memory c) public view returns (uint8[] memory) {
        Vesta.VestaAffinePoint memory cAffine = Vesta.IntoAffine(Vesta.VestaProjectivePoint(c.comm.X, c.comm.Y, c.comm.Z));
        return affineCoordinatesToArray(cAffine.x, cAffine.y, c.eval);
    }
}