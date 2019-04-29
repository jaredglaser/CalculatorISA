library ieee;
use ieee.std_logic_1164.all;

entity shift_reg_8bit is
port(	I:	in std_logic_vector (7 downto 0); -- for loading
		I_SHIFT_IN: in std_logic; -- shifted in bit for both left and right
		sel:        in std_logic_vector(1 downto 0); -- 00:hold; 01: shift left; 10: shift right; 11: load
		clock:		in std_logic; -- positive level triggering in problem 3
		enable:		in std_logic; -- 0: don't do anything; 1: shift_reg is enabled
		shiftin: in std_logic_vector(1 downto 0); -- 00: regular load 11: regular load 01: shift left load 10: shift right load
		O:	out std_logic_vector(7 downto 0) -- output the current register content
);
end shift_reg_8bit;


architecture behav of shift_reg_8bit is
signal temp: std_logic_vector(7 downto 0);

begin
process(I,clock,sel,enable,shiftin)
begin
if(rising_edge(clock)) then
	if(enable = '1') then
		if(sel = "00") then
			--HOLD
			temp <= temp;
			O <= temp;
		end if;

		if(sel = "01") then
			--SHIFT LEFT
			
			temp(7 downto 1) <= temp(6 downto 0);
			temp(0) <= I_SHIFT_IN;

			--Output is equal to the new value of temp
			O(7 downto 1) <= temp(6 downto 0);
			O(0) <= I_SHIFT_IN;
			
		end if;

		if(sel = "10") then
			--SHIFT RIGHT
			
			temp(6 downto 0) <= temp (7 downto 1);
			temp(7) <= I_SHIFT_IN;

			--Output is equal to the new value of temp
			O(6 downto 0) <= temp (7 downto 1);
			O(7) <= I_SHIFT_IN;
		end if;

		if(sel = "11") then
		--LOAD
			if(shiftin = "00" or shiftin = "11") then
				temp <= I; --set temp equal to the input to load
				O <= I; 
			end if;
			if(shiftin = "01") then --left shift in
				temp(7 downto 1) <= I(6 downto 0);
				temp(0) <= I_SHIFT_IN;
		
				O(7 downto 1) <= I(6 downto 0);
				O(0) <= I_SHIFT_IN;
			end if;
			if(shiftin = "10") then --right shift in
				temp(6 downto 0) <= I(7 downto 1);
				temp(7) <= I_SHIFT_IN;
			
				O(6 downto 0) <= I(7 downto 1);
				O(7) <= I_SHIFT_IN;
			end if;
		end if;	
	end if;
end if;
end process;
end behav;

