class uart_rx_seqr extends uvm_sequencer #(uart_rx_xtn,uart_rx_xtn);
`uvm_component_utils(uart_rx_seqr)

extern function new(string name = "uart_rx_seqr", uvm_component parent);
endclass

function uart_rx_seqr::new(string name = "uart_rx_seqr", uvm_component parent);
super.new(name,parent);
endfunction
