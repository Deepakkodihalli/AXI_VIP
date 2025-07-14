class master_driver extends uvm_driver;

	`uvm_component_utils(master_driver);
	
	master_cfg mcfgh;
	
	virtual AXI_IF.MST_DRV_MP vif;
	
	extern function new (string name = "master_driver", uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
	//extern task run_phase(uvm_phase phase);

endclass

function master_driver:: new(string name = "master_driver", uvm_component parent);
	super.new(name,parent);

endfunction

function void master_driver:: build_phase(uvm_phase phase);
	
	super.build_phase(phase);
	
	if(! uvm_config_db #(master_cfg):: get(this,"","master_cfg",mcfgh))
			`uvm_fatal(get_type_name(), " UNABLE TO GET master_cfg FROM DB");

endfunction

function void master_driver:: connect_phase(uvm_phase phase);

	vif = mcfgh.vif;
endfunction

