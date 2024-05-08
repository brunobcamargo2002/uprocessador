ghdl -a rom.vhd
ghdl -e rom

ghdl -a rom_tb.vhd
ghdl -e rom_tb

ghdl -r rom_tb --vcd=rom_tb.vcd
gtkwave rom_tb.vcd
