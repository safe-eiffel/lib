indexing

    description: "Curses attribute constants."
    cluster: 	"ecurses, spec";
    interface: 	"mixin"
    status: 	"See notice at end of class";
    date: 	"$Date$";
    revision: 	"$Revision$";
    author: 	"Paul G. Crismer, Eric Fafchamps"

class CURSES_ATTRIBUTE_CONSTANTS

feature

    Attribute_attributes: INTEGER is 
	do
  		Result := c_curses_a_attributes
	end

    Attribute_normal: INTEGER is 
	do
 		Result := c_curses_a_normal 
	end

    Attribute_standout: INTEGER is 
	do
 		Result := c_curses_a_standout 
	end

    Attribute_underline: INTEGER is 
	do
 		Result := c_curses_a_underline 
	end

    Attribute_reverse: INTEGER is 
	do
 		Result := c_curses_a_reverse 
	end

    Attribute_blink: INTEGER is 
	do
 		Result := c_curses_a_blink 
	end

    Attribute_dim: INTEGER is 
	do
 		Result := c_curses_a_dim 
	end

    Attribute_bold: INTEGER is 
	do
 		Result := c_curses_a_bold 
	end

    Attribute_altcharset: INTEGER is 
	do
 		Result := c_curses_a_altcharset 
	end

    Attribute_invisible: INTEGER is 
	do
 		Result := c_curses_a_invis 
	end

    Attribute_protected: INTEGER is 
	do
 		Result := c_curses_a_protect
	end


    Attribute_color: INTEGER is 
	do
 		Result := c_curses_a_color
	end    

feature {NONE}  -- C interface

    c_curses_a_attributes	:	INTEGER is external "C" end
    c_curses_a_normal		:	INTEGER is external "C" end
    c_curses_a_standout		:	INTEGER is external "C" end
    c_curses_a_underline	:	INTEGER is external "C" end
    c_curses_a_reverse		:	INTEGER is external "C" end
    c_curses_a_blink		:	INTEGER is external "C" end
    c_curses_a_dim			:	INTEGER is external "C" end
    c_curses_a_bold			:	INTEGER is external "C" end
    c_curses_a_altcharset	:	INTEGER is external "C" end
    c_curses_a_invis		:	INTEGER is external "C" end
    c_curses_a_protect		:	INTEGER is external "C" end
    c_curses_a_color		:	INTEGER is external "C" end


end  -- class CURSES_ATTRIBUTE_CONSTANTS
-----------------------------------------------------------
-- Copyright (C) 1999 Paul G. Crismer, Eric Fafchamps
-- Licensed under Eiffel Forum Freeware License, version 1
-- (see forum.txt)
-----------------------------------------------------------


