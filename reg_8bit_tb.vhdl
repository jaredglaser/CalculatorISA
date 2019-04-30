library ieee;
use ieee.std_logic_1164.all;

--  A testbench has no ports.
entity register_8bit_tb is
end register_8bit_tb;

architecture behav of register_8bit_tb is
--  Declaration of the component that will be instantiated.
component reg_8bit
port(	
    I:	in std_logic_vector (7 downto 0); -- for loading
    clock:		in std_logic; -- positive level triggering in problem 3
    enable: in std_logic;
    O:	out std_logic_vector(7 downto 0) -- output the current register content
);
end component;
--  Specifies which entity is bound with the component.
-- for shift_reg_0: shift_reg use entity work.shift_reg(rtl);
signal I : std_logic_vector(7 downto 0);
signal clock,enable: std_logic;
signal O : std_logic_vector(7 downto 0);
begin
--  Component instantiation.
register1: reg_8bit port map (I,clock, enable,O);

--  This process does the real job.
process
type pattern_type is record
--  The inputs of the shift_reg.
I: std_logic_vector(7 downto 0);
clock,enable: std_logic;
O : std_logic_vector(7 downto 0);

end record;
--  The patterns to apply.
type pattern_array is array (natural range <>) of pattern_type;
constant patterns : pattern_array :=
(("00000000",'0','0',"00000000"), --clock cycle
("11111111",'1','1',"11111111"), --load 1111111
("00000000",'0','0',"11111111"), --should hold value
("00000000",'1','0',"11111111"),
("00000000",'0','0',"11111111"),
("10101010",'1','1',"10101010"), --set new value
("00000000",'0','0',"10101010"), --should hold value
("00000000",'1','0',"10101010"));
begin
--  Check each pattern.
for n in patterns'range loop
--  Set the inputs.
I <= patterns(n).I;
clock <= patterns(n).clock;
enable <= patterns(n).enable;
O <= patterns(n).O;
--  Wait for the results.
wait for 1 ns;
--  Check the outputs.
if n /= 0 then --ignore the first pattern since it is used to set clock to low and the output is still undefined
assert O = patterns(n).O
report "bad output value" severity error;
end if;
end loop;
assert false report "end of test" severity note;
--  Wait forever; this will finish the simulation.
wait;
end process;
end behav;
