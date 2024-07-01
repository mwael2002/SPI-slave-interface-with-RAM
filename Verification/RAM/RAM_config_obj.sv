package RAM_config_obj_pkg;
    
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    class RAM_config_obj extends uvm_object;
        `uvm_object_utils(RAM_config_obj)

        virtual RAM_intf RAM_config_vif;
        virtual RAM_intf RAM_config_golden_vif;

        function new(string name="RAM_config_obj");
            
            super.new(name);

        endfunction 
    endclass 

endpackage