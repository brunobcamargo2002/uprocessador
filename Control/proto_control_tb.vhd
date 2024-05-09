library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity proto_control_tb is
end entity;

architecture a_proto_control_tb of proto_control_tb is

    component proto_control is   
        port (
            clk, rst: in std_logic;
            wr_en: in std_logic;
            data_out: out unsigned(6 downto 0);
            is_branch: in std_logic;
            branch_address: in unsigned(6 downto 0)
        );
    end component;

    signal clk, rst, is_branch: std_logic;
    signal data_out, branch_address: unsigned(6 downto 0);

    signal finished : std_logic := '0';

    constant clock_period: time:= 50 ns;

begin

    uut : proto_control port map (
        clk => clk,
        rst => rst,
        wr_en => '1',
        data_out => data_out,
        is_branch => is_branch,
        branch_address => branch_address
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
        is_branch <= '0';
        branch_address <= "0000000";
        wr_en <= '1';
        wait for 300 ns;
        is_branch <= '1';
        wait for 50 ns;
        branch_address <= "0000100";
        wait for 50 ns;
        wait;
    end process;
end a_proto_control_tb ; -- a_proto_control_tb