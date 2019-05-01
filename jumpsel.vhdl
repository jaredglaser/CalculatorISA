library ieee;
use ieee.std_logic_1164.all;

entity jumpsel is
port(	
        jcount: in std_logic;
        OP: in std_logic_vector(1 downto 0);
        DIST: in std_logic;
        clk: in std_logic;
        RD1, RD2: in std_logic_vector(7 downto 0);
        O: out std_logic_vector(1 downto 0)
);
end jumpsel;



architecture behav of jumpsel is
    
	signal feedback: std_logic_vector(1 downto 0) := "00";
    signal value: std_logic_vector(1 downto 0) := "00";

begin
   
process (clk, value) 
begin
   if(rising_edge(clk)) then
    O<= value;
    feedback <= value;
   end if;
end process;

process(Jcount, OP, DIST, feedback,RD1, RD2) 
begin
    --if(rising_edge(clk)) then
    if(feedback = "00") then --see if there is a comp instruction
        if(jcount = '1') and (OP = "11") and (DIST = '0') and (RD1 = RD2) then --it is a comp with jump 2
            value<= "10";
        
        elsif(jcount = '0') and (OP = "11") and (DIST = '0') and (RD1 = RD2) then --it is a comp with jump 1
            value<="01";
        
        else
            value<="00";
        end if;
    else --decrement the feedback
        if(feedback = "10") then
            value <= "01";
        elsif(feedback = "01") then
            value <= "00";
        end if;    
    end if;
    
    --end if;
end process;
end behav;

