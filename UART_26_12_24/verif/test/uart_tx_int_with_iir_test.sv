class uart_tx_int_with_iir_test extends uart_test;

  `uvm_component_utils(uart_tx_int_with_iir_test)

  uart_tx_int_with_iir_seq tx_seq; // RX sequence handle  

  // Constructor
  function new(string name = "uart_tx_int_with_iir_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  // Build Phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

endfunction

  // Run Phase
  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    `uvm_info("UART_TEST", "Starting UART RX Single Byte Test", UVM_HIGH)

    // Create and start the UART TX sequence
    tx_seq = uart_tx_int_with_iir_seq::type_id::create("tx_seq");
    tx_seq.start(env.tx_agent.seqr);

    // Wait for sequence completion and check scoreboard
    `uvm_info("UART_TEST", "Sequence completed. Verifying results.", UVM_HIGH)


    phase.drop_objection(this);
  endtask
endclass

