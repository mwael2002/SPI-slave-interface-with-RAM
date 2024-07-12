package RAM_scoreboard_pkg;

    import uvm_pkg::*;
    import RAM_seq_item_pkg::*;
    `include "uvm_macros.svh"

    class RAM_scoreboard extends uvm_scoreboard;
        `uvm_component_utils(RAM_scoreboard)
        
        uvm_analysis_export #(RAM_seq_item) sb_export;
        uvm_tlm_analysis_fifo #(RAM_seq_item) sb_fifo;
        RAM_seq_item seq_item_sb;
        

        int correct_counter=0,error_counter=0;

        function new(string name="RAM_scoreboard", uvm_component parent = null);

            super.new(name,parent);
        
        endfunction 

        function void build_phase(uvm_phase phase);

            super.build_phase(phase);
            seq_item_sb=RAM_seq_item::type_id::create("seq_item_sb");
            sb_export=new("sb_export",this);
            sb_fifo=new("sb_fifo",this);

        endfunction

        function void connect_phase(uvm_phase phase);
                super.connect_phase(phase);
                sb_export.connect(sb_fifo.analysis_export);

        endfunction


        task run_phase(uvm_phase phase);
            
            super.run_phase(phase);

            forever begin
             
             sb_fifo.get(seq_item_sb);

                if((seq_item_sb.dout_golden)!==(seq_item_sb.dout) || (seq_item_sb.tx_valid_golden) !== (seq_item_sb.tx_valid)) begin
                                
                    $display("At time %0t : din= %0b , rx valid = %0b , dout dut = %0b and dout golden = %0b , tx dut = %0b and tx golden = %0b ",
                    $time,seq_item_sb.din,seq_item_sb.rx_valid,seq_item_sb.dout,seq_item_sb.dout_golden,seq_item_sb.tx_valid_golden,seq_item_sb.tx_valid_golden);
                    error_counter++;
                end 

                else begin
                    correct_counter++;
                end

            end
        endtask

    endclass 
    
endpackage