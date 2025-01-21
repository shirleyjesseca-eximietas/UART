class uart_loopback_2_test extends uart_test;

  `uvm_component_utils(uart_loopback_2_test)

  uart_loopback_2_seq seq; // TX sequence handle

  // Constructor
  function new(string name = "uart_loopback_2_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  // Build Phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

endfunction

  // Run Phase
  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    `uvm_info("UART_TEST", "Starting UART TX Single Byte Test", UVM_HIGH)

    // Create and start the UART TX sequence
    seq = uart_loopback_2_seq::type_id::create("seq");
    seq.start(env.v_seqr);

    // Wait for sequence completion and check scoreboard
    `uvm_info("UART_TEST", "Sequence completed. Verifying results.", UVM_HIGH)

     //#1000ns;

    phase.drop_objection(this);
  endtask
endclass

