class uart_rx_agent extends uvm_agent;
`uvm_component_utils(uart_rx_agent)

uart_rx_drv drv;
uart_rx_mon mon;
uart_rx_seqr seqr;
uart_rx_cfg m_cfg;

extern function new(string name = "uart_rx_agent", uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
endclass

function uart_rx_agent::new(string name = "uart_rx_agent", uvm_component parent);
super.new(name, parent);
endfunction

function void uart_rx_agent::build_phase(uvm_phase phase);
super.build_phase(phase);
if(!uvm_config_db #(uart_rx_cfg)::get(this,"","uart_rx_cfg",m_cfg))
	`uvm_fatal("CONFIGURATION","Failed to get() in uart_rx_agent")

mon = uart_rx_mon::type_id::create("mon",this);

if(m_cfg.is_active == UVM_ACTIVE)
begin
	drv = uart_rx_drv::type_id::create("drv",this);
	seqr = uart_rx_seqr::type_id::create("seqr",this);
end

endfunction

function void uart_rx_agent::connect_phase(uvm_phase phase);
super.connect_phase(phase);

if(m_cfg.is_active == UVM_ACTIVE)
	drv.seq_item_port.connect(seqr.seq_item_export);

endfunction

