module SPI_Wrapper_Golden(MOSI,MISO,SS_n,clk,rst_n);
input  MOSI,clk,rst_n,SS_n;
output MISO;
wire [9:0]rx_data;
wire [7:0]tx_data;
wire rx_valid,tx_valid;

RAM_golden RAM0(.din(rx_data),.rx_valid(rx_valid),.clk(clk),.rst_n(rst_n),.dout(tx_data),.tx_valid(tx_valid));
spi_slave_golden spi_slave_g(.MOSI(MOSI),.MISO(MISO),.SS_n(SS_n),.clk(clk),.rst_n(rst_n),.rx_data(rx_data),.rx_valid(rx_valid),.tx_data(tx_data),.tx_valid(tx_valid)); 


endmodule