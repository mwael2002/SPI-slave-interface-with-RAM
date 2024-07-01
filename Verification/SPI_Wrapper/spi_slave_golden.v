module  spi_slave_golden(MOSI,MISO,SS_n,clk,rst_n,rx_data,rx_valid,tx_data,tx_valid);
parameter IDLE=3'b000;
parameter CHK_CMD=3'b001;
parameter WRITE=3'b010;
parameter READ_ADD=3'b100;
parameter READ_DATA=3'b011;


input  MOSI,SS_n,tx_valid,clk,rst_n;
input  [7:0] tx_data;
output reg [9:0] rx_data;
output reg MISO,rx_valid;

reg [2:0] cs,ns;
reg DONE_ADDR=0;
reg [3:0]i;
reg [2:0]j;


always @(*) begin
	case(cs)
	IDLE: begin
		if(SS_n == 1) begin
			ns = IDLE;
		end
		else begin
			ns = CHK_CMD;
		end
	end
	CHK_CMD: begin
		if (SS_n == 1) begin
			ns = IDLE;
		end
		else if (SS_n == 0 && MOSI == 0) begin
			ns = WRITE;
		end
		else begin
			if (DONE_ADDR == 1) begin
				ns = READ_DATA;
			end
			else begin
				ns = READ_ADD;
			end
		end

	end
	WRITE: begin
		if (SS_n == 1) begin
			ns = IDLE;
		end
		else begin
			ns = WRITE;
		end
	end
	READ_ADD: begin
		if (SS_n == 1) begin
			ns = IDLE;
		end
		else begin
			ns = READ_ADD;
		end
	end
	READ_DATA: begin
		if (SS_n == 1) begin
			ns = IDLE;
		end
		else begin
			ns = READ_DATA;
		end
	end
	default:ns=IDLE;
	endcase
end

//**************************************************************************

always@(posedge clk or negedge rst_n) begin
    	
	if(rst_n==0) begin
    		MISO<=0;
	        DONE_ADDR<=0;
			rx_valid<=0;
			rx_data<=0;
    	end
		
    else if (cs==IDLE) begin
    	   i <=4'b0;
    	   j <=4'b0;
	       rx_valid <=0;
	       MISO <= 0;
		   rx_data<=0;
    end

	else if(cs==WRITE) begin 
	  	 if(i==9) begin
         rx_valid<=1;
		 rx_data[9-i] <= MOSI;
		 i<=0;
		 end

       else begin
	      rx_data[9-i] <= MOSI;
	      i<=i+1;
		  rx_valid<=0;
	    end


	end

	else if(cs==READ_ADD) begin
	  	 if(i==9) begin
         rx_valid<=1;
		 rx_data[9-i] <= MOSI;
		 i<=0;
		 DONE_ADDR<=1;
		 end

          else begin
	          rx_data[9-i] <= MOSI;
	          i<=i+1;
			  rx_valid<=0;
	         end
    end

    else if(cs==READ_DATA) begin
    	   if(i==9) begin 
            rx_valid<=1;
		    rx_data[9-i] <= MOSI;
			i<=0;
		   end
          else begin
	          rx_data[9-i] <= MOSI;
	          i<=i+1;
			  rx_valid<=0;
	        end

        if(tx_valid==1) begin
		   rx_valid<=0;
	       
		   if(j==7) begin
		   DONE_ADDR<=0;
		   MISO <= tx_data[7-j];
		   end
           else begin
		   MISO <= tx_data[7-j];
	       j<=j+1;
	       end
        end
		 
end
end
//***************************************************************************

always@(posedge clk or negedge rst_n)begin
	if(~rst_n)
		cs<=IDLE;
	else
		cs<=ns;
end

endmodule