import spi_test1::*;
import uvm_pkg::*;
`include "uvm_macros.svh"
module top();
bit clk;

initial begin
	forever
	#1 clk=~clk;
end 


SPI_IF spi_intf(clk);
SPI_IF spi_golden_intf(clk);

spi_wrapper DUT(spi_intf);
SPI_Wrapper_Golden golden(.clk(spi_golden_intf.clk),.MOSI(spi_golden_intf.MOSI),.rst_n(spi_golden_intf.rst_n),.SS_n(spi_golden_intf.SS_n),.MISO(spi_golden_intf.MISO));

bind spi_wrapper SPI_assertions SPI_AS(spi_intf);

initial begin
	uvm_config_db#(virtual SPI_IF)::set(null, "uvm_test_top", "interface",spi_intf);
	uvm_config_db#(virtual SPI_IF)::set(null, "uvm_test_top", "gold",spi_golden_intf);
	run_test("spi_test");
end

endmodule : top