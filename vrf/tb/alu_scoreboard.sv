class alu_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(alu_scoreboard)

  int total;
  int passed;
  int failed;
  int skipped;
  
  uvm_analysis_imp #(alu_seq_item, alu_scoreboard) ap;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
    virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    ap = new ("ap", this);
  endfunction
   
  function void write(alu_seq_item tr);
  	logic [16:0] res = 0;
	logic [15:0] opr = 0;
	logic opr_cout = 0;
	logic flag_default = 0;
	//active low
	
	case ({tr.mode, tr.opcode})
		OP_A_ADD: begin res = tr.operand_a + tr.operand_b; end
		OP_A_SUB: begin res = tr.operand_a - tr.operand_b - (tr.carry_in ? 0 : 1); end 
		OP_A_MINUS1: begin res = tr.carry_in ? 16'h0000: 16'hFFFF; end
		OP_A_AMBM1: begin  res = tr.operand_a - tr.operand_b - 16'h1; end
		OP_L_AND: begin res = tr.operand_a & tr.operand_b; end
		OP_L_OR: begin res = tr.operand_a | tr.operand_b; end
		OP_L_XOR: begin res = tr.operand_a ^ tr.operand_b; end
		default: begin `uvm_info(get_full_name(), $sformatf("This opcode is not implemented yet"), UVM_LOW); res = 'hxxxxx; flag_default = 1; end
	endcase
	opr = res [15:0]; opr_cout = res[16] + tr.carry_in;
	total++;
	if (!flag_default) begin : fd
		if (tr.mode == 0) begin :m0
			if (tr.result === opr && tr.carry_out === opr_cout) begin
			passed++;
			`uvm_info(get_full_name(),
				$sformatf("Scoreboard passed: mode=%0b op=%0b a=%h b=%h => result=%h/%b expected=%h/%b",
					tr.mode, tr.opcode, tr.operand_a, tr.operand_b, tr.result, tr.carry_out, opr, opr_cout), UVM_LOW);
		end else begin
			failed++;
			`uvm_error(get_full_name(),
				$sformatf("Scoreboard mismatch: mode=%0b op=%0b a=%h b=%h => result=%h/%b expected=%h/%b",
					tr.mode, tr.opcode, tr.operand_a, tr.operand_b, tr.result, tr.carry_out, opr, opr_cout));
			end
		end :m0
		else begin :m1
			if (tr.result === opr) begin
			passed++;
			`uvm_info(get_full_name(),
				$sformatf("Scoreboard passed: mode=%0b op=%0b a=%h b=%h => result=%h expected=%h",
					tr.mode, tr.opcode, tr.operand_a, tr.operand_b, tr.result, opr), UVM_LOW);
		end else begin
			failed++;
			`uvm_error(get_full_name(),
				$sformatf("Scoreboard mismatch: mode=%0b op=%0b a=%h b=%h => result=%h expected=%h",
					tr.mode, tr.opcode, tr.operand_a, tr.operand_b, tr.result, opr));
			end
		end :m1
		end : fd
	else begin
		skipped++;
		`uvm_info(get_full_name(), $sformatf("Unexpected opcode, skipped. opcode = %b, mode = %b", tr.opcode, tr.mode), UVM_LOW);
	end
   endfunction
   
   function void report_phase(uvm_phase phase);
		`uvm_info(get_full_name(), $sformatf("Scoreboard: total=%0d passed=%0d failed=%0d skipped=%0d", total, passed, failed, skipped), UVM_LOW);
   endfunction
   
endclass

