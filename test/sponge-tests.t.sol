// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.16;

import "@std/Test.sol";
import "src/blocks/poseidon/Sponge.sol";
import "src/blocks/grumpkin/Bn256.sol";
import "src/blocks/grumpkin/Grumpkin.sol";
import "test/utils.t.sol";

// TODO: add other sponge (in simplex mode) tests from neptune: https://github.com/lurk-lab/neptune/blob/master/src/sponge/vanilla.rs#L501
contract SpongeContractTest is Test {
    function testSpongeVestaApiUsageInNova() public {
        /*
            let constants = Sponge::<Fq, U24>::api_constants(Strength::Standard);

            let mut sponge = Sponge::new_with_constants(&constants, Mode::Simplex);

            // start
            let absorb_len = 189u32;
            let squeeze_len = 1u32;

            let io_pattern = IOPattern(vec![SpongeOp::Absorb(absorb_len), SpongeOp::Squeeze(squeeze_len)]);
            let domain_separator = Some(1212312312u32);
            let accumulator = &mut ();

            SpongeAPI::start(&mut sponge, io_pattern, domain_separator, accumulator);

            // absorb
            let mut scalars = Vec::<Fq>::with_capacity(absorb_len as usize);
            for element in 0u64..absorb_len as u64 {
                scalars.push(Fq::from(element));
            }

            SpongeAPI::absorb(&mut sponge, absorb_len, &scalars, accumulator);

            // squeeze
            let output = SpongeAPI::squeeze(&mut sponge, squeeze_len, accumulator);

            println!("output: {:?}", output);

            // finish
            sponge.finish(accumulator).expect("couldn't finish");
        */

        uint32 absorbLen = 189;
        uint32 sqeezeLen = 1;
        uint32 domainSeparator = 1212312312;

        SpongeOpLib.SpongeOp memory absorb = SpongeOpLib.SpongeOp(SpongeOpLib.SpongeOpType.Absorb, absorbLen);
        SpongeOpLib.SpongeOp memory squeeze = SpongeOpLib.SpongeOp(SpongeOpLib.SpongeOpType.Squeeze, sqeezeLen);
        SpongeOpLib.SpongeOp[] memory pattern = new SpongeOpLib.SpongeOp[](2);
        pattern[0] = absorb;
        pattern[1] = squeeze;
        IOPatternLib.IOPattern memory p = IOPatternLib.IOPattern(pattern);

        NovaSpongeVestaLib.SpongeU24Vesta memory sponge = NovaSpongeVestaLib.start(p, domainSeparator);

        uint256[] memory scalars = new uint256[](absorbLen);
        for (uint32 i = 0; i < absorbLen; i++) {
            scalars[i] = uint256(i);
        }

        sponge = NovaSpongeVestaLib.absorb(sponge, scalars);

        (NovaSpongeVestaLib.SpongeU24Vesta memory updatedSponge, uint256[] memory output) =
            NovaSpongeVestaLib.squeeze(sponge, sqeezeLen);

        assertEq(output.length, sqeezeLen);
        assertEq(output[0], uint256(0x0142edde0a42918f63c603295391c6d33c1007522c28177d8f1759a9b19b202a));

        updatedSponge = NovaSpongeVestaLib.finish(updatedSponge);
        sponge = NovaSpongeVestaLib.finishNoFinalIOCounterCheck(sponge);
    }

    function testSpongePallasApiUsageInNova() public {
        /*
            let constants = Sponge::<Fp, U24>::api_constants(Strength::Standard);
            let mut sponge = Sponge::new_with_constants(&constants, Mode::Simplex);

            // start
            let absorb_len = 189u32;
            let squeeze_len = 1u32;

            let io_pattern = IOPattern(vec![SpongeOp::Absorb(absorb_len), SpongeOp::Squeeze(squeeze_len)]);
            let domain_separator = Some(1212312312u32);
            let accumulator = &mut ();

            SpongeAPI::start(&mut sponge, io_pattern, domain_separator, accumulator);

            // absorb
            let mut scalars = Vec::<Fp>::with_capacity(absorb_len as usize);
            for element in 0u64..absorb_len as u64 {
                scalars.push(Fp::from(element));
            }

            SpongeAPI::absorb(&mut sponge, absorb_len, &scalars, accumulator);

            // squeeze
            let output = SpongeAPI::squeeze(&mut sponge, squeeze_len, accumulator);

            // finish
            sponge.finish(accumulator).expect("couldn't finish");
        */

        uint32 absorbLen = 189;
        uint32 sqeezeLen = 1;
        uint32 domainSeparator = 1212312312;

        SpongeOpLib.SpongeOp memory absorb = SpongeOpLib.SpongeOp(SpongeOpLib.SpongeOpType.Absorb, absorbLen);
        SpongeOpLib.SpongeOp memory squeeze = SpongeOpLib.SpongeOp(SpongeOpLib.SpongeOpType.Squeeze, sqeezeLen);
        SpongeOpLib.SpongeOp[] memory pattern = new SpongeOpLib.SpongeOp[](2);
        pattern[0] = absorb;
        pattern[1] = squeeze;
        IOPatternLib.IOPattern memory p = IOPatternLib.IOPattern(pattern);

        NovaSpongePallasLib.SpongeU24Pallas memory sponge = NovaSpongePallasLib.start(p, domainSeparator);

        uint256[] memory scalars = new uint256[](absorbLen);
        for (uint32 i = 0; i < absorbLen; i++) {
            scalars[i] = uint256(i);
        }

        sponge = NovaSpongePallasLib.absorb(sponge, scalars);

        (NovaSpongePallasLib.SpongeU24Pallas memory updatedSponge, uint256[] memory output) =
            NovaSpongePallasLib.squeeze(sponge, sqeezeLen);

        assertEq(output.length, sqeezeLen);
        assertEq(output[0], uint256(0x356137a51d6b4280ae94ce82533063ce3440a55c927eb6a16c847c26905fa103));

        updatedSponge = NovaSpongePallasLib.finish(updatedSponge);
        sponge = NovaSpongePallasLib.finishNoFinalIOCounterCheck(sponge);
    }

    function testIOPattern() public {
        // Mimics reference tests from Rust: https://github.com/lurk-lab/neptune/blob/master/src/sponge/api.rs#L262
        SpongeOpLib.SpongeOp[] memory pattern = new SpongeOpLib.SpongeOp[](0);
        IOPatternLib.IOPattern memory p = IOPatternLib.IOPattern(pattern);

        assertEq(0, IOPatternLib.value(p, 0));
        assertEq(340282366920938463463374607431768191899, IOPatternLib.value(p, 123));

        SpongeOpLib.SpongeOp memory absorb = SpongeOpLib.SpongeOp(SpongeOpLib.SpongeOpType.Absorb, 2);
        SpongeOpLib.SpongeOp memory squeeze = SpongeOpLib.SpongeOp(SpongeOpLib.SpongeOpType.Squeeze, 2);
        SpongeOpLib.SpongeOp[] memory pattern1 = new SpongeOpLib.SpongeOp[](2);
        pattern1[0] = absorb;
        pattern1[1] = squeeze;
        IOPatternLib.IOPattern memory p1 = IOPatternLib.IOPattern(pattern1);

        assertEq(340282366920938463463374607090318361668, IOPatternLib.value(p1, 0));
        assertEq(340282366920938463463374607090314341989, IOPatternLib.value(p1, 1));

        SpongeOpLib.SpongeOp memory absorb1 = SpongeOpLib.SpongeOp(SpongeOpLib.SpongeOpType.Absorb, 1);
        SpongeOpLib.SpongeOp memory absorb2 = SpongeOpLib.SpongeOp(SpongeOpLib.SpongeOpType.Absorb, 1);
        SpongeOpLib.SpongeOp memory squeeze1 = SpongeOpLib.SpongeOp(SpongeOpLib.SpongeOpType.Squeeze, 2);
        SpongeOpLib.SpongeOp[] memory pattern2 = new SpongeOpLib.SpongeOp[](3);
        pattern2[0] = absorb1;
        pattern2[1] = absorb2;
        pattern2[2] = squeeze1;
        IOPatternLib.IOPattern memory p2 = IOPatternLib.IOPattern(pattern2);

        assertEq(340282366920938463463374607090318361668, IOPatternLib.value(p2, 0));

        SpongeOpLib.SpongeOp memory absorb3 = SpongeOpLib.SpongeOp(SpongeOpLib.SpongeOpType.Absorb, 1);
        SpongeOpLib.SpongeOp memory absorb4 = SpongeOpLib.SpongeOp(SpongeOpLib.SpongeOpType.Absorb, 1);
        SpongeOpLib.SpongeOp memory squeeze2 = SpongeOpLib.SpongeOp(SpongeOpLib.SpongeOpType.Squeeze, 1);
        SpongeOpLib.SpongeOp memory squeeze3 = SpongeOpLib.SpongeOp(SpongeOpLib.SpongeOpType.Squeeze, 1);
        SpongeOpLib.SpongeOp[] memory pattern3 = new SpongeOpLib.SpongeOp[](4);
        pattern3[0] = absorb3;
        pattern3[1] = absorb4;
        pattern3[2] = squeeze2;
        pattern3[3] = squeeze3;
        IOPatternLib.IOPattern memory p3 = IOPatternLib.IOPattern(pattern3);

        assertEq(340282366920938463463374607090318361668, IOPatternLib.value(p3, 0));
    }

    function testNovaSpongeBn256() public {
        uint32 absorbLen = 19;
        uint32 sqeezeLen = 1;
        uint32 domainSeparator = 0;

        SpongeOpLib.SpongeOp memory absorb = SpongeOpLib.SpongeOp(SpongeOpLib.SpongeOpType.Absorb, absorbLen);
        SpongeOpLib.SpongeOp memory squeeze = SpongeOpLib.SpongeOp(SpongeOpLib.SpongeOpType.Squeeze, sqeezeLen);
        SpongeOpLib.SpongeOp[] memory pattern = new SpongeOpLib.SpongeOp[](2);
        pattern[0] = absorb;
        pattern[1] = squeeze;
        IOPatternLib.IOPattern memory p = IOPatternLib.IOPattern(pattern);

        NovaSpongeLib.SpongeU24 memory sponge =
            NovaSpongeLib.start(p, domainSeparator, TestUtilities.loadBn256Constants());

        uint256[] memory scalars = new uint256[](absorbLen);
        for (uint32 i = 0; i < absorbLen; i++) {
            scalars[i] = 0x2f84ba2d19e9ddd19a1c31e99146be2346cbdeb53c268d0b8f7f70d41cde0883;
        }

        sponge = NovaSpongeLib.absorb(sponge, scalars, Bn256.R_MOD);

        uint256[] memory output;
        (sponge, output) = NovaSpongeLib.squeeze(sponge, sqeezeLen, Bn256.R_MOD);
        assertEq(output.length, sqeezeLen);
        assertEq(output[0], uint256(0x1ef0e6a5980781cf56df9a4d1dc7c892903296b099a02ca7d7d43cbabf62b11e));
    }

    function testNovaSpongeGrumpkin() public {
        uint32 absorbLen = 19;
        uint32 sqeezeLen = 1;
        uint32 domainSeparator = 0;

        SpongeOpLib.SpongeOp memory absorb = SpongeOpLib.SpongeOp(SpongeOpLib.SpongeOpType.Absorb, absorbLen);
        SpongeOpLib.SpongeOp memory squeeze = SpongeOpLib.SpongeOp(SpongeOpLib.SpongeOpType.Squeeze, sqeezeLen);
        SpongeOpLib.SpongeOp[] memory pattern = new SpongeOpLib.SpongeOp[](2);
        pattern[0] = absorb;
        pattern[1] = squeeze;
        IOPatternLib.IOPattern memory p = IOPatternLib.IOPattern(pattern);

        NovaSpongeLib.SpongeU24 memory sponge =
            NovaSpongeLib.start(p, domainSeparator, TestUtilities.loadGrumpkinConstants());

        uint256[] memory scalars = new uint256[](absorbLen);
        for (uint32 i = 0; i < absorbLen; i++) {
            scalars[i] = 0x022adeeb1771a44aa7ba41cf5d3df5662e88f7e6a60dcabdf21575cb07f1a289;
        }

        sponge = NovaSpongeLib.absorb(sponge, scalars, Grumpkin.P_MOD);

        uint256[] memory output;
        (sponge, output) = NovaSpongeLib.squeeze(sponge, sqeezeLen, Grumpkin.P_MOD);
        assertEq(output.length, sqeezeLen);
        assertEq(output[0], uint256(0x2222ebe34c5e5c2954eb33d46412a0ddd160bb42d3bd03c5e59f0a0ca42796d5));
    }
}
