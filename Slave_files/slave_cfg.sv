class slave_cfg extends uvm_object;
	
	`uvm_object_utils(slave_cfg);
	
	bit is_active = UVM_ACTIVE;
	
	 virtual AXI_IF vif;
	
	function new(string name = "slave_cfg");
		super.new(name);
	endfunction
	
endclass