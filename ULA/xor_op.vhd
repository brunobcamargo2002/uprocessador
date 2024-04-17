library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity xor_op is
    port(
        in_a : in unsigned(15 downto 0);
        in_b : in unsigned(15 downto 0);
        result : out unsigned(15 downto 0)
    );
end entity;


architecture a_xor_op of xor_op is
    signal aux : unsigned(15 downto 0);
begin 
    result<= in_a xor in_b;
    
end architecture;
            