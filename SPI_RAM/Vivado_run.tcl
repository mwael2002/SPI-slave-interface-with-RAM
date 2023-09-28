create_project Project_2 -part xc7a35ticpg236-1L -force

add_files RAM.v 
add_files SPI_slave.v
add_files SPI_Wrapper.v
add_files constrain_design4.xdc

synth_design -rtl -top SPI_Wrapper > elab.log

write_schematic elaborated_schematic.pdf -format pdf -force 

launch_runs synth_1 > synth.log

wait_on_run synth_1
open_run synth_1

write_schematic synthesized_schematic.pdf -format pdf -force 

write_verilog -force SPI_Wrapper_netlist.v

launch_runs impl_1 -to_step write_bitstream 

wait_on_run impl_1
open_run impl_1