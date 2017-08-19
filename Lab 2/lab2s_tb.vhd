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

entity lab2s_tb is
--  Port ( );
end lab2s_tb;

architecture behavior of lab2s_tb is

	COMPONENT Lab2s_FSM
		Port ( Input : in  STD_LOGIC_VECTOR(2 DOWNTO 0);
			   Clk : in  STD_LOGIC;
			   Permit : out  STD_LOGIC;
			   ReturnChange : out  STD_LOGIC);
	end COMPONENT;
	
	--inputs
	signal Clk : std_logic := '0';
	signal Input : STD_LOGIC_VECTOR(2 DOWNTO 0) := (others => '0');
	
	--outputs
	signal permit : std_logic := '0';
	signal change : std_logic := '0';
	
	--clock period definition
	constant clk_period : time := 10 ns;

begin

	uut: Lab2s_FSM PORT MAP (
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
		WAIT UNTIL clk = '1' AND clk'EVENT;
		Wait for 10 ns;
		ASSERT( permit = '0' AND change = '0') REPORT "Failed to enter Start_State" SEVERITY Warning;
		
		Input <="010";
		WAIT UNTIL clk = '1' AND clk'EVENT;
		Wait for 10 ns;
		ASSERT( permit = '0' AND change = '0') REPORT "Failed Start_State -> $10 Received_State" SEVERITY Warning;
		
		Input <="000";
		WAIT UNTIL clk = '1' AND clk'EVENT;
		Wait for 10 ns;
		ASSERT( permit = '0' AND change = '0') REPORT "Failed $10 Received_State -> $10 Ready_Next_State" SEVERITY Warning;
		
		Input <="010";
		WAIT UNTIL clk = '1' AND clk'EVENT;
		Wait for 10 ns;
		ASSERT( permit = '0' AND change = '0') REPORT "Failed $10 Ready_Next_State -> $20 Received_State" SEVERITY Warning;
		
		Input <="000";
		WAIT UNTIL clk = '1' AND clk'EVENT;
		Wait for 10 ns;
		ASSERT( permit = '1' AND change = '0') REPORT "Failed $20 Received_State -> $20 Permit_State" SEVERITY Warning;
		
		Input <="000";
		WAIT UNTIL clk = '1' AND clk'EVENT;
		Wait for 10 ns;
		ASSERT( permit = '0' AND change = '0') REPORT "Failed $20 Permit_State -> Start_State" SEVERITY Warning;
		
		Input <="100";
		WAIT UNTIL clk = '1' AND clk'EVENT;
		Wait for 10 ns;
		ASSERT( permit = '0' AND change = '0') REPORT "Failed Start_State -> $20 Received_State" SEVERITY Warning;
		
		Input <="000";
		WAIT UNTIL clk = '1' AND clk'EVENT;
		Wait for 10 ns;
		ASSERT( permit = '1' AND change = '0') REPORT "Failed $20 Received_State -> $20 Permit_State" SEVERITY Warning;
	end process;
	
end behavior;
