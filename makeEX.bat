cls
ghdl --remove
ghdl --clean
ghdl -a EqNN-Nome.vhd
ghdl -e nome_entidade
ghdl -a EqNN-Nome_tb.vhd
ghdl -e nome_entidade_tb
ghdl -r nome_entidade_tb --wave=EqNN-Nome_tb.ghw
gtkwave --save=EqNN-Nome_tb.gtkw EqNN-Nome_tb.ghw
