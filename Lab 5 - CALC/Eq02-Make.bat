@echo off
clear-history
cls
echo ==============================================================================
echo RUN GHDL
echo ==============================================================================
@echo on

ghdl --clean
ghdl --remove

ghdl -a Eq02-reg16bits.vhd
ghdl -e reg16bits

ghdl -a Eq02-register_file.vhd
ghdl -e register_file

ghdl -a Eq02-acumulador.vhd
ghdl -e acumulador

ghdl -a Eq02-ULA.vhd
ghdl -e ULA

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

ghdl -r controlUnit_tb --wave="Eq02-Calc.ghw" --stop-time=15000ns

gtkwave Eq02-Calc.ghw Eq02-Calc.gtkw