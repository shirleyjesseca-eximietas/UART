// uart_tx_single_byte_test.sv
class uart_tx_single_byte_test extends uvm_test;

  `uvm_component_utils(uart_tx_single_byte_test)

  uart_env uart_env_h; // APB Environment handle
  uart_tx_single_byte_seq tx_seq; // TX sequence handle

  uart_env_cfg env_cfg;
  uart_tx_cfg tx_cfg ;

  bit has_scoreboard =  1;
  bit has_virtual_sequencer = 1;


  // Constructor
  function new(string name = "uart_tx_single_byte_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  // Build Phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    uart_env_h = uart_env::type_id::create("uart_env_h", this);
    env_cfg = uart_env_cfg::type_id::create("env_cfg",this);


    tx_cfg = uart_tx_cfg::type_id::create("tx_cfg");
if(!uvm_config_db #(virtual uart_if)::get(this,"","uart_if",tx_cfg.vif))
	`uvm_fatal("CONFIGURATION","Failed to get() in uart_env")

tx_cfg.is_active = UVM_ACTIVE;

env_cfg.tx_cfg = tx_cfg;

//rx_cfg = uart_rx_cfg::type_id::create("rx_cfg");
//if(!uvm_config_db #(virtual uart_if)::get(this,"","uart_if",rx_cfg.vif))
	//`uvm_fatal("CONFIGURATION","Failed to get() in uart_env")

//rx_cfg.is_active = UVM_ACTIVE;
//env_cfg.rx_cfg = rx_cfg;

env_cfg.has_scoreboard = has_scoreboard;
env_cfg.has_virtual_sequencer = has_virtual_sequencer;


uvm_config_db #(uart_env_cfg)::set(this,"*","uart_env_cfg",env_cfg);
`uvm_info("TEST", "Setting uart_env_cfg", UVM_MEDIUM)

endfunction

  // Run Phase
  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    `uvm_info("UART_TEST", "Starting UART TX Single Byte Test", UVM_HIGH)

    // Create and start the UART TX sequence
    tx_seq = uart_tx_single_byte_seq::type_id::create("tx_seq");
    tx_seq.start(uart_env_h.tx_agent.seqr);

    // Wait for sequence completion and check scoreboard
    `uvm_info("UART_TEST", "Sequence completed. Verifying results.", UVM_HIGH)

     //#1000;

    phase.drop_objection(this);
  endtask
endclass
