package agent;
import seq_item::*;
import sequencer::*;
import monitor::*;
import driver::*;
import myconfig::*;
import uvm_pkg::*;
`include "uvm_macros.svh"

class spi_agent extends  uvm_agent;
	`uvm_component_utils(spi_agent)
   spi_monitor mon;
   spi_driver drv;
   spi_config config1;
   spi_sequencer sqr;
   uvm_analysis_port #(spi_seq_item) agt_ap;

	function new(string name= "spi_agent", uvm_component parent=null);
	 super.new(name,parent);
endfunction
	
function void build_phase(uvm_phase phase);
	super.build_phase(phase);
    if(!uvm_config_db#(spi_config)::get(this, "", "INTERFACE",config1 ))
      `uvm_fatal("build_phase","unable to get config1 object")

   mon=spi_monitor::type_id::create("mon",this);
   drv=spi_driver::type_id::create("drv",this);
   sqr=spi_sequencer::type_id::create("sqr",this);
   agt_ap=new("agt_ap",this);
endfunction 

function void connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	mon.mointor_vif=config1.spi_config_vif;
	drv.driver_vif=config1.spi_config_vif;

	mon.mointor_golden_vif=config1.spi_golden_config_vif;
	drv.driver_golden_vif=config1.spi_golden_config_vif;

	drv.seq_item_port.connect(sqr.seq_item_export);
	mon.mon_ap.connect(agt_ap);
	
endfunction 

endclass : spi_agent
	
endpackage : agent