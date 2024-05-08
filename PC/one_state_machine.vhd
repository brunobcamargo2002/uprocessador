library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY one_state_machine is 
    port(
        clk: in std_logic;
        rst: in std_logic;
        estado: out unsigned(15 downto 0)
    );
end entity;

architecture a_one_state_machine of one_state_machine is
    signal estado: std_logic;
begin
    
    process(clk, rst, wr_en)
    begin
        if rst='1' then
            estado <= "0";
        elif rising_edge(clk) then
            estado <= not estado;
        end if;
    end process;
    data_out <= reg;    
end architecture;

