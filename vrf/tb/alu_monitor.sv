class alu_monitor extends uvm_component;
    `uvm_component_utils(alu_monitor)

    virtual alu_if.tb_mp vif;

    uvm_analysis_port#(alu_seq_item) ap;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        ap = new("ap", this);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual alu_if.tb_mp)::get(this, "", "vif", vif)) begin
            `uvm_fatal("NOVIF", "Virtual interface not set for alu_monitor")
        end
    endfunction

    task run_phase(uvm_phase phase);
        alu_seq_item tr;
        forever begin
            //if (!vif.reset) begin
			tr = alu_seq_item::type_id::create("mon_tr");
			tr.operand_a = vif.operand_a;
			tr.operand_b = vif.operand_b;
			tr.opcode = vif.opcode;
			tr.carry_in = vif.carry_in;
			tr.result = vif.result;
			tr.carry_out  = vif.carry_out;
			ap.write(tr);
			@(posedge vif.clk);
            //end
        end
    endtask
endclass
