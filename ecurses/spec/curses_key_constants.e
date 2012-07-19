indexing

    description: "Key code constants"
    cluster: 	"ecurses, spec"
    interface: 	"mixin"
    status: 	"See notice at end of class"
    date: 	"$Date$"
    revision: 	"$Revision$"
    author: 	"Paul G. Crismer, Eric Fafchamps"

class CURSES_KEY_CONSTANTS

feature  

    Key_min: INTEGER is 
	do 
		Result := c_curses_key_min 
	end

    Key_MAX : INTEGER is 
	    -- Maximum key value 
  	do
		Result := c_curses_key_max
	end 

    Key_break: INTEGER is 
	do 
		Result := c_curses_key_break 
	end

    Key_down: INTEGER is
	do 
		Result := c_curses_key_down 
	end

    Key_up: INTEGER is
	do 
		Result := c_curses_key_up 
	end

    Key_left: INTEGER is
	do 
		Result := c_curses_key_left 
	end

    Key_right: INTEGER is
	do 
		Result := c_curses_key_right 
	end

    Key_home: INTEGER is
	do 
		Result := c_curses_key_home 
	end

    Key_backspace: INTEGER is
	do 
		Result := c_curses_key_backspace 
	end

    Key_f0: INTEGER is
	do 
		Result := c_curses_key_f0 
	end

    key_f (n: INTEGER): INTEGER is 
	    -- code for function key F`n'
	do 
		Result := c_curses_key_fn(n)
	end

    Key_DL : INTEGER is 
	    -- Delete line
	do 
		Result := c_curses_key_dl
	end

     Key_IL  : INTEGER is 
	    -- Insert line 
 	do
		Result := c_curses_key_il
	end 

    Key_DC : INTEGER is 
	    -- Delete character 
  	do
		Result := c_curses_key_dc
	end 

    Key_IC  : INTEGER is 
	    -- Insert char or enter insert mode 
   	do
		Result := c_curses_key_ic
	end 

    Key_EIC : INTEGER is 
	    -- Exit insert char mode 
   	do
		Result := c_curses_key_eic
	end

    Key_CLEAR : INTEGER is 
	    -- Clear screen 
   	do
		Result := c_curses_key_clear
	end 

    Key_EOS : INTEGER is 
	    -- Clear to end of screen 
   	do
		Result := c_curses_key_eos
	end 

    Key_EOL : INTEGER is 
	    -- Clear to end of line 
   	do
		Result := c_curses_key_eol
	end 

    Key_SF : INTEGER is 
	    -- Scroll 1 line forward 
   	do
		Result := c_curses_key_sf
	end 

    Key_SR : INTEGER is 
	    -- Scroll 1 line backward (reverse) 
   	do
		Result := c_curses_key_sr
	end 

    Key_NPAGE : INTEGER is 
	    -- Next page 
   	do
		Result := c_curses_key_npage
	end 

    Key_PPAGE : INTEGER is 
	    -- Previous page 
   	do
		Result := c_curses_key_ppage
	end 

    Key_STAB : INTEGER is 
	    -- Set tab 
   	do
		Result := c_curses_key_stab
	end 

    Key_CTAB : INTEGER is 
	    -- Clear tab 
   	do
		Result := c_curses_key_ctab
	end 

    Key_CATAB : INTEGER is 
	    -- Clear all tabs 
   	do
		Result := c_curses_key_catab
	end 

    Key_PRINT : INTEGER is 
	    -- Print 
   	do
		Result := c_curses_key_print
	end 

    Key_LL  : INTEGER is 
	    -- Home down or bottom (lower left) 
   	do
		Result := c_curses_key_ll
	end 

-- The keypad is arranged like this: 
-- a1    up    a3   
-- left   b2  right  
-- c1   down   c3   

    Key_A1 : INTEGER is 
	    -- Upper left of keypad 
   	do
		Result := c_curses_key_a1
	end 

    Key_A3 : INTEGER is 
	    -- Upper right of keypad 
   	do
		Result := c_curses_key_a3
	end 

    Key_B2 : INTEGER is 
	    -- Center of keypad 
   	do
		Result := c_curses_key_b2
	end 

    Key_C1 : INTEGER is 
	    -- Lower left of keypad 
  	do
		Result := c_curses_key_c1
	end 

     Key_C3 : INTEGER is 
	    -- Lower right of keypad 
   	do
		Result := c_curses_key_c3
	end 

    Key_BTAB : INTEGER is 
	    -- Back tab 
   	do
		Result := c_curses_key_btab
	end 

    Key_BEG : INTEGER is 
	    -- Beg (beginning) 
   	do
		Result := c_curses_key_beg
	end 

    Key_CANCEL : INTEGER is 
	    -- Cancel 
   	do
		Result := c_curses_key_cancel
	end 

    Key_CLOSE : INTEGER is 
	    -- Close 
   	do
		Result := c_curses_key_close
	end 

    Key_COMMAND : INTEGER is 
	    -- Cmd (command) 
   	do
		Result := c_curses_key_command
	end 

    Key_COPY : INTEGER is 
	    -- Copy 
   	do
		Result := c_curses_key_copy
	end 

    Key_CREATE : INTEGER is 
	    -- Create 
   	do
		Result := c_curses_key_create
	end 

    Key_END : INTEGER is 
	    -- End 
  	do
		Result := c_curses_key_end
	end 

     Key_EXIT : INTEGER is 
	    -- Exit 
   	do
		Result := c_curses_key_exit
	end 

    Key_FIND : INTEGER is 
	    -- Find 
   	do
		Result := c_curses_key_find
	end 

    Key_HELP : INTEGER is 
	    -- Help 
   	do
		Result := c_curses_key_help
	end 

    Key_MARK : INTEGER is 
	    -- Mark 
   	do
		Result := c_curses_key_mark
	end 

    Key_MESSAGE : INTEGER is 
	    -- Message 
   	do
		Result := c_curses_key_message
	end 

    Key_MOVE : INTEGER is 
	    -- Move 
   	do
		Result := c_curses_key_move
	end 

    Key_NEXT : INTEGER is 
	    -- Next 
   	do
		Result := c_curses_key_next
	end 

    Key_OPEN : INTEGER is 
	    -- Open 
   	do
		Result := c_curses_key_open
	end 

    Key_OPTIONS : INTEGER is 
	    -- Options 
   	do
		Result := c_curses_key_options
	end 

    Key_PREVIOUS : INTEGER is 
	    -- Prev (previous) 
   	do
		Result := c_curses_key_previous
	end 

    Key_REDO : INTEGER is 
	    -- Redo 
   	do
		Result := c_curses_key_redo
	end 

    Key_REFERENCE : INTEGER is 
	    -- Ref (reference) 
   	do
		Result := c_curses_key_reference
	end 

    Key_REFRESH : INTEGER is 
	    -- Refresh 
   	do
		Result := c_curses_key_refresh
	end 

    Key_REPLACE : INTEGER is 
	    -- Replace 
   	do
		Result := c_curses_key_replace
	end 

    Key_RESTART : INTEGER is 
	    -- Restart 
   	do
		Result := c_curses_key_restart
	end 

    Key_RESUME : INTEGER is 
	    -- Resume 
   	do
		Result := c_curses_key_resume
	end 

    Key_SAVE : INTEGER is 
	    -- Save 
   	do
		Result := c_curses_key_save
	end 

    Key_SBEG : INTEGER is 
	    -- Shifted Beg (beginning) 
   	do
		Result := c_curses_key_sbeg
	end 

    Key_SCANCEL : INTEGER is 
	    -- Shifted Cancel 
   	do
		Result := c_curses_key_scancel
	end 

    Key_SCOMMAND : INTEGER is 
	    -- Shifted Command 
   	do
		Result := c_curses_key_scommand
	end 

    Key_SCOPY : INTEGER is 
	    -- Shifted Copy 
   	do
		Result := c_curses_key_scopy
	end 

    Key_SCREATE : INTEGER is 
	    -- Shifted Create 
   	do
		Result := c_curses_key_screate
	end 

    Key_SDC : INTEGER is 
	    -- Shifted Delete char 
   	do
		Result := c_curses_key_sdc
	end 

    Key_SDL : INTEGER is 
	    -- Shifted Delete line 
   	do
		Result := c_curses_key_sdl
	end 

    Key_SELECT : INTEGER is 
	    -- Select 
   	do
		Result := c_curses_key_select
	end 

    Key_SEND : INTEGER is 
	    -- Shifted End 
   	do
		Result := c_curses_key_send
	end 

    Key_SEOL : INTEGER is 
	    -- Shifted Clear line 
   	do
		Result := c_curses_key_seol
	end 

    Key_SEXIT : INTEGER is 
	    -- Shifted Dxit 
   	do
		Result := c_curses_key_sexit
	end 

    Key_SFIND : INTEGER is 
	    -- Shifted Find 
   	do
		Result := c_curses_key_sfind
	end 

    Key_SHELP : INTEGER is 
	    -- Shifted Help 
   	do
		Result := c_curses_key_shelp
	end 

    Key_SHOME : INTEGER is 
	    -- Shifted Home 
   	do
		Result := c_curses_key_shome
	end 

    Key_SIC : INTEGER is 
	    -- Shifted Input 
   	do
		Result := c_curses_key_sic
	end 

    Key_SLEFT : INTEGER is 
	    -- Shifted Left arrow 
   	do
		Result := c_curses_key_sleft
	end 

    Key_SMESSAGE : INTEGER is 
	    -- Shifted Message 
   	do
		Result := c_curses_key_smessage
	end 

    Key_SMOVE : INTEGER is 
	    -- Shifted Move 
   	do
		Result := c_curses_key_smove
	end 

    Key_SNEXT : INTEGER is 
	    -- Shifted Next 
   	do
		Result := c_curses_key_snext
	end 

    Key_SOPTIONS : INTEGER is 
	    -- Shifted Options 
   	do
		Result := c_curses_key_soptions
	end 

    Key_SPREVIOUS : INTEGER is 
	    -- Shifted Prev 
   	do
		Result := c_curses_key_sprevious
	end 

    Key_SPRINT : INTEGER is 
	    -- Shifted Print 
   	do
		Result := c_curses_key_sprint
	end 

    Key_SREDO : INTEGER is 
	    -- Shifted Redo 
   	do
		Result := c_curses_key_sredo
	end 

    Key_SREPLACE : INTEGER is 
	    -- Shifted Replace 
   	do
		Result := c_curses_key_sreplace
	end 

    Key_SRIGHT : INTEGER is 
	    -- Shifted Right arrow 
   	do
		Result := c_curses_key_sright
	end 

    Key_SRSUME : INTEGER is 
	    -- Shifted Resume 
   	do
		Result := c_curses_key_srsume
	end 

    Key_SSAVE : INTEGER is 
	    -- Shifted Save 
  	do
		Result := c_curses_key_ssave
	end 

     Key_SSUSPEND : INTEGER is 
	    -- Shifted Suspend 
  	do
		Result := c_curses_key_ssuspend
	end 

     Key_SUNDO : INTEGER is 
	    -- Shifted Undo 
  	do
		Result := c_curses_key_sundo
	end 

     Key_SUSPEND : INTEGER is 
	    -- Suspend 
  	do
		Result := c_curses_key_suspend
	end 

     Key_UNDO : INTEGER is 
	    -- Undo 
  	do
		Result := c_curses_key_undo
	end 

    

feature {NONE}  -- C interface

    c_curses_key_min	:	INTEGER is external "C" end
    c_curses_key_max	:	INTEGER is external "C" end
    c_curses_key_break	:	INTEGER is external "C" end
    c_curses_key_down	:	INTEGER is external "C" end
    c_curses_key_up	:	INTEGER is external "C" end
    c_curses_key_left	:	INTEGER is external "C" end
    c_curses_key_right	:	INTEGER is external "C" end
    c_curses_key_home	:	INTEGER is external "C" end
    c_curses_key_backspace	:	INTEGER is external "C" end
    c_curses_key_f0	:	INTEGER is external "C" end
	
    c_curses_key_fn (n	:	INTEGER) : INTEGER is external "C" end

    c_curses_key_dl	:	INTEGER is external "C" end
    c_curses_key_il	:	INTEGER is external "C" end
    c_curses_key_dc	:	INTEGER is external "C" end
    c_curses_key_ic	:	INTEGER is external "C" end
    c_curses_key_eic	:	INTEGER is external "C" end
    c_curses_key_clear	:	INTEGER is external "C" end
    c_curses_key_eos	:	INTEGER is external "C" end
    c_curses_key_eol	:	INTEGER is external "C" end
    c_curses_key_sf	:	INTEGER is external "C" end
    c_curses_key_sr	:	INTEGER is external "C" end 
    c_curses_key_npage	:	INTEGER is external "C" end
    c_curses_key_ppage	:	INTEGER is external "C" end
    c_curses_key_stab	:	INTEGER is external "C" end
    c_curses_key_ctab	:	INTEGER is external "C" end
    c_curses_key_catab	:	INTEGER is external "C" end
    c_curses_key_print	:	INTEGER is external "C" end
    c_curses_key_ll	:	INTEGER is external "C" end

-- The keypad is arranged like this: 
-- a1    up    a3   
-- left   b2  right  
-- c1   down   c3   

    c_curses_key_a1	:	INTEGER is external "C" end
    c_curses_key_a3	:	INTEGER is external "C" end
    c_curses_key_b2	:	INTEGER is external "C" end
    c_curses_key_c1	:	INTEGER is external "C" end
    c_curses_key_c3	:	INTEGER is external "C" end
    c_curses_key_btab	:	INTEGER is external "C" end
    c_curses_key_beg	:	INTEGER is external "C" end
    c_curses_key_cancel	:	INTEGER is external "C" end
    c_curses_key_close	:	INTEGER is external "C" end
    c_curses_key_command	:	INTEGER is external "C" end
    c_curses_key_copy	:	INTEGER is external "C" end
    c_curses_key_create	:	INTEGER is external "C" end
    c_curses_key_end	:	INTEGER is external "C" end
    c_curses_key_exit	:	INTEGER is external "C" end
    c_curses_key_find	:	INTEGER is external "C" end
    c_curses_key_help	:	INTEGER is external "C" end
    c_curses_key_mark	:	INTEGER is external "C" end
    c_curses_key_message	:	INTEGER is external "C" end
    c_curses_key_move	:	INTEGER is external "C" end
    c_curses_key_next	:	INTEGER is external "C" end
    c_curses_key_open	:	INTEGER is external "C" end
    c_curses_key_options	:	INTEGER is external "C" end
    c_curses_key_previous	:	INTEGER is external "C" end
    c_curses_key_redo	:	INTEGER is external "C" end
    c_curses_key_reference	:	INTEGER is external "C" end
    c_curses_key_refresh	:	INTEGER is external "C" end
    c_curses_key_replace	:	INTEGER is external "C" end
    c_curses_key_restart	:	INTEGER is external "C" end
    c_curses_key_resume	:	INTEGER is external "C" end
    c_curses_key_save	:	INTEGER is external "C" end
    c_curses_key_sbeg	:	INTEGER is external "C" end
    c_curses_key_scancel	:	INTEGER is external "C" end
    c_curses_key_scommand	:	INTEGER is external "C" end
    c_curses_key_scopy	:	INTEGER is external "C" end
    c_curses_key_screate	:	INTEGER is external "C" end
    c_curses_key_sdc	:	INTEGER is external "C" end
    c_curses_key_sdl	:	INTEGER is external "C" end
    c_curses_key_select	:	INTEGER is external "C" end
    c_curses_key_send	:	INTEGER is external "C" end
    c_curses_key_seol	:	INTEGER is external "C" end
    c_curses_key_sexit	:	INTEGER is external "C" end
    c_curses_key_sfind	:	INTEGER is external "C" end
    c_curses_key_shelp	:	INTEGER is external "C" end
    c_curses_key_shome	:	INTEGER is external "C" end
    c_curses_key_sic	:	INTEGER is external "C" end
    c_curses_key_sleft	:	INTEGER is external "C" end
    c_curses_key_smessage	:	INTEGER is external "C" end
    c_curses_key_smove	:	INTEGER is external "C" end
    c_curses_key_snext	:	INTEGER is external "C" end
    c_curses_key_soptions	:	INTEGER is external "C" end
    c_curses_key_sprevious	:	INTEGER is external "C" end
    c_curses_key_sprint	:	INTEGER is external "C" end
    c_curses_key_sredo	:	INTEGER is external "C" end
    c_curses_key_sreplace	:	INTEGER is external "C" end
    c_curses_key_sright	:	INTEGER is external "C" end
    c_curses_key_srsume	:	INTEGER is external "C" end
    c_curses_key_ssave	:	INTEGER is external "C" end
    c_curses_key_ssuspend	:	INTEGER is external "C" end
    c_curses_key_sundo	:	INTEGER is external "C" end
    c_curses_key_suspend	:	INTEGER is external "C" end
    c_curses_key_undo	:	INTEGER is external "C" end

end  -- class CURSES_KEY_CONSTANTS
-----------------------------------------------------------
-- Copyright (C) 1999-2009 Paul G. Crismer, Eric Fafchamps
-- Licensed under Eiffel Forum Freeware License, version 2
-- (see forum.txt)
-----------------------------------------------------------


