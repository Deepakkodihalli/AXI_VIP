class environment extends uvm_env;

	`uvm_component_utils(environment);
	
	master_agt_top m_agt_top;
	slave_agt_top  s_agt_top;
	
	env_cfg ecfgh;
	//score_board sbh;
	
	//vr_seqr v_seqrh;
	
	extern function new (string name = "environment", uvm_component parent);
	extern function void build_phase (uvm_phase phase);
//	extends function void connect_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
	
endclass

function environment:: new(string name = "environment", uvm_component parent);
	super.new(name,parent);
	
endfunction

function void environment:: build_phase(uvm_phase phase);
	super.build_phase(phase);
	
	if(! uvm_config_db #(env_cfg):: get(this,"", "env_cfg",ecfgh))
		`uvm_fatal(get_type_name(),"UNABLE TO GET env_cfg FROM DB");
	
	//foreach(ecfgh.no_of_master_agents[i])
	//uvm_config_db #(master_cfg):: set(this,"*", $sformatf("master_cfg[%0d]",i),ecfgh.mcfgh[i]);
	
	m_agt_top = master_agt_top::type_id::create("m_agt_top",this);
	
	
	//uvm_config_db #(slave_cfg):: set(this,"", "slave_cfg",ecfgh.scfgh);
	
	s_agt_top = slave_agt_top::type_id::create("s_agt_top",this);
	
	//if(ecfgh.v_seqrh)
		//v_seqrh = vr_seqr::type_id::create("vr_seqr",this);
		
endfunction
	
task environment:: run_phase(uvm_phase phase);

	uvm_top.print_topology();
	
endtask