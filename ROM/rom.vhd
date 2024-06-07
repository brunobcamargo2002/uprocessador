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
        0 => B"0001_011_000000000", -- A 
        1 => B"0001_100_000000000", -- B
        2 => B"0110_000_000_000000", -- C
        3 => B"0010_000_011_000000",
        4 => B"0010_000_100_000000",
        5 => B"0111_100_000000000", 
        6 => B"0110_000_000_000000", -- zera acumulador
        7 => B"0011_000_000000001", -- D
        8 => B"0111_011_000_000000",
        9 => B"0110_000_011_011110", -- E
        10 => B"0101_000_000011110",
        11 => B"1010_1110111_00000", 
        12 => B"0110_000_100_000000", --F
        13 => B"0111_101_000_000000",
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