indexing
    description: "Curses pad API";
    cluster: 	"ecurses, spec"
    interface: 	"mixin"
    status: 	"See notice at end of class"
    date: 	"$Date$"
    revision: 	"$Revision$"
    author: 	"Paul G. Crismer, Eric Fafchamps"

class 
	CURSES_PAD_API

inherit
	
	RCURSES_PAD_API_IDS
		export
			{NONE} all
		end

	RCURSES_CLIENT_API
		export
			{NONE} all
		end

feature

    newpad (lines, columns : INTEGER) : POINTER is
		do
			remote_curses.send_request (Id_newpad, <<lines, columns>>)
			Result := new_pointer_for_identifier (remote_curses.last_results.item (1))
		end	

    prefresh (w : POINTER; pmr, pmc, smir, smic, smar, smac : INTEGER) : INTEGER is
    	local
    		an_identifier: STRING
    	do
			an_identifier := identifier_from_pointer (p)
			remote_curses.send_request (Id_prefresh, <<an_identifier, pmr, pmc, smir, smic, smar, smac>>)
			Result := remote_curses.last_results.item (1).to_integer
		end	

    pnoutrefresh (w : POINTER; pmr, pmc, smir, smic, smar, smac : INTEGER) : INTEGER is
    	local
    		an_identifier: STRING
    	do
			an_identifier := identifier_from_pointer (p)
			remote_curses.send_request (Id_pnoutrefresh, <<an_identifier, pmr, pmc, smir, smic, smar, smac>>)
			Result := remote_curses.last_results.item (1).to_integer
		end	

    subpad (w: POINTER; lines, columns, begin_y, begin_x : INTEGER) : POINTER is
    	local
    		an_identifier: STRING
    	do
			an_identifier := identifier_from_pointer (p)
			remote_curses.send_request (Id_subpad, <<an_identifier, lines, columns, begin_y, begin_x>>)
			Result := new_pointer_for_identifier (remote_curses.last_results.item (1))
		end	

    pechochar (w: POINTER; ch : INTEGER) is
    	local
    		an_identifier: STRING
    	do
			an_identifier := identifier_from_pointer (p)
			remote_curses.send_request (Id_pechochar, <<an_identifier, ch>>)
		end	


end -- class CURSES_PAD_API

-----------------------------------------------------------
-- Copyright (C) 1999-2009 Paul G. Crismer, Eric Fafchamps
-- Licensed under Eiffel Forum Freeware License, version 2
-- (see forum.txt)
-----------------------------------------------------------


