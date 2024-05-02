library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg_bd is
    port(
        read_r0: in unsigned(2 downto 0);
        read_r1: in unsigned(2 downto 0);
        write_enable: in std_logic;
        write_register: in unsigned(2 downto 0);
        write_data: in unsigned(15 downto 0);
        clk: in std_logic;
        rst: in std_logic;
        read_data0: out unsigned(15 downto 0); 
        read_data1: out unsigned(15 downto 0)
    );
end entity;

architecture a_reg_bd of reg_bd is   
component registrator_16 is
    port(
        clk: in std_logic;
        rst: in std_logic;
        wr_en: in std_logic;
        data_in: in unsigned(15 downto 0);
        data_out: out unsigned(15 downto 0)
    );
end component;

signal reg0_out, reg1_out, reg2_out, reg3_out, reg4_out, reg5_out, reg6_out, reg7_out: unsigned(15 downto 0);
signal reg0_in: unsigned(15 downto 0) := "0000000000000000";
signal reg1_in, reg2_in, reg3_in, reg4_in, reg5_in, reg6_in, reg7_in: unsigned(15 downto 0);
signal write_enable0, write_enable1, write_enable2, write_enable3, write_enable4, write_enable5, write_enable6, write_enable7 : std_logic;

begin 
    reg0 : registrator_16 port map (clk => clk, rst => rst, 
        wr_en => write_enable0, data_in => reg0_in, data_out => reg0_out);
    reg1 : registrator_16 port map (clk => clk, rst => rst, 
        wr_en => write_enable1, data_in => reg1_in, data_out => reg1_out);
    reg2 : registrator_16 port map (clk => clk, rst => rst, 
        wr_en => write_enable2, data_in => reg2_in, data_out => reg2_out);
    reg3 : registrator_16 port map (clk => clk, rst => rst, 
        wr_en => write_enable3, data_in => reg3_in, data_out => reg3_out);
    reg4 : registrator_16 port map (clk => clk, rst => rst, 
        wr_en => write_enable4, data_in => reg4_in, data_out => reg4_out);
    beg5 : registrator_16 port map (clk => clk, rst => rst, 
        wr_en => write_enable5, data_in => reg5_in, data_out => reg5_out);
    beg6 : registrator_16 port map (clk => clk, rst => rst, 
        wr_en => write_enable6, data_in => reg6_in, data_out => reg6_out);
    beg7 : registrator_16 port map (clk => clk, rst => rst, 
        wr_en => write_enable7, data_in => reg7_in, data_out => reg7_out);

            read_data0 <= 
                reg0_out when read_r0 = "000" else
                reg1_out when read_r0 = "001" else
                reg2_out when read_r0 = "010" else
                reg3_out when read_r0 = "011" else
                reg4_out when read_r0 = "100" else
                reg5_out when read_r0 = "101" else
                reg6_out when read_r0 = "110" else
                reg7_out when read_r0 = "111" else
                "0000000000000000";

            read_data1 <= 
                reg0_out when read_r1 = "000" else
                reg1_out when read_r1 = "001" else
                reg2_out when read_r1 = "010" else
                reg3_out when read_r1 = "011" else
                reg4_out when read_r1 = "100" else
                reg5_out when read_r1 = "101" else
                reg6_out when read_r1 = "110" else
                reg7_out when read_r1 = "111" else
                "0000000000000000";
            
            reg1_in <= write_data;
            reg2_in <= write_data;
            reg3_in <= write_data;
            reg4_in <= write_data;
            reg5_in <= write_data;
            reg6_in <= write_data;
            reg7_in <= write_data;

            write_enable0 <= '1' when write_enable = '1' and write_register = "000" else '0';
            write_enable1 <= '1' when write_enable = '1' and write_register = "001" else '0';
            write_enable2 <= '1' when write_enable = '1' and write_register = "010" else '0';
            write_enable3 <= '1' when write_enable = '1' and write_register = "011" else '0';
            write_enable4 <= '1' when write_enable = '1' and write_register = "100" else '0';
            write_enable5 <= '1' when write_enable = '1' and write_register = "101" else '0';
            write_enable6 <= '1' when write_enable = '1' and write_register = "110" else '0';
            write_enable7 <= '1' when write_enable = '1' and write_register = "111" else '0';
end architecture;
