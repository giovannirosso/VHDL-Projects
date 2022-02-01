--GIOVANNI DE ROSSO UNRUH
--ANDRIGO PIAI LIUCCI
--ULA

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; -- para usarmos UNSIGNED

entity ULA is
	port(op							: in unsigned(1 downto 0);
		 in_A						: in unsigned(15 downto 0);
		 in_B						: in unsigned(15 downto 0);
		 flag						: out std_logic;
		 out_s						: out unsigned(15 downto 0)
		);
end entity;

architecture ULA of ULA is
begin
	out_s <= in_A + in_B when op="00" else --SOMA
			 in_A - in_B when op="01" else --SUBT
			 in_A / in_B when op="10" else --DIVI
			 "0000000000000000";
	flag <=  '1' when in_A>in_B and op="11" else --MAIOR DO Q
			 '0' when in_A<=in_B and op="11" else
			 'U';
end architecture;
	