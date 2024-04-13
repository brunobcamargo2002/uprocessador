library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity porta_tb is
    compoent adder
        port (
            in_a : in unsigned(15 downto 0);
            in_b : in unsigned(15 downto 0);
            result : out unsigned(15 downto 0)
        );
end entity;