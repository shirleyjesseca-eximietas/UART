class uart_tx_scoreboard extends uvm_scoreboard;

  `uvm_component_utils(uart_tx_scoreboard)

  // Analysis FIFOs for receiving transactions
  uvm_tlm_analysis_fifo #(uart_tx_xtn) apb_fifo;
  uvm_tlm_analysis_fifo #(uart_tx_xtn) tx_fifo;


  // For coverage
  uart_tx_xtn tx_cov_data;
  uart_rx_xtn rx_cov_data;


  // Constructor
  function new(string name = "uart_tx_scoreboard", uvm_component parent);
    super.new(name, parent);
  endfunction

  // Build phase to initialize FIFOs
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    apb_fifo = new("apb_fifo", this);
    tx_fifo = new("tx_fifo", this);


    //tx_cov_data = new("tx_cov_data",this);
    //rx_cov_data = new("rx_cov_data",this);

  endfunction

  // Connect phase to bind FIFOs to analysis ports
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    //env.apb_monitor.monitor_port.connect(apb_fifo.analysis_export);
    //env.tx_monitor.monitor_tx_port.connect(tx_fifo.analysis_export);
  endfunction

  // Run phase to compare transactions
  virtual task run_phase(uvm_phase phase);
    uart_tx_xtn apb_xtn, tx_xtn;
    bit [1:0] wordlength;
    bit parity_bit, stop_bit;
    bit [7:0] temp_reg, parity_temp;
    int data_bit, i;

    forever begin
      // Get a transaction from the APB FIFO
      apb_fifo.get(apb_xtn);

      tx_cov_data = apb_xtn;


      // Step 1: Check if address matches the LCR (Line Control Register)
      if (apb_xtn.PADDR == 'hC) begin
        wordlength = apb_xtn.PWDATA[1:0];   // Word length (e.g., 5, 6, 7, or 8 bits)
        stop_bit = apb_xtn.PWDATA[2];       // Stop bit
        parity_bit = apb_xtn.PWDATA[3];     // Parity bit

        case (wordlength)
          2'b00: data_bit = 5;
          2'b01: data_bit = 6;
          2'b10: data_bit = 7;
          2'b11: data_bit = 8;
          default: data_bit = 8;
        endcase

        `uvm_info("UART_SCB", $sformatf("LCR Configured: Wordlength=%0d, Stop Bit=%0b, Parity Bit=%0b", data_bit, stop_bit, parity_bit), UVM_MEDIUM);
      end

      // Step 2: Detect TXD going low (start bit detection) using IF statement
      tx_fifo.get(tx_xtn);
      if (tx_xtn.TXD == 0) begin
        `uvm_info("UART_SCB", "Start bit detected", UVM_MEDIUM);
        
        for (i = 0; i < data_bit; i++) begin         // Transmit wordlength bits and store TXD in a temp register
          tx_fifo.get(tx_xtn);
          temp_reg[i] = tx_xtn.TXD;
          `uvm_info("UART_SCB", $sformatf("Data Bit[%0d]: TXD=%0b", i, tx_xtn.TXD), UVM_MEDIUM);
        end

        if (parity_bit) begin                       // Handle parity bit if enabled
          tx_fifo.get(tx_xtn);
          parity_temp = tx_xtn.TXD;
          `uvm_info("UART_SCB", $sformatf("Parity Bit: TXD=%0b", tx_xtn.TXD), UVM_MEDIUM);
        end

        tx_fifo.get(tx_xtn);                       // Handle stop bit
        if (tx_xtn.TXD !== 1) begin
          `uvm_error("UART_SCB", $sformatf("Stop Bit Mismatch: TXD=%0b", tx_xtn.TXD));
        end else begin
          `uvm_info("UART_SCB", $sformatf("Stop Bit: TXD=%0b", tx_xtn.TXD), UVM_MEDIUM);
        end
      end else begin
         `uvm_error("UART_SCB", "Start bit not detected");
        continue;
      end
    end
  endtask

endclass

