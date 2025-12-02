class alu_env extends uvm_env;

  alu_agent     agent;
  alu_scoreboard scoreboard;
  uvm_sequencer #(alu_seq_item) sequencer;

  virtual alu_if vif;

  `uvm_component_utils(alu_env)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    if (!uvm_config_db#(virtual alu_if.tb_mp)::get(this, "", "vif", vif))
      `uvm_fatal("NOVIF", "Virtual interface not found for ALU environment");

    sequencer = uvm_sequencer#(alu_seq_item)::type_id::create("sequencer", this);

    agent = alu_agent::type_id::create("agent", this);
    uvm_config_db#(virtual alu_if)::set(this, "agent", "vif", vif);

    scoreboard = alu_scoreboard::type_id::create("scoreboard", this);
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    agent.mon.ap.connect(scoreboard.ap);
  endfunction

endclass
