library ieee;
use ieee.std_logic_1164.all;

entity decoder_tb is
end decoder_tb;

architecture behav of decoder_tb is

signal c: STD_LOGIC_VECTOR(7 downto 0);

signal r1: STD_LOGIC_VECTOR(1 downto 0);
signal r2: STD_LOGIC_VECTOR(1 downto 0);
signal rd: STD_LOGIC_VECTOR(1 downto 0);
signal op: STD_LOGIC_VECTOR(1 downto 0);
signal regw: STD_LOGIC;
signal dist: STD_LOGIC;
signal imm: STD_LOGIC_VECTOR(3 downto 0);
signal jcount: STD_LOGIC;

begin

process
type pattern_type is record

c: STD_LOGIC_VECTOR(7 downto 0);

r1: STD_LOGIC_VECTOR(1 downto 0);
r2: STD_LOGIC_VECTOR(1 downto 0);
rd: STD_LOGIC_VECTOR(1 downto 0);
op: STD_LOGIC_VECTOR(1 downto 0);
regw: STD_LOGIC;
dist: STD_LOGIC;
imm: STD_LOGIC_VECTOR(3 downto 0);
jcount: STD_LOGIC;
end record;

type pattern_array is array (natural range <>) of pattern_type;
constant patterns : pattern_array :=
(("01110110","01","10","11","01",'1','0',"0000",'0'), --add to 11 registers 01 and 10 respectively.
("10001110","11","10","00","10",'1','0',"0000",'0'), --subt to 00 registers 11 10
("00110011","00","00","11","00",'1','0',"0011",'0'), --load to 11 0011
("11011001","11","01","00","11",'0','0',"0000",'1'), --comp 11 and 00, jcount = 1
("11100000","00","00","00","11",'0','1',"0000",'0')); --disp register 00
begin

for n in patterns'range loop
c<=patterns(n).c; --no declaration for c
r1<=patterns(n).r1;
r2<=patterns(n).r2;
rd<=patterns(n).rd;
op<=patterns(n).op;
regw<=patterns(n).regw;
dist<=patterns(n).dist;
imm<=patterns(n).imm;
jcount<=patterns(n).jcount;

wait for 1 ns;

assert r1<=patterns(n).r1 report "bad r1" severity error;
assert r2<=patterns(n).r2 report "bad 2" severity error;
assert rd<=patterns(n).rd report "bad rd" severity error;
assert op<=patterns(n).op report "bad op" severity error;
assert regw<=patterns(n).regw report "bad regw" severity error;
assert dist<=patterns(n).dist report "bad dist" severity error;
assert imm<=patterns(n).imm report "bad imm" severity error;
assert jcount<=patterns(n).jcount report "bad jcount" severity error;

end loop;
assert false report "end of test" severity note;
wait;
end process;
end behav;