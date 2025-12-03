
`include "uvm_macros.svh"
import uvm_pkg::*;
 
typedef enum logic [4:0] { //  mode, sel, Active Low Inputs
	
	OP_A_ADD      = {1'b0, 4'b1001},  // A plus B (Add)
	OP_A_SUB      = {1'b0, 4'b0001},  // AB minus 1 (Subtract)
	OP_A_MINUS1   = {1'b0, 4'b0011},  // MINUS 1
	OP_A_AMBM1	  = {1'b0, 4'b0110}, // A minus B minus 1
	
	OP_L_AND      = {1'b1, 4'b1110},  // AND
	OP_L_OR       = {1'b1, 4'b1011},  // OR
	OP_L_XOR    = {1'b1, 4'b0110}  // XOR
	
} alu_opcode_t;

/*typedef enum logic [4:0] { //  mode, sel, Active High Inputs
	
	OP_A_ADD      = {1'b0, 4'b1001},  // A plus B (Add)
	OP_A_SUB      = {1'b0, 4'b0111},  // AB minus 1 (Subtract)
	OP_A_MINUS1   = {1'b0, 4'b0011},  // MINUS 1
	OP_A_AMBM1	  = {1'b0, 4'b0110}, // A minus B minus 1
	
	OP_L_AND      = {1'b1, 4'b1011},  // AND
	OP_L_OR       = {1'b1, 4'b1110},  // OR
	OP_L_XOR      = {1'b1, 4'b0110}  // XOR
	
} alu_opcode_t;*/
