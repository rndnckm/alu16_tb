class alu_env extends uvm_env;

  // Компоненты окружения
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

    if (!uvm_config_db#(virtual alu_if)::get(this, "", "vif", vif))
      `uvm_fatal("NOVIF", "Virtual interface not found for ALU environment");

    sequencer = uvm_sequencer#(alu_seq_item)::type_id::create("sequencer", this);

    agent = alu_agent::type_id::create("agent", this);
    uvm_config_db#(virtual alu_if)::set(this, "agent", "vif", vif);

    scoreboard = alu_scoreboard::type_id::create("scoreboard", this);
  endfunction

  // Connect phase: соединяем компоненты
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    // Подключаем sequencer к драйверу
    agent.drv.seq_item_port.connect(sequencer.seq_item_export);

    // Подключаем монитор к scoreboard
    agent.mon.ap.connect(scoreboard.ap);
  endfunction

endclass
