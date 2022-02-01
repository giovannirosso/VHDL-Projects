cls
ghdl --remove
ghdl --clean

ghdl -a Eq02-rom.vhd
ghdl -e rom

ghdl -a Eq02-maquinaEstados.vhd
ghdl -e maquinaEstados

ghdl -a Eq02-pc.vhd
ghdl -e pc

ghdl -a Eq02-controlUnit.vhd
ghdl -e controlUnit

ghdl -a Eq02-controlUnit_tb.vhd
ghdl -e controlUnit_tb

ghdl -r controlUnit_tb --stop-time=5000ns --wave=Eq02-ROM-PC-UC.ghw
gtkwave --save=Eq02-ROM-PC-UC.gtkw Eq02-ROM-PC-UC.ghw
