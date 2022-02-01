library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; -- para usarmos UNSIGNED

entity mux2x1_tb is
end;

architecture a_mux2x1_tb of mux2x1_tb is
	component mux2x1
		port(sel0 	: in std_logic;
			 entr0	: in unsigned(7 downto 0);
			 entr1	: in unsigned(7 downto 0);
			 saida	: out unsigned(7 downto 0)
			);
	end component;
	
	signal sel0 : std_logic;
	signal entr0,entr1,saida : unsigned(7 downto 0);
	begin
		uut: mux2x1 port map(sel0 => sel0,
							 entr0 => entr0,
							 entr1 => entr1,
							 saida => saida);
	process
	begin
	entr0 <= "01010101";
	entr1 <= "10101010";
	sel0 <= '0';
	wait for 50 ns;
	sel0 <= '1';
	wait for 50 ns;
	wait;
	end process;
end architecture;
	