indexing
	description: "Support routines for tests";
	date: "$Date$";
	revision: "$Revision$"

class 
	CURSES_TEST_SUPPORT

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
		do
			Result:= c.lower.code - ('a').code + 1
		end

	shellout (window: CURSES_WINDOW; message: BOOLEAN) is
			-- Start shell with or without message
		require
			window_exist: window /= Void
		local
			exec_env: EXECUTION_ENVIRONMENT
		do
			if message then
				window.put_string ("Shelling out...")
			end
			window.curses.save_terminal_state
			window.curses.escape_to_shell
			!!exec_env
			exec_env.system ("sh")
			window.curses.resume_from_shell
			window.curses.restore_terminal_state
			if message then
				window.put_string ("returned from shellout.%N")
			end

			window.refresh
		end

end -- class CURSES_TEST_SUPPORT
-----------------------------------------------------------
-- Copyright (C) 1999 Paul G. Crismer, Eric Fafchamps
-- Licensed under Eiffel Forum Freeware License, version 1
-- (see forum.txt)
-----------------------------------------------------------

