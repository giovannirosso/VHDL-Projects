--GIOVANNI DE ROSSO UNRUH
--ANDRIGO PIAI LIUCCI
--ULA_Regs.vhd

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ULA_Regs is
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
end entity;

architecture a_ULA_Regs of ULA_Regs is
	signal data_w, data_in_a1, data_in_a2, data_out_s: unsigned(15 downto 0);
	component register_file is
		port( clk		: in std_logic; -- clock
			  rst 		: in std_logic; -- reset
			  we3	: in std_logic;	-- write enable
			  wd3: in unsigned(15 downto 0); -- valor a ser escrito em write_reg
			  a3 : in unsigned(2 downto 0); -- registrador a ser escrito
			  a1: in unsigned(2 downto 0); -- entrada de dados
			  a2: in unsigned(2 downto 0); -- entrada de dados
			  rd1: out unsigned(15 downto 0); -- saida de dados
			  rd2: out unsigned(15 downto 0) -- saida de dados
			);
	end component;
	component ULA is 
	port(
		in_A : in unsigned(15 downto 0);
		in_B : in unsigned(15 downto 0);
		op   : in unsigned(1 downto 0); -- bits de seleção num só bus
		flag  : out std_logic;
		out_s : out unsigned(15 downto 0)
		);
	end component;
begin


	reg_file: 	register_file port map(clk => clk, rst => rst, we3 => we3, wd3 => data_w, a1 => a1, a2 => a2, a3 => a3, rd1 => data_in_a1, rd2 => data_in_a2);
	ula1: 		ULA port map(in_A => data_in_a1, in_B => data_in_a2, op => op, flag=>flag, out_s=>data_out_s);

data_w	<= 	data_out_s when op = "01" else
			wd3;
out_s<=data_out_s;
end architecture;