
module alu_tb;

  logic clk;

  // Interface instantiation
  alu_if alu_intf(clk);

  
  // DUT instantiation using interface
    alu16 dut (
        .a(alu_intf.operand_a),
        .b(alu_intf.operand_b),
        .Cin(alu_intf.carry_in),
        .mode(alu_intf.mode),
        .sel(alu_intf.opcode),
        .result(alu_intf.result),
        .Cout(alu_intf.carry_out),
        .nBo(alu_intf.nBo),
        .nGo(alu_intf.nGo)
    );
	  
  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end
  
    // UVM test setup
    initial begin
        uvm_config_db#(virtual alu_if.tb_mp)::set(null, "*", "vif", alu_intf);
        run_test("alu_base_test");
    end
	

  endmodule
