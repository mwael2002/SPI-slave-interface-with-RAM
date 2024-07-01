vlib work
vlog  RAM_Golden.v project_ram.v  RAM_seq_item.sv \
Top_module.sv RAM_interface.sv RAM_sequence.sv \
RAM_sequencer.sv RAM_scoreboard.sv RAM_agent.sv \
RAM_test.sv RAM_config_obj.sv RAM_monitor.sv \
RAM_env.sv RAM_assertions.sv RAM_driver.sv \
RAM_coverage.sv +cover -covercells

vsim -voptargs=+acc work.Top_module -classdebug -uvmcontrol=all -cover

coverage save ram.ucdb -onexit
run -all

vcover report ram.ucdb -details -annotate -all -output ram_coverage_rpt.txt 

