class alu_base_seq extends uvm_sequence #(alu_seq_item);
`uvm_object_utils(alu_base_seq)

  function new(string name = "alu_base_seq");
    super.new(name);
  endfunction
  
  task body();
	alu_seq_item tr;
	tr = alu_seq_item::type_id::create("tr");
	initialize_test(tr);
	start_item(tr);
	finish_item(tr);
  endtask: body
  
  // Helper tasks
	  task initialize_test(alu_seq_item tr);
		tr.operand_a <= 0;
		tr.operand_b <= 0;
		tr.mode <= 0;
		tr.opcode <= 0;
		tr.carry_in <= 0;
	  endtask
	  
endclass