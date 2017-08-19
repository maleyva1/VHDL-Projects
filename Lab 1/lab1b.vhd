----------------------------------------------------------------------
-- Digital Design 101 Lab Assignment 1
-- LFDetector Behavioral Model
----------------------------------------------------------------------
-- Student First Name : Mark
-- Student Last Name : Leyva
-- Student ID : 25662446
----------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY LFDetector_behav IS
   PORT (Fuel3, Fuel2, Fuel1, Fuel0: IN std_logic;
         FuelWarningLight: OUT std_logic);
END LFDetector_behav;

ARCHITECTURE Behavior OF LFDetector_behav IS

-- DO NOT modify any signals, ports, or entities above this line
-- add your code below this line
-- put your code in a PROCESS
-- use AND/OR/NOT keywords for behavioral function
BEGIN
	PROCESS(Fuel3, Fuel2, Fuel1, Fuel0)
	BEGIN
		--FuelWarningLight <= NOT(Fuel3) AND ((Fuel2 AND NOT(Fuel1)) OR NOT(Fuel2)) AFTER 5 NS;
		--FuelWarningLight <= NOT(Fuel3 AND NOT(Fuel2) AND Fuel1) AND (NOT(Fuel3) OR NOT(Fuel2)) AFTER 2.4 NS;
		-- FuelWarningLight <= NOT(Fuel3) AND Not(Fuel2 AND (Not(Fuel2) OR Fuel1)) AFTER 1.4 NS;
		FuelWarningLight <= NOT(Fuel3) AND Not(Fuel2 AND Fuel1) AFTER 1.4 NS;
	END PROCESS;
	
END Behavior;