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
	--BGT		--92		--Valor relativo 8 bits					-- Realiza o desvio se o flag indicar Maior Que
	--BEQ		--27		--Valor relativo 8 bits					-- Realiza o desvio se o flag indicar Igualdade
	--LDR		--D1		--Registrador X		--posição da RAM	-- Carega o valor da RAM p/ Rx
	--STR		--D2		--Registrador X		--posição da RAM	-- Escreve o valor RX na ram
	--LDA		--A			--Registrador X		--Valor Até FF		-- Escrita no registradodor especial até FF (Opcode especial para facilitar nossa vida)
	
architecture a_rom of rom is
	signal data_s: unsigned(15 downto 0):="0000000000000000";
	type mem is array (0 to 1024) of unsigned(15 downto 0);
	constant content_rom : mem := (
			 0	=> 	x"0000", --	NOP
		 	 1 	=>  x"A501", -- LDA r5, #1 	--CARREGA r5 COM 1			 
		 	 2 	=>  x"A620", -- LDA r6, #32 --CARREGA r1 COM 32 
			 3 	=>  x"FB75", -- ADD #1	
			 4  =>	x"F770", -- STA r7
			 5 	=>  x"D277", -- STX r7, [r7]--Armazena r7 em [r7]
			 6 	=>  x"F106", -- CMP r6		--COMPARA Acc COM r6
			 7 	=>  x"91FC", -- BLT #-4	
			 
							 -- Todas as posiçoes da ram de 0 a 32 estão prenchidas com 0 a 32
							 -- Agr começa a remoção de multiplos
							 
			 8 	=>  x"A102", -- LDA r1, #2
			 9 	=>  x"A202", -- LDA r2, #2
			 10 =>  x"FB12", -- ADD r1 r2
			 11 =>  x"F710", -- STA r1
			 12 =>  x"D201", -- STR r0 [r1]
			 13 =>  x"F106", -- CMP r6
			 14 =>  x"91FC", -- BLT -4
			 
							-- Multiplos de 2 removidos agr de 3
							
			 15 =>  x"A103", -- LDA r1, #3
			 16 =>  x"A203", -- LDA r2, #3
			 17 =>  x"FB12", -- ADD r1 r2
			 18 =>  x"F710", -- STA r1
			 19 =>  x"D201", -- STR r0 [r1]
			 20 =>  x"F106", -- CMP r6
			 21 =>  x"91FC", -- BLT -4
			 
							-- Multiplos de 3 removidos agr de 5
							
			 22 =>	x"A105", -- LDA r1, #5
			 23 =>	x"A205", -- LDA r2, #5
			 24 =>	x"FB12", -- ADD r1 r2
			 25 =>	x"F710", -- STA r1
			 26 =>	x"D201", -- STR r0 [r1]
			 27 =>	x"F106", -- CMP r6
			 28 =>	x"91FC", -- BLT -4
			 
							-- Multiplos de 5 removidos agr salvar os primos
			 29 =>	x"A47F", -- LDA r4, #127
			 30 =>	x"A102", -- LDA r1, #2
			 31 =>	x"D112", -- LDR r2 [r1]
			 32 =>	x"A300", -- LDA r3, #0
			 33 =>	x"F102", -- CMP r2			---compara valor acumulador 0, com r2
			 34 =>	x"2702", -- BEQ +2
			 35 =>	x"D224", -- STR r2 [r7]
			 36 =>	x"FB15", -- ADD r1 r5
			 37 =>	x"F710", -- STA r1
			 38 =>	x"CC1F", -- JMp 31
			 39 =>	x"0000", -- 
			 40 =>	x"0000", -- 
			 41 =>	x"0000", -- 
			 42 =>	x"0000", -- 
			 43 =>	x"0000", -- 
			 44 =>	x"0000", -- 
			 45 =>	x"0000", -- 
			 46 =>	x"0000", -- 
			 47 =>	x"0000", -- 
			 48 =>	x"0000", -- 
			 49 =>	x"0000", -- 
			 50 =>	x"0000", -- 
			 51 =>	x"0000", -- 
			 52 =>	x"0000", -- 
			 53 =>	x"0000", -- NOP
		 -- abaixo: casos omissos => (zero em todos os bits)
			
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
