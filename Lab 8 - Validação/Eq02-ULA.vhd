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

architecture a_ula of ula is

signal result: 	unsigned(15 downto 0):=x"0000";
signal flag_s:	unsigned(7 downto 0):=x"00";

-- 000 NOP				|		-- |7|6|5|4|3|2|1|0|	->	bits
-- 001 soma				|		-- |V|1|1|H|I|N|Z|C|	->	flags
-- 010 subtracao		|		-- V -> overflow
-- 011 divisao			|		-- H -> half-carry
-- 100 CMP in_A in_B	|		-- I -> interrupt mask
-- 101 in_A >= in_B		|		-- N -> negative flag
-- 110 in_A < in_B		|		-- Z -> zero flag
-- 111 in_A <= in_B		|		-- C -> carry

begin		
	result 	<=	in_A+in_B when op="001" else
				in_A-in_B when op="010" or op="100" else
	 			in_A/in_B when op="011" else
	 			x"0000";

	flag_s(7) <= '1' when op="001" and result(15) = '0' and in_A(15) = '1' and in_B(15) = '1' else				--OVERFLOW
				 '1' when op="001" and result(15) = '1' and in_A(15) = '1' and in_B(15) = '0' else
				 '1' when op="100" and result(15) = '0' and in_A(15) = '1' and in_B(15) = '0' else
				 '1' when op="100" and result(15) = '1' and in_A(15) = '0' and in_B(15) = '1' else
				 flag_s(7);

	flag_s(6) <= '1';--não implementado

	flag_s(5) <= '1';--não implementado
				
	flag_s(4) <= '1' when op="001" and in_A(7) = '1' and in_B(7) = '1' else										--FLAG HALF CARRY
				 '1' when op="001" and result(7) = '0' and in_A(7) = '1' else									--P/ OP DE 3 E 4 BITS
				 '1' when op="001" and result(7) = '0' and in_B(7) = '1' else									--N TESTEI
				 flag_s(4);
				
	flag_s(3) <= '1';																							--Interrupt Mask não implementado
				
	flag_s(2) <= result(15) when op="001" else																	--FLAG NEGATIVO
				 result(15) when op="010" else --VERIFICAR
				 result(15) when op="011" else --VERIFICAR
				 result(15) when op="100" else
				 '1' when op="100" and result(15)='1' else
				 flag_s(2);		
				
	flag_s(1) <= 	'1' when result(15) = '0' and result(14) = '0' and result(13) = '0' and result(12) = '0' and result(11) = '0' and result(10) = '0' and result(9) = '0' and result(8) = '0' and result(7) = '0' and result(6) = '0' and result(5) = '0' and result(4) = '0' and result(3) = '0' and result(2) = '0' and result(1) = '0' and result(0) = '0' else
					'0';					  
				
	flag_s(0) <= '1' when op="001" and in_A(15) = '1' and in_B(15) = '1' else									--FLAG CARRY
				 '1' when op="001" and result(15) = '0' and in_A(15) = '1' else
				 '1' when op="001" and result(15) = '0' and in_B(15) = '1' else
				 '1' when op="100" and result(15) = '1' and in_B(15) = '1' else
				 '1' when op="101" and in_A >= in_B else
				 '1' when op="110" and in_A < in_B else
				 '1' when op="111" and in_A <= in_B else
				 flag_s(0);
				 
	out_s<=result;
	flag <= flag_s when op="100";
	
end architecture ;
	