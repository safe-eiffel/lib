indexing
	description: "[
			Objects that stores curses function names 
			and provide access to them by the integer code
			]"
    status: 	"See notice at do end of class"
    date: 	"$Date$"
    revision: 	"$Revision$"
    author: 	"Paul G. Crismer, Eric Fafchamps"

class
	RCURSES_DICTIONNARY

inherit
		
	RCURSES_ATTRIBUTE_CONSTANTS_IDS
		export
			{NONE} all
		end
		
	RCURSES_CHARACTER_CONSTANTS_IDS
		export
			{NONE} all
		end
		
	RCURSES_COLOR_CONSTANTS_IDS
		export
			{NONE} all
		end
		
	RCURSES_ERROR_API_IDS
		export
			{NONE} all
		end
		
	RCURSES_KEY_CONSTANTS_IDS
		export
			{NONE} all
		end
		
	RCURSES_PAD_API_IDS
		export
			{NONE} all
		end
		
	RCURSES_PANEL_API_IDS
		export
			{NONE} all
		end
		
	RCURSES_SLK_API_IDS
		export
			{NONE} all
		end
		
	RCURSES_SYSTEM_API_IDS
		export
			{NONE} all
		end
	
	RCURSES_WINDOW_API_IDS
		export
			{NONE} all
		end
		
	ANY	
		
	
feature {NONE} -- Initialization


feature -- Access


	found: BOOLEAN is
			-- Does the last search found a name?
		do
			Result := table.found
		end
	
	found_item: STRING is
			-- The last found item.
		do
			Result := table.found_item
		end
	
feature -- Basic operations

	search (a_feature_identifier: INTEGER) is
			-- Search name for `a_feature_identifier'.
		do
			table.search (a_feature_identifier)
		end
		
feature {NONE} -- Implementation

	table: DS_HASH_TABLE [STRING,INTEGER] is
			-- Table of names indexed by feature identifiers.
		once
			!!Result.make (300)
			Result.force ("endwin", Id_endwin)

			Result.force ("initscr", Id_initscr)
 
			Result.force ("cbreak", Id_cbreak)
 			
			Result.force ("echo", Id_echo)

			Result.force ("halfdelay", Id_halfdelay)

			Result.force ("nocbreak", Id_nocbreak)

			Result.force ("noecho", Id_noecho)

			Result.force ("noraw", Id_noraw)

			Result.force ("raw", Id_raw)

			Result.force ("nl", Id_nl)
 
			Result.force ("nonl", Id_nonl)
 
			Result.force ("erasechar", Id_erasechar)

			Result.force ("killchar", Id_killchar)
 
			Result.force ("typeahead", Id_typeahead)

			Result.force ("flushinp", Id_flushinp)
 
			Result.force ("intrflush", Id_intrflush)
 
			Result.force ("keypad", Id_keypad)

			Result.force ("meta", Id_meta)
 					
			Result.force ("nodelay", Id_nodelay)

			Result.force ("notimeout", Id_notimeout)
 
			Result.force ("wtimeout", Id_wtimeout)

			Result.force ("api_beep", Id_api_beep)
 
			Result.force ("api_flash", Id_api_flash)
 
			Result.force ("clearok", Id_clearok)
			
			Result.force ("idlok", Id_idlok)
			
			Result.force ("idcok", Id_idcok)
			
			Result.force ("leaveok", Id_leaveok)
 
			Result.force ("immedok", Id_immedok)
 
			Result.force ("wsetscrreg", Id_wsetscrreg)
 
			Result.force ("api_lines", Id_api_lines)
 
			Result.force ("api_columns", Id_api_columns)
 
			Result.force ("api_tab_size", Id_api_tab_size)

			Result.force ("api_colors", Id_api_colors)

			Result.force ("api_color_pairs", Id_api_color_pairs)

			Result.force ("api_stdscr", Id_api_stdscr)
 
			Result.force ("api_has_colors", Id_api_has_colors)
 
			Result.force ("start_color", Id_start_color)
 
			Result.force ("color_pair", Id_color_pair)

			Result.force ("init_pair", Id_init_pair)
 
			Result.force ("pair_number", Id_pair_number)
 
			Result.force ("pair_content", Id_pair_content)
 
			Result.force ("newwin", Id_newwin)
 
			Result.force ("delwin", Id_delwin)
			
			Result.force ("mvwin", Id_mvwin)
 
			Result.force ("subwin", Id_subwin)

			Result.force ("derwin", Id_derwin)
 
			Result.force ("mvderwin", Id_mvderwin)
 
			Result.force ("dupwin", Id_dupwin)
 
			Result.force ("wsyncup", Id_wsyncup)

			Result.force ("wcursyncup", Id_wcursyncup)
 
			Result.force ("wsyncdown", Id_wsyncdown)
 
			Result.force ("syncok", Id_syncok)
 
			Result.force ("waddch", Id_waddch)

			Result.force ("wechochar", Id_wechochar)
 
			Result.force ("mvwaddch", Id_mvwaddch)
 
			Result.force ("winsch", Id_winsch)
 
			Result.force ("wdelch", Id_wdelch)
 
			Result.force ("mvwdelch", Id_mvwdelch)
 
			Result.force ("wgetch", Id_wgetch)

			Result.force ("mvwgetch", Id_mvwgetch)

			Result.force ("winch", Id_winch)
 
			Result.force ("wgetstr", Id_wgetstr)

			Result.force ("wgetnstr", Id_wgetnstr)
 
			Result.force ("winchstr", Id_winchstr)
 
			Result.force ("winchnstr", Id_winchnstr)
 
			Result.force ("winstr", Id_winstr)
 
			Result.force ("winnstr", Id_winnstr)
 
			Result.force ("waddstr", Id_waddstr)

			Result.force ("waddnstr", Id_waddnstr)
 
			Result.force ("waddchstr", Id_waddchstr)
 
			Result.force ("waddchnstr", Id_waddchnstr)
 
			Result.force ("winsstr", Id_winsstr)
			
			Result.force ("winsnstr", Id_winsnstr)
 
			Result.force ("wattroff", Id_wattroff)

			Result.force ("wattron", Id_wattron)
 
			Result.force ("wattrset", Id_wattrset)

			Result.force ("wbkgdset", Id_wbkgdset)

			Result.force ("wbkgd", Id_wbkgd)
 
			Result.force ("wchgat", Id_wchgat)
 
			Result.force ("getattrs", Id_getattrs)
 
			Result.force ("getbkgd", Id_getbkgd)
 
			Result.force ("wborder", Id_wborder)
 
			Result.force ("whline", Id_whline)
 
			Result.force ("wvline", Id_wvline)
 
			Result.force ("box", Id_box)
 
			Result.force ("wrefresh", Id_wrefresh)
 
			Result.force ("wnoutrefresh", Id_wnoutrefresh)

			Result.force ("doupdate", Id_doupdate)
 
			Result.force ("redrawwin", Id_redrawwin)

			Result.force ("wredrawln", Id_wredrawln)
 
			Result.force ("wtouchln", Id_wtouchln)
 
			Result.force ("touchwin", Id_touchwin)

			Result.force ("is_wintouched", Id_is_wintouched)
 
			Result.force ("is_linetouched", Id_is_linetouched)

			Result.force ("werase", Id_werase)

			Result.force ("wclear", Id_wclear)

			Result.force ("wclrtobot", Id_wclrtobot)

			Result.force ("wclrtoeol", Id_wclrtoeol)

			Result.force ("wdeleteln", Id_wdeleteln)
 
			Result.force ("winsdelln", Id_winsdelln)

			Result.force ("winsertln", Id_winsertln)

			Result.force ("wmove", Id_wmove)

			Result.force ("scrollok", Id_scrollok)

			Result.force ("wscrl", Id_wscrl)
 
			Result.force ("overlay", Id_overlay)

			Result.force ("overwrite", Id_overwrite)
 
			Result.force ("copywin", Id_copywin)

			Result.force ("getmaxx", Id_getmaxx)
 
			Result.force ("getmaxy", Id_getmaxy)
 
			Result.force ("getbegx", Id_getbegx)
 
			Result.force ("getbegy", Id_getbegy)
 
			Result.force ("c_cursor_x", Id_c_cursor_x)
 
			Result.force ("c_cursor_y", Id_c_cursor_y)

			Result.force ("panel_window", Id_panel_window)
 
			Result.force ("update_panels", Id_update_panels)
 				
			Result.force ("hide_panel", Id_hide_panel)

			Result.force ("show_panel", Id_show_panel)

			Result.force ("del_panel", Id_del_panel)

			Result.force ("top_panel", Id_top_panel)

			Result.force ("bottom_panel", Id_bottom_panel)

			Result.force ("new_panel", Id_new_panel)
 
			Result.force ("panel_above", Id_panel_above)

			Result.force ("panel_below", Id_panel_below)

			Result.force ("set_panel_userptr", Id_set_panel_userptr)
 
			Result.force ("panel_userptr", Id_panel_userptr)
 
			Result.force ("move_panel", Id_move_panel)
 
			Result.force ("replace_panel", Id_replace_panel)
 
			Result.force ("panel_hidden", Id_panel_hidden)

			Result.force ("newpad", Id_newpad)
 
			Result.force ("prefresh", Id_prefresh)
 
			Result.force ("pnoutrefresh", Id_pnoutrefresh)
 
			Result.force ("subpad", Id_subpad)
 
			Result.force ("pechochar", Id_pechochar)

			Result.force ("def_prog_mode", Id_def_prog_mode)
 
			Result.force ("def_shell_mode", Id_def_shell_mode)
 
			Result.force ("reset_prog_mode", Id_reset_prog_mode)
 
			Result.force ("reset_shell_mode", Id_reset_shell_mode)

			Result.force ("resetty", Id_resetty)

			Result.force ("savetty", Id_savetty)

			Result.force ("getsyx)", Id_getsyx)
 
			Result.force ("setsyx", Id_setsyx)

			Result.force ("curs_set", Id_curs_set)

			Result.force ("napms", Id_napms)
 
			Result.force ("unctrl", Id_unctrl)

			Result.force ("keyname", Id_keyname)

			Result.force ("slk_init", Id_slk_init)
 
			Result.force ("slk_set", Id_slk_set)
 
			Result.force ("slk_refresh", Id_slk_refresh)

			Result.force ("slk_noutrefresh", Id_slk_noutrefresh)
 
			Result.force ("slk_label", Id_slk_label)

			Result.force ("slk_clear", Id_slk_clear)

			Result.force ("slk_restore", Id_slk_restore)

			Result.force ("slk_touch", Id_slk_touch)

			Result.force ("slk_attron", Id_slk_attron)

			Result.force ("slk_attrset", Id_slk_attrset)

			Result.force ("slk_attr", Id_slk_attr)

			Result.force ("slk_attroff", Id_slk_attroff)

			Result.force ("attribute_attributes", Id_attribute_attributes)

			Result.force ("attribute_normal", Id_attribute_normal)
 
			Result.force ("attribute_standout", Id_attribute_standout)

			Result.force ("attribute_underline", Id_attribute_underline)

			Result.force ("attribute_reverse", Id_attribute_reverse)

			Result.force ("attribute_blink", Id_attribute_blink)

			Result.force ("attribute_dim", Id_attribute_dim)

			Result.force ("attribute_bold", Id_attribute_bold)

			Result.force ("attribute_altcharset", Id_attribute_altcharset)

			Result.force ("attribute_invisible)", Id_attribute_invisible)

			Result.force ("attribute_protected", Id_attribute_protected)

			Result.force ("attribute_color", Id_attribute_color)

			Result.force ("Character_ulcorner", Id_Character_ulcorner)

			Result.force ("Character_llcorner", Id_Character_llcorner)
 
			Result.force ("Character_urcorner", Id_Character_urcorner)
 
			Result.force ("Character_lrcorner", Id_Character_lrcorner)
 
			Result.force ("Character_ltee", Id_Character_ltee)
 
			Result.force ("Character_rtee", Id_Character_rtee)
 
			Result.force ("Character_btee", Id_Character_btee)
 
			Result.force ("Character_ttee", Id_Character_ttee)
 
			Result.force ("Character_hline", Id_Character_hline)
 
			Result.force ("Character_vline", Id_Character_vline)
 
			Result.force ("Character_plus", Id_Character_plus)
 
			Result.force ("Character_s1", Id_Character_s1)
 
			Result.force ("Character_s9", Id_Character_s9)
 
			Result.force ("Character_diamond", Id_Character_diamond)
 
			Result.force ("Character_ckboard", Id_Character_ckboard)
 
			Result.force ("Character_degree", Id_Character_degree)
 
			Result.force ("Character_plminus", Id_Character_plminus)
 
			Result.force ("Character_bullet", Id_Character_bullet)
 
			Result.force ("Character_larrow", Id_Character_larrow)
 
			Result.force ("Character_rarrow", Id_Character_rarrow)
 
			Result.force ("Character_darrow", Id_Character_darrow)
 
			Result.force ("Character_uarrow", Id_Character_uarrow)
 
			Result.force ("Character_board", Id_Character_board)
 
			Result.force ("Character_lantern", Id_Character_lantern)
 
			Result.force ("Character_block", Id_Character_block)
 
 			Result.force ("Color_black", Id_Color_black)
 
			Result.force ("Color_red", Id_Color_red)
 
			Result.force ("Color_green", Id_Color_green)
 
			Result.force ("Color_yellow", Id_Color_yellow)
 
			Result.force ("Color_blue", Id_Color_blue)
 
			Result.force ("Color_magenta", Id_Color_magenta)
 
			Result.force ("Color_cyan", Id_Color_cyan)
 
			Result.force ("Color_white", Id_Color_white)
 
			Result.force ("c_ecurses_err", Id_c_ecurses_err)
 
			Result.force ("c_ecurses_ok", Id_c_ecurses_ok)
 	
			Result.force ("Key_min", Id_Key_min)

			Result.force ("Key_MAX", Id_Key_MAX)
 
			Result.force ("Key_break", Id_Key_break)

			Result.force ("Key_down", Id_Key_down)

			Result.force ("Key_up", Id_Key_up)

			Result.force ("Key_left", Id_Key_left)

			Result.force ("Key_right", Id_Key_right)

			Result.force ("Key_home", Id_Key_home)

			Result.force ("Key_backspace", Id_Key_backspace)

			Result.force ("Key_f0", Id_Key_f0)

			Result.force ("key_f", Id_key_f)

			Result.force ("Key_DL", Id_Key_DL)

			Result.force ("Key_IL", Id_Key_IL )

			Result.force ("Key_DC", Id_Key_DC)

			Result.force ("Key_IC", Id_Key_IC )

			Result.force ("Key_EIC", Id_Key_EIC)

			Result.force ("Key_CLEAR", Id_Key_CLEAR)

			Result.force ("Key_EOS", Id_Key_EOS)

			Result.force ("Key_EOL", Id_Key_EOL)

			Result.force ("Key_SF", Id_Key_SF)

			Result.force ("Key_SR", Id_Key_SR)

			Result.force ("Key_NPAGE", Id_Key_NPAGE)

			Result.force ("Key_PPAGE", Id_Key_PPAGE)

			Result.force ("Key_STAB", Id_Key_STAB)

			Result.force ("Key_CTAB", Id_Key_CTAB)

			Result.force ("Key_CATAB", Id_Key_CATAB)

			Result.force ("Key_PRINT", Id_Key_PRINT)

			Result.force ("Key_LL", Id_Key_LL )

			Result.force ("Key_A1", Id_Key_A1)

			Result.force ("Key_A3", Id_Key_A3)

			Result.force ("Key_B2", Id_Key_B2)

			Result.force ("Key_C1", Id_Key_C1)

			Result.force ("Key_C3", Id_Key_C3)

			Result.force ("Key_BTAB", Id_Key_BTAB)

			Result.force ("Key_BEG", Id_Key_BEG)

			Result.force ("Key_CANCEL", Id_Key_CANCEL)

			Result.force ("Key_CLOSE", Id_Key_CLOSE)

			Result.force ("Key_COMMAND", Id_Key_COMMAND)

			Result.force ("Key_COPY)", Id_Key_COPY)

			Result.force ("Key_CREATE", Id_Key_CREATE)

			Result.force ("Key_END", Id_Key_END)

			Result.force ("Key_EXIT", Id_Key_EXIT)

			Result.force ("Key_FIND", Id_Key_FIND)

			Result.force ("Key_HELP", Id_Key_HELP)

			Result.force ("Key_MARK", Id_Key_MARK)

			Result.force ("Key_MESSAGE", Id_Key_MESSAGE)

			Result.force ("Key_MOVE", Id_Key_MOVE)

			Result.force ("Key_NEXT", Id_Key_NEXT)

			Result.force ("Key_OPEN", Id_Key_OPEN)

			Result.force ("Key_OPTIONS", Id_Key_OPTIONS)

			Result.force ("Key_PREVIOUS", Id_Key_PREVIOUS)

			Result.force ("Key_REDO", Id_Key_REDO)

			Result.force ("Key_REFERENCE", Id_Key_REFERENCE)

			Result.force ("Key_REFRESH", Id_Key_REFRESH)

			Result.force ("Key_REPLACE", Id_Key_REPLACE)

			Result.force ("Key_RESTART", Id_Key_RESTART)

			Result.force ("Key_RESUME", Id_Key_RESUME)

			Result.force ("Key_SAVE", Id_Key_SAVE)

			Result.force ("Key_SBEG", Id_Key_SBEG)

			Result.force ("Key_SCANCEL", Id_Key_SCANCEL)

			Result.force ("Key_SCOMMAND", Id_Key_SCOMMAND)

			Result.force ("Key_SCOPY", Id_Key_SCOPY)

			Result.force ("Key_SCREATE", Id_Key_SCREATE)

			Result.force ("Key_SDC", Id_Key_SDC)

			Result.force ("Key_SDL", Id_Key_SDL)

			Result.force ("Key_SELECT", Id_Key_SELECT)

			Result.force ("Key_SEND", Id_Key_SEND)

			Result.force ("Key_SEOL", Id_Key_SEOL)

			Result.force ("Key_SEXIT", Id_Key_SEXIT)

			Result.force ("Key_SFIND", Id_Key_SFIND)

			Result.force ("Key_SHELP", Id_Key_SHELP)

			Result.force ("Key_SHOME", Id_Key_SHOME)

			Result.force ("Key_SIC", Id_Key_SIC)

			Result.force ("Key_SLEFT", Id_Key_SLEFT)

			Result.force ("Key_SMESSAGE", Id_Key_SMESSAGE)

			Result.force ("Key_SMOVE", Id_Key_SMOVE)

			Result.force ("Key_SNEXT", Id_Key_SNEXT)

			Result.force ("Key_SOPTIONS", Id_Key_SOPTIONS)

			Result.force ("Key_SPREVIOUS", Id_Key_SPREVIOUS)

			Result.force ("Key_SPRINT", Id_Key_SPRINT)

			Result.force ("Key_SREDO", Id_Key_SREDO)

			Result.force ("Key_SREPLACE", Id_Key_SREPLACE)

			Result.force ("Key_SRIGHT", Id_Key_SRIGHT)

			Result.force ("Key_SRSUME", Id_Key_SRSUME)

			Result.force ("Key_SSAVE", Id_Key_SSAVE)

			Result.force ("Key_SSUSPEND", Id_Key_SSUSPEND)

			Result.force ("Key_SUNDO", Id_Key_SUNDO)

			Result.force ("Key_SUSPEND", Id_Key_SUSPEND)

			Result.force ("Key_UNDO", Id_Key_UNDO)

		end
			
end -- class RCURSES_ADAPTER

-----------------------------------------------------------
-- Copyright (C) 2001 Paul G. Crismer, Eric Fafchamps
-- Licensed under Eiffel Forum Freeware License, version 1
-- (see forum.txt)
-----------------------------------------------------------
