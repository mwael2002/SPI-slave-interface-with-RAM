package myconfig;
import uvm_pkg::*;
`include "uvm_macros.svh"

class spi_config extends  uvm_object;
	`uvm_object_utils(spi_config)

	function  new(string name="spi_config");
		super.new(name);
	endfunction 

virtual SPI_IF spi_config_vif;
virtual SPI_IF spi_golden_config_vif;

	
endclass : spi_config
endpackage : myconfig