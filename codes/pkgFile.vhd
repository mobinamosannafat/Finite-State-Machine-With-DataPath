package pkgfile is
 	type State is(State_0, State_1, State_2, State_3, State_4, State_5, State_6, State_7, State_8, State_9, 
			State_10, State_11, State_12, State_13, State_14, State_15, State_16 ,State_17);
	
	procedure stAssign (Signal nxt : IN State ; Signal curr : OUT State);
END PACKAGE pkgfile;

package body pkgfile is
	procedure stAssign (Signal nxt : IN State ; Signal curr : OUT State) IS
	begin
		curr <= nxt after 2 ns;
	end procedure;
end package body pkgfile;
