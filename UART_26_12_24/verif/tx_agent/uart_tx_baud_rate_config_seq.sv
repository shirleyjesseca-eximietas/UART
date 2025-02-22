class uart_tx_baud_rate_config_seq extends uvm_sequence #(uart_tx_xtn);
  `uvm_object_utils(uart_tx_baud_rate_config_seq)

     uart_tx_xtn tx_xtn;


  // Class members
  rand bit [31:0] baud_rates [] = '{4800, 9600, 19200, 38400, 57600, 115200, 230400, 460000, 921600};
  rand bit [7:0] tx_data [8]; // Array to hold bytes for transmission

  // Constructor
  function new(string name = "uart_tx_baud_rate_config_seq");
    super.new(name);
  endfunction

  // Body of the sequence
  task body();

    bit [7:0] baud_divisors_dll[] = {8'h1C, 8'h0F, 8'h07, 8'h03, 8'h02, 8'h01, 8'h00, 8'h00, 8'h00}; 
    bit [7:0] baud_divisors_dlm[] ={8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h01, 8'h02, 8'h04};

    tx_xtn = uart_tx_xtn::type_id::create("tx_xtn");

    //time delay_ns;


    // Iterate through baud rates
    foreach (baud_rates[i]) begin
      // Set the DLL (low byte of divisor)
      start_item(tx_xtn);
      tx_xtn.PADDR = 32'h1c; // Address of DLL register
      tx_xtn.PWDATA = baud_divisors_dll[i];
      tx_xtn.PWRITE = 1'b1;
      finish_item(tx_xtn);


      start_item(tx_xtn);
      // Set the DLM (high byte of divisor)
      tx_xtn.PADDR = 32'h20; // Address of DLM register
      tx_xtn.PWDATA = baud_divisors_dlm[i];
       tx_xtn.PWRITE = 1'b1;
      finish_item(tx_xtn);
      
      start_item(tx_xtn);
      // Enable UART transmitter
      tx_xtn.PADDR = 32'hc; // Address of Line Control Register
      tx_xtn.PWDATA = 8'h03; // Configure UART for 8N1 format
      tx_xtn.PWRITE = 1'b1;
      finish_item(tx_xtn);
      


      // Enable transmitter interrupts
      start_item(tx_xtn);
      tx_xtn.PADDR = 32'h8; // Address for FCR
      tx_xtn.PWDATA = 8'h01; // Enable FIFO
      tx_xtn.PWRITE = 1'b1;
      finish_item(tx_xtn);

      // Transmit multiple bytes
      foreach (tx_data[j]) begin
        //int delay_ns = (10000000000 / baud_rates[i]);
    //int bit_delay_ns = 1e9 / baud_rates[i];

    start_item(tx_xtn);
     tx_xtn.PADDR = 32'h0; // Address of Data Register
     tx_xtn.PWDATA = tx_data[j];
     tx_xtn.PWRITE = 1'b1;

    finish_item(tx_xtn);

    #60000;

      end

    end
  endtask : body

endclass : uart_tx_baud_rate_config_seq


