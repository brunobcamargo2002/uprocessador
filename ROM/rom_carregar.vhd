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
        -- Carregar 19563_10 = 4C6B_16 em r4 --
        1 => B"0001_001_000000000", -- ld r1, 0 -- iterador
        2 => B"0001_010_111111111", -- ld r2, 511 -- op mult 1
        3 => B"0001_011_000100110", -- ld r3, 38 -- op mult 2
        4 => B"0001_100_000000000", -- ld r4, 0 -- resultado
        5 => B"0110_000_100_000000", -- mova r4
        6 => B"0010_000_010_000000", -- add r2
        7 => B"0111_100_0000_00000", -- mvr r4
        8 => B"0110_000_001_000000", -- mova r1
        9 => B"0011_000_000000001", -- addi 1
        10 => B"1110_000_011_000000", -- cmp r3
        11 => B"0111_001_0000_00000", -- mvr r1
        12 => B"1011_1111001_00000", -- jc -7
        13 => B"0110_000_100_000000", -- mova r4
        14 => B"0011_000_01001_0001", -- addi 145
        15 => B"0111_100_0000_00000", -- mvr r4


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
