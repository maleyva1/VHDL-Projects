----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/28/2017 07:27:51 PM
-- Design Name: 
-- Module Name: lab2b_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity lab2b_tb is
--  Port ( );
end lab2b_tb;

architecture Behavioral of lab2b_tb is

	COMPONENT Lab2b_FSM
		Port ( Input : in  STD_LOGIC_VECTOR(2 DOWNTO 0);
			   Clk : in  STD_LOGIC;
			   Permit : out  STD_LOGIC;
			   ReturnChange : out  STD_LOGIC);
	end COMPONENT;
	
	--inputs
	signal Clk : std_logic := '0';
	signal Input : STD_LOGIC_VECTOR(2 DOWNTO 0);
	
	--outputs
	signal permit : std_logic := '0';
	signal change : std_logic := '0';
	
	--clock period definition
	constant clk_period : time := 10 ns;

begin

	uut: Lab2b_FSM PORT MAP (
		Clk => Clk,
		Input => Input,
		Permit => permit,
		ReturnChange => change
	);
	
	clk_process :process
	begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
   
   --stimulus process
   stim_proc: process
   begin
		Input <= "000";
		wait for 100 ns;
		
		wait for clk_period*10;
		
			Input <= "001";
			WAIT UNTIL clk = '1' AND clk'EVENT;
			Wait for 20 ns;
			ASSERT (permit = '0' AND change = '0') REPORT "Failed NoBill_State -> OneBill_State" SEVERITY Warning;
			
			Input <= "000";
			WAIT UNTIL clk = '1' AND clk'EVENT;
			Wait for 20 ns;
			ASSERT (permit = '0' AND change = '0') REPORT "Failed OneBill_State - > OneBillWait_State" SEVERITY Warning;
			
			Input <= "100";
			WAIT UNTIL clk = '1' AND clk'EVENT;
			Wait for 20 ns;
			ASSERT (permit = '1' AND change = '1') REPORT "Failed OneBillWait_State -> PermitChange_State" SEVERITY Warning;
			
			Input <= "000";
			WAIT UNTIL clk = '1' AND clk'EVENT;
			Wait for 20 ns;
			ASSERT (permit = '0' AND change = '0') REPORT "Failed PermitChange_State -> NoBill_State" SEVERITY Warning;
			
			Input <= "010";
			WAIT UNTIL clk = '1' AND clk'EVENT;
			Wait for 20 ns;
			ASSERT (permit = '0' AND change = '0') REPORT "Failed NoBill_State -> TenBill_State" SEVERITY Warning;
			
			Input <= "000";
			WAIT UNTIL clk = '1' AND clk'EVENT;
			Wait for 20 ns;
			ASSERT (permit = '0' AND change = '0') REPORT "Failed TenBill_State -> TenBillWait_Stat" SEVERITY Warning;
			
			Input <= "010";
			WAIT UNTIL clk = '1' AND clk'EVENT;
			Wait for 20 ns;
			ASSERT (permit = '1' AND change = '0') REPORT "Failed TenBillWait_State -> PermitNoChange_State" SEVERITY Warning;
			
			Input <= "000";
			WAIT UNTIL clk = '1' AND clk'EVENT;
			Wait for 20 ns;
			ASSERT (permit = '0' AND change = '0') REPORT "Failed PermitNoChange_State -> NoBill_State" SEVERITY Warning;
			
			Input <= "100";
			WAIT UNTIL clk = '1' AND clk'EVENT;
			Wait for 20 ns;
			ASSERT (permit = '0' AND change = '0') REPORT "Failed NoBill_State -> TwentyBill_State" SEVERITY Warning;
			
			Input <= "111";
			WAIT UNTIL clk = '1' AND clk'EVENT;
			Wait for 20 ns;
			ASSERT (permit = '0' AND change = '1') REPORT "Failed TwentyBill_State -> NoPermitChange_State" SEVERITY Warning;
			
			Input <= "000";
			WAIT UNTIL clk = '1' AND clk'EVENT;
			Wait for 20 ns;
			ASSERT (permit = '0' AND change = '0') REPORT "Failed NoPermitChange_State -> NoBill_State" SEVERITY Warning;
			
			Input <= "001";
			WAIT UNTIL clk = '1' AND clk'EVENT;
			Wait for 20 ns;
			ASSERT (permit = '0' AND change = '0') REPORT "Failed NoBill_State -> OneBill_State" SEVERITY Warning;
			
			Input <= "001";
			WAIT UNTIL clk = '1' AND clk'EVENT;
			Wait for 20 ns;
			ASSERT (permit = '0' AND change = '0') REPORT "Failed OneBill_State -> OneBill_State" SEVERITY Warning;
			
			Input <= "000";
			WAIT UNTIL clk = '1' AND clk'EVENT;
			Wait for 20 ns;
			ASSERT (permit = '0' AND change = '0') REPORT "Failed OneBill_State -> OneBillWait_State" SEVERITY Warning;
			
			Input <= "010";
			WAIT UNTIL clk = '1' AND clk'EVENT;
			Wait for 20 ns;
			ASSERT (permit = '0' AND change = '0') REPORT "Failed OneBillWait_State -> FifteenBill_State" SEVERITY Warning;
			
			Input <= "000";
			WAIT UNTIL clk = '1' AND clk'EVENT;
			Wait for 20 ns;
			ASSERT (permit = '0' AND change = '0') REPORT "Failed FifteenBill_State -> FifteenBillWait_State" SEVERITY Warning;
			
			Input <= "001";
			WAIT UNTIL clk = '1' AND clk'EVENT;
			Wait for 20 ns;
			ASSERT (permit = '1' AND change = '0') REPORT "Failed FifteenBillWait_State -> PermitNoChange_State" SEVERITY Warning;
			
			Input <= "000";
			WAIT UNTIL clk = '1' AND clk'EVENT;
			Wait for 20 ns;
			ASSERT (permit = '0' AND change = '0') REPORT "Failed PermitNoChange_State -> NoBill_State" SEVERITY Warning;
			
			Input <= "001";
			WAIT UNTIL clk = '1' AND clk'EVENT;
			Wait for 20 ns;
			ASSERT (permit = '0' AND change = '0') REPORT "Failed NoBill_State -> OneBill_State" SEVERITY Warning;
			
			Input <= "000";
			WAIT UNTIL clk = '1' AND clk'EVENT;
			Wait for 20 ns;
			ASSERT (permit = '0' AND change = '0') REPORT "Failed OneBill_State -> OneBillWait_State" SEVERITY Warning;
			
			Input <= "001";
			WAIT UNTIL clk = '1' AND clk'EVENT;
			Wait for 20 ns;
			ASSERT (permit = '0' AND change = '0') REPORT "Failed OneBillWait_State -> TwoBill_State" SEVERITY Warning;
			
			Input <= "000";
			WAIT UNTIL clk = '1' AND clk'EVENT;
			Wait for 20 ns;
			ASSERT (permit = '0' AND change = '0') REPORT "Failed TwoBill_State -> TwoBillWait_State" SEVERITY Warning;
			
			Input <= "001";
			WAIT UNTIL clk = '1' AND clk'EVENT;
			Wait for 20 ns;
			ASSERT (permit = '0' AND change = '0') REPORT "Failed TwoBillWait_State -> ThreeBill_State" SEVERITY Warning;
			
			Input <= "000";
			WAIT UNTIL clk = '1' AND clk'EVENT;
			Wait for 20 ns;
			ASSERT (permit = '0' AND change = '0') REPORT "Failed ThreeBill_State -> ThreeBillWait_State" SEVERITY Warning;
			
			Input <= "001";
			WAIT UNTIL clk = '1' AND clk'EVENT;
			Wait for 20 ns;
			ASSERT (permit = '1' AND change = '0') REPORT "Failed ThreeBillWait_State -> PermitNoChange_State" SEVERITY Warning;
			
			Input <= "000";
			WAIT UNTIL clk = '1' AND clk'EVENT;
			Wait for 20 ns;
			ASSERT (permit = '1' AND change = '0') REPORT "Failed PermitNoChangE_State -> NoBill_State" SEVERITY Warning;
		wait;
	end process;
	
end Behavioral;
