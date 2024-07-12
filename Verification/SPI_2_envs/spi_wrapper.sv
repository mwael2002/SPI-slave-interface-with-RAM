module spi_wrapper(SPI_IF spi_intf);


wire [9:0] W1;
wire W2,W3;
wire [7:0] W4;

assign spi_intf.dut_state=m1.cs;

project m1(.MOSI(spi_intf.MOSI),.MISO(spi_intf.MISO),.clk(spi_intf.clk),.rst_n(spi_intf.rst_n),.SS_n(spi_intf.SS_n),.rx_data(W1),.rx_valid(W2),.tx_data(W4),.tx_valid(W3));

spi_ram m2(.clk(spi_intf.clk),.rst_n(spi_intf.rst_n),.din(W1),.rx_valid(W2),.dout(W4),.tx_valid(W3));


endmodule

