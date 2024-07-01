import RAM_pkg ::*;

module RAM_tb;
    
    logic [9:0] din;
    logic clk,rst_n,rx_valid,tx_valid_dut,tx_valid_golden;
    logic [7:0] dout_dut,dout_golden;

    int correct_count,error_count;

    RAM_class #(.WIDTH(10))RAM_cl;

    spi_ram #(.ADDR_SIZE(8),.MEM_DEPTH(256)) DUT(din,rx_valid,tx_valid_dut,dout_dut,clk,rst_n);
    RAM_golden #(.ADDR_SIZE(8),.MEM_DEPTH(256)) Golden(din,clk,rst_n,rx_valid,dout_golden,tx_valid_golden);

    bind spi_ram RAM_assertions #(.ADDR_SIZE(8),.MEM_DEPTH(256))RAM_SVA(.din(din),.rx_valid(rx_valid),.tx_valid(tx_valid),.dout(dout),
    .clk(clk),.rst_n(rst_n));

    initial begin
        
         clk=0;

         forever begin
            #6 clk=~clk;
         end

    end

    initial begin
        
        RAM_cl=new();
        RAM_cl.cvr_grp_ram.start();

        repeat(10000) begin
            
            assert (RAM_cl.randomize()) else $stop;
            rst_n=RAM_cl.rst_n;
            rx_valid=RAM_cl.rx_valid;
            din=RAM_cl.din;
            @(negedge clk);
            RAM_cl.cvr_grp_ram.sample();
            check_res();

        end

   

    $display("At the end correct counter =%0d and error counter = %0d",correct_count,error_count);

    $stop;
    end


    task check_res;
        
         if((dout_dut!==dout_golden)||(tx_valid_dut!==tx_valid_golden)) begin
         $display("At time %0t : din= %0b , rx valid = %0b , dout dut = %0b and dout golden = %0b , tx dut = %0b and tx golden = %0b ",
         $time,din,rx_valid,dout_dut,dout_golden,tx_valid_golden,tx_valid_golden);
         $stop;
         error_count++;
         end

         else
         correct_count++;

    endtask 


endmodule