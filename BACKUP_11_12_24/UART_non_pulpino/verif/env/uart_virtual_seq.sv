class uart_virtual_seq extends uvm_sequence #(uvm_sequence_item);
`uvm_object_utils(uart_virtual_seq)

uart_tx_seqr tx_seqrh;
//uart_rx_seqr rx_seqrh;
uart_virtual_seqr v_seqr;

extern function new(string name = "uart_virtual_seq");
extern task body();
endclass

function uart_virtual_seq::new(string name = "uart_virtual_seq");
super.new(name);
endfunction

task uart_virtual_seq::body();
$cast(v_seqr, m_sequencer);
tx_seqrh = v_seqr.tx_seqrh;
//rx_seqrh = v_seqr.rx_seqrh;
endtask

/////////////////////////////////////////////////////////////// 
//                TRANSMITTER DATA FRAME BITS CFG            //
///////////////////////////////////////////////////////////////

class uart_tx_single_byte_virtual_seq extends uart_virtual_seq;
`uvm_object_utils(uart_tx_single_byte_virtual_seq)

uart_tx_single_byte_seq tx_seq1;
//uart_tx_single_byte_seq tx_seq2;

extern function new (string name = "uart_tx_single_byte_virtual_seq");
extern task body();
endclass

function uart_tx_single_byte_virtual_seq::new(string name  = "uart_tx_single_byte_virtual_seq");
super.new(name);
endfunction

task uart_tx_single_byte_virtual_seq::body();
super.body();

tx_seq1 = uart_tx_single_byte_seq::type_id::create("tx_seq1");
//tx_seq2 = uart_tx_single_byte_seq::type_id::create("tx_seq2");

tx_seq1.start(tx_seqrh);
//tx_seq2.start(tx_seqrh);

endtask
