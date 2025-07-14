class master_agt_top extends uvm_env;

	`uvm_component_utils(master_agt_top);
	
	master_agt magth[];
	env_cfg ecfgh;
	master_cfg mcfgh[];
	
	function new(string name = "master_agt_top", uvm_component parent);
		super.new(name,parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		 if(!uvm_config_db#(env_cfg)::get(this, "", "env_cfg", ecfgh)) 
		 begin
			`uvm_fatal(get_type_name(), "UNABLE TO GET env_cfg FROM DB");
			return; // Exit the function if retrieval fails
		end
    
		if (ecfgh.no_of_master_agents <= 0) begin
			`uvm_warning(get_type_name(), "no_of_master_agents is 0 or less. Skipping master agent creation.");
			return; // Exit the function if no agents are specified
		end
	
		magth = new[ecfgh.no_of_master_agents];
		mcfgh = new[ecfgh.no_of_master_agents];
		
		foreach(magth[i])
		begin
			mcfgh[i] = ecfgh.mcfgh[i]; 
			uvm_config_db #(master_cfg):: set(this,$sformatf("master_agt[%0d]*",i),"master_cfg",mcfgh[i]);
			
			magth[i] = master_agt::type_id::create($sformatf("master_agt[%0d]",i),this);
			//mcfgh[i] = master_cfg::type_id::create($sformatf("master_cfg[%0d]",i));
			
		end
		
	endfunction
	
endclass