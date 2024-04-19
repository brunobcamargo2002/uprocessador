library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity and_op is 
    port(
        in_a : in unsigned(15 downto 0);
        in_b : in unsigned(15 downto 0);
        result : out unsigned(15 downto 0)
    );
end entity;

architecture a_and_op of and_op is
begin
    result <= in_a and in_b;
end architecture;