library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity addsub is
Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
B : in STD_LOGIC_VECTOR (3 downto 0);
Cin : in STD_LOGIC;
subt : in STD_LOGIC;
S : out STD_LOGIC_VECTOR (3 downto 0);
overflow : out STD_LOGIC;
Cout : out STD_LOGIC);
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
signal c1,c2,c3,c4: STD_LOGIC;
signal xor0, xor1, xor2, xor3: STD_LOGIC;

begin
xor0 <= B(0) xor subt; 
xor1 <= B(1) xor subt;
xor2 <= B(2) xor subt;
xor3 <= B(3) xor subt;
-- Port Mapping Full Adder 4 times
FA1: fulladder port map( A(0), xor0, subt, S(0), c1); --S0
FA2: fulladder port map( A(1), xor1, c1, S(1), c2); --S1
FA3: fulladder port map( A(2), xor2, c2, S(2), c3); --S2
FA4: fulladder port map( A(3), xor3, c3, S(3), Cout); --S3
overflow <= c3 XOR c4;
Cout <= c4;
end Behavioral;