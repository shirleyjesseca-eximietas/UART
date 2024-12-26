class uart_tx_seqr extends uvm_sequencer #(uart_tx_xtn);
`uvm_component_utils(uart_tx_seqr)

extern function new(string name = "uart_tx_seqr", uvm_component parent);
endclass

function uart_tx_seqr::new(string name = "uart_tx_seqr", uvm_component parent);
super.new(name,parent);
endfunction
