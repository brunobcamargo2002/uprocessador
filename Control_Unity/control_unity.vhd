library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- control_unity vai ter as flags 
-- para guardar condições

entity control_unity is 
    port (
        clk, rst: in std_logic;

        instruction_in : in unsigned(15 downto 0);
        wr_en_instruction_reg, wr_en_proto_control : out std_logic;
        branch_address : out unsigned(6 downto 0);
        is_branch : out std_logic; 
        write_register_reg_bank, rA_address_out : out unsigned(2 downto 0);
        const_reg_bank : out unsigned(8 downto 0);
        write_data_reg_bank, data_in_accumulator, in_a : out unsigned(15 downto 0);
        

        --flag_zero_in: in std_logic; 
        --flag_zero_out: out std_logic;
        
        --flag_overflow_in: in std_logic; 
        --flag_overflow_out: out std_logic;
   
        --flag_carry_in: in std_logic; 
        --flag_carry_out: out std_logic  
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
component three_state_machine is
    port( clk,rst: in std_logic;
          estado: out unsigned(1 downto 0)
    );
 end component;
begin
    three_state_machine_1 : three_state_machine port map (
        clk => clk,
        rst => rst,
        estado => estado_s
    );
    flag_zero: registrator_1 port map (clk => clk, rst => rst, wr_en => '1', data_in => flag_zero_in, data_out => flag_zero_out);
    flag_overflow: registrator_1 port map (clk => clk, rst => rst, wr_en => '1', data_in => flag_overflow_in, data_out => flag_overflow_out);
    flag_carry: registrator_1 port map (clk => clk, rst => rst, wr_en => '1', data_in => flag_carry_in, data_out => flag_carry_out);
end a_control_unity;