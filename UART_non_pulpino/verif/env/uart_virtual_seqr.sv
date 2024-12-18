class uart_virtual_seqr extends uvm_sequencer #(uvm_sequence_item);
`uvm_component_utils(uart_virtual_seqr)

uart_tx_seqr tx_seqrh;
uart_rx_seqr rx_seqrh;

extern function new(string name = "uart_virtual_seqr", uvm_component parent);
endclass

function uart_virtual_seqr::new(string name = "uart_virtual_seqr", uvm_component parent);
super.new(name,parent);
endfunction
