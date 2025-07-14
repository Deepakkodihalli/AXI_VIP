class slave_monitor extends uvm_monitor;

	`uvm_component_utils(slave_monitor);
	
	slave_cfg scfgh;
	
	virtual AXI_IF.SLV_MON_MP vif;
	
	extern function new (string name = "slave_monitor", uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
	//extern task run_phase(uvm_phase phase);

endclass

function slave_monitor:: new(string name = "slave_monitor", uvm_component parent);
	super.new(name,parent);

endfunction

function void slave_monitor:: build_phase(uvm_phase phase);
	
	super.build_phase(phase);
	
	if(! uvm_config_db #(slave_cfg):: get(this,"","slave_cfg",scfgh))
			`uvm_fatal(get_type_name(), " UNABLE TO GET slave_cfg FROM DB");

endfunction

function void slave_monitor:: connect_phase(uvm_phase phase);

	vif = scfgh.vif;
endfunction