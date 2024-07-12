package coverage;
import seq_item::*;
import uvm_pkg::*;
`include "uvm_macros.svh"

class spi_coverage extends  uvm_component;
	`uvm_component_utils(spi_coverage)
    spi_seq_item cov_seq_item;
    uvm_analysis_export #(spi_seq_item) cov_export;
    uvm_tlm_analysis_fifo #(spi_seq_item) cov_fifo;

    covergroup cvr_grp_spi;

            c_din: coverpoint cov_seq_item.data_in iff(cov_seq_item.rst_n){

            bins address_write_max={11'b000_1111_1111};
            bins address_read_max = {11'b110_1111_1111};
            bins address_write_min={11'b000_0000_0000};
            bins address_read_min = {11'b110_0000_0000};
           ignore_bins not_address[] = {[11'b000_0000_0001:11'b000_1111_1110],[11'b110_0000_0001:11'b110_1111_1110]};
        
        
        }

        endgroup


        function new(string name="spi_coverage",uvm_component parent=null);
        	super.new(name,parent);
        	cvr_grp_spi=new();
        endfunction 


        function void connect_phase(uvm_phase phase);
        	super.connect_phase(phase);
            cov_export.connect(cov_fifo.analysis_export);

        	endfunction

        function void build_phase(uvm_phase phase);
        	super.build_phase(phase);
        	cov_export=new("cov_export",this);
        	cov_fifo=new("cov_fifo",this);
        endfunction

        task run_phase(uvm_phase phase);
	        super.run_phase(phase);
            `uvm_info("run_phase","coverage run phase has started",UVM_LOW);
	        forever begin
	        	cov_fifo.get(cov_seq_item);

	        	cvr_grp_spi.sample();
	        end
	    endtask : run_phase

	
endclass : spi_coverage
	
endpackage : coverage