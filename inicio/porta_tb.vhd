library ieee;
use ieee.std_logic_1164.all;

entity porta_tb is
end;

architecture a_porta_tb of porta_tb is 
    component porta
        port (
            in_a : in std_logic;
            in_b : in std_logic;
            a_and_b : out std_logic
        );
    end component;
    signal in_a, in_b, a_and_b : std_logic;

begin
    uut : porta port map (
        in_a => in_a,
        in_b => in_b,
        a_and_b => a_and_b
    );
-- inserindo dados da simulação
    process 
    begin
        in_a <= '0';
        in_b <= '0';
        wait for 50 ns;
        in_a <= '0';
        in_b <= '1'; 
        wait for 50 ns;
        in_a <= '1';
        in_b <= '0';
        wait for 50 ns;
        in_a <= '1';
        in_b <= '1';
        wait for 50 ns;
        wait;
    end process;
end architecture;