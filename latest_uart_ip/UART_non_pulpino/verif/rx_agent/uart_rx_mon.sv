class uart_rx_mon extends uvm_monitor;
`uvm_component_utils(uart_rx_mon)

uart_rx_cfg m_cfg;
uart_env_cfg env_cfg;
virtual uart_if vif;
uart_rx_xtn xtn;

uvm_analysis_port #(uart_rx_xtn) monitor_rx_port;

bit[7:0] temp_data;

extern function new(string name = "uart_rx_mon", uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
extern task collect_data();
endclass

function uart_rx_mon::new(string name = "uart_rx_mon", uvm_component parent);
super.new(name, parent);
monitor_rx_port = new("monitor_rx_port",this);
endfunction

function void uart_rx_mon::build_phase(uvm_phase phase);
super.build_phase(phase);

if(!uvm_config_db #(uart_rx_cfg)::get(this,"","uart_rx_cfg",m_cfg))
	`uvm_fatal("CONFIGURATION","Failed to get() in uart_rx_mon")

endfunction

function void uart_rx_mon::connect_phase(uvm_phase phase);
super.connect_phase(phase);
vif = m_cfg.vif;
endfunction

task uart_rx_mon::run_phase(uvm_phase phase);
forever begin
	collect_data();
end
  
endtask
  
 task uart_rx_mon::collect_data();
xtn = uart_rx_xtn::type_id::create("xtn");

@(negedge vif.clock);
  // Populate transaction fields from the virtual interface
      xtn.RXD = vif.RXD;                // UART receiver signal
      xtn.IRQ = vif.IRQ;                // IRQ signal
      xtn.PADDR = vif.PADDR;           // APB address
      xtn.PWDATA = vif.PWDATA;         // APB write data
      xtn.PRDATA = vif.PRDATA;         // APB read data
      xtn.PWRITE = vif.PWRITE;         // APB write enable
      xtn.PENABLE = vif.PENABLE;       // APB enable signal
      xtn.PSEL = vif.PSEL;             // APB select signal
      xtn.PREADY = vif.PREADY;         // APB ready signal
      xtn.nRTS = vif.nRTS;
      xtn.PRESETn = vif.PRESETn;


      if(vif.PRDATA !=0)
	      `uvm_info("RX_MONITOR",$sformatf("The value of PRDATA = %0d",vif.PRDATA),UVM_LOW)

      //`uvm_info("RX_MON", $sformatf("Printing from RX_MONITOR : \n%s", xtn.sprint), UVM_LOW)

      // Send the transaction to the analysis port
      monitor_rx_port.write(xtn);

 
 endtask

          


