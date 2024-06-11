library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity one_state_machine is
  port (
    clk : in std_logic;
    rst : in std_logic;
    estado : out std_logic
  ) ;
end one_state_machine;

architecture a_one_state_machine of one_state_machine is

  signal estado_s : std_logic := '0';

begin

    process(clk)
    begin 
        if(rising_edge(clk)) then
            estado_s <= not estado_s;
        end if;
    end process;
    estado <= estado_s;
end a_one_state_machine ; -- a_one_state_machine