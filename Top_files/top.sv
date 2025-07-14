module top();

import pkg::* ;
import uvm_pkg::* ;
`include "uvm_macros.svh"

bit ACLK ;
	always #5 ACLK = ~ACLK ;

AXI_IF axi_if(ACLK) ;

initial
	begin
		
		uvm_config_db #(virtual AXI_IF):: set( null,"*","AXI_IF", axi_if);

		run_test();
	end
	
endmodule

		
	

