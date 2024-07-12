module project(MOSI,MISO,SS_n,clk,rst_n,rx_data,rx_valid,tx_data,tx_valid);
parameter IDLE=3'b000;
parameter CHK_CMD=3'b001;
parameter WRITE=3'b010;
parameter READ_DATA=3'b011;
parameter READ_ADD=3'b100;


input MOSI,SS_n,clk,rst_n,tx_valid;
input[7:0] tx_data;
output reg [9:0] rx_data;
output reg rx_valid;
output reg MISO;

reg flag;
reg [2:0] cs,ns;
reg[3:0] i,k;

always@(posedge clk or negedge rst_n)
begin
if(rst_n==0)
cs<=IDLE;
else cs<=ns;
end

always@(cs,SS_n,MOSI)
begin
case(cs)
IDLE: begin
if(SS_n==0)
ns=CHK_CMD;
else
ns<=IDLE;
end
CHK_CMD: 
begin
if(SS_n==1)
ns<=IDLE;
else if(SS_n==0 && MOSI==0)
ns=WRITE;
else if(SS_n==0 && MOSI==1 && flag==1)
begin
ns=READ_DATA;
end
else 
begin
ns=READ_ADD;
end
end
WRITE: 
begin
if(SS_n==0)
ns=WRITE;
else
ns=IDLE;
end
READ_ADD:
begin
if(SS_n==0)
ns=READ_ADD;

else
ns=IDLE;
end
READ_DATA:
begin
if(SS_n==0)
ns=READ_DATA;
else
ns=IDLE;
end

default:ns=IDLE;

endcase
end

always@(posedge clk or negedge rst_n)
begin

if(!rst_n) begin
      rx_valid<=0;
      MISO<=0;
      rx_data<=0;
      flag<=0;
      end

else begin

case (cs)

IDLE:
begin
      rx_valid<=0;
      MISO<=0;
      i<=9;
      k<=0;
      end


WRITE:begin
if(i==0) begin
rx_data[i]<=MOSI;
rx_valid<=1;
i<=9;
end

else begin
rx_data[i]<=MOSI;
i<=i-1;
rx_valid<=0;
end

end

READ_ADD:begin
if(i==0) begin
rx_data[i]<=MOSI;
rx_valid<=1;
flag<=1;
i<=9;
end

else begin
rx_data[i]<=MOSI;
i<=i-1;
rx_valid<=0;
end
end

READ_DATA: begin    
      
if(i==0) begin
rx_valid<=1;
rx_data[i]<=MOSI;
i<=9;
end

else begin
rx_data[i]<=MOSI;
i<=i-1;
rx_valid<=0;
end

if(tx_valid==1) begin

   rx_valid<=0;
   if(k==7) begin
   flag<=0;
   MISO<=tx_data[7-k];
   end
   else begin
   MISO<=tx_data[7-k];
   k=k+1;
   end
end

end

endcase

end
end


endmodule


