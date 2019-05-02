library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity disp is 
    port(
        OP: in STD_LOGIC_VECTOR(1 downto 0);
        DIST: in STD_LOGIC;
        CLK: in STD_LOGIC;
        RD1: in STD_LOGIC_VECTOR(7 downto 0);
        SkipVal: in STD_LOGIC_VECTOR(1 downto 0)
    );
end disp;

architecture behav of disp is
    
begin 
    process(OP, DIST,RD1,clk, SkipVal) is
        variable int_val : integer;
        
    begin
    if(rising_edge(CLK)) then
        int_val := to_integer(signed(RD1));
        if((OP = "11") and (DIST = '1')) and (SkipVal = "00") then
        if(int_val >= 0) then
            if(int_val < 10) then
              report "000" & integer'image(int_val) severity note;
            elsif(int_val < 100) then
              report "00" & integer'image(int_val) severity note;
            else
              report "0" & integer'image(int_val) severity note;
            end if;
          else --Display value is negative
            if(int_val > -10) then
              report "00" & integer'image(int_val) severity note;
            elsif(int_val > -100) then
              report "0" & integer'image(int_val) severity note;
            else
              report integer'image(int_val) severity note;
            end if;
          end if;
          end if;
    end if;
    end process;
end behav;