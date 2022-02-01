--GIOVANNI DE ROSSO UNRUH
--ANDRIGO PIAI LIUCCI
--ROM

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom is 
	port( clk, rst : in std_logic;
		  address : in unsigned(15 downto 0);
		  data : out unsigned(15 downto 0)
		);
end entity;

--Modificamos a maneira de operação do HC08 para seguinte estrutura
--Conjunto de Instruçoes utilizadas HC08

	--instr		--OP(8bits)	--(4bits)			--(4bits)			--
				--(15-8)	--(7-4)				--(3-0)
	--NOP		--9D		--x					--x					-- NOP
	--LDX		--DE		--Registrador X		--Imm 4 bits		-- Carrega valor inteiro no Registrador X
	--ADD		--FB		--Registrador X		--Registrador Y		-- Soma RX e RY p/ Acumulador
	--STA		--F7		--Registrador X		--x					-- Salva valor Acumulador p/ Registrador X
	--SUB		--D0		--Registrador X		--Registrador Y		-- Subtrai RX e RY p/ Acumulador
	--JMP		--CC		--Imm 8 bits							-- Salta para o endereço
	--MOV		--5E		--Registrador X		--Registrador Y		-- Copia valor de Registrador Y p/ Registrador X
	--CMP		--F1		--x					--Registrador X		-- Verifica o valor do registrador X e Atualiza as flags
	--BLT		--91		--Valor relativo 8 bits					-- Realiza o desvio se o flag indicar Menor Que

architecture a_rom of rom is
	signal data_s: unsigned(15 downto 0):="0000000000000000";
	type mem is array (0 to 65536) of unsigned(15 downto 0);
	constant content_rom : mem := (
		 	 0	=> 	x"0000", --	NOP
		 	 1 	=>  x"DE30", -- LDX $3 #0		--Carrega R3 com 0
		 	 2 	=>  x"DE40", -- LDX $4 #0		--Carrega R4 com 0
			 3	=>	x"DE7F", -- LDX $7 #15		--Carrega R7 com 15
			 4 	=>  x"FB77", -- ADD $7 $7		--Soma R7 com R7 e salva no Acc
			 5 	=>  x"F770", -- STA $7			--Salva valor do Acc em R7 -- agr r7 tem 30
			 6 	=>  x"FB34", -- ADD $3 $4		--Soma R3 com R4 e salva no Acc
			 7 	=>  x"F740", -- STA $4			--Salva valor do Acc em R4
			 8 	=>  x"DE61", -- LDX $6 #1		--Carrega R6 com 1
			 9 	=>  x"FB36", -- ADD $3 $6		--Soma R3 com R6=1 e salva no Acc
			 10 =>  x"F730", -- STA $3			--Salva valor do Acc em R3
			 11 =>  x"F107", -- CMP $7			--Atualiza as flags comparando o Acc com R7
			 12 =>  x"91FA", -- BLT -6  		--Brach relativo de -6 "comandos"
			 13 =>  x"5E54", --	MOV R5 R4		--Copia R4 para R5
			 14 =>  "0000000000000000",   
			 15 =>  "0000000000000000",  
			 16 =>  "0000000000000000",  
			 17 =>  "0000000000000000",  
			 18 =>  "0000000000000000",  
			 19 =>  x"0000", --NOP 
			 20 =>  x"0000", --NOP 
			 21 =>  x"0000", --NOP 
			 22 =>	x"0000", --NOP 
			 23 =>	"0000000000000000", 
		 -- abaixo: casos omissos => (zero em todos os bits)
		 others => (others=>'0')
	);
begin
	process(clk, rst)
	begin
		if rst /= '1' then
			if (rising_edge(clk)) then
				data_s <= content_rom(to_integer(address));
			end if;
		else
			data_s <= content_rom(0);
		end if;
	end process;
	data<= data_s;
end architecture;
