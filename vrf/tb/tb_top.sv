
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
        run_test("alu_base_test");//$finish;
    end
	
  // Test controller
 /* initial begin
    initialize_test();
    run_tests();
    report_results();
    $finish;
  end

  task run_tests();
    test_add_operation();
    //...
    test_and_operation();
    //...
  endtask

  // Results reporting
  task report_results();
    $display("\n=== TEST SUMMARY ===");
    $display("All basic operations tested");
    $display("Testbench completed successfully");
  endtask*/

  // Additional monitoring
  /*always @(posedge clk) begin
  //if (!alu_intf.reset) begin
    // Monitor can be extended here
    $display("Cycle: opcode=%h, a=%h, b=%h, result=%h, carry_out=%b",
              alu_intf.opcode, alu_intf.operand_a, 
              alu_intf.operand_b, alu_intf.result, alu_intf.carry_out);
  //end
  end*/
  endmodule
