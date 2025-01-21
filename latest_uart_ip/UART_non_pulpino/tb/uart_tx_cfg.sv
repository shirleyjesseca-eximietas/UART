class uart_tx_cfg extends uvm_object;
`uvm_object_utils(uart_tx_cfg)


virtual uart_if vif;
uvm_active_passive_enum is_active;

extern function new(string name = "uart_tx_cfg");
endclass

function uart_tx_cfg::new(string name = "uart_tx_cfg");
super.new(name);
endfunction
