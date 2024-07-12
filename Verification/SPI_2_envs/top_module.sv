import spi_test1::*;
import uvm_pkg::*;
`include "uvm_macros.svh"
module top_module();
bit clk;

initial begin
	forever
	#1 clk=~clk;
end 


SPI_IF spi_intf(clk);
SPI_IF spi_intf_golden(clk);
RAM_intf RAM_intf_DUT(clk);
RAM_intf RAM_intf_Golden(clk);

spi_wrapper DUT(spi_intf);
SPI_Wrapper_Golden golden(.clk(spi_intf_golden.clk),.MOSI(spi_intf_golden.MOSI),.rst_n(spi_intf_golden.rst_n),.SS_n(spi_intf_golden.SS_n),.MISO(spi_intf_golden.MISO));

bind spi_wrapper SPI_assertions SPI_AS(spi_intf);
bind DUT.m2 RAM_assertions RAM_AS(RAM_intf_DUT.din,RAM_intf_DUT.rx_valid,RAM_intf_DUT.tx_valid,RAM_intf_DUT.dout,RAM_intf_DUT.clk,RAM_intf_DUT.rst_n);

assign RAM_intf_DUT.rst_n=spi_intf.rst_n;
assign RAM_intf_DUT.din=DUT.W1;
assign RAM_intf_DUT.dout=DUT.W4;
assign RAM_intf_DUT.rx_valid=DUT.W2;
assign RAM_intf_DUT.tx_valid=DUT.W3;

assign RAM_intf_Golden.rst_n=spi_intf_golden.rst_n;
assign RAM_intf_Golden.din=golden.rx_data;
assign RAM_intf_Golden.dout=golden.tx_data;
assign RAM_intf_Golden.rx_valid=golden.rx_valid;
assign RAM_intf_Golden.tx_valid=golden.tx_valid;

initial begin

	uvm_config_db#(virtual RAM_intf)::set(null, "uvm_test_top", "RAM_interface_DUT",RAM_intf_DUT);
	uvm_config_db#(virtual RAM_intf)::set(null, "uvm_test_top", "RAM_interface_golden",RAM_intf_Golden);
	uvm_config_db#(virtual SPI_IF)::set(null, "uvm_test_top", "SPI_interface_DUT",spi_intf);
	uvm_config_db#(virtual SPI_IF)::set(null, "uvm_test_top", "SPI_interface_golden",spi_intf_golden);
	run_test("spi_test");
end

endmodule 