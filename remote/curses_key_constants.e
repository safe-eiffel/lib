indexing

    description: "Key code constants"
    cluster: 	"ecurses, spec, remote_access"
    interface: 	"mixin"
    status: 	"See notice at end of class"
    date: 	"$Date$"
    revision: 	"$Revision$"
    author: 	"Paul G. Crismer, Eric Fafchamps"

class CURSES_KEY_CONSTANTS

inherit
	
	RCURSES_KEY_CONSTANTS_IDS
		export
			{NONE} all
		end

	RCURSES_CLIENT_API
		export
			{NONE} all
		end

feature  

    Key_min: INTEGER is 
		do
			remote_curses.send_request (Id_Key_min, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Key_MAX : INTEGER is 
	    -- Maximum key value 
		do
			remote_curses.send_request (Id_Key_MAX, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Key_break: INTEGER is 
		do
			remote_curses.send_request (Id_Key_break, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Key_down: INTEGER is
		do
			remote_curses.send_request (Id_Key_down, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Key_up: INTEGER is
		do
			remote_curses.send_request (Id_Key_up, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Key_left: INTEGER is
		do
			remote_curses.send_request (Id_Key_left, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Key_right: INTEGER is
		do
			remote_curses.send_request (Id_Key_right, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Key_home: INTEGER is
		do
			remote_curses.send_request (Id_Key_home, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Key_backspace: INTEGER is
		do
			remote_curses.send_request (Id_Key_backspace, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Key_f0: INTEGER is
		do
			remote_curses.send_request (Id_Key_f0, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    key_f (n: INTEGER): INTEGER is 
	    -- code for function key F`n'
		do
			remote_curses.send_request (Id_key_f, <<n>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Key_DL : INTEGER is 
	    -- Delete line
		do
			remote_curses.send_request (Id_Key_DL, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

     Key_IL  : INTEGER is 
	    -- Insert line 
		do
			remote_curses.send_request (Id_Key_IL, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Key_DC : INTEGER is 
	    -- Delete character 
		do
			remote_curses.send_request (Id_Key_DC, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Key_IC  : INTEGER is 
	    -- Insert char or enter insert mode 
		do
			remote_curses.send_request (Id_Key_IC, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Key_EIC : INTEGER is 
	    -- Exit insert char mode 
		do
			remote_curses.send_request (Id_Key_EIC, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Key_CLEAR : INTEGER is 
	    -- Clear screen 
		do
			remote_curses.send_request (Id_Key_CLEAR, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Key_EOS : INTEGER is 
	    -- Clear to end of screen 
		do
			remote_curses.send_request (Id_Key_EOS, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Key_EOL : INTEGER is 
	    -- Clear to end of line 
		do
			remote_curses.send_request (Id_Key_EOL, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Key_SF : INTEGER is 
	    -- Scroll 1 line forward 
		do
			remote_curses.send_request (Id_Key_SF, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Key_SR : INTEGER is 
	    -- Scroll 1 line backward (reverse) 
		do
			remote_curses.send_request (Id_Key_SR, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Key_NPAGE : INTEGER is 
	    -- Next page 
		do
			remote_curses.send_request (Id_Key_NPAGE, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Key_PPAGE : INTEGER is 
	    -- Previous page 
		do
			remote_curses.send_request (Id_Key_PPAGE, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Key_STAB : INTEGER is 
	    -- Set tab 
		do
			remote_curses.send_request (Id_Key_STAB, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Key_CTAB : INTEGER is 
	    -- Clear tab 
		do
			remote_curses.send_request (Id_Key_CTAB, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Key_CATAB : INTEGER is 
	    -- Clear all tabs 
		do
			remote_curses.send_request (Id_Key_CATAB, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Key_PRINT : INTEGER is 
	    -- Print 
		do
			remote_curses.send_request (Id_Key_PRINT, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Key_LL  : INTEGER is 
	    -- Home down or bottom (lower left) 
		do
			remote_curses.send_request (Id_Key_LL, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

-- The keypad is arranged like this: 
-- a1    up    a3   
-- left   b2  right  
-- c1   down   c3   

    Key_A1 : INTEGER is 
	    -- Upper left of keypad 
		do
			remote_curses.send_request (Id_Key_A1, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Key_A3 : INTEGER is 
	    -- Upper right of keypad 
		do
			remote_curses.send_request (Id_Key_A3, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Key_B2 : INTEGER is 
	    -- Center of keypad 
		do
			remote_curses.send_request (Id_Key_B2, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Key_C1 : INTEGER is 
	    -- Lower left of keypad 
		do
			remote_curses.send_request (Id_Key_C1, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

     Key_C3 : INTEGER is 
	    -- Lower right of keypad 
		do
			remote_curses.send_request (Id_Key_C3, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Key_BTAB : INTEGER is 
	    -- Back tab 
		do
			remote_curses.send_request (Id_Key_BTAB, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Key_BEG : INTEGER is 
	    -- Beg (beginning) 
		do
			remote_curses.send_request (Id_Key_BEG, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Key_CANCEL : INTEGER is 
	    -- Cancel 
		do
			remote_curses.send_request (Id_Key_CANCEL, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Key_CLOSE : INTEGER is 
	    -- Close 
		do
			remote_curses.send_request (Id_Key_CLOSE, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Key_COMMAND : INTEGER is 
	    -- Cmd (command) 
		do
			remote_curses.send_request (Id_Key_COMMAND, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Key_COPY : INTEGER is 
	    -- Copy 
		do
			remote_curses.send_request (Id_Key_COPY, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Key_CREATE : INTEGER is 
	    -- Create 
		do
			remote_curses.send_request (Id_Key_CREATE, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Key_END : INTEGER is 
	    -- End 
		do
			remote_curses.send_request (Id_Key_END, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

     Key_EXIT : INTEGER is 
	    -- Exit 
		do
			remote_curses.send_request (Id_Key_EXIT, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Key_FIND : INTEGER is 
	    -- Find 
		do
			remote_curses.send_request (Id_Key_FIND, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Key_HELP : INTEGER is 
	    -- Help 
		do
			remote_curses.send_request (Id_Key_HELP, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Key_MARK : INTEGER is 
	    -- Mark 
		do
			remote_curses.send_request (Id_Key_MARK, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Key_MESSAGE : INTEGER is 
	    -- Message 
		do
			remote_curses.send_request (Id_Key_MESSAGE, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Key_MOVE : INTEGER is 
	    -- Move 
		do
			remote_curses.send_request (Id_Key_MOVE, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Key_NEXT : INTEGER is 
	    -- Next 
		do
			remote_curses.send_request (Id_Key_NEXT, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Key_OPEN : INTEGER is 
	    -- Open 
		do
			remote_curses.send_request (Id_Key_OPEN, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Key_OPTIONS : INTEGER is 
	    -- Options 
		do
			remote_curses.send_request (Id_Key_OPTIONS, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Key_PREVIOUS : INTEGER is 
	    -- Prev (previous) 
		do
			remote_curses.send_request (Id_Key_PREVIOUS, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Key_REDO : INTEGER is 
	    -- Redo 
		do
			remote_curses.send_request (Id_Key_REDO, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Key_REFERENCE : INTEGER is 
	    -- Ref (reference) 
		do
			remote_curses.send_request (Id_Key_REFERENCE, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Key_REFRESH : INTEGER is 
	    -- Refresh 
		do
			remote_curses.send_request (Id_Key_REFRESH, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Key_REPLACE : INTEGER is 
	    -- Replace 
		do
			remote_curses.send_request (Id_Key_REPLACE, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Key_RESTART : INTEGER is 
	    -- Restart 
		do
			remote_curses.send_request (Id_Key_RESTART, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Key_RESUME : INTEGER is 
	    -- Resume 
		do
			remote_curses.send_request (Id_Key_RESUME, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Key_SAVE : INTEGER is 
	    -- Save 
		do
			remote_curses.send_request (Id_Key_SAVE, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Key_SBEG : INTEGER is 
	    -- Shifted Beg (beginning) 
		do
			remote_curses.send_request (Id_Key_SBEG, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Key_SCANCEL : INTEGER is 
	    -- Shifted Cancel 
		do
			remote_curses.send_request (Id_Key_SCANCEL, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Key_SCOMMAND : INTEGER is 
	    -- Shifted Command 
		do
			remote_curses.send_request (Id_Key_SCOMMAND, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Key_SCOPY : INTEGER is 
	    -- Shifted Copy 
		do
			remote_curses.send_request (Id_Key_SCOPY, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Key_SCREATE : INTEGER is 
	    -- Shifted Create 
		do
			remote_curses.send_request (Id_Key_SCREATE, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Key_SDC : INTEGER is 
	    -- Shifted Delete char 
		do
			remote_curses.send_request (Id_Key_SDC, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Key_SDL : INTEGER is 
	    -- Shifted Delete line 
		do
			remote_curses.send_request (Id_Key_SDL, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Key_SELECT : INTEGER is 
	    -- Select 
		do
			remote_curses.send_request (Id_Key_SELECT, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Key_SEND : INTEGER is 
	    -- Shifted End 
		do
			remote_curses.send_request (Id_Key_SEND, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Key_SEOL : INTEGER is 
	    -- Shifted Clear line 
		do
			remote_curses.send_request (Id_Key_SEOL, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Key_SEXIT : INTEGER is 
	    -- Shifted Dxit 
		do
			remote_curses.send_request (Id_Key_SEXIT, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Key_SFIND : INTEGER is 
	    -- Shifted Find 
		do
			remote_curses.send_request (Id_Key_SFIND, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Key_SHELP : INTEGER is 
	    -- Shifted Help 
		do
			remote_curses.send_request (Id_Key_SHELP, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Key_SHOME : INTEGER is 
	    -- Shifted Home 
		do
			remote_curses.send_request (Id_Key_SHOME, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Key_SIC : INTEGER is 
	    -- Shifted Input 
		do
			remote_curses.send_request (Id_Key_SIC, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Key_SLEFT : INTEGER is 
	    -- Shifted Left arrow 
		do
			remote_curses.send_request (Id_Key_SLEFT, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Key_SMESSAGE : INTEGER is 
	    -- Shifted Message 
		do
			remote_curses.send_request (Id_Key_SMESSAGE, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Key_SMOVE : INTEGER is 
	    -- Shifted Move 
		do
			remote_curses.send_request (Id_Key_SMOVE, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Key_SNEXT : INTEGER is 
	    -- Shifted Next 
		do
			remote_curses.send_request (Id_Key_SNEXT, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Key_SOPTIONS : INTEGER is 
	    -- Shifted Options 
		do
			remote_curses.send_request (Id_Key_SOPTIONS, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Key_SPREVIOUS : INTEGER is 
	    -- Shifted Prev 
		do
			remote_curses.send_request (Id_Key_SPREVIOUS, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Key_SPRINT : INTEGER is 
	    -- Shifted Print 
		do
			remote_curses.send_request (Id_Key_SPRINT, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Key_SREDO : INTEGER is 
	    -- Shifted Redo 
		do
			remote_curses.send_request (Id_Key_SREDO, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Key_SREPLACE : INTEGER is 
	    -- Shifted Replace 
		do
			remote_curses.send_request (Id_Key_SREPLACE, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Key_SRIGHT : INTEGER is 
	    -- Shifted Right arrow 
		do
			remote_curses.send_request (Id_Key_SRIGHT, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Key_SRSUME : INTEGER is 
	    -- Shifted Resume 
		do
			remote_curses.send_request (Id_Key_SRSUME, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Key_SSAVE : INTEGER is 
	    -- Shifted Save 
		do
			remote_curses.send_request (Id_Key_SSAVE, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

     Key_SSUSPEND : INTEGER is 
	    -- Shifted Suspend 
		do
			remote_curses.send_request (Id_Key_SSUSPEND, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

     Key_SUNDO : INTEGER is 
	    -- Shifted Undo 
		do
			remote_curses.send_request (Id_Key_SUNDO, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

     Key_SUSPEND : INTEGER is 
	    -- Suspend 
		do
			remote_curses.send_request (Id_Key_SUSPEND, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

     Key_UNDO : INTEGER is 
	    -- Undo 
		do
			remote_curses.send_request (Id_Key_UNDO, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

end  -- class CURSES_KEY_CONSTANTS

-----------------------------------------------------------
-- Copyright (C) 2001 Paul G. Crismer, Eric Fafchamps
-- Licensed under Eiffel Forum Freeware License, version 1
-- (see forum.txt)
-----------------------------------------------------------


