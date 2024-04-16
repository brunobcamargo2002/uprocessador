library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ula is 
    port (
        operation : in unsigned(1 downto 0);
        in_a : in unsigned(15 downto 0);
        in_b : in unsigned(15 downto 0);
        saida : out unsigned(15 downto 0);
        is_zero: out std_logic
    );
end entity;

architecture a_ula of ula is

    component adder is 
        port (
            in_a : in unsigned(15 downto 0);
            in_b : in unsigned(15 downto 0);
            result : out unsigned(15 downto 0)
        );
    end component;

    component subtracter is
        port (
            in_a : in unsigned(15 downto 0);
            in_b : in unsigned(15 downto 0);
            result : out unsigned(15 downto 0)
        );
    end component;

    component multiplicator is
        port(
            in_a : in unsigned(15 downto 0);
            in_b : in unsigned(15 downto 0);
            result : out unsigned(15 downto 0)
        );
    end component;

    component xor_op is
        port(
            in_a : in unsigned(15 downto 0);
            in_b : in unsigned(15 downto 0);
            result : out unsigned(15 downto 0)
        );
    end component;

    signal result_adder, result_subtracter, result_multiplicator, result_xor : unsigned(15 downto 0);
begin
    adder1: adder port map(in_a=>in_a, in_b=>in_b, result=>result_adder);
    subtracter1: subtracter port map(in_a=>in_a, in_b=>in_b, result=>result_subtracter);
    multiplicator1: multiplicator port map(in_a=>in_a, in_b=>in_b, result=>result_multiplicator);
    xor_op1: xor_op port map(in_a=>in_a, in_b=>in_b, result=>result_xor);
    saida <= result_adder when operation="00" else
             result_subtracter when operation="01" else
             result_multiplicator when operation="10" else
             result_xor when operation="11" else
             "0000000000000000";
end architecture;

