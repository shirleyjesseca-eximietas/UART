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


uvm_config_db #(uart_env_cfg)::set(this,"*","uart_env_cfg",env_cfg);
endfunction 
  
  
  








