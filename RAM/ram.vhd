library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
------------------------------------------------------------------------
entity ram is
   port( 
         clk      : in std_logic;
         endereco : in unsigned(6 downto 0);
         wr_en    : in std_logic;
         dado_in  : in unsigned(15 downto 0);
         dado_out : out unsigned(15 downto 0) 
   );
end entity;
------------------------------------------------------------------------
architecture a_ram of ram is
   type mem is array (0 to 127) of unsigned(15 downto 0);
   signal conteudo_ram : mem :=(
        0 => B"0001_011_000000000",
        1 => B"0001_100_000000000", 
        2 => B"0110_000_000_000010", 
        3 => B"0000_000_000_000010",
        4 => B"0010_000_100_000000",
        5 => B"0111_100_000_000000", 
        6 => B"0110_000_000_000000", 
        7 => B"0011_000_000000001", 
        8 => B"0010_000_011_000000",
        9 => B"0111_011_000_000000",
        10 => B"0110_000_011_011110", 
        11 => B"0101_000_000011110",
        12 => B"1011_1110110_00000", 
        13 => B"0110_000_100_000000", 
        14 => B"0111_101_000_000000",
        others => (others=>'0')
    );
begin
   process(clk,wr_en)
   begin
      if rising_edge(clk) then
         if wr_en='1' then
            conteudo_ram(to_integer(endereco)) <= dado_in;
         end if;
      end if;
   end process;
   dado_out <= conteudo_ram(to_integer(endereco));
end architecture;