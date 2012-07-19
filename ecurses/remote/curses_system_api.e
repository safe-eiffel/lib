indexing
    description:"Curses 'system' API, see curs_util, curs_kernel"
    cluster: 	"ecurses, spec"
    interface: 	"mixin"
    status: 	"See notice at end of class"
    date: 	"$Date$"
    revision: 	"$Revision$"
    author: 	"Paul G. Crismer, Eric Fafchamps"

class CURSES_SYSTEM_API

inherit
	
	RCURSES_SYSTEM_API_IDS
		export
			{NONE} all
		end

	RCURSES_CLIENT_API
		export
			{NONE} all
		end

feature 

	def_prog_mode : INTEGER is
		do
			remote_curses.send_request (Id_def_prog_mode, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end	

	def_shell_mode : INTEGER is
		do
			remote_curses.send_request (Id_def_shell_mode, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end	

	reset_prog_mode : INTEGER is
		do
			remote_curses.send_request (Id_reset_prog_mode, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end	

	reset_shell_mode : INTEGER is
		do
			remote_curses.send_request (Id_reset_shell_mode, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end	

	resetty : INTEGER is
		do
			remote_curses.send_request (Id_resetty, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end	

	savetty : INTEGER is
		do
			remote_curses.send_request (Id_savetty, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end	
 
	getsyx (y, x : POINTER) is
		local
			i1: INTEGER
			i2: INTEGER
		do
			remote_curses.send_request (Id_getsyx, <<>>)
			i1 := remote_curses.last_results.item (1).to_integer	
			y.set_item ($i1)
			i2 := remote_curses.last_results.item (1).to_integer	
			x.set_item ($i2)
 		end
		
	setsyx (y, x : INTEGER) is
		do
			remote_curses.send_request (Id_setsyx, <<y,x>>)
		end	

	curs_set (visibility : INTEGER) : INTEGER is
		do
			remote_curses.send_request (Id_curs_set, <<visibility>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end	

	napms (ms : INTEGER) : INTEGER is 
		do
			remote_curses.send_request (Id_napms, <<ms>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end	

	unctrl (c : INTEGER) : POINTER is 
		do
			remote_curses.send_request (Id_unctrl, <<c>>)
			Result := converter.string_to_pointer (remote_curses.last_results.item (1))
		end	

	keyname (c : INTEGER) : POINTER is 
		do
			remote_curses.send_request (Id_keyname, <<c>>)
			Result := converter.string_to_pointer (remote_curses.last_results.item (1))
		end	

	converter: CURSES_EXTERNAL_TOOLS

end -- class CURSES_SYSTEM_API

-----------------------------------------------------------
-- Copyright (C) 1999-2009 Paul G. Crismer, Eric Fafchamps
-- Licensed under Eiffel Forum Freeware License, version 2
-- (see forum.txt)
-----------------------------------------------------------

