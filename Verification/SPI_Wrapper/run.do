vlib work
vlog project_ram.v project_spi.v RAM_Golden.v spi_slave_golden.v SPI_Wrapper_Golden.v top.sv interface.sv enviroment.sv test.sv driver.sv config.sv agent.sv coverage_collector.sv monitor.sv scoreboard.sv seq_item.sv sequence.sv sequencer.sv SPI_assertions.sv spi_wrapper.sv +cover -covercells
vsim -voptargs=+acc work.top -classdebug -uvmcontrol=all -cover
add wave /top/spi_intf/*
add wave -position insertpoint  \
sim:/top/spi_golden_intf/clk \
sim:/top/spi_golden_intf/MISO \
sim:/top/spi_golden_intf/MOSI \
sim:/top/spi_golden_intf/rst_n \
sim:/top/spi_golden_intf/SS_n


run 0
add wave /uvm_pkg::uvm_reg_map::do_write/#ublk#215181159#1731/immed__1735 /uvm_pkg::uvm_reg_map::do_read/#ublk#215181159#1771/immed__1775 /seq::spi_sequence_write::body/#ublk#31169#15/immed__19 /seq::spi_sequence_read::body/#ublk#31169#34/immed__38 /top/DUT/SPI_AS/reset_assertion /top/DUT/SPI_AS/a_not_reading_data

add wave -position insertpoint  \
sim:/uvm_root/uvm_test_top/myenv/sb/correct_count \
sim:/uvm_root/uvm_test_top/myenv/sb/error_count


coverage save abdo.ucdb -onexit 
run -all
quit -sim
vcover report abdo.ucdb -details -annotate -all -output coverage_rpt.txt