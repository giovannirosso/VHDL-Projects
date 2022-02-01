cls
ghdl --remove
ghdl --clean

ghdl -a Eq02-ULA.vhd
ghdl -e ULA

ghdl -a Eq02-Reg16bits.vhd
ghdl -e reg16bits

ghdl -a Eq02-register_file.vhd
ghdl -e register_file

ghdl -a Eq02-ULA_Regs.vhd
ghdl -e ULA_Regs

ghdl -a Eq02-ULA_Regs_tb.vhd
ghdl -e ULA_Regs_tb
ghdl -r ULA_Regs_tb --stop-time=3000ns --wave=Eq02-ULARegs.ghw
gtkwave --save=Eq02-ULARegs.gtkw Eq02-ULARegs.ghw
