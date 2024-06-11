#ULA
#ghdl -a ULA/and_op.vhd
ghdl -a ULA/subtracter.vhd
# ghdl -a ULA/xor_op.vhd
ghdl -a ULA/adder.vhd
ghdl -a ULA/ula.vhd

ghdl -e adder
# ghdl -e and_op
ghdl -e subtracter
# ghdl -e xor_op
ghdl -e ula

#ROM
ghdl -a ROM/rom.vhd
ghdl -e rom

#RegisterBank

ghdl -a utils/registrator_16.vhd

ghdl -a Register_Bank/reg_bd.vhd

ghdl -e reg_bd

#Utils
ghdl -a utils/three_state_machine.vhd
ghdl -a utils/registrator_7.vhd
ghdl -a utils/registrator_1.vhd

ghdl -e three_state_machine
ghdl -e registrator_7
ghdl -e registrator_1

#Control
ghdl -a Control/proto_control.vhd
ghdl -e proto_control

#Control Unity
ghdl -a Control_Unity/control_unity.vhd
ghdl -e control_unity

#TopLevel
ghdl -a processador.vhd

ghdl -e processador

#TestBench
ghdl -a processador_tb.vhd

ghdl -e processador_tb

#Generation of GTKWAVE file
ghdl -r processador_tb --vcd=processador_tb.vcd
#ghdl -r top_level_tb --wave=top_level_tb.ghw

#GTKWAVE
gtkwave processador_tb.vcd
#gtkwave top_level_tb.ghw


