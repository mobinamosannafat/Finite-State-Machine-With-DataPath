library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use work.pkgfile.all;

entity stateAssign is
	port(
		nxt : IN State;
		curr :Out State);
	end entity;

architecture arch1 of stateAssign is

begin
	stAssign( nxt , curr);

end arch1;

