library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY complement IS 
	PORT( 
		in1 : IN STD_LOGIC_VECTOR(10 DOWNTO 0); 
      		out1 :OUT STD_LOGIC_VECTOR(10 DOWNTO 0));
END ENTITY;

ARCHITECTURE comp OF complement IS

	component adder IS 
		PORT( 
			x , y: IN STD_LOGIC_VECTOR(10 DOWNTO 0); 
      			out1 :OUT STD_LOGIC_VECTOR(10 DOWNTO 0));
	END component;

	SIGNAL temp , ans : STD_LOGIC_VECTOR(10 DOWNTO 0);
	
	BEGIN
		a1: adder port map (temp , "00000000001" , ans);
		out1 <= ans;
	
	process(in1)
		begin
			temp <= not in1;
	
		end process;

	END comp;





