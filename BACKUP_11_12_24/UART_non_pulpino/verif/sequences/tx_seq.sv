class uart_tx_single_byte_seq extends uvm_sequence #(apb_sequencer);

  `uvm_object_utils(uart_tx_single_byte_seq)

  apb_seq_item apb_item;

  function new(string name = "uart_tx_single_byte_seq");
    super.new(name);
  endfunction

  task body();
    int byte_to_transmit = 8'hA5; // Byte to transmit
    int baud_divisor = 27; // Example divisor for 115200 baud at 50 MHz clock

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

    // Step 4: Push the byte to transmit into the TX FIFO
    apb_item.addr = 5'h0; // Address for Data Register (DR)
    apb_item.data = byte_to_transmit;
    apb_item.write = 1'b1;
    start_item(apb_item);
    finish_item(apb_item);

    `uvm_info("UART_SEQ", $sformatf("Pushed byte 0x%0h to TX FIFO", byte_to_transmit), UVM_MEDIUM)
  endtask
endclass
