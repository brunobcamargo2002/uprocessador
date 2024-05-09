#ghdl -a control_proto_unit.vhd
#ghdl -e control_proto_unit

#ghdl -a pc_tb.vhd
#ghdl -e pc_tb

ghdl -a one_state_machine.vhd
ghdl -e one_state_machine

ghdl -a one_state_machine_tb.vhd
ghdl -e one_state_machine_tb

ghdl -r one_state_machine_tb --wave=one_state_machine_tb.ghw
gtkwave one_state_machine_tb.ghw

#ghdl -r pc_tb --vcd=pc_tb.vcd
#gtkwave pc_tb.vcd
