class tx_subscriber extends uvm_subscriber #(uart_tx_xtn);
  `uvm_component_utils(tx_subscriber)

  uart_tx_xtn cov_data;

covergroup uart_tx_coverage(ref uart_tx_xtn cov_data);
      option.per_instance = 1;

  coverpoint cov_data.tx_fifo_count {
    bins empty = {0};
    bins low = {[1:4]};
    bins med = {[5:14]};
    bins full = {15};
  }

  coverpoint cov_data.tx_fifo_empty {
    bins empty = {1'b1};
    bins not_empty = {1'b0};
  }

  coverpoint cov_data.tx_fifo_full {
    bins full = {1'b1};
    bins not_full = {1'b0};
  }

  coverpoint cov_data.tx_busy {
    bins busy = {1'b1};
    bins idle = {1'b0};
  }

  coverpoint cov_data.TXD {
    bins low = {1'b0};
    bins high = {1'b1};
  }

  coverpoint cov_data.IRQ {
    bins asserted = {1'b1};
    bins deasserted = {1'b0};
  }

  coverpoint cov_data.LCR {
    bins word_length_5 = {8'bxxxxxx00};
    bins word_length_6 = {8'bxxxxxx01};
    bins word_length_7 = {8'bxxxxxx10};
    bins word_length_8 = {8'bxxxxxx11};
    bins parity_enable = {8'bxxxx1xxx};
    bins stop_bits_1 = {8'bxxxxx0xx};
    bins stop_bits_2 = {8'bxxxxx1xx};
  }

  coverpoint cov_data.nCTS {
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

endgroup : uart_tx_coverage
  
  extern function new(string name = "tx_subscriber", uvm_component parent);
    extern function void build_phase(uvm_phase phase);
    extern function void write(uart_tx_xtn t);

endclass : tx_subscriber

function tx_subscriber::new(string name = "tx_subscriber", uvm_component parent);
    super.new(name,parent);
    cov_data = uart_tx_xtn::type_id::create("cov_data", this); // Initialize cov_data
    uart_tx_coverage = new(cov_data);
endfunction : new

function void tx_subscriber::build_phase(uvm_phase phase);
    super.build_phase(phase);
endfunction : build_phase

function void tx_subscriber::write(uart_tx_xtn t);
  
  cov_data = t; // Assign the received transaction to cov_data for coverage sampling
  `uvm_info("Subscriber", $sformatf("Transaction data received: %s", t.sprint()), UVM_LOW)
  `uvm_info("Subscriber", $sformatf("Coverage data updated: %s", cov_data.sprint()), UVM_LOW)
  uart_tx_coverage.sample(); // Sample the coverage
  `uvm_info("Subscriber", $sformatf("Data received and coverage sampled: %s", t.sprint()), UVM_LOW)

endfunction : write
