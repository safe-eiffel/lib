indexing
	description: "Curses soft key label api"
    cluster: 	"ecurses, spec"
    interface: 	"mixin"
    status: 	"See notice at do end of class"
    date: 	"$Date$"
    revision: 	"$Revision$"
    author: 	"Paul G. Crismer, Eric Fafchamps"

class
	CURSES_SLK_API

inherit
	
	RCURSES_SLK_API_IDS
		export
			{NONE} all
		end

	RCURSES_CLIENT_API
		export
			{NONE} all
		end

feature

	slk_init (fmt : INTEGER )  : INTEGER is
		do
			remote_curses.send_request (Id_slk_init, <<fmt.out>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end	

	slk_set (labnum : INTEGER ;label  : POINTER ;fmt  : INTEGER )  : INTEGER is
	   	local
    		an_identifier: STRING
    		converter: CURSES_EXTERNAL_TOOLS
    	do
			an_identifier := converter.pointer_to_string (label)
			remote_curses.send_request (Id_slk_set, <<labnum.out, an_identifier, fmt.out>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end	

	slk_refresh  : INTEGER is
		do
			remote_curses.send_request (Id_slk_refresh, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end	

	slk_noutrefresh  : INTEGER is
		do
			remote_curses.send_request (Id_slk_noutrefresh, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end	

	slk_label (labnum : INTEGER )  : POINTER is
		local
			converter: CURSES_EXTERNAL_TOOLS
		do
			remote_curses.send_request (Id_slk_label, <<labnum>>)
			Result := converter.string_to_pointer (remote_curses.last_results.item (1))
		end	

	slk_clear  : INTEGER is
		do
			remote_curses.send_request (Id_slk_clear, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end	

	slk_restore  : INTEGER is
		do
			remote_curses.send_request (Id_slk_restore, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end	

	slk_touch  : INTEGER is
		do
			remote_curses.send_request (Id_slk_touch, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end	

	slk_attron (attrs : INTEGER )  : INTEGER is
		do
			remote_curses.send_request (Id_slk_attron, <<attrs.out>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end	
		
	slk_attrset (attrs : INTEGER ) : INTEGER is
		do
			remote_curses.send_request (Id_slk_attrset, <<attrs.out>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end	
	   
	slk_attr  : INTEGER is
		do
			remote_curses.send_request (Id_slk_attr, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end	

	slk_attroff (attrs : INTEGER )  : INTEGER is
		do
			remote_curses.send_request (Id_slk_attroff, <<attrs.out>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end	

end -- class CURSES_SLK_API

-----------------------------------------------------------
-- Copyright (C) 2001 Paul G. Crismer, Eric Fafchamps
-- Licensed under Eiffel Forum Freeware License, version 1
-- (see forum.txt)
-----------------------------------------------------------

