library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom_tb is
end entity;

architecture a_rom_tb of rom_tb is
    component rom is
        port(
            clk: in std_logic;
            address: in unsigned(6 downto 0);
            data: out unsigned(15 downto 0)
        );
    end component;
    signal clk: std_logic;
    signal address: unsigned(6 downto 0);
    signal data: unsigned(15 downto 0);
begin
    rom_rom: rom port map(clk => clk, address => address, data => data);
    process
    begin
        wait for 50 ns;
        clk<= '0';
        address<="0000000";
        wait for 50 ns;
        clk<= '1';
        wait for 50 ns;
        address<="0000101";
        clk<= '0';
        wait for 50 ns;
        clk<= '1';
        wait for 50 ns;
        address<="0000010";
        clk<= '0';
        wait for 50 ns;
        clk<= '1';
        wait for 50 ns;
        address<="0000100";
        clk<= '0';
        wait for 50 ns;
        clk<= '1';
        wait for 50 ns;
        address<="0000011";
        clk<= '0';
        wait for 50 ns;
        clk<= '1';
        wait for 50 ns;
        address<="0000001";
        clk<= '0';
        wait for 50 ns;
        clk<= '1';
        wait for 50 ns;
        wait;
    end process;
    
end architecture;