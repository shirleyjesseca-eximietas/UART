class uart_rx_drv extends uvm_driver #(uart_rx_xtn);
  `uvm_component_utils(uart_rx_drv)

  virtual uart_if vif;                    // Virtual interface
  uart_rx_xtn xtn;                        // Transaction object
  uart_rx_cfg rx_cfg;                     // UART RX configuration
  uart_env_cfg env_cfg;                   // Environment configuration

  logic [31:0] frame_size;               // Frame size variable
  logic parity_bit;


  extern function new(string name = "uart_rx_drv", uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase);
  //extern task send_to_dut(uart_rx_xtn xtn);
  extern task send_to_dut_with_baud(uart_rx_xtn xtn);


endclass

function uart_rx_drv::new(string name = "uart_rx_drv", uvm_component parent);
  super.new(name, parent);
 // driver_apb_port = new("driver_apb_port", this);
endfunction

function void uart_rx_drv::build_phase(uvm_phase phase);
  super.build_phase(phase);
  if (!uvm_config_db #(uart_rx_cfg)::get(this, "", "uart_rx_cfg", rx_cfg))
    `uvm_fatal("CONFIGURATION", "Failed to get(uart_rx_cfg) in uart_rx_drv")

  //if (!uvm_config_db #(uart_env_cfg)::get(this, "", "uart_env_cfg", env_cfg))
    //`uvm_fatal("CONFIGURATION", "Failed to get(uart_env_cfg) in uart_rx_drv")
endfunction

function void uart_rx_drv::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  vif = rx_cfg.vif;                      // Connect virtual interface from config
endfunction



task uart_rx_drv::run_phase(uvm_phase phase);
  @(posedge vif.clock);
  vif.PRESETn <= 1'b0;

  repeat (3) @(posedge vif.clock);
  vif.PRESETn <= 1'b1;

  vif.RXD <= 1'b1; // Idle state for RXD

  forever begin

    seq_item_port.get_next_item(xtn); // Get next transaction from sequencer

    // Determine frame size based on PWDATA[1:0] if PADDR == 32'hc
    if (xtn.PADDR == 32'hc) begin
      case (xtn.PWDATA[1:0])
        2'b00: frame_size <= 5;
        2'b01: frame_size <= 6;
        2'b10: frame_size <= 7;
        2'b11: frame_size <= 8;
        default: frame_size <= 8;
      endcase
    end else begin
      frame_size <= 8; // Default frame size
    end

    // Send the transaction to DUT
    send_to_dut_with_baud(xtn);

    seq_item_port.item_done(); // Mark transaction as done

  end
endtask

task uart_rx_drv::send_to_dut_with_baud(uart_rx_xtn xtn);
 
  @(posedge vif.clock);      // Wait for the next clock edge

  `uvm_info("BAUD_PERIOD_FIX",$sformatf("Baud period value = %d",xtn.baud_period),UVM_LOW)
  vif.nRTS <= xtn.nRTS; //new

  // --- APB Register Configuration ---
  vif.PSEL <= 1'b1;          // Select the peripheral (APB select)
  vif.PADDR <= xtn.PADDR;    // Address for the APB transaction
  vif.PWRITE <= xtn.PWRITE;  // Write or Read operation
  vif.PWDATA <= xtn.PWDATA;  // Data to be written to the APB

  if(xtn.rdata_done===1'b1) begin

    // --- UART RX Signal Driving ---
    // Send start bit (active low)
    parity_bit <= 1'b0;
    vif.PENABLE <= 1'b1;
    vif.RXD <= 1'b0;
    
    #(xtn.baud_period);

    // Send data bits based on the frame size

    for (int i = 0; i < frame_size; i++) begin
      vif.RXD <= xtn.rcvn_data[i]; // Transmit each bit serially
      #(xtn.baud_period);
      parity_bit <= parity_bit^xtn.rcvn_data[i]; // XOR of all data bits for parity bit calculation
    end


    #(xtn.baud_period);
    
    // --- Parity Bit Sending ---

    if(xtn.parity_err_inj==1)
      vif.RXD <= 1'bx;
    else
      vif.RXD <= parity_bit; // XOR of all data bits for even parity


    #(xtn.baud_period);

    // Send stop bit (active high)
    if(xtn.framing_err_inj==0) begin
      vif.RXD <= 1'b1;
  
    #(xtn.baud_period);
    end

    #(xtn.baud_period);

  end

  // Complete the APB transaction by deactivating the peripheral

@(posedge vif.clock);

  vif.PENABLE <= 1'b1; 

  

endtask
