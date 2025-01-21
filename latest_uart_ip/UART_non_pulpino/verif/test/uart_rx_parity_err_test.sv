// uart_rx_parity_err_test.sv
class uart_rx_parity_err_test extends uart_test;

  `uvm_component_utils(uart_rx_parity_err_test)

    uart_rx_reset_seq rx_seq1; //RX base sequence handle
	uart_rx_parity_err_seq rx_seq2; // RX sequence handle  

  // Constructor
  function new(string name = "uart_rx_parity_err_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  // Build Phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

endfunction

  // Run Phase
  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    `uvm_info("UART_TEST", "Starting UART RX Parity error Test", UVM_HIGH)

    // Create and start the UART RX sequence
   
    rx_seq1 = uart_rx_reset_seq::type_id::create("rx_seq1");    
    rx_seq2 = uart_rx_parity_err_seq::type_id::create("rx_seq2");
    rx_seq1.start(env.rx_agent.seqr);
    rx_seq2.start(env.rx_agent.seqr);

    // Wait for sequence completion and check scoreboard
    `uvm_info("UART_TEST", "Sequence completed. Verifying results.", UVM_HIGH)


    phase.drop_objection(this);
  endtask
endclass
