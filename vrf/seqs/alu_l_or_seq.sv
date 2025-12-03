class alu_or_seq extends uvm_sequence #(alu_seq_item);
    rand int unsigned num_tests = 10;

    `uvm_object_utils(alu_or_seq)

    function new(string name="alu_or_seq");
        super.new(name);
    endfunction

    task body();
        alu_seq_item tr;
        repeat(num_tests) begin
            tr = alu_seq_item::type_id::create("tr");
            assert(tr.randomize() with {
               {mode, opcode} == OP_L_OR; 
            });
            `uvm_info("OR_SEQ", $sformatf("Generated OR op A=%h B=%h", tr.operand_a, tr.operand_b), UVM_MEDIUM)
            start_item(tr);
            finish_item(tr);
        end
    endtask
endclass
