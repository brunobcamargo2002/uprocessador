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
        2 => B"0001_010_100000000", -- ld r2, 256 -- op mult 1
        3 => B"0001_011_010000000", -- ld r3, 128 -- op mult 2
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
        14 => B"0101_000_00000_0001", -- subi 1
        15 => B"0111_010_0000_00000", -- mvr r2
        16 => B"0001_100_000000000", -- ld r4, 0
        17 => B"0001_011_000000000", -- ld r3, 0

        18 => B"0001_001_000000000", -- ld r1, 0
        19 => B"0110_000_001_000000", -- mova r1
        20 => B"0011_000_000000001", -- addi 1
        21 => B"0111_001_000000000", -- movr r1
        22 => B"1101_000_001_000000", -- sw r1
        23 => B"0110_000_001_000000", -- mova r1
        24 => B"1111_000_010_000000", -- or r2
        25 => B"0100_000_010_000000", -- sub r2
        26 => B"1001_1111001_00000", -- jz -7
-----------------------------------------------------
-------------Crivo de Eratóstenes -------------------
-----------------------------------------------------
-- Remove os pares (eu acho) --
        27 => B"0001_001_000000010", -- ld r1, 2
        28 => B"0110_000_001_000000", -- mova r1
        29 => B"0011_000_000000010", -- addi 2
        30 => B"0111_001_000000000", -- movr r1
        31 => B"1101_000_000_000000", -- sw r0
        32 => B"0110_000_001_000000", -- mova r1
        33 => B"0100_000_010_000000", -- sub r2
        34 => B"1011_1111010_00000", -- jc -6


        35 => B"0001_001_000000001", -- ld r1, 1
        36 => B"0110_000_000_000000", -- mova r0
        37 => B"0010_000_001_000000", -- add r1
        38 => B"0011_000_000000010", -- addi 2
        39 => B"0111_001_000000000", -- movr r1
        40 => B"1100_011_000000000", -- lw r3 --
        41 => B"0110_000_011_000000", -- mova r3
        42 => B"1001_1111010_00000", -- jz -6
       


        43 => B"0110_000_001_000000", -- mova r1
        44 => B"0010_000_001_000000", -- add r1
        45 => B"0010_000_001_000000", -- add r1
        46 => B"0111_011_000000000", -- movr r3
        47 => B"0110_000_011_000000", -- mova r3
        48 => B"1101_000_000_000000", -- sw r0
        49 => B"0010_000_001_000000", -- add r1
        50 => B"0010_000_001_000000", -- add r1
        51 => B"0111_011_000000000", -- movr r3
        52 => B"0100_000_010_000000", -- sub r2
        53 => B"1011_1111010_00000", -- jc -6

        54 => B"0110_000_001_000000", -- mova r1
        55 => B"0011_000_000000010", -- addi 2
        56 => B"0111_001_000000000", -- movr r1
        57 => B"0100_000_010_000000", -- sub r2
        58 => B"1011_1101110_00000", -- jc -18

        59 => B"0001_100_000000000", -- ld r4, 0
        60 => B"0110_000_100_000000", -- mova r4
        61 => B"0011_000_000000001", -- addi, 1
        62 => B"1100_101_000000000", -- lw r5
        63 => B"0111_100_000000000", -- movr r4
        64 => B"1111_000_010_000000", -- or r2
        65 => B"0100_000_010_000000", -- sub r2
        66 => B"1001_1111010_00000", -- jz -6

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
