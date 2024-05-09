library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity one_state_machine_tb is
end entity;

architecture a_one_state_machine_tb of one_state_machine_tb is
    component one_state_machine
    port (
        clk : in std_logic;
        rst : in std_logic;
        estado : out std_logic
    ) ;
    end component;
    
    signal clk, rst, estado : std_logic;
begin 

    uut : one_state_machine port map (
        clk => clk,
        rst => rst,
        estado => estado
    );

    process begin
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