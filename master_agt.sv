class master_agt extends uvm_agent;

	`uvm_component_utils(master_agt);
	
	master_driver mdrv;
	master_seqr mseqr;
	master_monitor mmon;
	
	master_cfg mcfgh;
	
	extern function new (string name = "master_agt", uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	
endclass

function master_agt:: new (string name = "master_agt", uvm_component parent);
		super.new(name,parent);
endfunction

function void master_agt:: build_phase(uvm_phase phase);

	super.build_phase(phase);
	
		if(! uvm_config_db #(master_cfg):: get(this,"","master_cfg",mcfgh))
			`uvm_fatal(get_type_name(), " UNABLE TO GET master_cfg FROM DB");
			
		mmon = master_monitor::type_id::create("master_monitor",this);
		
		if(mcfgh.is_active)
		begin
			mdrv = master_driver::type_id::create("master_driver",this);
			mseqr = master_seqr::type_id::create("master_seqr",this);
		end
		
endfunction
