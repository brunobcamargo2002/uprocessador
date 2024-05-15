library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity proto_control is 
    port (
        clk, rst: in std_logic;
        wr_en: in std_logic;
        is_branch: in std_logic;
        branch_address: in unsigned(6 downto 0);
        estado: in unsigned(1 downto 0);
        data_out: out unsigned(15 downto 0)
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

    signal data_in_pc: unsigned(6 downto 0):= "0000000";
    signal data_out_pc, address_rom: unsigned(6 downto 0);
    signal data_out_rom: unsigned(15 downto 0);
    signal estado_s: unsigned(1 downto 0);
    
    signal new_address: unsigned(6 downto 0):="0000000"; 

begin
    pc : registrator_7 port map(clk => clk, rst => rst, wr_en => wr_en, data_in => data_in_pc, data_out => data_out_pc);  
    rom_1 : rom port map(clk => clk, address => address_rom, data => data_out_rom);
    --one_state_machine_1 : one_state_machine port map (clk => clk, rst => rst, estado => estado_s);
    
    --estado <= estado_s;
    estado_s <= estado;

    new_address <= branch_address when is_branch = '1' else data_out_pc+1;
    data_in_pc <= new_address when estado_s = "10" else data_out_pc;
    address_rom <= data_out_pc when estado_s = "00";
  
    data_out <= data_out_rom;
end architecture;