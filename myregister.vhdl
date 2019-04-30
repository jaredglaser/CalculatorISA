library ieee;
use ieee.std_logic_1164.all;

entity myregister is
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
end myregister;



architecture behav of myregister is
    component reg_8bit
    port(	I:	in std_logic_vector (7 downto 0); -- for loading
        clock:		in std_logic; -- positive level triggering in problem 3
        enable: in std_logic;
		O:	out std_logic_vector(7 downto 0) -- output the current register content
        );
    end component;
    signal regout1: std_logic_vector(7 downto 0);
	signal regout2: std_logic_vector(7 downto 0);
	signal regout3: std_logic_vector(7 downto 0);
	signal regout4: std_logic_vector(7 downto 0);

	signal regenable1: std_logic := '0';
	signal regenable2: std_logic := '0';
	signal regenable3: std_logic := '0';
    signal regenable4: std_logic := '0';
    

begin
    reg1: reg_8bit port map(wr,clk,regenable1,regout1);
    reg2: reg_8bit port map(wr,clk,regenable2,regout2);
    reg3: reg_8bit port map(wr,clk,regenable3,regout3);
    reg4: reg_8bit port map(wr,clk,regenable4,regout4);

    	--Handle setup for writing to register
--------------------------------------------------
process (reg_write, RD)
begin
    if(RD = "00") then
		if(REG_WRITE = '1') then
            regenable1 <= '1';
        end if;
        if(REG_WRITE = '0') then
			regenable1 <= '0';
		end if;
		regenable2 <= '0';
		regenable3 <= '0';
		regenable4 <= '0';
	end if;

	if(RD = "01") then
		if(REG_WRITE = '1') then
			regenable2 <= '1';
		else
			regenable2 <= '0';
		end if;
		regenable1 <= '0';
		regenable3 <= '0';
		regenable4 <= '0';
	end if;

	if(RD = "10") then
		if(REG_WRITE = '1') then
			regenable3 <= '1';
		else
			regenable3 <= '0';
		end if;
		regenable1 <= '0';
		regenable2 <= '0';
		regenable4 <= '0';
	end if;

	if(RD = "11") then
		if(REG_WRITE = '1') then
			regenable4 <= '1';
		else
			regenable4 <= '0';
		end if;
		regenable1 <= '0';
		regenable2 <= '0';
		regenable3 <= '0';
	end if;
end process;

process(OP,R1,R2,regout1,regout2,regout3,regout4)
begin
-------------------------------------------------------
--Handle demuxing outputs of flipflops to the outputs
	if(OP = "01" or OP = "10" or OP = "00") then --add,load,or sub instruction
		if(R1 = "00") then
			RD1 <= regout1;
		end if;
		if(R1 = "01") then
			RD1 <= regout2;
		end if;
		if(R1 = "10") then
			RD1 <= regout3;
		end if;
		if(R1 = "11") then
			RD1 <= regout4;
		end if;

		if(R2 = "00") then
			RD2 <= regout1;
		end if;
		if(R2 = "01") then
			RD2 <= regout2;
		end if;
		if(R2 = "10") then
			RD2 <= regout3;
		end if;
		if(R2 = "11") then
			RD2 <= regout4;
		end if;

	end if;
	if(OP = "11") then -- COMP or DISP instruction
		if(R1 = "00") then
			RD1 <= regout1;
		end if;
		if(R1 = "01") then
			RD1 <= regout2;
		end if;
		if(R1 = "10") then
			RD1 <= regout3;
		end if;
		if(R1 = "11") then
			RD1 <= regout4;
		end if;
		RD2 <= "00000000";
	end if;
	

end process;
end behav;

