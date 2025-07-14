class master_cfg extends uvm_object;
	
	`uvm_object_utils(master_cfg);
	
	bit is_active = UVM_ACTIVE;
 
  virtual AXI_IF  vif;
	
	function new(string name = "master_cfg");
		super.new(name);
	endfunction
	
endclass