library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg_bd_tb is
end entity;

architecture a_reg_bd_tb of reg_bd_tb is
    component reg_bd
        port (
            read_r0: in unsigned(2 downto 0);
            read_r1: in unsigned(2 downto 0);
            wr_en: in std_logic;
            write_register: in unsigned(2 downto 0);
            write_data: in unsigned(15 downto 0);
            clk: in std_logic;
            rst: in std_logic;
            read_data0: out unsigned(15 downto 0); 
            read_data1: out unsigned(15 downto 0)
        );
    end component;

    signal read_r0: unsigned(2 downto 0) := "000";
    signal read_r1: unsigned(2 downto 0) := "000";
    signal wr_en: std_logic := '0';
    signal write_register: unsigned(2 downto 0) := "000";
    signal write_data: unsigned(15 downto 0) := "0000000000000000";
    signal clk: std_logic := '0';
    signal rst: std_logic := '1';
    signal read_data0: unsigned(15 downto 0) := "0000000000000000"; 
    signal read_data1: unsigned(15 downto 0) := "0000000000000000";

    signal finished : std_logic := '0';

    constant clock_period: time:= 50 ns;
begin 
    uut: reg_bd port map (
        read_r0 => read_r0,
        read_r1 => read_r1, 
        wr_en => wr_en,
        write_register => write_register,
        write_data => write_data,
        clk => clk,
        rst => rst,
        read_data0 => read_data0,
        read_data1 => read_data1
    );

    sim_time_proc: process
    begin
        wait for 800 us; 
        finished <= '1';
        wait;
    end process sim_time_proc;

    clk_proc: process
    begin                      
        while finished /= '1' loop
            clk <= '0';
            wait for clock_period/2;
            clk <= '1';
            wait for clock_period/2;
        end loop;
        wait;
    end process clk_proc;

    process begin
        read_r0 <= "000";
        read_r1 <= "010";
        rst <= '0';
        wait for 200 ns;
        write_data <= "0000000000001000";
        write_register <= "011";
        wr_en <= '1';
        wait for 100 ns;
        read_r0 <= "011";
        write_data <= "0000000000000001";
        write_register <= "001";
        wr_en <= '0';
        wait for 100 ns;
        read_r0 <= "001";
        read_r1 <= "011";
        wait for 100 ns;
        rst <= '1';
        read_r0 <= "001";
        read_r1 <= "011";
        wait;
    end process;
end architecture;