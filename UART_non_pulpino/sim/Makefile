# Variables
FSDB = /home/synopsys/tools/verdi/W-2024.09/share/PLI/VCS/LINUX64
RTL = ../rtl/*
work = work # Library name
SVTB1 = ../verif/env/top.sv
INC = +incdir+../verif/env +incdir+../verif/test +incdir+../verif/tx_agent +incdir+../verif/rx_agent
SVTB2 = ../verif/test/uart_pkg.sv
VSIMOPT = -vopt -voptargs=+acc
VSIMCOV = -cm line+cond+fsm+branch+tgl #+func

# Help target
help:
	@echo =============================================================================================================
	@echo "! USAGE   	--  make target                             							!"
	@echo "! clean   	=>  Clean the earlier log and intermediate files.       					!"
	@echo "! sv_cmp    	=>  Create library and compile the code.                   					!"
	@echo "! run_testX	=>  Clean, compile & run simulation for a specific test in batch mode.		!"
	@echo "! regress    =>  Clean, compile and run all testcases in batch mode						!"
	@echo "! report     =>  Merge coverage reports for all testcases and convert to HTML format				!"
	@echo "! fun_cov    =>  Open the merged functional coverage report in HTML format					!"
	@echo "! code_cov   =>  Open the merged code coverage report in HTML format 						!"
	@echo "! view_waveX =>  View the waveform of a specific test                                                     	!"
	@echo ====================================================================================================================

# Compilation target
sv_cmp:
	vcs -l vcs.log -timescale=1ns/1ps -sverilog -ntb_opts uvm -debug_access+all -full64 -kdb -lca \
	    -P $(FSDB)/novas.tab $(FSDB)/pli.a $(RTL) $(INC) $(SVTB2) $(SVTB1) $(VSIMCOV) -cm_dir coverage_comp_12_30.vdb +define+COVERAGE #-cm_dir coverage_compile.vdb



#./simv -cm line+cond+fsm+tgl+branch -cm_name test1 -cm_dir ./cov_report +UVM_TESTNAME=uart_tx_single_byte_test

# Run individual tests with separate coverage directories
run_test1: sv_cmp
	#./simv -l vcs.log +fsdbfile+wave1.fsdb +ntb_random_seed_automatic +UVM_TESTNAME=uart_tx_single_byte_test  -cm_name test1 +TESTCASE=uart_tx_single_byte_test $(VSIMCOV)
	./simv -l vcs_test1.log +fsdbfile+wave1.fsdb +ntb_random_seed_automatic +UVM_TESTNAME=uart_tx_single_byte_test -cm_name test1 +TESTCASE=uart_tx_single_byte_test  


run_test2: sv_cmp
	./simv -l vcs.log +fsdbfile+wave2.fsdb +ntb_random_seed_automatic +UVM_TESTNAME=uart_rx_single_byte_test $(VSIMCOV) -cm_name test2 -cm_dir coverage_comp_2.vdb +TESTCASE=uart_rx_single_byte_test  

run_test3: sv_cmp
	./simv -l vcs.log +fsdbfile+wave3.fsdb +ntb_random_seed_automatic +UVM_TESTNAME=uart_rx_multi_data_test $(VSIMCOV) -cm_name test3 +TESTCASE=uart_rx_multi_data_test -cm_dir coverage_comp_3.vdb 

run_test4: sv_cmp
	./simv -l vcs.log +fsdbfile+wave4.fsdb +ntb_random_seed_automatic +UVM_TESTNAME=uart_rx_stop_bit_test $(VSIMCOV) -cm_name test4 +TESTCASE=uart_rx_stop_bit_test -cm_dir coverage_comp_4.vdb 

run_test5: sv_cmp
	./simv -l vcs.log +fsdbfile+wave5.fsdb +ntb_random_seed_automatic +UVM_TESTNAME=uart_rx_parity_err_test $(VSIMCOV) -cm_name test5 +TESTCASE=uart_rx_parity_err_test -cm_dir coverage_comp_5.vdb 

run_test6: sv_cmp
	./simv -l vcs.log +fsdbfile+wave6.fsdb +ntb_random_seed_automatic +UVM_TESTNAME=uart_rx_fifo_overflow_test $(VSIMCOV) -cm_name test6 +TESTCASE=uart_rx_fifo_overflow_test -cm_dir coverage_comp_6.vdb 

run_test7: sv_cmp
	./simv -l vcs.log +fsdbfile+wave7.fsdb +ntb_random_seed_automatic +UVM_TESTNAME=uart_tx_multi_byte_test $(VSIMCOV) -cm_name test7 +TESTCASE=uart_tx_multi_byte_test -cm_dir coverage_comp_7.vdb 

run_test8: sv_cmp
	./simv -l vcs.log +fsdbfile+wave8.fsdb +ntb_random_seed_automatic +UVM_TESTNAME=uart_tx_fifo_full_test $(VSIMCOV) -cm_name test8 +TESTCASE=uart_tx_fifo_full_test -cm_dir coverage_comp_8.vdb 

run_test9: sv_cmp
	./simv -l vcs.log +fsdbfile+wave9.fsdb +ntb_random_seed_automatic +UVM_TESTNAME=uart_tx_int_test $(VSIMCOV) -cm_name test9 +TESTCASE=uart_tx_int_test -cm_dir coverage_comp_9.vdb 

run_test10: sv_cmp
	./simv -l vcs.log +fsdbfile+wave10.fsdb +ntb_random_seed_automatic +UVM_TESTNAME=uart_tx_stop_bit_config_test $(VSIMCOV) -cm_name test10 +TESTCASE=uart_tx_stop_bit_config_test -cm_dir coverage_comp_10.vdb 

run_test11: sv_cmp
	./simv -l vcs.log +fsdbfile+wave11.fsdb +ntb_random_seed_automatic +UVM_TESTNAME=uart_loopback_test $(VSIMCOV) -cm_name test11 +TESTCASE=uart_loopback_test -cm_dir coverage_comp_11.vdb 

run_test12: sv_cmp
	./simv -l vcs.log +fsdbfile+wave12.fsdb +ntb_random_seed_automatic +UVM_TESTNAME=uart_tx_baud_rate_config_test $(VSIMCOV) -cm_name test12 +TESTCASE=uart_tx_baud_rate_config_test -cm_dir coverage_comp_12.vdb 

run_test13: sv_cmp
	./simv -l vcs.log +fsdbfile+wave13.fsdb +ntb_random_seed_automatic +UVM_TESTNAME=uart_tx_reset_test $(VSIMCOV) -cm_name test13 +TESTCASE=uart_tx_reset_test -cm_dir coverage_comp_13.vdb 



check_fun_rep:
	urg -dir ./report2_new.vdb/ -report ./cov_17_12_new




# Clean target
clean:
	rm -rf simv* csrc* *.tmp *.vpd *.vdb *.key *.log *hdrs.h *.fsdb verdi* coverage_report coverage *.log DVE*
	clear

# View waveforms
view_wave1:
	verdi -ssf wave1.fsdb

view_wave2:
	verdi -ssf wave2.fsdb

view_wave3:
	verdi -ssf wave3.fsdb

view_wave4:
	verdi -ssf wave4.fsdb

view_wave5:
	verdi -ssf wave5.fsdb

view_wave6:
	verdi -ssf wave6.fsdb

report:
	#urg -dir simv.vdb -report coverage_report -format both
	urg -dir ./coverage_compile.vdb -dbname merged_dir/merged


# Regression target
regress:run_test1 run_test2 run_test3 run_test4 run_test5 run_test6 run_test7 run_test8 run_test9 run_test10 run_test11 run_test12


# Open functional coverage report
fun_cov:
	firefox coverage_report/grp*.html &

# Open code coverage report
code_cov:
	#firefox coverage_report/dashboard.html
	verdi -cov -covdir merged_dir.vdb


wave:
	dve -full64 -vpd uart_new.vpd
	

