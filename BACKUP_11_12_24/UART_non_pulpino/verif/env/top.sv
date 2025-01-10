`include "/home/shirley/work_space/DV_VLSI/UART_non_pulpino/rtl/uart_if.sv"



package uart_pkg;
`timescale 1ns/1ns

import uvm_pkg::*;
`include "uvm_macros.svh"

`include "/home/shirley/work_space/DV_VLSI/UART_non_pulpino/verif/tx_agent/uart_tx_xtn.sv"
`include "/home/shirley/work_space/DV_VLSI/UART_non_pulpino/verif/tx_agent/uart_tx_cfg.sv"
`include "/home/shirley/work_space/DV_VLSI/UART_non_pulpino/verif/rx_agent/uart_rx_cfg.sv"
`include "/home/shirley/work_space/DV_VLSI/UART_non_pulpino/verif/env/uart_env_cfg.sv"
`include "/home/shirley/work_space/DV_VLSI/UART_non_pulpino/verif/tx_agent/uart_tx_drv.sv"
`include "/home/shirley/work_space/DV_VLSI/UART_non_pulpino/verif/tx_agent/uart_tx_mon.sv"
`include "/home/shirley/work_space/DV_VLSI/UART_non_pulpino/verif/tx_agent/uart_tx_seqr.sv"
`include "/home/shirley/work_space/DV_VLSI/UART_non_pulpino/verif/tx_agent/uart_tx_single_byte_seq.sv"
`include "/home/shirley/work_space/DV_VLSI/UART_non_pulpino/verif/tx_agent/uart_tx_agent.sv"

//`include "/home/shirley/work_space/DV_VLSI/UART_non_pulpino/verif/rx_agent/uart_rx_xtn.sv"
//`include "/home/shirley/work_space/DV_VLSI/UART_non_pulpino/verif/rx_agent/uart_rx_drv.sv"
//`include "/home/shirley/work_space/DV_VLSI/UART_non_pulpino/verif/rx_agent/uart_rx_mon.sv"
//`include "/home/shirley/work_space/DV_VLSI/UART_non_pulpino/verif/rx_agent/uart_rx_seqr.sv"
//`include "/home/shirley/work_space/DV_VLSI/UART_non_pulpino/verif/rx_agent/uart_rx_seq.sv"
//`include "/home/shirley/work_space/DV_VLSI/UART_non_pulpino/verif/rx_agent/uart_rx_agent.sv"

`include "/home/shirley/work_space/DV_VLSI/UART_non_pulpino/verif/env/uart_scoreboard.sv"
`include "/home/shirley/work_space/DV_VLSI/UART_non_pulpino/verif/env/uart_virtual_seqr.sv"
`include "/home/shirley/work_space/DV_VLSI/UART_non_pulpino/verif/env/uart_virtual_seq.sv"


`include "/home/shirley/work_space/DV_VLSI/UART_non_pulpino/verif/env/uart_env.sv"
//`include "/home/shirley/work_space/DV_VLSI/UART_non_pulpino/verif/test/uart_test.sv
`include "/home/shirley/work_space/DV_VLSI/UART_non_pulpino/verif/test/uart_tx_single_byte_test.sv"

endpackage



module top;
`timescale 1ns/1ns

import uart_pkg::*;
import uvm_pkg::*;
bit clock;

uart_if in(clock);

uart_16550 DUT (
   .PCLK(clock),
   .PRESETn(in.PRESETn),
   .PADDR(in.PADDR),
   .PWDATA(in.PWDATA),
   .PRDATA(in.PRDATA),
   .PWRITE(in.PWRITE),
   .PENABLE(in.PENABLE),
   .PSEL(in.PSEL),
   .PREADY(in.PREADY),
   .PSLVERR(in.PSLVERR),
   .IRQ(in.IRQ),
   .TXD(in.TXD),
   .RXD(in.RXD),
   .nRTS(in.nRTS),
   .nDTR(in.nDTR),
   .nOUT1(in.nOUT1),
   .nOUT2(in.nOUT2),
   .nCTS(in.nCTS),
   .nDSR(in.nDSR),
   .nDCD(in.nDCD),
   .baud_o(in.baud_o)
  );

always #10 clock = ~clock;

initial begin
//	$dumpfile("apb_drv.vcd");
  //    $dumpvars(0,top);
        $vcdplusfile("uart_11_12_24.vpd");
        $vcdpluson;
        $vcdplusmemon;
	clock = 0;
	uvm_config_db #(virtual uart_if)::set(null,"*","uart_if",in);
	run_test("uart_tx_single_byte_test");

end
endmodule
