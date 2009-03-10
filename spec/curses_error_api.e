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

feature 

    c_ecurses_err: INTEGER is
	external "C"
	end

    c_ecurses_ok: INTEGER is
	external "C"
	end

end -- class CURSES_ERROR_API
-----------------------------------------------------------
-- Copyright (C) 1999-2009 Paul G. Crismer, Eric Fafchamps
-- Licensed under Eiffel Forum Freeware License, version 2
-- (see forum.txt)
-----------------------------------------------------------


