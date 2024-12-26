class uart_tx_int_with_iir_seq extends uvm_sequence #(uart_tx_xtn);

  `uvm_object_utils(uart_tx_int_with_iir_seq)

  uart_tx_xtn apb_item;

  function new(string name = "uart_tx_int_with_iir_seq");
    super.new(name);
  endfunction

  task body();
    bit [15:0] baud_divisor = 16'd27;  // Example divisor for 115200 baud at 50 MHz clock
    bit [7:0] iir_value;

    // Step 1: Configure Baud Rate (DIVISOR)
    apb_item = uart_tx_xtn::type_id::create("apb_item");

    // Write to DIV1 (lower byte)
    start_item(apb_item);
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
    
    // Step 2: Enable TX Interrupt in IER
    start_item(apb_item);
    apb_item.PADDR = 32'h4; // Address for IER
    apb_item.PWDATA = 8'h02; // IER[1] = 1 for TX interrupt
    apb_item.PWRITE = 1'b1;
    finish_item(apb_item);

    `uvm_info("UART_SEQ", "Configured IER", UVM_MEDIUM)

    // Step 3: Configure Line Control Register (LCR)
    start_item(apb_item);
    apb_item.PADDR = 32'hc; // Address for LCR
    apb_item.PWDATA = 8'h03; // 8 data bits, no parity, 1 stop bit
    apb_item.PWRITE = 1'b1;
    finish_item(apb_item);

    `uvm_info("UART_SEQ", "Configured LCR (8 data bits, no parity, 1 stop bit)", UVM_MEDIUM)

    // Step 4: Enable FIFO (FCR)
    start_item(apb_item);
    apb_item.PADDR = 32'h8; // Address for FCR
    apb_item.PWDATA = 8'h01; // Enable FIFO
    apb_item.PWRITE = 1'b1;
    finish_item(apb_item);

    `uvm_info("UART_SEQ", "Configured FCR (FIFO Enabled)", UVM_MEDIUM)

    // Step 5: Write multiple bytes to TX FIFO and handle interrupts
    for (int i = 0; i < 30; i++) begin
      // Write data to TX FIFO
      start_item(apb_item);
      apb_item.PADDR = 32'h0; // Address for TX Data Register
      apb_item.PWDATA = $random; // Data to transmit
      apb_item.PWRITE = 1'b1;
      finish_item(apb_item);

      `uvm_info("UART_SEQ", $sformatf("Transmitted byte %0d to TX FIFO", i), UVM_MEDIUM)

      // Wait for TX FIFO to become empty and TX interrupt to trigger
      repeat (5) begin
        start_item(apb_item);
        apb_item.PADDR = 32'h8; // Address for IIR
        apb_item.PWRITE = 1'b0;
        finish_item(apb_item);
        iir_value = apb_item.PRDATA[3:0]; // Capture IIR value

        if (iir_value == 4'h2) begin
          `uvm_info("UART_SEQ", "TX Interrupt Triggered", UVM_HIGH)

          // Clear TX interrupt by reading TX FIFO (or handle per your logic)
          start_item(apb_item);
          apb_item.PADDR = 32'h0; // Address for TX Data Register (Read to clear TX INT)
          apb_item.PWRITE = 1'b0;
          finish_item(apb_item);

          `uvm_info("UART_SEQ", "TX Interrupt Cleared by Reading TX FIFO", UVM_MEDIUM)
          break;
        end

        #5000; // Add delay to allow interrupt to propagate
      end
    end

    `uvm_info("UART_SEQ", "Completed TX FIFO Interrupt Handling", UVM_HIGH)
  endtask
endclass

