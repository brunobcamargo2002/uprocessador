library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder is 
    port (
        in_a : in unsigned(15 downto 0);
        in_b : in unsigned(15 downto 0);
        result : out unsigned(16 downto 0)
    );
end entity;

architecture a_adder of adder is
begin
    result <= '0'&in_a + '0'&in_b;
end architecture;