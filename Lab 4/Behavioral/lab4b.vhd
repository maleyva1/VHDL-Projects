----------------------------------------------------------------------
-- EECS31L/CSE31L Assignment4 DCT
--  Behavioral Model
----------------------------------------------------------------------
-- Student First Name : Mark
-- Student Last Name :  Leyva
-- Student ID : 25662446
----------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity DCT_beh is
        port (
                Clk :           in std_logic;
                Start :         in std_logic;
                Din :           in INTEGER;
                Done :          out std_logic;
                Dout :          out INTEGER
              );
end DCT_beh;

architecture behavioral of DCT_beh is
			TYPE StateType IS
				(StartS, State1, State2, State3, State4, State5, State6, State7);
			SIGNAL Current_State, Next_State: StateType;
			
begin
        process(Start, Clk, Din)
                type RF is array ( 0 to 7, 0 to 7 ) of INTEGER;
                --------------------------------------------------
                --you may modify below variables or declare new ones  
                --for the behavioral model
                --------------------------------------------------				
                variable i, j, k        : INTEGER;
                variable InBlock        : RF;
                variable COSBlock       : RF;
                variable TempBlock      : RF;
                variable OutBlock       : RF;
                variable A, B, P, Sum   : INTEGER; 
				-- More Variables --
				variable Cnt			: INTEGER;


        begin
			--wait until Start = '1';
                -------------------------------
                -- Initialize parameter matrix
                -------------------------------
                COSBlock := ( 
        ( 125,  122,    115,    103,    88,     69,     47,     24  ),
        ( 125,  103,    47,     -24,    -88,    -122,   -115,   -69  ),
        ( 125,  69,     -47,    -122,   -88,    24,     115,    103  ),
        ( 125,  24,     -115,   -69,    88,     103,    -47,    -122  ),
        ( 125,  -24,    -115,   69,     88,     -103,   -47,    122  ),
        ( 125,  -69,    -47,    122,    -88,    -24,    115,    -103  ),
        ( 125,  -103,   47,     24,     -88,    122,    -115,   69  ),
        ( 125,  -122,   115,    -103,   88,     -69,    47,     -24  )
                        );

		--add your code here    
			case Current_State IS
				When StartS =>
					Done <= '0';
					Cnt := 0;
					Dout <= 0;
					i := 0;
					j := 0;
					if(Start = '1') then
						Next_State <= State1;
					else
						Next_State <= StartS;
					end if;
				When State1 =>
					--Set InBlock to Din
					if(rising_edge(clk) and i < 8) then
						InBlock(i, j) := Din;
						Cnt := Cnt + 1;
						j := j + 1;
					end if;
					if(j > 7) then
						j := 0;
						i := i + 1;
						if(Cnt < 63) then
							Next_State <= State1;
						elsif(Cnt > 63) then
							Next_State <= State2;
						end if;
					elsif(j <= 7 and Cnt < 63) then
						Next_State <= State1;
					end if;
				When State2 =>
					Sum := 0;
					Cnt := 0;
					Next_State <= State3;
				When State3 =>
					for i in 0 to 7 loop
						for j in 0 to 7 loop
							Sum := 0;
							for k in 0 to 7 loop
								A := CosBlock(i, k);
								B := InBlock(k, j);
								P := A * B;
								Sum := Sum + P;
								if(k = 7) then
									TempBlock(i, j) := Sum;
								end if;
								cnt := cnt + 1;
							end loop;
						end loop;
					end loop;
					Next_State <= State4;
				When State4 =>
					Cnt := 0;
					Sum := 0;
					Next_State <= State5;
				When State5 =>
					-- Transpose CosBlock
					i := 0;
					j := 0;
					for i in 0 to 6 loop
						for j in (i + 1) to 7 loop
							A := CosBlock(i, j);
							CosBlock(i, j) := CosBlock(j, i);
							CosBlock(j, i) := A;
						end loop;
					end loop;
					-- Multiply transpose of CosBlock with TempBlock
					i := 0;
					j := 0;
					for i in 0 to 7 loop
						for j in 0 to 7 loop
							Sum := 0;
							for k in 0 to 7 loop
								A := TempBlock(i, k);
								B := CosBlock(k, j);
								P := A * B;
								Sum := Sum + P;
								if(k = 7) then
									OutBlock(i, j) := Sum;
								end if;
							end loop;
						end loop;
					end loop;
					Next_State <= State6;
				When State6 =>
					Cnt := 0;
					Done <= '1';
					Next_State <= State7;
				When State7 =>
				    Done <= '0';
					if(rising_edge(clk) and i < 8) then
						Dout <= OutBlock(i, j);
						Cnt := Cnt + 1;
						j := j + 1;
					end if;
					if(j > 7) then
						j := 0;
						i := i + 1;
						if(Cnt < 63) then
							Next_State <= State7;
						elsif(Cnt > 63) then
							Next_State <= StartS;
						end if;
					elsif(j <= 7 and Cnt < 63) then
						Next_State <= State7;
					end if;
			end case;
		end process;
		
    StateRegister: Process(clk)
	begin
		if(clk = '1' AND clk'EVENT) then
			Current_State <= Next_State;
		end if;
	end Process StateRegister;

end behavioral;
