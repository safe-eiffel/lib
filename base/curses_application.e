indexing
	description: 	"Curses application";
	cluster:        "ecurses, base"
    	interface: 	"client, classification"
    	status: 	"See notice at end of class"
    	date: 		"$Date$"
    	revision: 	"$Revision$"
    	author: 	"Paul G. Crismer"


class 
	CURSES_APPLICATION

inherit
	CURSES_WINDOW_API
		export {NONE} all
		end

	SHARED_CURSES_SYSTEM

	CURSES_ERROR_HANDLING


	MEMORY
		export {NONE} all
		redefine dispose
		end
	
creation
	initialize, initialize_323, initialize_44, initialize_444,
	initialize_444i, initialize_55

feature {NONE} -- Initialization

    initialize is
	do
		standard_window_pointer := initscr
		!!standard_window.make_from_pointer(standard_window_pointer)
--		curses.enable_character_reading_mode
		curses.disable_echo
--		curses.enable_flush_input_on_interrupt
--		curses.disable_cr_nl_translation
	ensure
		initialized
	end

	initialize_323 is
		-- initialize and display soft label keys organized 3-2-3
	    do
		!!soft_label_keys.make_323
		initialize
	    ensure
		soft_label_keys /= Void
	    end

	
	initialize_44 is
		-- initialize and display soft label keys organized 4-4
	    do
		!!soft_label_keys.make_44
		initialize
	    ensure
		soft_label_keys /= Void
	    end

	initialize_444 is
		-- initialize and display soft label keys organized 4-4-4
	    do
		!!soft_label_keys.make_444
		initialize
	    ensure
		soft_label_keys /= Void
	    end

	initialize_444i  is
		-- initialize and display soft label keys organized 4-4-4
		-- plus an index line
	    do
		!!soft_label_keys.make_444i
		initialize
	    ensure
		soft_label_keys /= Void
	    end

	initialize_55 is
		-- initialize and display soft label keys organized 5-5
	    do
		!!soft_label_keys.make_55
		initialize
	    ensure
		soft_label_keys /= Void
	    end

    dispose is
	do
		if standard_window_pointer /= default_pointer then
			handle_curses_call(endwin,"endwin")
		end
	end

feature  -- queries

	soft_label_keys : CURSES_SOFT_LABEL_KEYS

	standard_window : CURSES_WINDOW

	standard_panel : CURSES_PANEL is
	    once
		!!Result.make_standard_panel
	    end

	initialized : BOOLEAN is
	    do
		Result := standard_window_pointer /= default_pointer
	    end

feature {NONE}
	standard_window_pointer : POINTER

invariant
	is_initialized : initialized

end -- class CURSES_APPLICATION
-----------------------------------------------------------
-- Copyright (C) 1999 Paul G. Crismer, Eric Fafchamps
-- Licensed under Eiffel Forum Freeware License, version 1
-- (see forum.txt)
-----------------------------------------------------------


