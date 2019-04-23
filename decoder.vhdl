library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decoder is
    Port( c: in STD_LOCIG_VECTOR(7 downto 0);
    r1: out STD_LOGIC_VECTOR(1 downto 0);
    r2: out STD_LOGIC_VECTOR(1 downto 0);
    rd: out STD_LOGIC_VECTOR(1 downto 0);
    op: out STD_LOGIC_VECTOR(1 downto 0);
    regw: out STD_LOGIC;
    dist: out STD_LOGIC;
    imm: out STD_LOGIC_VECTOR(3 downto 0);
    jcount: out STD_LOGIC);
end decoder;

architecture behavioral of decoder is

begin
    if (C and "11000000" == "11000000") then --DISP or COMP
        op <= "11";
        dist <= C and "00100000";
        r1 <= C and "00011000";
        if(C and "00100000" == "00000000") then --This is a COMP    
            r2 <= C(2 downto 0); 
            jcount <= C and "00000001" --FIX + REPLACE WITH THE DOWNTO TINGIES
        end if;
    else -- EVERYTHING ELSE
        op <= C and "11000000";
        if(C and "11000000" == "00000000") then --LOAD
            rd <= C and "00110000";
            imm <= C and "00001111";
        else --EVERYTHING ELSE
            rd <= C and "00110000";
            r1 <= C and "00001100";
            r2 <= C and "00000011";
        end if;
    end if;
end behavioral;