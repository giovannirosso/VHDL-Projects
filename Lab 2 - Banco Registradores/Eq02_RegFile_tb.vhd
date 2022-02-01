--GIOVANNI DE ROSSO UNRUH
--ANDRIGO PIAI LIUCCI
--LAB 2

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; -- para usarmos UNSIGNED

entity register_file_tb is
end;

architecture a_register_file_tb of register_file_tb is
	component register_file
	 port(clk : in std_logic;
		  rst : in std_logic;
		  we3 : in std_logic;
		  a1,a2,a3: in unsigned(2 downto 0);
		  wd3:in unsigned(15 downto 0);
		  rd1,rd2: out unsigned(15 downto 0)
);
end component;
	signal clk,rst,we3: std_logic;
	signal a1,a2,a3: unsigned(2 downto 0);
	signal wd3,rd1,rd2: unsigned(15 downto 0);
	
begin

	uut: register_file port map(clk=>clk,
								rst=>rst,
								we3=>we3,
								a1=>a1,
								a2=>a2,
								a3=>a3,
								wd3=>wd3,
								rd1=>rd1,
								rd2=>rd2);
	process -- sinal de clock
	begin
		clk <= '0';
		wait for 50 ns;
		clk <= '1';
		wait for 50 ns;
	end process;
	
	process -- sinal de reset
	begin
		rst <= '1';
		wait for 100 ns;
		rst <= '0';
		wait for 1500 ns;
		rst <= '1';
		wait for 100 ns;
		rst <= '0';
		wait;
	end process;
	
	process -- sinais dos casos de teste
	begin
		we3 <= '0';
		a1<="000";
		a2<="000";
		a3<="000";
		wd3<="0000000000000000";
		wait for 100 ns;
		wd3 <= "1111111111111111";
		a1<="001";
		a2<="010";
		a3<="001";
		wait for 100 ns;
		wd3 <= "1000110110001101";
		a1<="010";
		a2<="001";
		a3<="010";
		wait for 100 ns;
		
		we3 <= '1';
		wd3 <= "1111111100000000";
		a1<="000";
		a2<="111";
		a3<="111";
		wait for 100 ns;
		wd3 <= "1000000000000001";
		a1<="001";
		a2<="110";
		a3<="110";
		wait for 100 ns;
		wd3 <= "0000000000000001";
		a1<="010";
		a2<="101";
		a3<="101";
		wait for 100 ns;
		wd3 <= "1000000000001111";
		a1<="011";
		a2<="100";
		a3<="100";
		wait for 100 ns;
		wd3 <= "1000000001001001";
		a1<="100";
		a2<="011";
		a3<="011";
		wait for 100 ns;
		wd3 <= "0001000000000010";
		a1<="101";
		a2<="010";
		a3<="010";
		wait for 100 ns;
		wd3 <= "1111110000000000";
		a1<="110";
		a2<="001";
		a3<="001";
		wait for 100 ns;
		wd3 <= "0101111010110010";
		a1<="111";
		a2<="000";
		a3<="000";
		wait for 100 ns;

		we3 <= '0';
		a1<="000";
		a2<="001";
		a3<="000"; 
		wait for 100 ns;
		a1<="010";
		a2<="011";
		a3<="001";
		wait for 100 ns;
		a1<="100";
		a2<="101";
		a3<="010";
		wait for 100 ns;
		a1<="110";
		a2<="111";
		a3<="011";
		wait for 100 ns;
		a1<="000";
		a2<="001";
		a3<="100";
		wait for 100 ns;
		a1<="010";
		a2<="011";
		a3<="101";
		wait for 100 ns;
		a1<="100";
		a2<="101";
		a3<="110";
		wait for 100 ns;
		a1<="110";
		a2<="111";
		a3<="111";
		wait for 100 ns;
		
		wait;
 end process;
end architecture;