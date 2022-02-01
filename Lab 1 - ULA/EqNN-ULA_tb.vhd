--GIOVANNI DE ROSSO UNRUH
--ANDRIGO PIAI LIUCCI
--ULA

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; -- para usarmos UNSIGNED

entity ULA_tb is
end;

architecture a_ULA_tb of ULA_tb is
	component ULA
		port(op 	: in unsigned(1 downto 0);
			 in_A   : in unsigned(15 downto 0);
			 in_B	: in unsigned(15 downto 0);
			 flag	: out std_logic;
			 out_s  : out unsigned(15 downto 0)
			);
	end component;
	
	signal op : unsigned(1 downto 0);
	signal in_A,in_B,out_s : unsigned(15 downto 0);
	signal flag : std_logic;
	begin
		uut: ULA port map(	op => op,
							in_A => in_A,
							in_B => in_B,
							out_s => out_s,
							flag => flag);
	process
	begin
	in_A <= "0000000000000101";
	in_B <= "0000000000100010";
	op <= "00";
	wait for 50 ns;
	in_A <= "0000000000100001";
	in_B <= "0000000000000110";
	op <= "01";
	wait for 50 ns;
	in_A <= "0000000000001000";
	in_B <= "0000000000000010";
	op <= "10";
	wait for 50 ns;
	in_A <= "0000000000000111";
	in_B <= "0000000000000011";
	op <= "11";
	wait for 50 ns;
	in_A <= "0000000000010111";
	in_B <= "0000000010001111";
	op <= "11";
	wait for 50 ns;
	wait;
	end process;
end architecture;
	
	