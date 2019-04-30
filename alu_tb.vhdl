library ieee;
use ieee.std_logic_1164.all;
entity alu_tb is 
end alu_tb;
architecture behav of alu_tb is

component alu
port(
        OP: in STD_LOGIC_VECTOR(1 downto 0);
        RD1: in STD_LOGIC_VECTOR(7 downto 0);
        RD2: in STD_LOGIC_VECTOR(7 downto 0);
        RD: out STD_LOGIC_VECTOR(7 downto 0);
        extend: out STD_LOGIC
);
end component;

signal OP:  STD_LOGIC_VECTOR(1 downto 0);
signal RD1: STD_LOGIC_VECTOR(7 downto 0);
signal RD2:  STD_LOGIC_VECTOR(7 downto 0);
signal RD:  STD_LOGIC_VECTOR(7 downto 0);
signal extend:  STD_LOGIC;

begin

process
type pattern_type is record
OP:  STD_LOGIC_VECTOR(1 downto 0);
RD1:  STD_LOGIC_VECTOR(7 downto 0);
RD2:  STD_LOGIC_VECTOR(7 downto 0);
RD:  STD_LOGIC_VECTOR(7 downto 0);
extend:  STD_LOGIC;
end record;

type pattern_array is array (natural range <>) of pattern_type;
constant patterns : pattern_array :=
(("01", "10010000", "01101101", "11111101", '0'), --add 144+109=253
("10", "10010000", "01101101", "00100011", '0'), --subtract 144-109=35
("10", "10010000", "01101101", "11011101", '1')); --subtract 109-144=-35 
begin

for n in patterns'range loop
OP<=patterns(n).OP;
RD1<=patterns(n).RD1;
RD2<=patterns(n).RD2;
RD<=patterns(n).RD;
extend<=patterns(n).extend;

wait for 1 ns;
assert OP<=patterns(n).OP report "bad OP" severity error;
assert RD1<=patterns(n).RD1 report "bad RD1" severity error;
assert RD2<=patterns(n).RD2 report "bad RD2" severity error;
assert RD<=patterns(n).RD report "bad RD" severity error;
assert extend<=patterns(n).extend report "bad extend" severity error;
end loop;
assert false report "end of test" severity note;
wait;
end process;
end behav;
