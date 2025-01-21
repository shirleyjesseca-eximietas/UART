class uart_tx_mon extends uvm_monitor;

  `uvm_component_utils(uart_tx_mon)

  uart_tx_xtn xtn;

  // Analysis ports for communication with the scoreboard
  uvm_analysis_port #(uart_tx_xtn) monitor_port;
  uvm_analysis_port #(uart_tx_xtn) monitor_tx_port;

  // Configuration object and virtual interface for DUT connection
  uart_tx_cfg m_cfg;
  virtual uart_if vif;

  // Temporary variables
  bit [7:0] temp_data;

  // Constructor
  function new(string name = "uart_tx_mon", uvm_component parent);
    super.new(name, parent);
    monitor_port = new("monitor_port", this); // Port for APB transactions
    monitor_tx_port = new("monitor_tx_port", this); // Port for UART TX transactions
  endfunction

  // Build phase for configuration checks
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db #(uart_tx_cfg)::get(this, "", "uart_tx_cfg", m_cfg)) begin
      `uvm_fatal("UART_MON", "Configuration object not set for uart_tx_mon")
    end
  endfunction

  // Connect phase for interface setup
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    vif = m_cfg.vif;
  endfunction

  // Run phase: Main monitoring loop
  task run_phase(uvm_phase phase);
   xtn = uart_tx_xtn::type_id::create("xtn");

    fork
    forever begin
       monitor_apb();
       monitor_uart_tx();
    end
    join_none //changed
  endtask

  // Task to monitor APB transactions
  task monitor_apb();
    @(negedge vif.clock); // Wait for APB clock edge
    if (vif.PSEL && vif.PENABLE && vif.PWRITE) begin   //10th Jan added PWRITE, 3rd removed vif.PREADY
  `uvm_info("UART_TX_MON", "Setting uart_monitor_APB", UVM_HIGH)
      xtn.PRESETn = vif.PRESETn;
      xtn.PADDR = vif.PADDR; // Capture address
      xtn.PWDATA = vif.PWDATA; // Capture write data
      xtn.PWRITE = vif.PWRITE; // Capture write/read operation
      xtn.PSEL = vif.PSEL;
      xtn.PENABLE = vif.PENABLE;
      xtn.PRDATA = vif.PRDATA; // Capture read data
      xtn.PSLVERR = vif.PSLVERR; // Capture error status
      xtn.PREADY = vif.PREADY; // Capture ready signal
      `uvm_info("APB_MON", $sformatf("Observed APB transaction: Addr=0x%0h, Data=0x%0h, Write=%0b",
                                     xtn.PADDR, vif.PWRITE ? xtn.PWDATA : xtn.PRDATA, xtn.PWRITE), UVM_LOW)

     monitor_port.write(xtn); // Send transaction
      `uvm_info("MONITOR", $sformatf("Transaction sent: %s", xtn.sprint()), UVM_HIGH)
    end
  endtask

  bit tx_fifo_empty;
  bit tx_fifo_full;

  bit [4:0] tx_fifo_count;

  bit tx_busy;
  bit [7:0] LCR;
  bit nCTS;


  // Task to monitor UART transmitter signals
  task monitor_uart_tx();
    @(negedge vif.clock); // Wait for UART clock edge
    //if (vif.PSEL && vif.PENABLE && vif.PREADY) begin   //3rd Jan added PWRITE


    xtn.TXD = vif.TXD; // Capture transmitted data
    xtn.IRQ = vif.IRQ; // Capture event signal
    xtn.LCR = vif.LCR;
    xtn.nCTS = vif.nCTS;

    xtn.tx_fifo_empty = vif.tx_fifo_empty;
    xtn.tx_fifo_full = vif.tx_fifo_full;
    xtn.tx_fifo_count = vif.tx_fifo_count;


    if (vif.TXD !== 1'bz) begin
      `uvm_info("UART_TX_MON", $sformatf("Observed UART TX: Data=0x%0h, Event=%0b",
                                         xtn.TXD, xtn.IRQ), UVM_HIGH)
      `uvm_info("MONITOR PORT", $sformatf("Transaction sent: %s", xtn.sprint()), UVM_HIGH)
      monitor_tx_port.write(xtn); // Send transaction
      `uvm_info("MONITOR", $sformatf("Transaction sent: %s", xtn.sprint()), UVM_HIGH)
    end
    //end

  endtask

endclass
