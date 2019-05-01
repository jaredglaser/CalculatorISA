library ieee;
use ieee.std_logic_1164.all;

entity bigcalc_tb is
end bigcalc_tb;

architecture behav of bigcalc_tb is

component bigcalc
port(
    I: in std_logic_vector(7 downto 0);
    CLK: in std_logic
);
end component;

signal i: std_logic_vector(7 downto 0);
signal clk: std_logic;
begin

bigcalc1: bigcalc port map (i, clk);

process
type pattern_type is record

i: std_logic_vector(7 downto 0);
clk: std_logic;

end record;

type pattern_array is array (natural range <>) of pattern_type;
constant patterns : pattern_array :=
(("00000111", '0'), 
("00000111", '1'), --load $r0 7
("00010111", '0'), 
("00010111", '1'), --load $r1 7
("01000001", '0'),
("01000001", '1'), --add $r0 $r0 $r1
("11100000", '0'),
("11100000", '1'), --display $r0 14
("00000111", '0'), 
("00000111", '1'), --load $r0 7
("11000011", '0'),
("11000011", '1'), --skip 2
("00010001", '0'),
("00010001", '1'), --load $r1 1 SKIPPED
("01000110", '0'),
("01000110", '1'), --add $r0 $r1 $r0 SKIPPED
("11000010", '0'),
("11000010", '1'), -- skip 1
("01000101", '0'),
("01000101", '1'), --add $r0 $r0 $r1 SKIPPED
("01000101", '0'),
("01000101", '1'), --add $r0 $r0 $r1 = 14
("11100000", '0'),
("11100000", '1'), --display final value of $r0: 14.
("00000111", '0'),
("00000111", '1'), --load $r0 7
("11100000", '0'),
("11100000", '1'), --display r0 - 7
("11101000", '0'),
("11101000", '1'), --display r1 - 7
("11000010", '0'),
("11000010", '1'), --skip 1 since r0 and r1 are 7
("00000000", '0'),
("00000000", '1'), --load r0 to 0 SKIPPED
("11100000", '0'),
("11100000", '1'), --display final value of r0 7
("11000010", '0'),
("11000010", '1'), --skip 1 since r0 and r1 are 7
("11100000", '0'),
("11100000", '1'), --display final value of r0 7 SKIPPED
------ANDREW TEST
("00000111", '0'),
("00000111", '1'), --load $r0 7
("00010111", '0'),
("00010111", '1'), --load $r1 7
("01100001", '0'),
("01100001", '1'), --add $r2 $r0 $r1
("00010001", '0'),
("00010001", '1'), --load $r1 1
("01000110", '0'),
("01000110", '1'), --add $r0 $r1 $r2
("00000000", '0'),
("11100000", '1'), --display final value of $r0: 15.
--An example of how we would fight overflow by subtracting positive numbers instead
--of adding negative numbers which would cause an overflow.
("00011100", '0'),
("00011100", '1'), --load $r1 -4
("00101000", '0'),
("00101000", '1'), --load $r2 -8
("01111001", '0'),
("01111001", '1'), --add $r3 $r2 $r1 , $r3 = -8 +-4 = -12
("00001001", '0'),
("00001001", '1'), --load $r0 -7
("01010011", '0'),
("01010011", '1'), --add $r1 $r0 $r3, $r1 = -7 +-12 = -19
("11101000", '0'),
("11101000", '1')); --display final value: -19


begin

for n in patterns'range loop
i<=patterns(n).i;
wait for 0 ns;
clk<=patterns(n).clk;
wait for 1 ns;

end loop;
assert false report "end of test" severity note;
wait;
end process;
end behav;