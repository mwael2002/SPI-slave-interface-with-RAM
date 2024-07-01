package spi_test1;
import env::*;
import myconfig::*;
import seq::*;
import uvm_pkg::*;
`include "uvm_macros.svh"

class spi_test extends  uvm_test;
	`uvm_component_utils(spi_test)
	spi_config obj;
	spi_env myenv;
	spi_sequence_write seq_write;
    spi_sequence_read seq_read;

	function new(string name="spi_test",uvm_component parent=null);
	  super.new(name,parent);
     endfunction 
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		obj=spi_config::type_id::create("obj");
		myenv=spi_env::type_id::create("myenv",this);
		seq_write=spi_sequence_write::type_id::create("seq_write");
		seq_read=spi_sequence_read::type_id::create("seq_read");

		if(!uvm_config_db#(virtual SPI_IF)::get(this, "", "interface", obj.spi_config_vif ))
			`uvm_fatal("build_phase","TEST - unable to get the VF from the uvm_config_db")

		uvm_config_db#(spi_config)::set(this, "*", "INTERFACE",obj);


		if(!uvm_config_db#(virtual SPI_IF)::get(this, "", "gold", obj.spi_golden_config_vif))
			`uvm_fatal("build_phase","TEST - unable to get the VF from the uvm_config_db")

		uvm_config_db#(spi_config)::set(this, "*", "gold",obj);


		
	endfunction 


   task run_phase(uvm_phase phase);
   	super.run_phase(phase);
   	phase.raise_objection(this);
   	`uvm_info("run_phase","writing Started",UVM_LOW);
   	seq_write.start(myenv.agt.sqr);
   	`uvm_info("run_phase","reading Started",UVM_LOW);
    seq_read.start(myenv.agt.sqr);
   	phase.drop_objection(this);

   	
   endtask : run_phase
endclass : spi_test


endpackage : spi_test1