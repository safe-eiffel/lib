indexing
	description: "Interface to curses soft label keys";
	cluster:        "ecurses, base"
    	interface: 	"client, shared"
    	status: 	"See notice at end of class"
    	date: 		"$Date$"
    	revision: 	"$Revision$"
    	author: 	"Paul G. Crismer, Eric Fafchamps"
class 
	CURSES_SOFT_LABEL_KEYS

inherit

	CURSES_WINDOW_API
		export {NONE} all
		end

	CURSES_SLK_API
		export {NONE} all
		end

	CURSES_ERROR_HANDLING

creation

	make_323, make_44, make_444, make_444i, make_55

feature {NONE} -- Initialization

	make_323 is
		-- make 8 soft label keys organized as 3-2-3
	    do
		initialize_soft_label_keys (0)
		count := 8
	    ensure
		count_ok: count = 8
	    end

	make_44 is
		-- make 8 soft label keys organized as 4-4
	    do
		initialize_soft_label_keys (1)
		count := 8
	    ensure
		count_ok: count = 8
	    end

	make_444 is
		-- make 12 soft label keys organized as 4-4-4
		-- !!! Curses only
	    do
		initialize_soft_label_keys (2)
		count := 12
	    ensure
		count_ok: count = 12
	    end

	make_444i is
		-- make 12 soft label keys organized as 4-4-4
		-- plus one index line
		-- !!! Curses only
	    do
		initialize_soft_label_keys (3)
		count := 12
	    ensure
		count_ok: count = 12
	    end


	make_55 is
		-- make 10 soft label keys organized as 5-5
		-- !! PDCurses only
	    do
		initialize_soft_label_keys (55)
		count := 10
	    ensure
		count_ok: count = 10
	    end

	initialize_soft_label_keys (mode : INTEGER) is
		-- initialize slk window
		do
			handle_curses_call (slk_init (mode), "slk_init")
			if last_error = curses_error_value then
				raise ("Wrong soft label key organization,%
				% please see Curses, Ncurses, or PDCurses documentation");
			end
		end

feature -- Status report

	count : INTEGER
		-- number of soft label keys

	item (key_num : INTEGER) : STRING is
		-- label of 'key_num'
	    require
		key_num_ok: key_num >=1 and key_num <= count
	    local
		p : POINTER
		tools: CURSES_EXTERNAL_TOOLS
	    do
		p := slk_label (key_num)
		Result := tools.pointer_to_string (p)
	    end

    current_attributes : INTEGER is
		-- current character attributes
		do
			handle_curses_call (slk_attr, "slk_attr")
			Result := last_error
		end


    left_justified 	: INTEGER is 0
    centered 		: INTEGER is 1
    right_justified 	: INTEGER is 2

feature -- Status setting

	set_label (key_num : INTEGER; msg : STRING; mode : INTEGER) is
		-- set key 'key_num' label to 'msg', according to 'mode'
		-- mode : 0 = left justified, 1 = centered, 2 = right_justified
	    require
		key_num_ok: key_num >=1 and key_num <= count
		mode_ok: mode >= 0 and mode <= 2
	    local
		tools : CURSES_EXTERNAL_TOOLS
 	    do
		handle_curses_call (slk_set (key_num, tools.string_to_pointer (msg), mode), "slk_set")
	    end

	refresh is
		do
			handle_curses_call (slk_refresh, "slk_refresh")
		end

    	memory_refresh is
		-- refresh in 'curses memory', nothing happens on display
	do
	    handle_curses_call (slk_noutrefresh, "slk_outrefresh")
	end

    clear is
		-- clear soft label keys from the screen
		-- until the next 'restore'
	do
		handle_curses_call (slk_clear, "slk_clear")
	end

    restore is
		-- restore soft label keys after a 'clear'
	do
		handle_curses_call (slk_restore, "slk_restore")
	end

    set_attributes (attrs : INTEGER) is
		-- set current applicable attributes to 'attrs'
	do
		handle_curses_call (slk_attrset (attrs), "slk_attrset")
	ensure
		attributes_set: current_attributes = attrs
	end

    enable_attributes (attrs : INTEGER) is
		-- enable attributes 'attrs' leaving others unchanged
	do
		handle_curses_call (slk_attron (attrs), "slk_attron")
	end

    disable_attributes (attrs : INTEGER) is
		-- disable attributes 'attrs' leaving others unchanged
	do
		handle_curses_call (slk_attroff (attrs), "slk_attroff")
	end

end -- class CURSES_SOFT_LABEL_KEYS
-----------------------------------------------------------
-- Copyright (C) 1999 Paul G. Crismer, Eric Fafchamps
-- Licensed under Eiffel Forum Freeware License, version 1
-- (see forum.txt)
-----------------------------------------------------------


