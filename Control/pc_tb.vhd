library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pc_tb is 
end entity pc_tb;

architecture a_registrator_16 of pc_tb is
    component control_proto_unit is
        port(
            clk, rst: in std_logic;
            wr_en: in std_logic;
            data_out: out unsigned(15 downto 0)
        );
    end component;
    
    signal clk, rst, wr_en: std_logic;
    signal data_out: unsigned(15 downto 0);
    
begin
    uut: control_proto_unit port map(
        clk => clk,
        rst => rst,
        wr_en => wr_en,
        data_out => data_out
    );
    
    process
    begin
        rst <= '1';
        clk <= '0';
        wait for 50 ns;
        rst <= '0';
        clk <= '1';
        wait for 50 ns;
        clk <= '0';
        wait for 50 ns;
        clk <= '1';
        wait for 50 ns;
        clk <= '0';
        wait for 50 ns;
        clk <= '1';
        wait for 50 ns;
        clk <= '0';
        wait for 50 ns;
        clk <= '1';
        wait for 50 ns;
        clk <= '0';
        wait for 50 ns;
        clk <= '1';
        wait for 50 ns;
        wait;
    end process;
    
end architecture;

