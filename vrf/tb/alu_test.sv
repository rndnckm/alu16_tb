class alu_base_test extends uvm_test;
  `uvm_component_utils(alu_base_test)
  alu_env env;

	function new(string name = "base_test", uvm_component parent = null);
		super.new(name, parent);
	endfunction
	
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		env = alu_env::type_id::create("env", this);
	endfunction
	
  task run_phase(uvm_phase phase);
	alu_base_seq base_seq;
	`uvm_info("TEST", "Basic testbench structure is running", UVM_LOW)
    phase.raise_objection(this);
	
	base_seq = alu_base_seq::type_id::create("seq");
    base_seq.start(env.agent.seqr);
	
    phase.drop_objection(this);
	`uvm_info("TEST", "Basic testbench structure completed", UVM_LOW)
  endtask
  
endclass

