library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity processador is
    port(
    clk, rst: in std_logic;

    ----wires----
    estado_out : out unsigned(1 downto 0);

    pc_out : out unsigned(15 downto 0);


    instruction_reg_out : out unsigned(15 downto 0);

    acumulador_out : out unsigned(15 downto 0);

    --ULA wires
    ULA_out: out unsigned (15 downto 0);

    --RB wires
    r0, r1, r2, r3, r4, r5, r6, r7: out unsigned(15 downto 0)
    );


end entity;

architecture a_processador of processador is
    component ula
        port (
            operation : in unsigned(1 downto 0);
            in_a : in unsigned(15 downto 0);
            in_b : in unsigned(15 downto 0);
            ULAout : out unsigned(15 downto 0);
            zero_flag: out std_logic;
            overflow_flag: out std_logic;
            carry_flag: out std_logic
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
        is_branch, is_relative_branch: in std_logic;
        branch_address: in unsigned(6 downto 0)
    );
    end component;

    component control_unity is 
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
    
    component ram is
    port( 
        clk      : in std_logic;
        endereco : in unsigned(6 downto 0);
        wr_en    : in std_logic;
        dado_in  : in unsigned(15 downto 0);
        dado_out : out unsigned(15 downto 0) 
    );
    end component;


    --ULA signals
    signal in_a, in_b, ULAout_s : unsigned(15 downto 0);
    signal is_zero : std_logic;
    signal operation_ula : unsigned(1 downto 0);
    signal zero_flag_s, overflow_flag_s, carry_flag_s : std_logic;


    --Register Bank signals
    signal regA_data_out, regB_data_out, write_data_s: unsigned (15 downto 0);
    signal write_register_s, rA_address, rB_address: unsigned(2 downto 0);
    signal wr_en_s : std_logic;
    signal const : unsigned(8 downto 0);

    -- instruction_reg signals
    signal data_out_instruction_reg, data_in_instruction_reg : unsigned (15 downto 0);
    signal opcode : unsigned (3 downto 0);
    signal wr_en_instruction_reg : std_logic;

    -- accumulator signals 
    signal wr_en_accumulator : std_logic;
    signal data_in_accumulator : unsigned (15 downto 0);
    signal data_out_accumulator : unsigned (15 downto 0);

    -- proto_control signals
    signal data_out_proto_control : unsigned (15 downto 0);
    signal is_branch_s, is_relative_branch_s : std_logic;
    signal branch_address_s : unsigned (6 downto 0);
    signal wr_en_proto_control : std_logic;

    -- Control Unity signals
    signal flag_zero_in_ctr, flag_zero_out_ctr : std_logic;
    signal flag_overflow_in_ctr, flag_overflow_out_ctr : std_logic; 
    signal flag_carry_in_ctr, flag_carry_out_ctr : std_logic; 
    signal wr_en_flags_ctr : std_logic;

    -- 3 state machine signals
    signal estado_s : unsigned (1 downto 0);

    -- RAM
    signal endereco_ram: unsigned(6 downto 0);
    signal wr_en_ram: std_logic;
    signal dado_in_ram: unsigned(15 downto 0);
    signal dado_out_ram: unsigned(15 downto 0);

begin 
    
    ula_1: ula port map ( operation => operation_ula, 
        in_a => in_a, 
        in_b => in_b,
        ULAout => ULAout_s,
        zero_flag => zero_flag_s,
        overflow_flag => overflow_flag_s,
        carry_flag => carry_flag_s
    );

    reg_bd_1: reg_bd port map(read_r0 => rA_address,--read_0, 
    read_r1 => rB_address,--read_1, 
    wr_en => wr_en_s,
    write_register => write_register_s, 
    write_data => write_data_s,  

    clk => clk, 
    rst => rst,
    read_data0 => regA_data_out, 
    read_data1 => regB_data_out,
    --wires
    r0 => r0, r1 => r1, r2 => r2, r3 => r3, r4 => r4, r5 => r5, r6 => r6, r7 => r7);

    instruction_reg : registrator_16 port map (
        clk => clk,
        rst => rst,
        wr_en => wr_en_instruction_reg,
        data_in => data_in_instruction_reg,
        data_out => data_out_instruction_reg
    );

    accumulator : registrator_16 port map (
        clk => clk,
        rst => rst,
        wr_en => wr_en_accumulator,
        data_in => data_in_accumulator,
        data_out => data_out_accumulator
    );

    proto_control_1 : proto_control port map (
        clk => clk,
        rst => rst,
        wr_en => wr_en_proto_control,
        data_out => data_out_proto_control,
        estado => estado_s,
        is_branch => is_branch_s,
        is_relative_branch => is_relative_branch_s,
        branch_address => branch_address_s
    );

    control_unity_1 : control_unity port map (
        clk => clk,
        rst => rst,

        flag_zero_in => zero_flag_s,
        flag_zero_out => flag_zero_out_ctr,
        
        flag_overflow_in => overflow_flag_s, 
        flag_overflow_out => flag_overflow_out_ctr,
   
        flag_carry_in => carry_flag_s, 
        flag_carry_out => flag_carry_out_ctr,
        
        wr_enable_flags => wr_en_flags_ctr

        
    );
    
    three_state_machine_1 : three_state_machine port map (
        clk => clk,
        rst => rst,
        estado => estado_s
    );

    ram_1 : ram port map (
        clk => clk,
        endereco => endereco_ram,
        wr_en => wr_en_ram,
        dado_in => dado_in_ram,
        dado_out => dado_out_ram
    );



    opcode <= data_out_instruction_reg(15 downto 12);

    -- instruction_reg
    data_in_instruction_reg <= data_out_proto_control;
    wr_en_instruction_reg <= '1' when estado_s = "00";
    
    -- proto_control
    wr_en_proto_control <= '1' when estado_s = "10";
    branch_address_s <= data_out_instruction_reg(11 downto 5);
    is_branch_s <= '1' when opcode = "1000" else '0';
    is_relative_branch_s <= '1' when 
        (opcode = "1001" and flag_zero_out_ctr = '1') or 
        (opcode = "1010" and flag_overflow_out_ctr = '1') or 
        (opcode = "1011" and flag_carry_out_ctr = '1')
         else '0';

    -- reg_bank
    write_register_s <= data_out_instruction_reg(11 downto 9);
    rA_address <= data_out_instruction_reg(8 downto 6);
    const <= data_out_instruction_reg(8 downto 0);
    
    write_data_s <= data_out_accumulator when opcode = "0111" else 
    dado_out_ram when opcode = "1100" else
    "0000000" & data_out_instruction_reg(8 downto 0);

    -- ULA
    data_in_accumulator <= regA_data_out when opcode = "0110" else ULAOut_s;
    in_a <= data_out_accumulator;

    --RAM
    endereco_ram <= data_out_accumulator(6 downto 0);
    dado_in_ram <= regA_data_out(15 downto 0);
    wr_en_ram <= '1' when (opcode = "1101" and estado_s = "10") else '0';

    -- accumulator
    --wr_en_accumulator <= '1' when estado_s = "10" else '0';
    wr_en_accumulator <= '0' when estado_s = "00" or estado_s = "01" or
        opcode = "0001" or opcode = "0111" or opcode = "1000" or opcode = "1100" or opcode = "1101" or opcode = "1110" else '1';

    
    wr_en_s <= '1' when (opcode = "0001" or opcode = "0111" or opcode = "1100") and estado_s = "01" else '0';
    -- opcode "0001" = LD
    -- opcode "0010" = ADD
    -- opcode "0011" = ADDI
    -- opcode "0100" = SUB
    -- opcode "0101" = SUBI
    -- opcode "0110" = MOVA
    -- opcode "0111" = MOVR
    -- opcode "1000" = BRA
    -- opcode "1100" = LW 
    -- opcode "1101" = RW
    -- opcode "1110" = CMP

    -- ULA
    operation_ula <= "00" when opcode = "0010" or opcode = "0011" else "11" when opcode = "1111" else
        "01";
    in_b <= "0000000" & const when (opcode = "0011" or opcode = "0101") else -- and estado_s = "01" else
        regA_data_out; -- when estado_s = "01";-- when opcode = "0010" or opcode = "0100"

    -- Control Unity (flags)
    wr_en_flags_ctr <= '1' when (opcode = "0010" or opcode = "0011" or 
        opcode = "0100" or opcode = "0101" or opcode = "1110") and estado_s = "10" else '0'; -- escrever somente quando tem operações na ula
    

    --Wires
    estado_out <= estado_s;
    ULA_out <= ULAout_s;
    pc_out <= data_out_proto_control;
    instruction_reg_out <= data_out_instruction_reg;
    acumulador_out <= data_out_accumulator;


    
end architecture;
