library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- control_unity vai ter as flags 
-- para guardar condições

entity control_unity is 
    port (
        clk, rst: in std_logic;
        flag1_in: in std_logic; 
        flag1_out: in std_logic;
    );
end entity;

architecture a_control_unity of control_unity is
component registrator_1 is 
    port(
        clk: in std_logic;
        rst: in std_logic;
        wr_en: in std_logic;
        data_in: in std_logic;
        data_out: out std_logic
    );
end component;
begin
    flag1: registrator_1 port map (clk => clk, rst => rst, wr_en => '1', data_in => flag1_in, data_out => flag1_out);
end a_control_unity;