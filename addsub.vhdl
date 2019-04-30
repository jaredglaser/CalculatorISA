library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity addsub is
Port ( A : in STD_LOGIC_VECTOR (7 downto 0);
B : in STD_LOGIC_VECTOR (7 downto 0);
Cin : in STD_LOGIC;
subt : in STD_LOGIC;
S : out STD_LOGIC_VECTOR (7 downto 0);
overflow : out STD_LOGIC);
--Cout : out STD_LOGIC);
end addsub;

architecture Behavioral of addsub is

-- Full Adder VHDL Code Component Decalaration
component fulladder
Port ( A : in STD_LOGIC;
B : in STD_LOGIC;
Cin : in STD_LOGIC;
S : out STD_LOGIC;
Cout : out STD_LOGIC);
end component;

-- Intermediate Carry declaration
signal c1,c2,c3,c4,c5,c6,c7,c8: STD_LOGIC;
signal xor0, xor1, xor2, xor3,xor4,xor5,xor6,xor7: STD_LOGIC;
signal cout: STD_LOGIC;
begin
xor0 <= B(0) xor subt; 
xor1 <= B(1) xor subt;
xor2 <= B(2) xor subt;
xor3 <= B(3) xor subt;
xor4 <= B(4) xor subt; 
xor5 <= B(5) xor subt;
xor6 <= B(6) xor subt;
xor7 <= B(7) xor subt;
cout<='0';
-- Port Mapping Full Adder 4 times
FA1: fulladder port map( A(0), xor0, subt, S(0), c1); --S0
FA2: fulladder port map( A(1), xor1, c1, S(1), c2); --S1
FA3: fulladder port map( A(2), xor2, c2, S(2), c3); --S2
FA4: fulladder port map( A(3), xor3, c3, S(3), c4); --S3
FA5: fulladder port map( A(4), xor4, c4, S(4), c5); --S4
FA6: fulladder port map( A(5), xor5, c5, S(5), c6); --S5
FA7: fulladder port map( A(6), xor6, c6, S(6), c7); --S6
FA8: fulladder port map( A(7), xor7, c7, S(7), Cout); --S7
overflow <= c7 XOR c8;
--Cout <= c8;
end Behavioral;