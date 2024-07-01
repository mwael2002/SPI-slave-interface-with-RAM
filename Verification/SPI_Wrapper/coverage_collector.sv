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

            c_din: coverpoint cov_seq_item.data_in{

            bins address_write_max={11'b000_1111_1111};
            bins address_read_max = {11'b110_1111_1111};
            bins address_write_min={11'b000_0000_0000};
            bins address_read_min = {11'b110_0000_0000};
           ignore_bins not_address[] = {[11'b000_0000_0001:11'b000_1111_1110],[11'b110_0000_0001:11'b110_1111_1110]};
        
        
        }

        c_rst_n:coverpoint cov_seq_item.rst_n;

           cross_write: cross c_din,c_rst_n{

           bins write_max_and_rx_valid = binsof(c_rst_n) intersect{1} && binsof(c_din.address_write_max);
           bins read_max_and_rx_valid = binsof(c_rst_n) intersect{1} && binsof(c_din.address_read_max);
           bins write_min_and_rx_valid = binsof(c_rst_n) intersect{1} && binsof(c_din.address_write_min);
           bins read_min_and_rx_valid = binsof(c_rst_n) intersect{1} && binsof(c_din.address_read_min);

           ignore_bins not_rst = binsof(c_rst_n) intersect{0};

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
	        forever begin
	        	cov_fifo.get(cov_seq_item);
                
                #16;
                if(cov_seq_item.data_in[10]==1)
                #16;

                #2;

	        	cvr_grp_spi.sample();
	        end
	    endtask : run_phase

	
endclass : spi_coverage
	
endpackage : coverage