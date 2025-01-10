// uart_rx_single_byte_test.sv
class uart_rx_single_byte_test extends uvm_test;

  `uvm_component_utils(uart_rx_single_byte_test)

  apb_env apb_env_h; // APB Environment handle
  uart_rx_single_byte_seq rx_seq; // RX sequence handle

  // Constructor
  function new(string name = "uart_rx_single_byte_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  // Build Phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    apb_env_h = apb_env::type_id::create("apb_env_h", this);
  endfunction

  // Run Phase
  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    `uvm_info("UART_TEST", "Starting UART RX Single Byte Test", UVM_HIGH)

    // Create and start the UART RX sequence
    rx_seq = uart_rx_single_byte_seq::type_id::create("rx_seq");
    rx_seq.start(apb_env_h.sequencer);

    // Wait for sequence completion and check scoreboard
    `uvm_info("UART_TEST", "Sequence completed. Verifying results.", UVM_HIGH)

    // Wait for UART reception to complete (monitor logic handles checking)
    #100us; // Wait based on UART timing (depends on baud rate, data size)

    `uvm_info("UART_TEST", "Test completed successfully.", UVM_HIGH)

    phase.drop_objection(this);
  endtask
endclass

