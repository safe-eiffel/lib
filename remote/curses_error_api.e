indexing
    description: "Curses error API";
    cluster: 	"ecurses, spec"
    interface: 	"mixin"
    status: 	"See notice at end of class"
    date: 	"$Date$"
    revision: 	"$Revision$"
    author: 	"Paul G. Crismer, Eric Fafchamps"

class 
	CURSES_ERROR_API

inherit
	
	RCURSES_ERROR_API_IDS
		export
			{NONE} all
		end

	RCURSES_CLIENT_API
		export
			{NONE} all
		end

feature 

    c_ecurses_err: INTEGER is
		do
			remote_curses.send_request (Id_c_ecurses_err, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end	

    c_ecurses_ok: INTEGER is
		do
			remote_curses.send_request (Id_c_ecurses_ok, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end	


end -- class CURSES_ERROR_API

-----------------------------------------------------------
-- Copyright (C) 2001 Paul G. Crismer, Eric Fafchamps
-- Licensed under Eiffel Forum Freeware License, version 1
-- (see forum.txt)
-----------------------------------------------------------


