indexing

    description: "Curses character constants."
    cluster: 	"ecurses, spec"
    interface: 	"mixin"
    status: 	"See notice at end of class"
    date: 	"$Date$"
    revision: 	"$Revision$"
    author: 	"Paul G. Crismer, Eric Fafchamps"

class CURSES_CHARACTER_CONSTANTS

inherit
	
	RCURSES_CHARACTER_CONSTANTS_IDS
		export
			{NONE} all
		end

	RCURSES_CLIENT_API
		export
			{NONE} all
		end

feature

    Character_ulcorner: INTEGER is
		-- upper left corner character
		do
			remote_curses.send_request (Id_Character_ulcorner, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Character_llcorner: INTEGER is
		-- lower left corner character
		do
			remote_curses.send_request (Id_Character_llcorner, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Character_urcorner: INTEGER is
		-- upper right corner character
		do
			remote_curses.send_request (Id_Character_urcorner, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Character_lrcorner: INTEGER is
		-- lower right corner character
		do
			remote_curses.send_request (Id_Character_lrcorner, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Character_ltee: INTEGER is
		-- left T  character
		do
			remote_curses.send_request (Id_Character_ltee, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Character_rtee: INTEGER is
		-- right T  character
		do
			remote_curses.send_request (Id_Character_rtee, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Character_btee: INTEGER is
		-- bottom T  character
		do
			remote_curses.send_request (Id_Character_btee, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Character_ttee: INTEGER is
		-- top T  character
		do
			remote_curses.send_request (Id_Character_ttee, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Character_hline: INTEGER is
		-- horizontal line character
		do
			remote_curses.send_request (Id_Character_hline, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Character_vline: INTEGER is
		-- vertical line  character
		do
			remote_curses.send_request (Id_Character_vline, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Character_plus: INTEGER is
		-- plus  character
		do
			remote_curses.send_request (Id_Character_plus, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Character_s1: INTEGER is
		-- s1  character
		do
			remote_curses.send_request (Id_Character_s1, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Character_s9: INTEGER is
		-- s9  character
		do
			remote_curses.send_request (Id_Character_s9, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Character_diamond: INTEGER is
		-- diamond character
		do
			remote_curses.send_request (Id_Character_diamond, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Character_ckboard: INTEGER is
		-- checkboard character
		do
			remote_curses.send_request (Id_Character_ckboard, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Character_degree: INTEGER is
		-- degree character
		do
			remote_curses.send_request (Id_Character_degree, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Character_plminus: INTEGER is
		-- plus/minus  character
		do
			remote_curses.send_request (Id_Character_plminus, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Character_bullet: INTEGER is
		-- bullet  character
		do
			remote_curses.send_request (Id_Character_bullet, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Character_larrow: INTEGER is
		-- left arrow  character
		do
			remote_curses.send_request (Id_Character_larrow, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Character_rarrow: INTEGER is
		-- right arrow  character
		do
			remote_curses.send_request (Id_Character_rarrow, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Character_darrow: INTEGER is
		-- down arrow  character
		do
			remote_curses.send_request (Id_Character_darrow, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Character_uarrow: INTEGER is
		-- up arrow  character
		do
			remote_curses.send_request (Id_Character_uarrow, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Character_board: INTEGER is
		-- borad character
		do
			remote_curses.send_request (Id_Character_board, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Character_lantern: INTEGER is
		-- lantern  character
		do
			remote_curses.send_request (Id_Character_lantern, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Character_block: INTEGER is
		-- block character
		do
			remote_curses.send_request (Id_Character_block, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end


end  -- class CURSES_CHARACTER_CONSTANTS

-----------------------------------------------------------
-- Copyright (C) 2001 Paul G. Crismer, Eric Fafchamps
-- Licensed under Eiffel Forum Freeware License, version 1
-- (see forum.txt)
-----------------------------------------------------------


