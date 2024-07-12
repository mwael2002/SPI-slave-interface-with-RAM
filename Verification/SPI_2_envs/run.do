vlib work
vlog project_ram.v project_spi.v RAM_Golden.v spi_slave_golden.v SPI_Wrapper_Golden.v top_module.sv interface.sv RAM_interface.sv spi_wrapper.sv \
RAM_sequencer.sv RAM_scoreboard.sv RAM_agent.sv RAM_monitor.sv RAM_env.sv RAM_assertions.sv RAM_driver.sv RAM_seq_item.sv RAM_coverage.sv\
enviroment.sv test.sv driver.sv config.sv agent.sv coverage_collector.sv monitor.sv scoreboard.sv seq_item.sv sequence.sv sequencer.sv SPI_assertions.sv \
+cover -covercells

vsim -voptargs=+acc work.top_module -classdebug -uvmcontrol=all -cover

coverage save SPI_2_envs.ucdb -onexit 
run -all
quit -sim
vcover report SPI_2_envs.ucdb -details -annotate -all -output coverage_rpt.txt
