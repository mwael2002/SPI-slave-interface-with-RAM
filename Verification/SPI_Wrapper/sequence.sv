package seq;
import seq_item::*;
import uvm_pkg::*;
`include "uvm_macros.svh"

class spi_sequence_write extends  uvm_sequence #(spi_seq_item);
	`uvm_object_utils(spi_sequence_write)
     
    spi_seq_item seq_item1;
	function new(string name="spi_sequence_write");
	super.new(name);
    endfunction : new

task body();
	repeat(2500)begin
		seq_item1=spi_seq_item::type_id::create("seq_item1");
		seq_item1.c_data_read.constraint_mode(0);
		start_item(seq_item1);
		assert(seq_item1.randomize());
        finish_item(seq_item1);
	end	
endtask : body	
endclass 

class spi_sequence_read extends  uvm_sequence #(spi_seq_item);
	`uvm_object_utils(spi_sequence_read)
     
    spi_seq_item seq_item;
	function new(string name="spi_sequence_read");
	super.new(name);
    endfunction : new

task body();
	repeat(2500)begin
		seq_item=spi_seq_item::type_id::create("seq_item");
		seq_item.c_data_write.constraint_mode(0);
		start_item(seq_item);
		assert(seq_item.randomize());
        finish_item(seq_item);
	end	
endtask : body	
endclass

endpackage : seq