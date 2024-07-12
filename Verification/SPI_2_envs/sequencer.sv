package sequencer;
import seq_item::*;
import uvm_pkg::*;
`include "uvm_macros.svh"
	class spi_sequencer extends uvm_sequencer #(spi_seq_item);
	`uvm_component_utils(spi_sequencer)
	function  new(string name="spi_sequencer",uvm_component parent=null);
		super.new(name,parent);
	endfunction : new
endclass 
endpackage : sequencer