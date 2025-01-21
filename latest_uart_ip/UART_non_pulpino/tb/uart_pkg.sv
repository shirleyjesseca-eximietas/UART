package uart_pkg;

import uvm_pkg::*;
`include "uvm_macros.svh"

`include "uart_tx_xtn.sv"
`include "uart_tx_cfg.sv"
`include "uart_rx_cfg.sv"
`include "uart_env_cfg.sv"
`include "uart_tx_drv.sv"
`include "uart_tx_mon.sv"
`include "uart_tx_seqr.sv"
`include "uart_tx_seq.sv"

`include "uart_tx_single_byte_seq.sv"
`include "uart_tx_multi_byte_seq.sv"
`include "uart_tx_fifo_full_seq.sv"
`include "uart_tx_int_seq.sv"
`include "uart_tx_stop_bit_config_seq.sv"
`include "uart_tx_no_baudrate_seq.sv"
`include "uart_loopback_seq.sv"
`include "uart_tx_baudrate_changing_seq.sv"

`include "uart_tx_agent.sv"


`include "uart_rx_xtn.sv"
`include "uart_rx_drv.sv"
`include "uart_rx_mon.sv"
`include "uart_rx_seqr.sv"
`include "uart_rx_seq.sv"

`include "uart_rx_single_data_seq.sv"
`include "uart_rx_multi_data_seq.sv"
`include "uart_rx_framing_err_seq.sv"
`include "uart_rx_parity_err_seq.sv"
`include "uart_rx_fifo_overflow_seq.sv"
`include "uart_rx_stop_bit_seq.sv"

`include "uart_rx_agent.sv"


`include "uart_scoreboard.sv"
`include "uart_virtual_seqr.sv"
`include "uart_virtual_seq.sv"


`include "uart_env.sv"
`include "uart_test.sv"
`include "uart_loopback_test.sv"

`include "uart_tx_single_byte_test.sv"
`include "uart_tx_multi_byte_test.sv"
`include "uart_tx_fifo_full_test.sv"
`include "uart_tx_int_test.sv"
`include "uart_tx_stop_bit_config_test.sv"
`include "uart_tx_no_baudrate_test.sv"
`include "uart_tx_baudrate_changing_test.sv"

`include "uart_rx_single_byte_test.sv"
`include "uart_rx_multi_data_test.sv"
`include "uart_rx_parity_err_test.sv"
`include "uart_rx_fifo_overflow_test.sv"
`include "uart_rx_stop_bit_test.sv"
`include "uart_rx_framing_err_test.sv"


endpackage

