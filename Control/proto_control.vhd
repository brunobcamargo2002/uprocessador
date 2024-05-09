library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity proto_control is 
    port (
        clk, rst: in std_logic;
        wr_en: in std_logic;
        data_out: out unsigned(6 downto 0)
    );
end entity;

architecture proto_control of proto_control is
    component registrator_7 is
        port(
            clk: in std_logic;
            rst: in std_logic;
            wr_en: in std_logic;
            data_in: in unsigned(6 downto 0);
            data_out: out unsigned(6 downto 0)
        );
    end component;
    signal data_in: unsigned(6 downto 0):= "0000000";
    signal data_out_s: unsigned(6 downto 0);
begin
    pc : registrator_7 port map(clk => clk, rst => rst, wr_en => '1', data_in => data_in, data_out => data_out_s);  
    data_in <= data_out_s+1;
    data_out <= data_out_s;

end architecture;