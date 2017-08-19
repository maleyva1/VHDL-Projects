----------------------------------------------------------------------
-- EECS31L/CSE31L Assignment3
-- Locator Behavioral Model
----------------------------------------------------------------------
-- Student First Name : Mark
-- Student Last Name : Leyva
-- Student ID : 25662446
----------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.std_logic_unsigned.ALL;


entity Locator_beh  is
    Port ( Start : in  STD_LOGIC;
           Rst : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           Loc : out  STD_LOGIC_VECTOR (15 downto 0);
           Done : out  STD_LOGIC);
end Locator_beh;

architecture Behavioral of Locator_beh  is

   TYPE regArray_type IS 
      ARRAY (0 TO 7) OF std_logic_vector(15 DOWNTO 0); 
   SIGNAL regArray : regArray_type :=  (X"0000", X"000A", X"0003", X"0002", X"0006", X"0000", X"0000", X"0000");     

-- do not modify any code above this line
-- additional variables/signals can be declared if needed
-- add your code starting here

	TYPE StateType IS
		(Start_State, Loc_On1, Loc_On2, Loc_On3, Loc_On4, Loc_On5, Loc_On6, End_State);
	SIGNAL Current_State, Next_State: StateType;

    signal OutReg: std_logic_vector(15 downto 0);
   
begin

	Locator: Process (clk, Start, Current_State)
	variable temp: std_logic_vector( 31 DOWNTO 0):= X"00000000";
	begin
	   if(Current_State'EVENT or RISING_EDGE(Start)) then
	       Done <= '0';
	       Loc <= (OTHERS => 'Z');
            case Current_State IS
                when Start_State =>
                    if(Start = '1') then
                        Next_State <= Loc_On1;
                    else
                        Next_State <= Start_State;
                    end if;
                when Loc_On1 =>
                    temp := regArray(4) * regArray(4);
                    regArray(5) <= temp(15 downto 0);
                    Next_State <= Loc_On2;
                when Loc_On2 =>
                    temp := regArray(5) * regArray(1);
                    regArray(5) <= temp(15 downto 0);
                    Next_State <= Loc_On3;
                when Loc_On3 =>
                    regArray(5) <= '0' & regArray(5)(15 downto 1);
                    Next_State <= Loc_On4;
                when Loc_On4=>
                    temp := regArray(2) * regArray(4);
                    regArray(6) <= temp(15 downto 0);
                    Next_State <= Loc_On5;
                when Loc_On5 =>
                    regArray(5) <= regArray(5) + regArray(6);
                    Next_State <= Loc_On6;
                when Loc_On6 =>
                    regArray(5) <= regArray(5) + regArray(3);
                    OutReg <= regArray(5) + regArray(3);
                    Next_State <= End_State;
                when End_State =>
                    Done <= '1';
                    Loc <= OutReg;
                    Next_State <= Start_State;
            end case;
		end if;
		
		if(RISING_EDGE(clk)) then
			if(Rst = '1') then
				Current_state <= Start_State;
			else
				Current_State <= Next_State;
			end if;	
		end if;
	end Process Locator;


end Behavioral;

