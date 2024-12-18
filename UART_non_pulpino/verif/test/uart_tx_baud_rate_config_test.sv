
class uart_tx_baud_rate_config_test extends uart_test;
  `uvm_component_utils(uart_tx_baud_rate_config_test)

  uart_tx_baud_rate_config_seq baudrate_seq; // TX sequence handle

  // Constructor
  function new(string name = "uart_tx_baud_rate_config_test", uvm_component parent);
    super.new(name, parent);
  endfunction

  // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  // Run phase
  task run_phase(uvm_phase phase);

    phase.raise_objection(this);

    baudrate_seq =  uart_tx_baud_rate_config_seq::type_id::create("baudrate_seq");

    // Set test-specific randomization for tx_data
    assert(baudrate_seq.randomize() with {
      foreach (tx_data[i]) tx_data[i] inside {8'h41, 8'h42, 8'h43, 8'h44, 8'h45, 8'h46, 8'h47, 8'h48};
    });

    // Start the sequence on the environment's sequencer
    baudrate_seq.start(env.tx_agent.seqr);

    phase.drop_objection(this);
  endtask

endclass

