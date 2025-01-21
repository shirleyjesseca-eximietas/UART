class uart_tx_reset_seq extends uart_tx_seq;

  `uvm_object_utils(uart_tx_reset_seq)

  uart_tx_xtn seq_item;


  function new(string name = "uart_tx_reset_seq");
    super.new(name);
  endfunction


  task body();

    seq_item = uart_tx_xtn::type_id::create("seq_item");

    start_item(seq_item);
    seq_item.tx_rst_en=1;
    finish_item(seq_item);
    
    endtask
endclass



