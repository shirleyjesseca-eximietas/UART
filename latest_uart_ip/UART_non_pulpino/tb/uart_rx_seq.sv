class uart_rx_seq extends uvm_sequence #(uart_rx_xtn);

  `uvm_object_utils(uart_rx_seq)

  uart_rx_xtn seq_item;

  static int baud_rate;
  static bit[15:0] baud_divisor;
  static int baud_period;

  function new(string name = "uart_rx_seq");
    super.new(name);
  endfunction

  task baud_rate_generator();
  baud_rate = 115200;              // SET BAUDRATE HERE
  baud_period = 1000000000/(baud_rate); //in terms of nano seconds
  baud_divisor = 50000000/(baud_rate*16); // 50MHz clock frequency

  endtask

endclass


