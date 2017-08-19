----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/28/2017 07:27:51 PM
-- Design Name: 
-- Module Name: lab3b_tb - Behavioral
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

entity lab3b_tb is
--  Port ( );
end lab3b_tb;

architecture Behavioral of lab3b_tb is

	COMPONENT Locator_beh
		Port ( Start : in  STD_LOGIC;
			   Rst : in  STD_LOGIC;
			   Clk : in  STD_LOGIC;
			   Loc : out  STD_LOGIC_VECTOR (15 downto 0);
			   Done : out  STD_LOGIC);
	end COMPONENT;
	
	--inputs
	signal Clk : std_logic := '0';
	signal start : std_logic := '0';
	signal reset: std_logic := '0';
	
	--outputs
	signal loc : std_logic_vector (15 downto 0);
	signal done : std_logic := '0';
	
	--clock period definition
	constant clk_period : time := 36 ns;

begin

	uut: Locator_beh PORT MAP (
		Clk => Clk,
		Start => start,
		Rst => reset,
		Loc => loc,
		Done => done
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
		wait for 10 ns;
		
		reset <= '1';
		start <= '0;
		wait for 100 ns;
		
		reset <= '0';
		wait for 20 ns;
		
		start <= '1';
		wait until rising_edge(clk);
		wait for clk_period;
		start <= '0';
		
		wait for clk_period*5;
		assert (done = '0' AND loc = "ZZZZZZZZZZZZZZZZ") report "Done is 1 and Location is not high impedence" SEVERITY WARNING;
		
		wait for clk_period*5;
		assert(done = '1' AND loc = "0000000011001000") report "Done is 0 and Location is not 200" SEVERITY WARNING;
			
		wait;
	end process;
	
end Behavioral;
