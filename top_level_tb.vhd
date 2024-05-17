library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top_level_tb is
end entity;

architecture a_top_level_tb of top_level_tb is
    
    component top_level
        port (
            clk, rst: in std_logic;
            --operation: in unsigned (1 downto 0);
            --read_0, read_1, write_register: in unsigned(2 downto 0);
            --wr_en: in std_logic;
            --cte: in unsigned(15 downto 0);
            --mux_2: in std_logic;
            ULA_out: out unsigned (15 downto 0);
            zero_flag: out std_logic;
            r0, r1, r2, r3, r4, r5, r6, r7: out unsigned(15 downto 0) 
        );
    end component; 
    --ULA
    signal operation : unsigned(1 downto 0);
    signal in_a, in_b, ULAout : unsigned(15 downto 0);
    signal is_zero : std_logic;

    --Mux_2
    signal mux_2: std_logic;

    --Register Bank signals
    signal read_0, read_1, write_register: unsigned(2 downto 0);
    signal read_data1, cte: unsigned (15 downto 0);
    signal wr_en: std_logic;

    constant period_time : time      := 50 ns;
    signal   finished    : std_logic := '0';
    signal clk, rst: std_logic;

    --WIRES--
    signal ULA_out: unsigned (15 downto 0);
    signal zero_flag: std_logic;
    signal r0, r1, r2, r3, r4, r5, r6, r7: unsigned(15 downto 0) ;
    

begin 
    tp_lvl: top_level port map(clk => clk,
    rst => rst,
    --operation => operation,
    --read_0 => read_0,
    --read_1 => read_1,
    --write_register => write_register,
    --wr_en => wr_en,
    --cte => cte,
    --mux_2 => mux_2,
    ULA_out => ULA_out,
    zero_flag => zero_flag,
    r0 => r0, r1 => r1, r2 => r2, r3 => r3, 
    r4 => r4, r5 => r5, r6 => r6, r7 => r7
    );

    in_b <= read_data1 when mux_2='0' else cte;
    
        reset_global: process
        begin
            rst <= '1';
            wait for period_time*2; -- espera 2 clocks, pra garantir
            rst <= '0';
            wait;
        end process;
        
        sim_time_proc: process
        begin
            wait for 4 us;         -- <== TEMPO TOTAL DA SIMULAÇÃO!!!
            finished <= '1';
            wait;
        end process sim_time_proc;


        clk_proc: process
        begin                       -- gera clock até que sim_time_proc termine
            while finished /= '1' loop
                clk <= '0';
                wait for period_time/2;
                clk <= '1';
                wait for period_time/2;
            end loop;
            wait;
        end process clk_proc;


       process                      -- sinais dos casos de teste (p.ex.)
       begin
        wait;
       end process;


       
end architecture;

