-- entradas
-- i0, i1
-- saidas
-- o0, o1, o2, o3

entity decoder2x4 is
    port (
        i0 : in std_logic;
        i1 : in std_logic;
        o0 : out std_logic;
        o1 : out std_logic;
        o2 : out std_logic;
        o3 : out std_logic
    );
end entity;

architecture a_decoder2x4 of decoder2x4 is
begin 
    saida <= (a and not d0 and not d1) or
        (b and not d0 and d1) or
        (c and d0 and not d1) or
        (d and d0 and d1);
end architecture;
