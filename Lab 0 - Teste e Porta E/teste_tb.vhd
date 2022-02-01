library ieee;
use ieee.std_logic_1164.all;

entity teste_tb is
end;

architecture a_teste_tb of teste_tb is
	component teste
		port(x0 : in std_logic;
		 x1 : in std_logic;
		 x2 : in std_logic;
		 x3 : in std_logic;
		 y0 : out std_logic;
		 y1 : out std_logic;
		 y2 : out std_logic;
		 y3 : out std_logic
		);
	end component;
	
	signal x0,x1,x2,x3,y0,y1,y2,y3: std_logic;
	begin
		uut: teste port map(x0 => x0,
							x1 => x1,
							x2 => x2,
							x3 => x3,
							y0 => y0,
							y1 => y1,
							y2 => y2,
							y3 => y3);
	process
	begin
	x0 <= '0';
	x1 <= '0';
	x2 <= '0';
	x3 <= '0';
	wait for 50 ns;
	x0 <= '0';
	x1 <= '0';
	x2 <= '0';
	x3 <= '1';
	wait for 50 ns;
	x0 <= '0';
	x1 <= '0';
	x2 <= '1';
	x3 <= '0';
	wait for 50 ns;
	x0 <= '0';
	x1 <= '0';
	x2 <= '1';
	x3 <= '1';
	wait for 50 ns;
	x0 <= '0';
	x1 <= '1';
	x2 <= '0';
	x3 <= '0';
	wait for 50 ns;
	x0 <= '0';
	x1 <= '1';
	x2 <= '0';
	x3 <= '1';
	wait for 50 ns;
	x0 <= '0';
	x1 <= '1';
	x2 <= '1';
	x3 <= '0';
	wait for 50 ns;
	x0 <= '0';
	x1 <= '1';
	x2 <= '1';
	x3 <= '1';
	wait for 50 ns;
	x0 <= '1';
	x1 <= '0';
	x2 <= '0';
	x3 <= '0';
	wait for 50 ns;
	x0 <= '1';
	x1 <= '0';
	x2 <= '0';
	x3 <= '1';
	wait for 50 ns;
	x0 <= '1';
	x1 <= '0';
	x2 <= '1';
	x3 <= '0';
	wait for 50 ns;
	x0 <= '1';
	x1 <= '0';
	x2 <= '1';
	x3 <= '1';
	wait for 50 ns;
	x0 <= '1';
	x1 <= '1';
	x2 <= '0';
	x3 <= '0';
	wait for 50 ns;
	x0 <= '1';
	x1 <= '1';
	x2 <= '0';
	x3 <= '1';
	wait for 50 ns;
	x0 <= '1';
	x1 <= '1';
	x2 <= '1';
	x3 <= '0';
	wait for 50 ns;
	x0 <= '1';
	x1 <= '1';
	x2 <= '1';
	x3 <= '1';
	wait for 50 ns;
	wait;
	end process;
end architecture;
