library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ula_tb is
end entity;

architecture a_ula_tb of ula_tb is
    component ula
        port (
            operation : in unsigned(1 downto 0);
            in_a : in unsigned(15 downto 0);
            in_b : in unsigned(15 downto 0);
            saida : out unsigned(15 downto 0);
            is_zero: out std_logic
        );
    end component;

    signal operation : unsigned(1 downto 0);
    signal in_a, in_b, saida : unsigned(15 downto 0);
    signal is_zero : std_logic;
    
begin 
    uut: ula port map (
        operation => operation,
        in_a => in_a,
        in_b => in_b,
        saida => saida,
        is_zero => is_zero
    );
    process
    begin
        in_a <= "0000000000001010";
        in_b <= "0000000000000110";
        wait for 50 ns;
        operation <= "00";
        wait for 50 ns;
        operation <= "01";
        wait for 50 ns;
        operation <= "10";
        wait for 50 ns;
        operation<="11";
        wait for 50 ns;
        in_a <= "0000100000001010"
        in_b <= "0011100000000010"
        wait for 50 ns;
        operation <= "00";
        wait for 50 ns;
        operation <= "01";
        wait for 50 ns;
        operation <= "10";
        wait for 50 ns;
        operation<="11";
        wait for 50 ns;
        wait;
    end process;
end architecture;

