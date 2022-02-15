// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

// Contract representing solidity's Arithmetic Operators

contract Operators {
    
	uint256 public a = 20;
	uint256 public b = 10;

    /// 1. Arithmetic Operators

	// Addition
	uint public sum = a + b;

	// Subtraction
	uint public diff = a - b;

	// Multiplication
	uint public mul = a * b;

	// Division
	uint public div = a / b;

	// Modulo (remainder) returns the remainder of a division
	uint public mod = a % b;

	// decrement value by 1
	uint public dec = --b;

	// increment value by 1
	uint public inc = ++a;


    /// 2. Comparison Operators

    // equality
    bool public eq = a == b;
 
    // Not equal
    bool public noteq = a != b;
    
    // greater than
    bool public gtr = a > b;
 
    // less than
    bool public les = a < b;
 
    // greater than or equal to
    bool public gtreq = a >= b;
 
    // less than equal to 
    bool public leseq = a <= b;


    /// 3. Logical Operators

    function logicOperators() public view returns (bool and, bool or, bool not) {
        // AND : returns true if both operands are true
        and = a > b && b > a;
        // OR : returns true if either operand is true
        or = a > b || b > a;
        // NOT : returns true if the operand is false & vice versa
        not = !(a > b);
    }


    /// 4. Assignment Operators

    function assignmentOperators(uint operand) public pure returns (uint assign, uint addassign, uint subassign, uint mulassign, uint divassign, uint modassign) {
        // Simple assignment 
        assign = operand;

        // Addition assignment (adds the value of the right operand to the left operand and stores the result in the left operand)
        addassign += operand;

        // Subtraction assignment (subtracts the value of the right operand from the left operand and stores the result in the left operand)
        subassign -= operand;

        // Multiplication assignment (multiplies the value of the right operand with the left operand and stores the result in the left operand)
        mulassign *= operand;

        // Division assignment (divides the value of the left operand by the value of the right operand and stores the result in the left operand)
        divassign /= operand;

        // Modulo assignment (returns the remainder of the division of the left operand by the right operand and stores the result in the left operand)
        modassign %= operand;

    }


    /// 5. Conditional Operators
    //if condition true ? then A: else B
    function conditionalOperators(uint operand) public pure returns (uint cond) {
        // Conditional (ternary) operator
        cond = operand > 10 ? operand%10 : operand;
    }


    /// 6. Bitwise Operators
    // These operators works on bit level of the integers

    // Bitwise AND (Both of the bits have to be 1 (true)).
    uint public and = a & b;

    // Bitwise OR (At least one of the bits have to be 1 (true)).
    uint public or = a | b;

    // Bitwise XOR (exclusive or) (One of the inputs have to be 1 and the other one must be 0 to result in true.)
    uint public xor = a ^ b;

    // Bitwise NOT (negation) ( Zero becomes one, one becomes zero.)
    uint public not = ~a;

    // Bitwise left shift (It moves all the bits in its first operand to the left by the number of places specified in the second operand. New bits are filled with zeros.) 
    uint public lshift = a << b;

    // Bitwise right shift (The left operand's value is moved right by the number of bits specified by the right operand.)
    uint public rshift = a >> b;
	
}

