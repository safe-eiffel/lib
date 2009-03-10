indexing
	description: "Support routines for tests";
	date: "$Date$";
	revision: "$Revision$"

class 
	CURSES_TEST_SUPPORT

inherit
	KL_IMPORTED_INTEGER_ROUTINES
		export
			{NONE}
				all
		end

	UT_CHARACTER_CODES
		export
			{NONE}
				all
		end

feature -- Support routines

	pause (window: CURSES_WINDOW) is
			-- Pause message and get input to continue.
		require
			window_exists: window /= Void
		do
			window.move (window.curses.maximum_height -1, 0)
			window.put_string ("Press any key to continue ...")
			window.read_character
		end
			
	cannot (window: CURSES_WINDOW; message: STRING) is
			-- Display a message for a missing capability of this terminal.
		require
			window_exists: window /= Void
			message_exists: message /= Void
		do
			window.put_string ("%NThis terminal ")
			window.put_string (message)
			window.put_string ("%N%N")
		end

	color_name  (color: INTEGER): STRING is
			-- Which is name of `color?
		local
			c : expanded CURSES_COLOR_CONSTANTS
		do	
			if     color = c.Color_white then Result := "white" 
			elseif color = c.Color_red then Result := "red" 
			elseif color = c.Color_black then Result := "black" 
			elseif color = c.Color_green then Result := "green" 
			elseif color = c.Color_yellow then Result := "yellow" 
			elseif color = c.Color_blue then Result := "blue" 
			elseif color = c.Color_magenta then Result := "magenta" 
			elseif color = c.Color_cyan then Result := "cyan"
			end

		end	

	ctrl (c: CHARACTER): INTEGER is
			-- Value of CTRL + key
		local
			lower_c: CHARACTER
		do
			if c.code >= Upper_a_code and c.code <= Upper_z_code then
				lower_c := INTEGER_.to_character ((c.code + Case_diff) \\ 256)
			else
				lower_c := c
			end
			Result:= lower_c.code - Lower_a_code + 1
		end

	shellout (window: CURSES_WINDOW; message: BOOLEAN) is
			-- Start shell with or without message
		require
			window_exist: window /= Void
		local
			shell_tool: CURSES_TEST_SHELL_TOOL
		do
			if message then
				window.put_string ("Shelling out...")
			end
			window.curses.save_terminal_state
			window.curses.escape_to_shell
			create shell_tool
			shell_tool.system_request ("sh")
			window.curses.resume_from_shell
			window.curses.restore_terminal_state
			if message then
				window.put_string ("returned from shellout.%N")
			end

			window.refresh
		end

end -- class CURSES_TEST_SUPPORT
-----------------------------------------------------------
-- Copyright (C) 1999-2009 Paul G. Crismer, Eric Fafchamps
-- Licensed under Eiffel Forum Freeware License, version 2
-- (see forum.txt)
-----------------------------------------------------------

