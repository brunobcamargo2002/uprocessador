#uprocessor
ghdl -a uprocessor.vhd
ghdl -e uprocessor

#ULA
ghdl -a ULA/ula.vhd
ghdl -a ULA/adder.vhd
ghdl -a ULA/and_op.vhd
ghdl -a ULA/subtracter.vhd
ghdl -a ULA/xor_op.vhd
ghdl -e ula
ghdl -e adder
ghdl -e and_op
ghdl -e subtracter
ghdl -e xor_op

#RegisterBank
ghdl -a Register_Bank/registrator_16.vhd
ghdl -a Register_Bank/reg_bd.vhd

ghdl -e registrator_16
ghdl -e reg_bd

ghdl -r uprocessor --vcd=uprocessor.vcd
gtkwave uprocessor.vcd


