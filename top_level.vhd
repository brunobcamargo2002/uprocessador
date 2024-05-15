library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top_level is
    port(
    clk, rst: in std_logic;

    ----wires----
    --ULA wires
    ULA_out: out unsigned (15 downto 0);
    zero_flag: out std_logic;

    --RB wires
    r0, r1, r2, r3, r4, r5, r6, r7: out unsigned(15 downto 0) 
    );


end entity;

architecture a_top_level of top_level is
    component ula
        port (
            operation : in unsigned(1 downto 0);
            in_a : in unsigned(15 downto 0);
            in_b : in unsigned(15 downto 0);
            ULAout : out unsigned(15 downto 0);
            is_zero: out std_logic
        );
    end component;

    component reg_bd
        port(
            read_r0: in unsigned(2 downto 0);
            read_r1: in unsigned(2 downto 0);
            wr_en: in std_logic;
            write_register: in unsigned(2 downto 0);
            write_data: in unsigned(15 downto 0);
            clk: in std_logic;
            rst: in std_logic;
            read_data0: out unsigned(15 downto 0); 
            read_data1: out unsigned(15 downto 0);
            --wires--
            r0, r1, r2, r3, r4, r5, r6, r7: out unsigned(15 downto 0)
        );
    end component;

    component proto_control is 
    port (
        clk, rst: in std_logic;
        wr_en: in std_logic;
        data_out: out unsigned(15 downto 0);
        estado: in unsigned(1 downto 0);
        is_branch: in std_logic;
        branch_address: in unsigned(6 downto 0)
    );
    end component;

    component three_state_machine is
        port( clk,rst: in std_logic;
              estado: out unsigned(1 downto 0)
        );
     end component;

    component registrator_16 is 
    port(
        clk: in std_logic;
        rst: in std_logic;
        wr_en: in std_logic;
        data_in: in unsigned(15 downto 0);
        data_out: out unsigned(15 downto 0)
    );
    end component;

    --ULA signals
    signal in_a, in_b, ULAout : unsigned(15 downto 0);
    signal is_zero : std_logic;


    --Register Bank signals
    signal read_data1, write_data_s: unsigned (15 downto 0);
    signal write_register_s : unsigned(2 downto 0);
    signal wr_en_s : std_logic;

    -- instruction_reg signals
    signal data_out_instruction_reg, data_in_instruction_reg : unsigned (15 downto 0);
    signal opcode : unsigned (3 downto 0);
    signal wr_en_instruction_reg : std_logic;

    -- proto_control signals
    signal data_out_proto_control : unsigned (15 downto 0);
    signal is_branch_s : std_logic;
    signal branch_address_s : unsigned (6 downto 0);
    signal wr_en_proto_control : std_logic;

    -- 3 state machine signals
    signal estado_s : unsigned (1 downto 0);

begin 
    
    --ula_1: ula port map ( operation => operation, 
    --in_a => in_a, 
    --in_b => in_b,
    --ULAout => ULAout,
    --is_zero => is_zero);

    reg_bd_1: reg_bd port map(read_r0 => "000",--read_0, 
    read_r1 => "000",--read_1, 
    wr_en => wr_en_s,
    write_register => write_register_s, 
    write_data => write_data_s,  
    clk => clk, 
    rst => rst,
    read_data0 => in_a, 
    read_data1 => read_data1,
    --wires
    r0 => r0, r2 => r2, r3 => r3, r4 => r4, r5 => r5, r6 => r6, r7 => r7);

    instruction_reg : registrator_16 port map (
        clk => clk,
        rst => rst,
        wr_en => wr_en_instruction_reg,
        data_in => data_in_instruction_reg,
        data_out => data_out_instruction_reg
    );

    proto_control_1 : proto_control port map (
        clk => clk,
        rst => rst,
        wr_en => wr_en_proto_control,
        data_out => data_out_proto_control,
        estado => estado_s,
        is_branch => is_branch_s,
        branch_address => branch_address_s
    );

    three_state_machine_1 : three_state_machine port map (
        clk => clk,
        rst => rst,
        estado => estado_s
    );

    opcode <= data_out_instruction_reg(15 downto 12);

    wr_en_proto_control <= '1' when estado_s = "00";

    data_in_instruction_reg <= data_out_proto_control;
    wr_en_instruction_reg <= '1' when estado_s = "01";

    -- reg_bank
    -- opcode "0001" = LI
    write_register_s <= data_out_instruction_reg(11 downto 9) when opcode = "0001" and estado_s = "10"
        else "000";
    write_data_s <= "0000000" & data_out_instruction_reg(8 downto 0) when opcode = "0001" and estado_s = "10"
        else X"0000";
    wr_en_s <= '1' when opcode = "0001" else '0';

    --mux in_b of ula
    -- in_b <= read_data1 when mux_2='0' else cte;

    --Wires
    ULA_out <= ULAout;
    zero_flag <= is_zero;


end architecture;
