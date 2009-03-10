indexing

    description: "Curses color constants."
    cluster: 	"ecurses, spec"
    interface: 	"mixin"
    status: 	"See notice at end of class"
    date: 	"$Date$"
    revision: 	"$Revision$"
    author: 	"Paul G. Crismer, Eric Fafchamps"

class CURSES_COLOR_CONSTANTS

feature  -- Colors

    Color_black: INTEGER is 
	do 
		Result := c_curses_color_black 
	end

    Color_red: INTEGER is 
	do 
		Result := c_curses_color_red 
	end

    Color_green: INTEGER is 
	do 
		Result := c_curses_color_green 
	end

    Color_yellow: INTEGER is 
	do 
		Result := c_curses_color_yellow 
	end

    Color_blue: INTEGER is 
	do 
		Result := c_curses_color_blue 
	end

    Color_magenta: INTEGER is 
	do 
		Result := c_curses_color_magenta 
	end


    Color_cyan: INTEGER is 
	do 
		Result := c_curses_color_cyan 
	end

    Color_white: INTEGER is 
	do 
		Result := c_curses_color_white 
	end


feature {NONE}  -- C interface

    c_curses_color_black	:	INTEGER is external "C" end
    c_curses_color_red		:	INTEGER is external "C" end
    c_curses_color_green	:	INTEGER is external "C" end
    c_curses_color_yellow	:	INTEGER is external "C" end
    c_curses_color_blue		:	INTEGER is external "C" end
    c_curses_color_magenta	:	INTEGER is external "C" end
    c_curses_color_cyan		:	INTEGER is external "C" end
    c_curses_color_white	:	INTEGER is external "C" end

end  -- class CURSES_COLOR_CONSTANTS
-----------------------------------------------------------
-- Copyright (C) 1999-2009 Paul G. Crismer, Eric Fafchamps
-- Licensed under Eiffel Forum Freeware License, version 2
-- (see forum.txt)
-----------------------------------------------------------


