class axi_xtn extends uvm_sequence_item;

	`uvm_object_utils(axi_xtn);
	
	bit ARESETn;
	
	rand bit [3:0] AWID;
	rand bit [31:0] AWADDR;
	rand bit [7:0] AWLEN;
	rand bit [2:0] AWSIZE;
	rand bit [1:0] AWBURST;
	bit AWVALID;
	bit AWREADY;
	
	rand bit [3:0] WID;
	rand bit [31:0] WDATA[];
	rand bit [3:0] WSTRB[];
    bit WLAST;
	bit WVALID;
	bit WREADY;
	
	rand bit [3:0] BID;
	bit [1:0] BRESP;
	bit BVALID;
	bit BREADY;
	
	rand bit [3:0] ARID;
	rand bit [31:0] ARADDR;
	rand bit [7:0] ARLEN;
	rand bit [2:0] ARSIZE;
	rand bit [1:0] ARBURST;
	bit ARREADY;
	bit ARVALID;
	
	rand bit [3:0] RID;
	rand bit [31:0] RDATA[];
	rand bit [1:0] RRESP;
	bit RLAST;
	bit RREADY;
	bit RVALID;
	bit [3:0] RSTRB[];
	
// write data

	bit [31:0] addr[];
	int no_bytes;
	int aligned_addr;
	int start_addr;
	
// read data

	bit [31:0] raddr[];
	int no_rbytes;
	int aligned_raddr;
	int start_raddr;
	
	
	constraint wdata_c  { WDATA.size() == (AWLEN+1);}
	constraint ardata_c { RDATA.size() == (ARLEN+1);}
	constraint awb 		{ AWBURST dist{ 0:=10, 1:= 10, 2:= 10};} 
	constraint arb 		{ ARBURST dist{ 0:=10, 1:= 10, 2:= 10};}
	
	
	constraint write_id_c { AWID == WID; BID == WID;}
	constraint read_id_c  { RID == ARID;}
	constraint aws_c	  { AWSIZE dist{ 0:= 10, 1:=10, 2:= 10};}
	constraint ars_c	  { ARSIZE dist{ 0:= 10, 1:=10, 2:= 10};}
	
	constraint awl_c	{ if(AWBURST == 2) (AWLEN+1) inside{2,4,8,16};}
	constraint arl_c	{ if(ARBURST == 2) (ARLEN+1) inside(2,4,8,16};}
	
	
	constraint write_alignment_c1	{ ((AWBURST == 2'b10 || AWBURST == 2'b00) && AWSIZE == 1) -> AWADDR%2 == 0;}
	constraint write_alignment_c2	{ ((AWBURST == 2'b10 || AWBURST == 2'b00) && AWSIZE == 2) -> AWADDR%4 == 0;}
	
	
	constraint Read_alignment_c1	{ ((ARBURST == 2'b10 || ARBURST == 2'b00) && ARSIZE == 1) -> ARADDR%2 == 0;}
	constraint Read_alignment_c2	{ ((ARBURST == 2'b10 || ARBURST == 2'b00) && ARSIZE == 2) -> ARADDR%4 == 0;}
	
	constraint max_boundary_c	{(2**AWSIZE)*(AWLEN+1)< 4096;}
	constraint max_boundary_cr	{(2**ARSIZE)*(ARLEN+1)<4096;}
	
	constraint awlent_c		{AWLEN inside{[1:17]};}
	constraint arlent_c		{ARLEN inside{[1:17]};}
	
	extern function new(string name = "axi_xtn");
	extern function do_print (uvm_printer printer);
	extern function do_compare(uvm_object rhs, uvm_comparer comparer);
	extern function void post_randomize();
	extern function void cal_addr();
	extern function void strb_cal();
	extern function void cal_raddr();
	extern function void strb_rcal();

endclass

function axi_xtn:: new(string name = "axi_xtn");
	super.new(name);
endfunction

function void axi_xtn:: post_randomize();

	// For write
	
	no_bytes = 2**AWSIZE;
	aligned_addr = (int'(AWADDR/no_bytes))*no_bytes;
	start_addr = AWADDR;
	WSTRB = new[AWLEN+1];
	
	// For Read
	
	no_rbytes = 2**ARSIZE;
	aligned_raddr = (int'(ARADDR/no_rbytes))*no_rbytes;
	start_raddr = ARADDR;
	RSTRB = new[ARLEN+1];
	
	cal_addr();
	strb_cal();
	
	cal_raddr();
	
endfunction


function void axi_xtn:: cal_addr();

	bit wb; // wrap boundary
	int burst_len = AWLEN+1;
	int N = burst_len;
	int initial_addr = (int'(AWADDR/(no_bytes*burst_len)))*(no_bytes*burst_len);
	int addr_n = initial_addr + (no_bytes*burst_len);
	
	addr = new[AWLEN+1];
	addr[0] = AWADDR;
	
	no_bytes = 2**AWSIZE;
	aligned_addr = (int'(AWADDR/no_bytes))*no_bytes;
	start_addr = AWADDR;
	
	for(int i=1; i< burst_len; i++)
		begin
			if(AWBURST==0)
				addr[i] = AWADDR;
				
			if(AWBURST==1)
				begin	
					addr[i] = aligned_addr + i*no_bytes;
				end
				
			if(AWBURST==2)
				begin
					if(wb==0)
						begin
							addr[i] = aligned_addr + i*no_bytes;
							if(addr[i] == (initial_addr +(no_bytes*burst_len)))
							begin
								addr[i] = initial_addr;
								wb++;
							end
						end
						
					else
						addr[i] = start_addr + (i*no_bytes) - (no_bytes*burst_len);
						
				end
		end
		
endfunction

function void axi_xtn:: strb_cal();

	int data_bus_bytes = 4;
	int lower_byte_lane, upper_byte_lane;
	
	int lower_byte_lane_0 = start_addr -((int'(start_raddr/data_bus_bytes))*data_bus_bytes);
	int upper_byte_lane_0 = (aligned_addr + (no_bytes-1)) - ((int'(start_addr/data_bus_bytes))*data_bus_bytes);
	
	for(int j = lower_byte_lane_0; j<= upper_byte_lane_o; j++)
	begin
		WSTRB[0][j] = 1;
	end
	
	for(int i=1;i<(AWLEN+1);i++)
		begin
			lower_byte_lane = addr[i]-(int'(addr[i]/data_bus_bytes))*data_bus_bytes;
			upper_byte_lane = lower_byte_lane +no_bytes-1;
			
			for(int j= lower_byte_lane; j<= upper_byte_lane; j++)
				WSTRB[i][j] = 1;
		end
endfunction

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	
	