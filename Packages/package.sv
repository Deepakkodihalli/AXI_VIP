package pkg;

	import uvm_pkg::* ;
	`include "uvm_macros.svh"
	
	`include "slave_cfg.sv"	
	`include "master_cfg.sv"
	`include "env_cfg.sv"
	
	`include "master_driver.sv"
	`include "master_seqr.sv"
	`include "master_monitor.sv"
	`include "master_agt.sv"
	`include "master_agt_top.sv"
	
	`include "slave_drv.sv"
	`include "slave_seqr.sv"
	`include "slave_mon.sv"
	`include "slave_agt.sv"
	`include "slave_agt_top.sv"
	
	`include "env.sv"
	`include "test.sv"
	
endpackage
	