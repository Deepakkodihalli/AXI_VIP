class slave_agt_top extends uvm_env;

	`uvm_component_utils(slave_agt_top);
	
	slave_agt s_agth[];
	env_cfg ecfgh;
	slave_cfg scfgh[];
	
	function new(string name = "slave_agt_top", uvm_component parent);
		super.new(name,parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		 if(!uvm_config_db#(env_cfg)::get(this, "", "env_cfg", ecfgh)) 
		 begin
			`uvm_fatal(get_type_name(), "UNABLE TO GET env_cfg FROM DB");
			return; // Exit the function if retrieval fails
		end
    
		if (ecfgh.no_of_slave_agents <= 0) begin
			`uvm_warning(get_type_name(), "no_of_slave_agents is 0 or less. Skipping slave agent creation.");
			return; // Exit the function if no agents are specified
		end
	
		s_agth = new[ecfgh.no_of_slave_agents];
		scfgh = new[ecfgh.no_of_slave_agents];
		
		foreach(s_agth[i])
		begin
			scfgh[i] = ecfgh.scfgh[i]; 
			uvm_config_db #(slave_cfg):: set(this,$sformatf("slave_agt[%0d]*",i),"slave_cfg",scfgh[i]);
			
			s_agth[i] = slave_agt::type_id::create($sformatf("slave_agt[%0d]",i),this);
			//scfgh[i] = slave_cfg::type_id::create($sformatf("slave_cfg[%0d]",i));
			
		end
		
	endfunction
	
endclass