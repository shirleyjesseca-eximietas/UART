class uart_rx_seq extends uvm_sequence #(uart_rx_xtn);

  `uvm_object_utils(uart_rx_seq)

  uart_rx_xtn seq_item;

  function new(string name = "uart_rx_seq");
    super.new(name);
  endfunction

  task body();

      int baud_divisor = 16'd27;       // Example divisor for 115200 baud at 50 MHz clock

    // Step 1: Configure the Baud Rate (DIV1 and DIV2)
    seq_item = uart_rx_xtn::type_id::create("seq_item");
    seq_item.rdata_done = 0;
    seq_item.PADDR = 32'h1c; // Address for DIV1
    seq_item.PWDATA = baud_divisor[7:0]; // Lower byte of divisor
    seq_item.PWRITE = 1'b1;
    start_item(seq_item);
    finish_item(seq_item);

    seq_item.PADDR = 32'h20; // Address for DIV2
    seq_item.PWDATA = baud_divisor[15:8]; // Upper byte of divisor
    seq_item.PWRITE = 1'b1;
    start_item(seq_item);
    finish_item(seq_item);

    `uvm_info("UART_SEQ", $sformatf("Configured Baud Rate Divisor (DIV1=0x%0h, DIV2=0x%0h)", 
                                     baud_divisor[7:0], baud_divisor[15:8]), UVM_MEDIUM)

    // Step 2: Configure the Line Control Register (LCR)
    seq_item.PADDR = 32'hc; // Address for LCR
    seq_item.PWDATA = 8'b00001011; // 8 PWDATA bits, parity, 1 stop bit
    seq_item.PWRITE = 1'b1;
    start_item(seq_item);
    finish_item(seq_item);

    `uvm_info("UART_SEQ", "Configured LCR (8 PWDATA bits, parity, 1 stop bit)", UVM_MEDIUM)

    // Step 3: Configure the Interrupt (IER)
    seq_item.PADDR = 32'h4; // Address for IER
    seq_item.PWDATA = 8'b00000111; // Enable RDA interrupt, THR empty, rx line status
    seq_item.PWRITE = 1'b1;
    start_item(seq_item);
    finish_item(seq_item);

    `uvm_info("UART_SEQ", "Configured IER (Interrupts Enabled)", UVM_MEDIUM)


    // Step 4: Configure the FIFO (FCR)
    seq_item.PADDR = 32'h8; // Address for FCR
    seq_item.PWDATA = 8'b11001111; // Enable FIFO
    seq_item.PWRITE = 1'b1;
    start_item(seq_item);
    finish_item(seq_item);

    `uvm_info("UART_SEQ", "Configured FCR (FIFO Enabled)", UVM_MEDIUM)

    endtask
endclass


