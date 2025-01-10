class uart_rx_seq extends uvm_sequence #(uart_rx_xtn);
`uvm_object_utils(uart_rx_seq)
  
  bit valid_data;
  uart_env_cfg m_cfg;
  
  task configuration;
  input bit wr_en;
    input bit [2:0]addr;
    input bit [7:0]wdata;
    input bit [7:0]r_data;
    input uart_rx_xtn req;
    input penable;
    
    start_item(req);
    assert(req.randomize() with {PWRITE == wr_en;
                                 PADDR [2:0] == addr;
                                 PWDATA [7:0] == wdata;
                                })
                              
     if((addr == 3'h3) && (wr_en==1)) begin
       req.bits_num = wdata[1:0]; 
      valid_data = wdata[7];
     end
    
      if((addr==3'h0) && (valid_data==0))
        begin
          case(req.bits_num)
            2'b00 : req.rcvn_data[3:0] = r_data[3:0];
            2'b01 : req.rcvn_data[4:0] = r_data[4:0];
            2'b10 : req.rcvn_data[5:0] = r_data[5:0];
            2'b11 : req.rcvn_data[6:0] = r_data[6:0];
          endcase
        end
     else
       req.rcvn_data = r_data;

       req.PENABLE = penable;
       
	finish_item(req);
  endtask
    
    task status_reg_info;
        configuration(0,3'h3,8'b0,8'b0,req,1); //LCR
        configuration(0,3'h1,8'b0,8'b0,req,1); // TER
        configuration(0,3'h5,8'b0,8'b0,req,1); // LSR
        configuration(0,3'h2,8'b0,8'b0,req,1); //IIR
    endtask
    

extern function new(string name = "uart_rx_seq");

task pre_body();
`uvm_info("SEQ", "Attempting to get uart_wr_cfg", UVM_MEDIUM)
  if (!uvm_config_db#(uart_env_cfg)::get(null,get_full_name, "uart_env_cfg", m_cfg)) begin
    `uvm_fatal("CONFIGURATION", "Failed to get() in uart_wr_seq")
  end
  super.pre_body(); 
endtask

endclass

function uart_rx_seq::new(string name = "uart_rx_seq");
super.new(name);
endfunction

/////////////////////////////////////////////////////////////// 
//                   RECEIVER CONFIGURATION                  //
/////////////////////////////////////////////////////////////// 

class config_read_seq extends uart_rx_seq;
  `uvm_object_utils(config_read_seq)

  extern function new(string name = "config_read_seq");
extern task body();
endclass

function config_read_seq::new(string name = "config_read_seq");
super.new(name);
endfunction


task config_read_seq::body();
req = uart_rx_xtn::type_id::create("req");
  
//Write Mode
  
  super.configuration(1,3'h3,8'b10000000,8'b0,req,1); //LCR - For DLL,DLM setup
  
  super.configuration(1,3'h0,m_cfg.dll,8'b0,req,1); // DLL setup
  super.configuration(1,3'h1,m_cfg.dlm,8'b0,req,1); // DLM setup
  
  super.configuration(1,3'h3,m_cfg.lcr,8'b0,req,1); //LCR 
  
  super.configuration(1,3'h1,m_cfg.ier,8'b0,req,1); //IER
  
  super.configuration(1,3'h2,m_cfg.fcr,8'b0,req,1); //FCR
  
endtask


/////////////////////////////////////////////////////////////// 
//        DATA PACKET BITS NUMBER CONFIGURATION              //
///////////////////////////////////////////////////////////////
 
class data_frame_config_read_seq extends uart_rx_seq;
`uvm_object_utils(data_frame_config_read_seq)

extern function new(string name = "data_frame_config_read_seq");
extern task body();
endclass

function data_frame_config_read_seq::new(string name = "data_frame_config_read_seq");
super.new(name);
endfunction


task data_frame_config_read_seq::body();
req = uart_rx_xtn::type_id::create("req");
  
//WRITE MODE
  
  // super.configuration(1,3'h2,8'b00000110,$random,req,1);//FCR
  // super.configuration(1,3'h1,8'b00000011,$random,req,1);//IER
  
  /*super.configuration(1,3'h3,8'b00001011,$random,req,1);//LCR //LCR - 7 bits in data frame
  req.rxata_done = 1;
  super.configuration(0,3'h0,$random,$random,req,1);//RBR
  super.configuration(0,3'h0,$random,$random,req,0);
  req.rxata_done = 0;
  super.status_reg_info;
  
  super.configuration(1,3'h2,8'b00000110,$random,req,1);//FCR
  super.configuration(1,3'h1,8'b00000011,$random,req,1);//IER
  super.configuration(1,3'h3,8'b00001001,$random,req,1);//LCR //LCR - 5 bits in data frame
  req.rxata_done = 1;
  super.configuration(0,3'h0,$random,$random,req,1);//RBR
  //super.configuration(0,3'h0,$random,$random,req,0);
  req.rxata_done = 0;
  super.status_reg_info;
  
  super.configuration(1,3'h2,8'b00000110,$random,req,1);//FCR
  super.configuration(1,3'h1,8'b00000011,$random,req,1);//IER
  super.configuration(1,3'h3,8'b00001000,$random,req,1);//LCR //LCR - 4 bits in data frame
  req.rxata_done = 1;
  super.configuration(0,3'h0,$random,$random,req,1);//RBR
  //super.configuration(0,3'h0,$random,$random,req,0);
  req.rxata_done = 0;
  super.status_reg_info;
  
  super.configuration(1,3'h2,8'b00000110,$random,req,1);//FCR
  super.configuration(1,3'h1,8'b00000011,$random,req,1);//IER
  super.configuration(1,3'h3,8'b00001010,$random,req,1);//LCR //LCR - 6 bits in data frame
  req.rxata_done = 1;
  super.configuration(0,3'h0,$random,$random,req,1);//RBR
  //super.configuration(0,3'h0,$random,$random,req,0);
  req.rxata_done = 0;
  super.status_reg_info;*/

  for(int i=0;i<4;i++) begin
  super.configuration(1,3'h3,m_cfg.lcr_queue[i],$random,req,1); //LCR  //LCR - 4 bits in data frame
  req.rxata_done = 1;
  super.configuration(0,3'h0,8'b0,$random,req,1); //THR
  //super.configuration(0,3'h0,8'b0,$random,req,0); //THR
  req.rxata_done = 0;
 end
  
  
endtask
  
/////////////////////////////////////////////////////////////// 
//            MULTIPLE DATA PACKET RECEPTION                 //
///////////////////////////////////////////////////////////////
  
class multi_read_seq extends uart_rx_seq;
  `uvm_object_utils(multi_read_seq)

  extern function new(string name = "multi_read_seq");
extern task body();
endclass

  function multi_read_seq::new(string name = "multi_read_seq");
super.new(name);
endfunction

  
task multi_read_seq::body();
req = uart_rx_xtn::type_id::create("req");

//WRITE MODE
  
  /*super.configuration(1,3'h3,8'b00001011,8'b10110011,req,1);//LCR
  super.configuration(1,3'h1,8'b00000111,8'b10110011,req,1);
  super.configuration(1,3'h2,8'b11000110,8'b10110011,req,1);*/
  
  repeat(10)
    begin
      req.rxata_done = 1;
      super.configuration(0,3'h0,8'b0,$random,req,1);
      req.rxata_done = 0;
      //super.status_reg_info;
    end
    //super.configuration(0,3'h0,$random,$random,req,0);
  
endtask

/////////////////////////////////////////////////////////////// 
//                    RECEIVER FIFO OVERFLOW                 //
///////////////////////////////////////////////////////////////
  
class fifo_overflow_read_seq extends uart_rx_seq;
  `uvm_object_utils(fifo_overflow_read_seq)

  extern function new(string name = "fifo_overflow_read_seq");
extern task body();
endclass

  function fifo_overflow_read_seq::new(string name = "fifo_overflow_read_seq");
super.new(name);
endfunction

  
task fifo_overflow_read_seq::body();
req = uart_rx_xtn::type_id::create("req");

//WRITE MODE
  
  super.configuration(1,3'h3,8'b00001011,8'b10110011,req,1);//LCR
  super.configuration(1,3'h1,8'b00000111,8'b10110011,req,1);
  super.configuration(1,3'h2,8'b11000110,8'b10110011,req,1);
  
  repeat(20)
    begin
      req.rxata_done = 1;
      super.configuration(0,3'h0,$random,$random,req,1);
      req.rxata_done = 0;
      super.status_reg_info;
    end
  
endtask


/////////////////////////////////////////////////////////////// 
//              PARITY BIT ERROR INJECTION                   //
///////////////////////////////////////////////////////////////
 
class parity_error_inj_seq extends uart_rx_seq;
`uvm_object_utils(parity_error_inj_seq)

extern function new(string name = "parity_error_inj_seq");
extern task body();
endclass

function parity_error_inj_seq::new(string name = "parity_error_inj_seq");
super.new(name);
endfunction


task parity_error_inj_seq::body();
req = uart_rx_xtn::type_id::create("req");
  
  
  //super.configuration(1,3'h1,8'b00000100,$random,req,1);//IER
  
  //super.configuration(1,3'h3,8'b00001011,$random,req,1);//LCR //LCR - 7 bits in data frame
  req.rxata_done = 1;
  req.parity_err_inj = 1;
  super.configuration(0,3'h0,8'b0,8'b11100111,req,1);//RBR
  req.parity_err_inj = 0;
  repeat(2)
  super.configuration(0,3'h0,8'b0,8'b11100001,req,0);//RBR
  req.rxata_done = 0;
  //super.status_reg_info;
  
endtask  
