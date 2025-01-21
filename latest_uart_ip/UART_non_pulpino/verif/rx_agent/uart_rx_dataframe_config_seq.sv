class uart_rx_dataframe_config_seq extends uart_rx_seq;

  `uvm_object_utils(uart_rx_dataframe_config_seq)

  uart_rx_xtn seq_item;

  function new(string name = "uart_rx_dataframe_config_seq");
    super.new(name);
  endfunction

  task body();

    super.baud_rate_generator();

    // Step 1: Configure the Baud Rate (DIV1 and DIV2)
    seq_item = uart_rx_xtn::type_id::create("seq_item");

    start_item(seq_item);
    seq_item.PRESETn = 1'b1;
    seq_item.parity_err_inj=0;
    seq_item.rdata_done = 0;
    seq_item.PADDR = 32'h20; // Address for DIV2
    seq_item.PWDATA = baud_divisor[15:8]; // Upper byte of divisor
    seq_item.PWRITE = 1'b1;
    finish_item(seq_item);

    start_item(seq_item);
    seq_item.PADDR = 32'h1c; // Address for DIV1
    seq_item.PWDATA = baud_divisor[7:0]; // Lower byte of divisor
    seq_item.PWRITE = 1'b1;
    finish_item(seq_item);

`uvm_info("RX_DIV_FIX",$sformatf("The Divisor value = %0d",baud_divisor),UVM_LOW)

    start_item(seq_item);
    // Step 2: Configure the Line Control Register (LCR) 8bit dataframe
    seq_item.PADDR = 32'hc; // Address for LCR
    seq_item.PWDATA = 8'b00001000; // 5 PWDATA bits, parity, 1 stop bit
    seq_item.PWRITE = 1'b1;
    finish_item(seq_item);

    `uvm_info("UART_SEQ", "Configured LCR (5 PWDATA bits, parity, 1 stop bit)", UVM_MEDIUM)


    start_item(seq_item);
    // Step 3: Configure the Modem Control Register (MCR)
    seq_item.PADDR = 32'h10; // Address for MCR
    seq_item.PWDATA = 4'b0010;
    seq_item.PWRITE = 1'b1;
    finish_item(seq_item);

    `uvm_info("UART_SEQ", "Configured MCR (Enabled RTS)", UVM_MEDIUM)


    start_item(seq_item);
        // Step 4: Configure the Interrupt (IER)
    seq_item.PADDR = 32'h4; // Address for IER
    seq_item.PWDATA = 8'b00000111; // Enable RDA interrupt, THR empty, rx line status
    seq_item.PWRITE = 1'b1;
    finish_item(seq_item);

    `uvm_info("UART_SEQ", "Configured IER (Interrupts Enabled)", UVM_MEDIUM)


    start_item(seq_item);
        // Step 5: Configure the FIFO (FCR)
    seq_item.PADDR = 32'h8; // Address for FCR
    seq_item.PWDATA = 8'h01; // Enable FIFO
    seq_item.PWRITE = 1'b1;
    finish_item(seq_item);


    `uvm_info("UART_SEQ", "Configured FCR (FIFO Enabled)", UVM_MEDIUM)
    start_item(seq_item); 
    seq_item.baud_period = baud_period;  
    seq_item.PADDR = 32'h0; //RBR (Reciever Buffer Register Address)
    seq_item.PWDATA = 32'h0;     
    seq_item.PWRITE = 1'b0; //READ OPERATION
    seq_item.rcvn_data = $random;
    seq_item.rdata_done = 1;
    finish_item(seq_item);

         `uvm_info("RX_SEQ",$sformatf("The received data in parallel form = %d",seq_item.rcvn_data),UVM_LOW)

        start_item(seq_item);
    seq_item.parity_err_inj=0;
    seq_item.rdata_done = 0;
    seq_item.PADDR = 32'h20; // Address for DIV2
    seq_item.PWDATA = baud_divisor[15:8]; // Upper byte of divisor
    seq_item.PWRITE = 1'b1;
    finish_item(seq_item);

    start_item(seq_item);
    seq_item.PADDR = 32'h1c; // Address for DIV1
    seq_item.PWDATA = baud_divisor[7:0]; // Lower byte of divisor
    seq_item.PWRITE = 1'b1;
    finish_item(seq_item);

`uvm_info("RX_DIV_FIX",$sformatf("The Divisor value = %0d",baud_divisor),UVM_LOW)

    start_item(seq_item);
    // Step 2: Configure the Line Control Register (LCR) 8bit dataframe
    seq_item.PADDR = 32'hc; // Address for LCR
    seq_item.PWDATA = 8'b00001001; // 6 PWDATA bits, parity, 1 stop bit
    seq_item.PWRITE = 1'b1;
    finish_item(seq_item);

    `uvm_info("UART_SEQ", "Configured LCR (6 PWDATA bits, parity, 1 stop bit)", UVM_MEDIUM)


    start_item(seq_item);
    // Step 3: Configure the Modem Control Register (MCR)
    seq_item.PADDR = 32'h10; // Address for MCR
    seq_item.PWDATA = 4'b0010;
    seq_item.PWRITE = 1'b1;
    finish_item(seq_item);

    `uvm_info("UART_SEQ", "Configured MCR (Enabled RTS)", UVM_MEDIUM)


    start_item(seq_item);
        // Step 4: Configure the Interrupt (IER)
    seq_item.PADDR = 32'h4; // Address for IER
    seq_item.PWDATA = 8'b00000111; // Enable RDA interrupt, THR empty, rx line status
    seq_item.PWRITE = 1'b1;
    finish_item(seq_item);

    `uvm_info("UART_SEQ", "Configured IER (Interrupts Enabled)", UVM_MEDIUM)


    start_item(seq_item);
        // Step 5: Configure the FIFO (FCR)
    seq_item.PADDR = 32'h8; // Address for FCR
    seq_item.PWDATA = 8'h01; // Enable FIFO
    seq_item.PWRITE = 1'b1;
    finish_item(seq_item);


    `uvm_info("UART_SEQ", "Configured FCR (FIFO Enabled)", UVM_MEDIUM)

    start_item(seq_item); 
    seq_item.baud_period = baud_period;  
    seq_item.PADDR = 32'h0; //RBR (Reciever Buffer Register Address)
    seq_item.PWDATA = 32'h0;     
    seq_item.PWRITE = 1'b0; //READ OPERATION
    seq_item.rcvn_data = $random;
    seq_item.rdata_done = 1;
    finish_item(seq_item);

            start_item(seq_item);
    seq_item.parity_err_inj=0;
    seq_item.rdata_done = 0;
    seq_item.PADDR = 32'h20; // Address for DIV2
    seq_item.PWDATA = baud_divisor[15:8]; // Upper byte of divisor
    seq_item.PWRITE = 1'b1;
    finish_item(seq_item);

    start_item(seq_item);
    seq_item.PADDR = 32'h1c; // Address for DIV1
    seq_item.PWDATA = baud_divisor[7:0]; // Lower byte of divisor
    seq_item.PWRITE = 1'b1;
    finish_item(seq_item);

`uvm_info("RX_DIV_FIX",$sformatf("The Divisor value = %0d",baud_divisor),UVM_LOW)



    start_item(seq_item);
    // Step 3: Configure the Modem Control Register (MCR)
    seq_item.PADDR = 32'h10; // Address for MCR
    seq_item.PWDATA = 4'b0010;
    seq_item.PWRITE = 1'b1;
    finish_item(seq_item);

    `uvm_info("UART_SEQ", "Configured MCR (Enabled RTS)", UVM_MEDIUM)


    start_item(seq_item);
        // Step 4: Configure the Interrupt (IER)
    seq_item.PADDR = 32'h4; // Address for IER
    seq_item.PWDATA = 8'b00000111; // Enable RDA interrupt, THR empty, rx line status
    seq_item.PWRITE = 1'b1;
    finish_item(seq_item);

    `uvm_info("UART_SEQ", "Configured IER (Interrupts Enabled)", UVM_MEDIUM)

        start_item(seq_item);
    // Step 2: Configure the Line Control Register (LCR) 8bit dataframe
    seq_item.PADDR = 32'hc; // Address for LCR
    seq_item.PWDATA = 8'b00001010; // 7 PWDATA bits, parity, 1 stop bit
    seq_item.PWRITE = 1'b1;
    finish_item(seq_item);

    `uvm_info("UART_SEQ", "Configured LCR (7 PWDATA bits, parity, 1 stop bit)", UVM_MEDIUM)



    start_item(seq_item);
        // Step 5: Configure the FIFO (FCR)
    seq_item.PADDR = 32'h8; // Address for FCR
    seq_item.PWDATA = 8'h01; // Enable FIFO
    seq_item.PWRITE = 1'b1;
    finish_item(seq_item);


    `uvm_info("UART_SEQ", "Configured FCR (FIFO Enabled)", UVM_MEDIUM)

    start_item(seq_item); 
    seq_item.baud_period = baud_period;  
    seq_item.PADDR = 32'h0; //RBR (Reciever Buffer Register Address)
    seq_item.PWDATA = 32'h0;     
    seq_item.PWRITE = 1'b0; //READ OPERATION
    seq_item.rcvn_data = $random;
    seq_item.rdata_done = 1;
    finish_item(seq_item);


            start_item(seq_item);
    seq_item.parity_err_inj=0;
    seq_item.rdata_done = 0;
    seq_item.PADDR = 32'h20; // Address for DIV2
    seq_item.PWDATA = baud_divisor[15:8]; // Upper byte of divisor
    seq_item.PWRITE = 1'b1;
    finish_item(seq_item);

    start_item(seq_item);
    seq_item.PADDR = 32'h1c; // Address for DIV1
    seq_item.PWDATA = baud_divisor[7:0]; // Lower byte of divisor
    seq_item.PWRITE = 1'b1;
    finish_item(seq_item);

`uvm_info("RX_DIV_FIX",$sformatf("The Divisor value = %0d",baud_divisor),UVM_LOW)

    start_item(seq_item);
    // Step 2: Configure the Line Control Register (LCR) 8bit dataframe
    seq_item.PADDR = 32'hc; // Address for LCR
    seq_item.PWDATA = 8'b00011011; // 8 PWDATA bits, parity, 1 stop bit
    seq_item.PWRITE = 1'b1;
    finish_item(seq_item);

    `uvm_info("UART_SEQ", "Configured LCR (8 PWDATA bits, parity, 1 stop bit)", UVM_MEDIUM)


    start_item(seq_item);
    // Step 3: Configure the Modem Control Register (MCR)
    seq_item.PADDR = 32'h10; // Address for MCR
    seq_item.PWDATA = 4'b0010;
    seq_item.PWRITE = 1'b1;
    finish_item(seq_item);

    `uvm_info("UART_SEQ", "Configured MCR (Enabled RTS)", UVM_MEDIUM)


    start_item(seq_item);
        // Step 4: Configure the Interrupt (IER)
    seq_item.PADDR = 32'h4; // Address for IER
    seq_item.PWDATA = 8'b00000111; // Enable RDA interrupt, THR empty, rx line status
    seq_item.PWRITE = 1'b1;
    finish_item(seq_item);

    `uvm_info("UART_SEQ", "Configured IER (Interrupts Enabled)", UVM_MEDIUM)


    start_item(seq_item);
        // Step 5: Configure the FIFO (FCR)
    seq_item.PADDR = 32'h8; // Address for FCR
    seq_item.PWDATA = 8'h01; // Enable FIFO
    seq_item.PWRITE = 1'b1;
    finish_item(seq_item);


    `uvm_info("UART_SEQ", "Configured FCR (FIFO Enabled)", UVM_MEDIUM)

    start_item(seq_item); 
    seq_item.baud_period = baud_period;  
    seq_item.PADDR = 32'h0; //RBR (Reciever Buffer Register Address)
    seq_item.PWDATA = 32'h0;     
    seq_item.PWRITE = 1'b0; //READ OPERATION
    seq_item.rcvn_data = $random;
    seq_item.rdata_done = 1;
    finish_item(seq_item);



    
    
    endtask
endclass

