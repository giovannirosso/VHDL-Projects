library ieee;
use ieee.std_logic_1164.all;

entity mux4x1_tb is
end;

architecture a_mux4x1_tb of mux4x1_tb is
	component mux4x1
		port(sel0 	: in std_logic;
			 sel1   : in std_logic;
			 entr0	: in std_logic;
			 entr1	: in std_logic;
			 entr2  : in std_logic;
			 entr3	: in std_logic;
			 saida	: out std_logic 
			);
	end component;
	
	signal sel0,sel1,entr0,entr1,entr2,entr3,saida: std_logic;
	begin
		uut: mux4x1 port map(sel0 => sel0,
							 sel1 => sel1,
							 entr0 => entr0,
							 entr1 => entr1,
							 entr2 => entr2,
							 entr3 => entr3,
							 saida => saida);
	process
	begin
	entr0 <= '1';
	entr1 <= '1';
	entr2 <= '1';
	entr3 <= '1';
	sel0 <= '0';
	sel1 <= '0';
	wait for 50 ns;
	sel0 <= '1';
	sel1 <= '0';
	wait for 50 ns;
	sel0 <= '0';
	sel1 <= '1';
	wait for 50 ns;
	sel0 <= '1';
	sel1 <= '1';
	wait for 50 ns;
	wait;
	end process;
end architecture;
	
	