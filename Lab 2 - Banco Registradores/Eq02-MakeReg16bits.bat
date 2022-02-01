cls
ghdl --remove
ghdl --clean
ghdl -a Eq02-Reg16bits.vhd
ghdl -e reg16bits
ghdl -a Eq02-Reg16bits_tb.vhd
ghdl -e reg16bits_tb
ghdl -r reg16bits_tb --stop-time=3000ns --wave=Eq02-Reg16bits.ghw
gtkwave --save=Eq02-Reg16bits.gtkw Eq02-Reg16bits.ghw
