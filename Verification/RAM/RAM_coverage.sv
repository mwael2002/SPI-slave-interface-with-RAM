package RAM_coverage_pkg;

    import uvm_pkg::*;
    import RAM_seq_item_pkg::*;
    `include "uvm_macros.svh"
    
    class RAM_coverage extends uvm_component;
          `uvm_component_utils(RAM_coverage)  
        
        uvm_analysis_export #(RAM_seq_item) cov_export;
        uvm_tlm_analysis_fifo #(RAM_seq_item) cov_fifo;
        RAM_seq_item seq_item_cov;
        
        covergroup cvr_grp_ram;

        c_rx_valid: coverpoint seq_item_cov.rx_valid;
        c_rst_n: coverpoint seq_item_cov.rst_n;
        
        c_din_write: coverpoint seq_item_cov.din iff(seq_item_cov.rst_n && seq_item_cov.rx_valid){
            option.auto_bin_max=8'b1111_1111;
             bins write_addresses[]={[10'b00_0000_0000:10'b00_1111_1111]};

        }

        c_din_read: coverpoint seq_item_cov.din iff(seq_item_cov.rst_n && seq_item_cov.rx_valid){
            option.auto_bin_max=8'b1111_1111;
             bins read_addresses[]={[10'b10_0000_0000:10'b10_1111_1111]};

        }

        endgroup 
        

        function  new(string name="RAM_coverage",uvm_component parent=null);
		
                  super.new(name,parent);
                  cvr_grp_ram=new();

        endfunction 
    
        function void build_phase(uvm_phase phase);
            
                super.build_phase(phase);
                cov_fifo=new("cov_fifo",this);
	            cov_export=new("cov_export",this);

        endfunction

        function void connect_phase(uvm_phase phase);
            
                cov_export.connect(cov_fifo.analysis_export);

        endfunction
        
        task run_phase(uvm_phase phase);
	
            super.run_phase(phase);
	        
            forever begin
		            cov_fifo.get(seq_item_cov);
		            cvr_grp_ram.sample();
	        end
	
         endtask

    endclass 

endpackage