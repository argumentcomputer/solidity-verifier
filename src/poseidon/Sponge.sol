pragma solidity ^0.8.0;

import "@std/Test.sol";
import "src/pasta/Pallas.sol";
import "src/poseidon/PoseidonNeptuneU24pallas.sol";
import "src/poseidon/PoseidonNeptuneU24vesta.sol";

library SpongeOpLib {
    enum SpongeOpType{ Absorb, Squeeze }

    struct SpongeOp
    {
        SpongeOpType id;
        uint32 val;
    }

    function reset(SpongeOp memory value) internal pure returns (SpongeOp memory) {
        if (value.id == SpongeOpType.Absorb) {
            return SpongeOp(SpongeOpType.Absorb, 0);
        }
        if (value.id == SpongeOpType.Squeeze) {
            return SpongeOp(SpongeOpType.Squeeze, 0);
        }
        revert("should never happen");
    }

    function count(SpongeOp memory value) internal pure returns (uint32) {
        return value.val;
    }

    function isAbsorb(SpongeOp memory value) internal pure returns (bool) {
        return value.id == SpongeOpType.Absorb;
    }

    function isSqueeze(SpongeOp memory value) internal pure returns (bool) {
        return value.id == SpongeOpType.Squeeze;
    }

    function matches(SpongeOp memory val1, SpongeOp memory val2) internal pure returns (bool) {
        return val1.id == val2.id;
    }

    function getValue(SpongeOp memory val) internal pure returns (uint32) {
        if (val.id == SpongeOpType.Absorb) {
            assert(0 == (val.val >> 31));
            return val.val + (1 << 31);
        }
        if (val.id == SpongeOpType.Squeeze) {
            assert(0 == (val.val >> 31));
            return val.val;
        }
        revert("should never happen");
    }

    function combine(SpongeOp memory val1, SpongeOp memory val2) internal pure returns (SpongeOp memory) {
        assert(matches(val1, val2));
        if (val1.id == SpongeOpType.Absorb) {
            return SpongeOp(SpongeOpType.Absorb, val1.val + val2.val);
        }
        if (val1.id == SpongeOpType.Squeeze) {
            return SpongeOp(SpongeOpType.Squeeze, val1.val + val2.val);
        }
        revert("should never happen");
    }
}

library HasherLib {
    uint128 constant public HASHER_BASE = 340282366920938463463374607431768211297;

    struct Hasher
    {
        uint128 x;
        uint128 x_i;
        uint128 state;
        SpongeOpLib.SpongeOp currentOp;
    }


    function updateOp(Hasher memory h, SpongeOpLib.SpongeOp memory op) internal pure
    {
        if (SpongeOpLib.matches(h.currentOp, op)) {
            h.currentOp = SpongeOpLib.combine(h.currentOp, op);
        } else {
            finishOp(h);
            h.currentOp = op;
        }
    }

    function finishOp(Hasher memory h) internal pure {
        if (SpongeOpLib.count(h.currentOp) == 0) {
            return;
        }

        uint val = SpongeOpLib.getValue(h.currentOp);
        update(h, uint128(val));
    }

    // TODO: if possible, replace with more efficient implementation (compatible with Rust overflowing_mul)
    function multiply(uint128 a, uint128 b) internal pure returns (uint128){
        uint128 modulus = type(uint128).max;
        uint128 result = 0;
        a = a % modulus;
        uint counter = 0;
        while (b > 0) {
            if (b % 2 == 1) {
            unchecked {
                result = (result + a) % modulus;
            }
            }

        unchecked {
            a = (a * 2) % modulus;
        }

            b /= 2;
            counter++;
        }

        return result % modulus;
    }

    // TODO: test this function very carefully
    function update(Hasher memory h, uint128 a) internal pure {
        uint128 x_i = h.x_i;
        uint128 x = h.x;
        uint128 state = h.state;
        uint128 a_temp = a;

        x_i = multiply(x_i, x);

        uint128 tmp = multiply(x_i, a_temp);
        uint128 result;
    unchecked {
        result = state + tmp;
    }

        h.x_i = x_i;
        h.state = result;
    }

    function finalize(Hasher memory h, uint128 domainSeparator) internal pure returns (uint128) {
        finishOp(h);
        update(h, domainSeparator);
        return h.state;
    }
}

library IOPatternLib {

    struct IOPattern {
        SpongeOpLib.SpongeOp[] pattern;
    }

    function value(IOPattern memory p, uint128 domainSeparator) internal pure returns (uint128) {
        HasherLib.Hasher memory h = HasherLib.Hasher(HasherLib.HASHER_BASE, 1, 0, SpongeOpLib.SpongeOp(SpongeOpLib.SpongeOpType.Absorb, 0));

        for (uint i; i < p.pattern.length; i++) {
            HasherLib.updateOp(h, p.pattern[i]);
        }

        return HasherLib.finalize(h, domainSeparator);
    }

    function opAt(IOPattern memory p, uint128 i) internal pure returns (SpongeOpLib.SpongeOp memory)
    {
        require(i < p.pattern.length);
        return p.pattern[i];
    }
}


// Poseidon instances (over Pallas / Vesta curves) used in Nova (Sponge in Simplex mode, U24, 128-bit security)
library NovaSpongePallasLib {

    uint256 constant public PALLAS_MODULUS = 0x40000000000000000000000000000000224698fc094cf91b992d30ed00000001;
    uint32 constant public STATE_SIZE = 25;

    struct SpongeU24Pallas {
        IOPatternLib.IOPattern pattern;
        PoseidonU24Pallas.HashInputs25 state;
        uint32 squeezeIndex;
        uint32 IOCounter;
        uint32 statePosition;
    }

    function initializeState(uint128 pValue) internal pure returns (PoseidonU24Pallas.HashInputs25 memory){
        PoseidonU24Pallas.HashInputs25 memory state = PoseidonU24Pallas.HashInputs25 (
            uint256(pValue),
            0x0000000000000000000000000000000000000000000000000000000000000000,
            0x0000000000000000000000000000000000000000000000000000000000000000,
            0x0000000000000000000000000000000000000000000000000000000000000000,
            0x0000000000000000000000000000000000000000000000000000000000000000,
            0x0000000000000000000000000000000000000000000000000000000000000000,
            0x0000000000000000000000000000000000000000000000000000000000000000,
            0x0000000000000000000000000000000000000000000000000000000000000000,
            0x0000000000000000000000000000000000000000000000000000000000000000,
            0x0000000000000000000000000000000000000000000000000000000000000000,
            0x0000000000000000000000000000000000000000000000000000000000000000,
            0x0000000000000000000000000000000000000000000000000000000000000000,
            0x0000000000000000000000000000000000000000000000000000000000000000,
            0x0000000000000000000000000000000000000000000000000000000000000000,
            0x0000000000000000000000000000000000000000000000000000000000000000,
            0x0000000000000000000000000000000000000000000000000000000000000000,
            0x0000000000000000000000000000000000000000000000000000000000000000,
            0x0000000000000000000000000000000000000000000000000000000000000000,
            0x0000000000000000000000000000000000000000000000000000000000000000,
            0x0000000000000000000000000000000000000000000000000000000000000000,
            0x0000000000000000000000000000000000000000000000000000000000000000,
            0x0000000000000000000000000000000000000000000000000000000000000000,
            0x0000000000000000000000000000000000000000000000000000000000000000,
            0x0000000000000000000000000000000000000000000000000000000000000000,
            0x0000000000000000000000000000000000000000000000000000000000000000
        );
        return state;
    }

    function start(IOPatternLib.IOPattern memory pattern, uint32 domainSeparator) public pure returns (SpongeU24Pallas memory) {
        uint128 pValue = IOPatternLib.value(pattern, domainSeparator);

        PoseidonU24Pallas.HashInputs25 memory state = initializeState(pValue);

        SpongeU24Pallas memory sponge = SpongeU24Pallas(pattern, state, 0, 0, 1);

        return sponge;
    }

    function absorb(SpongeU24Pallas memory sponge, uint256[] memory scalars) public pure returns (SpongeU24Pallas memory) {
        uint256[] memory state = stateToArray(sponge.state);

        uint32 rate = STATE_SIZE - 1;
        for (uint32 i = 0; i < scalars.length; i++) {
            if (absorbPosition(sponge) == rate) {
                state = permute(sponge);

                setAbsorbPosition(sponge, 0);
            }
            uint256 old = readRateElement(state, absorbPosition(sponge));
            uint256 addition = addmod(old, scalars[i], PALLAS_MODULUS);
            addRateElement(state, absorbPosition(sponge), addition);
            setAbsorbPosition(sponge, absorbPosition(sponge) + 1);

            sponge.state = arrayToState(state);
        }

        SpongeOpLib.SpongeOp memory op = SpongeOpLib.SpongeOp(SpongeOpLib.SpongeOpType.Absorb, uint32(scalars.length));
        uint32 oldCount = incrementIOCounter(sponge);

        assert(IOPatternLib.opAt(sponge.pattern, uint128(oldCount)).id == op.id);
        assert(IOPatternLib.opAt(sponge.pattern, uint128(oldCount)).val == op.val);

        setSqueezePosition(sponge, rate);

        // TODO: for some reasons, we need to return modified sponge and reassign it on caller side, in order to recognize modifications
        return sponge;
    }

    function constantsAreEqual(uint256[] memory mix, uint256[] memory arc) public pure returns (bool){
        if (mix.length < 25) {
            return false;
        }
        if (arc.length < 25) {
            return false;
        }

        (uint256[] memory mix_expected, uint256[] memory arc_expected) = PoseidonU24Pallas.getConstants();

        if (mix_expected.length != 25) {
            return false;
        }
        if (arc_expected.length != 25) {
            return false;
        }

        for (uint32 i = 0; i < 25; i++) {
            if (mix_expected[i] != mix[i] || arc_expected[i] != arc[i]) {
                return false;
            }
        }

        return true;
    }

    function squeeze(SpongeU24Pallas memory sponge, uint32 length) public pure returns (SpongeU24Pallas memory, uint256[] memory){
        uint32 rate = STATE_SIZE - 1;

        uint256[] memory out = new uint256[](length);

        uint256[] memory state = stateToArray(sponge.state);

        for (uint32 i = 0; i < length; i++) {
            if (sponge.squeezeIndex == rate) {
                state = permute(sponge);
                setSqueezePosition(sponge, 0);
                setAbsorbPosition(sponge, 0);
            }
            out[i] = readRateElement(state, sponge.squeezeIndex);
            setSqueezePosition(sponge, sponge.squeezeIndex + 1);
            sponge.state = arrayToState(state);
        }

        SpongeOpLib.SpongeOp memory op = SpongeOpLib.SpongeOp(SpongeOpLib.SpongeOpType.Squeeze, length);
        uint32 oldCount = incrementIOCounter(sponge);
        assert(IOPatternLib.opAt(sponge.pattern, uint128(oldCount)).id == op.id);
        assert(IOPatternLib.opAt(sponge.pattern, uint128(oldCount)).val == op.val);

        // TODO: for some reasons, we need to return modified sponge and reassign it on caller side, in order to recognize modifications
        return (sponge, out);
    }

    function finish(SpongeU24Pallas memory sponge) public pure returns (SpongeU24Pallas memory){
        sponge.state = initializeState(0);
        uint32 finalIOCounter = incrementIOCounter(sponge);
        require(finalIOCounter == sponge.pattern.pattern.length, "ParameterUsageMismatch");
        // TODO: for some reasons, we need to return modified sponge and reassign it on caller side, in order to recognize modifications
        return sponge;
    }

    function finishNoFinalIOCounterCheck(SpongeU24Pallas memory sponge) public pure returns (SpongeU24Pallas memory) {
        sponge.state = initializeState(0);
        // TODO: for some reasons, we need to return modified sponge and reassign it on caller side, in order to recognize modifications
        return sponge;
    }

    function incrementIOCounter(SpongeU24Pallas memory sponge) internal pure returns (uint32){
        uint32 oldIOCounter = sponge.IOCounter;
        sponge.IOCounter++;
        return oldIOCounter;
    }

    function getElement(uint256[] memory state, uint32 index) internal pure returns (uint256) {
        return state[index];
    }

    function readRateElement(uint256[] memory state, uint32 offset) internal pure returns (uint256){
        return getElement(state, offset + 1);
    }

    function addRateElement(uint256[] memory state, uint32 offset, uint256 element) internal pure {
        state[offset + 1] = element;
    }

    function stateToArray(PoseidonU24Pallas.HashInputs25 memory state) internal pure returns (uint256[] memory) {
        uint256[] memory result = new uint256[](STATE_SIZE);
        result[0] = state.t0;
        result[1] = state.t1;
        result[2] = state.t2;
        result[3] = state.t3;
        result[4] = state.t4;
        result[5] = state.t5;
        result[6] = state.t6;
        result[7] = state.t7;
        result[8] = state.t8;
        result[9] = state.t9;
        result[10] = state.t10;
        result[11] = state.t11;
        result[12] = state.t12;
        result[13] = state.t13;
        result[14] = state.t14;
        result[15] = state.t15;
        result[16] = state.t16;
        result[17] = state.t17;
        result[18] = state.t18;
        result[19] = state.t19;
        result[20] = state.t20;
        result[21] = state.t21;
        result[22] = state.t22;
        result[23] = state.t23;
        result[24] = state.t24;
        return result;
    }

    function arrayToState(uint256[] memory state) internal pure returns (PoseidonU24Pallas.HashInputs25 memory) {
        assert(state.length == STATE_SIZE);
        PoseidonU24Pallas.HashInputs25 memory tempState = PoseidonU24Pallas.HashInputs25(
            state[0],
            state[1],
            state[2],
            state[3],
            state[4],
            state[5],
            state[6],
            state[7],
            state[8],
            state[9],
            state[10],
            state[11],
            state[12],
            state[13],
            state[14],
            state[15],
            state[16],
            state[17],
            state[18],
            state[19],
            state[20],
            state[21],
            state[22],
            state[23],
            state[24]
        );
        return tempState;
    }

    function absorbPosition(SpongeU24Pallas memory sponge) internal pure returns (uint32) {
        return sponge.statePosition - 1;
    }

    function setAbsorbPosition(SpongeU24Pallas memory sponge, uint32 index) internal pure {
        sponge.statePosition = index + 1;
    }

    function setSqueezePosition(SpongeU24Pallas memory sponge, uint32 index) internal pure {
        sponge.squeezeIndex = index;
    }

    function setPattern(SpongeU24Pallas memory sponge, IOPatternLib.IOPattern memory pattern) internal pure {
        sponge.pattern = pattern;
    }

    function permute(SpongeU24Pallas memory sponge) internal pure returns (uint256[] memory){
        PoseidonU24Pallas.HashInputs25 memory temp_state = sponge.state;

        PoseidonU24Pallas.hash(temp_state, PALLAS_MODULUS);

        setAbsorbPosition(sponge, 0);
        setSqueezePosition(sponge, 0);
        sponge.statePosition = 0;

        return stateToArray(temp_state);
    }
}

library NovaSpongeVestaLib {
    uint256 constant public VESTA_MODULUS = 0x40000000000000000000000000000000224698fc0994a8dd8c46eb2100000001;
    uint32 constant public STATE_SIZE = 25;

    struct SpongeU24Vesta {
        IOPatternLib.IOPattern pattern;
        PoseidonU24Vesta.HashInputs25 state;
        uint32 squeezeIndex;
        uint32 IOCounter;
        uint32 statePosition;
    }

    function initializeState(uint128 pValue) internal pure returns (PoseidonU24Vesta.HashInputs25 memory){
        PoseidonU24Vesta.HashInputs25 memory state = PoseidonU24Vesta.HashInputs25 (
            uint256(pValue),
            0x0000000000000000000000000000000000000000000000000000000000000000,
            0x0000000000000000000000000000000000000000000000000000000000000000,
            0x0000000000000000000000000000000000000000000000000000000000000000,
            0x0000000000000000000000000000000000000000000000000000000000000000,
            0x0000000000000000000000000000000000000000000000000000000000000000,
            0x0000000000000000000000000000000000000000000000000000000000000000,
            0x0000000000000000000000000000000000000000000000000000000000000000,
            0x0000000000000000000000000000000000000000000000000000000000000000,
            0x0000000000000000000000000000000000000000000000000000000000000000,
            0x0000000000000000000000000000000000000000000000000000000000000000,
            0x0000000000000000000000000000000000000000000000000000000000000000,
            0x0000000000000000000000000000000000000000000000000000000000000000,
            0x0000000000000000000000000000000000000000000000000000000000000000,
            0x0000000000000000000000000000000000000000000000000000000000000000,
            0x0000000000000000000000000000000000000000000000000000000000000000,
            0x0000000000000000000000000000000000000000000000000000000000000000,
            0x0000000000000000000000000000000000000000000000000000000000000000,
            0x0000000000000000000000000000000000000000000000000000000000000000,
            0x0000000000000000000000000000000000000000000000000000000000000000,
            0x0000000000000000000000000000000000000000000000000000000000000000,
            0x0000000000000000000000000000000000000000000000000000000000000000,
            0x0000000000000000000000000000000000000000000000000000000000000000,
            0x0000000000000000000000000000000000000000000000000000000000000000,
            0x0000000000000000000000000000000000000000000000000000000000000000
        );
        return state;
    }

    function start(IOPatternLib.IOPattern memory pattern, uint32 domainSeparator) public pure returns (SpongeU24Vesta memory) {
        uint128 pValue = IOPatternLib.value(pattern, domainSeparator);

        PoseidonU24Vesta.HashInputs25 memory state = initializeState(pValue);

        SpongeU24Vesta memory sponge = SpongeU24Vesta(pattern, state, 0, 0, 1);

        return sponge;
    }

    function absorb(SpongeU24Vesta memory sponge, uint256[] memory scalars) public pure returns (SpongeU24Vesta memory) {
        uint256[] memory state = stateToArray(sponge.state);

        uint32 rate = STATE_SIZE - 1;
        for (uint32 i = 0; i < scalars.length; i++) {
            if (absorbPosition(sponge) == rate) {
                state = permute(sponge);

                setAbsorbPosition(sponge, 0);
            }
            uint256 old = readRateElement(state, absorbPosition(sponge));
            uint256 addition = addmod(old, scalars[i], VESTA_MODULUS);
            addRateElement(state, absorbPosition(sponge), addition);
            setAbsorbPosition(sponge, absorbPosition(sponge) + 1);

            sponge.state = arrayToState(state);
        }

        SpongeOpLib.SpongeOp memory op = SpongeOpLib.SpongeOp(SpongeOpLib.SpongeOpType.Absorb, uint32(scalars.length));
        uint32 oldCount = incrementIOCounter(sponge);

        assert(IOPatternLib.opAt(sponge.pattern, uint128(oldCount)).id == op.id);
        assert(IOPatternLib.opAt(sponge.pattern, uint128(oldCount)).val == op.val);

        setSqueezePosition(sponge, rate);

        // TODO: for some reasons, we need to return modified sponge and reassign it on caller side, in order to recognize modifications
        return sponge;
    }

    function constantsAreEqual(uint256[] memory mix, uint256[] memory arc) public view returns (bool){
        if (mix.length < 25) {
            console.log("here");
            return false;
        }
        if (arc.length < 25) {
            console.log("here1");
            return false;
        }

        (uint256[] memory mix_expected, uint256[] memory arc_expected) = PoseidonU24Vesta.getConstants();

        if (mix_expected.length != 25) {
            console.log("here2");
            return false;
        }
        if (arc_expected.length != 25) {
            console.log("here3");
            return false;
        }

        for (uint32 i = 0; i < 25; i++) {
            if (mix_expected[i] != mix[i] || arc_expected[i] != arc[i]) {
                console.log("here4");
                return false;
            }
        }

        return true;
    }

    function squeeze(SpongeU24Vesta memory sponge, uint32 length) public pure returns (SpongeU24Vesta memory, uint256[] memory){
        uint32 rate = STATE_SIZE - 1;

        uint256[] memory out = new uint256[](length);

        uint256[] memory state = stateToArray(sponge.state);

        for (uint32 i = 0; i < length; i++) {
            if (sponge.squeezeIndex == rate) {
                state = permute(sponge);
                setSqueezePosition(sponge, 0);
                setAbsorbPosition(sponge, 0);
            }
            out[i] = readRateElement(state, sponge.squeezeIndex);
            setSqueezePosition(sponge, sponge.squeezeIndex + 1);
            sponge.state = arrayToState(state);
        }

        SpongeOpLib.SpongeOp memory op = SpongeOpLib.SpongeOp(SpongeOpLib.SpongeOpType.Squeeze, length);
        uint32 oldCount = incrementIOCounter(sponge);
        assert(IOPatternLib.opAt(sponge.pattern, uint128(oldCount)).id == op.id);
        assert(IOPatternLib.opAt(sponge.pattern, uint128(oldCount)).val == op.val);

        // TODO: for some reasons, we need to return modified sponge and reassign it on caller side, in order to recognize modifications
        return (sponge, out);
    }

    function finish(SpongeU24Vesta memory sponge) public pure returns (SpongeU24Vesta memory){
        sponge.state = initializeState(0);
        uint32 finalIOCounter = incrementIOCounter(sponge);
        require(finalIOCounter == sponge.pattern.pattern.length, "ParameterUsageMismatch");
        // TODO: for some reasons, we need to return modified sponge and reassign it on caller side, in order to recognize modifications
        return sponge;
    }

    function finishNoFinalIOCounterCheck(SpongeU24Vesta memory sponge) public pure returns (SpongeU24Vesta memory) {
        sponge.state = initializeState(0);
        // TODO: for some reasons, we need to return modified sponge and reassign it on caller side, in order to recognize modifications
        return sponge;
    }

    function incrementIOCounter(SpongeU24Vesta memory sponge) internal pure returns (uint32){
        uint32 oldIOCounter = sponge.IOCounter;
        sponge.IOCounter++;
        return oldIOCounter;
    }

    function getElement(uint256[] memory state, uint32 index) internal pure returns (uint256) {
        return state[index];
    }

    function readRateElement(uint256[] memory state, uint32 offset) internal pure returns (uint256){
        return getElement(state, offset + 1);
    }

    function addRateElement(uint256[] memory state, uint32 offset, uint256 element) internal pure {
        state[offset + 1] = element;
    }

    function stateToArray(PoseidonU24Vesta.HashInputs25 memory state) internal pure returns (uint256[] memory) {
        uint256[] memory result = new uint256[](STATE_SIZE);
        result[0] = state.t0;
        result[1] = state.t1;
        result[2] = state.t2;
        result[3] = state.t3;
        result[4] = state.t4;
        result[5] = state.t5;
        result[6] = state.t6;
        result[7] = state.t7;
        result[8] = state.t8;
        result[9] = state.t9;
        result[10] = state.t10;
        result[11] = state.t11;
        result[12] = state.t12;
        result[13] = state.t13;
        result[14] = state.t14;
        result[15] = state.t15;
        result[16] = state.t16;
        result[17] = state.t17;
        result[18] = state.t18;
        result[19] = state.t19;
        result[20] = state.t20;
        result[21] = state.t21;
        result[22] = state.t22;
        result[23] = state.t23;
        result[24] = state.t24;
        return result;
    }

    function arrayToState(uint256[] memory state) internal pure returns (PoseidonU24Vesta.HashInputs25 memory) {
        assert(state.length == STATE_SIZE);
        PoseidonU24Vesta.HashInputs25 memory tempState = PoseidonU24Vesta.HashInputs25(
            state[0],
            state[1],
            state[2],
            state[3],
            state[4],
            state[5],
            state[6],
            state[7],
            state[8],
            state[9],
            state[10],
            state[11],
            state[12],
            state[13],
            state[14],
            state[15],
            state[16],
            state[17],
            state[18],
            state[19],
            state[20],
            state[21],
            state[22],
            state[23],
            state[24]
        );
        return tempState;
    }

    function absorbPosition(SpongeU24Vesta memory sponge) internal pure returns (uint32) {
        return sponge.statePosition - 1;
    }

    function setAbsorbPosition(SpongeU24Vesta memory sponge, uint32 index) internal pure {
        sponge.statePosition = index + 1;
    }

    function setSqueezePosition(SpongeU24Vesta memory sponge, uint32 index) internal pure {
        sponge.squeezeIndex = index;
    }

    function setPattern(SpongeU24Vesta memory sponge, IOPatternLib.IOPattern memory pattern) internal pure {
        sponge.pattern = pattern;
    }

    function permute(SpongeU24Vesta memory sponge) internal pure returns (uint256[] memory){
        PoseidonU24Vesta.HashInputs25 memory temp_state = sponge.state;

        PoseidonU24Vesta.hash(temp_state, VESTA_MODULUS);

        setAbsorbPosition(sponge, 0);
        setSqueezePosition(sponge, 0);
        sponge.statePosition = 0;

        return stateToArray(temp_state);
    }
}
