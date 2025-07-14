class base_test extends uvm_test;

	`uvm_component_utils(base_test);
	
	environment envh;
	
	env_cfg ecfgh;
	master_cfg mcfgh[];
	slave_cfg scfgh[];
	
	int no_of_master_agents = 1;
	int no_of_slave_agents = 1;
	
	extern function new (string name = "base_test", uvm_component parent);
	extern function void build_phase (uvm_phase phase);
	
endclass

function base_test:: new(string name = "base_test", uvm_component parent);
	super.new(name,parent);
endfunction

function void base_test:: build_phase(uvm_phase phase);
	super.build_phase(phase);
	
	ecfgh = env_cfg::type_id::create("env_cfg");
	
	ecfgh.mcfgh = new[no_of_master_agents];
	mcfgh = new [no_of_master_agents];
	
	foreach(mcfgh[i])
	begin
		
		mcfgh[i] = master_cfg::type_id::create($sformatf("master_cfg[%0d]",i));
		mcfgh[i].is_active = UVM_ACTIVE;
		
		if(! uvm_config_db #(virtual AXI_IF):: get( this,"","AXI_IF",mcfgh[i].vif))
			`uvm_fatal(get_type_name(), " UNABLE TO GET virtual master_if FROM DB");
			
		ecfgh.mcfgh[i] = mcfgh[i];
		
		
		
	end
	
	ecfgh.no_of_master_agents = no_of_master_agents;
	
	ecfgh.scfgh = new[no_of_slave_agents];
	scfgh = new [no_of_slave_agents];
	
	foreach(scfgh[i])
	begin
		
		scfgh[i] = slave_cfg::type_id::create($sformatf("slave_cfg[%0d]",i));
		scfgh[i].is_active = UVM_ACTIVE;
		
	    if(! uvm_config_db #(virtual AXI_IF):: get( this,"","AXI_IF",scfgh[i].vif))
			`uvm_fatal(get_type_name(), " UNABLE TO GET slave_cfg FROM DB");
			
		ecfgh.scfgh[i] = scfgh[i];
		
		
	end
	
	ecfgh.no_of_slave_agents = no_of_slave_agents;
	
	envh = environment::type_id::create("environment",this);
	
	uvm_config_db #(env_cfg):: set(this,"*","env_cfg", ecfgh);
	
endfunction
	
	
		