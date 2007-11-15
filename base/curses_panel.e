indexing
	description: "curses panel abstraction";
	cluster:        "ecurses, base"
    	interface: 	"client, classification"
    	status: 	"See notice at end of class"
    	date: 		"$Date$"
    	revision: 	"$Revision$"
    	author: 	"Paul G. Crismer, Eric Fafchamps"
class 
	CURSES_PANEL

inherit
	CURSES_PANEL_API
		export {NONE} all
		end

	CURSES_WINDOW
		redefine
			make, close, move_window, memory_refresh, refresh
		end


create
	make, make_standard_panel

feature {NONE}  -- creation

    make (a_height, a_width, y, x : INTEGER) is
		-- make panel
	do
	    Precursor (a_height, a_width, y, x)
	    pptr := new_panel(wptr)
	ensure then
		not hidden
	end -- make


    make_standard_panel is
		-- make for stdscr
	do
		make_from_pointer(api_stdscr)
		pptr := new_panel(wptr)
	ensure
		exists: exists
	end

feature -- status

     panel_exists : BOOLEAN is
	do
	    Result := exists and pptr /= default_pointer
	end

feature  -- commands

    close is
	do
	    handle_curses_call(del_panel(pptr), "del_panel")
	    Precursor		
	end

    hide is
	do
	    handle_curses_call(hide_panel(pptr), "hide_panel")
	ensure
	    hidden: hidden
	end

    show is
	do
	    handle_curses_call(show_panel(pptr), "show_panel")
	ensure
	    shown: not hidden
	end

    bring_to_front is
	require
		shown: not hidden
	do
	    handle_curses_call(top_panel(pptr), "top_panel")
	end

    send_to_back is
	require
		shown: not hidden
	do
	    handle_curses_call(bottom_panel(pptr), "bottom_panel")
	end

    hidden : BOOLEAN is
	local
		res : INTEGER
	do
	    res := panel_hidden(pptr)
	    handle_curses_call(res, "panel_hidden")
	    Result := res = curses_ok_value
	end

     move_window (y, x: INTEGER) is
	    -- Move the current panel to specific `x, y' position.
	do
	    handle_curses_call(move_panel (pptr , y, x), "move_panel")
	end

    refresh is
	do
	    update_panels
	    do_update
	end

    memory_refresh is
	do
	    update_panels	    
	end

    redraw is
	local
		pan : POINTER
	do
		from pan := panel_above(default_pointer)
		until pan = default_pointer
		loop
			handle_curses_call(touchwin (panel_window(pan)), "touchwin")
			pan := panel_above(pan)
		end
		refresh
	end
	    
feature {NONE} -- implementation

	pptr : POINTER 
		-- C panel pointer

end -- class CURSES_PANEL
-----------------------------------------------------------
-- Copyright (C) 1999 Paul G. Crismer, Eric Fafchamps
-- Licensed under Eiffel Forum Freeware License, version 1
-- (see forum.txt)
-----------------------------------------------------------

