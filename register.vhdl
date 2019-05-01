library ieee;
use ieee.std_logic_1164.all;

entity register is
port(	
		R1: in std_logic_vector(1 downto 0); 
		R2: in std_logic_vector(1 downto 0);
		OP: in std_logic_vector(1 downto 0);
		DIST: in std_logic;
		CLK: in std_logic; 
		WR: in std_logic_vector(7 downto 0); 
		REG_WRITE: in std_logic;
		RD: in std_logic_vector(1 downto 0);
		RD1: out std_logic_vector(7 downto 0); 
		RD2:	out std_logic_vector(7 downto 0) 
);
end register;


architecture behav of register is
	signal regout1: std_logic_vector(7 downto 0);
	signal regout2: std_logic_vector(7 downto 0);
	signal regout3: std_logic_vector(7 downto 0);
	signal regout4: std_logic_vector(7 downto 0);

	signal regenable1: std_logic;
	signal regenable2: std_logic;
	signal regenable3: std_logic;
	signal regenable4: std_logic;
begin
process(R1,R2,OP,DIST,CLK,WR,REG_WRITE,RD)
begin
	reg1: reg_8bit
	port map(
		I <= wr
		Clock <= clock
		Enable <= regenable1
		O <= regout1
	);
	reg2: reg_8bit
	port map(
		I <= wr
		Clock <= clock
		Enable <= regenable2
		O <= regout2
	);
	reg3: reg_8bit
	port map(
		I <= wr
		Clock <= clock
		Enable <= regenable3
		O <= regout3
	);
	reg4: reg_8bit
	port map(
		I <= wr
		Clock <= clock
		Enable <= regenable4
		O <= regout4
	);
if(rising_edge(clock)) then

	--Handle setup for writing to register
--------------------------------------------------
	if(RD = "00") then
		if(REG_WRITE = '1') then
			regenable1 <= '1';
		else
			regeneable1 <= '0';
		end if;
		regeneable2 <= '0';
		regeneable3 <= '0';
		regeneable4 <= '0';
	end if;

	if(RD = "01") then
		if(REG_WRITE = '1') then
			regenable2 <= '1';
		else
			regeneable2 <= '0';
		end if;
		regeneable1 <= '0';
		regeneable3 <= '0';
		regeneable4 <= '0';
	end if;

	if(RD = "10") then
		if(REG_WRITE = '1') then
			regenable3 <= '1';
		else
			regeneable3 <= '0';
		end if;
		regeneable1 <= '0';
		regeneable2 <= '0';
		regeneable4 <= '0';
	end if;

	if(RD = "11") then
		if(REG_WRITE = '1') then
			regenable4 <= '1';
		else
			regeneable4 <= '0';
		end if;
		regeneable1 <= '0';
		regeneable2 <= '0';
		regeneable3 <= '0';
	end if;

--------------------------------------------------------
--Handle demuxing outputs of flipflops to the outputs
	if(OP = "01" or OP = "10" or OP = "00") then --add,load,or sub instruction
		if(R1 = "00")
			RD1 <= regout1;
		end if;
		if(R1 = "01")
			RD1 <= regout2;
		end if;
		if(R1 = "10")
			RD1 <= regout3;
		end if;
		if(R1 = "11")
			RD1 <= regout4;
		end if;

		if(R2 = "00")
			RD2 <= regout1;
		end if;
		if(R2 = "01")
			RD2 <= regout2;
		end if;
		if(R2 = "10")
			RD2 <= regout3;
		end if;
		if(R2 = "11")
			RD2 <= regout4;
		end if;

	end if;
	if(OP = "11") then -- COMP or DISP instruction
		if(R1 = "00")
			RD1 <= regout1;
		end if;
		if(R1 = "01")
			RD1 <= regout2;
		end if;
		if(R1 = "10")
			RD1 <= regout3;
		end if;
		if(R1 = "11")
			RD1 <= regout4;
		end if;
		RD2 <= "00000000";
	end if;
	
end if;
end process;
end behav;

