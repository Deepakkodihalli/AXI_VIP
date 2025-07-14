class slave_driver extends uvm_driver;

	`uvm_component_utils(slave_driver);
	
	slave_cfg scfgh;
	
	virtual AXI_IF.SLV_DRV_MP vif;
	
	extern function new (string name = "slave_driver", uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
	//extern task run_phase(uvm_phase phase);

endclass

function slave_driver:: new(string name = "slave_driver", uvm_component parent);
	super.new(name,parent);

endfunction

function void slave_driver:: build_phase(uvm_phase phase);
	
	super.build_phase(phase);
	
	if(! uvm_config_db #(slave_cfg):: get(this,"","slave_cfg",scfgh))
			`uvm_fatal(get_type_name(), " UNABLE TO GET slave_cfg FROM DB");

endfunction

function void slave_driver:: connect_phase(uvm_phase phase);

	vif = scfgh.vif;
endfunction

