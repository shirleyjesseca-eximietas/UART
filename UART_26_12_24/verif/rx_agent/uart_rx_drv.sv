class uart_rx_drv extends uvm_driver #(uart_rx_xtn);
  `uvm_component_utils(uart_rx_drv)

  virtual uart_if vif;                    // Virtual interface
  uart_rx_xtn xtn;                        // Transaction object
  uart_rx_cfg rx_cfg;                     // UART RX configuration
  uart_env_cfg env_cfg;                   // Environment configuration

  logic [31:0] frame_size;               // Frame size variable
  logic parity_bit;

bit [31:0] baud_period;
//bit [31:0] baud_period = 32'd32;

bit [15:0] divisor_latch; // 16-bit divisor latch


  extern function new(string name = "uart_rx_drv", uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase);
  //extern task send_to_dut(uart_rx_xtn xtn);
  extern task send_to_dut_with_baud(uart_rx_xtn xtn, bit [31:0] baud_period);


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

    // Capture divisor latch values from APB writes
    if (xtn.PADDR == 32'h1c) begin
      divisor_latch[7:0] <= xtn.PWDATA[7:0]; // Lower 8 bits
    end else if (xtn.PADDR == 32'h20) begin
      divisor_latch[15:8] <= xtn.PWDATA[7:0]; // Higher 8 bits
    end

    // Compute baud_period based on the divisor latch value
    if (divisor_latch != 0) begin
     // baud_period <= (50000000 / (divisor_latch * 16)); // 50 MHz clock frequency
      baud_period <= divisor_latch * 8; // 50 MHz clock frequency

    end else begin
      baud_period <= 32'd32; // Default baud_period if divisor is zero
    end

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

    `uvm_info("UART_RX_DRV", 
              $sformatf("Received Data=%b, Divisor Latch=%0d, Calculated Baud Period=%0d", 
                        xtn.rcvn_data, divisor_latch, baud_period), UVM_LOW)

    // Send the transaction to DUT with calculated baud period
    send_to_dut_with_baud(xtn, baud_period);

    seq_item_port.item_done(); // Mark transaction as done
  end
endtask

task uart_rx_drv::send_to_dut_with_baud(uart_rx_xtn xtn, bit [31:0] baud_period);


  // --- APB Register Configuration ---
  vif.PSEL <= 1'b1;          // Select the peripheral (APB select)
  vif.PENABLE <= 1'b0;       // Setup phase (enable low)
  vif.PADDR <= xtn.PADDR;    // Address for the APB transaction
  vif.PWRITE <= xtn.PWRITE;  // Write or Read operation
  vif.PWDATA <= xtn.PWDATA;  // Data to be written to the APB
  @(posedge vif.clock);      // Wait for the next clock edge

  // Enable phase of APB transaction
  vif.PENABLE <= 1'b1;       // Enable the APB transaction
  @(posedge vif.clock);      // Wait for the next clock edge

  if(xtn.rdata_done===1'b1) begin

    // --- UART RX Signal Driving ---
    // Send start bit (active low)
    vif.RXD <= 1'b0;
    repeat (baud_period) @(posedge vif.clock);

    // Send data bits based on the frame size
    for (int i = 0; i < frame_size; i++) begin
      vif.RXD <= xtn.rcvn_data[i]; // Transmit each bit serially
      repeat (baud_period) @(posedge vif.clock);
    end

    // --- Parity Bit Calculation ---
    // Assuming even parity (set this to xtn.parity_type if config provides parity type)
    if(xtn.parity_err_inj==1)
      parity_bit <= 1'bx;
    else
      parity_bit <= ^xtn.rcvn_data; // XOR of all data bits for even parity

    // Send parity bit (even or odd parity)
    vif.RXD <= parity_bit;
    repeat (baud_period) @(posedge vif.clock);

    // Send stop bit (active high)
    vif.RXD <= 1'b1;
    repeat (baud_period) @(posedge vif.clock);

  end

  // Complete the APB transaction by deactivating the peripheral
  vif.PSEL <= 1'b0;          // Deselect the peripheral
  vif.PENABLE <= 1'b0;       // Disable the enable signal for APB
    @(posedge vif.clock);
  `uvm_info("RX_DRIVER", "Printing to - Driver", UVM_LOW)

endtask
