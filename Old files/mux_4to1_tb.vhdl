library ieee;
use ieee.std_logic_1164.all;

--  A testbench has no ports.
entity mux_4to1_tb is
end mux_4to1_tb;

architecture behav of mux_4to1_tb is
--  Declaration of the component that will be instantiated.
component mux_4to1
    port(
        A,B,C,D : in STD_LOGIC_VECTOR(7 downto 0);
        S: in STD_LOGIC_VECTOR(1 downto 0);
        Z: out STD_LOGIC_VECTOR(7 downto 0)
     );
   end component;
--  Specifies which entity is bound with the component.
-- for shift_reg_0: shift_reg use entity work.shift_reg(rtl);
signal a,b,c,d,o : std_logic_vector(7 downto 0);
signal sel : std_logic_vector(1 downto 0);
begin
--  Component instantiation.
mux_4to1_0: mux_4to1 port map (A => a, B => b, C => c, D => d,S => sel, Z => o);

--  This process does the real job.
process
type pattern_type is record
--  The inputs of the shift_reg.


A,B,C,D: std_logic_vector(7 downto 0);
sel: std_logic_vector(1 downto 0);


--  The expected outputs of the shift_reg.
o: std_logic_vector (7 downto 0);
end record;
--  The patterns to apply.
type pattern_array is array (natural range <>) of pattern_type;
constant patterns : pattern_array :=
(("11111111", "11110000", "00001111", "00000000", "00", "11111111"),
("11111111", "11110000", "00001111", "00000000", "01", "11110000"),
("11111111", "11110000", "00001111", "00000000", "10", "00001111"),
("11111111", "11110000", "00001111", "00000000", "11", "00000000"));
begin
--  Check each pattern.
for n in patterns'range loop
--  Set the inputs.
A <= patterns(n).A;
B <= patterns(n).B;
C <= patterns(n).C;
D <= patterns(n).D;
sel <= patterns(n).sel;

--  Wait for the results.
wait for 1 ns;
--  Check the outputs.
assert o = patterns(n).o
report "bad output value" severity error;
end loop;
assert false report "end of test" severity note;
--  Wait forever; this will finish the simulation.
wait;
end process;
end behav;
