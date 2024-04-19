library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg_bd is
    port(
        read_r1: in unsigned();
        read_r2: in unsigned();
        write_enable: in std_logic;
        write_register: in unsigned(3 downto 0);
        write_data: in unsigned(15 downto 0);
        clk: in std_logic;
        rst: in std_logic;
        read_data0: out unsigned(15 downto 0); 
        read_data1: out unsigned(15 downto 0); 
    );
end entity;