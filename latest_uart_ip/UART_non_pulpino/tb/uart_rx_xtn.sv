class uart_rx_xtn extends uvm_sequence_item;
`uvm_object_utils(uart_rx_xtn)
  
rand bit [11:0] PADDR;
rand bit [31:0] PWDATA;
bit RXD;
bit PRESETn;
rand bit PWRITE;
bit PSEL;
bit PENABLE;
bit [31:0] PRDATA;
bit PREADY, PSLVERR;
bit IRQ;
bit [7:0] rcvn_data;
bit rdata_done;
bit [1:0] bits_num;
bit parity_err_inj, framing_err_inj;
bit nCTS,nRTS;
int frame_size;
int baud_period;

constraint addr1 {PADDR[11:3] == 'h0;}
constraint data1 {PWDATA[31:8] == 'h0;}

extern function new(string name = "uart_rx_xtn");
extern function void do_print(uvm_printer printer);
endclass

function uart_rx_xtn::new(string name = "uart_rx_xtn");
super.new(name);
endfunction

function void uart_rx_xtn::do_print(uvm_printer printer);
super.do_print(printer);
printer.print_field("RESET"      , this.PRESETn  ,  1, UVM_DEC);
printer.print_field("APB ADDRESS", this.PADDR , 12, UVM_DEC);
printer.print_field("APB WDATA"  , this.PWDATA [7:0], 8, UVM_BIN);
printer.print_field("APB WRITE"  , this.PWRITE,  1, UVM_DEC);
printer.print_field("APB SEL"    , this.PSEL  ,  1, UVM_DEC);
printer.print_field("APB ENABLE" , this.PENABLE, 1, UVM_DEC);
printer.print_field("APB READY"  , this.PREADY,  1, UVM_DEC);
printer.print_field("APB SLVERR" , this.PSLVERR,  1, UVM_DEC);
printer.print_field("RECEIVING DATA (SERIALLY)" , this.RXD,  1, UVM_DEC);
printer.print_field("INTERRUPT"  , this.IRQ,  1, UVM_DEC);
printer.print_field("APB RDATA"  , this.PRDATA [7:0], 8, UVM_BIN);
printer.print_field("CTS"  , this.nCTS,  1, UVM_DEC);
printer.print_field("RTS"  , this.nRTS,  1, UVM_DEC);
endfunction
  



