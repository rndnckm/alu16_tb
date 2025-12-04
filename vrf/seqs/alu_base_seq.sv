class alu_base_seq extends uvm_sequence #(alu_seq_item);
`uvm_object_utils(alu_base_seq)

  rand int unsigned num_tests = 10;
	
  function new(string name = "alu_base_seq");
    super.new(name);
  endfunction
  
  alu_opcode_low_t op_selected;
  
  task body();
	alu_seq_item tr;
        repeat(num_tests) begin
			assert(randomize(op_selected))
                else `uvm_error("SEQ", "Enum randomization failed");
            tr = alu_seq_item::type_id::create("tr");
            assert(tr.randomize() with {
                {mode, opcode} == op_selected; 
            });
            `uvm_info("ADD_SEQ", $sformatf("Generated %s op A=%h B=%h",  op_selected.name(), tr.operand_a, tr.operand_b), UVM_MEDIUM)
            start_item(tr);
            finish_item(tr);
        end
   endtask
	  
endclass