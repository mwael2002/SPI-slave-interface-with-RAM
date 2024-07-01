package RAM_pkg;

    

    class RAM_class #(int WIDTH=10);

        randc logic [WIDTH-1:0] din;
        rand logic rx_valid,rst_n;

        constraint c_rst_n{ rst_n dist{0:=5,1:=95};  };
        constraint c_rx_valid { rx_valid dist{1:=25,0:=75};  }
        

        covergroup cvr_grp_ram;

        c_din: coverpoint din{

            bins address_write_max={10'b00_1111_1111};
            bins address_read_max = {10'b10_1111_1111};
            bins address_write_min={10'b00_0000_0000};
            bins address_read_min = {10'b10_0000_0000};
           ignore_bins not_address[] = {[10'b00_0000_0001:10'b00_1111_1110],[10'b10_0000_0001:10'b10_1111_1110]};
        
        
        }

        c_rx_valid: coverpoint rx_valid;
        c_rst_n: coverpoint rst_n;
       


        cross_write: cross c_din,c_rst_n,c_rx_valid{

           bins write_max_and_rx_valid = binsof(c_rst_n) intersect{1} && binsof(c_din.address_write_max) && binsof(c_rx_valid) intersect{1};
           bins read_max_and_rx_valid = binsof(c_rst_n) intersect{1} && binsof(c_din.address_read_max) && binsof(c_rx_valid) intersect{1};
           bins write_min_and_rx_valid = binsof(c_rst_n) intersect{1} && binsof(c_din.address_write_min) && binsof(c_rx_valid) intersect{1};
           bins read_min_and_rx_valid = binsof(c_rst_n) intersect{1} && binsof(c_din.address_read_min) && binsof(c_rx_valid) intersect{1};

           ignore_bins not_rx = binsof(c_rx_valid) intersect{0};
           ignore_bins not_rst = binsof(c_rst_n) intersect{0};

        }

        endgroup
 

        function new();
            
            cvr_grp_ram=new();

        endfunction


    endclass

    
endpackage