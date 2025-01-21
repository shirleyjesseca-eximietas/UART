class uart_tx_seq extends uvm_sequence #(uart_tx_xtn);
  `uvm_object_utils(uart_tx_seq)

  // Constructor
  function new(string name = "uart_tx_seq");
    super.new(name);
  endfunction

  // Body task: Implements the actual sequence
  virtual task body();
    uart_tx_xtn tx_xtn;

    // Display the start of the sequence
    `uvm_info(get_type_name(), "Starting UART TX Sequence", UVM_LOW);

    // Create a transaction object
    tx_xtn = uart_tx_xtn::type_id::create("tx_xtn", this);

    // Write to the TX FIFO multiple times (example data values)
    for (int i = 0; i < 32; i++) begin // Loop extended for FIFO overflow
      tx_xtn.PWRITE = 1;
      tx_xtn.PADDR = 0;      
      tx_xtn.PWDATA = $urandom;         // Randomized data to transmit
      tx_xtn.PSEL = 1;
      tx_xtn.PENABLE = 1;
      tx_xtn.PRESETn = 1;

      // Start the sequence item and send it to the driver
      start_item(tx_xtn);
      finish_item(tx_xtn);
    end

    // End of TX FIFO sequence
    `uvm_info(get_type_name(), "Completed UART TX FIFO Sequence", UVM_LOW);
  endtask

endclass
