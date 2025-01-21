class tx_side extends uvm_sequence #(uart_tx_xtn);
  `uvm_object_utils(tx_side)

  // Transaction object
  uart_tx_xtn tx_xtn;
  
  // Constructor
  function new(string name = "tx_side");
    super.new(name);
  endfunction

  // Main body
  virtual task body();
    bit [7:0] tx_data;

    // Step 1: Configure clock divisors (CLK_DIV1 and CLK_DIV2)
    uvm_report_info(get_name(), "Configuring clock divisors.", UVM_LOW);
    tx_xtn = uart_tx_xtn::type_id::create("tx_xtn");
    
    start_item(tx_xtn);
    tx_xtn.PRESETn = 1'b1;
    tx_xtn.PWRITE = 1; // Write operation
    tx_xtn.PADDR = 32'h1c; // Address for CLK_DIV1 (shifted to [6:2])
    tx_xtn.PWDATA = 8'h04; // Example divisor value for CLK_DIV1
    finish_item(tx_xtn);
    
    
    start_item(tx_xtn);
    tx_xtn.PWRITE = 1;
    tx_xtn.PADDR = 32'h20; // Address for CLK_DIV2 (shifted to [6:2])
    tx_xtn.PWDATA = 8'h0; // Example divisor value for CLK_DIV2
    finish_item(tx_xtn);

    // Step 2: Enable loopback mode
    uvm_report_info(get_name(), "Enabling loopback mode.", UVM_LOW);
    start_item(tx_xtn);
    tx_xtn.PWRITE = 1;
    tx_xtn.PADDR = 32'h10; // Address of the control register (shifted to [6:2])
    tx_xtn.PWDATA = 8'h10; // Set bit 4 to enable
    finish_item(tx_xtn);
    
    //added
    
     //  Configure Line Control Register (LCR)
    start_item(tx_xtn);
    tx_xtn.PADDR = 32'hc; // Address for LCR
    tx_xtn.PWDATA = 8'h07; 
    tx_xtn.PWRITE = 1'b1;

    finish_item(tx_xtn);
    

    `uvm_info("UART_SEQ", "Configured LCR (8 data bits, no parity, 1 stop bit)", UVM_MEDIUM)

    //  Enable FIFO (FCR)
    start_item(tx_xtn);
    tx_xtn.PADDR = 32'h8; // Address for FCR
    tx_xtn.PWDATA = 8'h01; // Enable FIFO
    tx_xtn.PWRITE = 1'b1;

    finish_item(tx_xtn);

    `uvm_info("UART_SEQ", "Configured FCR (FIFO Enabled)", UVM_MEDIUM)
    
    //added
    

    // Step 3: Transmit data
    uvm_report_info(get_name(), "Transmitting data in loopback mode.", UVM_LOW);
    
    for(int i=0; i<7; i++) begin
      start_item(tx_xtn);
      tx_xtn.PADDR = 32'h0; // Address for TX Data Register
      tx_xtn.PWDATA = $urandom; // Data to transmit
      tx_xtn.PWRITE = 1'b1;
      finish_item(tx_xtn);


      #8000; // Small delay to simulate the time between transmissions
    end
    
  endtask
  
endclass


class rx_side extends uvm_sequence #(uart_rx_xtn);
  `uvm_object_utils(rx_side)
  
   uart_rx_xtn rx_xtn;
  
  // Constructor
  function new(string name = "rx_side");
    super.new(name);
  endfunction

  // Main body
  
  virtual task body();
    bit [7:0] rx_data;
   
    `uvm_info("UART_SEQ", "RX SIDE", UVM_MEDIUM)
    
  rx_xtn = uart_rx_xtn::type_id::create("rx_xtn");
  
  for(int i=0; i<20; i++) begin
      start_item(rx_xtn);
      rx_xtn.PADDR = 32'h0; // Address for RX Data Register
      rx_xtn.PWRITE = 1'b0;
      finish_item(rx_xtn);


      #8000; // Small delay to simulate the time between transmissions //10000
    end
    
  endtask
endclass
  

  
