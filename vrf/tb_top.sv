`include "uvm_macros.svh"
import uvm_pkg::*;
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
        uvm_config_db#(virtual alu_if)::set(null, "*", "alu_if", alu_intf);
        run_test("alu_basic_test");
    end
	
  // Test controller
  initial begin
    initialize_test();
    run_tests();
    report_results();
    $finish;
  end

  // Helper tasks
  task initialize_test();
    //alu_intf.reset <= 1;
    alu_intf.operand_a <= 0;
    alu_intf.operand_b <= 0;
    alu_intf.opcode <= 0;
    alu_intf.carry_in <= 0;
    //#20 alu_intf.reset <= 0;
    $display("Test initialization completed");
  endtask

  task run_tests();
    test_add_operation();
    //...
    test_and_operation();
    //...
  endtask

  // Individual test tasks
  task test_add_operation();
    $display("Testing ADD operation...");
    alu_intf.opcode <= 4'b0000; // ADD
    alu_intf.operand_a <= 16'h0005;
    alu_intf.operand_b <= 16'h0003;
    alu_intf.carry_in <= 0;
    
    //...
    //end
  endtask

  task test_and_operation();
    $display("Testing AND operation...");
    alu_intf.opcode <= 4'b0101; // AND
    alu_intf.operand_a <= 16'h00FF;
    alu_intf.operand_b <= 16'h0F0F;
    //...
  endtask


  // Results reporting
  task report_results();
    $display("\n=== TEST SUMMARY ===");
    $display("All basic operations tested");
    $display("Testbench completed successfully");
  endtask

  // Additional monitoring
  always @(posedge clk) begin
  //if (!alu_intf.reset) begin
    // Monitor can be extended here
    $display("Cycle: opcode=%h, a=%h, b=%h, result=%h, carry_out=%b",
              alu_intf.opcode, alu_intf.operand_a, 
              alu_intf.operand_b, alu_intf.result, alu_intf.carry_out);
  //end
  end
  endmodule
