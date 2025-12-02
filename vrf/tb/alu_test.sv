class alu_basic_test extends uvm_test;
  `uvm_component_utils(alu_basic_test)
  alu_env env;

	function new(string name = "base_test", uvm_component parent = null);
		super.new(name, parent);
	endfunction
	
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		env = alu_env::type_id::create("env", this);
	endfunction
	
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
   // alu_add_seq seq = alu_add_seq::type_id::create("seq");
    //seq.start(env.agent.sequencer);
	            `uvm_info("TEST", "Basic testbench structure is running", UVM_LOW)
            #100;
    phase.drop_objection(this);
  endtask
  
endclass

