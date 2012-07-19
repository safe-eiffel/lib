indexing
	description: "Shared access to curses system";
	cluster:        "ecurses, base"
    	interface: 	"classification"
    	status: 	"See notice at end of class"
    	date: 		"$Date$"
    	revision: 	"$Revision$"
    	author: 	"Paul G. Crismer, Eric Fafchamps"
class 
	SHARED_CURSES_SYSTEM

feature -- shared item

	curses : CURSES_SYSTEM is
		once
			create Result
		end
			
end -- class SHARED_CURSES_SYSTEM
-----------------------------------------------------------
-- Copyright (C) 1999-2009 Paul G. Crismer, Eric Fafchamps
-- Licensed under Eiffel Forum Freeware License, version 2
-- (see forum.txt)
-----------------------------------------------------------


