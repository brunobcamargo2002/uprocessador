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
        0 => B"0010_0010_1001_1000", -- ADD R1, R2, R3
        -- 0 => B"0011_0110_0000_0101", -- LI R3, 5
        -- 1 => B"0011_1000_0000_1000", -- LI R4, 8
        2 => "0000000000011000",
        3 => "0000000000001010",
        4 => "0000000000001100",
        5 => "0000000000000010",
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