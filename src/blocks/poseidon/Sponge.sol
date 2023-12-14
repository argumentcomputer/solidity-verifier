// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.16;

import "@std/Test.sol";
import "src/blocks/poseidon/PoseidonNeptuneU24pallas.sol";
import "src/blocks/poseidon/PoseidonNeptuneU24vesta.sol";
import "src/blocks/poseidon/PoseidonNeptuneU24Optimized.sol";

/**
 * @title SpongeOpLib
 * @notice A Solidity library for managing operations in a cryptographic sponge construction.
 * @dev Provides utility functions to work with `SpongeOp` structures in cryptographic operations. The `SpongeOp` structure
 *      represents an operation in a sponge function. The library offers functionalities like initializing, resetting,
 *      and combining operations, as well as checking their types and retrieving values.
 */
library SpongeOpLib {
    enum SpongeOpType {
        Absorb,
        Squeeze
    }

    struct SpongeOp {
        SpongeOpType id;
        uint32 val;
    }

    /**
     * @notice Resets the `SpongeOp` structure to its initial state depending on the operation type.
     * @dev Resets the `val` field to 0 while keeping the operation type unchanged.
     * @param value The `SpongeOp` structure to be reset.
     * @return A new `SpongeOp` structure with the `val` field reset to 0.
     */
    function reset(SpongeOp memory value) internal pure returns (SpongeOp memory) {
        if (value.id == SpongeOpType.Absorb) {
            return SpongeOp(SpongeOpType.Absorb, 0);
        }
        if (value.id == SpongeOpType.Squeeze) {
            return SpongeOp(SpongeOpType.Squeeze, 0);
        }
        revert("should never happen");
    }

    /**
     * @notice Returns the current value stored in the `SpongeOp` structure.
     * @dev Retrieves the count of operations performed, stored in the `val` field of `SpongeOp`.
     * @param value The `SpongeOp` structure from which the value is retrieved.
     * @return The current count as a `uint32`.
     */
    function count(SpongeOp memory value) internal pure returns (uint32) {
        return value.val;
    }

    /**
     * @notice Checks if the given `SpongeOp` is an absorb operation.
     * @dev Compares the operation type of `SpongeOp` with `SpongeOpType.Absorb`.
     * @param value The `SpongeOp` structure to be checked.
     * @return `true` if the operation type is `Absorb`, otherwise `false`.
     */
    function isAbsorb(SpongeOp memory value) internal pure returns (bool) {
        return value.id == SpongeOpType.Absorb;
    }

    /**
     * @notice Checks if the given `SpongeOp` is a squeeze operation.
     * @dev Compares the operation type of `SpongeOp` with `SpongeOpType.Squeeze`.
     * @param value The `SpongeOp` structure to be checked.
     * @return `true` if the operation type is `Squeeze`, otherwise `false`.
     */
    function isSqueeze(SpongeOp memory value) internal pure returns (bool) {
        return value.id == SpongeOpType.Squeeze;
    }

    /**
     * @notice Checks if two `SpongeOp` structures have the same operation type.
     * @dev Compares the operation types of two `SpongeOp` structures.
     * @param val1 The first `SpongeOp` structure for comparison.
     * @param val2 The second `SpongeOp` structure for comparison.
     * @return `true` if both have the same operation type, otherwise `false`.
     */
    function matches(SpongeOp memory val1, SpongeOp memory val2) internal pure returns (bool) {
        return val1.id == val2.id;
    }

    /**
     * @notice Retrieves the operation value from a `SpongeOp` structure with additional processing based on the operation
     *            type.
     * @dev For `Absorb` operations, it adds 2^31 to the value. For `Squeeze` operations, it returns the value as is.
     * @param val The `SpongeOp` structure from which the value is retrieved.
     * @return The processed value as a `uint32`.
     */
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

/**
 * @title HasherLib
 * @notice A Solidity library providing hashing functionalities using a cryptographic sponge construction.
 * @dev Implements a custom hash function, utilizing sponge operations and modular arithmetic for cryptographic purposes.
 *      The library encapsulates the logic of managing the internal state and operations of a hashing process.
 *      It is designed to integrate with sponge operations provided by the `SpongeOpLib`.
 */
library HasherLib {
    uint128 public constant HASHER_BASE = 340282366920938463463374607431768211297;

    struct Hasher {
        uint128 x;
        uint128 x_i;
        uint128 state;
        SpongeOpLib.SpongeOp currentOp;
    }

    /**
     * @notice Updates the current operation of the hasher.
     * @dev If the new operation matches the current one in the hasher, combines them using `SpongeOpLib.combine`.
     *      Otherwise, finishes the current operation with `finishOp` and sets the hasher's current operation to the new one.
     * @param h The `Hasher` structure representing the current state of the hasher.
     * @param op The `SpongeOp` structure representing the new operation to update to.
     */
    function updateOp(Hasher memory h, SpongeOpLib.SpongeOp memory op) internal pure {
        if (SpongeOpLib.matches(h.currentOp, op)) {
            h.currentOp = SpongeOpLib.combine(h.currentOp, op);
        } else {
            finishOp(h);
            h.currentOp = op;
        }
    }

    /**
     * @notice Finalizes the current operation in the hasher.
     * @dev Completes the current operation if its count is non-zero, updating the hasher's state with `update`.
     * @param h The `Hasher` structure representing the current state of the hasher.
     */
    function finishOp(Hasher memory h) internal pure {
        if (SpongeOpLib.count(h.currentOp) == 0) {
            return;
        }

        uint256 val = SpongeOpLib.getValue(h.currentOp);
        update(h, uint128(val));
    }

    /**
     * @notice Performs modular multiplication of two 128-bit numbers.
     * @dev This function computes the product of 'a' and 'b' under a 128-bit modulus.It implements a basic multiplication
     *      algorithm with modulo operation to ensure the result stays within bounds.
     * @param a The first operand, a 128-bit unsigned integer.
     * @param b The second operand, a 128-bit unsigned integer.
     * @return The result of the modular multiplication as a 128-bit unsigned integer.
     */
    // TODO: if possible, replace with more efficient implementation (compatible with Rust overflowing_mul)
    function multiply(uint128 a, uint128 b) internal pure returns (uint128) {
        uint128 modulus = type(uint128).max;
        uint128 result = 0;
        a = a % modulus;
        uint256 counter = 0;
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

    /**
     * @notice Updates the internal state of the hasher with a new input.
     * @dev Applies modular arithmetic and updates the state of the hasher. It's a core part of the sponge construction,
     *      transforming the state with each new input.
     * @param h The `Hasher` structure representing the current state of the hasher.
     * @param a The new input as a 128-bit unsigned integer to update the hasher's state.
     */
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
    /**
     * @notice Finalizes the hashing process, producing the final hash output.
     * @dev Completes any pending operations and then updates the hasher's state with a domain separator.
     * @param h The `Hasher` structure representing the current state of the hasher.
     * @param domainSeparator A 128-bit domain separator used to finalize the hash value.
     * @return The final hash value as a 128-bit unsigned integer.
     */

    function finalize(Hasher memory h, uint128 domainSeparator) internal pure returns (uint128) {
        finishOp(h);
        update(h, domainSeparator);
        return h.state;
    }
}

/**
 * @title IOPatternLib
 * @dev This library provides functionalities to manage input/output patterns for cryptographic operations. It is designed
 *      to store and manipulate sequences of operations (absorb, squeeze) in a sponge-based hash function.
 */
library IOPatternLib {
    // The IOPattern struct represents a sequence of operations in a cryptographic sponge construction.
    struct IOPattern {
        SpongeOpLib.SpongeOp[] pattern;
    }

    /**
     * @notice Calculates the hash value based on the provided I/O pattern and domain separator.
     * @dev This function processes an I/O pattern through a hashing routine, incorporating a domain separator to produce
     *      a final hash value.
     * @param p The IOPattern structure containing the sequence of sponge operations.
     * @param domainSeparator A 128-bit domain separator used in the final hash computation.
     * @return The calculated hash value as a 128-bit unsigned integer.
     */
    function value(IOPattern memory p, uint128 domainSeparator) internal pure returns (uint128) {
        HasherLib.Hasher memory h =
            HasherLib.Hasher(HasherLib.HASHER_BASE, 1, 0, SpongeOpLib.SpongeOp(SpongeOpLib.SpongeOpType.Absorb, 0));

        for (uint256 i; i < p.pattern.length; i++) {
            HasherLib.updateOp(h, p.pattern[i]);
        }

        return HasherLib.finalize(h, domainSeparator);
    }

    /**
     * @notice Retrieves a specific sponge operation from the I/O pattern at the given index.
     * @dev This function is used to access individual operations within an I/O pattern, typically for verification or
     *      processing.
     * @param p The IOPattern structure containing the sequence of sponge operations.
     * @param i The index of the desired operation within the I/O pattern.
     * @return The sponge operation at the specified index in the I/O pattern.
     */
    function opAt(IOPattern memory p, uint128 i) internal pure returns (SpongeOpLib.SpongeOp memory) {
        require(i < p.pattern.length);
        return p.pattern[i];
    }
}

/**
 * @title NovaSpongePallasLib
 * @dev Poseidon instances (over Pallas / Vesta curves) used in Nova (Sponge in Simplex mode, U24, 128-bit security).
 */
library NovaSpongePallasLib {
    // The PALLAS_MODULUS constant defines the modulus used in Pallas curve operations. It ensures that all curve operations
    // are performed within the finite field defined by the Pallas curve.
    uint256 public constant PALLAS_MODULUS = 0x40000000000000000000000000000000224698fc094cf91b992d30ed00000001;

    // The STATE_SIZE constant specifies the size of the state array in the Sponge construction.It defines the number of
    // elements in the state array used in absorb, squeeze, and permutation operations.
    uint32 public constant STATE_SIZE = 25;

    // The SpongeU24Pallas struct is designed for the Sponge construction using the Pallas curve. It encapsulates essential
    // elements required for cryptographic operations such as hashing.
    struct SpongeU24Pallas {
        IOPatternLib.IOPattern pattern; // Defines the input/output operation pattern for the sponge.
        PoseidonU24Pallas.HashInputs25 state; // Represents the internal state of the sponge, tailored for the Pallas curve.
        uint32 squeezeIndex; // Tracks the current position in the state array for the squeezing operation.
        uint32 IOCounter; // Counter for the number of input/output operations conducted.
        uint32 statePosition; // Indicates the current position in the state array for absorb and squeeze operations.
    }

    /**
     * @notice Initializes the state of the sponge with a provided value.
     * @dev This function sets up the initial state of the sponge for the Poseidon hash function over the Pallas curve.
     *      It is the first step in the sponge process, preparing the state for subsequent absorption of data.
     * @param pValue A 128-bit value used to initialize the state.
     * @return An initialized PoseidonU24Pallas.HashInputs25 structure representing the state of the sponge.
     */
    function initializeState(uint128 pValue) internal pure returns (PoseidonU24Pallas.HashInputs25 memory) {
        PoseidonU24Pallas.HashInputs25 memory state = PoseidonU24Pallas.HashInputs25(
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

    /**
     * @notice Initializes and starts the sponge operation with a given I/O pattern and domain separator.
     * @dev This function sets up the sponge for operation by initializing its state based on a hash of the provided I/O
     *      pattern and domain separator. It's the entry point for using the sponge construction.
     * @param pattern The I/O pattern, a sequence of absorb and squeeze operations.
     * @param domainSeparator A 32-bit domain separator to differentiate hashing contexts.
     * @return A SpongeU24Pallas structure representing the initialized and ready-to-use sponge.
     */
    function start(IOPatternLib.IOPattern memory pattern, uint32 domainSeparator)
        public
        pure
        returns (SpongeU24Pallas memory)
    {
        uint128 pValue = IOPatternLib.value(pattern, domainSeparator);

        PoseidonU24Pallas.HashInputs25 memory state = initializeState(pValue);

        SpongeU24Pallas memory sponge = SpongeU24Pallas(pattern, state, 0, 0, 1);

        return sponge;
    }

    /**
     * @notice Absorbs an array of scalar values into the sponge state.
     * @dev This function incorporates the provided scalar values into the sponge's state, following the sponge
     *      construction's absorb phase.
     * @param sponge The SpongeU24Pallas structure representing the current state of the sponge.
     * @param scalars An array of scalar values to be absorbed into the sponge.
     * @return An updated SpongeU24Pallas structure after absorbing the scalar values.
     */
    function absorb(SpongeU24Pallas memory sponge, uint256[] memory scalars)
        public
        pure
        returns (SpongeU24Pallas memory)
    {
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

    /**
     * @notice Compares given constants with expected constants in the Poseidon hash function for verification.
     * @dev This function checks if the provided 'mix' and 'arc' constants match the expected values from PoseidonU24Pallas.
     *      It is used for ensuring consistency and correctness of the constants used in the hashing process.
     * @param mix The array of 'mix' constants to be compared.
     * @param arc The array of 'arc' constants to be compared.
     * @return A boolean indicating whether the provided constants match the expected Poseidon constants.
     */
    function constantsAreEqual(uint256[] memory mix, uint256[] memory arc) public pure returns (bool) {
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

    /**
     * @notice Squeezes out an array of hash values from the sponge.
     * @dev Extracts a specified number of elements from the sponge state. This is part of the squeezing phase of the sponge construction.
     *      It is used to generate hash outputs or intermediate hash states.
     * @param sponge The current state of the sponge.
     * @param length The number of elements to be squeezed out of the sponge.
     * @return A tuple containing the updated sponge state and an array of squeezed elements.
     */
    function squeeze(SpongeU24Pallas memory sponge, uint32 length)
        public
        pure
        returns (SpongeU24Pallas memory, uint256[] memory)
    {
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

    /**
     * @notice Finalizes the sponge operation and resets its state.
     * @dev Completes the sponge operation by resetting its state. This is typically called after all absorb and squeeze operations are done.
     * @param sponge The current state of the sponge to be finalized.
     * @return An updated SpongeU24Pallas structure with a reset state.
     */
    function finish(SpongeU24Pallas memory sponge) public pure returns (SpongeU24Pallas memory) {
        sponge.state = initializeState(0);
        uint32 finalIOCounter = incrementIOCounter(sponge);
        require(finalIOCounter == sponge.pattern.pattern.length, "ParameterUsageMismatch");
        // TODO: for some reasons, we need to return modified sponge and reassign it on caller side, in order to recognize modifications
        return sponge;
    }

    /**
     * @notice Finalizes the sponge operation without checking the final I/O counter.
     * @dev Similar to 'finish' but omits the check for the final I/O counter. Useful in scenarios where such a check is not required.
     * @param sponge The current state of the sponge to be finalized.
     * @return An updated SpongeU24Pallas structure with a reset state.
     */
    function finishNoFinalIOCounterCheck(SpongeU24Pallas memory sponge) public pure returns (SpongeU24Pallas memory) {
        sponge.state = initializeState(0);
        // TODO: for some reasons, we need to return modified sponge and reassign it on caller side, in order to recognize modifications
        return sponge;
    }

    /**
     * @notice Increments the I/O counter of the sponge and returns the old counter value.
     * @dev Manages the I/O counter, which tracks the number of operations (absorb or squeeze) performed on the sponge.
     * @param sponge The sponge whose I/O counter is to be incremented.
     * @return The value of the I/O counter before incrementation.
     */
    function incrementIOCounter(SpongeU24Pallas memory sponge) internal pure returns (uint32) {
        uint32 oldIOCounter = sponge.IOCounter;
        sponge.IOCounter++;
        return oldIOCounter;
    }

    /**
     * @notice Retrieves an element from a given state array at the specified index.
     * @dev Utility function to access elements of the state array, primarily used in absorb and squeeze operations.
     * @param state The state array from which to retrieve an element.
     * @param index The index of the element to retrieve.
     * @return The element at the specified index in the state array.
     */
    function getElement(uint256[] memory state, uint32 index) internal pure returns (uint256) {
        return state[index];
    }

    /**
     * @notice Reads a rate element from the sponge state at a given offset.
     * @dev Extracts a rate element (part of the sponge's state used for absorbing or squeezing) at the specified offset.
     * @param state The state array of the sponge.
     * @param offset The offset at which the rate element is to be read.
     * @return The rate element from the sponge's state at the given offset.
     */
    function readRateElement(uint256[] memory state, uint32 offset) internal pure returns (uint256) {
        return getElement(state, offset + 1);
    }

    /**
     * @notice Adds a given element to the state array at a specified offset.
     * @dev Updates the sponge's state by adding a new element at a specific position in the rate portion of the state.
     * @param state The state array of the sponge.
     * @param offset The offset in the state array where the element is to be added.
     * @param element The element to be added to the state array.
     */
    function addRateElement(uint256[] memory state, uint32 offset, uint256 element) internal pure {
        state[offset + 1] = element;
    }

    /**
     * @notice Converts the sponge's state structure to an array format.
     * @dev Useful for manipulating the sponge's state, as it allows for easier element access and modification.
     * @param state The sponge's state structure.
     * @return An array representing the sponge's state.
     */
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

    /**
     * @notice Converts an array back to the sponge's state structure.
     * @dev Reconstructs the sponge's state structure from an array, typically used after state manipulation.
     * @param state The array representing the sponge's state.
     * @return The sponge's state structure derived from the array.
     */
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

    /**
     * @notice Retrieves the current position in the sponge's state for absorbing elements.
     * @dev Determines where the next element will be absorbed into the sponge's state.
     * @param sponge The current state of the sponge.
     * @return The current absorb position in the sponge's state.
     */
    function absorbPosition(SpongeU24Pallas memory sponge) internal pure returns (uint32) {
        return sponge.statePosition - 1;
    }

    /**
     * @notice Sets the position in the sponge's state for the next absorb operation.
     * @dev Updates the sponge's state to indicate where the next element should be absorbed.
     * @param sponge The sponge whose absorb position is to be set.
     * @param index The index to set as the new absorb position.
     */
    function setAbsorbPosition(SpongeU24Pallas memory sponge, uint32 index) internal pure {
        sponge.statePosition = index + 1;
    }

    /**
     * @notice Sets the position in the sponge's state for the next squeeze operation.
     * @dev Updates the sponge's state to indicate where the next element should be squeezed out.
     * @param sponge The sponge whose squeeze position is to be set.
     * @param index The index to set as the new squeeze position.
     */
    function setSqueezePosition(SpongeU24Pallas memory sponge, uint32 index) internal pure {
        sponge.squeezeIndex = index;
    }

    /**
     * @notice Sets the I/O pattern for the sponge.
     * @dev Defines the sequence of absorb and squeeze operations for the sponge.
     * @param sponge The sponge whose I/O pattern is to be set.
     * @param pattern The I/O pattern to be set in the sponge.
     */
    function setPattern(SpongeU24Pallas memory sponge, IOPatternLib.IOPattern memory pattern) internal pure {
        sponge.pattern = pattern;
    }

    /**
     * @notice Performs the permutation operation on the sponge's state.
     * @dev The core transformation function of the sponge, which mixes the state elements to produce a pseudo-random output.
     * @param sponge The sponge whose state is to be permuted.
     * @return An array representing the permuted state.
     */
    function permute(SpongeU24Pallas memory sponge) internal pure returns (uint256[] memory) {
        PoseidonU24Pallas.HashInputs25 memory temp_state = sponge.state;

        PoseidonU24Pallas.hash(temp_state, PALLAS_MODULUS);

        setAbsorbPosition(sponge, 0);
        setSqueezePosition(sponge, 0);
        sponge.statePosition = 0;

        return stateToArray(temp_state);
    }
}

/**
 * @title NovaSpongeVestaLib
 * @notice This library implements the sponge construction for cryptographic hashing over the Vesta curve.
 * @dev Provides functions to initialize, absorb data into, and squeeze data out of the sponge. This library is designed
 *      for operations specific to the Vesta curve.
 */
library NovaSpongeVestaLib {
    // The VESTA_MODULUS constant defines the modulus used in Vesta curve operations.
    // This modulus value is specific to the Vesta elliptic curve and is used for modular arithmetic operations within
    // the curve's field. This constant is crucial for ensuring that all computations stay within the finite field defined
    //by the Vesta curve.
    uint256 public constant VESTA_MODULUS = 0x40000000000000000000000000000000224698fc0994a8dd8c46eb2100000001;
    // The STATE_SIZE constant defines the size of the state array in the Sponge construction. It determines the number
    // of elements in the state array, which is used in various operations like absorb, squeeze, and permutation.
    uint32 public constant STATE_SIZE = 25;

    // The SpongeU24Vesta struct defines the structure for the Sponge construction  using the Vesta curve. It encapsulates
    // the state and operational details required for the sponge function to perform cryptographic operations such as
    // hashing.
    struct SpongeU24Vesta {
        IOPatternLib.IOPattern pattern; // Pattern of input/output operations for the sponge.
        PoseidonU24Vesta.HashInputs25 state; // Internal state of the sponge, specific to the Vesta implementation.
        uint32 squeezeIndex; // Index for the squeezing operation, indicating the current position in the state array.
        uint32 IOCounter; // Counter for tracking the number of input/output operations performed.
        uint32 statePosition; // Position in the state array, used during absorb and squeeze operations.
    }

    /**
     * @notice Initializes the state of the sponge with a given value.
     * @dev Sets up the initial state for the sponge based on a provided value, which is crucial for the sponge's operation.
     * @param pValue The initial value to set in the sponge's state.
     * @return The initialized state of the sponge.
     */
    function initializeState(uint128 pValue) internal pure returns (PoseidonU24Vesta.HashInputs25 memory) {
        PoseidonU24Vesta.HashInputs25 memory state = PoseidonU24Vesta.HashInputs25(
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

    /**
     * @notice Begins the sponge operation with a specific I/O pattern and domain separator.
     * @dev Initializes the sponge state and sets the I/O pattern for subsequent absorb and squeeze operations.
     * @param pattern The I/O pattern defining the sequence of absorb and squeeze operations.
     * @param domainSeparator A value used to differentiate hash outputs for different applications.
     * @return A new sponge instance ready for absorbing and squeezing operations.
     */
    function start(IOPatternLib.IOPattern memory pattern, uint32 domainSeparator)
        public
        pure
        returns (SpongeU24Vesta memory)
    {
        uint128 pValue = IOPatternLib.value(pattern, domainSeparator);

        PoseidonU24Vesta.HashInputs25 memory state = initializeState(pValue);

        SpongeU24Vesta memory sponge = SpongeU24Vesta(pattern, state, 0, 0, 1);

        return sponge;
    }

    /**
     * @notice Absorbs an array of scalar values into the sponge's state.
     * @dev Integrates external data into the sponge by sequentially absorbing elements into the sponge state.
     * @param sponge The current state of the sponge.
     * @param scalars The array of scalar values to be absorbed into the sponge.
     * @return The updated state of the sponge after absorption.
     */
    function absorb(SpongeU24Vesta memory sponge, uint256[] memory scalars)
        public
        pure
        returns (SpongeU24Vesta memory)
    {
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

    /**
     * @notice Checks if the provided constants match the expected constants for the Vesta curve.
     * @dev Used for verifying the integrity of the constants used in the sponge's operations.
     * @param mix An array of provided constants for comparison.
     * @param arc An array of provided constants for comparison.
     * @return `true` if the provided constants match the expected values, otherwise `false`.
     */
    function constantsAreEqual(uint256[] memory mix, uint256[] memory arc) public view returns (bool) {
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

    /**
     * @notice Squeezes an array of elements out of the sponge's state.
     * @dev Extracts data from the sponge by sequentially reading elements from the sponge state.
     * @param sponge The current state of the sponge.
     * @param length The number of elements to squeeze out of the sponge.
     * @return The updated state of the sponge and an array of squeezed elements.
     */
    function squeeze(SpongeU24Vesta memory sponge, uint32 length)
        public
        pure
        returns (SpongeU24Vesta memory, uint256[] memory)
    {
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

    /**
     * @notice Finalizes the sponge operation and resets the state.
     * @dev Concludes the sponge operation and resets the state for security reasons.
     * @param sponge The current state of the sponge.
     * @return The reset state of the sponge.
     */
    function finish(SpongeU24Vesta memory sponge) public pure returns (SpongeU24Vesta memory) {
        sponge.state = initializeState(0);
        uint32 finalIOCounter = incrementIOCounter(sponge);
        require(finalIOCounter == sponge.pattern.pattern.length, "ParameterUsageMismatch");
        // TODO: for some reasons, we need to return modified sponge and reassign it on caller side, in order to recognize modifications
        return sponge;
    }

    /**
     * @notice Finalizes the sponge operation without checking the final I/O counter.
     * @dev Similar to `finish` but skips the check of the final I/O counter, used in cases where such validation is not
     *      required.
     * @param sponge The current state of the sponge.
     * @return The reset state of the sponge.
     */
    function finishNoFinalIOCounterCheck(SpongeU24Vesta memory sponge) public pure returns (SpongeU24Vesta memory) {
        sponge.state = initializeState(0);
        // TODO: for some reasons, we need to return modified sponge and reassign it on caller side, in order to recognize modifications
        return sponge;
    }

    /**
     * @notice Increments the I/O counter of the sponge.
     * @dev Used to track the number of operations (absorb/squeeze) performed on the sponge.
     * @param sponge The sponge whose I/O counter is to be incremented.
     * @return The previous value of the I/O counter before incrementing.
     */
    function incrementIOCounter(SpongeU24Vesta memory sponge) internal pure returns (uint32) {
        uint32 oldIOCounter = sponge.IOCounter;
        sponge.IOCounter++;
        return oldIOCounter;
    }

    /**
     * @notice Retrieves an element from the state array based on the index.
     * @dev Accesses a specific element in the sponge's state array.
     * @param state The state array of the sponge.
     * @param index The index of the element to retrieve.
     * @return The element at the specified index in the state array.
     */
    function getElement(uint256[] memory state, uint32 index) internal pure returns (uint256) {
        return state[index];
    }

    /**
     * @notice Reads a rate element from the sponge's state.
     * @dev Extracts a specific element from the rate part of the sponge's state.
     * @param state The state array of the sponge.
     * @param offset The offset for the rate element in the state array.
     * @return The rate element at the specified offset.
     */
    function readRateElement(uint256[] memory state, uint32 offset) internal pure returns (uint256) {
        return getElement(state, offset + 1);
    }

    /**
     * @notice Adds a new element to the rate part of the sponge's state.
     * @dev Modifies a specific element in the rate part of the sponge's state.
     * @param state The state array of the sponge.
     * @param offset The offset for the rate element in the state array.
     * @param element The element to be added at the specified offset.
     */
    function addRateElement(uint256[] memory state, uint32 offset, uint256 element) internal pure {
        state[offset + 1] = element;
    }

    /**
     * @notice Converts the sponge's state to an array format.
     * @dev Facilitates manipulation of the sponge's state by converting it to an array.
     * @param state The sponge's state in structured format.
     * @return The state converted to an array format.
     */
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

    /**
     * @notice Converts an array back to the sponge's state format.
     * @dev Reverts the operation of `stateToArray`, converting an array back to the sponge's structured state format.
     * @param state The state array of the sponge.
     * @return The state converted to its structured format.
     */
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

    /**
     * @notice Determines the current position for absorbing elements into the sponge's state.
     * @dev Calculates the position in the state array where the next element should be absorbed.
     * @param sponge The current state of the sponge.
     * @return The position in the state array for the next absorption.
     */
    function absorbPosition(SpongeU24Vesta memory sponge) internal pure returns (uint32) {
        return sponge.statePosition - 1;
    }

    /**
     * @notice Sets the position for the next element absorption in the sponge's state.
     * @dev Updates the position in the state array where the next element should be absorbed.
     * @param sponge The current state of the sponge.
     * @param index The new position in the state array for the next absorption.
     */
    function setAbsorbPosition(SpongeU24Vesta memory sponge, uint32 index) internal pure {
        sponge.statePosition = index + 1;
    }

    /**
     * @notice Sets the position for the next element squeezing from the sponge's state.
     * @dev Updates the position in the state array where the next element should be squeezed out.
     * @param sponge The current state of the sponge.
     * @param index The new position in the state array for the next squeezing.
     */
    function setSqueezePosition(SpongeU24Vesta memory sponge, uint32 index) internal pure {
        sponge.squeezeIndex = index;
    }

    /**
     * @notice Assigns a new I/O pattern to the sponge.
     * @dev Sets a specific I/O pattern for the sponge operations, defining the sequence of absorb and squeeze operations.
     * @param sponge The current state of the sponge.
     * @param pattern The I/O pattern to be set for the sponge.
     */
    function setPattern(SpongeU24Vesta memory sponge, IOPatternLib.IOPattern memory pattern) internal pure {
        sponge.pattern = pattern;
    }

    /**
     * @notice Applies a permutation to the sponge's state.
     * @dev Performs the cryptographic mixing step essential for the sponge's security.
     * @param sponge The sponge whose state is to be permuted.
     * @return The permuted state of the sponge as an array.
     */
    function permute(SpongeU24Vesta memory sponge) internal pure returns (uint256[] memory) {
        PoseidonU24Vesta.HashInputs25 memory temp_state = sponge.state;

        PoseidonU24Vesta.hash(temp_state, VESTA_MODULUS);

        setAbsorbPosition(sponge, 0);
        setSqueezePosition(sponge, 0);
        sponge.statePosition = 0;

        return stateToArray(temp_state);
    }
}

/**
 * @title NovaSpongeLib Library
 * @dev Provides cryptographic sponge construction functionalities for cryptographic purposes, specifically designed for use with the PoseidonU24Optimized library.
 */
library NovaSpongeLib {
    uint32 public constant STATE_SIZE = 25;


    // Represents the state and operational parameters of the sponge.
    struct SpongeU24 {
        IOPatternLib.IOPattern pattern;
        PoseidonU24Optimized.PoseidonConstantsU24 constants;
        PoseidonU24Optimized.HashInputs25 state;
        uint32 squeezeIndex;
        uint32 IOCounter;
        uint32 statePosition;
    }

    /**
     * @notice Initializes the state of the sponge with a given pValue.
     * @param pValue The initial value to start the sponge state.
     * @return Returns the initialized state of the sponge.
     */
    function initializeState(uint128 pValue) internal pure returns (PoseidonU24Optimized.HashInputs25 memory) {
        PoseidonU24Optimized.HashInputs25 memory state = PoseidonU24Optimized.HashInputs25(
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

    /**
     * @notice Starts the sponge operation with a specific pattern, domain separator, and constants.
     * @param pattern The I/O pattern to be used by the sponge.
     * @param domainSeparator The domain separator for domain separation purposes.
     * @param constants The Poseidon constants used for the hash function.
     * @return Returns the initialized sponge instance.
     */
    function start(
        IOPatternLib.IOPattern memory pattern,
        uint32 domainSeparator,
        PoseidonU24Optimized.PoseidonConstantsU24 memory constants
    ) public pure returns (SpongeU24 memory) {
        uint128 pValue = IOPatternLib.value(pattern, domainSeparator);

        PoseidonU24Optimized.HashInputs25 memory state = initializeState(pValue);

        SpongeU24 memory sponge = SpongeU24(pattern, constants, state, 0, 0, 1);

        return sponge;
    }

    /**
     * @notice Absorbs an array of scalars into the sponge's state.
     * @param sponge The sponge instance.
     * @param scalars The array of scalars to absorb.
     * @param modulus The modulus used for arithmetic operations.
     * @return Returns the updated sponge instance after absorption.
     */
    function absorb(SpongeU24 memory sponge, uint256[] memory scalars, uint256 modulus)
        public
        pure
        returns (SpongeU24 memory)
    {
        // TODO we can avoid copying state to array and vice versa if Poseidon's state will be array itself
        uint256[] memory state = stateToArray(sponge.state);

        uint32 rate = STATE_SIZE - 1;
        for (uint32 i = 0; i < scalars.length; i++) {
            if (absorbPosition(sponge) == rate) {
                state = permute(sponge, modulus);

                setAbsorbPosition(sponge, 0);
            }
            uint256 old = readRateElement(state, absorbPosition(sponge));
            uint256 addition = addmod(old, scalars[i], modulus);
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

    /**
     * @notice Squeezes output from the sponge.
     * @param sponge The sponge instance.
     * @param length The length of the output array.
     * @param modulus The modulus used for arithmetic operations.
     * @return tuple containing the updated sponge instance and the squeezed output array.
     */
    function squeeze(SpongeU24 memory sponge, uint32 length, uint256 modulus)
        public
        pure
        returns (SpongeU24 memory, uint256[] memory)
    {
        uint32 rate = STATE_SIZE - 1;

        uint256[] memory out = new uint256[](length);

        uint256[] memory state = stateToArray(sponge.state);

        for (uint32 i = 0; i < length; i++) {
            if (sponge.squeezeIndex == rate) {
                state = permute(sponge, modulus);
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

    /**
     * @notice Converts the sponge's state from a PoseidonU24Optimized.HashInputs25 structure to an array.
     * @dev This is an internal helper function to facilitate state manipulation.
     * @param state The PoseidonU24Optimized.HashInputs25 state to be converted.
     * @return The state represented as an array.
     */
    function stateToArray(PoseidonU24Optimized.HashInputs25 memory state) internal pure returns (uint256[] memory) {
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

    /**
     * @notice Converts the sponge's state from an array back to a PoseidonU24Optimized.HashInputs25 structure.
     * @dev This is an internal helper function for state manipulation and ensures the array length matches the expected state size.
     * @param state The array representing the state.
     * @return The state represented as PoseidonU24Optimized.HashInputs25.
     */
    function arrayToState(uint256[] memory state) internal pure returns (PoseidonU24Optimized.HashInputs25 memory) {
        require(state.length == STATE_SIZE, "[NovaSpongeBn256Lib::arrayToState] state.length != STATE_SIZE");
        PoseidonU24Optimized.HashInputs25 memory tempState = PoseidonU24Optimized.HashInputs25(
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

    /**
     * @notice Determines the current position for absorption in the sponge's state.
     * @dev This function helps in identifying where the next element should be absorbed in the state array.
     * @param sponge The sponge instance.
     * @return The current position for absorption in the sponge's state.
     */
    function absorbPosition(SpongeU24 memory sponge) internal pure returns (uint32) {
        return sponge.statePosition - 1;
    }

    /**
     * @notice Applies the permutation function to the sponge's state, ensuring the security and correctness of the
     *         sponge construction.
     * @param sponge The sponge instance.
     * @param modulus The modulus used for arithmetic operations in the permutation.
     * @return The new state array after permutation.
     */
    function permute(SpongeU24 memory sponge, uint256 modulus) internal pure returns (uint256[] memory) {
        PoseidonU24Optimized.HashInputs25 memory temp_state = sponge.state;

        PoseidonU24Optimized.hash(temp_state, sponge.constants, modulus);

        setAbsorbPosition(sponge, 0);
        setSqueezePosition(sponge, 0);
        sponge.statePosition = 0;

        return stateToArray(temp_state);
    }

    /**
     * @notice Sets the absorption position index in the sponge's state.
     * @param sponge The sponge instance.
     * @param index The new position index for absorption.
     */
    function setAbsorbPosition(SpongeU24 memory sponge, uint32 index) internal pure {
        sponge.statePosition = index + 1;
    }

    /**
     * @notice Sets the squeezing position index in the sponge's state.
     * @param sponge The sponge instance.
     * @param index The new position index for squeezing.
     */
    function setSqueezePosition(SpongeU24 memory sponge, uint32 index) internal pure {
        sponge.squeezeIndex = index;
    }

    /**
     * @notice Increments the IO counter of the sponge.
     * @param sponge The sponge instance whose IO counter is to be incremented.
     * @return The value of the IO counter before the increment.
     */
    function incrementIOCounter(SpongeU24 memory sponge) internal pure returns (uint32) {
        uint32 oldIOCounter = sponge.IOCounter;
        sponge.IOCounter++;
        return oldIOCounter;
    }

    /**
     * @notice Adds an element to the rate part of the sponge's state at a specified offset.
     * @dev This is an internal function used during the absorb phase of the sponge operation.
     * @param state The state array of the sponge.
     * @param offset The offset in the state array where the element is to be added.
     * @param element The element to add to the state array.
     */
    function addRateElement(uint256[] memory state, uint32 offset, uint256 element) internal pure {
        state[offset + 1] = element;
    }

    /**
     * @notice Reads an element from the rate part of the sponge's state at a specified offset.
     * @dev This function is used during the squeezing phase to read elements from the state array.
     * @param state The state array of the sponge.
     * @param offset The offset in the state array from where the element is to be read.
     * @return The element at the specified offset in the state array.
     */
    function readRateElement(uint256[] memory state, uint32 offset) internal pure returns (uint256) {
        return getElement(state, offset + 1);
    }

    /**
     * @notice Retrieves an element from a specified index in the state array.
     * @param state The state array of the sponge.
     * @param index The index in the state array from where the element is to be retrieved.
     * @return The element at the specified index in the state array.
     */
    function getElement(uint256[] memory state, uint32 index) internal pure returns (uint256) {
        return state[index];
    }
}
