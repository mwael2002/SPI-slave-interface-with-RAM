package monitor;
import seq_item::*;
import uvm_pkg::*;
`include "uvm_macros.svh"

class spi_monitor extends  uvm_monitor;
	`uvm_component_utils(spi_monitor)
 
 spi_seq_item mon_seq_item;
 virtual SPI_IF mointor_vif;
 virtual SPI_IF mointor_golden_vif;

 uvm_analysis_port #(spi_seq_item) mon_ap;

	function new(string name= "spi_monitor", uvm_component parent=null);
	super.new(name,parent);
    endfunction

function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	mon_ap=new("mon_ap",this);
endfunction 

task run_phase(uvm_phase phase);
	super.run_phase(phase);

forever begin
mon_seq_item=spi_seq_item::type_id::create("mon_seq_item");

	@(negedge mointor_vif.clk);
	
	mon_seq_item.MOSI=mointor_vif.MOSI;
	mon_seq_item.rst_n=mointor_vif.rst_n;
	mon_seq_item.SS_n=mointor_vif.SS_n;
	mon_seq_item.MISO=mointor_vif.MISO;

	mon_seq_item.MISO_golden=mointor_golden_vif.MISO;


    mon_ap.write(mon_seq_item);
    `uvm_info("run_phase",mon_seq_item.convert2string_stimulus(),UVM_HIGH)
end


endtask : run_phase



endclass : spi_monitor

	
endpackage : monitor