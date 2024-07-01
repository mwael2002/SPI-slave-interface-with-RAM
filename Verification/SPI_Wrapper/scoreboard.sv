package scoreboard;
import seq_item::*;
import uvm_pkg::*;
`include "uvm_macros.svh"

class spi_scoreboard extends  uvm_scoreboard;
	`uvm_component_utils(spi_scoreboard)
    spi_seq_item seq_item1;

    uvm_analysis_export #(spi_seq_item) sb_export;
    uvm_tlm_analysis_fifo #(spi_seq_item) sb_fifo;

    int error_count=0; int correct_count=0;

    function  new(string name="spi_scoreboard",uvm_component parent=null);
		super.new(name,parent);
	endfunction : new
	
    function void build_phase(uvm_phase phase);
    	super.build_phase(phase);
    	seq_item1=spi_seq_item::type_id::create("seq_item1");
    	sb_export=new("sb_export",this);
    	sb_fifo=new("sb_fifo",this);
    endfunction 


    function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		sb_export.connect(sb_fifo.analysis_export);
	endfunction 

	task run_phase(uvm_phase phase);
		super.run_phase(phase);

		forever begin
			sb_fifo.get(seq_item1);
			if(seq_item1.MISO != seq_item1.MISO_golden)begin
				`uvm_error("run_phase",$sformatf("comparison failed,Transaction received by the Dut:%s while the refernce out:0b%b",seq_item1.convert2string_stimulus(), seq_item1.MISO_golden));
		         error_count++;
	             end
             else begin
	         `uvm_info("run_phase",$sformatf("correct spi out:%s", seq_item1.convert2string_stimulus()),UVM_HIGH);
	           correct_count++;
               end
			end
		
		
	endtask : run_phase

endclass : spi_scoreboard
	
endpackage : scoreboard