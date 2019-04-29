library ieee;
use ieee.std_logic_1164.all;

--  A testbench has no ports.
entity shift_reg_tb_8bit is
end shift_reg_tb_8bit;

architecture behav of shift_reg_tb_8bit is
--  Declaration of the component that will be instantiated.
component shift_reg_8bit
port (	I:	in std_logic_vector (7 downto 0);
		I_SHIFT_IN: in std_logic;
		sel:        in std_logic_vector(1 downto 0); -- 00:hold; 01: shift left; 10: shift right; 11: load
		clock:		in std_logic; 
		enable:		in std_logic;
		shiftin: in std_logic_vector(1 downto 0);
		O:	out std_logic_vector(7 downto 0)
);
end component;
--  Specifies which entity is bound with the component.
-- for shift_reg_0: shift_reg use entity work.shift_reg(rtl);
signal i, o : std_logic_vector(7 downto 0);
signal i_shift_in, clk, enable : std_logic;
signal sel,shiftin : std_logic_vector(1 downto 0);
begin
--  Component instantiation.
shift_reg_0: shift_reg_8bit port map (I => i, I_SHIFT_IN => i_shift_in, sel => sel, clock => clk, enable => enable, shiftin => shiftin, O => o);

--  This process does the real job.
process
type pattern_type is record
--  The inputs of the shift_reg.
i: std_logic_vector (7 downto 0);
i_shift_in, clock, enable: std_logic;
sel,shiftin: std_logic_vector(1 downto 0);
--  The expected outputs of the shift_reg.
o: std_logic_vector (7 downto 0);
end record;
--  The patterns to apply.
type pattern_array is array (natural range <>) of pattern_type;
constant patterns : pattern_array :=
(("00000000", '1', '0', '1', "00", "00", "00000000"),
("01110000", '0', '1', '1', "11", "00", "01110000"), --1st rising edge loading 0001 into the shift reg
("00000000", '1', '0', '1', "11", "00", "01110000"),
("00000000", '0', '1', '1', "01", "00", "11100000"), --2nd rising edge shifting left (shift in 0)
("00000000", '1', '0', '1', "11", "00", "11100000"),
("00000000", '0', '1', '1', "10", "00", "01110000"), --3rd rising edge shifting right (shift in 0)
("00000000", '1', '0', '1', "11", "00", "01110000"),
("00000000", '1', '1', '1', "01", "00", "11100001"), -- 4th rising edge shifting left (shift in 1)
("00000000", '1', '0', '1', "11", "00", "11100001"),
("00000000", '1', '1', '1', "10", "00", "11110000"), --5th rising edge shifting right (shift in 1)
("00000000", '1', '0', '1', "11", "00", "11110000"),
("00100000", '0', '1', '1', "11", "01", "01000000"), --6th rising edge shifting input left (shift in 0)
("00000000", '1', '0', '1', "11", "00", "01000000"),
("00100000", '1', '1', '0', "11", "01", "01000000"), --7th NO ENABLE  rising edge shifting input left (shift in 1)
("00000000", '1', '0', '0', "11", "00", "01000000"),
("00100000", '0', '1', '1', "11", "10", "00010000"), --8th rising edge shifting input right (shift in 0)
("00000000", '1', '0', '1', "11", "00", "00010000"));
begin
--  Check each pattern.
for n in patterns'range loop
--  Set the inputs.
i <= patterns(n).i;
i_shift_in <= patterns(n).i_shift_in;
sel <= patterns(n).sel;
clk <= patterns(n).clock;
enable <= patterns(n).enable;
shiftin <= patterns(n).shiftin;
O <= patterns(n).o;
--  Wait for the results.
wait for 1 ns;
--  Check the outputs.
if n /= 0 then --ignore the first pattern since it is used to set clock to low and the output is still undefined
assert o = patterns(n).o
report "bad output value" severity error;
end if;
end loop;
assert false report "end of test" severity note;
--  Wait forever; this will finish the simulation.
wait;
end process;
end behav;
