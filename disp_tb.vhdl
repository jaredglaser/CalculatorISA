library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity dist_tb is
end dist_tb;

architecture behav of dist_tb is

signal    OP: in STD_LOGIC_VECTOR(1 downto 0);
signal    DIST: in STD_LOGIC;
signal    RD1: in STD_LOGIC_VECTOR(7 downto 0);

begin

process 
type pattern_type is record

OP:  STD_LOGIC_VECTOR(1 downto 0);
DIST: STD_LOGIC;
RD1:  STD_LOGIC_VECTOR(7 downto 0);
end record;

type pattern_array is array (natural range <>) of pattern_type;
constant patterns : pattern_array :=
(("11",'1',"11111111")); --just print it out
begin

for n in patterns'range loop
OP<=patterns(n).OP;
DIST<=patterns(n).DIST;
RD1<=patterns(n).RD1;

wait for 1 ns;
end loop;
assert false report "end of test" severity note;
wait;
end process;
end behav;
