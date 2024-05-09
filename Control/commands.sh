#ghdl -a control_proto_unit.vhd
#ghdl -e control_proto_unit

#ghdl -a pc_tb.vhd
#ghdl -e pc_tb

ghdl -a ../PC/one_state_machine.vhd
ghdl -e one_state_machine

ghdl -a ../ROM/rom.vhd
ghdl -e rom

ghdl -a proto_control.vhd
ghdl -e proto_control

ghdl -a proto_control_tb.vhd
ghdl -e proto_control_tb

ghdl -r proto_control_tb --wave=proto_control_tb.ghw
gtkwave proto_control_tb.ghw
