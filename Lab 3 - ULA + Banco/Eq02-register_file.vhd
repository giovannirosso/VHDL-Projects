--GIOVANNI DE ROSSO UNRUH
--ANDRIGO PIAI LIUCCI
--register file

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

entity register_file is
     port(
          --Controle do banco (write enable (we3), reset e clock):
          clk : in std_logic;
          rst : in std_logic;
          we3 : in std_logic;
          -- Seleção dos registradores:
          a1,a2: in unsigned(2 downto 0);
          --Selecao do registrador para escrita:
          a3: in unsigned(2 downto 0);
          --Barramento de dados para escrita:
          wd3:in unsigned(15 downto 0);
          --Saida:
          rd1,rd2: out unsigned(15 downto 0)
     );
end entity;

architecture a_register_file of register_file is
    component reg16bits is
         port(  clk : in std_logic;
                rst : in std_logic;
                wr_en : in std_logic;
                data_in : in unsigned(15 downto 0);
                data_out : out unsigned(15 downto 0)
    );
    end component;
    
    signal dataOUT_reg0 : unsigned (15 downto 0):= "0000000000000000";
    signal dataOUT_reg1 : unsigned (15 downto 0):= "0000000000000000";
    signal dataOUT_reg2 : unsigned (15 downto 0):= "0000000000000000";
    signal dataOUT_reg3 : unsigned (15 downto 0):= "0000000000000000";
    signal dataOUT_reg4 : unsigned (15 downto 0):= "0000000000000000";
    signal dataOUT_reg5 : unsigned (15 downto 0):= "0000000000000000";
    signal dataOUT_reg6 : unsigned (15 downto 0):= "0000000000000000";
    signal dataOUT_reg7 : unsigned (15 downto 0):= "0000000000000000";
    signal write_en0 : std_logic;
    signal write_en1 : std_logic;
    signal write_en2 : std_logic;
    signal write_en3 : std_logic;
    signal write_en4 : std_logic;
    signal write_en5 : std_logic;
    signal write_en6 : std_logic;
    signal write_en7 : std_logic;
    
begin
        
        reg0: reg16bits port map(clk=>clk,rst=>rst,wr_en=>write_en0,data_in=>"0000000000000000",data_out=>dataOUT_reg0);
        reg1: reg16bits port map(clk=>clk,rst=>rst,wr_en=>write_en1,data_in=>wd3,data_out=>dataOUT_reg1);
        reg2: reg16bits port map(clk=>clk,rst=>rst,wr_en=>write_en2,data_in=>wd3,data_out=>dataOUT_reg2);
        reg3: reg16bits port map(clk=>clk,rst=>rst,wr_en=>write_en3,data_in=>wd3,data_out=>dataOUT_reg3);
        reg4: reg16bits port map(clk=>clk,rst=>rst,wr_en=>write_en4,data_in=>wd3,data_out=>dataOUT_reg4);
        reg5: reg16bits port map(clk=>clk,rst=>rst,wr_en=>write_en5,data_in=>wd3,data_out=>dataOUT_reg5);
        reg6: reg16bits port map(clk=>clk,rst=>rst,wr_en=>write_en6,data_in=>wd3,data_out=>dataOUT_reg6);
        reg7: reg16bits port map(clk=>clk,rst=>rst,wr_en=>write_en7,data_in=>wd3,data_out=>dataOUT_reg7);
            
        rd1 <=  dataOUT_reg0 when a1 = "000" else
                dataOUT_reg1 when a1 = "001" else
                dataOUT_reg2 when a1 = "010" else
                dataOUT_reg3 when a1 = "011" else
                dataOUT_reg4 when a1 = "100" else
                dataOUT_reg5 when a1 = "101" else
                dataOUT_reg6 when a1 = "110" else
                dataOUT_reg7 when a1 = "111" else
                "0000000000000000";
                            
        rd2 <=  dataOUT_reg0 when a2 = "000" else
                dataOUT_reg1 when a2 = "001" else
                dataOUT_reg2 when a2 = "010" else
                dataOUT_reg3 when a2 = "011" else
                dataOUT_reg4 when a2 = "100" else
                dataOUT_reg5 when a2 = "101" else
                dataOUT_reg6 when a2 = "110" else
                dataOUT_reg7 when a2 = "111" else
                "0000000000000000";
                
        write_en0 <= we3 when a3 = "000" else '0';
        write_en1 <= we3 when a3 = "001" else '0';
        write_en2 <= we3 when a3 = "010" else '0';
        write_en3 <= we3 when a3 = "011" else '0';
        write_en4 <= we3 when a3 = "100" else '0';
        write_en5 <= we3 when a3 = "101" else '0';
        write_en6 <= we3 when a3 = "110" else '0';
        write_en7 <= we3 when a3 = "111" else '0';

end architecture;
