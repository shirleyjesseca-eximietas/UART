//----------------------------------------------------------------------
//   Copyright 2011-2012 Mentor Graphics Corporation
//   All Rights Reserved Worldwide
//
//   Licensed under the Apache License, Version 2.0 (the
//   "License"); you may not use this file except in
//   compliance with the License.  You may obtain a copy of
//   the License at
//
//       http://www.apache.org/licenses/LICENSE-2.0
//
//   Unless required by applicable law or agreed to in
//   writing, software distributed under the License is
//   distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
//   CONDITIONS OF ANY KIND, either express or implied.  See
//   the License for the specific language governing
//   permissions and limitations under the License.
//----------------------------------------------------------------------

// This UART is based on the 16550 UART but with an APB interface
//
// It has a similar pin-out and register map however it may
// not be exactly compatible in terms of functionality and
// timing
//
// It is provided as part of a verification environment and is
// not intended to be used as design IP

module uart_16550 (
  // APB Signals
  input PCLK,
  input PRESETn,
  input [31:0] PADDR,
  input [31:0] PWDATA,
  output[31:0] PRDATA,
  input PWRITE,
  input PENABLE,
  input PSEL,
  output PREADY,
  output PSLVERR,
  // UART interrupt request line
  output IRQ,
  // UART signals
  // serial input/output
  output TXD,
  input RXD,
  // modem signals
  output nRTS,
  output nDTR,
  output nOUT1,
  output nOUT2,
  input nCTS,
  input nDSR,
  input nDCD,
  input nRI,
  // Baud rate generator output - needed for checking
  output baud_o
  );

// Interconnect
// Transmitter related:
wire tx_fifo_we;
wire tx_enable;
wire[4:0] tx_fifo_count;
wire tx_fifo_empty;
wire tx_fifo_full;
wire tx_busy;
// Receiver related:
wire[10:0] rx_data_out;
wire rx_idle;
wire rx_overrun;
wire parity_error;
wire framing_error;
wire break_error;
wire[4:0] rx_fifo_count;
wire rx_fifo_empty;
wire push_rx_fifo;
wire rx_enable;
wire rx_fifo_re;
wire loopback;

wire[7:0] LCR;

uart_register_file control(.PCLK(PCLK),
                           .PRESETn(PRESETn),
                           .PSEL(PSEL),
                           .PWRITE(PWRITE),
                           .PENABLE(PENABLE),
                           .PADDR(PADDR[6:2]),
                           .PWDATA(PWDATA),
                           .PRDATA(PRDATA),
                           .PREADY(PREADY),
                           .PSLVERR(PSLVERR),
                           .LCR(LCR),
                           // Transmitter related signals
                           .tx_fifo_we(tx_fifo_we),
                           .tx_enable(tx_enable),
                           .tx_fifo_count(tx_fifo_count),
                           .tx_fifo_empty(tx_fifo_empty),
                           .tx_fifo_full(tx_fifo_full),
                           .tx_busy(tx_busy),
                           // Receiver related signals
                           .rx_idle(rx_idle),
                           .rx_data_out(rx_data_out),
                           .rx_overrun(rx_overrun),
                           .parity_error(parity_error),
                           .framing_error(framing_error),
                           .break_error(break_error),
                           .rx_fifo_count(rx_fifo_count),
                           .rx_fifo_empty(rx_fifo_empty),
                           .rx_fifo_full(rx_fifo_full),
                           .push_rx_fifo(push_rx_fifo),
                           .rx_enable(rx_enable),
                           .rx_fifo_re(rx_fifo_re),
                           // Modem interface related signals
                           .loopback(loopback),
                           .dsrn(nDSR),
                           .dcdn(nDCD),
                           .rin(nRI),
                           .ctsn(nCTS),
                           .rtsn(nRTS),
                           .dtrn(nDTR),
                           .out1n(nOUT1),
                           .out2n(nOUT2),
                           .irq(IRQ),
                           .baud_o(baud_o)
                          );

// Transmitter and TX FIFO
uart_tx tx_channel(
  .PCLK(PCLK),
  .PRESETn(PRESETn),
  .PWDATA(PWDATA[7:0]),
  .tx_fifo_push(tx_fifo_we),
  .LCR(LCR),
  .enable(tx_enable),
  .tx_fifo_empty(tx_fifo_empty),
  .tx_fifo_full(tx_fifo_full),
  .tx_fifo_count(tx_fifo_count),
  .busy(tx_busy),
  .TXD(TXDout));

// Receiver and RX FIFO
uart_rx rx_channel(
  .PCLK(PCLK),
  .PRESETn(PRESETn),
  .RXD(RXDin),
  .pop_rx_fifo(rx_fifo_re),
  .enable(rx_enable),
  .LCR(LCR),
  .rx_idle(rx_idle),
  .rx_fifo_out(rx_data_out),
  .rx_fifo_count(rx_fifo_count),
  .push_rx_fifo(push_rx_fifo),
  .rx_fifo_empty(rx_fifo_empty),
  .rx_fifo_full(rx_fifo_full),
  .rx_overrun(rx_overrun),
  .parity_error(parity_error),
  .framing_error(framing_error),
  .break_error(break_error));


// handle loopback
assign RXDin = loopback ? TXD : RXD;
assign TXD = TXDout;

// Assertions for UART Protocol
// Framing Error Check
property A1_framing_error_check;
  @(posedge PCLK) disable iff (!PRESETn)
  (rx_enable && !rx_fifo_empty) |-> !framing_error;
endproperty
Framing_Error_Check: assert property (A1_framing_error_check) else $error("Framing error detected.");

// Parity Check
property A2_parity_check;
  @(posedge PCLK) disable iff (!PRESETn)
  (rx_enable && LCR[3]) |-> !parity_error;
endproperty
Parity_Check: assert property (A2_parity_check) else $error("Parity error detected.");

// TX FIFO No Underflow
property A3_tx_fifo_no_underflow;
  @(posedge PCLK) disable iff (!PRESETn)
  tx_fifo_we |=> !tx_fifo_empty;
endproperty
Tx_Fifo_No_Underflow: assert property (A3_tx_fifo_no_underflow) else $error("TX FIFO underflow detected.");

// Transmit Data Validity
property A4_tx_data_valid;
  @(posedge PCLK) disable iff (!PRESETn)
  (tx_enable && !tx_fifo_empty) |-> (TXDout !== 1'bx);
endproperty

Tx_Data_Valid: assert property (A4_tx_data_valid) else $error("Invalid data transmitted.");

// Receiver Data Validity
property A5_rx_data_valid;
  @(posedge PCLK) disable iff (!PRESETn)
  (rx_enable && !rx_fifo_empty) |-> (rx_data_out !== 11'bx);
endproperty
Rx_Data_Valid: assert property (A5_rx_data_valid) else $error("Invalid data received.");

// Parity Enable Consistency
property A6_parity_enable_consistency;
  @(posedge PCLK) disable iff (!PRESETn)
  (LCR[3] == 1'b1) |-> (LCR[4:5] != 2'b00);
endproperty
Parity_Enable_Consistency: assert property (A6_parity_enable_consistency) else $error("Parity enable configuration is inconsistent.");

// Baud Rate Generator Active
property A7_baud_rate_generator_active;
  @(posedge PCLK) disable iff (!PRESETn)
  baud_o > 0 |-> (tx_enable || rx_enable);
endproperty
Baud_Rate_Generator_Active: assert property (A7_baud_rate_generator_active) else $error("Baud rate generator is not active when UART is in use.");

// CTS and RTS Synchronization
property A8_cts_rts_sync;
  @(posedge PCLK) disable iff (!PRESETn)
  !nCTS |-> (nRTS == 1'b0);
endproperty
Cts_Rts_Sync: assert property (A8_cts_rts_sync) else $error("CTS and RTS signals are not synchronized.");

// DSR and DTR Synchronization
property A9_dsr_dtr_sync;
  @(posedge PCLK) disable iff (!PRESETn)
  !nDSR |-> (nDTR == 1'b0);
endproperty
Dsr_Dtr_Sync: assert property (A9_dsr_dtr_sync) else $error("DSR and DTR signals are not synchronized.");

// Data Terminal Ready Control
property A10_dtr_control;
  @(posedge PCLK) disable iff (!PRESETn)
  (nDTR == 1'b0) |-> (nDSR == 1'b0);
endproperty
Dtr_Control: assert property (A10_dtr_control) else $error("Data Terminal Ready signal is not properly controlled.");

// IRQ Assertion
property A11_irq_assertion;
  @(posedge PCLK) disable iff (!PRESETn)
  IRQ |=> (rx_fifo_full || tx_fifo_empty || framing_error || parity_error || break_error);
endproperty
Irq_Assertion: assert property (A11_irq_assertion) else $error("IRQ signal is not asserted correctly.");  

endmodule: uart_16550
