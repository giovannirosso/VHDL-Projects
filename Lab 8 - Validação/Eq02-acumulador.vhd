--GIOVANNI DE ROSSO UNRUH
--ANDRIGO PIAI LIUCCI
--acumulador

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity acumulador is
	port( clk	: in std_logic;	-- Clock
		  rst	: in std_logic;	-- Reset
		  ACC_wr_en	: in std_logic;
		  ACC_data_in	:in unsigned(15 downto 0);	-- Entrada de dados
		  ACC_data_out	: out unsigned(15 downto 0)	-- Saida de dados
	);
end entity;

architecture a_acumulador of acumulador is
	signal registro: unsigned(15 downto 0);
begin
	
	process(clk,rst,ACC_wr_en)
	begin
		if rst='1' then
			registro <= "0000000000000000";
		elsif ACC_wr_en='1' then
			if rising_edge(clk) then
				registro <= ACC_data_in;
			end if;
		end if;
	end process;
	
	ACC_data_out <= registro;
end architecture;

