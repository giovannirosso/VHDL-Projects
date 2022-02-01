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
--NOP		--9D		--x					--x					-- NOP
--LDX		--DE		--Registrador X		--Valor inteiro		-- Carrega valor inteiro no Registrador X
--ADD		--FB		--Registrador X		--Registrador Y		-- Soma RX e RY p/ Acumulador
--STA		--F7		--Registrador X		--NULL				-- Salva valor Acumulador p/ Registrador X
--SUB		--D0		--Registrador X		--Registrador Y		-- Subtrai RX e RY p/ Acumulador
--JMP		--CC		--Endereço do Salto	até 8 bits			-- Salta para o endereço
--MOV		--5E		--Registrador X		--Registrador Y		-- Copia valor de Registrador Y p/ Registrador X

architecture a_rom of rom is
	signal data_s: unsigned(15 downto 0):="0000000000000000";
	type mem is array (0 to 65536) of unsigned(15 downto 0);
	constant content_rom : mem := (
		 	 0	=> 	x"0000", --	NOP
		 	 1 	=>  x"DE35", -- LDX $3 #5		--Carrega R3 com 5
		 	 2 	=>  x"DE48", -- LDX $4 #8		--Carrega R4 com 8
			 3 	=>  x"FB34", -- ADD $3 $4		--Soma R3 com R4 e salva no Acc
			 4 	=>  x"F750", -- STA $5			--Salva valor do Acc em R5
			 5 	=>  x"DE61", -- LDX $6 #1		--Carrega R6 com 1
			 6 	=>  x"D056", -- SUB $5 $6		--Subtrai R5 com R6
			 7 	=>  x"F750", -- STA $5			--Salva valor do Acc em R5
			 8 	=>  x"CC14", -- JMP #20			--Pula para posição 20
			 9 	=>  x"0000", --NOP  
			 10 =>  x"0000", --NOP
			 11 =>  "0000000000000000",  
			 12 =>  "0000000000000000",  
			 13 =>  "0000000000000000", 
			 14 =>  "0000000000000000",  
			 15 =>  "0000000000000000",  
			 16 =>  "0000000000000000",  
			 17 =>  "0000000000000000",  
			 18 =>  "0000000000000000",  
			 19 =>  x"0000", --NOP  
			 20 =>  x"5E35", -- MOV $3, $5		--Move R5 para R3
			 21 =>  x"CC03", -- JMP #3			--Pula para posição 3
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
