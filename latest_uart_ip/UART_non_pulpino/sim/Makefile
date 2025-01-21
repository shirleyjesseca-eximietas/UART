# Variables
FSDB = /home/synopsys/tools/verdi/W-2024.09/share/PLI/VCS/LINUX64
RTL = ../rtl/*
work = work # Library name
SVTB1 = ../verif/env/top.sv
INC = +incdir+../verif/env +incdir+../verif/test +incdir+../verif/tx_agent +incdir+../verif/rx_agent
SVTB2 = ../verif/test/uart_pkg.sv
VSIMOPT = -vopt -voptargs=+acc
VSIMCOV = -cm line+cond+fsm+branch+tgl+assert

# Help target
help:
	@echo =============================================================================================================
	@echo "! USAGE   	--  make target                             							!"
	@echo "! clean   	=>  Clean the earlier log and intermediate files.       					!"
	@echo "! sv_cmp    	=>  Create library and compile the code.                   					!"
	@echo "! run_test1	=>  Clean, compile & run simulation for a TESTCASE = uart_tx_single_byte_test			!"
	@echo "! run_test2	=>  Clean, compile & run simulation for a TESTCASE = uart_rx_single_byte_test			!"
	@echo "! run_test3	=>  Clean, compile & run simulation for a TESTCASE = uart_rx_multi_data_test			!"
	@echo "! run_test4	=>  Clean, compile & run simulation for a TESTCASE = uart_rx_stop_bit_test			!"
	@echo "! run_test5	=>  Clean, compile & run simulation for a TESTCASE = uart_rx_parity_err_test			!"
	@echo "! run_test6	=>  Clean, compile & run simulation for a TESTCASE = uart_rx_fifo_overflow_test			!"
	@echo "! run_test7	=>  Clean, compile & run simulation for a TESTCASE = uart_tx_multi_byte_test			!"
	@echo "! run_test8	=>  Clean, compile & run simulation for a TESTCASE = uart_tx_fifo_full_test			!"
	@echo "! run_test9	=>  Clean, compile & run simulation for a TESTCASE = uart_tx_int_test				!"
	@echo "! run_test10	=>  Clean, compile & run simulation for a TESTCASE = uart_tx_stop_bit_config_test		!"
	@echo "! run_test11	=>  Clean, compile & run simulation for a TESTCASE = uart_loopback_test				!"
	@echo "! run_test12	=>  Clean, compile & run simulation for a TESTCASE = uart_rx_baud_rate_config_test		!"
	@echo "! run_test13	=>  Clean, compile & run simulation for a TESTCASE = uart_tx_missing_dvsr_test			!"
	@echo "! run_test14	=>  Clean, compile & run simulation for a TESTCASE = uart_tx_no_baudrate_test			!"
	@echo "! run_test15	=>  Clean, compile & run simulation for a TESTCASE = uart_tx_baudrate_changing_test		!"
	@echo "! run_test16	=>  Clean, compile & run simulation for a TESTCASE = uart_rx_framing_err_test			!"
	@echo "! run_test17	=>  Clean, compile & run simulation for a TESTCASE = uart_tx_int_with_iir_test			!"
	@echo "! run_test18	=>  Clean, compile & run simulation for a TESTCASE = uart_tx_odd_parity_test			!"
	@echo "! run_test19	=>  Clean, compile & run simulation for a TESTCASE = uart_rx_dataframe_config_test		!"
	@echo "! regress    =>  Clean, compile and run all testcases in batch mode						!"
	@echo "! report     =>  Merge coverage reports for all testcases and convert to HTML format				!"
	@echo "! fun_cov    =>  Open the merged functional coverage report in HTML format					!"
	@echo "! code_cov   =>  Open the merged code coverage report in HTML format 						!"
	@echo "! view_waveX =>  View the waveform of a specific test                                                     	!"
	@echo ====================================================================================================================

# Compilation target
sv_cmp:
	vcs -l vcs.log -timescale=1ns/1ps -sverilog -ntb_opts uvm -debug_access+all -full64 -kdb -lca \
	    -P $(FSDB)/novas.tab $(FSDB)/pli.a $(RTL) $(INC) $(SVTB2) $(SVTB1) -cm_dir coverage_compile.vdb $(VSIMCOV)

# Run individual tests with separate coverage directories
run_test1: sv_cmp
	./simv -l vcs_test1.log +UVM_TESTNAME=uart_tx_single_byte_test $(VSIMCOV) -cm_name test1 +TESTCASE=uart_tx_single_byte_test
	python3 regress_testcase.py vcs_test1.log

       	
run_test2: sv_cmp
	./simv -l vcs_test2.log +UVM_TESTNAME=uart_rx_single_byte_test $(VSIMCOV) -cm_name test2 +TESTCASE=uart_rx_single_byte_test
	python3 regress_testcase.py vcs_test2.log
	

run_test3: sv_cmp
	./simv -l vcs_test3.log +UVM_TESTNAME=uart_rx_multi_data_test $(VSIMCOV) -cm_name test3 +TESTCASE=uart_rx_multi_data_test
	python3 regress_testcase.py vcs_test3.log


run_test4: sv_cmp
	./simv -l vcs_test4.log +UVM_TESTNAME=uart_rx_stop_bit_test $(VSIMCOV) -cm_name test4 +TESTCASE=uart_rx_stop_bit_test
	python3 regress_testcase.py vcs_test4.log
 

run_test5: sv_cmp
	./simv -l vcs_test5.log +UVM_TESTNAME=uart_rx_parity_err_test $(VSIMCOV) -cm_name test5 +TESTCASE=uart_rx_parity_err_test
	python3 regress_testcase.py vcs_test5.log


run_test6: sv_cmp
	./simv -l vcs_test6.log +UVM_TESTNAME=uart_rx_fifo_overflow_test $(VSIMCOV) -cm_name test6 +TESTCASE=uart_rx_fifo_overflow_test
	python3 regress_testcase.py vcs_test6.log
 

run_test7: sv_cmp
	./simv -l vcs_test7.log +UVM_TESTNAME=uart_tx_multi_byte_test $(VSIMCOV) -cm_name test7 +TESTCASE=uart_tx_multi_byte_test
	python3 regress_testcase.py vcs_test7.log
 

run_test8: sv_cmp
	./simv -l vcs_test8.log +UVM_TESTNAME=uart_tx_fifo_full_test $(VSIMCOV) -cm_name test8 +TESTCASE=uart_tx_fifo_full_test
	python3 regress_testcase.py vcs_test8.log


run_test9: sv_cmp
	./simv -l vcs_test9.log +UVM_TESTNAME=uart_tx_int_test $(VSIMCOV) -cm_name test9 +TESTCASE=uart_tx_int_test
	python3 regress_testcase.py vcs_test9.log


run_test10: sv_cmp
	./simv -l vcs_test10.log +UVM_TESTNAME=uart_tx_stop_bit_config_test $(VSIMCOV) -cm_name test10 +TESTCASE=uart_tx_stop_bit_config_test
	python3 regress_testcase.py vcs_test10.log


run_test11: sv_cmp
	./simv -l vcs_test11.log +UVM_TESTNAME=uart_loopback_test $(VSIMCOV) -cm_name test11 +TESTCASE=uart_loopback_test
	python3 regress_testcase.py vcs_test11.log


run_test12: sv_cmp
	./simv -l vcs_test12_1.log +UVM_TESTNAME=uart_rx_baud_rate_config_test $(VSIMCOV) -cm_name test12_1 +TESTCASE=uart_rx_baud_rate_config_test +baudrate=4800
	./simv -l vcs_test12_2.log +UVM_TESTNAME=uart_rx_baud_rate_config_test $(VSIMCOV) -cm_name test12_2 +TESTCASE=uart_rx_baud_rate_config_test +baudrate=9600
	./simv -l vcs_test12_3.log +UVM_TESTNAME=uart_rx_baud_rate_config_test $(VSIMCOV) -cm_name test12_3 +TESTCASE=uart_rx_baud_rate_config_test +baudrate=19200
	./simv -l vcs_test12_4.log +UVM_TESTNAME=uart_rx_baud_rate_config_test $(VSIMCOV) -cm_name test12_4 +TESTCASE=uart_rx_baud_rate_config_test +baudrate=38400
	./simv -l vcs_test12_5.log +UVM_TESTNAME=uart_rx_baud_rate_config_test $(VSIMCOV) -cm_name test12_5 +TESTCASE=uart_rx_baud_rate_config_test +baudrate=57600
	./simv -l vcs_test12_6.log +UVM_TESTNAME=uart_rx_baud_rate_config_test $(VSIMCOV) -cm_name test12_6 +TESTCASE=uart_rx_baud_rate_config_test +baudrate=115200
	./simv -l vcs_test12_7.log +UVM_TESTNAME=uart_rx_baud_rate_config_test $(VSIMCOV) -cm_name test12_7 +TESTCASE=uart_rx_baud_rate_config_test +baudrate=230400
	./simv -l vcs_test12_8.log +UVM_TESTNAME=uart_rx_baud_rate_config_test $(VSIMCOV) -cm_name test12_8 +TESTCASE=uart_rx_baud_rate_config_test +baudrate=460000
	./simv -l vcs_test12_9.log +UVM_TESTNAME=uart_rx_baud_rate_config_test $(VSIMCOV) -cm_name test12_9 +TESTCASE=uart_rx_baud_rate_config_test +baudrate=921600
	python3 regress_testcase.py vcs_test12_9.log

run_test13: sv_cmp
	./simv -l vcs_test13.log +UVM_TESTNAME=uart_tx_missing_dvsr_test  $(VSIMCOV) -cm_name test13 +TESTCASE=uart_tx_missing_dvsr_test
	python3 regress_testcase.py vcs_test13.log


run_test14: sv_cmp
	./simv -l vcs_test14.log +UVM_TESTNAME=uart_tx_no_baudrate_test $(VSIMCOV) -cm_name test14 +TESTCASE=uart_tx_no_baudrate_test
	python3 regress_testcase.py vcs_test14.log


run_test15: sv_cmp
	./simv -l vcs_test15.log +UVM_TESTNAME=uart_tx_baudrate_changing_test $(VSIMCOV) -cm_name test15 +TESTCASE=uart_tx_baudrate_changing_test
	python3 regress_testcase.py vcs_test15.log

run_test16: sv_cmp
	./simv -l vcs_test16.log +UVM_TESTNAME=uart_rx_framing_err_test $(VSIMCOV) -cm_name test16 +TESTCASE=uart_rx_framing_err_test
	python3 regress_testcase.py vcs_test16.log

run_test17: sv_cmp
	./simv -l vcs_test17.log +UVM_TESTNAME=uart_tx_int_with_iir_test $(VSIMCOV) -cm_name test17 +TESTCASE=uart_tx_int_with_iir_test
	python3 regress_testcase.py vcs_test17.log

run_test18: sv_cmp
	./simv -l vcs_test18.log +UVM_TESTNAME=uart_tx_odd_parity_test $(VSIMCOV) -cm_name test18 +TESTCASE=uart_tx_odd_parity_test
	python3 regress_testcase.py vcs_test18.log

run_test19: sv_cmp
	./simv -l vcs_test19.log +UVM_TESTNAME=uart_rx_dataframe_config_test $(VSIMCOV) -cm_name test19 +TESTCASE=uart_rx_dataframe_config_test
	python3 regress_testcase.py vcs_test19.log

run_test20: sv_cmp
	./simv -l vcs_test20.log +UVM_TESTNAME=uart_rx_no_parity_test $(VSIMCOV) -cm_name test20 +TESTCASE=uart_rx_no_parity_test
	python3 regress_testcase.py vcs_test20.log




# Clean target
clean:
	rm -rf simv* csrc* *.tmp *.vpd *.vdb *.key *.log *hdrs.h *.fsdb verdi* coverage_report coverage *.log DVE*
	clear

# View waveforms
view_wave1:
	verdi -ssf wave1.fsdb

report:
	#urg -dir simv.vdb -report coverage_report -format both
	urg -dir ./coverage_compile.vdb -dbname merged_dir/merged


# Regression target
regress: clean run_test1 run_test2 run_test3 run_test4 run_test5 run_test6 run_test7 run_test8 run_test9 run_test10 run_test11 run_test12 run_test13 run_test14 run_test15 run_test16 run_test17 run_test18 run_test19 run_test20


# Open functional coverage report
fun_cov:
	firefox coverage_report/grp*.html &

# Open code coverage report
code_cov:
	./simv -verdi -cov
	#firefox coverage_report/dashboard.html
	#verdi -cov -covdir merged_dir.vdb
	

