package RAM_seq_item_pkg;

   import uvm_pkg::*;
   `include "uvm_macros.svh"

   class RAM_seq_item  extends uvm_sequence_item ;
    
    `uvm_object_utils(RAM_seq_item);

        randc logic [9:0] din;
        rand logic rx_valid,rst_n;
        logic [7:0] dout,dout_golden;
        logic tx_valid,tx_valid_golden;


    function new(string name = "RAM_seq_item");
        
         super.new(name);

    endfunction 

        constraint c_rst_n{ rst_n dist{0:=5,1:=95};  };
        constraint c_rx_valid { rx_valid dist{1:=30,0:=70};  }

    endclass 

endpackage