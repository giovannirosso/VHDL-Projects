library ieee;
use ieee.std_logic_1164.all;

entity teste is
	port(x0 : in std_logic;
		 x1 : in std_logic;
		 x2 : in std_logic;
		 x3 : in std_logic;
		 y0 : out std_logic;
		 y1 : out std_logic;
		 y2 : out std_logic;
		 y3 : out std_logic
		 );
end entity;

architecture a_teste of teste is
begin
	y3 <= x3;
	y2 <= x2 and not x3;
	y1 <= x1 and not x2 and not x3;
	y0 <= x0 and not x1 and not x2 and not x3;
end architecture;