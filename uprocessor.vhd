library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uprocessor is
end entity;

architecture a_uprocessor of uprocessor is
    component ula
        port (
            operation : in unsigned(1 downto 0);
            in_a : in unsigned(15 downto 0);
            in_b : in unsigned(15 downto 0);
            saida : out unsigned(15 downto 0);
            is_zero: out std_logic
        );
    end component;

    component reg_bd
        port(
            read_r0: in unsigned(2 downto 0);
            read_r1: in unsigned(2 downto 0);
            write_enable: in std_logic;
            write_register: in unsigned(2 downto 0);
            write_data: in unsigned(15 downto 0);
            clk: in std_logic;
            rst: in std_logic;
            read_data0: out unsigned(15 downto 0); 
            read_data1: out unsigned(15 downto 0)
        );
    end component;
    
    

    --ULA
    signal operation : unsigned(1 downto 0);
    signal in_a, in_b, saida : unsigned(15 downto 0);
    signal is_zero : std_logic;

    --Mux_2
    signal mux_2: std_logic;

    --Register Bank signals
    signal read_0, read_1, write_register: unsigned(2 downto 0);
    signal read_data1, cte: unsigned (15 downto 0);
    signal write_enable: std_logic;

    constant period_time : time      := 100 ns;
    signal   finished    : std_logic := '0';
    signal clk, rst: std_logic;
    

begin 
    uut: ula port map ( operation => operation, in_a => in_a, in_b => in_b, saida => saida, is_zero => is_zero);
    reg_b: reg_bd port map(read_r0 => read_0, read_r1 => read_1, write_register => write_register, write_data => saida, read_data0 => in_a, read_data1 => read_data1, clk => clk, rst => rst, write_enable => write_enable);

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
            wait for 10 us;         -- <== TEMPO TOTAL DA SIMULAÇÃO!!!
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
         --addi beg5, zero, 5
        wait for 200 ns;
        write_enable <= '0';
        wait for 100 ns;
        read_0 <="000";
        mux_2 <= '1';
        cte <= "0000000000000101";
        operation <= "00";
        write_register <= "101";
        wait for 100 ns;
        write_enable <= '1';
        

         --addi reg3, beg5, 7
         wait for 100 ns;
         write_enable <= '0';
         wait for 100 ns;
         read_0 <="101";
         mux_2 <= '1';
         cte <= "0000000000000111";
         operation <= "00";
         write_register <= "100";
         wait for 100 ns;
         write_enable <= '1';

        --sub reg7, reg3, beg5
         wait for 100 ns;
         write_enable <= '0';
         wait for 100 ns;
         read_0 <="101";
         read_1 <="100";
         mux_2 <= '0';
         operation <= "01";
         write_register <= "111";
         wait for 100 ns;
         write_enable <= '1';
         wait;
       end process;

       
end architecture;

