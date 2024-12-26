class uart_default_seq extends uvm_sequence #(uart_tx_xtn);

  `uvm_object_utils(uart_default_seq)

  uart_tx_xtn apb_item;

  function new(string name = "uart_default_seq");
    super.new(name);
  endfunction

  task body();

    apb_item = uart_tx_xtn::type_id::create("apb_item");

    start_item(apb_item);
    apb_item.PADDR = `DEFAULT; 
    apb_item.PWDATA = 32'h00; 
    apb_item.PWRITE = 1'b1;

    finish_item(apb_item);

    #13000;


   
   endtask
endclass



