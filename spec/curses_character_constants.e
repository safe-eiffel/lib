indexing

    description: "Curses character constants."
    cluster: 	"ecurses, spec"
    interface: 	"mixin"
    status: 	"See notice at end of class"
    date: 	"$Date$"
    revision: 	"$Revision$"
    author: 	"Paul G. Crismer, Eric Fafchamps"

class CURSES_CHARACTER_CONSTANTS

feature

    Character_ulcorner: INTEGER is
		-- upper left corner character
	do 
		Result := c_curses_acs_ulcorner 
	end

    Character_llcorner: INTEGER is
		-- lower left corner character
	do 
		Result := c_curses_acs_llcorner 
	end

    Character_urcorner: INTEGER is
		-- upper right corner character
	do 
		Result := c_curses_acs_urcorner 
	end

    Character_lrcorner: INTEGER is
		-- lower right corner character
	do 
		Result := c_curses_acs_lrcorner 
	end

    Character_ltee: INTEGER is
		-- left T  character
	do 
		Result := c_curses_acs_ltee 
	end

    Character_rtee: INTEGER is
		-- right T  character
	do 
		Result := c_curses_acs_rtee 
	end

    Character_btee: INTEGER is
		-- bottom T  character
	do 
		Result := c_curses_acs_btee 
	end

    Character_ttee: INTEGER is
		-- top T  character
	do 
		Result := c_curses_acs_ttee 
	end

    Character_hline: INTEGER is
		-- horizontal line character
	do 
		Result := c_curses_acs_hline 
	end

    Character_vline: INTEGER is
		-- vertical line  character
	do 
		Result := c_curses_acs_vline 
	end

    Character_plus: INTEGER is
		-- plus  character
	do 
		Result := c_curses_acs_plus 
	end

    Character_s1: INTEGER is
		-- s1  character
	do 
		Result := c_curses_acs_s1 
	end

    Character_s9: INTEGER is
		-- s9  character
	do 
		Result := c_curses_acs_s9 
	end

    Character_diamond: INTEGER is
		-- diamond character
	do 
		Result := c_curses_acs_diamond 
	end

    Character_ckboard: INTEGER is
		-- checkboard character
	do 
		Result := c_curses_acs_ckboard 
	end

    Character_degree: INTEGER is
		-- degree character
	do 
		Result := c_curses_acs_degree 
	end

    Character_plminus: INTEGER is
		-- plus/minus  character
	do 
		Result := c_curses_acs_plminus 
	end

    Character_bullet: INTEGER is
		-- bullet  character
	do 
		Result := c_curses_acs_bullet
	end

    Character_larrow: INTEGER is
		-- left arrow  character
	do 
		Result := c_curses_acs_larrow 
	end

    Character_rarrow: INTEGER is
		-- right arrow  character
	do 
		Result := c_curses_acs_rarrow 
	end

    Character_darrow: INTEGER is
		-- down arrow  character
	do 
		Result := c_curses_acs_darrow 
	end

    Character_uarrow: INTEGER is
		-- up arrow  character
	do 
		Result := c_curses_acs_uarrow 
	end

    Character_board: INTEGER is
		-- borad character
	do 
		Result := c_curses_acs_board 
	end

    Character_lantern: INTEGER is
		-- lantern  character
	do 
		Result := c_curses_acs_lantern 
	end

    Character_block: INTEGER is
		-- block character
	do 
		Result := c_curses_acs_block 
	end


feature {NONE}  -- C interface

    c_curses_acs_ulcorner	:	INTEGER is external "C" end
    c_curses_acs_llcorner	:	INTEGER is external "C" end
    c_curses_acs_urcorner	:	INTEGER is external "C" end
    c_curses_acs_lrcorner	:	INTEGER is external "C" end
    c_curses_acs_ltee		:	INTEGER is external "C" end
    c_curses_acs_rtee		:	INTEGER is external "C" end
    c_curses_acs_btee		:	INTEGER is external "C" end
    c_curses_acs_ttee		:	INTEGER is external "C" end
    c_curses_acs_hline		:	INTEGER is external "C" end
    c_curses_acs_vline		:	INTEGER is external "C" end
    c_curses_acs_plus		:	INTEGER is external "C" end
    c_curses_acs_s1			:	INTEGER is external "C" end
    c_curses_acs_s9			:	INTEGER is external "C" end
    c_curses_acs_diamond	:	INTEGER is external "C" end
    c_curses_acs_ckboard	:	INTEGER is external "C" end
    c_curses_acs_degree		:	INTEGER is external "C" end
    c_curses_acs_plminus	:	INTEGER is external "C" end
    c_curses_acs_bullet		:	INTEGER is external "C" end
    c_curses_acs_larrow		:	INTEGER is external "C" end
    c_curses_acs_rarrow		:	INTEGER is external "C" end
    c_curses_acs_darrow		:	INTEGER is external "C" end
    c_curses_acs_uarrow		:	INTEGER is external "C" end
    c_curses_acs_board		:	INTEGER is external "C" end
    c_curses_acs_lantern	:	INTEGER is external "C" end
    c_curses_acs_block		:	INTEGER is external "C" end

end  -- class CURSES_CHARACTER_CONSTANTS
-----------------------------------------------------------
-- Copyright (C) 1999 Paul G. Crismer, Eric Fafchamps
-- Licensed under Eiffel Forum Freeware License, version 1
-- (see forum.txt)
-----------------------------------------------------------


