library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- control_unity vai ter as flags 
-- para guardar condições

entity control_unity is 
    port (
        clk, rst: in std_logic;

        flag_zero_in: in std_logic; 
        flag_zero_out: out std_logic;
        
        flag_overflow_in: in std_logic; 
        flag_overflow_out: out std_logic;
   
        flag_carry_in: in std_logic; 
        flag_carry_out: out std_logic;  

        wr_enable_flags: in std_logic
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
    flag_zero: registrator_1 port map (clk => clk, rst => rst, wr_en => wr_enable_flags, data_in => flag_zero_in, data_out => flag_zero_out);
    flag_overflow: registrator_1 port map (clk => clk, rst => rst, wr_en => wr_enable_flags, data_in => flag_overflow_in, data_out => flag_overflow_out);
    flag_carry: registrator_1 port map (clk => clk, rst => rst, wr_en => wr_enable_flags, data_in => flag_carry_in, data_out => flag_carry_out);
end a_control_unity;