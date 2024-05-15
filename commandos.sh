#ULA
ghdl -a ULA/and_op.vhd
ghdl -a ULA/subtracter.vhd
ghdl -a ULA/xor_op.vhd
ghdl -a ULA/adder.vhd
ghdl -a ULA/ula.vhd

ghdl -e adder
ghdl -e and_op
ghdl -e subtracter
ghdl -e xor_op
ghdl -e ula

#ROM
ghdl -a ROM/rom.vhd
ghdl -e rom

#RegisterBank
ghdl -a utils/registrator_16.vhd
ghdl -a Register_Bank/reg_bd.vhd

ghdl -e registrator_16
ghdl -e reg_bd

#Utils
ghdl -a utils/three_state_machine.vhd
ghdl -a utils/registrator_7.vhd

ghdl -e three_state_machine
ghdl -e registrator_7

#Control
ghdl -a Control/proto_control.vhd
ghdl -e proto_control

#TopLevel
ghdl -a top_level.vhd

ghdl -e top_level

#TestBench
ghdl -a top_level_tb.vhd

ghdl -e top_level_tb

#Generation of GTKWAVE file
ghdl -r top_level_tb --vcd=top_level_tb.vcd
#ghdl -r top_level_tb --wave=top_level_tb.ghw

#GTKWAVE
gtkwave top_level_tb.vcd
#gtkwave top_level_tb.ghw


