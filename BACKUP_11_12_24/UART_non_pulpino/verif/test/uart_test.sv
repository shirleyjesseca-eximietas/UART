/////////////////////////////////////////////////////
//             -- BAUD RATE --                     //
//                                                 //
// BAUD RATE   | DIVISOR VALUE |     {DLM+DLL}     //
//-------------------------------------------------//
//    4800     |      651      | dlm = 8'b00000010 //
//             |               | dll = 8'b10001011 //
//-------------------------------------------------//
//    9600     |      326      | dlm = 8'b00000001 //
//             |               | dll = 8'b01000110 //
//-------------------------------------------------//
//  19,200     |      163      | dlm = 8'b00000000 //
//             |               | dll = 8'b10100011 //
//-------------------------------------------------//
//  38,400     |       81      | dlm = 8'b00000000 //
//             |               | dll = 8'b01010001 //
//-------------------------------------------------//
//  57,600     |       54      | dlm = 8'b00000000 //
//             |               | dll = 8'b00110110 //
//-------------------------------------------------//
//  1,15,200   |       27      | dlm = 8'b00000000 //
//             |               | dll = 8'b00011011 //
//-------------------------------------------------//
//  2,30,400   |       14      | dlm = 8'b00000000 //
//             |               | dll = 8'b00001110 //
//-------------------------------------------------//
//  4,60,000   |        7      | dlm = 8'b00000000 //
//             |               | dll = 8'b00000111 //
//-------------------------------------------------//
//  9,21,600   |        3      | dlm = 8'b00000000 //
//             |               | dll = 8'b00000011 //
/////////////////////////////////////////////////////

class uart_test extends uvm_test;
`uvm_component_utils(uart_test)

typedef bit [7:0] bit_8;

uart_env_cfg env_cfg;
uart_tx_cfg tx_cfg ;
uart_rx_cfg rx_cfg;

uart_env env; 

bit has_scoreboard =  0;
bit has_virtual_sequencer = 1;

bit_8 lcr = 8'b00001000; // [1:0] -> number of bits in data frame
bit_8 ier = 8'b00000100; // [0] RDA interrupt ; [1] THR empty ; [2] Rx line status interrupt
bit_8 fcr = 8'b11000110; // [7:6] -> RX FIFO trigger value ; [2] -> TX FIFO CLEAR ; [1] -> RX FIFO CLEAR 
bit_8 dlm = 8'b00000000;
bit_8 dll = 8'b00000011;

bit_8 lcr_queue[$];
bit_8 lcr_min_value = 8'b00001000; // 4-bits in data frame
 


extern function new(string name = "uart_test", uvm_component parent);
extern function void build_phase(uvm_phase phase);

endclass

function uart_test::new(string name = "uart_test", uvm_component parent);
super.new(name, parent);
endfunction

function void uart_test::build_phase(uvm_phase phase);
super.build_phase(phase);

env = uart_env::type_id::create("env",this);
env_cfg = uart_env_cfg::type_id::create("env_cfg",this);

tx_cfg = uart_tx_cfg::type_id::create("tx_cfg");
if(!uvm_config_db #(virtual uart_if)::get(this,"","uart_if",tx_cfg.vif))
	`uvm_fatal("CONFIGURATION","Failed to get() in uart_env")

tx_cfg.is_active = UVM_ACTIVE;

env_cfg.tx_cfg = tx_cfg;

rx_cfg = uart_rx_cfg::type_id::create("rx_cfg");
if(!uvm_config_db #(virtual uart_if)::get(this,"","uart_if",rx_cfg.vif))
	`uvm_fatal("CONFIGURATION","Failed to get() in uart_env")

rx_cfg.is_active = UVM_ACTIVE;
env_cfg.rx_cfg = rx_cfg;

env_cfg.has_scoreboard = has_scoreboard;
env_cfg.has_virtual_sequencer = has_virtual_sequencer;

env_cfg.lcr = lcr;
env_cfg.ier = ier;
env_cfg.fcr = fcr;
env_cfg.dlm = dlm;
env_cfg.dll = dll;


`uvm_info("TEST", "Setting uart_env_cfg", UVM_MEDIUM)
uvm_config_db #(uart_env_cfg)::set(this,"*","uart_env_cfg",env_cfg);

//uvm_config_db#(uart_env_cfg)::dump();
endfunction 

/////////////////////////////////////////////////////////////// 
//                TRANSMITTER DATA FRAME BITS CFG            //
///////////////////////////////////////////////////////////////

class tx_data_frame_cfg_test extends uart_test;
  `uvm_component_utils(tx_data_frame_cfg_test)

tx_data_frame_cfg_seq v_seq;
bit_8 lcr_queue[$]; 
bit_8 lcr_min_value = 8'b00001000;
extern function new(string name = "tx_data_frame_cfg_test", uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);

endclass

function tx_data_frame_cfg_test::new(string name = "tx_data_frame_cfg_test", uvm_component parent);
super.new(name,parent);
endfunction

function void tx_data_frame_cfg_test::build_phase(uvm_phase phase);
super.build_phase(phase);


for(int i=0;i<4;i++) begin
  lcr_queue[i] = lcr_min_value;
  lcr_min_value++;
end

env_cfg.lcr_queue = lcr_queue;
uvm_config_db #(uart_env_cfg)::set(this,"*","uart_env_cfg",env_cfg);

endfunction

task tx_data_frame_cfg_test::run_phase(uvm_phase phase);
v_seq = tx_data_frame_cfg_seq::type_id::create("v_seq");
phase.raise_objection(this);
v_seq.start(env.v_seqr);	
  #20us;
phase.drop_objection(this);
endtask

  
  
  








