ghdl -a registrator_16.vhd
ghdl -a reg_bd.vhd
ghdl -a reg_bd_tb.vhd

ghdl -e registrator_16
ghdl -e reg_bd
ghdl -e reg_bd_tb

ghdl -r reg_bd_tb --wave=reg_bd_tb.ghw
gtkwave   reg_bd_tb.ghw