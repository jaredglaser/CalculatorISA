library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity disp is 
    port(
        OP: in STD_LOGIC_VECTOR(1 downto 0);
        DIST: in STD_LOGIC;
        CLK: in STD_LOGIC;
        RD1: in STD_LOGIC_VECTOR(7 downto 0)
    );
end disp;

architecture behav of disp is
    
begin 
    process(OP, DIST,RD1,clk) is
        variable int_val : integer;
        
    begin
    if(rising_edge(CLK)) then
        int_val := to_integer(signed(RD1));
        if((OP = "11") and (DIST = '1')) then
            report " " & integer'image(int_val) severity note;
        end if;
    end if;
    end process;
end behav;