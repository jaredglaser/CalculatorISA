library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decoder is
    port( 
        c: in STD_LOGIC_VECTOR(7 downto 0);
        r1: out STD_LOGIC_VECTOR(1 downto 0);
        r2: out STD_LOGIC_VECTOR(1 downto 0);
        rd: out STD_LOGIC_VECTOR(1 downto 0);
        op: out STD_LOGIC_VECTOR(1 downto 0);
        regw: out STD_LOGIC;
        dist: out STD_LOGIC;
        imm: out STD_LOGIC_VECTOR(3 downto 0);
        jcount: out STD_LOGIC
    );
end decoder;

architecture behavioral of decoder is

begin
    process(C) is
    begin
    if ((C and "11000000") = "11000000") then --DISP or COMP
        op <= "11";
        regw<='0'; --no writing to regs
        imm<="0000"; --no immediate ever
        dist <= C(6);--and "00100000";
        r1 <= C(4 downto 3);--and "00011000";
        jcount <= C(0);
        if((C and "00100000") = "00000000") then --This is a COMP    
            r2 <= C(2 downto 0);
        else
            r2<="00"; --default? 
        end if;
    else -- EVERYTHING ELSE
        op <= C(7 downto 6);-- and "11000000";
        regw<= '1';
        jcount<='0';
        dist<='0';
        if((C and "11000000") = "00000000") then --LOAD
            rd <= C(5 downto 4);--and "00110000";
            imm <= C(3 downto 0);--and "00001111";
            r1<="00";
            r2<="00";
        else --ADD, SUB
            rd <= C(5 downto 4);--and "00110000";
            r1 <= C(3 downto 2);--and "00001100";
            r2 <= C(1 downto 0); --and "00000011";
            imm<="0000";
        end if;
    end if;
    end process;
end behavioral;