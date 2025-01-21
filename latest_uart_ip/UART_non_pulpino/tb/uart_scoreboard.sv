class uart_tx_scoreboard extends uvm_scoreboard;

  `uvm_component_utils(uart_tx_scoreboard)

  // Analysis FIFOs
  uvm_tlm_analysis_fifo #(uart_tx_xtn) apb_fifo;
  uvm_tlm_analysis_fifo #(uart_tx_xtn) uart_fifo;

  // Coverage-related variables
  uart_tx_xtn cov_data;

  // Covergroup definition
  covergroup uart_tx_cov;
    option.per_instance = 1;

    PADDR_CG : coverpoint cov_data.PADDR {
      bins valid_addrs[] = {[16'h0:16'hFF]}; // Example valid range
    }

    PWDATA_CG : coverpoint cov_data.PWDATA {
      bins low = {[0:63]};
      bins mid = {[64:127]};
      bins high = {[128:255]};
    }

    TXD_CG : coverpoint cov_data.TXD {
      bins tx_values[] = {[8'h00:8'hFF]};
    }

    IRQ_CG : coverpoint cov_data.IRQ {
      bins asserted = {1'b1};
      bins deasserted = {1'b0};
    }

    cross PADDR_CG, PWDATA_CG, TXD_CG; // Cross-coverage
  endgroup

  // Constructor
  function new(string name = "uart_tx_scoreboard", uvm_component parent);
    super.new(name, parent);
    apb_fifo = new("apb_fifo", this);
    uart_fifo = new("uart_fifo", this);
    uart_tx_cov = new;

  endfunction

  // Build Phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
      endfunction

  // Run Phase
  task run_phase(uvm_phase phase);
    uart_tx_xtn apb_tx, uart_tx;

    forever begin
      // Get data from the FIFOs
      apb_fifo.get(apb_tx);
      uart_fifo.get(uart_tx);

      // Functional checks
      if (apb_tx.PWRITE && apb_tx.PWDATA[7:0] != uart_tx.TXD) begin
        `uvm_error("UART_TX_SCB", $sformatf("Mismatch: APB Data=0x%0h, UART Data=0x%0h",
                                           apb_tx.PWDATA[7:0], uart_tx.TXD))
      end

      if (apb_tx.PWRITE && uart_tx.IRQ !== 1'b1) begin
        `uvm_error("UART_TX_SCB", "IRQ not asserted for a valid write operation")
      end

      if (!apb_tx.PWRITE && uart_tx.IRQ === 1'b1) begin
        `uvm_error("UART_TX_SCB", "IRQ incorrectly asserted for a read operation")
      end

      // Sample coverage
      cov_data = uart_tx;
      uart_tx_cov.sample();
    end
  endtask

  // Check Phase
  function void check_phase(uvm_phase phase);
    `uvm_info("UART_TX_SCB", "All functional checks passed.", UVM_LOW)
  endfunction

  // Report Phase
  function void report_phase(uvm_phase phase);
    `uvm_info("UART_TX_SCB", "Simulation completed with coverage reported below:", UVM_NONE)
  endfunction

endclass
