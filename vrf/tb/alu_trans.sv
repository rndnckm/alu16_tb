`include "uvm_macros.svh"
import uvm_pkg::*;
    class alu_seq_item extends uvm_sequence_item;
        rand logic [15:0] operand_a;
        rand logic [15:0] operand_b;
        rand logic [3:0]  opcode;
        rand logic        mode;
        rand logic        carry_in;
        
        logic [15:0] result;
        logic        carry_out;
        logic        nBo;
        logic        nGo;

        `uvm_object_utils_begin(alu_seq_item)
            `uvm_field_int(operand_a, UVM_ALL_ON)
            `uvm_field_int(operand_b, UVM_ALL_ON)
            `uvm_field_int(opcode, UVM_ALL_ON)
            `uvm_field_int(mode, UVM_ALL_ON)
            `uvm_field_int(carry_in, UVM_ALL_ON)
            `uvm_field_int(result, UVM_ALL_ON)
            `uvm_field_int(carry_out, UVM_ALL_ON)
            `uvm_field_int(nBo, UVM_ALL_ON)
            `uvm_field_int(nGo, UVM_ALL_ON)
        `uvm_object_utils_end
		  
        function new(string name = "alu_seq_item");
            super.new(name);
        endfunction
    endclass

