----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Mark Leyva
-- 
-- Create Date: 03/15/2017 03:05:19 PM
-- Design Name: 
-- Module Name: lab4s_tb - Behavioral
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

entity lab4s_tb is
--  Port ( );
end lab4s_tb;

architecture Behavioral of lab4s_tb is

	COMPONENT DCT_str IS
      Port (
                Clk :           in std_logic;
                Start :         in std_logic;
                Din :           in INTEGER;
                Done :          out std_logic;
                Dout :          out INTEGER
              );
	End COMPONENT;
	
	--inputs
	signal Clk : std_logic := '0';
	signal start : std_logic := '0';
	signal din : INTEGER := 0;
	
	--outputs
	signal dout : INTEGER := 0;
	signal done : std_logic := '0';
	
	--clock period definition
	-- From Reg A/B to Multiplier to RegP
	constant clk_period : time := 34 ns;

begin

	uut: DCT_str PORT MAP (
		Clk => Clk,
		Start => start,
		Din => din,
		Done => done,
		Dout => dout
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

		start <= '0';
		wait for 100 ns;
		
		start <= '1';
		wait until rising_edge(clk);
		--wait for clk_period;
		start <= '0';
		
		-- Wait until counter reaches 128 --
		-- Reasoning: InBlock starts at 128 --
		--wait for 4.292 us;
		---------------------------------
		--      Feed Data -- Sandwich Case
		---------------------------------
		for i in 0 to 7 loop
			wait until Clk = '0' AND CLK'EVENT;
			Din <= 255;
		end loop;

		-- feed in the rest of the cases here
		for i in 0 to 39 loop
			wait until Clk = '0' AND CLK'EVENT;
			Din <= 0;
		end loop;
		
		for i in 0 to 15 loop
			wait until Clk = '0' AND CLK'EVENT;
			Din <= 255;
		end loop;
		--------------------------------

			
		wait;
	end process;

end Behavioral;
