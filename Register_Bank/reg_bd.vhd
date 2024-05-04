library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg_bd is
    port(
        read_r0: in unsigned(2 downto 0);
        read_r1: in unsigned(2 downto 0);
        wr_en: in std_logic;
        write_register: in unsigned(2 downto 0);
        write_data: in unsigned(15 downto 0);
        clk: in std_logic;
        rst: in std_logic;
        read_data0: out unsigned(15 downto 0); 
        read_data1: out unsigned(15 downto 0);


        --Wires
        r0, r1, r2, r3, r4, r5, r6, r7: out unsigned(15 downto 0)
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
signal wr_en0, wr_en1, wr_en2, wr_en3, wr_en4, wr_en5, wr_en6, wr_en7 : std_logic;

begin 
    reg0 : registrator_16 port map (clk => clk, rst => rst, 
        wr_en => wr_en0, data_in => reg0_in, data_out => reg0_out);
    reg1 : registrator_16 port map (clk => clk, rst => rst, 
        wr_en => wr_en1, data_in => reg1_in, data_out => reg1_out);
    reg2 : registrator_16 port map (clk => clk, rst => rst, 
        wr_en => wr_en2, data_in => reg2_in, data_out => reg2_out);
    reg3 : registrator_16 port map (clk => clk, rst => rst, 
        wr_en => wr_en3, data_in => reg3_in, data_out => reg3_out);
    reg4 : registrator_16 port map (clk => clk, rst => rst, 
        wr_en => wr_en4, data_in => reg4_in, data_out => reg4_out);
    beg5 : registrator_16 port map (clk => clk, rst => rst, 
        wr_en => wr_en5, data_in => reg5_in, data_out => reg5_out);
    beg6 : registrator_16 port map (clk => clk, rst => rst, 
        wr_en => wr_en6, data_in => reg6_in, data_out => reg6_out);
    beg7 : registrator_16 port map (clk => clk, rst => rst, 
        wr_en => wr_en7, data_in => reg7_in, data_out => reg7_out);

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

    wr_en0 <= '1' when wr_en = '1' and write_register = "000" else '0';
    wr_en1 <= '1' when wr_en = '1' and write_register = "001" else '0';
    wr_en2 <= '1' when wr_en = '1' and write_register = "010" else '0';
    wr_en3 <= '1' when wr_en = '1' and write_register = "011" else '0';
    wr_en4 <= '1' when wr_en = '1' and write_register = "100" else '0';
    wr_en5 <= '1' when wr_en = '1' and write_register = "101" else '0';
    wr_en6 <= '1' when wr_en = '1' and write_register = "110" else '0';
    wr_en7 <= '1' when wr_en = '1' and write_register = "111" else '0';

    r0 <= reg0_out;
    r1 <= reg1_out;
    r2 <= reg2_out;
    r3 <= reg3_out;
    r4 <= reg4_out;
    r5 <= reg5_out;
    r6 <= reg6_out;
    r7 <= reg7_out;

            

end architecture;
