package RAM_agent_pkg;
    
    import uvm_pkg::*;
    import RAM_sequencer_pkg::*;
    import RAM_driver_pkg::*;
    import RAM_monitor_pkg::*;
    import myconfig::*;
    import RAM_seq_item_pkg::*;
    `include "uvm_macros.svh"


    class RAM_agent extends uvm_agent;
        `uvm_component_utils(RAM_agent)
        
        RAM_sequencer sqr;
        spi_config RAM_agent_config_obj;
        RAM_driver drv;
        RAM_monitor mon;
        uvm_analysis_port #(RAM_seq_item) agent_port;
        
        function new(string name="RAM_agent", uvm_component parent = null);
            
            super.new(name,parent);

        endfunction 

        function void build_phase (uvm_phase phase);
            
               super.build_phase(phase);

               agent_port=new("agent_port",this);

               RAM_agent_config_obj=spi_config::type_id::create("RAM_agent_config",this);

               if(!uvm_config_db #(spi_config):: get(this,"","RAM_config_obj",RAM_agent_config_obj))
               `uvm_fatal("build_phase","agent cannot get config obj")

               mon=RAM_monitor::type_id::create("mon",this);

               if(RAM_agent_config_obj.ag_s==UVM_AGENT_ACTIVE)begin
               sqr=RAM_sequencer::type_id::create("sqr",this); 
               drv=RAM_driver::type_id::create("drv",this);
               end

        endfunction

       function void connect_phase(uvm_phase phase);
              
               super.connect_phase(phase);
               
               if(RAM_agent_config_obj.ag_s==UVM_AGENT_ACTIVE) begin
               drv.RAM_driver_vif=RAM_agent_config_obj.ram_config_vif;
               drv.RAM_driver_golden_vif=RAM_agent_config_obj.ram_golden_config_vif;
               drv.seq_item_port.connect(sqr.seq_item_export);
               end

               mon.RAM_monitor_vif=RAM_agent_config_obj.ram_config_vif;
               mon.RAM_monitor_golden_vif=RAM_agent_config_obj.ram_golden_config_vif;               
               
               mon.mon_port.connect(agent_port);
                
       endfunction

    endclass 


endpackage