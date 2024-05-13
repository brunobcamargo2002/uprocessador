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

#RegisterBank
ghdl -a Register_Bank/reg_bd.vhd

ghdl -e reg_bd

#ROM

ghdl -a ROM/rom.vhd

ghdl -e rom

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

#GTKWAVE
gtkwave top_level_tb.vcd


