library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY adder IS 
	PORT( 
		x , y: IN STD_LOGIC_VECTOR(10 DOWNTO 0); 
     	 	out1 :OUT STD_LOGIC_VECTOR(10 DOWNTO 0));
END ENTITY;

ARCHITECTURE comp OF adder IS

	SIGNAL temp : STD_LOGIC_VECTOR(10 DOWNTO 0);

	BEGIN
		temp <= STD_LOGIC_VECTOR (UNSIGNED(x) + UNSIGNED(y));
		out1 <= temp;
	end comp;



