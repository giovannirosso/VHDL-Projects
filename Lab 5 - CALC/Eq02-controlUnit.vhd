--GIOVANNI DE ROSSO UNRUH
--ANDRIGO PIAI LIUCCI
--UNIDADE DE CONTROLE

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity controlUnit is
	port( clk : in std_logic;
		  rst : in std_logic;
		  controlUnit_out : out unsigned(15 downto 0)
		);
end entity;

architecture a_controlUnit of controlUnit is

	component pc is
		port( clk : in std_logic;
			  write_en : in std_logic;
			  rst : in std_logic;
			  data_in : in unsigned(15 downto 0);
			  data_out : out unsigned(15 downto 0)
			);
	end component;

	component rom is
		port( clk,rst : in std_logic;
			  address : in unsigned(15 downto 0);
			  data : out unsigned(15 downto 0)
			);
	end component;

	component maquinaEstados is
		port( clk : in std_logic;
			  rst : in std_logic;
			  estado : out unsigned(1 downto 0)
			);
	end component;
	
	component register_file is
		port( clk	: in std_logic; -- clock
			  rst 	: in std_logic; -- reset
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
		port( in_A : in unsigned(15 downto 0);
			  in_B : in unsigned(15 downto 0);
			  op   : in unsigned(2 downto 0); 
			  flag  : out unsigned(7 downto 0);
			  out_s : out unsigned(15 downto 0)
			);
	end component;
	
	component acumulador is
		port( clk	: in std_logic;	-- Clock
			  rst	: in std_logic;	-- Reset
			  ACC_wr_en	: in std_logic;
			  ACC_data_in	:in unsigned(15 downto 0);	-- Entrada de dados
			  ACC_data_out	: out unsigned(15 downto 0)	-- Saida de dados
			);
	end component;
		
---------------------------------------------------------------------------------

	signal data_rom_out		: unsigned(15 downto 0):= "0000000000000000";
	signal data_in_s		: unsigned(15 downto 0):= "0000000000000000"; 
	signal data_outPC_s		: unsigned(15 downto 0):= "0000000000000000"; 
	signal address_rom		: unsigned(15 downto 0):= "0000000000000000";
	signal we3_s			: std_logic:= '0';		--Write enable
	signal jump_en			: std_logic:= '0';		--Jump enable
	signal opcode			: unsigned (7 downto 0):= "00000000";
	signal jump_address		: unsigned(15 downto 0):= "0000000000000000";
	signal a1_s				: unsigned(2 downto 0):= "000"; 
	signal a2_s				: unsigned(2 downto 0):= "000"; 
	signal a3_s				: unsigned(2 downto 0):= "000"; 
	signal rd1_s			: unsigned(15 downto 0):= x"0000"; 
	signal rd2_s			: unsigned(15 downto 0):= x"0000"; 
	signal wd3_s			: unsigned(15 downto 0):= x"0000";
	signal ula_src_A_s		: unsigned(15 downto 0):= x"0000";
	signal ula_src_B_s		: unsigned(15 downto 0):= x"0000";
	signal ula_op_s			: unsigned(2 downto 0):= "000";
	signal flag_s			: unsigned(7 downto 0):= x"00";
	signal out_s			: unsigned(15 downto 0):= x"0000";
	signal writePC_s		: std_logic:='0';
	signal ULAsrcBsel		: std_logic:='0'; 
	signal a3srcSel			: std_logic:='0';
	signal wd3srcSel		: std_logic:='0';
	signal signalext		: unsigned(15 downto 0):= x"0000";
	signal estado_s			: unsigned(1 downto 0):= "00";
	signal ACC_wr_en_s		: std_logic:= '0';
	signal ACC_data_in_s	: unsigned(15 downto 0):= x"0000";
	signal ACC_data_out_s	: unsigned(15 downto 0):= x"0000";
	
begin

--Port Map-----------------------------------------------------------------------
---------------------------------------------------------------------------------
	pc_c: pc port map (clk => clk, 
					   write_en => writePC_s, 
					   rst => rst, 
					   data_in => data_in_s, 
					   data_out => data_outPC_s);
					   
	rom_c: rom port map (clk => clk, rst => rst, 
						 address => address_rom, 
						 data => data_rom_out);
						 
	Maq_estados: maquinaEstados port map(clk => clk, 
										 rst => rst, 
										 estado => estado_s);

	reg_file: register_file port map(clk => clk, 
									 rst => rst, 
									 we3 => we3_s, 
									 wd3 => wd3_s, 
									 a3 => a3_s, 
									 a1 => a1_s, 
									 a2 => a2_s, 
									 rd1 => rd1_s, 
									 rd2 => rd2_s);
									 
	ula_c: ULA port map(in_A => ula_src_A_s,
						in_B => ula_src_B_s, 
						op => ula_op_s, 
						flag => flag_s, 
						out_s => out_s);
						
	ACC_c: acumulador port map(clk => clk,
							   rst => rst,
							   ACC_wr_en => ACC_wr_en_s,
							   ACC_data_in => ACC_data_in_s,
							   ACC_data_out => ACC_data_out_s);
	
--Sinais-------------------------------------------------------------------------
---------------------------------------------------------------------------------
	-- 8 bits de OPCODE
	opcode 	<= 	data_rom_out(15 downto 8) when estado_s="00"; 
	
	-- 8 bits de DADOS	
	--instr		--OP(8bits)	--(4bits)			--(4bits)			--
				--(15-8)	--(7-4)				--(3-0)
	--NOP		--9D		--x					--x					-- NOP
	--LDX		--DE		--Registrador X		--Imm 4 bits		-- Carrega valor inteiro no Registrador X
	--ADD		--FB		--Registrador X		--Registrador Y		-- Soma RX e RY p/ Acumulador
	--STA		--F7		--Registrador X		--x					-- Salva valor Acumulador p/ Registrador X
	--SUB		--D0		--Registrador X		--Registrador Y		-- Subtrai RX e RY p/ Acumulador
	--JMP		--CC		--Imm 8 bits							-- Salta para o endereço
	--MOV		--5E		--Registrador X		--Registrador Y		-- Copia valor de Registrador Y p/ Registrador X
	
	signalext <= x"0000" when (opcode = x"9D") and estado_s = "00" else --NOP
				 x"000" & data_rom_out(3 downto 0) when (opcode = x"DE") and estado_s = "00" else --LDX
				 x"0000" when (opcode = x"FB") and estado_s = "00" else --ADD
				 x"0000" when (opcode = x"F7") and estado_s = "00" else --STA
				 x"0000" when (opcode = x"D0") and estado_s = "00" else --SUB
				 x"00" & data_rom_out(7 downto 0) when (opcode = x"CC") and estado_s = "00" else --JMP
				 x"0000" when (opcode = x"5E") and estado_s = "00" else --MOV
				 signalext;


	a1_s 	<= 	"000" when (opcode=x"DE" or opcode=x"F7")  else
				data_rom_out(6 downto 4) when (opcode=x"5E") else
				data_rom_out(6 downto 4) when (opcode=x"FB") else
				data_rom_out(6 downto 4) when (opcode=x"D0") else
				a1_s;
				
	a2_s 	<=	data_rom_out(2 downto 0) when (opcode=x"5E") else
				data_rom_out(2 downto 0) when (opcode=x"D0") else
				data_rom_out(2 downto 0) when (opcode=x"FB") else
				"000";

	a3_s 	<=  data_rom_out(6 downto 4) when opcode=x"F7" else
				data_rom_out(6 downto 4) when opcode=x"DE" else
				data_rom_out(6 downto 4) when opcode=x"5E" else
				"000" ; 

	jump_en <= 	'1' when opcode=x"CC" and rst /= '1' else 	-- jump CC
				'0';						 				-- nop 

	jump_address <= signalext when  rst /= '1' else
					x"0000";

	ULAsrcBsel <= '1' when opcode = x"DE" else
				  '0';
	
	ACC_data_in_s <= out_s;  --Acumulador recebe saida da ULA
	
	ACC_wr_en_s <= '1' when (opcode = x"DE" or opcode = x"FB" or opcode = x"D0") else
				   '0';
	
	wd3_s <= ACC_data_out_s when opcode = x"F7" else --wd3 recebe saida do acumulador quando pede pra salvar
			 ACC_data_out_s when opcode = x"DE" and ACC_wr_en_s = '1' else
			 ACC_data_out_s when opcode = x"D0" and ACC_wr_en_s = '1' else
			 ACC_data_out_s when opcode = x"FB" and ACC_wr_en_s = '1';


	ula_op_s <= "001" when (opcode=x"F7" or opcode=x"DE" or opcode=x"5E") else 	--STA(F7) LDX(DE) e MOV(5E)
				"001" when (opcode=x"FB") else	--soma ADD
				"010" when (opcode=x"D0") else	--sub SUB
				"000";	--nop
				
	ula_src_A_s <= rd1_s;
	
	ula_src_B_s <= rd2_s when ULAsrcBsel='0' else
					signalext;


	we3_s <= 	'1' when opcode=x"DE"  and estado_s="10" else
				'1' when opcode=x"FB"  and estado_s="10" else
				'1' when opcode=x"F7" else
				'1' when opcode=x"D0"  and estado_s="10" else
				'1' when opcode=x"CC"  and estado_s="10" else
				'1' when opcode=x"5E"  and estado_s="10" else
			 	'0';
				
	writePC_s <= '1' when estado_s="01" else
				 '0';

	address_rom <= data_outPC_s when estado_s="10" or rst /= '0' else
				   address_rom;
	
	data_in_s <= data_outPC_s + 1 when estado_s="01" and jump_en='0' else
				 jump_address when estado_s="01" and jump_en='1' else
				 data_outPC_s;
				 
	controlUnit_out <= data_rom_out;

end architecture;
