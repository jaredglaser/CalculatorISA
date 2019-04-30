library ieee;
use ieee.std_logic_1164.all;

--  A testbench has no ports.
entity register_tb is
end register_tb;

architecture behav of register_tb is
--  Declaration of the component that will be instantiated.
component myregister
port(	
		R1: in std_logic_vector(1 downto 0); 
		R2: in std_logic_vector(1 downto 0);
		OP: in std_logic_vector(1 downto 0);
		DIST: in std_logic;
		CLK: in std_logic; 
		WR: in std_logic_vector(7 downto 0); 
        REG_WRITE: in std_logic;
        RD: in std_logic_vector(1 downto 0);
		RD1: out std_logic_vector(7 downto 0); 
		RD2:	out std_logic_vector(7 downto 0) 
);
end component;
--  Specifies which entity is bound with the component.
-- for shift_reg_0: shift_reg use entity work.shift_reg(rtl);
signal wr,rd1,rd2 : std_logic_vector(7 downto 0);
signal dist, clk, reg_write: std_logic;
signal r1,r2,op,rd : std_logic_vector(1 downto 0);
begin
--  Component instantiation.
register1: myregister port map (r1, r2, op, dist, clk, wr,  reg_write,rd, rd1, rd2);

--  This process does the real job.
process
type pattern_type is record
--  The inputs of the shift_reg.
r1,r2: std_logic_vector (1 downto 0);
op : std_logic_vector(1 downto 0);
dist, clk: std_logic;
WR : std_logic_vector (7 downto 0);
reg_write: std_logic;
RD: std_logic_vector(1 downto 0);
rd1,rd2: std_logic_vector(7 downto 0);

end record;
--  The patterns to apply.
type pattern_array is array (natural range <>) of pattern_type;
constant patterns : pattern_array :=
(("00","00","01",'0','0',"00000000",'0',"00","00000000","00000000"), --clock cycle
("00","00","00",'0','0',"11111111",'0',"00","00000000","00000000"), --load 11111111 into r0
("00","00","01",'0','0',"00000000",'0',"00","00000000","00000000"), --clock cycle
("00","00","00",'0','1',"11111111",'1',"00","00000000","00000000"), --load 11111111 into r0
("00","00","01",'0','0',"00000000",'0',"00","00000000","00000000"), --clock cycle
("00","01","01",'0','1',"00000000",'0',"00","11111111","00000000")); --add instruction that reads r0 and r1
begin
--  Check each pattern.
for n in patterns'range loop
--  Set the inputs.
r1 <= patterns(n).r1;
r2 <= patterns(n).r2;
op <= patterns(n).op;
dist <= patterns(n).dist;
clk <= patterns(n).clk;
WR <= patterns(n).WR;
reg_write<= patterns(n).reg_write;
RD <= patterns(n).RD;
rd1 <= patterns(n).rd1;
rd2 <= patterns(n).rd2;
--  Wait for the results.
wait for 1 ns;
--  Check the outputs.
if n /= 0 then --ignore the first pattern since it is used to set clock to low and the output is still undefined
assert rd1 = patterns(n).rd1
report "bad rd1 value" severity error;
assert rd2 = patterns(n).rd2
report "bad rd2 value" severity error;
end if;
end loop;
assert false report "end of test" severity note;
--  Wait forever; this will finish the simulation.
wait;
end process;
end behav;
