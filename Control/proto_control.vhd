library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity proto_control is 
    port (
        clk, rst: in std_logic;
        wr_en: in std_logic;
        data_out: out unsigned(6 downto 0);
        is_branch: in std_logic;
        branch_address: in unsigned(6 downto 0);
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
    component rom is 
        port(
        clk: in std_logic;
        address: in unsigned(6 downto 0);
        data: out unsigned(15 downto 0)
        );
    end component;
    component one_state_machine is
        port (
            clk : in std_logic;
            rst : in std_logic;
            estado : out std_logic
        );
    end component;

    signal data_in: unsigned(6 downto 0):= "0000000";
    signal data_out_s, address_s: unsigned(6 downto 0);
    signal data_s: unsigned(15 downto 0);
    signal estado_s: std_logic;
begin
    pc : registrator_7 port map(clk => clk, rst => rst, wr_en => '1', data_in => data_in, data_out => data_out_s);  
    rom_1 : rom port map(clk => clk, address => address_s, data => data_s);
    one_state_machine_1 : one_state_machine port map (clk => clk, rst => rst => estado => estado_s);
    data_in <= data_out_s+1 when estado = '1' else data_out_s;
    data_out <= data_out_s;
    address_s <= data_out_s when is_branch = '0' else branch_address; 

end architecture;