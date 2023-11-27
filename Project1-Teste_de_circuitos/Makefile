
GUI = -gui -access +r

sim:
	xrun $(GUI) controller_tb.v controller.v counter_M.v counter_N.v state_machine.v shift_reg.v 

sim_cov:
	xrun -covfile cov.ccf -covoverwrite controller_tb.v controller.v counter_M.v counter_N.v state_machine.v shift_reg.v 
	imc -verbose -load cov_work/scope/test -exec imc.tcl

clean:
	rm -rf cov_detail_report cov_work xcelium.d *.key *.log *.history
