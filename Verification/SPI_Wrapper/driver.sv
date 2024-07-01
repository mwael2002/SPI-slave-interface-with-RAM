package driver;
import uvm_pkg::*;
import seq_item::*;
`include "uvm_macros.svh"

class spi_driver extends  uvm_driver #(spi_seq_item);
	`uvm_component_utils(spi_driver)
spi_seq_item driver_seq_item;
virtual SPI_IF driver_vif;
virtual SPI_IF driver_golden_vif;

	function new(string name= "spi_driver", uvm_component parent=null);
	 super.new(name,parent);
endfunction

task run_phase(uvm_phase phase);
	super.run_phase(phase);
	forever begin
		driver_seq_item=spi_seq_item::type_id::create("driver_seq_item");
		seq_item_port.get_next_item(driver_seq_item);
		
		driver_vif.rst_n=driver_seq_item.rst_n;
		driver_golden_vif.rst_n=driver_seq_item.rst_n;

		if(driver_seq_item.data_in[10]==0) begin

		driver_vif.SS_n=0;
		driver_golden_vif.SS_n=0;
		@(negedge driver_vif.clk);
		

		for(int i=10;i>=0;i--) begin

        driver_vif.MOSI=driver_seq_item.data_in[i];
        driver_golden_vif.MOSI=driver_seq_item.data_in[i];
        @(negedge driver_vif.clk);

        end
		driver_vif.SS_n=1;
		driver_golden_vif.SS_n=1;
		@(negedge driver_vif.clk);

		end


		else begin

		driver_vif.SS_n=0;
		driver_golden_vif.SS_n=0;
        
		repeat(2)
        @(negedge driver_vif.clk);

        for(int i=10;i>=0;i--) begin

        driver_vif.MOSI=driver_seq_item.data_in[i];
        driver_golden_vif.MOSI=driver_seq_item.data_in[i];
        @(negedge driver_vif.clk);

        end

        if(driver_seq_item.data_in[10:8]==3'b111) begin
        repeat(9) begin
            
            @(negedge driver_vif.clk);         

        end
       end
       
        driver_vif.SS_n=1;
        driver_golden_vif.SS_n=1;
		@(negedge driver_vif.clk);

		end
    
		seq_item_port.item_done();
		`uvm_info("run_phase", driver_seq_item.convert2string_stimulus(),UVM_HIGH)

	end
endtask : run_phase

endclass : spi_driver
	
endpackage : driver
