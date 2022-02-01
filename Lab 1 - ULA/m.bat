cls
ghdl -a ULA.vhd
ghdl -e ULA
ghdl -a ULA_tb.vhd
ghdl -e ULA_tb
ghdl -r ULA_tb --wave=ULA_tb.ghw
gtkwave --save=ULA.gtkw ULA_tb.ghw
