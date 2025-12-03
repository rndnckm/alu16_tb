class alu_agent extends uvm_agent;

  `uvm_component_utils(alu_agent)

  // Параметры и компоненты агентного уровня
  alu_driver   drv;
  alu_monitor  mon;
  uvm_sequencer #(alu_seq_item) seqr;

  virtual alu_if vif;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Получение virtual interface
    if (!uvm_config_db #(virtual alu_if)::get(this, "", "vif", vif))
      `uvm_fatal("NOVIF", "Virtual interface not found in config DB")

    // Проверка режима
    void'(uvm_config_db #(uvm_active_passive_enum)::get(this, "", "is_active", is_active));

    // Создание монитора
    mon = alu_monitor::type_id::create("mon", this);

    // Создание компонент активной части
    if (is_active == UVM_ACTIVE) begin
      seqr = uvm_sequencer #(alu_seq_item)::type_id::create("seqr", this);
      drv  = alu_driver::type_id::create("drv", this);
    end
  endfunction

  function void connect_phase(uvm_phase phase);
	super.connect_phase(phase);
    if (is_active == UVM_ACTIVE) begin
      drv.seq_item_port.connect(seqr.seq_item_export);
    end
  endfunction

endclass

