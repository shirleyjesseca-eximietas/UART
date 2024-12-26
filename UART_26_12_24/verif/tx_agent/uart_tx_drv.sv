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
  `uvm_info("TX_DRIVER", "Printing from WR Driver", UVM_LOW)
  @(posedge vif.clock);

  vif.PSEL <= 0;
  vif.PENABLE <= 0;
  vif.PADDR <= 0;
  vif.PWDATA <= 0;
  vif.PWRITE <= 0;

    vif.PRESETn <=1'b0;
  repeat(3)
  begin
  @(posedge vif.clock);
  end
    vif.PRESETn <=1'b1;

  // Initialization/Reset Logic
  
  `uvm_info("TX_DRIVER", "Printing to start the connection logic - Driver", UVM_LOW)
forever begin
    seq_item_port.get_next_item(xtn);
  `uvm_info("TX_DRIVER", "Printing to start the connection logic1 - Driver", UVM_LOW)
    send_to_dut(xtn);
  `uvm_info("TX_DRIVER", "Printing to start the connection logic2 - Driver", UVM_LOW)
    seq_item_port.item_done();
  `uvm_info("TX_DRIVER", "Printing to start the connection logic3 - Driver", UVM_LOW)
 end
endtask

task uart_tx_drv::send_to_dut(uart_tx_xtn xtn);
  `uvm_info("TX_DRIVER", $sformatf("Printing from send to dut \n %s", xtn.sprint()), UVM_LOW)
  vif.PSEL <= 1;
  vif.PADDR <= xtn.PADDR;
  vif.PWDATA <= xtn.PWDATA;
  vif.PWRITE <= xtn.PWRITE;
  
  vif.nCTS <= 1'b0;  // Assert CTS (Clear to send)
  vif.nDSR <= 1'b0;   // Assert DSR (Data set ready)
  vif.nDCD <= 1'b0;   // Assert DCD (Carrier detect)
  vif.nRI  <= 1'b0;   // Assert RI (Ring indicator)

  @(posedge vif.clock);
  vif.PENABLE <= 1;
  
  //@(posedge vif.clock);

  while (!vif.PREADY) 
    @(posedge vif.clock);

  vif.PSEL <= 0;
  vif.PENABLE <= 0;
  @(posedge vif.clock);


  vif.nRI  <= 1'b1;   // Deassert RI (Ring indicator)
  vif.nDCD <= 1'b1;   // Deassert DCD (Carrier detect)
  vif.nDSR <= 1'b1;   // Deassert DSR (Data set ready)
  vif.nCTS <= 1'b1;   // Deassert CTS (Clear to send)
  `uvm_info("TX_DRIVER", "Printing to - Driver", UVM_LOW)

endtask

