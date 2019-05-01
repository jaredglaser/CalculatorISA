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
("01100001", '0'),
("01100001", '1'), --add $r2 $r0 $r1
("00010001", '0'),
("00010001", '1'), --load $r1 1
("01000110", '0'),
("01000110", '1'), --add $r0 $r1 $r2
("00000000", '0'),
("11100000", '1')); --display final value of $r0: 15.
begin

for n in patterns'range loop
i<=patterns(n).i;
wait for 0 ns;
clk<=patterns(n).clk;
wait for 1 ns;
if n /= 0 then
end if;
end loop;
assert false report "end of test" severity note;
wait;
end process;
end behav;