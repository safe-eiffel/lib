indexing

    description: "Curses color constants."
    cluster: 	"ecurses, spec"
    interface: 	"mixin"
    status: 	"See notice at end of class"
    date: 	"$Date$"
    revision: 	"$Revision$"
    author: 	"Paul G. Crismer, Eric Fafchamps"

class CURSES_COLOR_CONSTANTS

inherit
	
	RCURSES_COLOR_CONSTANTS_IDS
		export
			{NONE} all
		end
	
	RCURSES_CLIENT_API
		export
			{NONE} all
		end

	ANY

feature  -- Colors

    Color_black: INTEGER is 
		do
			remote_curses.send_request (Id_Color_black, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Color_red: INTEGER is 
		do
			remote_curses.send_request (Id_Color_red, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end
		
    Color_green: INTEGER is 
		do
			remote_curses.send_request (Id_Color_green, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Color_yellow: INTEGER is 
		do
			remote_curses.send_request (Id_Color_yellow, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Color_blue: INTEGER is 
		do
			remote_curses.send_request (Id_Color_blue, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Color_magenta: INTEGER is 
		do
			remote_curses.send_request (Id_Color_magenta, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end


    Color_cyan: INTEGER is 
		do
			remote_curses.send_request (Id_Color_cyan, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Color_white: INTEGER is 
		do
			remote_curses.send_request (Id_Color_white, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end


end  -- class CURSES_COLOR_CONSTANTS

-----------------------------------------------------------
-- Copyright (C) 2001 Paul G. Crismer, Eric Fafchamps
-- Licensed under Eiffel Forum Freeware License, version 1
-- (see forum.txt)
-----------------------------------------------------------


