-- EECS31L/CSE31L Assignment2
-- FSM Structural Model
----------------------------------------------------------------------
-- Student First Name : Mark
-- Student Last Name : Leyva
-- Student ID : 25662446
----------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Lab2s_FSM IS
     Port (Input : in  STD_LOGIC_VECTOR(2 DOWNTO 0);
           Clk : in  STD_LOGIC;
           Permit : out  STD_LOGIC;
           ReturnChange : out  STD_LOGIC);
END Lab2s_FSM;

ARCHITECTURE Structural OF Lab2s_FSM IS

-- DO NOT modify any signals, ports, or entities above this line
-- Create 2 processes (one for updating state status and the other for describing transitions and outputs)
-- For the combinatorial process, use Boolean equations consisting of AND, OR, and NOT gates while expressing the delay in terms of the NAND gates. 
-- For the state register process, use IF statements.
-- Figure out the appropriate sensitivity list of both the processes.
-- add your code here

	SUBTYPE StateType is STD_LOGIC_VECTOR (3 downto 0);
	SIGNAL Current_State, Next_State: StateType := "0000";
	
begin

CombLogic: Process (Current_State, Input)
	begin
		Next_State(3) <= ( (NOT Current_State(3)) AND (NOT Current_State(2)) AND Current_State(1) AND (NOT Current_State(0)) AND Input(2) ) OR 
							( (NOT Current_State(3)) AND Current_State(2) AND (NOT Current_State(1)) AND (NOT Current_State(0)) AND Input(2) ) or
							( (NOT Current_State(3)) AND Current_State(2) AND Current_State(1) AND (NOT Current_State(0)) AND (((NOT Input(2)) AND Input(1) AND (Input(0))) OR
							Input(2)) ) OR ( (NOT Current_State(3)) AND Current_State(2) AND Current_State(1) AND Current_State(0) AND (NOT Input(2)) AND (NOT Input(1)) AND 
							(NOT Input(0)) ) OR ( Current_State(3) AND (NOT Current_State(2)) AND (NOT Current_State(1)) AND Current_State(0) AND (NOT Input(2)) AND 
							(NOT Input(1)) AND (NOT Input(0)) ) after 5.6 ns;
						
		Next_State(2) <= ((NOT Current_State(3)) AND (NOT Current_State(2)) AND (NOT Current_State(1)) AND (NOT Current_State(0)) AND Input(2) AND (NOT Input(1)) AND
						(NOT Input(0))) OR ((NOT Current_State(3)) AND (NOT Current_State(2)) AND Current_State(1) AND (NOT Current_State(0)) AND (NOT Input(2)) AND 
						Input(1) AND (NOT Input(0))) OR ((NOT Current_State(3)) AND (NOT Current_State(2)) AND Current_State(1) AND Current_State(0) AND (NOT Input(2)) AND
						(NOT Input(1)) AND (NOT Input(0))) OR ((NOT Current_State(3)) AND Current_State(2) AND (NOT Current_State(1)) AND (NOT Current_State(0)) AND (NOT Input(2)))
						OR ((NOT Current_State(3)) AND Current_State(2) AND (NOT Current_State(1)) AND Current_State(0) AND (NOT Input(2)) AND (NOT Input(1)) AND (NOT Input(0)))
						OR ((NOT Current_State(3)) AND Current_State(2) AND Current_State(1) AND (NOT Current_State(0)) AND (NOT Input(2)) AND (NOT Input(1))) after 5.6 ns;
						
		Next_State(1) <= ( (NOT Current_State(3)) AND (NOT Current_State(2)) AND (NOT Current_State(1)) AND (NOT Current_State(0)) AND (( (NOT Input(2)) AND Input(1) AND 
							(NOT Input(0))) OR (Input(2) AND (NOT Input(1)) AND (NOT Input(0))) ))
							OR
							((NOT Current_State(3)) AND (NOT Current_State(2)) AND (NOT Current_State(1)) AND Current_State(0) AND (NOT Input(2)) AND (NOT Input(1)) and
							(NOT Input(0)) )
							OR
							( (NOT Current_State(3)) AND (NOT Current_State(2)) AND Current_State(1) AND (NOT Current_State(0)) AND (( (NOT Input(2)) AND (NOT Input(1)) AND 
							(NOT Input(0))) OR ( (NOT Input(2)) AND (NOT Input(1)) AND Input(0)) OR (Input(2) AND Input(1) AND Input(0))))
							OR
							((NOT Current_State(3)) AND (NOT Current_State(2)) AND Current_State(1) AND Current_State(0) AND (NOT Input(2)) AND Input(1) and
							NOT Input(0) )
							OR 
							( (NOT Current_State(3)) AND Current_State(2) AND (NOT Current_State(1)) AND (NOT Current_State(0)) AND (( (NOT Input(2)) AND Input(1) AND 
							(NOT Input(0))) OR (Input(2) AND Input(1) AND Input(0))))
							OR
							((NOT Current_State(3)) AND Current_State(2) AND (NOT Current_State(1)) AND Current_State(0) AND (NOT Input(2)) AND (NOT Input(1)) and
							NOT Input(0) )
							OR
							((NOT Current_State(3)) AND Current_State(2) AND Current_State(1) AND (NOT Current_State(0)) AND (((NOT Input(2)) AND (NOT Input(1)) and
							NOT Input(0)) OR ((NOT Input(2)) AND (NOT Input(1)) AND Input(0))))
							OR
							(Current_State(3) AND (NOT Current_State(2)) AND (NOT Current_State(1)) AND Current_State(0) AND ((NOT Input(2)) AND (NOT Input(1)) AND Input(0)))
							after 5.6 ns;
							
		Next_State(0) <= ( (NOT Current_State(3)) AND (NOT Current_State(2)) AND (NOT Current_State(1)) AND (NOT Current_State(0)) AND
							( ((NOT Input(2)) AND (NOT Input(1)) AND Input(0)) OR ( (NOT Input(2)) AND Input(1) AND (NOT Input(0)) ) OR ( Input(2) AND (NOT Input(1)) AND 
							(NOT Input(0)) ) ) )
							OR 
							( ( NOT Current_State(3)) AND (NOT Current_State(2)) AND (NOT Current_State(1)) AND Current_State(0) AND Input(2) AND Input(1) AND Input(0) )
							OR 
							( (NOT Current_State(3)) AND (NOT Current_State(2)) AND Current_State(1) AND (NOT Current_State(0)) AND ( ( (NOT Input(2)) AND (NOT Input(1)) AND 
							Input(0) ) OR ( (NOT Input(2)) AND Input(1) AND (NOT Input(0)) ) OR ( Input(2) AND (NOT Input(1)) AND (NOT Input(0)) ) OR ( Input(2) AND Input(1) and
							Input(0) ) ) )
							OR 
							( (NOT Current_State(3)) AND (NOT Current_State(2)) AND Current_State(1) AND Current_State(0) AND Input(2) AND Input(1) AND Input(0) )
							OR 
							( (NOT Current_State(3)) AND Current_State(2) AND (NOT Current_State(1)) AND (NOT Current_State(0)) AND ( ( (NOT Input(2)) AND (NOT Input(1)) AND 
							Input(0) ) OR ( (NOT Input(2)) AND Input(1) AND (NOT Input(0)) ) OR ( Input(2) AND (NOT Input(1)) AND (NOT Input(0)) ) OR ( Input(2) AND Input(1) and
							Input(0) ) ) )
							OR
							( (NOT Current_State(3)) AND Current_State(2) AND (NOT Current_State(1)) AND Current_State(0) AND Input(2) AND Input(1) AND Input(0) )
							OR 
							( (NOT Current_State(3)) AND Current_State(2) AND Current_State(1) AND (NOT Current_State(0)) AND ( ( (NOT Input(2)) AND (NOT Input(1)) AND 
							Input(0) ) OR ( (NOT Input(2)) AND Input(1) AND (NOT Input(0)) ) OR ( Input(2) AND (NOT Input(1)) AND (NOT Input(0)) ) OR ( Input(2) AND Input(1) and
							Input(0) ) ) )
							after 5.6 ns;
							
		Permit <= Current_State(3) AND (NOT Current_State(2)) AND (NOT Current_State(0));
		
		ReturnChange <= Current_State(3) AND (NOT Current_State(2)) AND Current_State(1);	
	end process CombLogic;

StateRegister: Process (clk)
	begin
		if(clk = '1' AND clk'event) then
			Current_State <= Next_State after 4 ns;
		end if;
	end process StateRegister;

END Structural;