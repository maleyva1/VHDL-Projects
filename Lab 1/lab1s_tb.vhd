----------------------------------------------------------------------
-- Digital Design 101 Lab Assignment 1
-- LFDetector Structural Model Testbench
----------------------------------------------------------------------
-- Student First Name : Mark
-- Student Last Name : Leyva
-- Student ID : 25662446
--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Design Name:   LFDetector_behav
-- Module Name:   lab1b_tb.vhd
-- Project Name:  Lab1_LFDetector
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: LFDetector_behav
--
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends 
-- that these types always be used for the top-level I/O of a design in order 
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY lab1s_tb_vhd IS
END lab1s_tb_vhd;

ARCHITECTURE TBARCH of lab1s_tb_vhd IS
	COMPONENT LFDetector_structural IS
		PORT (Fuel3, Fuel2, Fuel1, Fuel0: IN std_logic;
			FuelWarningLight: OUT std_logic);
	END COMPONENT;
	
	SIGNAL fuel3, fuel2, fuel1, fuel0, y: std_logic;
	
BEGIN
	CompToTest: LFDetector_structural
		PORT MAP (fuel3, fuel2, fuel1, fuel0, y);
	PROCESS
	BEGIN
				-- Expecting these five values to be 1
		fuel3 <= '0';fuel2 <= '1';fuel1 <= '0';fuel0 <= '1';
		wait for 10 ns;
		
		Fuel3 <= '0';fuel2 <= '1';fuel1 <= '0';fuel0 <= '0';
		wait for 10 ns;
		
		fuel3 <= '0';fuel2 <= '0';fuel1 <= '1';fuel0 <= '1';
		wait for 10 ns;
		
		fuel3 <= '0';fuel2 <= '0';fuel1 <= '1';fuel0 <= '0';
		wait for 10 ns;
		
		fuel3 <= '0';fuel2 <= '0';fuel1 <= '0';fuel0 <='1';
		wait for 10 ns;

        -- testing value "0000", expecting FuelWarningLight = __?
        -- should be 1
		fuel3 <= '0';fuel2 <= '0';fuel1 <= '0';fuel0 <='0';
		wait for 10 ns;
       
        -- test more values
        -- these values should not trigger the FuelWarningLight
        fuel3 <= '1';fuel2 <= '1';fuel1 <= '1';fuel0 <= '1';
        wait for 10 ns;
		
		wait;
	END PROCESS;
END TBARCH;