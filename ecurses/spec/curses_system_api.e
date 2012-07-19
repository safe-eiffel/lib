indexing
    description:"Curses 'system' API, see curs_util, curs_kernel"
    cluster: 	"ecurses, spec"
    interface: 	"mixin"
    status: 	"See notice at end of class"
    date: 	"$Date$"
    revision: 	"$Revision$"
    author: 	"Paul G. Crismer, Eric Fafchamps"

class CURSES_SYSTEM_API

feature 

	def_prog_mode : INTEGER is
	external "C"
	alias "c_ecurses_def_prog_mode"
	end

	def_shell_mode : INTEGER is
	external "C"
	alias "c_ecurses_def_shell_mode"
	end

	reset_prog_mode : INTEGER is
	external "C"
	alias "c_ecurses_reset_prog_mode"
	end

	reset_shell_mode : INTEGER is
	external "C"
	alias "c_ecurses_reset_shell_mode"
	end

	resetty : INTEGER is
	external "C"
	alias "c_ecurses_resetty"
	end

	savetty : INTEGER is
	external "C"
	alias "c_ecurses_savetty"
	end
 
	getsyx (y, x : POINTER) is
	external "C"
	alias "c_ecurses_getsyx"
	end

 
	setsyx (y, x : INTEGER) is
	external "C"
	alias "c_ecurses_setsyx"
	end

	curs_set (visibility : INTEGER) : INTEGER is
	external "C"
	alias "c_ecurses_curs_set"
	end

	napms (ms : INTEGER) : INTEGER is 
	external "C"
	alias "c_ecurses_napms"
	end

	unctrl (c : INTEGER) : POINTER is 
	external "C"
	alias "c_ecurses_unctrl"
	end

	keyname (c : INTEGER) : POINTER is 
	external "C"
	alias "c_ecurses_keyname"
	end

end -- class CURSES_SYSTEM_API
-----------------------------------------------------------
-- Copyright (C) 1999-2009 Paul G. Crismer, Eric Fafchamps
-- Licensed under Eiffel Forum Freeware License, version 2
-- (see forum.txt)
-----------------------------------------------------------

