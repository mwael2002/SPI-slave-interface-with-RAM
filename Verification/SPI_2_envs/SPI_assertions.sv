module SPI_assertions(SPI_IF asser);
    
    always @(*) begin
    
    if(!asser.rst_n) begin
    reset_assertion: assert final (asser.MISO==0);
    cover_assertion: cover final(asser.MISO==0);

      end
    end

    property p_not_reading_data;

    disable iff(!asser.rst_n)( @(posedge asser.clk) $fell(asser.SS_n) ##3 !($past(asser.MOSI,1)==1 && asser.MOSI==1) |=> !asser.MISO [*8] );

    endproperty

    a_not_reading_data:assert property(p_not_reading_data);
    c_not_reading_data:cover property(p_not_reading_data);

endmodule