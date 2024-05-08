ghdl -a pc_tb.vhd

ghdl -e pc_tb

ghdl -r pc_tb --wave=pc_tb.ghw
gtkwave pc_tb.ghw