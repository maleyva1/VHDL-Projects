----------------------------------------------------------------------
-- EECS31L/CSE31L Assignment2
-- FSM Behavioral Model
----------------------------------------------------------------------
-- Student First Name : Mark
-- Student Last Name : Leyva
-- Student ID : 25662446
----------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

entity Lab2b_FSM is
    Port ( Input : in  STD_LOGIC_VECTOR(2 DOWNTO 0);
           Clk : in  STD_LOGIC;
           Permit : out  STD_LOGIC;
           ReturnChange : out  STD_LOGIC);
end Lab2b_FSM;

architecture Behavioral of Lab2b_FSM is

-- DO NOT modify any signals, ports, or entities above this line
-- Create 2 processes (one for updating state status and the other for describing transitions and outputs)
-- Figure out the appropriate sensitivity list of both the processes.
-- Use CASE statements and IF/ELSE/ELSIF statements to describe your processes.
-- add your code here
TYPE StateType is
	(NoBill_State, OneBill_State, OneBillWait_State, TwoBill_State, TwoBillWait_State, ThreeBill_State, ThreeBillWait_State, TenBill_State, TenBillWait_State, TwentyBill_State, FifteenBill_State, FifteenBillWait_State, PermitNoChange_State, PermitChange_State, NoPermitChange_State);
	
	Signal Current_State, Next_State: StateType;
	
begin

CombLogic: Process (Input, Current_State)
begin
	case Current_State IS
		When NoBill_State =>
			Permit <= '0';
			ReturnChange <= '0';
			if(Input = "000") then
				Next_State <= NoBill_State;
			elsif(Input = "001") then
				Next_State <= OneBill_State;
			elsif(Input = "010") then
				Next_State <= TenBIll_State;
			elsif(Input = "100") then
				Next_State <= TwentyBill_State;
			elsif(Input = "111") then
				Next_State <= NoBill_State;
			else
				Next_State <= NoBill_State;
			end if;
		When OneBill_State =>
			Permit <= '0';
			ReturnChange <= '0';
			if(Input <= "000") then
				Next_State <= OneBillWait_State;
			elsif(Input = "001") then
				Next_State <= OneBill_State;
			elsif(Input = "010") then
				Next_State <= OneBill_State;
			elsif(Input = "100") then
				Next_State <= OneBill_State;
			elsif(Input = "111") then
				Next_State <= NoPermitChange_State;
			else
				Next_State <= OneBill_State;
			end if;
		When OneBillWait_State =>
			Permit <= '0';
			ReturnChange <= '0';
			if(Input <= "000") then
				Next_State <= OneBillWait_State;
			elsif(Input = "001") then
				Next_State <= TwoBill_State;
			elsif(Input = "010") then
				Next_State <= FifteenBill_State;
			elsif(Input = "100") then
				Next_State <= PermitChange_State;
			elsif(Input = "111") then
				Next_State <= NoPermitChange_State;
			else
				Next_State <= OneBillWait_State;
			end if;
		When TwoBill_State =>
			Permit <= '0';
			ReturnChange <= '0';
			if(Input <= "000") then
				Next_State <= TwoBillWait_State;
			elsif(Input = "001") then
				Next_State <= TwoBill_State;
			elsif(Input = "010") then
				Next_State <= PermitNoChange_State;
			elsif(Input = "100") then
				Next_State <= PermitChange_State;
			elsif(Input = "111") then
				Next_State <= NoPermitChange_State;
			else
				Next_State <= TwoBillWait_State;
			end if;
		When TwoBillWait_State =>
			Permit <= '0';
			ReturnChange <= '0';
			if(Input <= "000") then
				Next_State <= TwoBillWait_State;
			elsif(Input = "001") then
				Next_State <= ThreeBill_State;
			elsif(Input = "010") then
				Next_State <= OneBill_State;
			elsif(Input = "100") then
				Next_State <= OneBill_State;
			elsif(Input = "111") then
				Next_State <= NoPermitChange_State;
			else
				Next_State <= NoBill_State;
			end if;
		When ThreeBill_State =>
			Permit <= '0';
			ReturnChange <= '0';
			if(Input <= "000") then
				Next_State <= ThreeBillWait_State;
			elsif(Input = "001") then
				Next_State <= ThreeBill_State;
			elsif(Input = "010") then
				Next_State <= ThreeBill_State;
			elsif(Input = "100") then
				Next_State <= ThreeBill_State;
			elsif(Input = "111") then
				Next_State <= NoPermitChange_State;
			else
				Next_State <= ThreeBill_State;
			end if;
		When ThreeBillWait_State =>
			Permit <= '0';
			ReturnChange <= '0';
			if(Input <= "000") then
				Next_State <= ThreeBillWait_State;
			elsif(Input = "001") then
				Next_State <= PermitNoChange_State;
			elsif(Input = "010") then
				Next_State <= PermitChange_State;
			elsif(Input = "100") then
				Next_State <= PermitChange_State;
			elsif(Input = "111") then
				Next_State <= NoPermitChange_State;
			else
				Next_State <= ThreeBillWait_State;
			end if;
		When TenBill_State =>
			Permit <= '0';
			ReturnChange <= '0';
			if(Input <= "000") then
				Next_State <= TenBillWait_State;
			elsif(Input = "001") then
				Next_State <= TenBill_State;
			elsif(Input = "010") then
				Next_State <= TenBill_State;
			elsif(Input = "100") then
				Next_State <= TenBill_State;
			elsif(Input = "111") then
				Next_State <= NoPermitChange_State;
			else
				Next_State <= TenBill_State;
			end if;
		When TenBillWait_State =>
			Permit <= '0';
			ReturnChange <= '0';
			if(Input <= "000") then
				Next_State <= TenBillWait_State;
			elsif(Input = "001") then
				Next_State <= FifteenBill_State;
			elsif(Input = "010") then
				Next_State <= PermitNoChange_State;
			elsif(Input = "100") then
				Next_State <= PermitChange_state;
			elsif(Input = "111") then
				Next_State <= NoPermitChange_State;
			else
				Next_State <= TenBillWait_State;
			end if;
		When FifteenBill_State =>
			Permit <= '0';
			ReturnChange <= '0';
			if(Input <= "000") then
				Next_State <= FifteenBillWait_State;
			elsif(Input = "001") then
				Next_State <= FifteenBill_State;
			elsif(Input = "010") then
				Next_State <= FifteenBill_State;
			elsif(Input = "100") then
				Next_State <= FifteenBill_State;
			elsif(Input = "111") then
				Next_State <= NoPermitChange_State;
			else
				Next_State <= FifteenBill_State;
			end if;
		When FifteenBillWait_State =>
			Permit <= '0';
			ReturnChange <= '0';
			if(Input <= "000") then
				Next_State <= FifteenBillWait_State;
			elsif(Input = "001") then
				Next_State <= PermitNoChange_State;
			elsif(Input = "010") then
				Next_State <= PermitChange_State;
			elsif(Input = "100") then
				Next_State <= PermitChange_State;
			elsif(Input = "111") then
				Next_State <= NoPermitChange_State;
			else
				Next_State <= FifteenBillWait_State;
			end if;
		When TwentyBill_State =>
			Permit <= '0';
			ReturnChange <= '0';
			if(Input <= "000") then
				Next_State <= PermitNoChange_State;
			elsif(Input = "001") then
				Next_State <= TwentyBill_State;
			elsif(Input = "010") then
				Next_State <= TwentyBill_State;
			elsif(Input = "100") then
				Next_State <= TwentyBill_State;
			elsif(Input = "111") then
				Next_State <= NoPermitChange_State;
			else
				Next_State <= TwentyBill_State;
			end if;
		When PermitNoChange_State =>
			Permit <= '1';
			ReturnChange <= '0';
			Next_State <= NoBill_State;
		When PermitChange_State =>
			Permit <= '1';
			ReturnChange <= '1';
			Next_State <= NoBill_State;
		When NoPermitChange_State =>
			Permit <= '0';
			ReturnChange <= '1';
			Next_State <= NoBill_State;
	end case;
end Process CombLogic;

StateRegister: Process(clk)
begin
	if(clk = '1' AND clk'EVENT) then
		Current_State <= Next_State;
	end if;
end Process StateRegister;

END Behavioral;