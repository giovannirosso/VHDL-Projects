--GIOVANNI DE ROSSO UNRUH
--ANDRIGO PIAI LIUCCI
--ROM

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom is 
	port( clk : in std_logic;
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
	--CMP		--F1		--Registrador X		--x					-- Verifica o valor do registrador X e Atualiza as flags
	--BLT		--91		--Valor relativo 8 bits					-- Realiza o desvio se o flag indicar Menor Que
	--LDR		--D1		--Registrador X		--imm				-- Carega o valor da RAM p/ Rx
	--STR		--D2		--Registrador X		--imm				-- Escreve o valor RX na ram
	--LDA		--A			--Registrador X		--Valor Até FF		-- Escrita no registradodor especial até FF (Opcode especial para facilitar nossa vida)
	
architecture a_rom of rom is
	signal data_s: unsigned(15 downto 0):="0000000000000000";
	type mem is array (0 to 1024) of unsigned(15 downto 0);
	constant content_rom : mem := (
		 	 0	=> 	x"0000", --	NOP
		 	 1 	=>  x"A180", -- LDA $1 #128		--Carrega R1 com 128
		 	 2 	=>  x"DE20", -- LDX $2 #0		--Carrega R2 com 0
			 3	=>	x"A3FB", -- LDA $3 #251		--Carrega R3 com 251
			 4 	=>  x"A701", --	LDA $7 #1		--Carrega R7 com 1
			 5 	=>  x"D037", -- SUB $3 $7		--Subtrai 1(r7) do r3
			 6 	=>  x"F730", -- STA $3			--Salva do Acc em R3
			 7 	=>  x"D232", -- STR $3 ($2)		--
			 8 	=>  x"D124", -- LDR $4 ($2)		--
			 9 	=>  x"FB27", -- ADD $2 $7		--SOMA 1(r7) NO R2
			 10 =>  x"F720", -- STA $2			--Salva do Acc em R2
			 11 =>  x"CC05", 
			 12 =>  x"0000", 
			 13 =>  x"0000", 
			 14 =>  x"0000",   
			 15 =>  x"0000",  
			 16 =>  x"0000",   
			 17 =>  x"0000",  
			 18 =>  x"0000",  
			 19 =>  x"0000", --NOP 
			 20 =>  x"0000", --NOP 
			 21 =>  x"0000", --NOP 
			 22 =>	x"0000", --NOP 
			 23 =>	"0000000000000000", 
		 -- abaixo: casos omissos => (zero em todos os bits)
		 others => (others=>'0')
	);
begin
	process(clk)
	begin
		if (rising_edge(clk)) then
			data_s <= content_rom(to_integer(address));
		end if;
		
	end process;
	data<= data_s;
end architecture;
