library ieee;
use ieee.std_logic_1164.all;

entity addsub_tb is
end addsub_tb;

architecture behav of addsub_tb is

component addsub
Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
B : in STD_LOGIC_VECTOR (3 downto 0);
Cin : in STD_LOGIC;
subt : in STD_LOGIC;
S : out STD_LOGIC_VECTOR (3 downto 0);
overflow : out STD_LOGIC;
Cout : out STD_LOGIC);
end component;

signal a: STD_LOGIC_VECTOR(3 downto 0);
signal b: STD_LOGIC_VECTOR(3 downto 0);
signal subt: STD_LOGIC;
signal s : STD_LOGIC_VECTOR(3 downto 0);
signal cout : STD_LOGIC;
signal over : STD_LOGIC;

BEGIN
--component instantiation
addsub0 : addsub port map (A=>a, B=>b, subt=>subt, S=>s, overflow=>over, Cout=>cout);

process
type pattern_type is record
--the inputs of the add/subtract
A,B: STD_LOGIC_VECTOR(3 downto 0);
subt: STD_LOGIC;

--the outputs
s:std_logic_vector (3 downto 0);
over:std_logic;
cout:std_logic;
end record;

type pattern_array is array (natural range <>) of pattern_type;
constant patterns : pattern_array :=
(("1000", "0100", '0', "1100", '0', '0'),
("1000", "0100", '1',"0100",'0','1'),
("0001","0010",'1',"1111",'1','0'),
("0001","0010",'0',"0011",'0','0'),
("0101","1010",'1',"1011",'1','0')); -- -5-10 = -5 (signed)
begin

for n in patterns'range loop
A<=patterns(n).A;
B<=patterns(n).B;
subt<=patterns(n).subt;
over<=patterns(n).over;
cout<=patterns(n).cout;

wait for 1 ns;

assert cout =patterns(n).cout;
assert over = patterns(n).over;
assert s=patterns(n).s;
report "bad output value" severity error;
end loop;
assert false report "end of test" severity note;
wait;
end process;
end behav;
