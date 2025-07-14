class env_cfg extends uvm_object;

	`uvm_object_utils(env_cfg);
	
	bit v_seqrh = 1'b1;
	
	int no_of_master_agents ;
	int no_of_slave_agents ;
	
	master_cfg mcfgh[];
	slave_cfg  scfgh[];
	
	function new(string name = "env_cfg");
		super.new(name);
	endfunction
	
endclass
	
	
	