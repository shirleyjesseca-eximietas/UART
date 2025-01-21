class uart_rx_reset_seq extends uart_rx_seq;

  `uvm_object_utils(uart_rx_reset_seq)

  uart_rx_xtn seq_item;


  function new(string name = "uart_rx_reset_seq");
    super.new(name);
  endfunction


  task body();

  super.baud_rate_generator();

    seq_item = uart_rx_xtn::type_id::create("seq_item");

    start_item(seq_item);
    seq_item.rx_rst_en=1;
    finish_item(seq_item);
    
    endtask
endclass



