class uart_rx_single_byte_seq extends uvm_sequence #(apb_sequencer);

  `uvm_object_utils(uart_rx_single_byte_seq)

  apb_seq_item apb_item;

  function new(string name = "uart_rx_single_byte_seq");
    super.new(name);
  endfunction

  task body();
    int byte_to_receive = 8'hA5; // Byte expected to be received
    int baud_divisor = 27;       // Example divisor for 115200 baud at 50 MHz clock
    int received_byte;

    // Step 1: Configure the Baud Rate (DIV1 and DIV2)
    apb_item = apb_seq_item::type_id::create("apb_item");
    apb_item.addr = 5'h7; // Address for DIV1
    apb_item.data = baud_divisor[7:0]; // Lower byte of divisor
    apb_item.write = 1'b1;
    start_item(apb_item);
    finish_item(apb_item);

    apb_item.addr = 5'h8; // Address for DIV2
    apb_item.data = baud_divisor[15:8]; // Upper byte of divisor
    apb_item.write = 1'b1;
    start_item(apb_item);
    finish_item(apb_item);

    `uvm_info("UART_SEQ", $sformatf("Configured Baud Rate Divisor (DIV1=0x%0h, DIV2=0x%0h)", 
                                     baud_divisor[7:0], baud_divisor[15:8]), UVM_MEDIUM)

    // Step 2: Configure the Line Control Register (LCR)
    apb_item.addr = 5'h3; // Address for LCR
    apb_item.data = 8'h03; // 8 data bits, no parity, 1 stop bit
    apb_item.write = 1'b1;
    start_item(apb_item);
    finish_item(apb_item);

    `uvm_info("UART_SEQ", "Configured LCR (8 data bits, no parity, 1 stop bit)", UVM_MEDIUM)

    // Step 3: Configure the FIFO (FCR)
    apb_item.addr = 5'h2; // Address for FCR
    apb_item.data = 8'h01; // Enable FIFO
    apb_item.write = 1'b1;
    start_item(apb_item);
    finish_item(apb_item);

    `uvm_info("UART_SEQ", "Configured FCR (FIFO Enabled)", UVM_MEDIUM)

    // Step 4: Inject data into RX line (handled externally via testbench RXD drive)
    `uvm_info("UART_SEQ", $sformatf("Injecting data 0x%0h into RXD line", byte_to_receive), UVM_HIGH)
    // Inject the byte to the RXD input via a testbench mechanism.
    // This should be handled by a UVM driver or testbench stimulus.

    // Step 5: Poll the RX FIFO to read the received byte
    wait (is_data_available_in_rx_fifo()); // Wait for the RX FIFO to indicate data is ready

    apb_item.addr = 5'h0; // Address for Data Register (DR)
    apb_item.write = 1'b0; // Read operation
    start_item(apb_item);
    finish_item(apb_item);

    received_byte = apb_item.data;
    `uvm_info("UART_SEQ", $sformatf("Read byte 0x%0h from RX FIFO", received_byte), UVM_MEDIUM)

    // Step 6: Compare the received byte with the expected value
    if (received_byte === byte_to_receive) begin
      `uvm_info("UART_SEQ", $sformatf("Successfully received the expected byte: 0x%0h", received_byte), UVM_HIGH)
    end else begin
      `uvm_error("UART_SEQ", $sformatf("Mismatch! Expected: 0x%0h, Received: 0x%0h", byte_to_receive, received_byte))
    end
  endtask

  // Helper task to check RX FIFO status (depends on the Line Status Register LSR)
  function bit is_data_available_in_rx_fifo();
    apb_item = apb_seq_item::type_id::create("apb_item");
    apb_item.addr = 5'h5; // Address for LSR (Line Status Register)
    apb_item.write = 1'b0; // Read operation
    start_item(apb_item);
    finish_item(apb_item);
    
    return (apb_item.data & 8'h01) != 0; // LSR[0] = Data Ready
  endfunction

endclass



//change
