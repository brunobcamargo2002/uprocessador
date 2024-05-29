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
        0 => B"0001_011_000000101", -- A 
        1 => B"0001_100_000001000", -- B
        2 => B"0110_000_000_000000", -- C
        3 => B"0010_000_011_000000",
        4 => B"0010_000_100_000000",
        5 => B"0111_101_000_000000", 
        6 => B"0110_000_101_000000", -- D
        7 => B"0101_000_000000001",
        8 => B"0111_101_000000000",
        9 => B"1000_0011001_00000", -- E
        10 => B"0110_000_000_000000", -- F
        11 => B"0111_101_000000000", 
        12 => B"0000_0000000_00000", --
        13 => B"0000_0000000_00000", 
        14 => B"0000_0000000_00000", 
        15 => B"0000_0000000_00000", 
        16 => B"0000_0000000_00000", 
        17 => B"0000_0000000_00000", 
        18 => B"0000_0000000_00000", 
        19 => B"0000_0000000_00000", 
        20 => B"0110_000_101_000000", -- G
        21 => B"0111_011_000_000000", 
        22 => B"0000_0000000_00000", -- H
        23 => B"0110_000_000_000000", -- I
        24 => B"0111_011_000_000000",
        25 => B"0001_111_000001010", -- load R1, 10
        26 => B"0110_000_111_00_0000", -- mova R1
        27 => B"0100_000_111_00_0000", -- sub R1
        28 => B"1001_0011001_0_0000", -- sub R1
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