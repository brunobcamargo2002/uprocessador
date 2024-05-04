library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top_level is
    port(
    clk, rst: in std_logic;

    --ULA inputs
    operation: in unsigned (1 downto 0);

    --Register Bank inputs
    read_0, read_1, write_register: in unsigned(2 downto 0);
    wr_en: in std_logic;

    cte: in unsigned(15 downto 0);
    mux_2: in std_logic;

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
    
    

    --ULA signals
    signal in_a, in_b, ULAout : unsigned(15 downto 0);
    signal is_zero : std_logic;


    --Register Bank signals
    signal read_data1: unsigned (15 downto 0);

begin 
    
    uut: ula port map ( operation => operation, 
    in_a => in_a, 
    in_b => in_b,
    ULAout => ULAout,
    is_zero => is_zero);

    reg_b: reg_bd port map(read_r0 => read_0, 
    read_r1 => read_1, 
    wr_en => wr_en,
    write_register => write_register, 
    write_data => ULAout,  
    clk => clk, 
    rst => rst,
    read_data0 => in_a, 
    read_data1 => read_data1,
    --wires
    r0 => r0, r2 => r2, r3 => r3, r4 => r4, r5 => r5, r6 => r6, r7 => r7);

    --mux in_b of ula
    in_b <= read_data1 when mux_2='0' else cte;

    --Wires
    ULA_out <= ULAout;
    zero_flag <= is_zero;


end architecture;
