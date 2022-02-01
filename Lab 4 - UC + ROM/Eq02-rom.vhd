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

architecture a_rom of rom is
	signal data_s: unsigned(15 downto 0):="0000000000000000";
	type mem is array (0 to 65536) of unsigned(15 downto 0);
	constant content_rom : mem := (
		 	 0 	=>  "0100001010001100", -- ROM_OUT: 428C
			 1 	=>  "0110001100010111", -- ROM_OUT: 4317
			 2 	=>  "1111000000000100", -- PULA PARA ENDERECO 4 
			 3 	=>  "0000000000000000", -- NOP
			 4 	=>  "0000000000000001", -- ROM_OUT: 1
			 5 	=>  "0000000000000010", -- ROM_OUT: 2
			 6 	=>  "0000000000000011", -- ROM_OUT: 3
			 7 	=>  "0000000000000100", -- ROM_OUT: 4
			 8  =>  "0000000000000000", -- NOP
			 9 	=>  "0000000000000000", -- NOP
			 10 =>  "0000000000000000", -- NOP
			 11 =>  "0000000000000000", -- NOP  
			 12 =>  "0000000000000000", -- NOP  
			 13 =>  "0000000000000000", -- NOP 
			 14 =>  "0000000000000000", -- NOP  
			 15 =>  "0000000000000000", -- NOP  
			 16 =>  "0000000000000000", -- NOP  
			 17 =>  "1111000000000000", -- PULA PARA ENDERECO 0 
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
