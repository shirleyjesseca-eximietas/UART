
class uart_tx_non_standard_dvsr_seq extends uvm_sequence #(uart_tx_xtn);

  `uvm_object_utils(uart_tx_non_standard_dvsr_seq)

  uart_tx_xtn apb_item;

  function new(string name = "uart_tx_non_standard_dvsr_seq");
    super.new(name);
  endfunction

  task body();
    bit [7:0] byte_to_transmit = 8'hA1; // Byte to transmit without programming divisor

    apb_item = uart_tx_xtn::type_id::create("apb_item");
    
  // Write to DIV1 (lower byte)
  start_item(apb_item);
    apb_item.PRESETn = 1'b1;
  apb_item.PADDR = 32'h1c;              // Address for DIV1
  apb_item.PWDATA = 32'hAB;             // Non-standard lower byte (example: 0xAB)
  apb_item.PWRITE = 1'b1;

  finish_item(apb_item);

  // Write to DIV2 (upper byte)
  start_item(apb_item);
  apb_item.PADDR = 32'h20;              // Address for DIV2
  apb_item.PWDATA = 32'hCD;             // Non-standard upper byte (example: 0xCD)
  apb_item.PWRITE = 1'b1;

  finish_item(apb_item);
    

      // Step 2: Configure Line Control Register (LCR) - No Divisor Latch Programming
    start_item(apb_item);
    apb_item.PADDR = 32'hC; // Address for Line Control Register (LCR)
    apb_item.PWDATA = 8'h03; // 8 data bits, no parity, 1 stop bit
    apb_item.PWRITE = 1'b1;
    finish_item(apb_item);

// Step 3: Enable FIFO (FCR)
    start_item(apb_item);
    apb_item.PADDR = 32'h8; // Address for FCR
    apb_item.PWDATA = 8'h01; // Enable FIFO
    apb_item.PWRITE = 1'b1;

    finish_item(apb_item);

    // Step 3: Attempt to Write Byte to TX FIFO Without Programming Divisor
    `uvm_info("UART_SEQ", "Attempting to Write Byte to TX FIFO without programming Divisor Latch...", UVM_MEDIUM)

    start_item(apb_item);
    apb_item.PADDR = 32'h0; // Address for TX Data Register
    apb_item.PWDATA = byte_to_transmit; // Data to transmit
    apb_item.PWRITE = 1'b1;
    finish_item(apb_item);

    `uvm_info("UART_SEQ", $sformatf("Written byte 0x%0h to TX FIFO without Divisor Latch programming", byte_to_transmit), UVM_MEDIUM)

    // Step 4: Check for Unexpected Behavior (TXD or IRQ assertion)
    `uvm_info("UART_SEQ", "Observing UART TX Output and IRQ Behavior...", UVM_MEDIUM)

    start_item(apb_item);
    apb_item.PADDR = 32'h4; // Address for Line Status Register (LSR) or status check
    apb_item.PWRITE = 1'b0; // Read operation
    finish_item(apb_item);

   #13000; 

    `uvm_info("UART_SEQ", "Exception Handling Test Completed: Divisor Latch Not Programmed.", UVM_MEDIUM)

  endtask
endclass


