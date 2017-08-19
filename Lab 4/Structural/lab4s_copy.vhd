----------------------------------------------------------------------
-- EECS31L/CSE31L Assignment4 DCT
--  Structural Model
-- Student name: Mark Leyva
-- ID: 25662446
----------------------------------------------------------------------
--   Version 2-11-2013

Library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_MISC.all;
use IEEE.STD_LOGIC_ARITH.all;

Package COMPONENTS is

Subtype INT is INTEGER;
	
	function int_to_uvec(number, length : INTEGER) Return unsigned;
End COMPONENTS;

Package body COMPONENTS is

--function to convert an INTEGER to unsigned bit vector
	function int_to_uvec(number, length : INTEGER) Return unsigned is
	Variable temp : unsigned(length -1 downto 0);
	Variable num, quotient : INTEGER := 0;
	Begin
		quotient := number;

		for i in 0 to length -1 Loop
			num := 0;
			While quotient > 1 Loop
				quotient := quotient - 2;
				num := num + 1;
			End Loop;
			
			Case quotient is
				when 1 => temp(i) := '1';
				when 0 => temp(i) := '0';
				when others => null;
			End Case;
			
			quotient := num;
		End Loop;

		Return temp;
	End int_to_uvec;

End COMPONENTS;

----------------integer register--------------------

Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_misc.all;
use IEEE.std_logic_arith.all;
use work.components.all;

Entity Reg is
      Generic ( Delay:   Time := 4 ns ); 
      Port (    Clk : In    std_logic;
                Din : In    INT;
                Rst:  In    std_logic;
                Ld : In    std_logic;
                Dout : Out   INT );
End Reg;

Architecture BEHAVIORAL of Reg is
   Begin
	P: Process (Clk)
	Variable Value : INT := 0;
	Begin
     if( Clk'event and Clk = '1' ) then
       if (Rst = '1') then
           Dout <= 0;			
       elsif( Ld = '1' ) then
           Dout <=  Din after Delay;
       End if;
     End if; 
	End Process P;
End BEHAVIORAL;

-----------256x32(integer) Register file-------------------

Library ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

Entity RegFile IS
   Generic ( Delay:   Time := 8 ns );
   Port (R_addr1,R_addr2,W_addr: IN std_logic_vector(7 DOWNTO 0);
         R_en1,R_en2, W_en: IN std_logic;
         R_data1, R_data2: OUT INTEGER; 
         W_data: IN INTEGER; 
         Clk: IN std_logic );
End RegFile;

Architecture Behavioral OF RegFile IS 
	type RF is array ( 0 to 31, 0 to 7 ) of INTEGER;
	signal Storage : RF := (
			 --------OutBlock--------
			( 0, 0, 0, 0, 0, 0, 0, 0 ),
			( 0, 0, 0, 0, 0, 0, 0, 0 ),
			( 0, 0, 0, 0, 0, 0, 0, 0 ),
			( 0, 0, 0, 0, 0, 0, 0, 0 ),
			( 0, 0, 0, 0, 0, 0, 0, 0 ),
			( 0, 0, 0, 0, 0, 0, 0, 0 ),
			( 0, 0, 0, 0, 0, 0, 0, 0 ),
			( 0, 0, 0, 0, 0, 0, 0, 0 ),
			 --------TempBlock--------
			( 0, 0, 0, 0, 0, 0, 0, 0 ),
			( 0, 0, 0, 0, 0, 0, 0, 0 ),
			( 0, 0, 0, 0, 0, 0, 0, 0 ),
			( 0, 0, 0, 0, 0, 0, 0, 0 ),
			( 0, 0, 0, 0, 0, 0, 0, 0 ),
			( 0, 0, 0, 0, 0, 0, 0, 0 ),
			( 0, 0, 0, 0, 0, 0, 0, 0 ),
			( 0, 0, 0, 0, 0, 0, 0, 0 ),
			 --------InBlock--------
			( 0, 0, 0, 0, 0, 0, 0, 0 ),
			( 0, 0, 0, 0, 0, 0, 0, 0 ),
			( 0, 0, 0, 0, 0, 0, 0, 0 ),
			( 0, 0, 0, 0, 0, 0, 0, 0 ),
			( 0, 0, 0, 0, 0, 0, 0, 0 ),
			( 0, 0, 0, 0, 0, 0, 0, 0 ),
			( 0, 0, 0, 0, 0, 0, 0, 0 ),
			( 0, 0, 0, 0, 0, 0, 0, 0 ),
	       --------COS-------------
			( 125, 122,  115, 103,  88,  69,   47,   24  ),
			( 125, 103,  47,  -24,  -88, -122, -115, -69  ),
			( 125, 69,   -47, -122, -88, 24,   115,  103  ),
			( 125, 24,   -115, -69, 88,  103,  -47,  -122  ),
			( 125, -24,  -115, 69,  88,  -103, -47,  122  ),
			( 125, -69,  -47, 122,  -88, -24,  115,  -103  ),
			( 125, -103, 47,  24,   -88, 122,  -115, 69  ),
			( 125, -122, 115, -103, 88,  -69,  47,   -24 )			
			);
Begin
	WriteProcess: Process(Clk)
	Variable col_w:std_logic_vector(2 DOWNTO 0);	
	Variable row_w:std_logic_vector(4 DOWNTO 0);
	Begin
	      row_w := W_addr(7 downto 3);
	      col_w := W_addr(2 downto 0);
		
	if( Clk'event and Clk = '1' ) then   
	  if(W_en = '1') then 
		-- write --
		Storage( CONV_INTEGER(row_w), CONV_INTEGER(col_w)) <= W_data after Delay;
	  End if;
		
	End if;
	
	End Process;

	ReadProcess: Process(R_en1, R_addr1, R_en2, R_addr2,Storage)
	Variable  col_r1, col_r2:std_logic_vector(2 DOWNTO 0);	
	Variable  row_r1, row_r2:std_logic_vector(4 DOWNTO 0);
	Begin
	      row_r1 := R_addr1(7 downto 3);
	      col_r1 := R_addr1(2 downto 0);
		  row_r2 := R_addr2(7 downto 3);
	      col_r2 := R_addr2(2 downto 0);
	
	if(R_en1 = '1') then 
		R_data1 <= Storage( CONV_INTEGER(row_r1), CONV_INTEGER(col_r1) ) after Delay;
	else
		R_data1 <= INTEGER'left;	
	End if;
	
	if(R_en2 = '1') then 
		R_data2 <= Storage( CONV_INTEGER(row_r2), CONV_INTEGER(col_r2) ) after Delay;
	else
		R_data2 <= INTEGER'left;	
	End if;
	End Process;
End Behavioral;


-------------------------------Counter------------------------------

Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_misc.all;
use IEEE.std_logic_arith.all;
use work.components.all;


Entity Counter is
      Generic ( Delay:   Time := 8 ns );
      Port (    Clk : In    std_logic;
                Inc : In    std_logic;
                Rst : In    std_logic;
                Dout : Out   INT;
                i : Out   std_logic_vector(2 downto 0);
                j : Out   std_logic_vector(2 downto 0);
                k : Out   std_logic_vector(2 downto 0) );
End Counter;

Architecture BEHAVIORAL of Counter is
   Begin
	P: Process ( Clk )
	Variable Value : UNSIGNED( 8 downto 0 ) := "000000000";
	Begin
		if( Clk'event and Clk = '1' ) then 
			if( Rst = '1' ) then
				Value := "000000000";
			elsif( Inc = '1' ) then
				Value := Value + 1;
			End if;
		End if;
                Dout <= CONV_INTEGER( Value ) after Delay;
                i(2) <= Value(8) after Delay;
                i(1) <= Value(7) after Delay;
                i(0) <= Value(6) after Delay;
                j(2) <= Value(5) after Delay; 
                j(1) <= Value(4) after Delay;
                j(0) <= Value(3) after Delay;
                k(2) <= Value(2) after Delay;
                k(1) <= Value(1) after Delay; 
                k(0) <= Value(0) after Delay;					 
	End Process P;

End BEHAVIORAL;

---------------------------Multiplier--------------------------

library IEEE;
   use IEEE.std_logic_1164.all;
   use IEEE.std_logic_misc.all;
   use IEEE.std_logic_arith.all;


entity Multiplier is
          generic ( Delay:   Time := 25 ns );
       Port (A : In    integer;
             B : In    integer;
             Product : Out   integer );
end Multiplier;

architecture BEHAVIORAL of Multiplier is
   begin
	P: process ( A, B )
		variable Result : integer := 0;
	begin
		if( A /= integer'left and B /= integer'left ) then
			Result := A * B;
		end if;
		Product <= Result after Delay;
	end process P;
end BEHAVIORAL;


-------------------------Adder-------------------------------

library IEEE;
   use IEEE.std_logic_1164.all;
   use IEEE.std_logic_misc.all;
   use IEEE.std_logic_arith.all;


entity Adder is
         generic ( Delay:   Time := 15 ns ); 
      Port (     A : In    integer;
                 B : In    integer;
                 Sum : Out   integer );
end Adder;

architecture BEHAVIORAL of Adder is
   begin
	P: process ( A, B )
		variable Result : integer := 0;
	begin
		if( A /= integer'left and B /= integer'left ) then
			Result := A + B;
		end if;
		Sum <= Result after Delay;
	end process P;

end BEHAVIORAL;


----------------------32-bit(integer) Mux----------------------

Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_misc.all;
use IEEE.std_logic_arith.all;
use work.components.all;


Entity MuxInt is
      Generic ( Delay:   Time := 4 ns );
      Port (    C : In    std_logic;
                D0 : In    INT;
                D1 : In    INT;
                Dout : Out   INT );
End MuxInt;

Architecture BEHAVIORAL of MuxInt is
   Begin
	P: Process ( D0, D1, C )
	Variable data_out : INT;
	Begin
		if( C = '0' ) then
			data_out := D0;
		else
			data_out := D1;
		End if;
		Dout <= data_out after Delay;
	End Process P;
End BEHAVIORAL;


--------------------3-bit Mux--------------------------
Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_misc.all;
use IEEE.std_logic_arith.all;
use work.components.all;


Entity Mux3 is
      Generic ( Delay:   Time := 4 ns );
      Port (    C : In    std_logic;
                D0 : In    std_logic_vector(2 downto 0);
                D1 : In    std_logic_vector(2 downto 0);
                Dout : Out   std_logic_vector(2 downto 0) );
End Mux3;

Architecture BEHAVIORAL of Mux3 is
   Begin
	P: Process ( D0, D1, C )
		Begin
		if( C = '0' ) then
			Dout <= D0 after Delay;
		else
			Dout <= D1 after Delay;
		End if;
		
	End Process P;
End BEHAVIORAL;

---------- 32-bit (integer) Three-state Buffer ----------

Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_misc.all;
use IEEE.std_logic_arith.all;
use work.components.all;

Entity ThreeStateBuff IS
    Generic ( Delay:   Time := 1 ns );
    Port (Control_Input: IN std_logic;
          Data_Input: IN INT;
          Output: OUT INT );
End ThreeStateBuff;

Architecture Beh OF ThreeStateBuff IS
Begin
    Process (Control_Input, Data_Input)
    Begin
        IF (Control_Input = '1') THEN
            Output <= Data_Input AFTER Delay;
        ELSE
            Output <= INT'left AFTER Delay;
        End IF;
    End Process;
End Beh;

  

 -------------------------------------------------------------
 --      Controller
 -------------------------------------------------------------
Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_misc.all;
use IEEE.std_logic_arith.all;
use work.components.all;


Entity Controller is
     Generic ( Delay:   Time := 6.4 ns );
     Port (  Clk   : In    std_logic;
             Start : In    std_logic;
             Count : In    INT;
             Inc : Out   std_logic := '0';
             R_en1 : Out   std_logic := '0';
             R_en2 : Out   std_logic := '0';
			 W_en : Out   std_logic := '0';
             LoadSum : Out   std_logic := '0';				 
             Rst_counter : Out   std_logic := '0';
             Rst_sum : Out   std_logic := '0'; 
             Rst_p : Out   std_logic := '0'; 
             Sel1 : Out   std_logic := '0';
             Sel2 : Out   std_logic := '0';
             Sel3 : Out   std_logic := '0';
             Sel4 : Out   std_logic := '0';
             Sel5 : Out   std_logic := '0';
             Sel6 : Out   std_logic := '0';
             Sel7 : Out   std_logic := '0';	
			 Sel8 : Out   std_logic := '0';
             Oe   : Out   std_logic := '0';					 
             Done : Out   std_logic := '0');
End Controller;

Architecture BEHAVIORAL of Controller is

-- Add Your Code Here

-- Testing State 0 to State 1
-- Reading from Din to InBlock
SUBTYPE StateType is std_logic_vector (4 downto 0);
SIGNAL Current_State, Next_State: StateType := "00000";

SIGNAL Rst : std_logic;



BEGIN
	CombLogic: Process(Start, Current_State, Count)
	variable   CountVector : unsigned(8 downto 0);
	variable   i, j, k : INT;
	begin
		-- These will always be turned off until State 17 and 18 respectively
		Oe <= '0' after Delay;
		Done <= '0' after Delay;
		
		case Current_State is
			-- State 0
			when "00000" =>
				-- Reset StateReg
				Rst <= '0';
				-- Reset registers
				Inc <= '0' after Delay;
				R_en1 <= '0' after Delay;
				R_en2 <= '0' after Delay;
				W_en <= '0' after Delay;
				LoadSum <= '0' after Delay;
				Rst_counter <= '1' after Delay;
				Rst_sum <= '1' after Delay;
				Rst_p <= '1' after Delay;
				Sel1 <= '-' after Delay;
				Sel2 <= '-' after Delay;
				Sel3 <= '-' after Delay;
				Sel4 <= '-' after Delay;
				Sel5 <= '-' after Delay;
				Sel6 <= '-' after Delay;
				Sel7 <= '-' after Delay;
				Sel8 <= '-' after Delay;
				
				-- Check if we should move onto the next state
				if(Start = '1') then
					Next_State <= "00001" after Delay;
				else
					Next_State <= "00000" after Delay;
				end if;
			-- State 1
			when "00001" =>
				-- We want to write to the RegFile in this state
				-- Given Din, we write to InBlock(i, j)
				-- Wait until Din changes output on rising edge of clk
				Inc <= '1' after Delay;
				Rst_counter <= '0' after Delay;
				R_en1 <= '0' after Delay;
				R_en2 <= '0' after Delay;
				LoadSum <= '0' after Delay;
				Rst_sum <= '0' after Delay;
				Rst_p <= '0' after Delay;
				Sel1 <= '0' after Delay;
				Sel2 <= '1' after Delay;
				Sel3 <= '0' after Delay;
				Sel4 <= '0' after Delay;
				Sel5 <= '1' after Delay;
				Sel6 <= '1' after Delay;
				Sel7 <= '1' after Delay;
				Sel8 <= '-' after Delay;

				W_en < '1' after Delay;
				
				if(Count < 63) then
					Next_State <= "00001" after Delay; -- Stay in State 1
				elsif(Count = 63) then
					Next_State <= "00010" after Delay; -- Go to State 2
				end if;
			-- State 2
			when "00010" =>
				-- Reset Counter and Sum register
				Inc <= '0' after Delay;
				R_en1 <= '0' after Delay;
				R_en2 <= '0' after Delay;
				W_en <= '0' after Delay;
				LoadSum <= '0' after Delay;
				Rst_counter <= '1' after Delay; -- Don't reset
												-- Don't listen to this dumbass
				Rst_sum <= '1' after Delay;
				Rst_p <= '0' after Delay;
				Sel1 <= '-' after Delay;
				Sel2 <= '-' after Delay;
				Sel3 <= '-' after Delay;
				Sel4 <= '-' after Delay;
				Sel5 <= '-' after Delay;
				Sel6 <= '-' after Delay;
				Sel7 <= '-' after Delay;
				Sel8 <= '-' after Delay;

				Next_State <= "00000000" after Delay;
			
			when others => NULL;
		end case;
	end process;
	
	StateReg: Process(Clk, Rst)
	begin
		if(clk = '1' AND clk'event) then
			if(Rst = '1') then
				Current_State <= "00000" after 4 ns;
			else
				Current_State <= Next_State after 4 ns;
			end if;
		end if;
	end Process;

End BEHAVIORAL;

 -------------------------------------------------------------
 --      top level: structure for DCT
 --      minimal clock cycle = 34 ns
 --      (please specify the clock cycle above) 
 -------------------------------------------------------------
 
Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_misc.all;
use IEEE.std_logic_arith.all;
use work.components.all;

Entity DCT_str IS
      Port (
                Clk :           in std_logic;
                Start :         in std_logic;
                Din :           in INTEGER;
                Done :          out std_logic;
                Dout :          out INTEGER
              );
End DCT_str;


Architecture struct OF DCT_str IS

COMPONENT Multiplier IS
      PORT ( A : In    integer;
             B : In    integer;
             Product : Out   integer );
END COMPONENT;

COMPONENT Adder IS
      PORT (     A : In    integer;
                 B : In    integer;
                 Sum : Out   integer );
END COMPONENT;

COMPONENT Counter IS
      Port (    Clk : In    std_logic;
                Inc : In    std_logic;
                Rst : In    std_logic;
                Dout : Out   INT;
                i : Out   std_logic_vector(2 downto 0);
                j : Out   std_logic_vector(2 downto 0);
                k : Out   std_logic_vector(2 downto 0)  );
End COMPONENT;

COMPONENT MuxInt is
	   Port (   C : In    std_logic;
                D0 : In    INT;
                D1 : In    INT;
                Dout : Out   INT );
End COMPONENT;

COMPONENT Mux3 is
      Port (    C : In    std_logic;
                D0 : In    std_logic_vector(2 downto 0);
                D1 : In    std_logic_vector(2 downto 0);
                Dout : Out   std_logic_vector(2 downto 0) );
End COMPONENT;

COMPONENT Reg is
      Port (    Clk : In    std_logic;
                DIN : In    INT;
                Rst : In    std_logic;
                Ld : In    std_logic;
                Dout : Out   INT );
End COMPONENT;

COMPONENT RegFile IS
      Port (    R_addr1,R_addr2,W_addr: IN std_logic_vector(7 DOWNTO 0);
                R_en1,R_en2, W_en: IN std_logic;
                R_data1, R_data2: OUT INTEGER; 
                W_data: IN INTEGER; 
                Clk: IN std_logic );
End COMPONENT;

COMPONENT ThreeStateBuff IS
      Port (    Control_Input: IN std_logic;
                Data_Input: IN INT;
                Output: OUT INT );
End COMPONENT;

COMPONENT Controller IS
      Port (    Clk   : In    std_logic;
                Start : In    std_logic;
                Count : In    INT;
                Inc : Out   std_logic ;
                R_en1 : Out   std_logic ;
                R_en2 : Out   std_logic ;
				W_en : Out   std_logic ;
                LoadSum : Out   std_logic ;				 
                Rst_counter : Out   std_logic;
                Rst_sum : Out   std_logic; 
				Rst_p : Out   std_logic := '0'; 
                Sel1 : Out   std_logic; 	-- Used for 32-bit Mux between Din and Register outputs (A/B/Sum)
                Sel2 : Out   std_logic ;	-- Used for 32-bit Mux between Reg A/B output and Reg Sum Output
                Sel3 : Out   std_logic ;	-- Used for 32-bit Mux between Reg A and Reg B
                Sel4 : Out   std_logic ;	-- Used to control loads for Reg A and Reg B
                Sel5 : Out   std_logic ;	-- Used to control load for Reg P
                Sel6 : Out   std_logic ;	-- Used to control 'k' or 'j' 3-bit Mux
                Sel7 : Out   std_logic ;	-- Used to control 'i' or 'j' 3-bit Mux
				Sel8 : Out   std_logic ;	-- Used to controll w_addr 3-Bit Mux for MSB
                Oe   : Out   std_logic ;				 
                Done : Out   std_logic );
End COMPONENT;

--------------------------------------------------
--you may modify below signals or declare new ones  
--for the interconnections of the structrual model
--------------------------------------------------

SIGNAL counter_out: INTEGER;
SIGNAL Incr, Rst_counter, Rst_sum, Rst_p:std_logic;
SIGNAL R_en1_s, R_en2_s :std_logic;
SIGNAL W_en_s :std_logic;
SIGNAL Sel1_s, Sel2_s,Sel3_s,Sel4_s,Sel5_s,Sel6_s,Sel7_s,Sel8_s:std_logic;
SIGNAL muxout1,muxout2,muxout3: std_logic_vector(2 downto 0);
SIGNAL muxout4, muxout5, muxout6: INTEGER;
SIGNAL mult_out: INTEGER;
SIGNAL add_out: INTEGER;
SIGNAL R_data1_out, R_data2_out : INTEGER;
SIGNAL i_s, j_s, k_s: std_logic_vector(2 downto 0);
SIGNAL ldsum:std_logic;
SIGNAL reg_sum_out,reg_p_out,reg_a_out,reg_b_out: INTEGER;
SIGNAL Oe_s :std_logic;

-- R/W addresses
SIGNAL w_addr_s, w_addr1_s, w_addr2_s : std_logic_vector(7 downto 0);
SIGNAL r_addr1_s : std_logic_vector(7 downto 0);
SIGNAL r_addr2_s : std_logic_vector(7 downto 0);

-- Added 3-bit muxs
SIGNAL muxout7, muxout8, muxout9, muxout10: std_logic_vector(2 downto 0);

Begin
	 
	-- Add Your Code Here
	ControllerS: Controller PORT MAP(Clk, Start, counter_out, Incr, R_en1_s, R_en2_s, W_en_s, ldsum, Rst_counter, Rst_sum, Rst_p, Sel1_s, Sel2_s,Sel3_s,Sel4_s,Sel5_s,Sel6_s,Sel7_s, Sel8_s, Oe_s, Done);
	
	CounterS: Counter PORT MAP(Clk, Incr, Rst_counter, counter_out, i_s, j_s, k_s);
	
	-- 3-bit muxs for R/W addresses
	--TriMux1: Mux3 PORT MAP(Sel6_s, i_s, j_s, muxout1); -- 'i' or 'j'
	--TriMux2: Mux3 PORT MAP(Sel7, k_s, j_s, muxout2); -- 'k' or 'j'
	--TriMux3: Mux3 PORT MAP(Sel1_s, "011", "001", muxout7); -- CosBlock or TempBlock
	--TriMux4: Mux3 PORT MAP(Sel2_s, "010", "011", muxout8); -- InBlock or CosBlock
	-- TriMux5: Mux3 PORT MAP(Sel3_s, NOT(muxout7), NOT(muxout8), muxout9);
	-- TriMux6: Mux3 PORT MAP(Sel8_s, muxout9, "011", muxout10);
	
	-- Write address
	--w_addr_s <= muxout(1) & muxout(0) & k_s & j_s;
	TriMux1: Mux3 PORT MAP(Sel6_s, j_s, k_s, muxout1);
	TriMux2: Mux3 PORT MAP(Sel7_s, j_s, k_s, muxout2)
	TriMux3: Mux3 PORT MAP(Sel8_s, i_s, j_s, muxout3);
	
	W_addr_s <= Sel2_S & Sel1_s & muxout1 & muxout2;
	
	RegisterFile: RegFile PORT MAP("00000000", "0000000", w_addr_s, R_en1_s, R_en2_s, W_en_s, R_data1_out, R_data2_out, muxout4,Clk);
	
	RegA: Reg PORT MAP(Clk, R_data1_out, Rst_p, sel6_s, reg_a_out);
	
	RegB: Reg PORT MAP(Clk, R_data2_out, RsT_p, sel7_s, reg_b_out);
	
	IntMux3: MuxInt PORT MAP(sel8_s, reg_a_out, reg_b_out, muxout6);	-- 32-bit mux between Reg A and Reg B => outputs to INTmux2
	
	INTmux1: MuxInt PORT MAP(Sel1_s, Din, muxout5, muxout4);
	
	MultS: Multiplier PORT MAP(reg_a_out, reg_b_out, mult_out);
	
	RegP: Reg PORT MAP(Clk, mult_out, Rst_p, sel2_s, reg_p_out);		-- Share signals between Reg P and INTmux2
	
	RegSum: Reg PORT MAP(Clk, add_out, Rst_sum, ldsum, reg_sum_out);
	
	AdderS: Adder PORT MAP(reg_p_out, reg_sum_out, add_out);
	
	INTmux2: MuxInt PORT MAP(Sel2_s, muxout6, reg_sum_out, muxout5);
	
	TriState: ThreeStateBuff PORT MAP(Oe_s, R_data1_out, Dout);

End struct;
 
