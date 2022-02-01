--GIOVANNI DE ROSSO UNRUH
--ANDRIGO PIAI LIUCCI
--UNIDADE DE CONTROLE

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity controlUnit is
	port (	clk : in std_logic;
			rst : in std_logic;
			controlUnit_out : out unsigned(15 downto 0)
		);
end entity;

architecture a_controlUnit of controlUnit is
	component pc is
		port (	clk : in std_logic;
				write_en : in std_logic;
				rst : in std_logic;
				data_in : in unsigned(15 downto 0);
				data_out : out unsigned(15 downto 0)
			);
	end component;

	component rom is
		port( clk : in std_logic;
			  address : in unsigned(15 downto 0);
			  data : out unsigned(15 downto 0)
			);
	end component;

	component maquinaEstados is
		port (	clk : in std_logic;
				rst : in std_logic;
				estado : out std_logic
			);
	end component;

	signal data_rom_out: unsigned(15 downto 0):="0000000000000000";
	signal data_in_s, data_outPC_s, address_rom: unsigned(15 downto 0):="0000000000000000";
	signal estado_s, jump_en: std_logic:='0';
	signal opcode: unsigned (3 downto 0):="0000";
	signal jump_address: unsigned(11 downto 0):="000000000000";


begin

	pc_c: pc port map (clk => clk, write_en => estado_s, rst => rst, data_in => data_in_s, data_out => data_outPC_s);
	rom_c: rom port map (clk => clk, address=> address_rom, data => data_rom_out);
	Maq_estados: maquinaEstados port map(clk => clk, rst => rst, estado => estado_s);

	opcode <= data_rom_out(15 downto 12); 

	jump_en <= 	'1' when opcode = "1111" else -- jump 1111
				'0';						  -- nop 0000

	jump_address <= data_rom_out(11 downto 0);

	address_rom <= data_outPC_s when estado_s = '0' else
				   address_rom;

	data_in_s <= data_outPC_s + 1 when estado_s = '1' and jump_en = '0' else
				 "0000" & jump_address when estado_s = '1' and jump_en = '1' else
				 data_outPC_s;

	controlUnit_out <= data_rom_out;

end architecture;
