ghdl -a ula.vhd
ghdl -a adder.vhd
ghdl -a and_op.vhd
ghdl -a subtracter.vhd
ghdl -a xor_op.vhd
ghdl -a ula_tb.vhd
ghdl -e ula
ghdl -e adder
ghdl -e and_op
ghdl -e subtracter
ghdl -e xor_op
ghdl -e ula_tb

ghdl -r ula_tb --vcd=ula_tb.vcd
gtkwave ula_tb.vcd
