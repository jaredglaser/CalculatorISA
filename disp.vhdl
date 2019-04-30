library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library std;
use std.textio.ALL;

entity disp is 
    port(
        OP: in STD_LOGIC_VECTOR(1 downto 0);
        DIST: in STD_LOGIC;
        RD1: in STD_LOGIC_VECTOR(7 downto 0)
    );
end disp;

architecture behav of disp is

begin 
    process(OP, DIST) is
        variable my_line : line;
    begin
    if((OP = "11") and (DIST = '1')) then
        Hwrite(my_line, RD1);
        writeline(OUTPUT, my_line);
    else
    end if;
    end process;
end behav;