import uvm_pkg::*;
import RAM_test_pkg::*;

module Top_module ();
    
      bit clk;

      initial begin
        
         forever #1 clk=~clk;

      end

      RAM_intf RAM_intf0(clk);
      RAM_intf RAM_golden_intf(clk);
      spi_ram DUT(.din(RAM_intf0.din),.rx_valid(RAM_intf0.rx_valid),.tx_valid(RAM_intf0.tx_valid),.dout(RAM_intf0.dout),.clk(clk),.rst_n(RAM_intf0.rst_n));
      RAM_golden Golden_ref(.din(RAM_golden_intf.din),.clk(clk),.rst_n(RAM_golden_intf.rst_n),.rx_valid(RAM_golden_intf.rx_valid),
      .dout(RAM_golden_intf.dout),.tx_valid(RAM_golden_intf.tx_valid) );

      bind spi_ram RAM_assertions #(.ADDR_SIZE(8),.MEM_DEPTH(256))RAM_SVA(.din(RAM_intf0.din),.rx_valid(RAM_intf0.rx_valid),.tx_valid(RAM_intf0.tx_valid),.dout(RAM_intf0.dout),
      .clk(clk),.rst_n(RAM_intf0.rst_n));

      initial begin
        uvm_config_db#(virtual RAM_intf)::set(null,"uvm_test_top","RAM_INTF",RAM_intf0);
        uvm_config_db#(virtual RAM_intf)::set(null,"*","RAM_GOLD_INTF",RAM_golden_intf);
        run_test("RAM_test");

      end

endmodule