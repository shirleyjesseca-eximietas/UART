class uart_virtual_seq extends uvm_sequence #(uvm_sequence_item);
`uvm_object_utils(uart_virtual_seq)

uart_wr_seqr wr_seqrh;
uart_rd_seqr rd_seqrh;
uart_virtual_seqr v_seqr;

extern function new(string name = "uart_virtual_seq");
extern task body();
endclass

function uart_virtual_seq::new(string name = "uart_virtual_seq");
super.new(name);
endfunction

task uart_virtual_seq::body();
$cast(v_seqr,m_sequencer);
wr_seqrh = v_seqr.wr_seqrh;
rd_seqrh = v_seqr.rd_seqrh;
endtask

/////////////////////////////////////////////////////////////// 
//                TRANSMITTER DATA FRAME BITS CFG            //
///////////////////////////////////////////////////////////////

class tx_data_frame_cfg_seq extends uart_virtual_seq;
`uvm_object_utils(tx_data_frame_cfg_seq)

config_write_seq wr_seq1;
data_frame_config_write_seq wr_seq2;

extern function new (string name = "tx_data_frame_cfg_seq");
extern task body();
endclass

function tx_data_frame_cfg_seq::new(string name  = "tx_data_frame_cfg_seq");
super.new(name);
endfunction

task tx_data_frame_cfg_seq::body();
super.body();

wr_seq1 = config_write_seq::type_id::create("wr_seq1");
wr_seq2 = data_frame_config_write_seq::type_id::create("wr_seq2");

wr_seq1.start(wr_seqrh);
wr_seq2.start(wr_seqrh);

endtask

/////////////////////////////////////////////////////////////// 
//          TRANSMITTER MULTIPLE DATA TRANSMISSION           //
///////////////////////////////////////////////////////////////
  
class tx_multi_data_seq extends uart_virtual_seq;
  `uvm_object_utils(tx_multi_data_seq)
config_write_seq wr_seq1;
multi_write_seq wr_seq2;

  extern function new (string name = "tx_multi_data_seq");
extern task body();
endclass

  function tx_multi_data_seq::new(string name  = "tx_multi_data_seq");
super.new(name);
endfunction

task tx_multi_data_seq::body();
super.body();
wr_seq1 = config_write_seq::type_id::create("wr_seq1");
wr_seq2 = multi_write_seq::type_id::create("wr_seq2");
wr_seq1.start(wr_seqrh);
wr_seq2.start(wr_seqrh);

endtask

/////////////////////////////////////////////////////////////// 
//                TRANSMITTER FIFO OVERFLOW                  //
///////////////////////////////////////////////////////////////

class tx_fifo_overflow_seq extends uart_virtual_seq;
  `uvm_object_utils(tx_fifo_overflow_seq)
config_write_seq wr_seq1;
fifo_overflow_write_seq wr_seq2;

extern function new (string name = "tx_fifo_overflow_seq");
extern task body();
endclass

function tx_fifo_overflow_seq::new(string name  = "tx_fifo_overflow_seq");
super.new(name);
endfunction

task tx_fifo_overflow_seq::body();
super.body();
wr_seq1 = config_write_seq::type_id::create("wr_seq1");
wr_seq2 = fifo_overflow_write_seq::type_id::create("wr_seq2");
wr_seq1.start(wr_seqrh);
wr_seq2.start(wr_seqrh);

endtask

/////////////////////////////////////////////////////////////// 
//             RECEIVER PARITY ERROR INJECTION               //
///////////////////////////////////////////////////////////////

class rx_parity_err_seq extends uart_virtual_seq;
  `uvm_object_utils(rx_parity_err_seq)

config_write_seq wr_seq;
parity_error_inj_seq rd_seq;
tx_interrupt_reading_seq int_seq;

extern function new (string name = "rx_parity_err_seq");
extern task body();
endclass

function rx_parity_err_seq::new(string name  = "rx_parity_err_seq");
super.new(name);
endfunction

task rx_parity_err_seq::body();
super.body();
wr_seq = config_write_seq::type_id::create("wr_seq");
rd_seq = parity_error_inj_seq::type_id::create("rd_seq");
int_seq = tx_interrupt_reading_seq::type_id::create("int_seq");

wr_seq.start(wr_seqrh);
//fork
rd_seq.start(rd_seqrh);
int_seq.start(wr_seqrh);
//join

endtask

/////////////////////////////////////////////////////////////// 
//                RECEIVER DATA FRAME BITS CFG               //
///////////////////////////////////////////////////////////////

class rx_data_frame_cfg_seq extends uart_virtual_seq;
  `uvm_object_utils(rx_data_frame_cfg_seq)

config_write_seq wr_seq;
data_frame_config_read_seq rd_seq;

extern function new (string name = "rx_data_frame_cfg_seq");
extern task body();
endclass

function rx_data_frame_cfg_seq::new(string name  = "rx_data_frame_cfg_seq");
super.new(name);
endfunction

task rx_data_frame_cfg_seq::body();
super.body();

wr_seq = config_write_seq::type_id::create("wr_seq");
rd_seq = data_frame_config_read_seq::type_id::create("rd_seq");

wr_seq.start(wr_seqrh);
rd_seq.start(rd_seqrh);

endtask

/////////////////////////////////////////////////////////////// 
//             RECEIVER MULTIPLE DATA TRANSMISSION           //
///////////////////////////////////////////////////////////////

class rx_multi_data_seq extends uart_virtual_seq;
  `uvm_object_utils(rx_multi_data_seq)

config_write_seq wr_seq;
multi_read_seq rd_seq;

extern function new (string name = "rx_multi_data_seq");
extern task body();
endclass

function rx_multi_data_seq::new(string name  = "rx_multi_data_seq");
super.new(name);
endfunction

task rx_multi_data_seq::body();
super.body();

wr_seq = config_write_seq::type_id::create("wr_seq");
rd_seq = multi_read_seq::type_id::create("rd_seq");

wr_seq.start(wr_seqrh);
rd_seq.start(rd_seqrh);

endtask

/////////////////////////////////////////////////////////////// 
//               RECEIVER FIFO OVERFLOW                      //
///////////////////////////////////////////////////////////////

class rx_fifo_overflow_seq extends uart_virtual_seq;
  `uvm_object_utils(rx_fifo_overflow_seq)

config_write_seq wr_seq;
fifo_overflow_read_seq rd_seq;

  extern function new (string name = "rx_fifo_overflow_seq");
extern task body();
endclass

  function rx_fifo_overflow_seq::new(string name  = "rx_fifo_overflow_seq");
super.new(name);
endfunction

task rx_fifo_overflow_seq::body();
super.body();
wr_seq = config_write_seq::type_id::create("wr_seq");
rd_seq = fifo_overflow_read_seq::type_id::create("rd_seq");

wr_seq.start(wr_seqrh);
rd_seq.start(rd_seqrh);

endtask

/////////////////////////////////////////////////////////////// 
//                        ALL SEQUENCES                      //
///////////////////////////////////////////////////////////////

class all_seq extends uart_virtual_seq;
  `uvm_object_utils(all_seq)

data_frame_config_write_seq wr_seq1;
multi_write_seq wr_seq2;
fifo_overflow_write_seq wr_seq3;
config_write_seq wr_seq4;
parity_error_inj_seq wr_seq;
data_frame_config_read_seq rd_seq;
multi_read_seq rd_seq3;
fifo_overflow_read_seq rd_seq4;

  extern function new (string name = "all_seq");
extern task body();
endclass

  function all_seq::new(string name  = "all_seq");
super.new(name);
endfunction

task all_seq::body();
super.body();

wr_seq1 = data_frame_config_write_seq::type_id::create("wr_seq1");
wr_seq2 = multi_write_seq::type_id::create("wr_seq2");
wr_seq3 = fifo_overflow_write_seq::type_id::create("wr_seq3");
wr_seq4 = config_write_seq::type_id::create("wr_seq4");
wr_seq = parity_error_inj_seq::type_id::create("wr_seq");
rd_seq = data_frame_config_read_seq::type_id::create("rd_seq");
rd_seq3 = multi_read_seq::type_id::create("rd_seq3");
rd_seq4 = fifo_overflow_read_seq::type_id::create("rd_seq4");

begin
wr_seq1.start(wr_seqrh);
wr_seq2.start(wr_seqrh);
wr_seq3.start(wr_seqrh);

wr_seq4.start(wr_seqrh);
wr_seq.start(rd_seqrh);

wr_seq4.start(wr_seqrh);
rd_seq.start(rd_seqrh);

rd_seq3.start(rd_seqrh);
rd_seq4.start(rd_seqrh);
end

endtask
