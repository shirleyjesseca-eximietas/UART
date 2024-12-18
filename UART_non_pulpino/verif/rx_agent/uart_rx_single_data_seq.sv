class uart_rx_single_data_seq extends uart_rx_seq;

  `uvm_object_utils(uart_rx_single_data_seq)

  uart_rx_xtn seq_item;
  bit[15:0] baud_divisor;
  string baudrate; 


  function new(string name = "uart_rx_single_data_seq");
    super.new(name);
  endfunction

/*  task pre_body();

	  //int baud_divisor = 16'd27;       // Example divisor for 115200 baud at 50 MHz clock
//
int baudrate;

if(!uvm_config_db #(int)::get(null,get_full_name,"baudrate",baudrate)) begin
	baudrate = 9600;
	`uvm_warning("UART_RX_SEQ","No Baudrate is set, thus default baudrate value is being used i.e., 9600")
end


case(baudrate)
	'd4800: baud_divisor = 16'd651;
	'd9600: baud_divisor = 16'd326;
	'd19200: baud_divisor = 16'd163;
	'd38400: baud_divisor = 16'd81;
	'd57600: baud_divisor = 16'd54;
	'd115200: baud_divisor = 16'd27;
	'd230400: baud_divisor = 16'd14;
	'd460000: baud_divisor = 16'd7;
	'd921600: baud_divisor = 16'd3;
	default: baud_divisor = 16'd27; //1,15,200 baudrate
endcase
super.pre_body();
endtask*/


  task body();

	  uvm_cmdline_processor inst = uvm_cmdline_processor::get_inst();

	inst.get_arg_value("+baudrate=",baudrate);

	case(baudrate)
	"4800": baud_divisor = 16'd651;
	"9600": baud_divisor = 16'd326;
	"19200": baud_divisor = 16'd163;
	"38400": baud_divisor = 16'd81;
	"57600": baud_divisor = 16'd54;
	"115200": baud_divisor = 16'd27;
	"230400": baud_divisor = 16'd14;
	"460000": baud_divisor = 16'd7;
	"921600": baud_divisor = 16'd3;
	default: baud_divisor = 16'd27; //1,15,200 baudrate
endcase

`uvm_info("UART_RX_SEQ",$sformatf("The Baudrate = %s",baudrate),UVM_LOW)


    // Step 1: Configure the Baud Rate (DIV1 and DIV2)
    seq_item = uart_rx_xtn::type_id::create("seq_item");

    start_item(seq_item);
    seq_item.parity_err_inj=0;
    seq_item.rdata_done = 0;
    seq_item.PADDR = 32'h1c; // Address for DIV1
    seq_item.PWDATA = baud_divisor[7:0]; // Lower byte of divisor
    seq_item.PWRITE = 1'b1;
    finish_item(seq_item);


    start_item(seq_item);
        seq_item.PADDR = 32'h20; // Address for DIV2
    seq_item.PWDATA = baud_divisor[15:8]; // Upper byte of divisor
    seq_item.PWRITE = 1'b1;
    finish_item(seq_item);

    `uvm_info("UART_SEQ", $sformatf("Configured Baud Rate Divisor (DIV1=%0d, DIV2=%0d)", 
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

start_item(seq_item);   
    seq_item.PADDR = 32'h0; //RBR (Reciever Buffer Register Address)
    seq_item.PWDATA = 32'h0;     
    seq_item.PWRITE = 1'b0; //READ OPERATION
    seq_item.rcvn_data = $random;
    seq_item.rdata_done = 1;
    finish_item(seq_item);

    
    endtask
endclass



