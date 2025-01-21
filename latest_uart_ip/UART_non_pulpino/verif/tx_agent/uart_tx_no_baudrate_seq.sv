class uart_tx_no_baudrate_seq extends uvm_sequence #(uart_tx_xtn);

  `uvm_object_utils(uart_tx_no_baudrate_seq)

  uart_tx_xtn apb_item;

  function new(string name = "uart_tx_no_baudrate_seq");
    super.new(name);
  endfunction

  task body();
    //bit [7:0] bytes_to_transmit[] = {8'h9A, 8'h82, 8'h31, 8'h1F}; // Array of bytes to transmit
    bit [7:0] bytes_to_transmit[] = {8'h10, 8'h20, 8'h30}; // Array of bytes to transmit

	apb_item = uart_tx_xtn::type_id::create("apb_item");
	
    // Step 1: Configure Line Control Register (LCR)
    start_item(apb_item);
    apb_item.PRESETn = 1'b1;
    apb_item.nCTS = 0;
    apb_item.PADDR = 32'hc; // Address for LCR
    apb_item.PWDATA = 8'h03; // 8 data bits, no parity, 1 stop bit
    apb_item.PWRITE = 1'b1;
    finish_item(apb_item);

    `uvm_info("UART_SEQ", "Configured LCR (8 data bits, no parity, 1 stop bit)", UVM_MEDIUM)

    // Step 2: Enable FIFO (FCR)
    start_item(apb_item);
    apb_item.PADDR = 32'h8; // Address for FCR
    apb_item.PWDATA = 8'h01; // Enable FIFO
    apb_item.PWRITE = 1'b1;
    finish_item(apb_item);

    `uvm_info("UART_SEQ", "Configured FCR (FIFO Enabled)", UVM_MEDIUM)

    // Step 3: Write multiple bytes to TX FIFO
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
