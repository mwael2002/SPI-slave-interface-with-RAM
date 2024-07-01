vlib work

vlog coverage_packege.sv FIFO.sv interface.sv monitor.sv scoreboard.sv shared_packege.sv testbench.sv top.sv transaction_packege.sv golden_ref0.sv +cover -covercells

vsim -voptargs=+acc work.FIFO_top -cover
add wave -position insertpoint  \
sim:/FIFO_top/F_if/FIFO_WIDTH \
sim:/FIFO_top/F_if/FIFO_DEPTH \
sim:/FIFO_top/F_if/clk \
sim:/FIFO_top/F_if/data_in \
sim:/FIFO_top/F_if/rst_n \
sim:/FIFO_top/F_if/wr_en \
sim:/FIFO_top/F_if/rd_en \
sim:/FIFO_top/F_if/data_out \
sim:/FIFO_top/F_if/wr_ack \
sim:/FIFO_top/F_if/overflow \
sim:/FIFO_top/F_if/full \
sim:/FIFO_top/F_if/empty \
sim:/FIFO_top/F_if/almostfull \
sim:/FIFO_top/F_if/almostempty \
sim:/FIFO_top/F_if/underflow \
sim:/FIFO_top/F_if/test_finished

add wave -position insertpoint  \
sim:/FIFO_top/tb/data_out_gold \
sim:/FIFO_top/tb/wr_ack_gold \
sim:/FIFO_top/tb/overflow_gold \
sim:/FIFO_top/tb/full_gold \
sim:/FIFO_top/tb/empty_gold \
sim:/FIFO_top/tb/almostfull_gold \
sim:/FIFO_top/tb/almostempty_gold \
sim:/FIFO_top/tb/underflow_gold

add wave -position insertpoint  \
sim:/FIFO_top/dut/count
add wave -position insertpoint  \
sim:/FIFO_top/tb/dut/count

add wave /FIFO_top/dut/signal_wr_ack_1 /FIFO_top/dut/signal_overflow_1 /FIFO_top/dut/signal_full_1 /FIFO_top/dut/signal_empty_1 /FIFO_top/dut/signal_almostfull_1 /FIFO_top/dut/signal_almostempty_1 /FIFO_top/dut/signal_underflow_1 /FIFO_top/tb/#ublk#182146786#22/immed__24

add wave -position insertpoint  \
sim:/FIFO_top/tb/dut/wr_en \
sim:/FIFO_top/tb/dut/rd_en
add wave -position insertpoint  \
sim:/FIFO_top/dut/wr_ptr \
sim:/FIFO_top/dut/rd_ptr
coverage save FIFO_top.ucdb -onexit

run -all