cls
ghdl --remove
ghdl --clean

ghdl -a Eq02-Reg16bits.vhd
ghdl -e reg16bits

ghdl -a Eq02_RegFile.vhd
ghdl -e register_file

ghdl -a Eq02_RegFile_tb.vhd
ghdl -e register_file_tb
ghdl -r register_file_tb --stop-time=3000ns --wave=Eq02-RegFile.ghw
gtkwave --save=Eq02-RegFile.gtkw Eq02-RegFile.ghw
