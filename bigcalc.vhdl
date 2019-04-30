library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bigcalc is
    port(	
        I: in std_logic_vector(7 downto 0);
        CLK: in std_logic
    );
end bigcalc;

architecture behav of myregister is

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
    ;
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
        Feedback: in std_logic_vector(1 downto 0);
        clk: in std_logic;
        RD1, RD2: in std_logic_vector(7 downto 0);
        O: in std_logic_vector(1 downto 0)
    );
    end component;

    signal R1,R2,RD, OP: std_logic_vector(1 downto 0);    
    signal DIST, REG_WRITE,Jcount: std_logic;
    signal WR, RD1,RD2,:std_logic_vector(7 downto 0);
    signal imm:std_logic_vector(3 downto 0);

    signal internalJump: std_logic_vector(1 downto 0);
    signal internalRegWr: std_logic_vector;
    signal internalALU: std_logic_vector(7 downto 0);

    begin
    myreg: myregister port map(R1,R2,OP,DIST,CLK,WR,REG_WRITE,RD,RD1,RD2);
    myalu: alu port map(OP,RD1,RD2,internalALU);
    mydecoder: decoder port map(I,R1,R2,Rd,OP,internalRegWr,DIST,IMM,JCOUNT);
    myjumpsel: jumpsel port map(jcount,OP,DIST,Feedback,clk,RD1,RD2,internalJump); 

    --handle the mux between ALU and WR
    process(internalALU, imm, OP)
        if(OP = "00") then --it is a load
            WR <= imm;
        else
            WR <= internalALU;
        end if;

    end process;

    --handle the black box between jumpsel and regwr
    process(internalJump, internalRegWr)
        if(internalJump = "01") or (internalJump = "10") then
            REG_WRITE <= '0';
        else
            REG_WRITE <= internalRegWr;
        end if;
    end process;



end behav;

