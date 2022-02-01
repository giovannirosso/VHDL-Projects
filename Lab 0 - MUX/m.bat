cls
ghdl -a mux2x1.vhd
ghdl -e mux2x1
ghdl -a mux2x1_tb.vhd
ghdl -e mux2x1_tb
ghdl -r mux2x1_tb --wave=mux2x1_tb.ghw
gtkwave --save=mux2x1.gtkw mux2x1_tb.ghw
