class alu_driver extends uvm_driver #(alu_seq_item);
`uvm_component_utils(alu_driver)
  virtual alu_if vif;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    if (!uvm_config_db#(virtual alu_if)::get(this,"","alu_vif",vif))
      `uvm_fatal("NOVIF","Virtual interface not found");
  endfunction

  virtual task run_phase(uvm_phase phase);
	super.run_phase(phase);
    forever begin
	  alu_seq_item tr;
	  `uvm_info("DRV", $sformatf("Wait for item from sequencer"), UVM_LOW)
      seq_item_port.get_next_item(tr);
      drive_item(tr);
      seq_item_port.item_done();
    end
  endtask
  
    virtual task drive_item(alu_seq_item tr);
		vif.operand_a <= tr.operand_a;
		vif.operand_b <= tr.operand_b;
		vif.opcode <= tr.opcode;
		vif.mode <= tr.mode;
		vif.carry_in <= tr.carry_in;
		`uvm_info("DRIVER", $sformatf("Driving transaction: a=%h, b=%h, op=%h, mode=%b, carry_in=%b", tr.operand_a, tr.operand_b, tr.opcode, tr.mode, tr.carry_in), UVM_LOW)
		@(posedge vif.clk);
	endtask
  
endclass

