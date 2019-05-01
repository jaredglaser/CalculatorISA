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
    
	signal value: std_logic_vector(1 downto 0) := "00";
    signal feedback: std_logic_vector(1 downto 0) := "00";

begin
   
process (clk, value) 
begin
   if(rising_edge(clk)) then
    O<= feedback;
    value <= feedback;
   end if;
end process;

process(Jcount, OP, DIST, value,RD1, RD2) 
begin
    --if(rising_edge(clk)) then
    if(feedback = "00") then --see if there is a comp instruction
        if(jcount = '1') and (OP = "11") and (DIST = '0') and (RD1 = RD2) then --it is a comp with jump 2
            feedback<= "10";
        
        elsif(jcount = '0') and (OP = "11") and (DIST = '0') and (RD1 = RD2) then --it is a comp with jump 1
            feedback<="01";
        
        else
            feedback<="00";
        end if;
    else --decrement the value
        if(feedback = "10") then
            feedback <= "01";
        elsif(feedback = "01") then
            feedback <= "00";
        end if;    
    end if;
    
    --end if;
end process;
end behav;

