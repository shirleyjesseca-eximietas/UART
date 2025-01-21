import uvm_pkg::*;
`include "uvm_macros.svh"
class uart_rx_cfg extends uvm_object;
`uvm_object_utils(uart_rx_cfg)

virtual uart_if vif;
uvm_active_passive_enum is_active;

extern function new(string name = "uart_rx_cfg");
endclass

function uart_rx_cfg::new(string name = "uart_rx_cfg");
super.new(name);
endfunction
