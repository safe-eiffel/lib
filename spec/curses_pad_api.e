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


feature

    newpad (lines, columns : INTEGER) : POINTER is
	external "C"
	alias "c_ecurses_newpad"
	end

    prefresh (w : POINTER; pmr, pmc, smir, smic, smar, smac : INTEGER) : INTEGER is
	external "C"
	alias "c_ecurses_prefresh"
	end

    pnoutrefresh (w : POINTER; pmr, pmc, smir, smic, smar, smac : INTEGER) : INTEGER is
	external "C"
	alias "c_ecurses_pnoutrefresh"
	end

    subpad (w: POINTER; lines, columns, begin_y, begin_x : INTEGER) : POINTER is
	external "C"
	alias "c_ecurses_subpad"
	end

    pechochar (w: POINTER; ch : INTEGER) is
	external "C"
	alias "c_ecurses_pechochar"
	end

end -- class CURSES_PAD_API
-----------------------------------------------------------
-- Copyright (C) 1999 Paul G. Crismer, Eric Fafchamps
-- Licensed under Eiffel Forum Freeware License, version 1
-- (see forum.txt)
-----------------------------------------------------------


