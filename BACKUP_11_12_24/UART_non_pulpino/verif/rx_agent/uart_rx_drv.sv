class uart_rx_drv extends uvm_driver #(uart_rx_xtn);
`uvm_component_utils(uart_rx_drv)

virtual uart_if vif;
uart_rx_xtn xtn;
uart_rx_cfg rx_cfg;
uart_env_cfg env_cfg;
uvm_analysis_port #(uart_rx_xtn) driver_apb_port;

extern function new(string name = "uart_rx_drv", uvm_component parent);
extern function void build_phase (uvm_phase phase);
extern function void connect_phase (uvm_phase phase);
extern task run_phase (uvm_phase phase);
extern task send_to_dut (uart_rx_xtn xtn);

endclass

function uart_rx_drv::new(string name = "uart_rx_drv", uvm_component parent);
super.new(name, parent);
driver_apb_port = new("driver_apb_port",this);
endfunction

function void uart_rx_drv::build_phase(uvm_phase phase);
super.build_phase(phase);
if(!uvm_config_db #(uart_rx_cfg)::get(this,"","uart_rx_cfg",rx_cfg))
	`uvm_fatal("CONFIGURATION","Failed to get(uart_rx_cfg) in uart_rx_drv")

if(!uvm_config_db #(uart_env_cfg)::get(this,"","uart_env_cfg",env_cfg))
	`uvm_fatal("CONFIGURATION","Failed to get(uart_env_cfg) in uart_rx_drv")


endfunction

function void uart_rx_drv::connect_phase(uvm_phase phase);
super.connect_phase(phase);
vif = rx_cfg.vif;
endfunction

task uart_rx_drv::run_phase(uvm_phase phase);

forever begin
	seq_item_port.get_next_item(req);
	send_to_dut(req);
	seq_item_port.item_done();
end
endtask

task uart_rx_drv::send_to_dut(uart_rx_xtn xtn);
`uvm_info("RD_DRIVER",$sformatf("Printing from Read Driver \n %s",xtn.sprint()),UVM_LOW)

@(posedge vif.clock);

  
endtask


