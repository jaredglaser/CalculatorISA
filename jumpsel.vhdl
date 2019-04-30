library ieee;
use ieee.std_logic_1164.all;

entity jumpsel is
port(	
        jcount: in std_logic;
        OP: in std_logic_vector(1 downto 0);
        DIST: in std_logic;
        Feedback: in std_logic_vector(1 downto 0);
        clk: in std_logic;
        RD1, RD2: in std_logic_vector(7 downto 0);
        O: in std_logic_vector(1 downto 0)
);
end jumpsel;



architecture behav of myregister is
    
	signal value := "00":
    

begin
   
process (clk)
begin
    if(rising_edge(clk)) then
        O<= value;
    end if;
end process;

process(Jcount, OP, DIST, feedback, value, RD1, RD2)
begin
    if(feedback = "00") then --see if there is a comp instruction
        if(jcount = '1') and (OP = "11") and (DIST = "0") and (RD1 = RD2) then --it is a comp with jump 2
            value<= "10";
        
        elsif(jcount = '0') and (OP = "11") and (DIST = "0") and (RD1 = RD2) then --it is a comp with jump 1
            value<="01";
        
        else
            value<="00";
        end if;
    else --decrement the value
        if(value = "10") then
            value <= "01";
        elsif(value = "01") then
            value <= "00"
        end if;    
    end if;

end process;
end behav;

