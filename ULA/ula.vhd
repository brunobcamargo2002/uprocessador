library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ula is 
    port (
        operation : in unsigned(1 downto 0);
        in_a : in unsigned(15 downto 0);
        in_b : in unsigned(15 downto 0);
        ULAout : out unsigned(15 downto 0);
        zero_flag: out std_logic;
        overflow_flag: out std_logic;
        carry_flag: out std_logic
    );
end entity;

architecture a_ula of ula is

    component adder is 
        port (
            in_a : in unsigned(15 downto 0);
            in_b : in unsigned(15 downto 0);
            result : out unsigned(16 downto 0)
        );
    end component;

    component subtracter is
        port (
            in_a : in unsigned(15 downto 0);
            in_b : in unsigned(15 downto 0);
            result : out unsigned(16 downto 0)
        );
    end component;

    component xor_op is
        port(
            in_a : in unsigned(15 downto 0);
            in_b : in unsigned(15 downto 0);
            result : out unsigned(15 downto 0)
        );
    end component;

    component and_op is
        port(
            in_a : in unsigned(15 downto 0);
            in_b : in unsigned(15 downto 0);
            result : out unsigned(15 downto 0)
        );
    end component;

    signal result_and, result_xor: unsigned(15 downto 0);
    signal result_subtracter, result_adder, final_result : unsigned(16 downto 0);
begin
    adder1: adder port map(in_a=>in_a, in_b=>in_b, result=>result_adder);
    subtracter1: subtracter port map(in_a=>in_a, in_b=>in_b, result=>result_subtracter);
    --multiplicator1: multiplicator port map(in_a=>in_a, in_b=>in_b, result=>result_multiplicator);
    and_op1: and_op port map(in_a=>in_a, in_b=>in_b, result=>result_xor);
    xor_op1: xor_op port map(in_a=>in_a, in_b=>in_b, result=>result_xor);
    final_result <= result_adder when operation="00" else
             result_subtracter when operation="01" else
             '0' & result_and when operation="10" else
             '0' & result_xor when operation="11" else
             "00000000000000000";
    ULAout <= final_result(15 downto 0);

    zero_flag <= '1' when final_result(15 downto 0) = x"0000" else '0';
    overflow_flag <= '1' when final_result(16) = '1' else '0';
    carry_flag <= '1' when final_result(16) = '1' else '0';
end architecture;

