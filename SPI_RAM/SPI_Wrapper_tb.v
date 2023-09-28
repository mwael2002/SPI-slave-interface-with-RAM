module SPI_Wrapper_tb;
       
       reg clk,rst_n,MOSI,SS_n;
       wire MISO;

   SPI_Wrapper DUT(clk,rst_n,SS_n,MOSI,MISO);    

    initial begin
	clk=0;
	forever
	#1 clk=~clk;
    end

    
    integer signed i,j;
    
    initial begin
       
       rst_n=0;
       repeat(30) begin
              
              MOSI=$random;
              SS_n=$random;
              @(negedge clk);
       
       end

       rst_n=1;
       #2;

       for(i=0;i<40;i=i+1) begin
        
          SS_n=0;
          #2;
          MOSI=0;
          #6;

          for(j=7;j>=0;j=j-1) begin

              MOSI=i[j];
              #2;

            end

          SS_n=1;
          #2;

          SS_n=0;
          #2;

          MOSI=0;
          #4;

          MOSI=1;
          #2;

          for(j=0;j<8;j=j+1) begin

              MOSI=$random;
              #2;

          end

          SS_n=1;
          #2;

       end

       for(i=0;i<40;i=i+1) begin
        
          SS_n=0;
          #2;
          MOSI=1;
          #4;

          MOSI=0;
          #2;

          for(j=7;j>=0;j=j-1) begin

              MOSI=i[j];
              #2;

            end

          SS_n=1;
          #2;

          SS_n=0;
          #2;

          MOSI=1;
          #6;

          MOSI=$random;
          #32;

          SS_n=1;
          #2;

       end

    $stop;
    end



endmodule