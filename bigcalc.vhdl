library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bigcalc is
    port(	
        I: in std_logic_vector(7 downto 0);
        CLK: in std_logic
    );
end bigcalc;

architecture behav of bigcalc is

    component myregister
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
    end component;

    component alu
    port(
        OP: in STD_LOGIC_VECTOR(1 downto 0);
        RD1: in STD_LOGIC_VECTOR(7 downto 0);
        RD2: in STD_LOGIC_VECTOR(7 downto 0);
        RD: out STD_LOGIC_VECTOR(7 downto 0)
    );
    end component;

    component decoder
    port( 
        c: in STD_LOGIC_VECTOR(7 downto 0);
        r1: out STD_LOGIC_VECTOR(1 downto 0);
        r2: out STD_LOGIC_VECTOR(1 downto 0);
        rd: out STD_LOGIC_VECTOR(1 downto 0);
        op: out STD_LOGIC_VECTOR(1 downto 0);
        regw: out STD_LOGIC;
        dist: out STD_LOGIC;
        imm: out STD_LOGIC_VECTOR(3 downto 0);
        jcount: out STD_LOGIC
    );
    end component;

    component jumpsel is
    port(	
        jcount: in std_logic;
        OP: in std_logic_vector(1 downto 0);
        DIST: in std_logic;
        clk: in std_logic;
        RD1, RD2: in std_logic_vector(7 downto 0);
        O: out std_logic_vector(1 downto 0)
    );
    end component;

    component disp is 
    port(
        OP: in STD_LOGIC_VECTOR(1 downto 0);
        DIST: in STD_LOGIC;
        CLK: in STD_LOGIC;
        RD1: in STD_LOGIC_VECTOR(7 downto 0);
        SkipVal: in STD_LOGIC_VECTOR(1 downto 0)
    );
    end component;

    signal R1,R2,RD, OP: std_logic_vector(1 downto 0);    
    signal DIST, REG_WRITE,Jcount: std_logic;
    signal WR, RD1,RD2:std_logic_vector(7 downto 0);
    signal imm:std_logic_vector(3 downto 0);
    signal internalJump: std_logic_vector(1 downto 0);
    signal internalRegWr: std_logic;
    signal internalALU: std_logic_vector(7 downto 0);

    begin
    myreg: myregister port map(R1,R2,OP,DIST,CLK,WR,REG_WRITE,RD,RD1,RD2);
    myalu: alu port map(OP,RD1,RD2,internalALU);
    mydecoder: decoder port map(I,R1,R2,Rd,OP,internalRegWr,DIST,IMM,JCOUNT);
    myjumpsel: jumpsel port map(jcount,OP,DIST,clk,RD1,RD2,internalJump); 
    mydist: disp port map(OP, DIST, clk, RD1,internalJump);
    --handle the mux between ALU and WR
    process(internalALU, imm, OP) is
        begin
        if(OP = "00") then --it is a load
            WR(3 downto 0) <= imm;
            if(imm(3) = '1') then
                WR(7 downto 4) <= "1111";
            else
                WR(7 downto 4) <= "0000";
            end if;
        else
            WR <= internalALU;
        end if;

    end process;

    --handle the black box between jumpsel and regwr
    process(internalJump, internalRegWr) is
        begin
        if(internalJump = "01") or (internalJump = "10") then
            REG_WRITE <= '0';
        else
            REG_WRITE <= internalRegWr;
        end if;
    end process;



end behav;

