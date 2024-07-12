package seq_item;
import uvm_pkg::*;
`include "uvm_macros.svh"

class spi_seq_item extends  uvm_sequence_item;
	`uvm_object_utils(spi_seq_item)
    
    rand logic rst_n;
    logic [2:0] dut_state;
    rand static bit [10:0] data_in;
    randc static bit [7:0] payload;
    rand bit [2:0] control;
    static bit past_control;
    logic MISO,MISO_golden;
    logic SS_n,MOSI;

	function new(string name="spi_seq_item");
	super.new(name);
    endfunction : new


    function string convert2string_stimulus();
    	return $sformatf("MOSI=0b%0b ,rst_n=0b%0b ,SS_n=0b%0b ,dut_state=0b%0b",MOSI, rst_n, SS_n, dut_state);
    	
    endfunction


    constraint c_rst_n{ rst_n dist{0:=3,1:=97}; };

    constraint c_data_in{data_in=={control,payload};  }

    constraint c_data_write{
        
        control[2]==0;
        control[1]==0;

    }
        
    constraint c_data_read{

        control[2]==1;
        control[1]==1;

    }

    constraint c_r_w_rst{

        if(rst_n){
            
            if(past_control==0){
                control[0]==1;
            }
            if(past_control==1){
                control[0]==0;
            }
        }

        else if(!rst_n){
            control[0]==1;
        }


    }

    function void post_randomize;
            
    past_control=control[0];
            
    endfunction 
	
endclass : spi_seq_item
	
endpackage : seq_item