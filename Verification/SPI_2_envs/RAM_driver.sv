package RAM_driver_pkg;
    
   import uvm_pkg::*;
   import RAM_seq_item_pkg::*;
   `include "uvm_macros.svh"

   class RAM_driver extends uvm_driver#(RAM_seq_item);
    
    `uvm_component_utils(RAM_driver)

    RAM_seq_item stim_seq_item;
    virtual RAM_intf RAM_driver_vif;
   virtual RAM_intf RAM_driver_golden_vif;

    function new(string name="RAM_driver", uvm_component parent = null);
        super.new(name,parent);
    endfunction  

   task run_phase(uvm_phase phase);
    super.run_phase(phase);

     forever begin
        stim_seq_item=RAM_seq_item::type_id::create("stim_seq_item");
        seq_item_port.get_next_item(stim_seq_item);

         RAM_driver_vif.din=stim_seq_item.din;
         RAM_driver_vif.rst_n=stim_seq_item.rst_n;
         RAM_driver_vif.rx_valid=stim_seq_item.rx_valid;
         RAM_driver_golden_vif.din=stim_seq_item.din;
         RAM_driver_golden_vif.rst_n=stim_seq_item.rst_n;
         RAM_driver_golden_vif.rx_valid=stim_seq_item.rx_valid;

        @(negedge RAM_driver_vif.clk);
        seq_item_port.item_done(stim_seq_item);

     end

   endtask 
   
   
   endclass

endpackage

// Code your testbench here
// or browse Examples
module a;
  integer a,b,c;
  initial begin
    
    a=55; b=10; c=5;
    
  end
  
  initial begin
    
     
    a<= #10 b*c;
    b<= #11 a-25; 
    c<= #9 a+ b;

    #31; 
    $display("%d",c);
    $stop;
  end
  
endmodule