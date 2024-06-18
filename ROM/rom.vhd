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
        1 => B"0000_001_000000010", -- none
        2 => B"0001_001_000000010", -- ld r1, 2
        3 => B"0001_010_000100000", -- ld r2, 32
        4 => B"0110_000_001_000000", -- mova r1
        5 => B"1110_000_010_000000", -- cmp 
        6 => B"1011_1111110_00000", -- jc -2
        7 => B"1101_000_001_000000", -- sw r1
        8 => B"0110_000_001_000000", -- mova r1
        9 => B"0100_000_010_000000", -- sub r2
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
