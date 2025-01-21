class uart_tx_agent extends uvm_agent;
`uvm_component_utils(uart_tx_agent)

uart_tx_drv drv;
uart_tx_mon mon;
uart_tx_seqr tseqr;
uart_tx_cfg m_cfg;

extern function new(string name = "uart_tx_agent", uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
endclass

function uart_tx_agent::new(string name = "uart_tx_agent", uvm_component parent);
super.new(name, parent);
endfunction

function void uart_tx_agent::build_phase(uvm_phase phase);
super.build_phase(phase);
if(!uvm_config_db #(uart_tx_cfg)::get(this,"","uart_tx_cfg",m_cfg))
	`uvm_fatal("CONFIGURATION","Failed to get() in uart_tx_agent")


//Uncomment later - if(m_cfg.is_active == UVM_ACTIVE)
//begin
	drv = uart_tx_drv::type_id::create("drv",this);
  tseqr = uart_tx_seqr::type_id::create("tseqr",this);
	mon = uart_tx_mon::type_id::create("mon",this);
//end

endfunction

function void uart_tx_agent::connect_phase(uvm_phase phase);
super.connect_phase(phase);

//Uncomment later - if(m_cfg.is_active == UVM_ACTIVE)
  drv.seq_item_port.connect(tseqr.seq_item_export);

endfunction


