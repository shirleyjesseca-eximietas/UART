class uart_tx_stop_bit_config_seq extends uvm_sequence #(uart_tx_xtn);

  `uvm_object_utils(uart_tx_stop_bit_config_seq)

  uart_tx_xtn apb_item;

  function new(string name = "uart_tx_stop_bit_config_seq");
    super.new(name);
  endfunction

  task body();
    bit [7:0] bytes_to_transmit[] = {8'h9A, 8'h82, 8'h31, 8'h1F}; // Array of bytes to transmit
    bit [15:0] baud_divisor = 16'd27;  // Example divisor for 115200 baud at 50 MHz clock

    // Step 1: Configure Baud Rate (DIVISOR)
    apb_item = uart_tx_xtn::type_id::create("apb_item");

    // Write to DIV1 (lower byte)
    start_item(apb_item);
    apb_item.nCTS = 0;
    apb_item.PADDR = 32'h1c; // Address for DIV1
    apb_item.PWDATA = 32'h04; // Lower byte
    apb_item.PWRITE = 1'b1;
    finish_item(apb_item);

    // Write to DIV2 (upper byte)
    start_item(apb_item);
    apb_item.PADDR = 32'h20; // Address for DIV2
    apb_item.PWDATA = 32'h0; // Upper byte
    apb_item.PWRITE = 1'b1;
    finish_item(apb_item);

    `uvm_info("UART_SEQ", $sformatf("Configured Baud Rate DIVISOR: 0x%0h", baud_divisor), UVM_MEDIUM)

    // Step 2: Configure Line Control Register (LCR)
    start_item(apb_item);
    apb_item.PADDR = 32'hc; // Address for LCR
    apb_item.PWDATA = 8'h07; // 8 data bits, no parity, 2 stop bits
    apb_item.PWRITE = 1'b1;
    finish_item(apb_item);

    `uvm_info("UART_SEQ", "Configured LCR (8 data bits, no parity, 2 stop bits)", UVM_MEDIUM)

    // Step 3: Enable FIFO (FCR)
    start_item(apb_item);
    apb_item.PADDR = 32'h8; // Address for FCR
    apb_item.PWDATA = 8'h01; // Enable FIFO
    apb_item.PWRITE = 1'b1;
    finish_item(apb_item);

    `uvm_info("UART_SEQ", "Configured FCR (FIFO Enabled)", UVM_MEDIUM)

    // Step 4: Write multiple bytes to TX FIFO
    foreach (bytes_to_transmit[i]) begin
      start_item(apb_item);
      apb_item.PADDR = 32'h0; // Address for TX Data Register
      apb_item.PWDATA = bytes_to_transmit[i]; // Data to transmit
      apb_item.PWRITE = 1'b1;
      finish_item(apb_item);

      `uvm_info("UART_SEQ", $sformatf("Written byte 0x%0h to TX FIFO", bytes_to_transmit[i]), UVM_MEDIUM)

      #13000; // Small delay to simulate the time between transmissions
    end

    `uvm_info("UART_SEQ", "Transmitted all bytes to TX FIFO", UVM_MEDIUM)
  endtask
endclass

