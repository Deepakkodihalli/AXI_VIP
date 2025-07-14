class slave_agt extends uvm_agent;

	`uvm_component_utils(slave_agt);
	
	slave_driver s_drv;
	slave_seqr s_seqr;
	slave_monitor s_mon;
	
	slave_cfg scfgh;
	
	extern function new (string name = "slave_agt", uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	
endclass

function slave_agt:: new (string name = "slave_agt", uvm_component parent);
		super.new(name,parent);
endfunction

function void slave_agt:: build_phase(uvm_phase phase);

	super.build_phase(phase);
	
		if(! uvm_config_db #(slave_cfg):: get(this,"","slave_cfg",scfgh))
			`uvm_fatal(get_type_name(), " UNABLE TO GET slave_cfg FROM DB");
			
		s_mon = slave_monitor::type_id::create("slave_monitor",this);
		
		if(scfgh.is_active)
		begin
			s_drv = slave_driver::type_id::create("slave_driver",this);
			s_seqr = slave_seqr::type_id::create("slave_seqr",this);
		end
		
endfunction
