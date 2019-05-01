library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity disp_tb is
end disp_tb;

architecture behav of disp_tb is

    component disp
    port(
        OP: in STD_LOGIC_VECTOR(1 downto 0);
        DIST: in STD_LOGIC;
        CLK: in STD_LOGIC;
        RD1: in STD_LOGIC_VECTOR(7 downto 0);
        SkipVal: in STD_LOGIC_VECTOR(1 downto 0)
    );
    end component;

signal    OP:  STD_LOGIC_VECTOR(1 downto 0);
signal    DIST: STD_LOGIC;
signal    CLK: STD_LOGIC;
signal    RD1: STD_LOGIC_VECTOR(7 downto 0);
signal    SkipVal: STD_LOGIC_VECTOR(1 downto 0);

begin
    disp1: disp port map (OP,DIST,CLK,RD1,SkipVal);
process 
type pattern_type is record

OP:  STD_LOGIC_VECTOR(1 downto 0);
DIST: STD_LOGIC;
CLK: STD_LOGIC;
RD1:  STD_LOGIC_VECTOR(7 downto 0);
SkipVal: STD_LOGIC_VECTOR(1 downto 0);
end record;

type pattern_array is array (natural range <>) of pattern_type;
constant patterns : pattern_array :=
(("11",'0','0',"11111111","00"),
("11",'1','1',"11111111","00"), -- -1
("11",'0','0',"11111111","00"),
("11",'1','1',"01001110","00"), -- 78
("11",'0','0',"11111111","00"),
("11",'1','1',"10000000","00"), -- -128
("11",'0','0',"11111111","00"),
("11",'1','1',"01111111","00"), -- 127
("11",'0','0',"11111111","00"));--just print it out
begin

for n in patterns'range loop
OP<=patterns(n).OP;
DIST<=patterns(n).DIST;
SkipVal<=patterns(n).SkipVal;
RD1<=patterns(n).RD1;
wait for 0 ns;
CLK<=patterns(n).CLK;
wait for 1 ns;
end loop;
assert false report "end of test" severity note;
wait;
end process;
end behav;
