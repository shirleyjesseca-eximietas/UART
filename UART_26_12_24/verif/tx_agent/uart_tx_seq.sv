class uart_tx_single_byte_seq extends uvm_sequence #(uart_tx_xtn);

  `uvm_object_utils(uart_tx_single_byte_seq)

  uart_tx_xtn apb_item;

  function new(string name = "uart_tx_single_byte_seq");
    super.new(name);
  endfunction

  task body();
    bit [7:0] byte_to_transmit = 8'hA5; // Byte to transmit
    bit [15:0] baud_divisor = 16'd27; // Example divisor for 115200 baud at 50 MHz clock

    // Step 1: Configure the Baud Rate (DIV1 and DIV2)
    apb_item = uart_tx_xtn::type_id::create("apb_item");
    start_item(apb_item);

    apb_item.PADDR = 5'h7; // Address for DIV1
    apb_item.PWDATA = baud_divisor[7:0]; // Lower byte of divisor
    apb_item.PWRITE = 1'b1;
    apb_item.PSEL = 1'b1;
    apb_item.PENABLE = 1'b0;
    finish_item(apb_item);

    start_item(apb_item);

    apb_item.PADDR = 5'h8; // Address for DIV2
    apb_item.PWDATA = baud_divisor[15:8]; // Upper byte of divisor
    apb_item.PWRITE = 1'b1;
    apb_item.PSEL = 1'b1;
    finish_item(apb_item);


    start_item(apb_item);
    apb_item.PADDR = 5'h3; // Address for LCR
    apb_item.PWDATA = 8'h03; // 8 data bits, no parity, 1 stop bit
    apb_item.PWRITE = 1'b1;
    apb_item.PSEL = 1'b1;
    finish_item(apb_item);

    // Step 3: Configure the FIFO (FCR)
    start_item(apb_item);
    apb_item.PADDR = 5'h2; // Address for FCR
    apb_item.PWDATA = 8'h01; // Enable FIFO
    apb_item.PWRITE = 1'b1;
    apb_item.PSEL = 1'b1;
    finish_item(apb_item);

    start_item(apb_item);

    apb_item.PADDR = 5'h0; // Address for Data Register (DR)
    apb_item.PWDATA = byte_to_transmit;
    apb_item.PWRITE = 1'b1;
    apb_item.PSEL = 1'b1;
    finish_item(apb_item);

  endtask
endclass
