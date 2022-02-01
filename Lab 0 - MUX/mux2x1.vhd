library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; -- para usarmos UNSIGNED

entity mux2x1 is
	port(sel0				: in std_logic;
		 entr0,entr1		: in unsigned(7 downto 0);
		 saida				: out unsigned(7 downto 0) --sem ponto e virgula
		);
end entity;

architecture a_mux2x1 of mux2x1 is
begin
	saida <= entr0 when sel0='0' else
			 entr1 when sel0='1' else
			 "00000000";
end architecture;