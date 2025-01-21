// uart_rx_framing_err_test.sv
class uart_rx_framing_err_test extends uart_test;

  `uvm_component_utils(uart_rx_framing_err_test)

  uart_rx_framing_err_seq rx_seq; // RX sequence handle  

  // Constructor
  function new(string name = "uart_rx_framing_err_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  // Build Phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

endfunction

  // run phase
  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    `uvm_info("uart_test", "starting uart rx Multi Byte Test", UVM_HIGH)

    // Create and start the UART RX sequence
 
    rx_seq = uart_rx_framing_err_seq::type_id::create("rx_seq");

    rx_seq.start(env.rx_agent.seqr);

    // Wait for sequence completion and check scoreboard
    `uvm_info("UART_TEST", "Sequence completed. Verifying results.", UVM_HIGH)

    phase.drop_objection(this);
  endtask
endclass
