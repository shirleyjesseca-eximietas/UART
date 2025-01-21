import uvm_pkg::*;
`include "uvm_macros.svh"
class uart_env extends uvm_env;
`uvm_component_utils(uart_env)

uart_virtual_seqr v_seqr;
uart_scoreboard sb;
uart_env_cfg m_cfg;
uart_wr_cfg wr_cfg;
uart_rd_cfg rd_cfg;

uart_wr_agent wr_agent;
uart_rd_agent rd_agent;

extern function new(string name = "uart_env", uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);

endclass

function uart_env::new(string name = "uart_env", uvm_component parent);
super.new(name, parent);
endfunction

function void uart_env::build_phase(uvm_phase phase);
super.build_phase(phase);

wr_agent = uart_wr_agent::type_id::create("wr_agent",this);
rd_agent = uart_rd_agent::type_id::create("rd_agent",this);

if(!uvm_config_db #(uart_env_cfg)::get(this,"*","uart_env_cfg",m_cfg))
	`uvm_fatal("CONFIGURATION","Failed to get() in uart_env")

uvm_config_db #(uart_wr_cfg)::set(this,"wr_agent*","uart_wr_cfg",m_cfg.wr_cfg);
uvm_config_db #(uart_rd_cfg)::set(this,"rd_agent*","uart_rd_cfg",m_cfg.rd_cfg);

if(m_cfg.has_scoreboard == 1)
	sb = uart_scoreboard::type_id::create("sb",this);

if(m_cfg.has_virtual_sequencer == 1)
	v_seqr = uart_virtual_seqr::type_id::create("v_seqr",this);

endfunction

function void uart_env::connect_phase(uvm_phase phase);
super.connect_phase(phase);

if(m_cfg.has_virtual_sequencer == 1) 
	begin
	v_seqr.wr_seqrh = wr_agent.seqr;
	v_seqr.rd_seqrh = rd_agent.seqr;
	end

if(m_cfg.has_scoreboard == 1)
	begin
      wr_agent.mon.monitor_port.connect(sb.wr_mon_fifo);
      rd_agent.drv.driver_apb_port.connect(sb.rd_drv_apb_fifo);
      rd_agent.mon.monitor_rx_port.connect(sb.rd_mon_rx_fifo);
	  wr_agent.mon.monitor_tx_port.connect(sb.wr_mon_tx_fifo);
	end

endfunction
