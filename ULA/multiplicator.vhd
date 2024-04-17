library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity multiplicator is 
    port(
        in_a : in unsigned(15 downto 0);
        in_b : in unsigned(15 downto 0);
        result : out unsigned(15 downto 0)
    );
end entity;

architecture a_multiplicator of multiplicator is
    signal product: unsigned(31 downto 0);
begin
    product<=in_a*in_b;
    result<= product(15 downto 0);
end architecture;