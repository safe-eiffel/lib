indexing
	description: "Curses soft key label api"
    cluster: 	"ecurses, spec"
    interface: 	"mixin"
    status: 	"See notice at end of class"
    date: 	"$Date$"
    revision: 	"$Revision$"
    author: 	"Paul G. Crismer, Eric Fafchamps"

class
	CURSES_SLK_API

feature

	slk_init (fmt : INTEGER )  : INTEGER is
	external "C"
	alias "c_ecurses_slk_init"
	end

	slk_set (labnum : INTEGER ;label  : POINTER ;fmt  : INTEGER )  : INTEGER is
	external "C"
	alias "c_ecurses_slk_set"
	end

	slk_refresh  : INTEGER is
	external "C"
	alias "c_ecurses_slk_refresh"
	end

	slk_noutrefresh  : INTEGER is
	external "C"
	alias "c_ecurses_slk_noutrefresh"
	end

	slk_label (labnum : INTEGER )  : POINTER is
	external "C"
	alias "c_ecurses_slk_label"
	end

	slk_clear  : INTEGER is
	external "C"
	alias "c_ecurses_slk_clear"
	end

	slk_restore  : INTEGER is
	external "C"
	alias "c_ecurses_slk_restore"
	end

	slk_touch  : INTEGER is
	external "C"
	alias "c_ecurses_slk_touch"
	end

	slk_attron (attrs : INTEGER )  : INTEGER is
	external "C"
	alias "c_ecurses_slk_attron"
	end
		
	slk_attrset (attrs : INTEGER ) : INTEGER is
	external "C"
	alias "c_ecurses_slk_attrset"
	end
	   
	slk_attr  : INTEGER is
	external "C"
	alias "c_ecurses_slk_attr"
	end

	slk_attroff (attrs : INTEGER )  : INTEGER is
	external "C"
	alias "c_ecurses_slk_attroff"
	end

end -- class CURSES_SLK_API
-----------------------------------------------------------
-- Copyright (C) 1999-2009 Paul G. Crismer, Eric Fafchamps
-- Licensed under Eiffel Forum Freeware License, version 2
-- (see forum.txt)
-----------------------------------------------------------

