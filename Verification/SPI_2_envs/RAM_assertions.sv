module RAM_assertions(din,rx_valid,tx_valid,dout,clk,rst_n);
    
parameter ADDR_SIZE = 8, MEM_DEPTH =256;

input logic rx_valid,tx_valid,clk,rst_n;
input logic [9:0] din;
input logic [7:0] dout;


always @(*) begin
    
    if(!rst_n) begin
    reset_assertion: assert final (dout==0 && tx_valid ==0);
    cover_assertion: cover final(dout==0 && tx_valid ==0);
    end

end

property p_tx_check_low;

  disable iff(!rst_n) ( @(posedge clk) !(din[9] && din[8]) |-> rx_valid |=> !tx_valid );   

endproperty

property p_tx_check_high;

  disable iff(!rst_n) ( @(posedge clk) (din[9] && din[8] ) |-> rx_valid |=> tx_valid );   

endproperty

a_tx_check_high: assert property (p_tx_check_high);
c_tx_check_high: cover property(p_tx_check_high);

a_tx_check_low: assert property (p_tx_check_low);
c_tx_check_low: cover property(p_tx_check_low);

endmodule