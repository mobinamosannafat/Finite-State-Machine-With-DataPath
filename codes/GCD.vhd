library IEEE;
library work;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use work.pkgfile.all;


entity GCD is
    Port ( 
		input1 ,input2  : IN  STD_LOGIC_VECTOR (10 DOWNTO 0):= "00000000000";
		Start	   	: IN  STD_LOGIC:='0';
	  	PushBottun      : IN  STD_LOGIC:= '0';
		Ready	        : out  STD_LOGIC := '0' ;
       		LEDs  	        : out STD_LOGIC_VECTOR (10 DOWNTO 0):= "00000000000");
end GCD;

architecture Moor of GCD is

	FUNCTION equal (SIGNAL in1 , in2 : IN STD_LOGIC_VECTOR(10 DOWNTO 0)) RETURN STD_LOGIC IS
	VARIABLE ans : STD_LOGIC;
	BEGIN
		IF in1 = in2 THEN 
			ans := '1';
		ELSE 
			ans := '0';
		END IF;
		RETURN ans;
	END equal;

	
	FUNCTION less (SIGNAL in1 , in2: STD_LOGIC_VECTOR(10 DOWNTO 0)) RETURN STD_LOGIC IS
	VARIABLE ans : STD_LOGIC;
	BEGIN
		IF in1 < in2 THEN 
			ans := '1';
		ELSE 
			ans := '0';
		END IF;
		RETURN ans;
	END less;


	component stateAssign is
		port(
			nxt : IN State;
			curr :Out State);
	end component;

	
	COMPONENT complement IS 
		PORT( 
			in1 : IN STD_LOGIC_VECTOR(10 DOWNTO 0); 
			out1 :OUT STD_LOGIC_VECTOR(10 DOWNTO 0));
	END COMPONENT;
	
	signal CurrentState , NextState : State := State_0;
	signal Uinp1 ,Uinp2 ,op1 ,op2 ,TEMP1,TEMP2: STD_LOGIC_VECTOR (10 DOWNTO 0) ;
	signal ANSW          : STD_LOGIC_VECTOR (10 DOWNTO 0) := "00000000000";
	signal RDY           : STD_LOGIC := '0' ;
	SIGNAL eqout , lsout : STD_LOGIC;
	
	BEGIN 
		
		B1 : complement PORT MAP (input1 , Uinp1);
		B2 : complement PORT MAP (input2 , Uinp2 );
		
		stt0 : stateAssign port map (NextState , CurrentState);

		process (CurrentState)
		begin
			case CurrentState is
			
				when State_0 =>
					if Start = '1' then
						NextState <= State_1;
					else
						NextState <= State_0;
					end if;
		
				when State_1 =>
					if PushBottun = '1' then
						NextState <= State_2;
					else
						NextState <= State_1;
					end if;
					
				when State_2 => 
					op1 <= input1;
					NextState <= State_3;
					
				when State_3 => 
					if PushBottun = '1' then
						NextState <= State_4;
					else
						NextState <= State_3;
					end if;
					
				when State_4 => 
					op2 <= input2;
					NextState <= State_5;
					
				when State_5 => 
					if op1(10) = '1' then
						NextState <= State_6;
					else
						NextState <= State_7;
					end if;
					
				when State_6 =>
					op1 <= Uinp1;
					NextState <= State_7;
					
				when State_7 => 
					if op2(10) = '1' then
						NextState <= State_8;
					else
						NextState <= State_9;
					end if;
					
				when State_8 => 
					op2 <= Uinp2;
					NextState <= State_9;
					
				when State_9 =>
					eqout <= equal (op1 , op2);
					NextState <= State_10;
		
				when State_10 => 
					if eqout = '1' then
						NextState <= State_17;
					else
						NextState <= State_11;
					end if;
		
				when State_11 =>
					lsout <= less (op1 , op2);
					NextState <= State_12;
					
				when State_12 =>
					if lsout = '1' then
						NextState <= State_13;
					else	
						NextState <= State_15;
					end if;
					
				when State_13 => 
					TEMP1 <= op1;
					TEMP2 <= op2;
					NextState <= State_14;
					
				when State_14 =>
					op1 <= TEMP2;
					op2 <= TEMP1;
					NextState <= State_15;
					
				when State_15 =>
					op1 <= STD_LOGIC_VECTOR (UNSIGNED(op1) - UNSIGNED(op2));
					NextState <= State_16;
		
	
				when State_16 => 
					if op1 = "00000000000" then
						NextState <= State_17;
					else	
						NextState <= State_9;
					end if;
					
				when State_17 =>
					RDY <= '1' ;
					ANSW <= op2;
					
			END Case;
		
		END process;
				
		Ready <= RDY ;
		LEDs <= ANSW;
		
	End Moor;
	


	




