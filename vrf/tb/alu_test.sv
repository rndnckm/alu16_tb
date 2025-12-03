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
	alu_add_seq add_seq;
	alu_ambm1_seq ambm1_seq;
	alu_m1_seq m1_seq;
	alu_and_seq and_seq;
	alu_or_seq or_seq;
	alu_xor_seq xor_seq;
	
	`uvm_info("TEST", "Basic testbench structure is running", UVM_LOW)
    phase.raise_objection(this);
	
	base_seq = alu_base_seq::type_id::create("seq");
    base_seq.start(env.agent.seqr);
	
	add_seq = alu_add_seq::type_id::create("add_seq");
	add_seq.start(env.agent.seqr);
	
	ambm1_seq = alu_ambm1_seq::type_id::create("ambm1_seq");
	ambm1_seq.start(env.agent.seqr);
	
	m1_seq = alu_m1_seq::type_id::create("m1_seq");
	m1_seq.start(env.agent.seqr);
	
	and_seq = alu_and_seq::type_id::create("and_seq");
	and_seq.start(env.agent.seqr);
	
	or_seq = alu_or_seq::type_id::create("or_seq");
	or_seq.start(env.agent.seqr);
	
	xor_seq = alu_xor_seq::type_id::create("xor_seq");
	xor_seq.start(env.agent.seqr);
	
    phase.drop_objection(this);
	`uvm_info("TEST", "Basic testbench structure completed", UVM_LOW)
  endtask
  
endclass

