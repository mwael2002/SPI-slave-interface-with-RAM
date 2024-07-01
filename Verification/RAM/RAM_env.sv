package RAM_env_pkg;
    
    import uvm_pkg::*;
    import RAM_agent_pkg::*;
    import RAM_scoreboard_pkg::*;
    import RAM_coverage_pkg::*;
    `include "uvm_macros.svh"

    class RAM_env extends uvm_env;
        
        `uvm_component_utils(RAM_env)
        
        RAM_agent ag;
        RAM_scoreboard sb;
        RAM_coverage cov;

        function new(string name="RAM_agent", uvm_component parent = null);
            super.new(name,parent);
        endfunction 
    
        function void build_phase(uvm_phase phase);
            
            super.build_phase(phase);

            ag=RAM_agent::type_id::create("ag",this);
            sb=RAM_scoreboard::type_id::create("sb",this);
            cov=RAM_coverage::type_id::create("cov",this);

        endfunction

        function void connect_phase(uvm_phase phase);
            super.connect_phase(phase);
            ag.agent_port.connect(sb.sb_export);
            ag.agent_port.connect(cov.cov_export);
        
        endfunction

    endclass  


endpackage