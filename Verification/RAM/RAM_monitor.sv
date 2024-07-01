package RAM_monitor_pkg;
    
    import uvm_pkg::*;
    import RAM_seq_item_pkg::*;
    `include "uvm_macros.svh"

    class RAM_monitor extends uvm_monitor;
        `uvm_component_utils(RAM_monitor)

        virtual RAM_intf RAM_monitor_vif;
        virtual RAM_intf RAM_monitor_golden_vif;

        RAM_seq_item mon_seq_item;
        uvm_analysis_port #(RAM_seq_item) mon_port;

        function new(string name="RAM_monitor", uvm_component parent = null);

                super.new(name,parent);

        endfunction 

        function void build_phase(uvm_phase phase);
            
                super.build_phase(phase);
                mon_port=new("mon_port",this);

        endfunction

        task run_phase(uvm_phase phase);
            
                forever begin
                    
                    mon_seq_item=RAM_seq_item::type_id::create("mon_seq_item");
                    @(negedge RAM_monitor_vif.clk);
                    
                    mon_seq_item.din=RAM_monitor_vif.din;
                    mon_seq_item.rst_n=RAM_monitor_vif.rst_n;
                    mon_seq_item.rx_valid=RAM_monitor_vif.rx_valid;
                    mon_seq_item.dout=RAM_monitor_vif.dout;
                    mon_seq_item.tx_valid=RAM_monitor_vif.tx_valid;

                    mon_seq_item.dout_golden=RAM_monitor_golden_vif.dout;
                    mon_seq_item.tx_valid_golden=RAM_monitor_golden_vif.tx_valid;

                    mon_port.write(mon_seq_item);

                end


        endtask

    endclass 

endpackage