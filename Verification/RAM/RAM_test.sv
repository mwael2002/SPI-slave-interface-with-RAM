package RAM_test_pkg;
    
    import uvm_pkg::*;
    import RAM_seq_pkg::*;
    import RAM_env_pkg::*;
    import RAM_config_obj_pkg::*;
    `include "uvm_macros.svh"

    class RAM_test extends uvm_test;
        
        `uvm_component_utils(RAM_test)

        RAM_env env;
        RAM_config_obj test_config_obj;
        RAM_seq seq;

        
        function new(string name="RAM_test", uvm_component parent = null);
            
                super.new(name,parent);

        endfunction 

        function void build_phase(uvm_phase phase);
            
                super.build_phase(phase);

                 env=RAM_env::type_id::create("env",this);
                 seq=RAM_seq::type_id::create("seq",this);
                 test_config_obj=RAM_config_obj::type_id::create("test_config",this);

                if(!uvm_config_db #(virtual RAM_intf):: get(this,"","RAM_INTF",test_config_obj.RAM_config_vif))
               `uvm_fatal("build_phase","test cannot get virtual DUT interface")

                if(!uvm_config_db #(virtual RAM_intf):: get(this,"","RAM_GOLD_INTF",test_config_obj.RAM_config_golden_vif))
               `uvm_fatal("build_phase","test cannot get virtual Golden interface")

                uvm_config_db #(RAM_config_obj):: set(this,"*","RAM_CFG",test_config_obj);

        endfunction

        task run_phase(uvm_phase phase);
            
            super.run_phase(phase);

            phase.raise_objection(this);
            seq.start(env.ag.sqr);
            phase.drop_objection(this);

        endtask


    endclass 


endpackage