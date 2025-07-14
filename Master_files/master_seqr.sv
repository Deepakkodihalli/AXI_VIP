class master_seqr extends uvm_sequencer;

	`uvm_component_utils(master_seqr);
	
	function new(string name = "master_seqr", uvm_component parent);
	
		super.new(name,parent);

    endfunction

endclass