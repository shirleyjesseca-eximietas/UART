import uvm_pkg::*;
`include "uvm_macros.svh"
class uart_tx_xtn extends uvm_sequence_item;
  `uvm_object_utils(uart_tx_xtn)

  // APB-related fields
  bit PRESETn;            // Reset signal
  bit [31:0] PADDR;       // Address
  bit [31:0] PWDATA;      // Write data
  bit PWRITE;             // Write enable
  bit PSEL;               // Select signal
  bit PENABLE;            // Enable signal
  bit [31:0] PRDATA;      // Read data
  bit PSLVERR;            // Slave error response
  bit PREADY;             // Ready signal

  // UART TX-related fields
  bit TXD;               // UART transmitter output
  bit IRQ;            // UART event signal


  bit tx_fifo_empty;
  bit tx_fifo_full;
  
  bit [4:0] tx_fifo_count;

  bit tx_busy;
  bit [7:0] LCR;
  bit nCTS;





  // Constructor
  extern function new(string name = "uart_tx_xtn");

  // Print function for debugging
  extern function void do_print(uvm_printer printer);

  // Convert to string for logs
  extern function string convert2string();

endclass

// Constructor implementation
function uart_tx_xtn::new(string name = "uart_tx_xtn");
  super.new(name);
endfunction

// Print function implementation
function void uart_tx_xtn::do_print(uvm_printer printer);
  super.do_print(printer);
  printer.print_field("PRESETn", PRESETn, 1, UVM_BIN);
  printer.print_field("PADDR", PADDR, $bits(PADDR), UVM_HEX);
  printer.print_field("PWDATA", PWDATA, $bits(PWDATA), UVM_HEX);
  printer.print_field("PWRITE", PWRITE, 1, UVM_BIN);
  printer.print_field("PSEL", PSEL, 1, UVM_BIN);
  printer.print_field("PENABLE", PENABLE, 1, UVM_BIN);
  printer.print_field("PRDATA", PRDATA, $bits(PRDATA), UVM_HEX);
  printer.print_field("PSLVERR", PSLVERR, 1, UVM_BIN);
  printer.print_field("PREADY", PREADY, 1, UVM_BIN);
  printer.print_field("TXD", TXD, 1, UVM_BIN);
  printer.print_field("IRQ", IRQ, 1, UVM_BIN);
endfunction

// Convert to string implementation
function string uart_tx_xtn::convert2string();
  return $sformatf("PRESETn=%0b, PADDR=0x%0h, PWDATA=0x%0h, PWRITE=%0b, PSEL=%0b, PENABLE=%0b, PRDATA=0x%0h, PSLVERR=%0b, PREADY=%0b, TXD=%0b, IRQ=%0b", 
                    PRESETn, PADDR, PWDATA, PWRITE, PSEL, PENABLE, PRDATA, PSLVERR, PREADY, TXD, IRQ);
endfunction
