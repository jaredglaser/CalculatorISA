library ieee;
use ieee.std_logic_1164.all;

entity reg_8bit is
port(	I:	in std_logic_vector (7 downto 0); -- for loading
        clock:		in std_logic; -- positive level triggering in problem 3
        enable: in std_logic;
		O:	out std_logic_vector(7 downto 0) -- output the current register content
);
end reg_8bit;


architecture behav of reg_8bit is
signal temp: std_logic_vector(7 downto 0);

begin
process(I,clock,enable)
begin
if(rising_edge(clock)) then
	if(enable = '1') then
        temp<= I;
        O<=I;
		end if;
    if(enable = '0') then
        temp<temp;
        O<= temp;
	end if;
end if;
end process;
end behav;

