ghdl -a control_proto_unit.vhd
ghdl -e control_proto_unit

ghdl -a pc_tb.vhd
ghdl -e pc_tb

ghdl -r pc_tb --vcd=pc_tb.vcd
gtkwave pc_tb.vcd
>>>>>>> fca142c812e65ad854c5e0420c582afcf91ef866
