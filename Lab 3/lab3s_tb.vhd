----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Mark Leyva
-- 
-- Create Date: 02/15/2017 06:03:22 PM
-- Design Name: 
-- Module Name: lab3s_tb - Behavioral
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

entity lab3s_tb is
--  Port ( );
end lab3s_tb;

architecture Behavioral of lab3s_tb is

    Component lab3s is
        Port ( Start : in  STD_LOGIC;
               Rst : in  STD_LOGIC;
               Clk : in  STD_LOGIC;
               Loc : out  STD_LOGIC_VECTOR (15 downto 0);
               Done : out  STD_LOGIC);
    end Component;
    
    --inputs
    SIGNAL clk : std_logic := '0';
    SIGNAL start : std_logic := '0';
    SIGNAL reset: std_logic := '0';
    
    --outputs
    SIGNAL loc: std_logic_vector(15 downto 0);
    SIGNAL done: std_logic := '0';
    
    --clock period definition
    constant clk_period : time := 37 ns;

begin

    uut: lab3s PORT MAP (
        Start => start,
        Rst => reset,
        Clk => clk,
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
		wait for 10 ns;
		
		reset <= '0';
		start <= '0';
		wait for 20 ns;
		
		start <= '1';
		wait until rising_edge(clk);
		wait for clk_period;
		start <= '0';
		
		wait for clk_period*5;
		assert (done = '0' AND loc = "ZZZZZZZZZZZZZZZZ") report "Done is 1 and Location is not high impedence" SEVERITY WARNING;
		
		wait for clk_period;
		assert(done = '1' AND loc = "0000000011001000") report "Done is 0 and Location is not 200" SEVERITY WARNING;
			
		wait;
	end process;
	
end Behavioral;
