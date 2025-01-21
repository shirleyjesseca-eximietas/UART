import uvm_pkg::*;
`include "uvm_macros.svh"
class uart_env_cfg extends uvm_object;
`uvm_object_utils(uart_env_cfg)

bit has_scoreboard;
bit has_virtual_sequencer;

typedef bit [7:0] bit_8;

bit_8 dll, ier, dlm, fcr, lcr;
bit_8 lcr_queue[$];

uart_wr_cfg wr_cfg;
uart_rd_cfg rd_cfg;

extern function new(string name = "uart_env_cfg");
endclass

function uart_env_cfg::new(string name = "uart_env_cfg");
super.new(name);
endfunction
