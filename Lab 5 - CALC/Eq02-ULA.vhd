--GIOVANNI DE ROSSO UNRUH
--ANDRIGO PIAI LIUCCI
--ULA

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; -- para usarmos UNSIGNED

entity ULA is
	port(op							: in unsigned(2 downto 0);
		 in_A						: in unsigned(15 downto 0);
		 in_B						: in unsigned(15 downto 0);
		 flag 					    : out unsigned(7 downto 0);
		 out_s						: out unsigned(15 downto 0)
		);
end entity;

-- 000 NOP
-- 001 soma
-- 010 subtracao
-- 011 divisao
-- 100 in_A > in_B
-- 101 in_A >= in_B
-- 110 in_A < in_B
-- 111 in_A <= in_B

architecture a_ULA of ULA is
signal result: unsigned(15 downto 0 );
begin
	result 	<=	in_A+in_B when op="001" else
				in_A-in_B when op="010" else
	 			in_A/in_B when op="011" else
			 	"0000000000000000";
	flag(7) <= 	'1' when op="110" and not result(15) = '1' and in_A(15) = '1' and in_B(15) = '1' else
				'0';
	flag(1) <= 	'1' when not result(15) = '1' and 
						 not result(14) = '1' and 
						 not result(13) = '1' and 
						 not result(12) = '1' and 
						 not result(11) = '1' and 
						 not result(10) = '1' and 
						 not result(9) = '1' and 
						 not result(8) = '1' and 
						 not result(7) = '1' and 
						 not result(6) = '1' and 
						 not result(5) = '1' and 
						 not result(4) = '1' and 
						 not result(3) = '1' and 
						 not result(2) = '1' and 
						 not result(1) = '1' and 
						 not result(0) = '1' else
				'0';
	flag(0) <= 	'1' when op="100" and in_A > 	in_B else
				'1'	when op="101" and in_A >= 	in_B else
				'1'	when op="110" and in_A < 	in_B else
				'1'	when op="111" and in_A <= 	in_B else
				'0';
	out_s<=result;
end architecture;
	