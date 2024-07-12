package spi_test1;
import env::*;
import myconfig::*;
import seq::*;
import uvm_pkg::*;
import RAM_env_pkg::*;
`include "uvm_macros.svh"

class spi_test extends  uvm_test;
	`uvm_component_utils(spi_test)
	spi_config  spi_config_obj;
	spi_config ram_config_obj;
	spi_env myenv;
	RAM_env ram_env;

	spi_sequence_write seq_write;
    spi_sequence_read seq_read;

	function new(string name="spi_test",uvm_component parent=null);
	  super.new(name,parent);
     endfunction 
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		spi_config_obj=spi_config::type_id::create(" spi_config_obj");
		ram_config_obj=spi_config::type_id::create(" ram_config_obj");

		myenv=spi_env::type_id::create("myenv",this);
		ram_env=RAM_env::type_id::create("ram_env",this);

		seq_write=spi_sequence_write::type_id::create("seq_write");
		seq_read=spi_sequence_read::type_id::create("seq_read");

		 if(!uvm_config_db#(virtual RAM_intf)::get(this, "", "RAM_interface_DUT",  ram_config_obj.ram_config_vif ))
			`uvm_fatal("build_phase","TEST - unable to get RAM DUT VF from the uvm_config_db")


		if(!uvm_config_db#(virtual RAM_intf)::get(this, "", "RAM_interface_golden",  ram_config_obj.ram_golden_config_vif))
			`uvm_fatal("build_phase","TEST - unable to get RAM golden VF from the uvm_config_db")

		ram_config_obj.ag_s=UVM_AGENT_PASSIVE;

		uvm_config_db#(spi_config)::set(this, "*", "RAM_config_obj", ram_config_obj);




		if(!uvm_config_db#(virtual SPI_IF)::get(this, "", "SPI_interface_DUT",  spi_config_obj.spi_config_vif ))
			`uvm_fatal("build_phase","TEST - unable to get SPI VF from the uvm_config_db")


		if(!uvm_config_db#(virtual SPI_IF)::get(this, "", "SPI_interface_golden",  spi_config_obj.spi_golden_config_vif))
			`uvm_fatal("build_phase","TEST - unable to get SPI Golden VF from the uvm_config_db")

		spi_config_obj.ag_s=UVM_AGENT_ACTIVE;

		uvm_config_db#(spi_config)::set(this, "*", "SPI_config_obj", spi_config_obj);

		

	endfunction 


   task run_phase(uvm_phase phase);
   	super.run_phase(phase);
   	phase.raise_objection(this);
   	`uvm_info("run_phase","writing Started",UVM_LOW);
   	seq_write.start(myenv.agt.sqr);
   	`uvm_info("run_phase","reading Started",UVM_LOW);
    seq_read.start(myenv.agt.sqr);
	`uvm_info("run_phase","reading Finished",UVM_LOW);
   	phase.drop_objection(this);

   	
   endtask : run_phase
endclass : spi_test


endpackage : spi_test1