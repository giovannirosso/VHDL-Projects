--GIOVANNI DE ROSSO UNRUH
--ANDRIGO PIAI LIUCCI
--Processador TB

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity processador_tb is

end entity;


architecture a_processador_tb of processador_tb is

component processador is
	port (	clk : in std_logic;
			rst : in std_logic;
			controlUnit_out : out unsigned(15 downto 0)
		);
end component;


	signal clk, rst: std_logic:='0';
	signal controlUnit_out: unsigned(15 downto 0):="0000000000000000";
begin
	uut: processador port map(clk => clk, rst => rst, controlUnit_out => controlUnit_out);

	process -- clk 100 ns
	begin
		clk <= '0';
		wait for 50 ns;
		clk <= '1';
		wait for 50 ns;
	end process;

	process -- reset
	begin
		rst <= '1';
		wait for 10 ns;
		rst <= '0';
		wait for 277000 ns;
		rst <= '1';
		wait for 10 ns;
		rst <= '0';
		wait;
	end process;

	process
	begin
		wait for 100 ns;
		wait;
	end process;


end architecture;
