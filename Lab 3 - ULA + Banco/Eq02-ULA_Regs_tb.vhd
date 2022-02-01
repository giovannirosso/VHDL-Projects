--GIOVANNI DE ROSSO UNRUH
--ANDRIGO PIAI LIUCCI

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ULA_Regs_tb is
end entity;

architecture a_ULA_Regs_tb of ULA_Regs_tb is
	component ULA_Regs
	port( clk		: in std_logic; -- clock
		  rst 		: in std_logic; -- reset
		  we3: 	 in std_logic;	-- write enable
		  wd3: 	 in unsigned(15 downto 0); -- valor a ser escrito em write_reg
		  a3 : 	 in unsigned(2 downto 0); -- registrador a ser escrito
		  a1: 	 in unsigned(2 downto 0); -- entrada de dados
		  a2: 	 in unsigned(2 downto 0); -- entrada de dados
		  op:	 in unsigned(1 downto 0);
		  flag:  out std_logic; -- saida de dados
		  out_s: out unsigned(15 downto 0) -- saida de dados
		);
	end component;

	signal clk, rst, we3, flag : std_logic:='0';
	signal a3, a2, a1: unsigned(2 downto 0):="000";
	signal op: unsigned(1 downto 0):="00";
	signal wd3, out_s: unsigned(15 downto 0):="0000000000000000";

begin
	uut: ULA_Regs port map 	(	clk => clk,
								rst => rst,
								we3  => we3,
								wd3 => wd3,
								a3 => a3,
								a1 => a1,
								a2 => a2,
								op => op,
								out_s => out_s,
								flag => flag
								);
	process
	begin
		clk <= '0';
		wait for 50 ns;
		clk <= '1';
		wait for 50 ns;
	end process;

	process -- sinal de reset
	begin
		rst <= '0';
		wait for 10 ns;
		rst <= '1';
		wait for 10 ns;
		rst <= '0';
		wait for 600 ns;
		rst <= '1';
		wait for 10 ns;
		rst <= '0';
		wait;
	end process;
	
	--	"00"	--SOMA
	--	"01"	--SUBT
	--	"10"	--DIVI
	--	"11"	--MAIOR DO Q
	process -- sinais dos casos de teste
	begin
		-- nada
		we3  <= '0';
		a3 <= "000";
		a1 <= "000";
		a2 <= "000";
		wd3 <= "0000000000000000";
		op <= "00";
		wait for 100 ns;
		-- escreve no reg1
		we3  <= '1';
		a3 <= "001";
		a1 <= "001";
		a2 <= "010";
		wd3 <= "0000000000000011";
		op <= "00";
		wait for 100 ns;
		-- escreve no reg2
		we3  <= '1';
		a3 <= "010";
		a1 <= "001";
		a2 <= "010";
		wd3 <= "0000000000001000";
		--op <= "00";
		wait for 100 ns;
		-- SOMA REG1 e REG2 E TENTA ESCREVER NO REG0
		we3  <= '1';
		a3 <= "000";
		a1 <= "001";
		a2 <= "010";
		wd3 <= "0000000000000000";
		op <= "00";
		wait for 100 ns;
		-- FAZ subtracao DE REG2-REG1 E SALVA EM REG3
		we3  <= '1';
		a3 <= "011";
		a1 <= "010";
		a2 <= "001";
		wd3 <= "1111111111111111";
		op <= "01";
		wait for 100 ns;
		-- Verificar reg3 
		we3  <= '0';
		a3 <= "000";
		a1 <= "011";
		a2 <= "001";
		wd3 <= "0000000000000000";
		op <= "11";
		wait for 100 ns;
		-- mostra o mesmo registrador (reg1) na saida A e B (depois do rst deve ser "0000000000000000")
		we3  <= '0';
		a3 <= "000";
		a1 <= "011";
		a2 <= "001";
		wd3 <= "0000000000000000";
		op <= "11";
		wait;
	end process;

end architecture;