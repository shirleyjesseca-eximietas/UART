class rx_subscriber extends uvm_subscriber #(uart_rx_xtn);
  `uvm_component_utils(rx_subscriber)

  uart_rx_xtn cov_data;

covergroup uart_rx_coverage;
  option.per_instance = 1;
  
  coverpoint cov_data.rx_fifo_count {
    bins empty = {0};
    bins low = {[1:4]};
    bins med = {[5:14]};
    bins full = {15};
  }

  coverpoint cov_data.rx_fifo_empty {
    bins empty = {1'b1};
    bins not_empty = {1'b0};
  }

  coverpoint cov_data.rx_fifo_full {
    bins full = {1'b1};
    bins not_full = {1'b0};
  }

  coverpoint cov_data.RXD {
    bins low = {1'b0};
    bins high = {1'b1};
  }

  coverpoint cov_data.IRQ {
    bins asserted = {1'b1};
    bins deasserted = {1'b0};
  }

  coverpoint cov_data.PSEL {
    bins selected = {1'b1};
    bins not_selected = {1'b0};
  }

  coverpoint cov_data.PENABLE {
    bins enabled = {1'b1};
    bins not_enabled = {1'b0};
  }

  coverpoint cov_data.PWRITE {
    bins write = {1'b1};
    bins read = {1'b0};
  }

  coverpoint cov_data.PREADY {
    bins ready = {1'b1};
    bins not_ready = {1'b0};
  }

  coverpoint cov_data.PSLVERR {
    bins error = {1'b1};
    bins no_error = {1'b0};
  }

endgroup : uart_rx_coverage
  
    extern function new(string name = "rx_subscriber", uvm_component parent);
    extern function void build_phase(uvm_phase phase);
    extern function void write(uart_rx_xtn t);

endclass : rx_subscriber

function rx_subscriber::new(string name = "rx_subscriber", uvm_component parent);
    super.new(name,parent);
endfunction : new

function void rx_subscriber::build_phase(uvm_phase phase);
    super.build_phase(phase);
endfunction : build_phase

function void rx_subscriber::write(uart_rx_xtn t);
  
  cov_data = t; // Assign the received transaction to cov_data for coverage sampling
  `uvm_info("Subscriber", $sformatf("Transaction data received: %s", t.sprint()), UVM_LOW)
  `uvm_info("Subscriber", $sformatf("Coverage data updated: %s", cov_data.sprint()), UVM_LOW)
  uart_rx_coverage.sample(); // Sample the coverage
  `uvm_info("Subscriber", $sformatf("Data received and coverage sampled: %s", t.sprint()), UVM_LOW)

endfunction : write
