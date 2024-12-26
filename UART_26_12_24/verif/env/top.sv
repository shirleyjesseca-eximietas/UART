module top;

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

assign in.LCR = DUT.LCR;
assign in.tx_fifo_empty = DUT.tx_fifo_empty;
assign in.tx_fifo_full = DUT.tx_fifo_full;
assign in.tx_fifo_count = DUT.tx_fifo_count;


initial begin
//	$dumpfile("apb_drv.vcd");
  //    $dumpvars(0,top);
        $vcdplusfile("uart_new.vpd");
        $vcdpluson;
        $vcdplusmemon;
	clock = 0;
	uvm_config_db #(virtual uart_if)::set(null,"*","uart_if",in);
	run_test();

end


endmodule
