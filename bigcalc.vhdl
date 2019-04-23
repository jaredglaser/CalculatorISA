library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bigcalc is 
    signal pc: std_logic_vector(7 downto 0);
    signal reg_read_addr_1: std_logic_vector(1 downto 0);
    signal reg_read_addr_2: std_logic_vector(1 downto 0);
    signal  