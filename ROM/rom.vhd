library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom is
    port(
        clk: in std_logic;
        address: in unsigned(6 downto 0);
        data: out unsigned(15 downto 0)
    );
end entity;

architecture a_rom of rom is
    type mem is array(0 to 127) of unsigned(15 downto 0);
    constant content: mem :=(
        0 => B"0110_000_000_000000",
        1 => B"0011_000_000000011",
        2 => B"0111_011_000000000",
        3 => B"1100_100_000000000",
        4 => B"0110_000_000_000000",
        5 => B"0011_000_000001011",
        6 => B"1100_101_000000000",
        7 => B"0001_010_000001000", -- ld r2, 08
        8 => B"1101_000_010_000000", -- rw r2
        9 => B"0011_000000001000", -- addi 8
        10 => B"1100_010_000_000000", -- lw r2
        others => (others=>'0')
    );
begin
    process(clk)
    begin
        if(rising_edge(clk)) then
            data <= content(to_integer(address));
        end if;
    end process;
end architecture;
