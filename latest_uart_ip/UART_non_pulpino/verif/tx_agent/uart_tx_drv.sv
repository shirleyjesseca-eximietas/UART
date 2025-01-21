class uart_tx_drv extends uvm_driver #(uart_tx_xtn);
`uvm_component_utils(uart_tx_drv)

virtual uart_if vif;
uart_tx_xtn xtn;
uart_tx_cfg m_cfg;
  

  bit valid_data;

  extern function new(string name = "uart_tx_drv", uvm_component parent);
  extern function void build_phase (uvm_phase phase);
  extern function void connect_phase (uvm_phase phase);
  extern task run_phase (uvm_phase phase);
  extern task send_to_dut (uart_tx_xtn xtn);

endclass

function uart_tx_drv::new(string name = "uart_tx_drv", uvm_component parent);
  super.new(name, parent);
endfunction

function void uart_tx_drv::build_phase(uvm_phase phase);
  super.build_phase(phase);
  if (!uvm_config_db #(uart_tx_cfg)::get(this, "", "uart_tx_cfg", m_cfg))
    `uvm_fatal("CONFIGURATION", "Failed to get() in uart_tx_drv")
  xtn = uart_tx_xtn::type_id::create("xtn");
endfunction

function void uart_tx_drv::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  vif = m_cfg.vif;
endfunction

task uart_tx_drv::run_phase(uvm_phase phase);

//repeat(4) @(posedge vif.clock);


  // Initialization/Reset Logic
  
forever begin
    seq_item_port.get_next_item(xtn);
    send_to_dut(xtn);
    seq_item_port.item_done();
 end
endtask

task uart_tx_drv::send_to_dut(uart_tx_xtn xtn);

  vif.PRESETn <= 1'b1;
   @(posedge vif.clock);

  `uvm_info("TX_DRIVER", $sformatf("Printing from send to dut \n %s", xtn.sprint()), UVM_LOW)

  if(xtn.tx_rst_en) begin
  vif.PRESETn <= 1'b0;
  vif.PSEL <= 0;
  vif.PENABLE <= 0;
  vif.PADDR <= 0;
  vif.PWDATA <= 0;
  vif.PWRITE <= 0;

  repeat(2) @(posedge vif.clock);
  vif.PRESETn <= 1'b1;
  @(posedge vif.clock);
  end


  vif.PSEL <= 1;
  vif.PADDR <= xtn.PADDR;
  vif.PWDATA <= xtn.PWDATA;
  vif.PWRITE <= xtn.PWRITE;
  @(posedge vif.clock);
  vif.PENABLE <= 1;
  
  //@(posedge vif.clock);

  while (!vif.PREADY) 
    @(posedge vif.clock);

  vif.PSEL <= 0;
  vif.PENABLE <= 0;
  @(posedge vif.clock);

endtask

