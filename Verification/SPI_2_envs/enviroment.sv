package env;
import coverage::*;
import agent::*;
import scoreboard::*;
import uvm_pkg::*;
`include "uvm_macros.svh"

class spi_env extends uvm_env;
	`uvm_component_utils(spi_env)

	spi_scoreboard sb;
	spi_coverage cov;
	spi_agent agt;

	function new(string name= "spi_env", uvm_component parent=null);
	 super.new(name,parent);
       endfunction

     function void build_phase(uvm_phase phase);
     	super.build_phase(phase);
     	sb=spi_scoreboard::type_id::create("sb",this);
     	cov=spi_coverage::type_id::create("cov",this);
     	agt=spi_agent::type_id::create("agt",this);
     	
     endfunction


	function void connect_phase(uvm_phase phase);
     	super.connect_phase(phase);
     	agt.agt_ap.connect(sb.sb_export);
     	agt.agt_ap.connect(cov.cov_export);
     endfunction
     	


endclass : spi_env



endpackage : env