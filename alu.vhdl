library ieee;
use ieee.std_logic_1164.all;

entity alu is
    port(
        OP: in STD_LOGIC_VECTOR(1 downto 0);
        RD1: in STD_LOGIC_VECTOR(7 downto 0);
        RD2: in STD_LOGIC_VECTOR(7 downto 0);
        RD: out STD_LOGIC_VECTOR(7 downto 0)
        --extend: out STD_LOGIC
);
end alu;

architecture behav of alu is
component addsub
Port ( A : in STD_LOGIC_VECTOR (7 downto 0);
B : in STD_LOGIC_VECTOR (7 downto 0);
Cin : in STD_LOGIC;
subt : in STD_LOGIC;
S : out STD_LOGIC_VECTOR (7 downto 0));
--overflow : out STD_LOGIC;
--Cout : out STD_LOGIC);
end component;

signal addorsub: STD_LOGIC; --maps directly to subt
--signal extend: STD_LOGIC; --passthrough value of RD1
--signal in1: STD_LOGIC(7 downto 0);
--signal in2: STD_LOGIC(7 downto 0);
signal cin: STD_LOGIC;

begin
    process(OP, RD1, RD2) is
    begin
    if(OP = "01") then
        addorsub<='0'; --add
    elsif(OP = "10") then
        addorsub<='1'; --sub
    else
        addorsub<='0'; --don't care, bypass ALU
    end if;
    cin<='0';
    end process;

    ALU1:addsub port map(RD1, RD2, cin, addorsub, RD);
    end behav;

        
