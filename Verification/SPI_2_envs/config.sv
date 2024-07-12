package myconfig;
import uvm_pkg::*;
`include "uvm_macros.svh"

typedef enum bit {UVM_AGENT_PASSIVE,UVM_AGENT_ACTIVE} AGENT_STATE;

class spi_config extends  uvm_object;
	`uvm_object_utils(spi_config)

	function  new(string name="spi_config");
		super.new(name);
	endfunction 

virtual SPI_IF spi_config_vif;
virtual SPI_IF spi_golden_config_vif;

virtual RAM_intf ram_config_vif;
virtual RAM_intf ram_golden_config_vif;

AGENT_STATE ag_s;
	
endclass : spi_config
endpackage : myconfig