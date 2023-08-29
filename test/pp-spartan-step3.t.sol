// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.0;

import "@std/Test.sol";
import "src/blocks/pasta/Pallas.sol";
import "src/blocks/pasta/Vesta.sol";
import "src/blocks/EqPolynomial.sol";
import "src/blocks/KeccakTranscript.sol";
import "src/blocks/PolyEvalInstance.sol";
import "src/blocks/Sumcheck.sol";
import "src/NovaVerifierAbstractions.sol";

contract PpSpartanStep3Computations is Test {
    function check_claim_inner_final_expected(
        uint256 coeffs_9,
        uint256 self_eval_E_row,
        uint256 self_eval_E_col,
        uint256 self_eval_val_A,
        uint256 c_inner,
        uint256 self_eval_val_B,
        uint256 self_eval_val_C,
        uint256 claim_inner_final_expected
    ) private {
        uint256 actual;
        uint256 modulusPallas = Pallas.P_MOD;
        assembly {
            let tmp := mulmod(c_inner, c_inner, modulusPallas)
            tmp := mulmod(tmp, self_eval_val_C, modulusPallas)
            tmp := addmod(tmp, self_eval_val_A, modulusPallas)
            actual := mulmod(c_inner, self_eval_val_B, modulusPallas)
            actual := addmod(actual, tmp, modulusPallas)
            actual := mulmod(actual, self_eval_E_col, modulusPallas)
            actual := mulmod(actual, self_eval_E_row, modulusPallas)
            actual := mulmod(actual, coeffs_9, modulusPallas)
        }

        assertEq(actual, claim_inner_final_expected);
    }

    function check_final_step3_verification(
        uint256 claim_mem_final_expected,
        uint256 claim_outer_final_expected,
        uint256 claim_inner_final_expected,
        uint256 claim_sat_final
    ) private {
        uint256 modulusPallas = Pallas.P_MOD;
        uint256 actual = addmod(
            addmod(claim_mem_final_expected, claim_outer_final_expected, modulusPallas),
            claim_inner_final_expected,
            modulusPallas
        );

        assertEq(actual, claim_sat_final);
    }

    function check_claim_outer_final_expected(
        uint256 coeffs_8,
        uint256 taus_bound_r_sat,
        uint256 self_eval_Az,
        uint256 self_eval_Bz,
        uint256 U_u,
        uint256 self_eval_Cz,
        uint256 self_eval_E,
        uint256 claim_outer_final_expected
    ) private {
        uint256 modulusPallas = Pallas.P_MOD;
        uint256 actual = mulmod(U_u, self_eval_Cz, modulusPallas);
        actual = Pallas.negateBase(actual);
        uint256 minus_self_eval_E = Pallas.negateBase(self_eval_E);
        assembly {
            let tmp := mulmod(self_eval_Az, self_eval_Bz, modulusPallas)
            tmp := addmod(tmp, minus_self_eval_E, modulusPallas)
            actual := addmod(actual, tmp, modulusPallas)
            actual := mulmod(actual, taus_bound_r_sat, modulusPallas)
            actual := mulmod(actual, coeffs_8, modulusPallas)
        }
        assertEq(actual, claim_outer_final_expected);
    }

    function check_claim_mem_final_expected(
        uint256 rand_eq_bound_r_sat,
        uint256[] memory coeffs,
        uint256[] memory eval_left_arr,
        uint256[] memory eval_right_arr,
        uint256[] memory eval_output_arr,
        uint256 claim_mem_final_expected
    ) private {
        uint256 len = 8;
        require(coeffs.length == len);
        require(eval_left_arr.length == len);
        require(eval_right_arr.length == len);
        require(eval_output_arr.length == len);

        uint256 modulusPallas = Pallas.P_MOD;

        uint256 actual;

        uint256 coeffs_item;
        uint256 eval_left_arr_item;
        uint256 eval_right_arr_item;

        uint256 tmp;
        for (uint256 index = 0; index < len; index++) {
            coeffs_item = coeffs[index];
            eval_left_arr_item = eval_left_arr[index];
            eval_right_arr_item = eval_right_arr[index];
            tmp = Pallas.negateBase(eval_output_arr[index]);
            assembly {
                let tmp1 := mulmod(eval_left_arr_item, eval_right_arr_item, modulusPallas)
                tmp1 := addmod(tmp1, tmp, modulusPallas)
                tmp1 := mulmod(tmp1, rand_eq_bound_r_sat, modulusPallas)
                tmp1 := mulmod(tmp1, coeffs_item, modulusPallas)
                actual := addmod(actual, tmp1, modulusPallas)
            }
        }

        assertEq(actual, claim_mem_final_expected);
    }

    function check_rand_eq_bound_r_sat(uint256[] memory r, uint256[] memory rx, uint256 rand_eq_bound_r_sat) public {
        require(r.length == rx.length);
        assertEq(rand_eq_bound_r_sat, EqPolinomialLib.evaluate(r, rx, Pallas.P_MOD, Pallas.negateBase));
    }

    function testFinalStep3Verification() public {
        uint256 claim_mem_final_expected = 0x05d06b1baa19c95a2f5b0cda10585ac6380eebf0b4526f5ba1abb2d80d36f396;
        uint256 claim_outer_final_expected = 0x2f323c788b0d9138ba80b6c93162c20bd230dcad68209bc523152ec3b57d0c5a;

        uint256 coeffs_9 = 0x0082b3fee7e08d0875839ed964a59b3d8890f3cc8c99951135bab451e481de45;
        uint256 self_eval_E_row = 0x005497eef16105a1131cf3aa93ad21559b45da5348d16a767a14bb3230791bc1;
        uint256 self_eval_E_col = 0x08e3e6ca6242951435f79a117fd229613e2de4a2038b530f04788e35ad298442;
        uint256 self_eval_val_A = 0x2d0b4b68536b9e808c633cf9cf0b2dd7bc50323497bd8da52c62829458e9cffa;
        uint256 c_inner = 0x0b997b6ffdc3ec15ffa942ce26cb2144184c7e88eaa29770a3061b22c062ea1e;
        uint256 self_eval_val_B = 0x00a4606a4306ae6398aaead1738624314fb48672c0e63643187a81d03e38b818;
        uint256 self_eval_val_C = 0x23a31846a3fcab9f5feea6ae88850868a6e50ad38c16dfc7c9e702ec20bba75f;

        uint256 claim_inner_final_expected = 0x2ad31f8f81c90ba58ee098a7ef2bfd7d8755651c837777432bfca54fba461d2f;
        check_claim_inner_final_expected(
            coeffs_9,
            self_eval_E_row,
            self_eval_E_col,
            self_eval_val_A,
            c_inner,
            self_eval_val_B,
            self_eval_val_C,
            claim_inner_final_expected
        );

        uint256 claim_sat_final = 0x1fd5c723b6f0663878bc5c4b30e71a4f6f4e94be969d8948579055fe7cfa1d1e;
        check_final_step3_verification(
            claim_mem_final_expected, claim_outer_final_expected, claim_inner_final_expected, claim_sat_final
        );
    }

    function test_claim_outer_final_expected_computation() public {
        uint256 coeffs_8 = 0x0f93dbcda1deaf626a43adb3c60580f16d6b319032efe5d9bcc56227b04db6a5;
        uint256 taus_bound_r_sat = 0x22f427ab378ad36181e799afb461c7959e81ead14d9cbb1cf817c3799fbdeaf1;
        uint256 self_eval_Az = 0x38948ca0462a02bdb53b1901fe38b628d211950f7ec0253e4077d6ca8e46ea80;
        uint256 self_eval_Bz = 0x0beb527e566ceb01dd437d13a42c9bd51fade27bb530bd8af14bb762ab40761e;
        uint256 U_u = 0x00000000000000000000000000000001be290d4c014dff424259e57be62191c4;
        uint256 self_eval_Cz = 0x1950e09255fee2c8de78a7efc81d13cfff43a5ef5eda973788b297020c8dd8c6;
        uint256 self_eval_E = 0x230f7c5a5c32e6b78dfc1dc1c0fe06baae7fd45a912733b1cf52521d2a78bfc2;
        uint256 claim_outer_final_expected = 0x2f323c788b0d9138ba80b6c93162c20bd230dcad68209bc523152ec3b57d0c5a;

        check_claim_outer_final_expected(
            coeffs_8,
            taus_bound_r_sat,
            self_eval_Az,
            self_eval_Bz,
            U_u,
            self_eval_Cz,
            self_eval_E,
            claim_outer_final_expected
        );
    }

    function test_claim_mem_final_expected_computation() public {
        uint256 rand_eq_bound_r_sat = 0x08fa71bd727e1f0539be7441ee184c610e4012207be66fc1fc948b009aa7cb84;

        uint256[] memory coeffs = new uint256[](8);
        uint256[] memory eval_left_arr = new uint256[](8);
        uint256[] memory eval_right_arr = new uint256[](8);
        uint256[] memory eval_output_arr = new uint256[](8);

        coeffs[0] = 0x24abec2a07d73e7f6aa8c47c41c545063724e664fc177870725a479a48296c45;
        eval_left_arr[0] = 0x147f44b4f49104ea3e17c46501eee96c38b17420cfcb4dbff6125e839cd2dc98;
        eval_right_arr[0] = 0x1d30c0feed53c5159359c12bd56c50187c1ccee0804e38bb72d85c557084eb30;
        eval_output_arr[0] = 0x1d8d0419087973cb02a3c2b0c151eb1ebd4ad532f0944c03509c5b672ee492c3;

        coeffs[1] = 0x252a854862eb46096810a4a4a9f35c0e40a12ea0ec1960d95626f2657a6a0422;
        eval_left_arr[1] = 0x232136b762e2981a8e8b620e6d06d516fd0aaef3be4db2aa11df469787dc9ff6;
        eval_right_arr[1] = 0x0a3dd62ec7710052c2d8b910c3d50895dd88068fd086143fcd7ddc77a0e20483;
        eval_output_arr[1] = 0x034d3e85e320aa7efdd807ff2bf0045aa0f8dc06ef9eea0e9ebc6336aa8da0ff;

        coeffs[2] = 0x03d733614e8f8b22b7a014ddbaf7108a8b99575a73543fb38850fd59e5d26b65;
        eval_left_arr[2] = 0x1cc43b30ada6c2048fd37949db1accb437b464f5076ffd3e831899ca0e7ba348;
        eval_right_arr[2] = 0x0b9d03d2a9ebe77c68d8d9fbe633ad3a220995f87555248edef27cc5880e8235;
        eval_output_arr[2] = 0x3b0a0751147350ff22d399dd19bf54b0393ffc6a88b82192a9ddaabb3998e3af;

        coeffs[3] = 0x26a82b7b3206cd44937ae80cb33d69f9e5ca95c456b92d0b4865d24a3850de3f;
        eval_left_arr[3] = 0x23df3f6ffdd66ddd7919ae7fb7bf2f4abd1630c24fcf1a233f2cc1844bddd24e;
        eval_right_arr[3] = 0x31576c56e0927b45323fd02aabfe5a77d1ec1d06fe146440adb34bbffeb21310;
        eval_output_arr[3] = 0x25bb0fba5fcbb5830c92cfaef2d6f2085eb4e5660214cf3513390236aaad6bbb;

        coeffs[4] = 0x2722c59f6520030025c43aa9e486b5f0fee7e190f6751674328b28828227957a;
        eval_left_arr[4] = 0x26a4428b87c121e12ddcdf5b885cf8d8d340e5e19281a3d74772f860e293c1e9;
        eval_right_arr[4] = 0x1352bc60c8bc4319c2d97065fc4eadeafb0f566d4e0635f6ad5fb462d4426605;
        eval_output_arr[4] = 0x20b253e21f96b20a29cc1fdd073a4a654fadd4e160735e988aaebfe343e1631c;

        coeffs[5] = 0x3cdff180a4b073740aeacc97898517c3cfa3b750827902d4b28bd583d1eeb77d;
        eval_left_arr[5] = 0x3817aeae1fe8406de02bcc39db14a938344a14ccc2f93c9365c41b43a0a44198;
        eval_right_arr[5] = 0x0a356cb567b8b9f61f3f26ee28f8d07274d4d1296fc682ce45af58a31596870e;
        eval_output_arr[5] = 0x26eda459228ba2c75d3cab4b01c9b396f0b750247e56c573dd2599ad312ad7b8;

        coeffs[6] = 0x12dada10e0a1bd16bb48b32c39f644188987784e0ca26dbf0e1a5db5721357e6;
        eval_left_arr[6] = 0x0ccff52e09e4e4c14eeaf3fe380c30e5b5e60fcb526abea502a4b14ff3199847;
        eval_right_arr[6] = 0x0103bc38a0b33f6c9ad0a9609ee1cf7e25d1fb5486c4d13fbe68d7d24a4e50de;
        eval_output_arr[6] = 0x209c4af8f703136125eb474143c5052cc5c206ef983377265fba782091b040f3;

        coeffs[7] = 0x0ae9211366b88ba710f1b05e0b5d961eebbf59c205e5dbc9384b93c195dd357c;
        eval_left_arr[7] = 0x0dac2ac3dea7fe9bda6bdd1ed9f0d01606fa41dcfb8e7531d9d466f25143f761;
        eval_right_arr[7] = 0x044251dcd2cb228142cef3294b52dfb9f2f4bbced579fdc823ac1d60dc07b167;
        eval_output_arr[7] = 0x0f32b713bef952f9209a9dffc863d9265198387b13b25e17c7cef80450c79cd8;

        uint256 claim_mem_final_expected = 0x05d06b1baa19c95a2f5b0cda10585ac6380eebf0b4526f5ba1abb2d80d36f396;
        check_claim_mem_final_expected(
            rand_eq_bound_r_sat, coeffs, eval_left_arr, eval_right_arr, eval_output_arr, claim_mem_final_expected
        );
    }

    function test_rand_eq_bound_r_sat_computation() public {
        uint256[] memory r_sat = new uint256[](17);
        r_sat[0] = 0x0c6d2bf540a735934ae40e93560708b56f4452a1b9c6ad435bcc5a3d718d636c;
        r_sat[1] = 0x12356e9d5716fbc87d57127bf033d6c944a469d3594be6690ebea874852df9a2;
        r_sat[2] = 0x11920f58b99610ea1e7df2b95803ac51e568be3261d8c57e53c5e7232b6a8100;
        r_sat[3] = 0x07669895060aa6d19a26a3ca15b66c653f057411e3e249ad032bd4c3d454dd2c;
        r_sat[4] = 0x1529ed49bcf02d198015331aaceda91523d4cb6480bf88ece2b9fdcb7455318d;
        r_sat[5] = 0x1a143c3ea3b03de4235858e759e5a5f145becbe09e73034bc5deae7b448dafcd;
        r_sat[6] = 0x33b78932e8c0a8560c559f8c6ffb88f47355f01af8d4db106cbfd0bb6813b48f;
        r_sat[7] = 0x28137caa1e6c94ba725683445a2fda31dde080460f1194927ea3d705e4a2b4cc;
        r_sat[8] = 0x2a1dc1db6e9d737c435c9c5f1e99a82ef22909045565c1d3d4a70e7f3476ddd0;
        r_sat[9] = 0x1980c374b3934f56f94174320f07a2086f723271f06ec0341619e804fe0af261;
        r_sat[10] = 0x3c13da89c92bed75f7441764335289c8688dbaad7592ffa27fc4af6c76234b9a;
        r_sat[11] = 0x0821d484a68f72a551207bf5a27a57dddbe4f6c1352fce1210ac8139c5b4b423;
        r_sat[12] = 0x1d70c72ceb8af51ff89f5b520643d1dcc35393e1255e9476b7ad4987324c467a;
        r_sat[13] = 0x1cbcf9e4c122e494679ad733c241d0e908d2a3c9fdb65cafea3a8c6ff72e2517;
        r_sat[14] = 0x0ef3b3e72135c28d158b117f3733d291c4789c2ac9c754bfe1e90a8fc5fbb208;
        r_sat[15] = 0x17e5a84f6bbdd8e53f5ec117374d39b6a23fe37a58571e95da5b4c1820608245;
        r_sat[16] = 0x3492aaf8252e21df8a00c0febe0c2c2476008b7210edc742afd161f7439adb4f;

        uint256[] memory rand_eq = new uint256[](17);
        rand_eq[0] = 0x27aabc1f9396c2df912a57e820d33667cd6faf59faff531e15b5bca62a921b70;
        rand_eq[1] = 0x1524b2421bd0dd7b069a6b49dee90441eda59d60b20a55aa4258680fbcaa85e1;
        rand_eq[2] = 0x00e5845d3b1936d72023ad3a8689f2964a98c03c2c78fc7f425e0f4f96e18213;
        rand_eq[3] = 0x1f8ba1693f2a89256bda343c8b3d3860567d0a92d44d2fe6f7bbfd84bd57f0a1;
        rand_eq[4] = 0x23ed0a59c496ce4f398e5220c1303c8306c0ff9e771a8f96cd2c2f2dcccd3b5c;
        rand_eq[5] = 0x2ec3b5d5d2abecc598a40e22a9dfee72f84daeeeef3a83c5578c1b3914ad50f0;
        rand_eq[6] = 0x2970d36138f1f017849739810a4b75ee69bdb6b12e0cee98569a44b9aeb99385;
        rand_eq[7] = 0x158b34cfc9d5d307a456510bc983e3347250f299c27e256973c49dc202837667;
        rand_eq[8] = 0x3b0f02de0d028ce268b67b86a229233605fd773f49023b7e35a58744b071d80a;
        rand_eq[9] = 0x1a8273e3ab009d5d0bfe641e757d165512e9cbbe7687a0609fed8a992a5efab7;
        rand_eq[10] = 0x221cfbd667abec54452af2f875e418042135782375eafb8ea3d734b527678acb;
        rand_eq[11] = 0x1a0d3935eb3ff77c80afbbe601a222c84e75291e4dc14e2c89398d8c728a9e1e;
        rand_eq[12] = 0x1b36747432801cf05c1592a4e1e812983c4bf5fa7d9e64d4a044cc14fadb3c09;
        rand_eq[13] = 0x1114d3c08a5ca3fdfe361d6cb328af82e6d9a2f164c88b106376643dcaea24a3;
        rand_eq[14] = 0x343e36767bcd4cbfb305e132161f6ce70c1855edfdb43f785bebe23fda134c2f;
        rand_eq[15] = 0x1e6e2af1f5c6431acdd75b6a5e891ed8cf8f986fc57ee6d8612d57fb2e7e9a09;
        rand_eq[16] = 0x331dc38b0812198ddcd60fd252fd19f91a0485c826c58a07480ad75876cf44b1;

        uint256 rand_eq_bound_r_sat = 0x08fa71bd727e1f0539be7441ee184c610e4012207be66fc1fc948b009aa7cb84;
        check_rand_eq_bound_r_sat(rand_eq, r_sat, rand_eq_bound_r_sat);
    }

    function loadInputForTau()
        private
        view
        returns (
            uint256,
            Abstractions.RelaxedR1CSInstance memory,
            Vesta.VestaAffinePoint memory,
            Vesta.VestaAffinePoint memory,
            Vesta.VestaAffinePoint memory
        )
    {
        uint256 vk_digest = 0x02fd7ec2a0975eb3c0e7cec9284b737d72e8eb4b77906ee1fe1439f47e8c2864;

        uint256 comm_Az = 0x30880d50c7abf9334ea5774be9c0471dd4f4a9b5e6034559076812aa1db69fb9;
        uint256 comm_Bz = 0xa48247f0746d1101c890f5c7dfb9fc6fa8dab5ba240e708d0d7991346424eaad;
        uint256 comm_Cz = 0x322cd251f864d29d23cbedaa0886fa5ca581f61d1c74ed6d5e5ba26bc918a191;
        //uint256 comm_E_row = 0xf12f26ac716736e7517e42b7db3807f9f7fd5c22f7adeb2a3141042e60de7b34;
        //uint256 comm_E_col = 0xb1d7f3abb6e94115a9cf21b2d84b74beb0ba412b8ab83805eda0f41b8871c825;

        Vesta.VestaAffinePoint memory comm_Az_decompressed = Vesta.decompress(comm_Az);
        Vesta.VestaAffinePoint memory comm_Bz_decompressed = Vesta.decompress(comm_Bz);
        Vesta.VestaAffinePoint memory comm_Cz_decompressed = Vesta.decompress(comm_Cz);
        //Vesta.VestaAffinePoint memory comm_E_row_decompressed = Vesta.decompress(comm_E_row);
        //Vesta.VestaAffinePoint memory comm_E_col_decompressed = Vesta.decompress(comm_E_col);

        uint256[] memory X = new uint256[](2);
        X[0] = 0x1db2c0c8e0e4c94b326d04f9d69a496737eaa2852f693492700c6847a35726f2;
        X[1] = 0x0b5b6a092d6d8406a62579e1cc2dc0b209c821e13fc3f2e846ecb90659ad413f;

        // f_U_secondary
        Abstractions.RelaxedR1CSInstance memory U = Abstractions.RelaxedR1CSInstance(
            0x026f01a19cba6322e4e5cd0cdabe33f63912b1a4d027bf83ce3bc243ceb3d8a0,
            0xf683c96c795e436f971c676506780b0d78387bfb97c75abddb590ec701ae9711,
            X,
            0x00000000000000000000000000000001be290d4c014dff424259e57be62191c4
        );

        return (vk_digest, U, comm_Az_decompressed, comm_Bz_decompressed, comm_Cz_decompressed);
    }

    function loadTranscript() private pure returns (KeccakTranscriptLib.KeccakTranscript memory) {
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

        KeccakTranscriptLib.KeccakTranscript memory transcript = KeccakTranscriptLib.instantiate(init_input);
        return transcript;
    }

    function loadInputForU()
        private
        view
        returns (Vesta.VestaAffinePoint[] memory, Vesta.VestaAffinePoint[] memory, uint256[] memory)
    {
        uint256 comm_Az = 0x30880d50c7abf9334ea5774be9c0471dd4f4a9b5e6034559076812aa1db69fb9;
        uint256 comm_Bz = 0xa48247f0746d1101c890f5c7dfb9fc6fa8dab5ba240e708d0d7991346424eaad;
        uint256 comm_Cz = 0x322cd251f864d29d23cbedaa0886fa5ca581f61d1c74ed6d5e5ba26bc918a191;

        uint256 comm_E_row = 0xf12f26ac716736e7517e42b7db3807f9f7fd5c22f7adeb2a3141042e60de7b34;
        uint256 comm_E_col = 0xb1d7f3abb6e94115a9cf21b2d84b74beb0ba412b8ab83805eda0f41b8871c825;

        Vesta.VestaAffinePoint[] memory comms_A_B_C = new Vesta.VestaAffinePoint[](3);
        comms_A_B_C[0] = Vesta.decompress(comm_Az);
        comms_A_B_C[1] = Vesta.decompress(comm_Bz);
        comms_A_B_C[2] = Vesta.decompress(comm_Cz);

        Vesta.VestaAffinePoint[] memory comms_E = new Vesta.VestaAffinePoint[](2);
        comms_E[0] = Vesta.decompress(comm_E_row);
        comms_E[1] = Vesta.decompress(comm_E_col);

        uint256[] memory evals = new uint256[](3);
        evals[0] = 0x03ceb0495f19505b379b535efae65b4aff31add3f912304bcc92df3ea5aae3d9;
        evals[1] = 0x2183da210706e672e013cfde880e41bf49dc13f12ab15a5741bd7d0d2adcab27;
        evals[2] = 0x16b1a33f9c928dce78632e3b85f165cb349011f4431d8e8aeda66956471adb0b;

        return (comms_A_B_C, comms_E, evals);
    }

    function log2(uint256 x) public pure returns (uint256 y) {
        assembly {
            let arg := x
            x := sub(x, 1)
            x := or(x, div(x, 0x02))
            x := or(x, div(x, 0x04))
            x := or(x, div(x, 0x10))
            x := or(x, div(x, 0x100))
            x := or(x, div(x, 0x10000))
            x := or(x, div(x, 0x100000000))
            x := or(x, div(x, 0x10000000000000000))
            x := or(x, div(x, 0x100000000000000000000000000000000))
            x := add(x, 1)
            let m := mload(0x40)
            mstore(m, 0xf8f9cbfae6cc78fbefe7cdc3a1793dfcf4f0e8bbd8cec470b6a28a7a5a3e1efd)
            mstore(add(m, 0x20), 0xf5ecf1b3e9debc68e1d9cfabc5997135bfb7a7a3938b7b606b5b4b3f2f1f0ffe)
            mstore(add(m, 0x40), 0xf6e4ed9ff2d6b458eadcdf97bd91692de2d4da8fd2d0ac50c6ae9a8272523616)
            mstore(add(m, 0x60), 0xc8c0b887b0a8a4489c948c7f847c6125746c645c544c444038302820181008ff)
            mstore(add(m, 0x80), 0xf7cae577eec2a03cf3bad76fb589591debb2dd67e0aa9834bea6925f6a4a2e0e)
            mstore(add(m, 0xa0), 0xe39ed557db96902cd38ed14fad815115c786af479b7e83247363534337271707)
            mstore(add(m, 0xc0), 0xc976c13bb96e881cb166a933a55e490d9d56952b8d4e801485467d2362422606)
            mstore(add(m, 0xe0), 0x753a6d1b65325d0c552a4d1345224105391a310b29122104190a110309020100)
            mstore(0x40, add(m, 0x100))
            let magic := 0x818283848586878898a8b8c8d8e8f929395969799a9b9d9e9faaeb6bedeeff
            let shift := 0x100000000000000000000000000000000000000000000000000000000000000
            let a := div(mul(x, magic), shift)
            y := div(mload(add(m, sub(255, a))), shift)
            y := add(y, mul(256, gt(arg, 0x8000000000000000000000000000000000000000000000000000000000000000)))
        }
    }

    function loadInputForCoeffsComputation()
        private
        view
        returns (Vesta.VestaAffinePoint[] memory, uint256[] memory, uint256)
    {
        Vesta.VestaAffinePoint[] memory comm_output_vec = new Vesta.VestaAffinePoint[](8);
        comm_output_vec[0] = Vesta.decompress(0x0a9b9b7ee032335d0a85236cd6efb0c1bb8351a1e12c70f1c5a76f48765ed2b6);
        comm_output_vec[1] = Vesta.decompress(0x867afb36f39dbf8faf84537a2e85c9008ebdddb93252936ff1fedd8603ac59ab);
        comm_output_vec[2] = Vesta.decompress(0x7b505036e82a3cd9d886cff311f664cbd55759fe3ef7bc7190e6343c4d3bac0c);
        comm_output_vec[3] = Vesta.decompress(0xd4b4297f4dce110e2f754d3dfb075bceac114a23b33275b35867eb8896f4b48e);
        comm_output_vec[4] = Vesta.decompress(0xde20988496bedc6544dbae8bca7ee4ef2d0130facb6375aac5e45deb2745fc1b);
        comm_output_vec[5] = Vesta.decompress(0xdd89cf6e483488991d713fcb7a872f17d5c952ac40d160626088235c59ba8681);
        comm_output_vec[6] = Vesta.decompress(0x03731a63eacddcf5d0629c3847eda49e806e6d3793a1f841a186c35f7b57c2a3);
        comm_output_vec[7] = Vesta.decompress(0x4d296b374f831ec4034953ace07dfe058404b50903f20569df99d2b7b6df6d9b);

        uint256[] memory claims_product_arr = new uint256[](8);
        claims_product_arr[0] = 0x13568ef1e6b2ca18ad197b05b83f9743f6193af87787186b3989d88361bed329;
        claims_product_arr[1] = 0x29f9cf21fb46f6dd5a9016044996a5110d2ae6522ab7142808413b3e20e00a80;
        claims_product_arr[2] = 0x3dd58d85d252507166814c5ee670f40e232c38844b41d72ea1d5e66e1f7cdd47;
        claims_product_arr[3] = 0x1e0bd5b1fc3358d9d62e47b0c6bcc4299f35b716720f3ee96de3531ab0af1c49;
        claims_product_arr[4] = 0x065b4666ee07456d3460d15425cfd579d842175d4240d2feb40cf57fb1176c4c;
        claims_product_arr[5] = 0x12904bdd1583fb18c0c5288c0ed986db7d13805ad724cdb9687e02a6a5feea51;
        claims_product_arr[6] = 0x21fe4f39d1763b38e056287c23d81790d8a816f24dd63aaa50377ffea2fc8c8f;
        claims_product_arr[7] = 0x3358146ed220ece61c4e54a94aee5714c6283d5e284a5598082b4127f35296a3;

        return (comm_output_vec, claims_product_arr, 131072);
    }

    function loadSumcheckProof() private pure returns (PolyLib.SumcheckProof memory) {
        PolyLib.CompressedUniPoly[] memory polys = new PolyLib.CompressedUniPoly[](17);

        uint256[] memory poly = new uint256[](3);
        poly[0] = 0x20b50e70008947fa3e7cf31b7879a79d2a6cb936ee78652882af5b4f0843af27;
        poly[1] = 0x1c8a5e1b802c923dc62493963c5d1776588da8d8c4d789b6efb3494a1be430ba;
        poly[2] = 0x155dc63bd05051f6c7ec858ee4290eaed9ccd56a23de611923f0915e6ba50863;
        polys[0] = PolyLib.CompressedUniPoly(poly);

        poly = new uint256[](3);
        poly[0] = 0x1722d665c8b674b29fee4cacf2128b3446bf58a1937e6f93d10bbb10954869d8;
        poly[1] = 0x0c16d59c075ab2b1921cd2754d30b46d4e7156ee62680a023b5d3c5ae4e5f7d3;
        poly[2] = 0x0a571049df2765ac8884753fdaa39da56b699459ebbc88958f5d74454518fa4d;
        polys[1] = PolyLib.CompressedUniPoly(poly);

        poly = new uint256[](3);
        poly[0] = 0x1202fb6428a95bc5b1f87e9813160e74221eb95df659fcd8b73c4c98b97a79db;
        poly[1] = 0x15b9a81e65d0ee323f44863900f43efb6ef2f24e03c6685f93e4bd2eb8c36886;
        poly[2] = 0x17ecee38240c58c9deef0ed1cf24b5962b43d1f01e1350c10397288bbcf01507;
        polys[2] = PolyLib.CompressedUniPoly(poly);

        poly = new uint256[](3);
        poly[0] = 0x1b50b5eebf96664daa727b1fdce643c19a8ad5be951c801dcc4b8d2a1a6dc6bc;
        poly[1] = 0x37f9e9889de00ca26e7ba98e3925addbb0eb8852b98850b37e2c265e1aa7e72c;
        poly[2] = 0x20bb71ce71b550cf2626915fea263ac96885be0257182b16077011796a203e43;
        polys[3] = PolyLib.CompressedUniPoly(poly);

        poly = new uint256[](3);
        poly[0] = 0x16e2cac1bdf829885d539ee5b7c410854a1c35efe8c5fea9d483e00d1874b956;
        poly[1] = 0x22a97a6cfbbf12dd48bab46cdee27fe87e07f4183f02e395fce5409222573ed7;
        poly[2] = 0x14649b4342de18b1ee87663b7e601914d70d353ba457269fa7b1c2f22a5683df;
        polys[4] = PolyLib.CompressedUniPoly(poly);

        poly = new uint256[](3);
        poly[0] = 0x1eba988f3bae3989689183e5892e54c733d371512d7fa6e7ca96e234ae814703;
        poly[1] = 0x23e415d03e9a88490016b2a8f1250284a761d4e23d725155644b78418d0ec480;
        poly[2] = 0x037639dcfe26f8611d59fd35fbe2604144adeaaba1fd4ed20516dfc68f97e555;
        polys[5] = PolyLib.CompressedUniPoly(poly);

        poly = new uint256[](3);
        poly[0] = 0x271845cc4a34c8239bca21878cadf6e153aea6e6613c9417544e965c77e68b2f;
        poly[1] = 0x2b1b2b85d76899a09c94065fd905a04e24bb5846b571ce8e84025228c652cd3c;
        poly[2] = 0x3158a16fc57057376152300765a25bd8e57031756127e08d8cb6eb8345d2e496;
        polys[6] = PolyLib.CompressedUniPoly(poly);

        poly = new uint256[](3);
        poly[0] = 0x3a6bd6ff394ba34080fadeccc2b1fca8f54662bf9e616f8c3f222032d043183f;
        poly[1] = 0x17154c665912ea4a65aefd6df3e0f1e28234dabef5c94a6339914b3a21da3a57;
        poly[2] = 0x0f3dd782a603a7d3c0432bd22393ec7c7b86a7c11e08c75f5eb0d97481c54c93;
        polys[7] = PolyLib.CompressedUniPoly(poly);

        poly = new uint256[](3);
        poly[0] = 0x3120fafb0faab0e46f3f5f83489c661a4207ce1377486df1556f354f2621f202;
        poly[1] = 0x21b67bbd9fb8209d726a88a27771ae7c18231d6639b83fa8af37347c5e713b21;
        poly[2] = 0x19a4e9c0bfa88d55cfcc01f808fc63447e9640572ef5ff226c25bc45f82f0281;
        polys[8] = PolyLib.CompressedUniPoly(poly);

        poly = new uint256[](3);
        poly[0] = 0x098ec732bd60824332e143497ce89c98794f5ee0efe42c09e7efc0251ce98705;
        poly[1] = 0x35212dea247fd17641453c5e0996e6acf1263f34849774ff174771423610c025;
        poly[2] = 0x146d3ba8bf33ab2f1a768a0e095b125c5d8ca050eb37574a851188700c3439b1;
        polys[9] = PolyLib.CompressedUniPoly(poly);

        poly = new uint256[](3);
        poly[0] = 0x0ad02dc3c28e324dc03290cd6ecf9b6d068b59a2b22ceb142061f2635bb25e58;
        poly[1] = 0x2795a023718a873e6513a5ce61f39378f3910f91a11ebf562cb997bdf274e131;
        poly[2] = 0x3e27eaa8738a4336c7ef065781fdb5acf4cfc11b4fd879c242b11b07c960b177;
        polys[10] = PolyLib.CompressedUniPoly(poly);

        poly = new uint256[](3);
        poly[0] = 0x2a524aae155898eb2727162b2a32a4899da0ff4f73d90fc43483833f542c2057;
        poly[1] = 0x2eb52b0303083a56157096d56fb694c3164903c3eb599fd5d096d6a7411e3ba0;
        poly[2] = 0x3e47d63ec4a2647074ba2b4a1b5f4199d9c43bd574870b4f6065bebf5779381b;
        polys[11] = PolyLib.CompressedUniPoly(poly);

        poly = new uint256[](3);
        poly[0] = 0x0f6946ab4a194d9c3d8d6aea0cba48a2a1f1ae6063bc0ebdceba7cfd845b0f9d;
        poly[1] = 0x3a021fc94ca304273d013734de6ccc85ab92deb5019fa3670d9f04afd295be38;
        poly[2] = 0x07a9dcb4437386edbe51d3d46938f41a76a92d5b32882b7c4d336f4891d53ed8;
        polys[12] = PolyLib.CompressedUniPoly(poly);

        poly = new uint256[](3);
        poly[0] = 0x3d8db47f52a2e88071c1c24125da7587c39a5d9d6d637e97363c7f81578538c7;
        poly[1] = 0x03f5d7a7d937ba08f73525dfce3498001ba290ead911118f57063a3c8062ad3a;
        poly[2] = 0x1209e1b3ad1e0f5c89f8f0c083c43a69c16b744e33989452a37dba23b941883a;
        polys[13] = PolyLib.CompressedUniPoly(poly);

        poly = new uint256[](3);
        poly[0] = 0x16b3a3cc6d6e4a9118e3d7b92b355c31a9fb38ddde523896768d05f241515a4b;
        poly[1] = 0x39a60e31decb6c9a26ceb94bcf0c3f0183788f8167c81942068210cac4d4f950;
        poly[2] = 0x26ceba6ece7073de90a7b4cf62d2c718660717c23994de9451fa6f2c4b22b311;
        polys[14] = PolyLib.CompressedUniPoly(poly);

        poly = new uint256[](3);
        poly[0] = 0x2393f4eaf35f6f4190668c5b8bdc5cf8dddb7ebbeab412e6b272e7a321467467;
        poly[1] = 0x2b2c1f6a766658407b8f15bcfe07ef58d5075a7fba71e5e1eb7d8dc0b288df79;
        poly[2] = 0x1ecc8482d85547321b692cb95758c612b39a546846b1080fb1bda673c32a7bd7;
        polys[15] = PolyLib.CompressedUniPoly(poly);

        poly = new uint256[](3);
        poly[0] = 0x05b85218299b596f07f3180e2b30f8474d03d5113a7912c9659ca40fcb1513d9;
        poly[1] = 0x2da66462c5600636192a2a101a089c925c48fce45f9572d453d87c0671fc6ee9;
        poly[2] = 0x2a960d6cb4bafe2d63ad279d1d6e8d19c9aece078af4af0aea28cf200fb043c4;
        polys[16] = PolyLib.CompressedUniPoly(poly);

        return PolyLib.SumcheckProof(polys);
    }

    function check_tau_computation(uint256[] memory tau_expected)
        private
        returns (KeccakTranscriptLib.KeccakTranscript memory)
    {
        // secondary
        (
            uint256 vk_digest,
            Abstractions.RelaxedR1CSInstance memory U,
            Vesta.VestaAffinePoint memory comm_Az,
            Vesta.VestaAffinePoint memory comm_Bz,
            Vesta.VestaAffinePoint memory comm_Cz
        ) = loadInputForTau();

        KeccakTranscriptLib.KeccakTranscript memory transcript = loadTranscript();

        uint8[] memory label = new uint8[](2); // Rust's b"vk"
        label[0] = 0x76;
        label[1] = 0x6b;

        transcript = KeccakTranscriptLib.absorb(transcript, label, vk_digest);

        label = new uint8[](1); // Rust's b"U"
        label[0] = 0x55;
        transcript = KeccakTranscriptLib.absorb(
            transcript, label, Vesta.decompress(U.comm_W), Vesta.decompress(U.comm_E), U.X, U.u
        );

        label = new uint8[](1); // Rust's b"c"
        label[0] = 0x63;

        Vesta.VestaAffinePoint[] memory commitments = new Vesta.VestaAffinePoint[](3);
        commitments[0] = comm_Az;
        commitments[1] = comm_Bz;
        commitments[2] = comm_Cz;

        transcript = KeccakTranscriptLib.absorb(transcript, label, commitments);

        label = new uint8[](1); // Rust's b"t"
        label[0] = 0x74;

        uint256[] memory tau = new uint256[](17);

        assertEq(tau_expected.length, tau.length);

        for (uint256 index = 0; index < tau.length; index++) {
            (transcript, tau[index]) =
                KeccakTranscriptLib.squeeze(transcript, ScalarFromUniformLib.curvePallas(), label);
            tau[index] = Field.reverse256(tau[index]);
            assertEq(tau[index], tau_expected[index]);
        }

        return transcript;
    }

    function check_u_computation(
        KeccakTranscriptLib.KeccakTranscript memory transcript,
        uint256[] memory tau,
        PolyEvalInstanceLib.PolyEvalInstance memory expected
    ) private returns (KeccakTranscriptLib.KeccakTranscript memory, uint256) {
        (Vesta.VestaAffinePoint[] memory comm_vec, Vesta.VestaAffinePoint[] memory comms_E, uint256[] memory evals) =
            loadInputForU();

        uint8[] memory label = new uint8[](1);
        label[0] = 0x65; // Rust's b"e"

        transcript = KeccakTranscriptLib.absorb(transcript, label, evals);
        transcript = KeccakTranscriptLib.absorb(transcript, label, comms_E);

        // Question to reference implemnetation: Do we need this absorbing, that duplicates one above?
        transcript = KeccakTranscriptLib.absorb(transcript, label, evals);

        label[0] = 0x63; // Rust's b"c"
        uint256 c;
        (transcript, c) = KeccakTranscriptLib.squeeze(transcript, ScalarFromUniformLib.curvePallas(), label);
        c = Field.reverse256(c);

        PolyEvalInstanceLib.PolyEvalInstance memory u = PolyEvalInstanceLib.batchSecondary(comm_vec, tau, evals, c);

        assertEq(expected.c_x, u.c_x);
        assertEq(expected.c_y, u.c_y);
        assertEq(expected.e, u.e);
        assertEq(expected.x.length, u.x.length);
        for (uint256 index = 0; index < u.x.length; index++) {
            assertEq(expected.x[index], u.x[index]);
        }
        return (transcript, c);
    }

    function check_gamma1_computation(KeccakTranscriptLib.KeccakTranscript memory transcript, uint256 gamma1_expected)
        public
        returns (KeccakTranscriptLib.KeccakTranscript memory)
    {
        uint8[] memory label = new uint8[](2);
        label[0] = 0x67; // Rust's b"g1"
        label[1] = 0x31;

        uint256 gamma_1;
        (transcript, gamma_1) = KeccakTranscriptLib.squeeze(transcript, ScalarFromUniformLib.curvePallas(), label);
        gamma_1 = Field.reverse256(gamma_1);

        assertEq(gamma1_expected, gamma_1);

        return transcript;
    }

    function check_gamma2_computation(KeccakTranscriptLib.KeccakTranscript memory transcript, uint256 gamma2_expected)
        public
        returns (KeccakTranscriptLib.KeccakTranscript memory)
    {
        uint8[] memory label = new uint8[](2);
        label[0] = 0x67; // Rust's b"g2"
        label[1] = 0x32;

        uint256 gamma_2;
        (transcript, gamma_2) = KeccakTranscriptLib.squeeze(transcript, ScalarFromUniformLib.curvePallas(), label);
        gamma_2 = Field.reverse256(gamma_2);

        assertEq(gamma2_expected, gamma_2);

        return transcript;
    }

    function check_coeffs_computation(
        KeccakTranscriptLib.KeccakTranscript memory transcript,
        uint256[] memory expected_coeffs
    ) public returns (KeccakTranscriptLib.KeccakTranscript memory, uint256[] memory, uint256[] memory, uint256) {
        (Vesta.VestaAffinePoint[] memory comm_output_vec, uint256[] memory claims_product_arr, uint256 vk_S_comm_N) =
            loadInputForCoeffsComputation();

        uint8[] memory label = new uint8[](1);
        label[0] = 0x6f; // Rust's b"o"

        transcript = KeccakTranscriptLib.absorb(transcript, label, comm_output_vec);

        label[0] = 0x63; // Rust's b"c"

        transcript = KeccakTranscriptLib.absorb(transcript, label, claims_product_arr);

        uint256 num_rounds = log2(vk_S_comm_N);

        label[0] = 0x65; // Rust's b"e"
        uint256[] memory rand_eq = new uint256[](num_rounds);
        uint256 index = 0;
        for (index = 0; index < num_rounds; index++) {
            (transcript, rand_eq[index]) =
                KeccakTranscriptLib.squeeze(transcript, ScalarFromUniformLib.curvePallas(), label);
            rand_eq[index] = Field.reverse256(rand_eq[index]);
        }

        label[0] = 0x72; // Rust's b"r"

        // in Rust length of coeffs is 10
        uint256[] memory coeffs = new uint256[](10);
        (transcript, coeffs[0]) = KeccakTranscriptLib.squeeze(transcript, ScalarFromUniformLib.curvePallas(), label);
        coeffs[0] = Field.reverse256(coeffs[0]);
        assertEq(coeffs[0], expected_coeffs[0]);

        for (index = 1; index < coeffs.length; index++) {
            coeffs[index] = mulmod(coeffs[index - 1], coeffs[0], Pallas.P_MOD);
            assertEq(coeffs[index], expected_coeffs[index]);
        }

        return (transcript, rand_eq, coeffs, num_rounds);
    }

    function compute_tau_claim_sat_final_r_sat_c_inner()
        public
        returns (
            KeccakTranscriptLib.KeccakTranscript memory,
            uint256[] memory,
            uint256[] memory,
            uint256,
            uint256[] memory,
            uint256,
            PolyEvalInstanceLib.PolyEvalInstance memory
        )
    {
        // secondary
        uint256[] memory tau_expected = new uint256[](17);
        tau_expected[0] = 0x17c03663671666409d2e5656c3ee877145c7e32e3494e16dbbec709afd0709e6;
        tau_expected[1] = 0x38b515b8596f09d0f1c56b3da33dc7c7dd3b1fe25d0d04b87cd716dc23f2cc31;
        tau_expected[2] = 0x23ae00416f6e0bd1e292f12ba6cbd2c498509027b8a2d92f287314235f2b2a6d;
        tau_expected[3] = 0x35281c3c99450dd3bdb0fccdafdf3028ea4e5b11a59fd8d485191cf79344f9e4;
        tau_expected[4] = 0x3110a4ef81e06dd527736a4fa519e2dd25453adb5355b08e9c83bd6341274585;
        tau_expected[5] = 0x02f5cd90a9bb245b75139967f5e033ccdaa0a5c03aa8eb349ec36eed1a4ee8fc;
        tau_expected[6] = 0x3f7bbbc64bcd58d08a504d873192746a9f568042907f926b174b59a0247f6e8e;
        tau_expected[7] = 0x2a3cb49129f6437fc4fc78ea272a653b610569f37a21757078fa74b39340f832;
        tau_expected[8] = 0x246eaeb45c2eaa49fe0490501a77cea8f18497c2b7a35b9d86f0930e0e082b7f;
        tau_expected[9] = 0x2f401cf8151d3eb918d15212f026ebd4930794107e7cd915c789a4b1c7e5eadd;
        tau_expected[10] = 0x133bd93c31e8b783f39e71c9b40c96591649115e90b0bafbffa1823fffb10ba0;
        tau_expected[11] = 0x14605eada47c70ab4c51563dc9fbb4953df05924deef56cbf8189840774a3828;
        tau_expected[12] = 0x3a09b34278f95c71529c3374c6567cec43f5dd65c76f863469249d5c2ef43e9e;
        tau_expected[13] = 0x0d88b3a19bf13be9c4c868dcff22a6790cc07736b9ed457be5782809bb55e0e4;
        tau_expected[14] = 0x19430f84eabe5885bd7fcdb9630c471c8c6002ad54302818962e3f63293935f0;
        tau_expected[15] = 0x3c43f9fc4e8571b3b15190551fe246bc25d190cff304e99253123126baf888ef;
        tau_expected[16] = 0x0bde99a49b09b102f23fe24cf9790380c734acc82063014a243edbbe4b8ba3ed;

        KeccakTranscriptLib.KeccakTranscript memory transcript = check_tau_computation(tau_expected);

        PolyEvalInstanceLib.PolyEvalInstance memory u_expected = PolyEvalInstanceLib.PolyEvalInstance(
            0x15353461b0478bc4adc71d396fdb3d98aef58ac5184a56985b145ff8a72056cd,
            0x2042fe5212f18f19e509506eb626870011bfd54556493e761833a88dc40cadc0,
            tau_expected,
            0x2144bc0d13b5cfc99beab8db542dd270bd2a8af3911e754ca0ca0818a5b9a5ba
        );
        uint256 c_inner;
        (transcript, c_inner) = check_u_computation(transcript, tau_expected, u_expected);

        // not a Step3, but we should have correct transcript
        transcript =
            check_gamma1_computation(transcript, 0x0d6f59a9222edc2cf19800be1beafc321d236892a73b2225f6ea491583a82bbd);
        transcript =
            check_gamma2_computation(transcript, 0x0cd442b1adc9853e45a036cc2613ee673ececcb54021a0980d51212176690d01);

        uint256[] memory coeffs = new uint256[](10);
        coeffs[0] = 0x24abec2a07d73e7f6aa8c47c41c545063724e664fc177870725a479a48296c45;
        coeffs[1] = 0x252a854862eb46096810a4a4a9f35c0e40a12ea0ec1960d95626f2657a6a0422;
        coeffs[2] = 0x03d733614e8f8b22b7a014ddbaf7108a8b99575a73543fb38850fd59e5d26b65;
        coeffs[3] = 0x26a82b7b3206cd44937ae80cb33d69f9e5ca95c456b92d0b4865d24a3850de3f;
        coeffs[4] = 0x2722c59f6520030025c43aa9e486b5f0fee7e190f6751674328b28828227957a;
        coeffs[5] = 0x3cdff180a4b073740aeacc97898517c3cfa3b750827902d4b28bd583d1eeb77d;
        coeffs[6] = 0x12dada10e0a1bd16bb48b32c39f644188987784e0ca26dbf0e1a5db5721357e6;
        coeffs[7] = 0x0ae9211366b88ba710f1b05e0b5d961eebbf59c205e5dbc9384b93c195dd357c;
        coeffs[8] = 0x0f93dbcda1deaf626a43adb3c60580f16d6b319032efe5d9bcc56227b04db6a5;
        coeffs[9] = 0x0082b3fee7e08d0875839ed964a59b3d8890f3cc8c99951135bab451e481de45;

        uint256 num_rounds;
        uint256[] memory rand_eq;
        (transcript, rand_eq, coeffs, num_rounds) = check_coeffs_computation(transcript, coeffs);

        uint256 claim_sat_final;
        uint256[] memory r_sat;
        (claim_sat_final, r_sat, transcript) = SecondarySumcheck.verify(
            loadSumcheckProof(), mulmod(coeffs[9], u_expected.e, Pallas.P_MOD), num_rounds, 3, transcript
        );

        return (transcript, rand_eq, tau_expected, claim_sat_final, r_sat, c_inner, u_expected);
    }

    function test_taus_bound_r_sat_rand_eq_bound_r_sat_computation() public {
        KeccakTranscriptLib.KeccakTranscript memory transcript;
        uint256[] memory rand_eq;
        uint256[] memory tau;
        uint256 claim_sat_final;
        uint256[] memory r_sat;
        uint256 c_inner;
        PolyEvalInstanceLib.PolyEvalInstance memory u;

        (transcript, rand_eq, tau, claim_sat_final, r_sat, c_inner, u) = compute_tau_claim_sat_final_r_sat_c_inner();

        uint256 claim_sat_final_expected = 0x1fd5c723b6f0663878bc5c4b30e71a4f6f4e94be969d8948579055fe7cfa1d1e;
        uint256[] memory r_sat_expected = new uint256[](17);
        r_sat_expected[0] = 0x0c6d2bf540a735934ae40e93560708b56f4452a1b9c6ad435bcc5a3d718d636c;
        r_sat_expected[1] = 0x12356e9d5716fbc87d57127bf033d6c944a469d3594be6690ebea874852df9a2;
        r_sat_expected[2] = 0x11920f58b99610ea1e7df2b95803ac51e568be3261d8c57e53c5e7232b6a8100;
        r_sat_expected[3] = 0x07669895060aa6d19a26a3ca15b66c653f057411e3e249ad032bd4c3d454dd2c;
        r_sat_expected[4] = 0x1529ed49bcf02d198015331aaceda91523d4cb6480bf88ece2b9fdcb7455318d;
        r_sat_expected[5] = 0x1a143c3ea3b03de4235858e759e5a5f145becbe09e73034bc5deae7b448dafcd;
        r_sat_expected[6] = 0x33b78932e8c0a8560c559f8c6ffb88f47355f01af8d4db106cbfd0bb6813b48f;
        r_sat_expected[7] = 0x28137caa1e6c94ba725683445a2fda31dde080460f1194927ea3d705e4a2b4cc;
        r_sat_expected[8] = 0x2a1dc1db6e9d737c435c9c5f1e99a82ef22909045565c1d3d4a70e7f3476ddd0;
        r_sat_expected[9] = 0x1980c374b3934f56f94174320f07a2086f723271f06ec0341619e804fe0af261;
        r_sat_expected[10] = 0x3c13da89c92bed75f7441764335289c8688dbaad7592ffa27fc4af6c76234b9a;
        r_sat_expected[11] = 0x0821d484a68f72a551207bf5a27a57dddbe4f6c1352fce1210ac8139c5b4b423;
        r_sat_expected[12] = 0x1d70c72ceb8af51ff89f5b520643d1dcc35393e1255e9476b7ad4987324c467a;
        r_sat_expected[13] = 0x1cbcf9e4c122e494679ad733c241d0e908d2a3c9fdb65cafea3a8c6ff72e2517;
        r_sat_expected[14] = 0x0ef3b3e72135c28d158b117f3733d291c4789c2ac9c754bfe1e90a8fc5fbb208;
        r_sat_expected[15] = 0x17e5a84f6bbdd8e53f5ec117374d39b6a23fe37a58571e95da5b4c1820608245;
        r_sat_expected[16] = 0x3492aaf8252e21df8a00c0febe0c2c2476008b7210edc742afd161f7439adb4f;

        assertEq(claim_sat_final_expected, claim_sat_final);
        assertEq(r_sat_expected.length, r_sat.length);

        for (uint256 index = 0; index < r_sat.length; index++) {
            assertEq(r_sat[index], r_sat_expected[index]);
        }

        uint256 taus_bound_r_sat = EqPolinomialLib.evaluate(tau, r_sat, Pallas.P_MOD, Pallas.negateBase);
        uint256 rand_eq_bound_r_sat = EqPolinomialLib.evaluate(rand_eq, r_sat, Pallas.P_MOD, Pallas.negateBase);

        assertEq(0x22f427ab378ad36181e799afb461c7959e81ead14d9cbb1cf817c3799fbdeaf1, taus_bound_r_sat);
        assertEq(0x08fa71bd727e1f0539be7441ee184c610e4012207be66fc1fc948b009aa7cb84, rand_eq_bound_r_sat);
    }
}
