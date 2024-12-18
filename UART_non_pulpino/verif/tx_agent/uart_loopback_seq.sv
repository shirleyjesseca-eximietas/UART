class uart_loopback_seq extends uvm_sequence#(uart_tx_xtn);
  `uvm_object_utils(uart_loopback_seq)

  // Configuration fields
  bit [31:0] base_addr;   // Base address for UART registers
  int num_transfers;      // Number of transactions to send in loopback mode
  bit enable_loopback;    // Flag to enable or disable loopback

  // Constructor
  function new(string name = "uart_loopback_seq");
    super.new(name);
  endfunction

  // Body task for sequence execution
  task body();
    uart_tx_xtn apb_item;  // Transaction item

    // Step 1: Enable loopback mode via register

    bit [7:0] byte_to_transmit = 8'b10010101; // Byte to transmit

   apb_item = uart_tx_xtn::type_id::create("apb_item");

   // Write to DIV1 (lower byte)
    start_item(apb_item);
    apb_item.PADDR = 32'h1c; // Address for DIV1  changed to new value
    apb_item.PWDATA = 32'h04; // Lower byte
    apb_item.PWRITE = 1'b1;

    finish_item(apb_item);

    // Write to DIV2 (upper byte)
    start_item(apb_item);
    apb_item.PADDR = 32'h20; // Address for DIV2
    apb_item.PWDATA = 32'h0; // Upper byte
    apb_item.PWRITE = 1'b1;

    finish_item(apb_item);



    //Set loopback mode
    
    start_item(apb_item);
    apb_item.PADDR = 32'h10; 
    apb_item.PWDATA = 8'h10; 
    apb_item.PWRITE = 1'b1;

    finish_item(apb_item);

    `uvm_info("UART_SEQ", "Set loopback", UVM_MEDIUM)


    //  Configure Line Control Register (LCR)
    start_item(apb_item);
    apb_item.PADDR = 32'hc; // Address for LCR
    apb_item.PWDATA = 8'h03; // 8 data bits, no parity, 1 stop bit
    apb_item.PWRITE = 1'b1;

    finish_item(apb_item);

    `uvm_info("UART_SEQ", "Configured LCR (8 data bits, no parity, 1 stop bit)", UVM_MEDIUM)

    //  Enable FIFO (FCR)
    start_item(apb_item);
    apb_item.PADDR = 32'h8; // Address for FCR
    apb_item.PWDATA = 8'h01; // Enable FIFO
    apb_item.PWRITE = 1'b1;

    finish_item(apb_item);

    `uvm_info("UART_SEQ", "Configured FCR (FIFO Enabled)", UVM_MEDIUM)

    // Write byte to TX FIFO
    start_item(apb_item);
    apb_item.PADDR = 32'h0; // Address for TX Data Register
    apb_item.PWDATA = byte_to_transmit; // Data to transmit
    apb_item.PWRITE = 1'b1;

    finish_item(apb_item);
    #13000;


    `uvm_info("UART_SEQ", $sformatf("Written byte 0x%0h to TX FIFO", byte_to_transmit), UVM_MEDIUM)


    
        
  endtask
endclass
