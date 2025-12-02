class alu_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(alu_scoreboard)

  uvm_analysis_imp #(alu_seq_item, alu_scoreboard) ap;
  int total;
  int passed;
  int failed;
	
  function new(string name, uvm_component parent);
    super.new(name, parent);
    ap = new("ap", this);
  endfunction
  
  function void write(alu_seq_item tr);
	logic [15:0] opr;
	logic opr_cout;

	//active low
	case ({tr.mode, tr.opcode})
		OP_A_ADD: begin {opr_cout, opr} = tr.operand_a + tr.operand_b + tr.carry_in; end
		OP_A_SUB: begin {opr_cout, opr} = tr.operand_a - tr.operand_b - (tr.carry_in ? 0 : 1); end 
		OP_A_MINUS1: begin {opr_cout, opr} = tr.carry_in ? 16'h0000: 16'hFFFF; end
		OP_A_AMBM1: begin  {opr_cout, opr} = tr.operand_a - tr.operand_b - 16'h1; end
		OP_L_AND: begin opr = tr.operand_a & tr.operand_b; opr_cout = 0; end
		OP_L_OR: begin opr = tr.operand_a | tr.operand_b; opr_cout = 0; end
		OP_L_XOR: begin opr = tr.operand_a ^ tr.operand_b; opr_cout = 0; end
		default: begin `uvm_info(get_full_name(), $sformatf("This opcode is not implemented yet"), UVM_LOW); opr = 16'h0000; opr_cout = 0; end
	endcase

	if (tr.result === opr && tr.carry_out === opr_cout) begin
		passed++;
	end else begin
		failed++;
		`uvm_error(get_full_name(),
			$sformatf("Scoreboard mismatch: op=%0h a=0x%04h b=0x%04h => got=0x%04h/%b opr=0x%04h/%b",
				tr.opcode, tr.operand_a, tr.operand_b, tr.result, tr.carry_out, opr, opr_cout));
	end
   endfunction
   
   function void report_phase(uvm_phase phase);
	`uvm_info(get_full_name(), $sformatf("Scoreboard: passed=%0d failed=%0d", passed, failed), UVM_LOW);
   endfunction
   
endclass

