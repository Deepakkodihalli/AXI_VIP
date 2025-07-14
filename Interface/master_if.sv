interface AXI_IF(input bit clk);

	logic [3:0] AWID;
	logic [31:0] AWADDR;
	logic [7:0] AWLEN;
	logic [2:0] AWSIZE;
	logic [1:0] AWBURST;
	logic AWVALID;
	logic AWREADY;
	
	logic [3:0] WID;
	logic [31:0] WDATA;
	logic [3:0] WSTRB;
	logic WLAST;
	logic WVALID;
	logic WREADY;
	
	logic [3:0] BID;
	logic [1:0] BRESP;
	logic BVALID;
	logic BREADY;
	
	logic [3:0] ARID;
	logic [31:0] ARADDR;
	logic [7:0] ARLEN;
	logic [2:0] ARSIZE;
	logic [1:0] ARBURST;
	logic ARREADY;
	logic ARVALID;
	
	logic [3:0] RID;
	logic [31:0] RDATA;
	logic [1:0] RRESP;
	logic RLAST;
	logic RREADY;
	logic RVALID;
	logic [3:0] RSTRB;

clocking mst_drv_cb @(posedge clk);

	// output from write address channel
	output AWID, AWADDR, AWLEN, AWSIZE, AWBURST, AWVALID; 
	
	// output from the read address channel
	output ARID, ARADDR, ARLEN, ARSIZE, ARBURST, ARVALID;
	
	// output from write data channel
	output WID, WDATA, WSTRB, WLAST, WVALID;
	
	// output from read data channel
	output RREADY;
	
	// output from write response channel
	output BREADY;
	
	
	
	// input from write address channel
	input AWREADY;
	
	// input from read address channel
	input ARREADY;
	
	// input from write data channel
	input WREADY;
	
	// input from read data channel
	input RID, RDATA, RRESP, RLAST, RVALID, RSTRB;
	
	// input from write response channel
	input BID, BVALID, BRESP;
	
	
	
endclocking

clocking mst_mon_cb @(posedge clk);
	
	// input from write address channel
	input AWID, AWADDR, AWLEN, AWSIZE, AWBURST, AWVALID; 
	
	//input from the read address channel
	input ARID, ARADDR, ARLEN, ARSIZE, ARBURST, ARVALID;
	
	// input from write data channel
	input WID, WDATA, WSTRB, WLAST, WVALID;
	
	// input from read data channel
	input RREADY;
	
	// input from write response channel
	input BREADY;
	
	
	
	// input from write address channel
	input AWREADY;
	
	// input from read address channel
	input ARREADY;
	
	// input from write data channel
	input WREADY;
	
	// input from read data channel
	input RID, RDATA, RRESP, RLAST, RVALID, RSTRB;
	
	// input from write response channel
	input BID, BVALID, BRESP;
	
endclocking
clocking slv_drv_cb @(posedge clk);

	// input from write address channel
	input AWID, AWADDR, AWLEN, AWSIZE, AWBURST, AWVALID; 
	
	//input from the read address channel
	input ARID, ARADDR, ARLEN, ARSIZE, ARBURST, ARVALID;
	
	// input from write data channel
	input WID, WDATA, WSTRB, WLAST, WVALID;
	
	// input from read data channel
	input RREADY;
	
	// input from write response channel
	input BREADY;
	
	
	
	// output from write address channel
	output AWREADY;
	
	// output from read address channel
	output ARREADY;
	
	// output from write data channel
	output WREADY;
	
	// output from read data channel
	output RID, RDATA, RRESP, RLAST, RVALID, RSTRB;
	
	//output from write response channel
	output BID, BVALID, BRESP;
	
endclocking

clocking slv_mon_cb @(posedge clk);

// input from write address channel
	input AWID, AWADDR, AWLEN, AWSIZE, AWBURST, AWVALID; 
	
	//input from the read address channel
	input ARID, ARADDR, ARLEN, ARSIZE, ARBURST, ARVALID;
	
	// input from write data channel
	input WID, WDATA, WSTRB, WLAST, WVALID;
	
	// input from read data channel
	input RREADY;
	
	// input from write response channel
	input BREADY;
	
	
	
	// input from write address channel
	input AWREADY;
	
	// input from read address channel
	input ARREADY;
	
	// input from write data channel
	input WREADY;
	
	// input from read data channel
	input RID, RDATA, RRESP, RLAST, RVALID, RSTRB;
	
	// input from write response channel
	input BID, BVALID, BRESP;
	
endclocking

modport MST_DRV_MP(clocking mst_drv_cb);
modport MST_MON_MP(clocking mst_mon_cb);
modport SLV_DRV_MP(clocking slv_drv_cb);
modport SLV_MON_MP(clocking slv_mon_cb);

endinterface