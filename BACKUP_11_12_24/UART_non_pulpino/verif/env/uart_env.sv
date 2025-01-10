class uart_env extends uvm_env;
`uvm_component_utils(uart_env)

uart_virtual_seqr v_seqr;
uart_tx_scoreboard sb;
uart_env_cfg m_cfg;
uart_tx_cfg tx_cfg;
//uart_rx_cfg rx_cfg;

uart_tx_agent tx_agent;
//uart_rx_agent rx_agent;

extern function new(string name = "uart_env", uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);

endclass

function uart_env::new(string name = "uart_env", uvm_component parent);
super.new(name, parent);
endfunction

function void uart_env::build_phase(uvm_phase phase);
super.build_phase(phase);

tx_agent = uart_tx_agent::type_id::create("tx_agent",this);
//rx_agent = uart_rx_agent::type_id::create("rx_agent",this);

if(!uvm_config_db #(uart_env_cfg)::get(this,"*","uart_env_cfg",m_cfg))
	`uvm_fatal("CONFIGURATION","Failed to get() in uart_env")

//uvm_config_db #(uart_tx_cfg)::set(this,"tx_agent*","uart_tx_cfg",m_cfg.tx_cfg);
uvm_config_db #(uart_tx_cfg)::set(this,"*","uart_tx_cfg",m_cfg.tx_cfg);
//uvm_config_db #(uart_rx_cfg)::set(this,"rx_agent*","uart_rx_cfg",m_cfg.rx_cfg);

if(m_cfg.has_scoreboard == 1)
	sb = uart_tx_scoreboard::type_id::create("sb",this);

//if(m_cfg.has_virtual_sequencer == 1)
	v_seqr = uart_virtual_seqr::type_id::create("v_seqr",this);

endfunction

function void uart_env::connect_phase(uvm_phase phase);
super.connect_phase(phase);

//if(m_cfg.has_virtual_sequencer == 1) 
//	begin
	v_seqr.tx_seqrh = tx_agent.seqr;
	//v_seqr.rx_seqrh = rx_agent.seqr;
//	end

if(m_cfg.has_scoreboard == 1)
	begin
      //tx_agent.mon.monitor_port.connect(sb.uart_fifo);
      /*rx_agent.drv.driver_apb_port.connect(sb.rx_drv_apb_fifo);
      rx_agent.mon.monitor_rx_port.connect(sb.rx_mon_rx_fifo);*/
      //tx_agent.mon.monitor_tx_port.connect(sb.tx_mon_tx_fifo); 
	end

endfunction




