indexing
	description: "Interface to curses system-wide primitives";
	cluster:        "ecurses, base"
    	interface: 	"client, shared"
    	status: 	"See notice at end of class"
    	date: 		"$Date$"
    	revision: 	"$Revision$"
    	author: 	"Paul G. Crismer, Eric Fafchamps"
class 
	CURSES_SYSTEM

inherit

	CURSES_WINDOW_API
		export {NONE} all
		end

	CURSES_SYSTEM_API
		export {NONE} all
		end

	CURSES_COLOR_CONSTANTS
		export {NONE} all
		end

	CURSES_ERROR_HANDLING

feature -- Status

    maximum_height : INTEGER is
	    -- maxium number of lines of the terminal
	do
		Result := api_lines
	end

    maximum_width : INTEGER is
	do
		Result := api_columns
	end

    tabulation_size : INTEGER is
	do
		Result := api_tab_size
	end

    maximum_colors : INTEGER is
	    -- maximum color number
	do	
		Result := api_colors
	end -- color_count


    maximum_color_pairs : INTEGER is
	    -- maximum color pair count
	do
		Result := api_color_pairs - 1
	end

    is_color_used : BOOLEAN


    has_colors : BOOLEAN is
		-- can this terminal display color ?
	do
		Result := api_has_colors
	end

feature -- Status setting


    enable_character_reading_mode is
	    -- reading mode : one character at a time
	do
	    handle_curses_call (cbreak, "cbreak")
	end
		
    enable_line_reading_mode is
	    -- reading mode : one line at a time
	do
	    handle_curses_call(nocbreak, "nocbreak")
	end
		
    enable_echo is
	    -- Echo characters as they are typed
	do
	    handle_curses_call(echo,"echo");
	end
		
   disable_echo is
    	    -- Do not echo characters
	do
	    handle_curses_call(noecho, "noecho")
	end
	    
--| FIXME : not available in PDCurses
--    enable_flush_all_on_interrupt is
--	do
--	    qiflush
--	end;
    
--| FIXME : not available in PDCurses
--    disable_flush_all_on_interrupt is
--	do
--	    noqiflush
--	end;
    
    enable_raw_reading_mode is
	    -- raw reading mode
	do
	    handle_curses_call(raw, "raw")
	end
	    
    disable_raw_reading_mode is
	    -- no raw input mode
	do
		handle_curses_call(noraw, "noraw")
	end


    enable_flush_input_on_interrupt is
	    -- Enable flushing of input characters on receipt of an
	    -- interrupt signal.
	do
	    handle_curses_call (intrflush(default_pointer, True),"intrflush")
	end

    disable_flush_input_on_interrupt is
	    -- Disable flushing of input characters on receipt of an
	    -- interrupt  signal.
	do
	    handle_curses_call (intrflush(default_pointer, False),"intrflush")
	end


     enable_cr_nl_translation is
		-- Translates the return key into newline on input
		-- Translates the newline into return and linefeed on output
		-- RETURN key is not detected on input
	do
		handle_curses_call (nl, "nl")
	end

    disable_cr_nl_translation is
		-- RETURN key is detected on input : no translation occurs
		-- Make better use of the line-feed capability
		-- faster cursor motion
	do
		handle_curses_call (nonl, "nonl")
	end

    use_colors is
		-- use colors ...
	require
	    has_colors: has_colors
	do
	    if not is_color_used then
		handle_curses_call(start_color, "start_color")
		is_color_used := True
		define_default_color_pairs
	    end
	ensure
	    is_color_used
	end

    define_default_color_pairs is
		-- define default color pairs
		-- called by use_color
		-- may be redefined
	require
		has_colors: has_colors
		color_used: is_color_used		
	do
		-- blue background
		define_color_pair (1, Color_yellow , Color_blue )
		define_color_pair (2, Color_red,     Color_blue)
		define_color_pair (3, Color_cyan ,   Color_blue )		
		define_color_pair (4, Color_black ,   Color_blue )

		-- cyan background
		define_color_pair (5, Color_black , Color_cyan )

		-- yellow background
		define_color_pair (6, Color_blue , Color_yellow )

		-- green background
		define_color_pair (7, Color_black , Color_green )
		define_color_pair (8, Color_white, Color_green)

		-- red background
		define_color_pair (9, Color_white, Color_red)

		-- magenta background
		define_color_pair (10, Color_white, Color_magenta)
		define_color_pair (11, Color_black, Color_magenta)

		-- white background
		define_color_pair (12, Color_black, Color_white)		
	end

    define_color_pair ( pair_nr, fore_col, back_col : INTEGER) is
	require
		color_used: is_color_used
		pair_number_ok: pair_nr > 0 and pair_nr <= maximum_color_pairs
		fore_color_ok: fore_col >= 0 and fore_col <= maximum_colors
		back_color_ok: back_col >= 0 and back_col <= maximum_colors
	do
	      handle_curses_call(init_pair(pair_nr, fore_col, back_col), "init_pair")
	end


	escape_to_shell
	    is
		-- escape from 'curses' mode
	    do
		handle_curses_call (def_prog_mode, "def_prog_mode")
		handle_curses_call(endwin,"endwin");			
	    end

	resume_from_shell is
		-- resume with 'curses'
	    do
		handle_curses_call (reset_prog_mode, "reset_prog_mode")
		handle_curses_call(doupdate, "doupdate");		
	    end	

	save_terminal_state is
		-- save terminal state
	    do
		handle_curses_call (savetty, "savetty")
	    end

	restore_terminal_state is
		-- restore terminal state
	    do
		handle_curses_call (resetty, "resetty")
	    end

	set_cursor_visibility (visibility : INTEGER) is
		-- set cursor state to
		-- invisible (0), normal (1), very visible (2)
	    require
		good_visibility: visibility >= 0 and visibility <= 2
	    do
		handle_curses_call (curs_set (visibility), "curs_set")
	    ensure
		last_error_value: True -- last_error /= curses_error_value 
			      -- implies last_error = old cursor visibility
	    end

	sleep (ms : INTEGER) is
		-- sleep for 'ms' milliseconds
	    require
		ms_positive: ms >= 0
	    do
		handle_curses_call (napms (ms), "napms");
	    end

	printable_representation (c : INTEGER) : STRING is
		-- printable representation of any character
		-- control characters are represented as ^X
		-- other characters are represented as is
	    local
		ptr : POINTER
		tools: CURSES_EXTERNAL_TOOLS
	    do
		create Result.make (2)
		ptr := unctrl (c)
		if ptr /= default_pointer then
			Result := tools.pointer_to_string (ptr)
		else
			last_error := curses_error_value
		end	
	    end

	key_name (key_code : INTEGER) : STRING is
		-- returns the name of the key corresponding to 'key_code'
	    local
		ptr : POINTER
		tools: CURSES_EXTERNAL_TOOLS
	    do
		create Result.make (5)
		ptr := keyname (key_code)
		if ptr /= default_pointer then
			Result := tools.pointer_to_string (ptr)
		else
			last_error := curses_error_value
		end
  	    end
 
end -- class CURSES_SYSTEM
-----------------------------------------------------------
-- Copyright (C) 1999 Paul G. Crismer, Eric Fafchamps
-- Licensed under Eiffel Forum Freeware License, version 1
-- (see forum.txt)
-----------------------------------------------------------


