// RAM module
module RAM_golden(
    input [9:0] din,
    input clk,
    input rst_n,
    input rx_valid,
    output reg[7:0] dout,
    output reg tx_valid
);

    parameter MEM_DEPTH = 256;
    parameter ADDR_SIZE = 8;

    localparam WRITE_ADD=2'b00,WRITE_DATA=2'b01,READ_ADD=2'b10,READ_DATA=2'b11; 

    reg [7:0] memory [MEM_DEPTH-1:0];
    reg [ADDR_SIZE-1:0] wr_addr;
    reg [ADDR_SIZE-1:0] rd_addr;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            wr_addr <= 0;
            rd_addr <= 0;
            dout<=0;
            tx_valid<=0;
        end 
        else if (rx_valid) begin
            case (din[9:8])
                WRITE_ADD: begin 
                    wr_addr <= din[7:0];
                    tx_valid<=0;             
                    end
                WRITE_DATA:begin
                     memory[wr_addr] <= din[7:0];
                     tx_valid<=0;
                     end
                READ_ADD:begin
                    rd_addr <= din[7:0];
                    tx_valid<=0;
                    end
                READ_DATA:begin
                dout<=memory[rd_addr];
                tx_valid<=1;
                end
            endcase
        end
    end


endmodule