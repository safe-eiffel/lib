indexing
	description: 	"Curses panel API";
    	cluster: 	"ecurses, spec"
    	interface: 	"mixin"
    	status: 	"See notice at end of class"
    	date: 		"$Date$"
    	revision: 	"$Revision$"
    	author: 	"Paul G. Crismer, Eric Fafchamps"
class 
	CURSES_PANEL_API


feature

	panel_window (p : POINTER) : POINTER is
	external "C"
	alias "c_ecurses_panel_window"
	end

	update_panels is
	external "C"
	alias "c_ecurses_update_panels"
	end

	hide_panel (p : POINTER) : INTEGER is
	external "C"
	alias "c_ecurses_hide_panel"
	end

	show_panel (p : POINTER) : INTEGER is
	external "C"
	alias "c_ecurses_show_panel"
	end

	del_panel (p : POINTER) : INTEGER is
	external "C"
	alias "c_ecurses_del_panel"
	end

	top_panel (p : POINTER) : INTEGER is
	external "C"
	alias "c_ecurses_top_panel"
	end

	bottom_panel (p : POINTER) : INTEGER is
	external "C"
	alias "c_ecurses_bottom_panel"
	end

	new_panel (w : POINTER) : POINTER is
	external "C"
	alias "c_ecurses_new_panel"
	end

	panel_above (p: POINTER) : POINTER is
	external "C"
	alias "c_ecurses_panel_above"
	end


	panel_below (p: POINTER) : POINTER is
	external "C"
	alias "c_ecurses_panel_below"
	end

	set_panel_userptr(p, u : POINTER) : INTEGER is
	external "C"
	alias "c_ecurses_set_panel_userptr"
	end

	panel_userptr(p : POINTER) : POINTER is 
	external "C"
	alias "c_ecurses_panel_userptr"
	end

	move_panel (p : POINTER; y, x : INTEGER) : INTEGER is
	external "C"
	alias "c_ecurses_move_panel"
	end

	replace_panel (p, w : POINTER) : INTEGER is
	external "C"
	alias "c_ecurses_replace_panel"
	end

	panel_hidden (p : POINTER) : INTEGER is
	external "C"
	alias "c_ecurses_panel_hidden"
	end


end -- class CURSES_PANEL_API
-----------------------------------------------------------
-- Copyright (C) 1999 Paul G. Crismer, Eric Fafchamps
-- Licensed under Eiffel Forum Freeware License, version 1
-- (see forum.txt)
-----------------------------------------------------------

