package seq_item;
import uvm_pkg::*;
`include "uvm_macros.svh"

class spi_seq_item extends  uvm_sequence_item;
	`uvm_object_utils(spi_seq_item)
   rand logic rst_n;
    logic [2:0] dut_state;
    randc static bit [10:0] data_in;
   logic MISO,MISO_golden;
   static bit past_data_in;
   logic SS_n,MOSI;

	function new(string name="spi_seq_item");
	super.new(name);
    endfunction : new


    function string convert2string_stimulus();
    	return $sformatf("MOSI=0b%0b ,rst_n=0b%0b ,SS_n=0b%0b ,dut_state=0b%0b",MOSI, rst_n, SS_n, dut_state);
    	
    endfunction


    constraint c_rst_n{ rst_n dist{0:=3,1:=97}; };

        constraint c_data_write{

        if(past_data_in==0)
        data_in[8]==1;
        
        if(past_data_in==1)
        data_in[8]==0;

        data_in[10]==0;
        data_in[9]==0;

        }

        constraint c_data_read{

        if(past_data_in==0)
        data_in[8]==1;
        
        if(past_data_in==1)
        data_in[8]==0;

        data_in[10]==1;
        data_in[9]==1;

        }

        function void post_randomize;
            
        past_data_in=data_in[8];
            
        endfunction 

	
endclass : spi_seq_item
	
endpackage : seq_item