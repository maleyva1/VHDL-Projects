----------------------------------------------------------------------
-- EECS31L/CSE31L Assignment3
-- Locator Structural Model
----------------------------------------------------------------------
-- Student First Name : Mark
-- Student Last Name :  Leyva
-- Student ID : 25662446
----------------------------------------------------------------------

---------- Components library ----------

---------- 8x16 Register File ----------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY RegFile IS
   PORT (R_Addr1, R_Addr2, W_Addr: IN std_logic_vector(2 DOWNTO 0);
         R_en, W_en: IN std_logic;
         Reg_Data1 : OUT std_logic_vector(15 DOWNTO 0); 
			Reg_Data2 : OUT std_logic_vector(15 DOWNTO 0); 
         W_Data: IN std_logic_vector(15 DOWNTO 0); 
         Clk, Rst: IN std_logic);
END RegFile;

ARCHITECTURE Beh OF RegFile IS 
   TYPE regArray_type IS 
      ARRAY (0 TO 7) OF std_logic_vector(15 DOWNTO 0); 
   SIGNAL regArray : regArray_type;
BEGIN
   WriteProcess: PROCESS(Clk)    
   BEGIN
      IF (Clk = '1' AND Clk'EVENT) THEN
         IF (Rst = '1') THEN
            regArray(0) <= X"0000" AFTER 6.0 NS;
            regArray(1) <= X"000A" AFTER 6.0 NS;
            regArray(2) <= X"0003" AFTER 6.0 NS;
            regArray(3) <= X"0002" AFTER 6.0 NS;
            regArray(4) <= X"0006" AFTER 6.0 NS;
            regArray(5) <= X"0000" AFTER 6.0 NS;
            regArray(6) <= X"0000" AFTER 6.0 NS;
            regArray(7) <= X"0000" AFTER 6.0 NS;
         ELSE
            IF (W_en = '1') THEN
                regArray(conv_integer(W_Addr)) <= W_Data AFTER 6.0 NS;
                END IF;
        END IF;
     END IF;
   END PROCESS;
            
   ReadProcess1: PROCESS(R_en, R_Addr1, regArray)
   BEGIN
      IF (R_en = '1') THEN
        CASE R_Addr1 IS
            WHEN "000" =>
                Reg_Data1 <= regArray(0) AFTER 6.0 NS;
            WHEN "001" =>
                Reg_Data1 <= regArray(1) AFTER 6.0 NS;
            WHEN "010" =>
                Reg_Data1 <= regArray(2) AFTER 6.0 NS;
            WHEN "011" =>
                Reg_Data1 <= regArray(3) AFTER 6.0 NS;
            WHEN "100" =>
                Reg_Data1 <= regArray(4) AFTER 6.0 NS;
            WHEN "101" =>
                Reg_Data1 <= regArray(5) AFTER 6.0 NS;
            WHEN "110" =>
                Reg_Data1 <= regArray(6) AFTER 6.0 NS;
            WHEN "111" =>
                Reg_Data1 <= regArray(7) AFTER 6.0 NS;
            WHEN OTHERS =>
                Reg_Data1 <= (OTHERS=>'0') AFTER 6.0 NS;
        END CASE;
      ELSE
        Reg_Data1 <= (OTHERS=>'0') AFTER 6.0 NS;
      END IF;
   END PROCESS;
	
	ReadProcess2: PROCESS(R_en, R_Addr2, regArray)
   BEGIN
      IF (R_en = '1') THEN
        CASE R_Addr2 IS
            WHEN "000" =>
                Reg_Data2 <= regArray(0) AFTER 6.0 NS;
            WHEN "001" =>
                Reg_Data2 <= regArray(1) AFTER 6.0 NS;
            WHEN "010" =>
                Reg_Data2 <= regArray(2) AFTER 6.0 NS;
            WHEN "011" =>
                Reg_Data2 <= regArray(3) AFTER 6.0 NS;
            WHEN "100" =>
                Reg_Data2 <= regArray(4) AFTER 6.0 NS;
            WHEN "101" =>
                Reg_Data2 <= regArray(5) AFTER 6.0 NS;
            WHEN "110" =>
                Reg_Data2 <= regArray(6) AFTER 6.0 NS;
            WHEN "111" =>
                Reg_Data2 <= regArray(7) AFTER 6.0 NS;
            WHEN OTHERS =>
                Reg_Data2 <= (OTHERS=>'0') AFTER 6.0 NS;
        END CASE;
      ELSE
        Reg_Data2 <= (OTHERS=>'0') AFTER 6.0 NS;
      END IF;
   END PROCESS;
END Beh;


---------- 16-Bit ALU ----------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;


ENTITY ALU IS
    PORT (Sel: IN std_logic;
            A: IN std_logic_vector(15 DOWNTO 0);
            B: IN std_logic_vector(15 DOWNTO 0);
            ALU_Out: OUT std_logic_vector (15 DOWNTO 0) );
END ALU;

ARCHITECTURE Beh OF ALU IS

BEGIN
    PROCESS (A, B)
         variable temp: std_logic_vector(31 DOWNTO 0):= X"00000000";
    BEGIN
        IF (Sel = '0') THEN
            ALU_Out <= A + B AFTER 12 NS;                
        ELSIF (Sel = '1') THEN
            temp := A * B ;
            ALU_Out <= temp(15 downto 0) AFTER 12 NS; 
        END IF;
          
    END PROCESS;
END Beh;


---------- 16-bit Shifter ----------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Shifter IS
   PORT (I: IN std_logic_vector(15 DOWNTO 0);
         Q: OUT std_logic_vector(15 DOWNTO 0);
         sel: IN std_logic );
END Shifter;

ARCHITECTURE Beh OF Shifter IS 
BEGIN
   PROCESS (I,sel) 
   BEGIN
         IF (sel = '1') THEN 
            Q <= I(14 downto 0) & '0' AFTER 4.0 NS;
         ELSE
            Q <= '0' & I(15 downto 1) AFTER 4.0 NS;
         END IF;   
   END PROCESS; 
END Beh;


---------- 2-to-1 Selector ----------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Selector IS
   PORT (sel: IN std_logic;
         x,y: IN std_logic_vector(15 DOWNTO 0);
         f: OUT std_logic_vector(15 DOWNTO 0));
END Selector;

ARCHITECTURE Beh OF Selector IS 
BEGIN
   PROCESS (x,y,sel)
   BEGIN
         IF (sel = '0') THEN
            f <= x AFTER 3.0 NS;
         ELSE
            f <= y AFTER 3.0 NS;
         END IF;   
   END PROCESS; 
END Beh;


---------- 16-bit Register ----------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Reg IS
   PORT (I: IN std_logic_vector(15 DOWNTO 0);
         Q: OUT std_logic_vector(15 DOWNTO 0);
         Ld: IN std_logic; 
         Clk, Rst: IN std_logic );
END Reg;

ARCHITECTURE Beh OF Reg IS 
BEGIN
   PROCESS (Clk)
   BEGIN
      IF (Clk = '1' AND Clk'EVENT) THEN
         IF (Rst = '1') THEN
            Q <= X"0000" AFTER 4.0 NS;
         ELSIF (Ld = '1') THEN
            Q <= I AFTER 4.0 NS;
         END IF;   
      END IF;
   END PROCESS; 
END Beh;

---------- 16-bit Three-state Buffer ----------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY ThreeStateBuff IS
    PORT (Control_Input: IN std_logic;
          Data_Input: IN std_logic_vector(15 DOWNTO 0);
          Output: OUT std_logic_vector(15 DOWNTO 0) );
END ThreeStateBuff;

ARCHITECTURE Beh OF ThreeStateBuff IS
BEGIN
    PROCESS (Control_Input, Data_Input)
    BEGIN
        IF (Control_Input = '1') THEN
            Output <= Data_Input AFTER 2 NS;
        ELSE
            Output <= (OTHERS=>'Z') AFTER 2 NS;
        END IF;
    END PROCESS;
END Beh;

---------- Controller ----------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY Controller IS
    PORT(R_en: OUT std_logic;
         W_en: OUT std_logic;
         R_Addr1: OUT std_logic_vector(2 DOWNTO 0);
			R_Addr2: OUT std_logic_vector(2 DOWNTO 0);
         W_Addr: OUT std_logic_vector(2 DOWNTO 0);
         Shifter_Sel: OUT std_logic;
         Selector_Sel: OUT std_logic;
         ALU_sel : OUT std_logic;
         OutReg_Ld: OUT std_logic;
         Oe: OUT std_logic;
         Done: OUT std_logic;
         Start, Clk, Rst: IN std_logic); 
END Controller;


ARCHITECTURE Beh OF Controller IS

SUBTYPE StateType is std_logic_vector (2 downto 0);
SIGNAL Current_State, Next_State: StateType := "000";

BEGIN
-------------------------------------------------------
-- Hint:
-- Controller shall consist of a CombLogic process 
-- containing case-statement and a StateReg process.
--      
-------------------------------------------------------

 -- add your code here
CombLogic: Process(Start, Current_State)
begin
	R_en <= '1' ;
	W_en <= '1' ;
	OutReg_Ld <= '0' ;
	Oe <= '0' ;
	Done <= '0' ;
	case Current_State IS 
		when "000" =>
			R_addr1 <= "---" ;
			R_addr2 <= "---" ;
			W_addr <= "---" ;
			Shifter_sel <= '-' ;
			Selector_sel <= '-' ;
			ALU_sel <= '-' ;
			if (Start = '1') then
				Next_State <= "001" after 11 ns;
			else
				Next_State <= "000" after 11 ns;
			end if;
		when "001" =>
			R_addr1 <= "100" ;
			R_addr2 <= "100" ;
			W_addr <= "101" ;
			ALU_sel <= '1' ;
			Shifter_sel <= '-' ;
			Selector_sel <= '0' ;
			Next_State <= "010" after 11 ns;
		when "010" =>
			R_addr1 <= "101" ;
			R_addr2 <= "001" ;
			W_addr <= "101" ;
			Shifter_sel <= '-' ;
			ALU_sel <= '1' ;
			Selector_sel <= '0' ;
			Next_State <= "011" after 11 ns;
		when "011" =>
			R_addr1 <= "---" ;
			R_addr2 <= "101" ;
			W_addr <= "101" ;
			Shifter_sel <= '0' ;
			ALU_sel <= '-' ;
			Selector_sel <= '1' ;
			Next_State <= "100" after 11 ns;
		when "100" =>
			R_addr1 <= "010" ;
			R_addr2 <= "100" ;
			W_addr <= "110" ;
			Shifter_sel <= '-' ;
			ALU_sel <= '1' ;
			Selector_sel <= '0' ;
			Next_State <= "101" after 11 ns;
		when "101" =>
			R_addr1 <= "101" ;
			R_addr2 <= "110" ;
			W_addr <= "101" ;
			Shifter_sel <= '-' ;
			ALU_sel <= '0' ;
			Selector_sel <= '0' ;
			Next_State <= "110" after 11 ns;
		when "110" =>
			R_addr1 <= "101" ;
			R_addr2 <= "011" ;
			W_addr <= "101" ;
			Shifter_sel <= '-' ;
			ALU_sel <= '0' ;	
			Selector_sel <= '0' ;
			OutReg_Ld <= '1' ;
			Next_State <= "111" after 11 ns;
		when "111" =>
			R_addr1 <= "---" ;
			R_addr2 <= "---" ;
			W_addr <= "---" ;
			Shifter_sel <= '-' ;
			Selector_sel <= '-' ;
			ALU_sel <= '-' ;
			Done <= '1' ;
			Oe <= '1' ;
			Next_State <= "000" after 11 ns;
		when others => NULL;
	end case; 
end Process;
 
StateReg: Process(Clk, Rst)
begin
	if(clk = '1' AND clk'event) then
		if(Rst = '1') then
			Current_State <= "000" after 4 ns;
		else
			Current_State <= Next_State after 4 ns;
		end if;
	end if;
end Process;

END Beh;


---------- Locator (with clock cycle =  37 NS )----------
--         INDICATE YOUR CLOCK CYCLE TIME ABOVE      ----

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

entity lab3s is
    Port ( Start : in  STD_LOGIC;
           Rst : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           Loc : out  STD_LOGIC_VECTOR (15 downto 0);
           Done : out  STD_LOGIC);
end lab3s;

architecture Struct of lab3s is
    
    COMPONENT RegFile IS
        PORT (  R_Addr1, R_Addr2, W_Addr: IN std_logic_vector(2 DOWNTO 0);
                R_en, W_en: IN std_logic;
                Reg_Data1: OUT std_logic_vector(15 DOWNTO 0); 
					 Reg_Data2: OUT std_logic_vector(15 DOWNTO 0);
                W_Data: IN std_logic_vector(15 DOWNTO 0); 
                Clk, Rst: IN std_logic );
    END COMPONENT;
    
    COMPONENT ALU IS
        PORT (Sel: IN std_logic;
                A: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
                B: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
                ALU_Out: OUT STD_LOGIC_VECTOR (15 DOWNTO 0) );
    END COMPONENT;

    COMPONENT Shifter IS
         PORT (I: IN std_logic_vector(15 DOWNTO 0);
               Q: OUT std_logic_vector(15 DOWNTO 0);
               sel: IN std_logic );
    END COMPONENT;

    COMPONENT Selector IS
        PORT (sel: IN std_logic;
              x,y: IN std_logic_vector(15 DOWNTO 0);
              f: OUT std_logic_vector(15 DOWNTO 0) );
    END COMPONENT;
   
    COMPONENT Reg IS
        PORT (I: IN std_logic_vector(15 DOWNTO 0);
              Q: OUT std_logic_vector(15 DOWNTO 0);
              Ld: IN std_logic; 
              Clk, Rst: IN std_logic );
    END COMPONENT;
    
    COMPONENT ThreeStateBuff IS
        PORT (Control_Input: IN std_logic;
              Data_Input: IN std_logic_vector(15 DOWNTO 0);
              Output: OUT std_logic_vector(15 DOWNTO 0) );
    END COMPONENT;
    
    COMPONENT Controller IS
       PORT(R_en: OUT std_logic;
            W_en: OUT std_logic;
            R_Addr1: OUT std_logic_vector(2 DOWNTO 0);
				R_Addr2: OUT std_logic_vector(2 DOWNTO 0);
            W_Addr: OUT std_logic_vector(2 DOWNTO 0);
            Shifter_sel: OUT std_logic;
            Selector_sel: OUT std_logic;
            ALU_sel : OUT std_logic;
            OutReg_Ld: OUT std_logic;
            Oe: OUT std_logic;
            Done: OUT std_logic;
            Start, Clk, Rst: IN std_logic); 
     END COMPONENT;

-- do not modify any code above this line
-- add signals needed below. hint: name them something you can keep track of while debugging/testing
-- add your code starting here

-- Signals involved with Controller --
	-- Signals between Combinatorial Logic and State Register --
	-- SIGNAL Comb2StateReg: std_logic_vector(3 downto 0); --
	-- SIGNAL StateReg2Comb : std_logic_vector(3 downto 0); --
	
	-- Signals between Combinatorial Logic and Datapath --
	SIGNAL ReadAddr1 : std_logic_vector(2 downto 0);
	SIGNAL ReadAddr2 : std_logic_vector(2 downto 0);
	SIGNAL ReadEnable : std_logic;
	SIGNAL WriteEnable : std_logic;
	SIGNAL WriteAddr : std_logic_vector(2 downto 0);
	SIGNAL ALU_sel : std_logic;
	SIGNAL Shifter_sel : std_logic;
	SIGNAL Selector_sel : std_logic;
	SIGNAL OutReg_Ld : std_logic;
	SIGNAL Oe : std_logic;
	
-- Signals involved in Datapath --
	SIGNAL RegOutput1 : std_logic_vector(15 downto 0);
	SIGNAL RegOutput2 : std_logic_vector(15 downto 0);
	SIGNAL ALUOut : std_logic_vector(15 downto 0);
	SIGNAL ShifterOut : std_logic_vector(15 downto 0);
	SIGNAL SelectorOut : std_logic_vector(15 downto 0);
	SIGNAL OutReg2TriState : std_logic_vector(15 downto 0);
	
begin

	
	-- Datapath --
		-- Register File --
	RegisterFile: RegFile PORT MAP (ReadAddr1, ReadAddr2, WriteAddr, ReadEnable, WriteEnable, RegOutput1, RegOutput2, SelectorOut, Clk, Rst);
		-- ALU --
	ALU_1: ALU PORT MAP (ALU_sel, RegOutput2, RegOutput1, ALUOut);
		-- Shifter --
	Shifter_1: Shifter PORT MAP (RegOutput2, ShifterOut, Shifter_sel);
		-- Selector --
	Selector_1: Selector PORT MAP (Selector_sel, ALUOut, ShifterOut, SelectorOut);
		-- Output Register --
	OutputReg: Reg PORT MAP (SelectorOut, OutReg2TriState, OutReg_Ld, Clk, Rst);
		-- TriState Bugger --
	TriState: ThreeStateBuff PORT MAP (Oe, OutReg2TriState, Loc);
	
		-- Controller --
	Control: Controller PORT MAP (ReadEnable, WriteEnable, ReadAddr1, ReadAddr2, WriteAddr, Shifter_sel, Selector_sel, ALU_sel, OutReg_Ld, Oe, Done, Start, Clk, Rst);

end Struct;

