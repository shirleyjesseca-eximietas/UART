class uart_rx_fifo_overflow_seq extends uart_rx_seq;

  `uvm_object_utils(uart_rx_fifo_overflow_seq)

  uart_rx_xtn seq_item;

  function new(string name = "uart_rx_fifo_overflow_seq");
    super.new(name);
  endfunction

  task body();
int baud_divisor = 16'd27;       // Example divisor for 115200 baud at 50 MHz clock

    // Step 1: Configure the Baud Rate (DIV1 and DIV2)
    seq_item = uart_rx_xtn::type_id::create("seq_item");

    start_item(seq_item);
    seq_item.parity_err_inj=0;
    seq_item.rdata_done = 0;
    seq_item.PADDR = 32'h1c; // Address for DIV1
    seq_item.PWDATA = 32'h04; // Lower byte of divisor
    seq_item.PWRITE = 1'b1;
    finish_item(seq_item);


    start_item(seq_item);
        seq_item.PADDR = 32'h20; // Address for DIV2
    seq_item.PWDATA = 32'h0; // Upper byte of divisor
    seq_item.PWRITE = 1'b1;
    finish_item(seq_item);

    `uvm_info("UART_SEQ", $sformatf("Configured Baud Rate Divisor (DIV1=0x%0h, DIV2=0x%0h)", 
                                     baud_divisor[7:0], baud_divisor[15:8]), UVM_MEDIUM)


    start_item(seq_item);
        // Step 2: Configure the Line Control Register (LCR)
    seq_item.PADDR = 32'hc; // Address for LCR
    seq_item.PWDATA = 8'b00001011; // 8 PWDATA bits, parity, 1 stop bit
    seq_item.PWRITE = 1'b1;
    finish_item(seq_item);

    `uvm_info("UART_SEQ", "Configured LCR (8 PWDATA bits, parity, 1 stop bit)", UVM_MEDIUM)


    start_item(seq_item);
        // Step 3: Configure the Interrupt (IER)
    seq_item.PADDR = 32'h4; // Address for IER
    seq_item.PWDATA = 8'b00000111; // Enable RDA interrupt, THR empty, rx line status
    seq_item.PWRITE = 1'b1;
    finish_item(seq_item);

    `uvm_info("UART_SEQ", "Configured IER (Interrupts Enabled)", UVM_MEDIUM)



    start_item(seq_item);
        // Step 4: Configure the FIFO (FCR)
    seq_item.PADDR = 32'h8; // Address for FCR
    seq_item.PWDATA = 8'h01; // Enable FIFO
    seq_item.PWRITE = 1'b1;
    finish_item(seq_item);

    `uvm_info("UART_SEQ", "Configured FCR (FIFO Enabled)", UVM_MEDIUM)
    for(int i=0; i < 30;i++) begin
	    start_item(seq_item);
    seq_item.PADDR = 32'h0; //RBR (Reciever Buffer Register Address)
    seq_item.PWDATA = 32'h0;     
    seq_item.PWRITE = 1'b0; //READ OPERATION
    seq_item.rcvn_data = $random;
    seq_item.rdata_done = 1;
    finish_item(seq_item);
    end
    
    endtask
endclass

