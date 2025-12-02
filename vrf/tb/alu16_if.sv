interface alu_if(input logic clk);
    logic [15:0] operand_a;
    logic [15:0] operand_b;
    logic [3:0]  opcode;
    logic        mode;
    logic        carry_in;
    logic [15:0] result;
    logic        carry_out;
    logic        nBo;
    logic        nGo;

    // Modport for DUT (inputs are driven by testbench)
    modport dut_mp (
        input  operand_a,
        input  operand_b,
        input  opcode,
        input  mode,
        input  carry_in,
        output result,
        output carry_out,
        output nBo,
        output nGo
    );

    // Modport for testbench (inputs are received from DUT)
    modport tb_mp (
        output operand_a,
        output operand_b,
        output opcode,
        output mode,
        output carry_in,
        input  result,
        input  carry_out,
        input  nBo,
        input  nGo,
		input  clk
    );

endinterface