----------------------------------------------------------------------
-- Digital Design 101 Lab Assignment 1
-- LFDetector Structural Model
----------------------------------------------------------------------
-- Student First Name : Mark
-- Student Last Name : Leyva
-- Student ID : 25662446
----------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY NAND2 IS
   PORT (x: IN std_logic;
         y: IN std_logic;
         F: OUT std_logic);
END NAND2;  

ARCHITECTURE behav OF NAND2 IS
BEGIN
   PROCESS(x, y)
   BEGIN
      F <= NOT (x AND y) AFTER 1.4 ns; 
   END PROCESS;
END behav;
----------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY LFDetector_structural IS
   PORT (Fuel3, Fuel2, Fuel1, Fuel0: IN std_logic;
         FuelWarningLight: OUT std_logic);
END LFDetector_structural;

ARCHITECTURE Structural OF LFDetector_structural IS

-- DO NOT modify any signals, ports, or entities above this line
-- add your code below this line
-- use the appropriate library component(s) specified in the lab handout
-- add the appropriate internal signals & wire your design below
    COMPONENT MYNAND IS
        PORT (x: IN std_logic;
              y: IN std_logic;
              F: OUT std_logic);
    END COMPONENT;
    
    SIGNAL W1, W2, W3, W4, W5, W6, F: std_logic;

BEGIN
    N1: MYNAND PORT MAP (Fuel3, Fuel3, W1);
    N2: MYNAND PORT MAP (Fuel2, Fuel2, W2);
    N3: MYNAND PORT MAP (Fuel1, Fuel1, W3);
    N4: MYNAND PORT MAP (W1, W2, W4);
    N5: MYNAND PORT MAP (Fuel2, W3, W5);
    N6: MYNAND PORT MAP (W1, W5, W6);
    N7: MYNAND PORT MAP (W4, W6, F);

END Structural;