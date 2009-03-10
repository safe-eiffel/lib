indexing
	description: "Objects that adapts ecurses client messages to the natif CURSES API"
    cluster: 	"ecurses, spec, remote_access, server"
    status: 	"See notice at do end of class"
    date: 	"$Date$"
    revision: 	"$Revision$"
    author: 	"Paul G. Crismer, Eric Fafchamps"

class
	RCURSES_ADAPTER

inherit
	
	CURSES_ATTRIBUTE_CONSTANTS
		export
			{NONE} all
		undefine
			default_rescue			
		end
	
	RCURSES_ATTRIBUTE_CONSTANTS_IDS
		export
			{NONE} all
		undefine
			default_rescue				
		end
	
	CURSES_CHARACTER_CONSTANTS
		export
			{NONE} all
		undefine
			default_rescue			
		end
	
	RCURSES_CHARACTER_CONSTANTS_IDS
		export
			{NONE} all
		undefine
			default_rescue			
		end
	
	CURSES_COLOR_CONSTANTS
		export
			{NONE} all
		undefine
			default_rescue			
		end
	
	RCURSES_COLOR_CONSTANTS_IDS
		export
			{NONE} all
		undefine
			default_rescue			
		end
	
	CURSES_ERROR_API
		export
			{NONE} all
		undefine
			default_rescue			
		end
	
	RCURSES_ERROR_API_IDS
		export
			{NONE} all
		undefine
			default_rescue			
		end
	
	CURSES_KEY_CONSTANTS
		export
			{NONE} all
		undefine
			default_rescue			
		end
	
	RCURSES_KEY_CONSTANTS_IDS
		export
			{NONE} all
		undefine
			default_rescue			
		end
	
	CURSES_PAD_API
		export
			{NONE} all
		undefine
			default_rescue			
		end
	
	RCURSES_PAD_API_IDS
		export
			{NONE} all
		undefine
			default_rescue			
		end
	
	CURSES_PANEL_API
		export
			{NONE} all
		undefine
			default_rescue			
		end
	
	RCURSES_PANEL_API_IDS
		export
			{NONE} all
		undefine
			default_rescue			
		end
	
	CURSES_SLK_API
		export
			{NONE} all
		undefine
			default_rescue			
		end
	
	RCURSES_SLK_API_IDS
		export
			{NONE} all
		undefine
			default_rescue			
		end
	
	CURSES_SYSTEM_API
		export
			{NONE} all
		undefine
			default_rescue			
		end
	
	RCURSES_SYSTEM_API_IDS
		export
			{NONE} all
		undefine
			default_rescue			
		end
	
	CURSES_WINDOW_API
		export
			{NONE} all
		undefine
			default_rescue			
		end

	RCURSES_WINDOW_API_IDS
		export
			{NONE} all
		undefine
			default_rescue			
		end
		
	UT_APPLICATION_STATUS_SINGLETON_ACCESSOR
		export
			{NONE} all
		end		

	ANY
		undefine
			default_rescue
		end

	
create
	make
	
feature {NONE} -- Initialization

	make is
			-- Initialize adapter
		do
			create pointers_table.make (1000)
			create last_results.make
			create dictionnary
		end


feature -- Access

	
	last_server_message: RCURSES_SERVER_MESSAGE is
			-- Last message of server results.
		do
			create Result.make (last_results)
		end

	pointers_table_dump: STRING is
			-- Dump of pointers_table.
		do
			create Result.make (200)
			Result.append_string ("(Key, Item) = ")
			from
				pointers_table.start
			until
				pointers_table.off
			loop
				Result.append_string ("(" + pointers_table.key_for_iteration.out + "," + pointers_table.item_for_iteration.out + ") ; ")	
				pointers_table.forth
			end
		end

		
feature -- Basic operations

	call_feature (a_client_message: RCURSES_CLIENT_MESSAGE) is
			-- Call feature for `a_client_message'.
		do	
			--| Initialize results
			last_results.wipe_out

			dispatch_call (a_client_message.feature_identifier, a_client_message.arguments)
			
		end
		
feature {NONE} -- Implementation

	dispatch_call (a_feature_identifier: INTEGER; arguments: ARRAY[STRING]) is
			-- Dispatch the feature call.
		local
			a_pointer: POINTER
			an_integer: INTEGER
			a_character: CHARACTER
			a_boolean: BOOLEAN
		do
			
			inspect a_feature_identifier
			
			--| Identifiers for CURSES_WINDOW_API

			when Id_endwin then
  				an_integer := endwin
 				last_results.force_last (an_integer)

			when Id_initscr then
				a_pointer := initscr
				pointers_table.force (a_pointer, a_pointer.out )
				last_results.force_last (a_pointer.out)
 
			when Id_cbreak then
 				an_integer := cbreak
 				last_results.force_last (an_integer)
 			
			when Id_echo then
 				an_integer := echo
 				last_results.force_last (an_integer)

			when Id_halfdelay then
 				an_integer := halfdelay (arguments.item(1).to_integer)
 				last_results.force_last (an_integer)

			when Id_nocbreak  then
  				an_integer := nocbreak
 				last_results.force_last (an_integer)

			when Id_noecho  then
  				an_integer := noecho
 				last_results.force_last (an_integer)

			when Id_noraw  then
  				an_integer := noraw
 				last_results.force_last (an_integer)

			when Id_raw  then
  				an_integer := raw
 				last_results.force_last (an_integer)

			when Id_nl then
 				an_integer := nl
 				last_results.force_last (an_integer)
 
			when Id_nonl then
 				an_integer := nonl
 				last_results.force_last (an_integer)
 
			when Id_erasechar then
 				a_character := erasechar
				last_results.force_last (a_character)

			when Id_killchar then
 				a_character := killchar
				last_results.force_last (a_character)
 
			when Id_typeahead then
  				an_integer := typeahead (arguments.item (1).to_integer)
 				last_results.force_last (an_integer)

			when Id_flushinp then
  				an_integer := flushinp
 				last_results.force_last (an_integer)
 
			when Id_intrflush then
 				an_integer := intrflush (pointers_table.item (arguments.item(1)), arguments.item(2).to_boolean)
 				last_results.force_last (an_integer)
 
			when Id_keypad then
 				an_integer := keypad (pointers_table.item (arguments.item(1)), arguments.item(2).to_boolean)
 				last_results.force_last (an_integer)

			when Id_meta then
 				an_integer := meta (pointers_table.item (arguments.item(1)), arguments.item(2).to_boolean)
 				last_results.force_last (an_integer)
 					
			when Id_nodelay then
  				an_integer := nodelay (pointers_table.item (arguments.item(1)), arguments.item(2).to_boolean)
 				last_results.force_last (an_integer)

			when Id_notimeout then
 				an_integer := notimeout (pointers_table.item (arguments.item(1)), arguments.item(2).to_boolean)
 				last_results.force_last (an_integer)
 
			when Id_wtimeout then
   				wtimeout (pointers_table.item (arguments.item(1)), arguments.item (2).to_integer)

			when Id_api_beep then
 				an_integer := api_beep
 				last_results.force_last (an_integer)
 
			when Id_api_flash then
 				an_integer := api_flash
 				last_results.force_last (an_integer)
 
			when Id_clearok then
 				an_integer := clearok (pointers_table.item (arguments.item(1)), arguments.item(2).to_boolean)
 				last_results.force_last (an_integer)
			
			when Id_idlok then
 				an_integer := idlok (pointers_table.item (arguments.item(1)), arguments.item(2).to_boolean)
 				last_results.force_last (an_integer)
			
			when Id_idcok then
 				idcok (pointers_table.item (arguments.item(1)), arguments.item(2).to_boolean)
			
			when Id_leaveok then
 				an_integer := leaveok (pointers_table.item (arguments.item(1)), arguments.item(2).to_boolean)
 				last_results.force_last (an_integer)
 
			when Id_immedok then
 				immedok (pointers_table.item (arguments.item(1)), arguments.item(2).to_boolean)
 
			when Id_wsetscrreg then
 				an_integer := wsetscrreg (pointers_table.item (arguments.item(1)), arguments.item(2).to_integer,arguments.item(3).to_integer)
 				last_results.force_last (an_integer)
 
			when Id_api_lines then
 				an_integer := api_lines
 				last_results.force_last (an_integer)
 
			when Id_api_columns then
 				an_integer := api_columns
 				last_results.force_last (an_integer)
 
			when Id_api_tab_size then
  				an_integer := api_tab_size
 				last_results.force_last (an_integer)

			when Id_api_colors then
  				an_integer := api_colors
 				last_results.force_last (an_integer)

			when Id_api_color_pairs then
  				an_integer := api_color_pairs
 				last_results.force_last (an_integer)

			when Id_api_stdscr then
 				a_pointer := api_stdscr
				pointers_table.force (a_pointer, a_pointer.out )
				last_results.force_last (a_pointer.out)
 
			when Id_api_has_colors then
  				a_boolean := api_has_colors
 				last_results.force_last (a_boolean)
 
			when Id_start_color then
  				an_integer := start_color
 				last_results.force_last (an_integer)
 
			when Id_color_pair then
   				an_integer := color_pair (arguments.item (1).to_integer)
 				last_results.force_last (an_integer)

			when Id_init_pair then
   				an_integer := init_pair (arguments.item (1).to_integer, arguments.item (2).to_integer, arguments.item (3).to_integer)
 				last_results.force_last (an_integer)
 
			when Id_pair_number then
   				an_integer := pair_number (arguments.item (1).to_integer)
 				last_results.force_last (an_integer)
 
			when Id_pair_content then
   				pair_content (arguments.item (1).to_integer, $i1, $i2)
 				last_results.force_last (i1)
 				last_results.force_last (i2)
 
			when Id_newwin then
   				a_pointer := newwin (arguments.item (1).to_integer,arguments.item (2).to_integer,arguments.item (3).to_integer,arguments.item (4).to_integer)
				pointers_table.force (a_pointer, a_pointer.out )
 				last_results.force_last (a_pointer.out)
 
			when Id_delwin then
 				an_integer := delwin (pointers_table.item (arguments.item(1)))
				last_results.force_last (an_integer)
			
			when Id_mvwin then
   				an_integer := mvwin (pointers_table.item (arguments.item(1)),arguments.item (2).to_integer,arguments.item (3).to_integer)
				last_results.force_last (an_integer)
 
			when Id_subwin then
   				a_pointer := subwin (pointers_table.item (arguments.item(1)),arguments.item (2).to_integer,arguments.item (3).to_integer,arguments.item (4).to_integer,arguments.item (5).to_integer)
				pointers_table.force (a_pointer, a_pointer.out )
 				last_results.force_last (a_pointer.out)

			when Id_derwin then
   				a_pointer := derwin (pointers_table.item (arguments.item(1)),arguments.item (2).to_integer,arguments.item (3).to_integer,arguments.item (4).to_integer,arguments.item (5).to_integer)
				pointers_table.force (a_pointer, a_pointer.out )
 				last_results.force_last (a_pointer.out)
 
			when Id_mvderwin then
   				an_integer := mvderwin (pointers_table.item (arguments.item(1)),arguments.item (2).to_integer,arguments.item (3).to_integer)
				last_results.force_last (an_integer)
 
			when Id_dupwin then
   				a_pointer := dupwin (pointers_table.item (arguments.item(1)))
				pointers_table.force (a_pointer, a_pointer.out )
 				last_results.force_last (a_pointer.out)
 
			when Id_wsyncup then
   				wsyncup (pointers_table.item (arguments.item(1)))

			when Id_wcursyncup then
   				wcursyncup (pointers_table.item (arguments.item(1)))
 
			when Id_wsyncdown then
   				wsyncdown (pointers_table.item (arguments.item(1)))
 
			when Id_syncok then
   				an_integer := syncok (pointers_table.item (arguments.item(1)),arguments.item (2).to_boolean)
				last_results.force_last (an_integer)
 
			when Id_waddch then
 				an_integer := waddch (pointers_table.item (arguments.item(1)), arguments.item(2).to_integer)
				last_results.force_last (an_integer)

			when Id_wechochar then
 				an_integer := wechochar (pointers_table.item (arguments.item(1)), arguments.item(2).to_integer)
				last_results.force_last (an_integer)
 
			when Id_mvwaddch then
 				an_integer := mvwaddch (pointers_table.item (arguments.item(1)), arguments.item(2).to_integer, arguments.item(3).to_integer, arguments.item(4).to_integer)
				last_results.force_last (an_integer)
 
			when Id_winsch then
 				an_integer := winsch (pointers_table.item (arguments.item(1)), arguments.item(2).to_integer)
				last_results.force_last (an_integer)
 
			when Id_wdelch then
 				an_integer := wdelch (pointers_table.item (arguments.item(1)))
				last_results.force_last (an_integer)
 
			when Id_mvwdelch then
 				an_integer := mvwdelch (pointers_table.item (arguments.item(1)), arguments.item(2).to_integer, arguments.item(3).to_integer)
				last_results.force_last (an_integer)
 
			when Id_wgetch then
  				an_integer := wgetch (pointers_table.item (arguments.item(1)))
 				last_results.force_last (an_integer)

			when Id_mvwgetch then
  				an_integer := mvwgetch (pointers_table.item (arguments.item(1)), arguments.item(2).to_integer, arguments.item(3).to_integer)
				last_results.force_last (an_integer)

			when Id_winch then
  				an_integer := winch (pointers_table.item (arguments.item(1)))
				last_results.force_last (an_integer)
 
			when Id_wgetstr then
  				an_integer := wgetstr (pointers_table.item (arguments.item(1)), a_pointer)
				last_results.force_last (an_integer)
				last_results.force_last (curses_external_tools.pointer_to_string (a_pointer))

			when Id_wgetnstr then
  				an_integer := wgetnstr (pointers_table.item (arguments.item(1)), a_pointer, arguments.item(2).to_integer)
				last_results.force_last (an_integer)
				last_results.force_last (curses_external_tools.pointer_to_string (a_pointer))
 
			when Id_winchstr then
  				an_integer := winchstr (pointers_table.item (arguments.item(1)), a_pointer)
				last_results.force_last (an_integer)
				last_results.force_last (curses_external_tools.pointer_to_string (a_pointer))
 
			when Id_winchnstr then
  				an_integer := winchnstr (pointers_table.item (arguments.item(1)), a_pointer, arguments.item(2).to_integer)
				last_results.force_last (an_integer)
				last_results.force_last (curses_external_tools.pointer_to_string (a_pointer))
 
			when Id_winstr then
  				an_integer := winstr (pointers_table.item (arguments.item(1)), a_pointer)
				last_results.force_last (an_integer)
				last_results.force_last (curses_external_tools.pointer_to_string (a_pointer))
 
			when Id_winnstr then
  				an_integer := winnstr (pointers_table.item (arguments.item(1)), a_pointer, arguments.item(2).to_integer)
				last_results.force_last (an_integer)
				last_results.force_last (curses_external_tools.pointer_to_string (a_pointer))
 
			when Id_waddstr then
 				an_integer := waddstr (pointers_table.item (arguments.item(1)),curses_external_tools.string_to_pointer (arguments.item(2)))
 				last_results.force_last (an_integer)

			when Id_waddnstr then
 				an_integer := waddnstr (pointers_table.item (arguments.item(1)),curses_external_tools.string_to_pointer (arguments.item(2)), arguments.item(3).to_integer)
 				last_results.force_last (an_integer)
 
			when Id_waddchstr then
 				an_integer := waddchstr (pointers_table.item (arguments.item(1)),curses_external_tools.string_to_pointer (arguments.item(2)))
 				last_results.force_last (an_integer)
 
			when Id_waddchnstr then
 				an_integer := waddchnstr (pointers_table.item (arguments.item(1)),curses_external_tools.string_to_pointer (arguments.item(2)), arguments.item(3).to_integer)
 				last_results.force_last (an_integer)
 
			when Id_winsstr then
 				an_integer := winsstr (pointers_table.item (arguments.item(1)),curses_external_tools.string_to_pointer (arguments.item(2)))
 				last_results.force_last (an_integer)
			
			when Id_winsnstr then
 				an_integer := winsnstr (pointers_table.item (arguments.item(1)),curses_external_tools.string_to_pointer (arguments.item(2)), arguments.item(3).to_integer)
 				last_results.force_last (an_integer)
 
			when Id_wattroff then
 				an_integer := wattroff (pointers_table.item (arguments.item(1)),arguments.item(2).to_integer)
 				last_results.force_last (an_integer)

			when Id_wattron then
 				an_integer := wattron (pointers_table.item (arguments.item(1)),arguments.item(2).to_integer)
 				last_results.force_last (an_integer)
 
			when Id_wattrset then
  				an_integer := wattrset (pointers_table.item (arguments.item(1)),arguments.item(2).to_integer)
 				last_results.force_last (an_integer)

			when Id_wbkgdset then
  				wbkgdset (pointers_table.item (arguments.item(1)),arguments.item(2).to_integer)

			when Id_wbkgd then
  				an_integer := wbkgd (pointers_table.item (arguments.item(1)),arguments.item(2).to_integer)
 				last_results.force_last (an_integer)
 
			when Id_wchgat then
  				an_integer := wchgat (pointers_table.item (arguments.item(1)), arguments.item(2).to_integer, arguments.item(3).to_integer, arguments.item(4).to_integer, default_pointer)
 				last_results.force_last (an_integer)
 
			when Id_getattrs then
  				an_integer := getattrs (pointers_table.item (arguments.item(1)))
 				last_results.force_last (an_integer)
 
			when Id_getbkgd then
  				an_integer := getbkgd (pointers_table.item (arguments.item(1)))
 				last_results.force_last (an_integer)
 
			when Id_wborder then
  				an_integer := wborder (pointers_table.item (arguments.item(1)), arguments.item(2).to_integer, arguments.item(3).to_integer, arguments.item(4).to_integer, arguments.item(5).to_integer, arguments.item(6).to_integer, arguments.item(7).to_integer, arguments.item(8).to_integer, arguments.item(9).to_integer)
 				last_results.force_last (an_integer)
 
			when Id_whline then
  				an_integer := whline (pointers_table.item (arguments.item(1)), arguments.item(2).to_integer, arguments.item(3).to_integer)
 				last_results.force_last (an_integer)
 
			when Id_wvline then
  				an_integer := wvline (pointers_table.item (arguments.item(1)), arguments.item(2).to_integer, arguments.item(3).to_integer)
 				last_results.force_last (an_integer)
 
			when Id_box then
  				an_integer := box (pointers_table.item (arguments.item(1)), arguments.item(2).to_integer, arguments.item(3).to_integer)
 				last_results.force_last (an_integer)
 
			when Id_wrefresh then
  				an_integer := wrefresh (pointers_table.item (arguments.item(1)))
 				last_results.force_last (an_integer)
 
			when Id_wnoutrefresh then
  				an_integer := wnoutrefresh (pointers_table.item (arguments.item(1)))
 				last_results.force_last (an_integer)

			when Id_doupdate then
  				an_integer := doupdate
 				last_results.force_last (an_integer)
 
			when Id_redrawwin then
   				an_integer := redrawwin (pointers_table.item (arguments.item(1)))
 				last_results.force_last (an_integer)

			when Id_wredrawln then
  				an_integer := wredrawln (pointers_table.item (arguments.item(1)), arguments.item(2).to_integer, arguments.item(3).to_integer)
 				last_results.force_last (an_integer)
 
			when Id_wtouchln then
  				an_integer := wtouchln (pointers_table.item (arguments.item(1)), arguments.item(2).to_integer, arguments.item(3).to_integer, arguments.item(4).to_boolean)
 				last_results.force_last (an_integer)
 
			when Id_touchwin then
   				an_integer := touchwin (pointers_table.item (arguments.item(1)))
 				last_results.force_last (an_integer)

			when Id_is_wintouched then
   				an_integer := is_wintouched (pointers_table.item (arguments.item(1)))
 				last_results.force_last (an_integer)
 
			when Id_is_linetouched then
    			an_integer := is_linetouched (pointers_table.item (arguments.item(1)), arguments.item (2).to_integer)
 				last_results.force_last (an_integer)

			when Id_werase then
   				an_integer := werase (pointers_table.item (arguments.item(1)))
 				last_results.force_last (an_integer)

			when Id_wclear then
   				an_integer := wclear (pointers_table.item (arguments.item(1)))
 				last_results.force_last (an_integer)

			when Id_wclrtobot then
				an_integer := wclrtobot (pointers_table.item (arguments.item(1)))
 				last_results.force_last (an_integer)

			when Id_wclrtoeol then
   				an_integer := wclrtoeol (pointers_table.item (arguments.item(1)))
 				last_results.force_last (an_integer)

			when Id_wdeleteln then
   				an_integer := wdeleteln (pointers_table.item (arguments.item(1)))
 				last_results.force_last (an_integer)
 
			when Id_winsdelln then
   				an_integer := winsdelln (pointers_table.item (arguments.item(1)), arguments.item(2).to_integer)
 				last_results.force_last (an_integer)

			when Id_winsertln then
   				an_integer := winsertln (pointers_table.item (arguments.item(1)))
 				last_results.force_last (an_integer)

			when Id_wmove then
 				an_integer := wmove (pointers_table.item (arguments.item(1)),arguments.item(2).to_integer, arguments.item(3).to_integer )
 				last_results.force_last (an_integer)

			when Id_scrollok then
   				an_integer := scrollok (pointers_table.item (arguments.item(1)), arguments.item(2).to_boolean)
 				last_results.force_last (an_integer)

			when Id_wscrl then
   				an_integer := wscrl (pointers_table.item (arguments.item(1)), arguments.item(2).to_integer)
 				last_results.force_last (an_integer)
 
			when Id_overlay then
   				an_integer := overlay (pointers_table.item (arguments.item(1)), pointers_table.item (arguments.item(2)))
 				last_results.force_last (an_integer)

			when Id_overwrite then
   				an_integer := overwrite (pointers_table.item (arguments.item(1)), pointers_table.item (arguments.item(2)))
 				last_results.force_last (an_integer)
 
			when Id_copywin then
   				an_integer := copywin (pointers_table.item (arguments.item(1)), pointers_table.item (arguments.item(2)), arguments.item(3).to_integer, arguments.item(4).to_integer,  arguments.item(5).to_integer, arguments.item(6).to_integer,  arguments.item(7).to_integer, arguments.item(8).to_integer,  arguments.item(9).to_integer)
 				last_results.force_last (an_integer)

			when Id_getmaxx then
 				an_integer := getmaxx (pointers_table.item (arguments.item(1)))
 				last_results.force_last (an_integer)
 
			when Id_getmaxy then
 				an_integer := getmaxy (pointers_table.item (arguments.item(1)))
 				last_results.force_last (an_integer)
 
			when Id_getbegx then
 				an_integer := getbegx (pointers_table.item (arguments.item(1)))
 				last_results.force_last (an_integer)
 
			when Id_getbegy then
 				an_integer := getbegy (pointers_table.item (arguments.item(1)))
 				last_results.force_last (an_integer)
 
			when Id_c_cursor_x then
				an_integer := c_cursor_x (pointers_table.item (arguments.item(1)))
 				last_results.force_last (an_integer)
 
			when Id_c_cursor_y then
				an_integer := c_cursor_y (pointers_table.item (arguments.item(1)))
 				last_results.force_last (an_integer)
 

			--| Identifiers for CURSES_WINDOW_PANEL_API

			when Id_panel_window then
				a_pointer := panel_window (pointers_table.item (arguments.item(1)))
				pointers_table.force (a_pointer, a_pointer.out )				
 				last_results.force_last (a_pointer.out)
 
			when Id_update_panels then
 				update_panels
 				
			when Id_hide_panel then
				an_integer := hide_panel (pointers_table.item (arguments.item(1)))
 				last_results.force_last (an_integer)

			when Id_show_panel then
 				an_integer := show_panel (pointers_table.item (arguments.item(1)))
 				last_results.force_last (an_integer)

			when Id_del_panel then
 				an_integer := del_panel (pointers_table.item (arguments.item(1)))
 				last_results.force_last (an_integer)

			when Id_top_panel then
 				an_integer := top_panel (pointers_table.item (arguments.item(1)))
 				last_results.force_last (an_integer)

			when Id_bottom_panel then
 				an_integer := bottom_panel (pointers_table.item (arguments.item(1)))
 				last_results.force_last (an_integer)

			when Id_new_panel then
				a_pointer := new_panel (pointers_table.item (arguments.item(1)))
				pointers_table.force (a_pointer, a_pointer.out )				
 				last_results.force_last (a_pointer.out)
 
			when Id_panel_above then
 				a_pointer := panel_above (pointers_table.item (arguments.item(1)))
				pointers_table.force (a_pointer, a_pointer.out )				
 				last_results.force_last (a_pointer.out)

			when Id_panel_below then
 				a_pointer := panel_below (pointers_table.item (arguments.item(1)))
				pointers_table.force (a_pointer, a_pointer.out )				
 				last_results.force_last (a_pointer.out)

			when Id_set_panel_userptr then
 				an_integer := set_panel_userptr (pointers_table.item (arguments.item(1)), pointers_table.item (arguments.item(2)))
 				last_results.force_last (an_integer)
 
			when Id_panel_userptr then
 				a_pointer := panel_userptr (pointers_table.item (arguments.item(1)))
				pointers_table.force (a_pointer, a_pointer.out )				
 				last_results.force_last (a_pointer.out)
 
			when Id_move_panel then
 				an_integer := move_panel (pointers_table.item (arguments.item(1)), arguments.item (2).to_integer, arguments.item(3).to_integer)
 				last_results.force_last (an_integer)
 
			when Id_replace_panel then
 				an_integer := replace_panel (pointers_table.item (arguments.item(1)), pointers_table.item (arguments.item(2)))
 				last_results.force_last (an_integer)
 
			when Id_panel_hidden then
  				an_integer := panel_hidden (pointers_table.item (arguments.item(1)))
 				last_results.force_last (an_integer)


			--| Identifiers for CURSES_WINDOW_PAD_API
	
			when Id_newpad then
				a_pointer := newpad (arguments.item(1).to_integer, arguments.item(2).to_integer)
				pointers_table.force (a_pointer, a_pointer.out )
				last_results.force_last (a_pointer.out)
 
			when Id_prefresh then
  				an_integer := prefresh (pointers_table.item (arguments.item(1)), arguments.item(2).to_integer, arguments.item(3).to_integer, arguments.item(4).to_integer, arguments.item(5).to_integer, arguments.item(6).to_integer, arguments.item(7).to_integer)
 				last_results.force_last (an_integer)
 
			when Id_pnoutrefresh then
  				an_integer := pnoutrefresh (pointers_table.item (arguments.item(1)), arguments.item(2).to_integer, arguments.item(3).to_integer, arguments.item(4).to_integer, arguments.item(5).to_integer, arguments.item(6).to_integer, arguments.item(7).to_integer)
 				last_results.force_last (an_integer)
 
			when Id_subpad then
				a_pointer := subpad (pointers_table.item (arguments.item(1)), arguments.item(2).to_integer, arguments.item(3).to_integer, arguments.item(4).to_integer, arguments.item(5).to_integer)
				pointers_table.force (a_pointer, a_pointer.out )
				last_results.force_last (a_pointer.out)
 
			when Id_pechochar then
  				pechochar (pointers_table.item (arguments.item(1)), arguments.item(2).to_integer)

			--|  Identifiers for CURSES_WINDOW_SYSTEM_API

			when Id_def_prog_mode then
				an_integer := def_prog_mode
				last_results.force_last (an_integer)
 
			when Id_def_shell_mode then
				an_integer := def_shell_mode
				last_results.force_last (an_integer)
 
			when Id_reset_prog_mode then
				an_integer := reset_prog_mode
				last_results.force_last (an_integer)
 
			when Id_reset_shell_mode then
 				an_integer := reset_shell_mode
				last_results.force_last (an_integer)

			when Id_resetty then
 				an_integer := resetty
				last_results.force_last (an_integer)

			when Id_savetty then
 				an_integer := savetty
				last_results.force_last (an_integer)

			when Id_getsyx then
 				getsyx ($i1, $i2)
				last_results.force_last (i1)
				last_results.force_last (i2)
 
			when Id_setsyx then
 				setsyx (arguments.item(1).to_integer, arguments.item(2).to_integer )

			when Id_curs_set then
				an_integer := curs_set (arguments.item(1).to_integer)
				last_results.force_last (an_integer)

			when Id_napms then
				an_integer := napms (arguments.item(1).to_integer)
				last_results.force_last (an_integer)
 
			when Id_unctrl then
  				a_pointer := unctrl (arguments.item(1).to_integer)
				last_results.force_last (curses_external_tools.pointer_to_string (a_pointer))

			when Id_keyname then
  				a_pointer := keyname (arguments.item(1).to_integer)
				last_results.force_last (curses_external_tools.pointer_to_string (a_pointer))

			--| Identifiers for CURSES_SLK_API

			when Id_slk_init then
 				an_integer := slk_init (arguments.item(1).to_integer)
				last_results.force_last (an_integer)
 
			when Id_slk_set then
 				an_integer := slk_set (arguments.item(1).to_integer, curses_external_tools.string_to_pointer (arguments.item(2)), arguments.item(3).to_integer)
				last_results.force_last (an_integer)
 
			when Id_slk_refresh then
  				an_integer := slk_refresh
 				last_results.force_last (an_integer)

			when Id_slk_noutrefresh then
  				an_integer := slk_noutrefresh
 				last_results.force_last (an_integer)
 
			when Id_slk_label then
  				a_pointer := slk_label (arguments.item(1).to_integer)
 				last_results.force_last (curses_external_tools.pointer_to_string (a_pointer))

			when Id_slk_clear then
   				an_integer := slk_clear
  				last_results.force_last (an_integer)

			when Id_slk_restore then
   				an_integer := slk_restore
  				last_results.force_last (an_integer)

			when Id_slk_touch then
   				an_integer := slk_touch
  				last_results.force_last (an_integer)

			when Id_slk_attron then
  				an_integer := slk_attron (arguments.item(1).to_integer)
 				last_results.force_last (an_integer)

			when Id_slk_attrset then
  				an_integer := slk_attrset (arguments.item(1).to_integer)
 				last_results.force_last (an_integer)

			when Id_slk_attr then
   				an_integer := slk_attr
  				last_results.force_last (an_integer)

			when Id_slk_attroff then
  				an_integer := slk_attroff (arguments.item(1).to_integer)
 				last_results.force_last (an_integer)

	
			--| Identifiers for CURSES_ATTRIBUTE_CONSTANTS

			when Id_attribute_attributes then
 				an_integer := attribute_attributes
				last_results.force_last (an_integer)

			when Id_attribute_normal then
 				an_integer := attribute_normal
				last_results.force_last (an_integer)
 
			when Id_attribute_standout then
  				an_integer := attribute_standout
				last_results.force_last (an_integer)

			when Id_attribute_underline then
   				an_integer := attribute_underline
				last_results.force_last (an_integer)

			when Id_attribute_reverse then
   				an_integer := attribute_reverse
				last_results.force_last (an_integer)

			when Id_attribute_blink then
   				an_integer := attribute_blink
				last_results.force_last (an_integer)

			when Id_attribute_dim then
   				an_integer := attribute_dim
				last_results.force_last (an_integer)

			when Id_attribute_bold then
   				an_integer := attribute_bold
				last_results.force_last (an_integer)

			when Id_attribute_altcharset then
   				an_integer := attribute_altcharset
				last_results.force_last (an_integer)

			when Id_attribute_invisible then
   				an_integer := attribute_invisible
				last_results.force_last (an_integer)

			when Id_attribute_protected then
   				an_integer := attribute_protected
				last_results.force_last (an_integer)

			when Id_attribute_color then
   				an_integer := attribute_color
				last_results.force_last (an_integer)


			--| Identifiers for CURSES_CHARACTER_CONSTANTS
	
			when Id_Character_ulcorner then
   				an_integer := character_ulcorner
				last_results.force_last (an_integer)

			when Id_Character_llcorner then
  				an_integer := character_llcorner
				last_results.force_last (an_integer)
 
			when Id_Character_urcorner then
  				an_integer := character_urcorner
				last_results.force_last (an_integer)
 
			when Id_Character_lrcorner then
  				an_integer := character_lrcorner
				last_results.force_last (an_integer)
 
			when Id_Character_ltee then
  				an_integer := character_ltee
				last_results.force_last (an_integer)
 
			when Id_Character_rtee then
  				an_integer := character_rtee
				last_results.force_last (an_integer)
 
			when Id_Character_btee then
  				an_integer := character_btee
				last_results.force_last (an_integer)
 
			when Id_Character_ttee then
  				an_integer := character_ttee
				last_results.force_last (an_integer)
 
			when Id_Character_hline then
  				an_integer := character_hline
				last_results.force_last (an_integer)
 
			when Id_Character_vline then
  				an_integer := character_vline
				last_results.force_last (an_integer)
 
			when Id_Character_plus then
  				an_integer := character_plus
				last_results.force_last (an_integer)
 
			when Id_Character_s1 then
  				an_integer := character_s1
				last_results.force_last (an_integer)
 
			when Id_Character_s9 then
  				an_integer := character_s9
				last_results.force_last (an_integer)
 
			when Id_Character_diamond then
  				an_integer := character_diamond
				last_results.force_last (an_integer)
 
			when Id_Character_ckboard then
  				an_integer := character_ckboard
				last_results.force_last (an_integer)
 
			when Id_Character_degree then
  				an_integer := character_degree
				last_results.force_last (an_integer)
 
			when Id_Character_plminus then
  				an_integer := character_plminus
				last_results.force_last (an_integer)
 
			when Id_Character_bullet then
  				an_integer := character_bullet
				last_results.force_last (an_integer)
 
			when Id_Character_larrow then
  				an_integer := character_larrow
				last_results.force_last (an_integer)
 
			when Id_Character_rarrow then
  				an_integer := character_rarrow
				last_results.force_last (an_integer)
 
			when Id_Character_darrow then
  				an_integer := character_darrow
				last_results.force_last (an_integer)
 
			when Id_Character_uarrow then
  				an_integer := character_uarrow
				last_results.force_last (an_integer)
 
			when Id_Character_board then
  				an_integer := character_board
				last_results.force_last (an_integer)
 
			when Id_Character_lantern then
  				an_integer := character_lantern
				last_results.force_last (an_integer)
 
			when Id_Character_block then
  				an_integer := character_block
				last_results.force_last (an_integer)
 

			--| Identifiers for CURSES_COLOR_CONSTANTS

			when Id_Color_black then
  				an_integer := color_black
				last_results.force_last (an_integer)
 
			when Id_Color_red then
   				an_integer := color_red
				last_results.force_last (an_integer)

			when Id_Color_green then
   				an_integer := color_green
				last_results.force_last (an_integer)

			when Id_Color_yellow then
   				an_integer := color_yellow
				last_results.force_last (an_integer)

			when Id_Color_blue then
   				an_integer := color_blue
				last_results.force_last (an_integer)

			when Id_Color_magenta then
   				an_integer := color_magenta
				last_results.force_last (an_integer)

			when Id_Color_cyan then
   				an_integer := color_cyan
				last_results.force_last (an_integer)

			when Id_Color_white then
   				an_integer := color_white
				last_results.force_last (an_integer)


			--| Identifiers for CURSES_ERROR_API

			when Id_c_ecurses_err then
				an_integer := c_ecurses_err
 				last_results.force_last (an_integer)
 
			when Id_c_ecurses_ok then
				an_integer := c_ecurses_ok
 				last_results.force_last (an_integer)
 

			--| Identifiers for CURSES_KEY_CONSTANTS
	
			when Id_Key_min then
   				an_integer := key_min
				last_results.force_last (an_integer)

			when Id_Key_MAX  then
   				an_integer := key_MAX
				last_results.force_last (an_integer)
 
			when Id_Key_break then
    			an_integer := key_break
				last_results.force_last (an_integer)

			when Id_Key_down then
				an_integer := key_down
				last_results.force_last (an_integer)

			when Id_Key_up then
 				an_integer := key_up
				last_results.force_last (an_integer)

			when Id_Key_left then
 				an_integer := key_left
				last_results.force_last (an_integer)

			when Id_Key_right then
 				an_integer := key_right
				last_results.force_last (an_integer)

			when Id_Key_home then
 				an_integer := key_home
				last_results.force_last (an_integer)

			when Id_Key_backspace then
 				an_integer := key_backspace
				last_results.force_last (an_integer)

			when Id_Key_f0 then
 				an_integer := key_f0
				last_results.force_last (an_integer)

			when Id_key_f then
 				an_integer := key_f (arguments.item(1).to_integer)
				last_results.force_last (an_integer)

			when Id_Key_DL  then
 				an_integer := key_DL
				last_results.force_last (an_integer)

			when Id_Key_IL   then
 				an_integer := key_IL
				last_results.force_last (an_integer)

			when Id_Key_DC  then
 				an_integer := key_DC
				last_results.force_last (an_integer)

			when Id_Key_IC   then
 				an_integer := key_IC
				last_results.force_last (an_integer)

			when Id_Key_EIC  then
 				an_integer := key_EIC
				last_results.force_last (an_integer)

			when Id_Key_CLEAR  then
 				an_integer := key_CLEAR
				last_results.force_last (an_integer)

			when Id_Key_EOS  then
 				an_integer := key_EOS
				last_results.force_last (an_integer)

			when Id_Key_EOL  then
 				an_integer := key_EOL
				last_results.force_last (an_integer)

			when Id_Key_SF  then
 				an_integer := key_SF
				last_results.force_last (an_integer)

			when Id_Key_SR  then
 				an_integer := key_SR
				last_results.force_last (an_integer)

			when Id_Key_NPAGE  then
 				an_integer := key_NPAGE
				last_results.force_last (an_integer)

			when Id_Key_PPAGE  then
 				an_integer := key_PPAGE
				last_results.force_last (an_integer)

			when Id_Key_STAB  then
 				an_integer := key_STAB
				last_results.force_last (an_integer)

			when Id_Key_CTAB  then
 				an_integer := key_CTAB
				last_results.force_last (an_integer)

			when Id_Key_CATAB  then
 				an_integer := key_CATAB
				last_results.force_last (an_integer)

			when Id_Key_PRINT  then
 				an_integer := key_PRINT
				last_results.force_last (an_integer)

			when Id_Key_LL   then
 				an_integer := key_LL
				last_results.force_last (an_integer)

			when Id_Key_A1  then
 				an_integer := key_A1
				last_results.force_last (an_integer)

			when Id_Key_A3  then
 				an_integer := key_A3
				last_results.force_last (an_integer)

			when Id_Key_B2  then
 				an_integer := key_B2
				last_results.force_last (an_integer)

			when Id_Key_C1  then
 				an_integer := key_C1
				last_results.force_last (an_integer)

			when Id_Key_C3  then
 				an_integer := key_C3
				last_results.force_last (an_integer)

			when Id_Key_BTAB  then
 				an_integer := key_BTAB
				last_results.force_last (an_integer)

			when Id_Key_BEG  then
 				an_integer := key_BEG
				last_results.force_last (an_integer)

			when Id_Key_CANCEL  then
 				an_integer := key_CANCEL
				last_results.force_last (an_integer)

			when Id_Key_CLOSE  then
 				an_integer := key_CLOSE
				last_results.force_last (an_integer)

			when Id_Key_COMMAND  then
 				an_integer := key_COMMAND
				last_results.force_last (an_integer)

			when Id_Key_COPY  then
 				an_integer := key_COPY
				last_results.force_last (an_integer)

			when Id_Key_CREATE  then
 				an_integer := key_CREATE
				last_results.force_last (an_integer)

			when Id_Key_END  then
 				an_integer := key_END
				last_results.force_last (an_integer)

			when Id_Key_EXIT  then
 				an_integer := key_EXIT
				last_results.force_last (an_integer)

			when Id_Key_FIND  then
 				an_integer := key_FIND
				last_results.force_last (an_integer)

			when Id_Key_HELP  then
 				an_integer := key_HELP
				last_results.force_last (an_integer)

			when Id_Key_MARK  then
 				an_integer := key_MARK
				last_results.force_last (an_integer)

			when Id_Key_MESSAGE  then
 				an_integer := key_MESSAGE
				last_results.force_last (an_integer)

			when Id_Key_MOVE  then
 				an_integer := key_MOVE
				last_results.force_last (an_integer)

			when Id_Key_NEXT  then
 				an_integer := key_NEXT
				last_results.force_last (an_integer)

			when Id_Key_OPEN  then
 				an_integer := key_OPEN
				last_results.force_last (an_integer)

			when Id_Key_OPTIONS  then
 				an_integer := key_OPTIONS
				last_results.force_last (an_integer)

			when Id_Key_PREVIOUS  then
 				an_integer := key_PREVIOUS
				last_results.force_last (an_integer)

			when Id_Key_REDO  then
 				an_integer := key_REDO
				last_results.force_last (an_integer)

			when Id_Key_REFERENCE  then
 				an_integer := key_REFERENCE
				last_results.force_last (an_integer)

			when Id_Key_REFRESH  then
 				an_integer := key_REFRESH
				last_results.force_last (an_integer)

			when Id_Key_REPLACE  then
 				an_integer := key_REPLACE
				last_results.force_last (an_integer)

			when Id_Key_RESTART  then
 				an_integer := key_RESTART
				last_results.force_last (an_integer)

			when Id_Key_RESUME  then
 				an_integer := key_RESUME
				last_results.force_last (an_integer)

			when Id_Key_SAVE  then
 				an_integer := key_SAVE
				last_results.force_last (an_integer)

			when Id_Key_SBEG  then
 				an_integer := key_SBEG
				last_results.force_last (an_integer)

			when Id_Key_SCANCEL  then
 				an_integer := key_SCANCEL
				last_results.force_last (an_integer)

			when Id_Key_SCOMMAND  then
				an_integer := key_SCOMMAND
				last_results.force_last (an_integer)

			when Id_Key_SCOPY  then
 				an_integer := key_SCOPY
				last_results.force_last (an_integer)

			when Id_Key_SCREATE  then
 				an_integer := key_SCREATE
				last_results.force_last (an_integer)

			when Id_Key_SDC  then
 				an_integer := key_SDC
				last_results.force_last (an_integer)

			when Id_Key_SDL  then
 				an_integer := key_SDL
				last_results.force_last (an_integer)

			when Id_Key_SELECT  then
 				an_integer := key_SELECT
				last_results.force_last (an_integer)

			when Id_Key_SEND  then
 				an_integer := key_SEND
				last_results.force_last (an_integer)

			when Id_Key_SEOL  then
 				an_integer := key_SEOL
				last_results.force_last (an_integer)

			when Id_Key_SEXIT  then
 				an_integer := key_SEXIT
				last_results.force_last (an_integer)

			when Id_Key_SFIND  then
 				an_integer := key_SFIND
				last_results.force_last (an_integer)

			when Id_Key_SHELP  then
 				an_integer := key_SHELP
				last_results.force_last (an_integer)

			when Id_Key_SHOME  then
 				an_integer := key_SHOME
				last_results.force_last (an_integer)

			when Id_Key_SIC  then
 				an_integer := key_SIC
				last_results.force_last (an_integer)

			when Id_Key_SLEFT  then
 				an_integer := key_SLEFT
				last_results.force_last (an_integer)

			when Id_Key_SMESSAGE  then
 				an_integer := key_SMESSAGE
				last_results.force_last (an_integer)

			when Id_Key_SMOVE  then
 				an_integer := key_SMOVE
				last_results.force_last (an_integer)

			when Id_Key_SNEXT  then
 				an_integer := key_SNEXT
				last_results.force_last (an_integer)

			when Id_Key_SOPTIONS  then
 				an_integer := key_SOPTIONS
				last_results.force_last (an_integer)

			when Id_Key_SPREVIOUS  then
 				an_integer := key_SPREVIOUS
				last_results.force_last (an_integer)

			when Id_Key_SPRINT  then
 				an_integer := key_SPRINT
				last_results.force_last (an_integer)

			when Id_Key_SREDO  then
 				an_integer := key_SREDO
				last_results.force_last (an_integer)

			when Id_Key_SREPLACE  then
 				an_integer := key_SREPLACE
				last_results.force_last (an_integer)

			when Id_Key_SRIGHT  then
 				an_integer := key_SRIGHT
				last_results.force_last (an_integer)

			when Id_Key_SRSUME  then
 				an_integer := key_SRSUME
				last_results.force_last (an_integer)

			when Id_Key_SSAVE  then
 				an_integer := key_SSAVE
				last_results.force_last (an_integer)

			when Id_Key_SSUSPEND  then
 				an_integer := key_SSUSPEND
				last_results.force_last (an_integer)

			when Id_Key_SUNDO  then
 				an_integer := key_SUNDO
				last_results.force_last (an_integer)

			when Id_Key_SUSPEND  then
 				an_integer := key_SUSPEND
				last_results.force_last (an_integer)

			when Id_Key_UNDO  then
 				an_integer := key_UNDO
				last_results.force_last (an_integer)

			else
				report_error (new_error ("Unknown feature indentifier: " + a_feature_identifier.out))
			end
		rescue
			dictionnary.search (a_feature_identifier)
			if dictionnary.found then
				report_error (new_error ("Exception occured in call to  " + dictionnary.found_item))
			else
				report_error (new_error ("Exception occured in call to rcurses feature with identifier " + a_feature_identifier.out))
			end
			report_error (new_error ("Contents of pointers table : " + pointers_table_dump))

		end

	pointers_table: DS_HASH_TABLE [POINTER,STRING]
			-- Tables of pointers which can be accessed by a string key.


	last_results: DS_LINKED_LIST[ANY]
			-- Results of last call.
			
	curses_external_tools: CURSES_EXTERNAL_TOOLS

	i1: INTEGER
	i2: INTEGER

	dictionnary: RCURSES_DICTIONNARY
	

end -- class RCURSES_ADAPTER

-----------------------------------------------------------
-- Copyright (C) 1999-2009 Paul G. Crismer, Eric Fafchamps
-- Licensed under Eiffel Forum Freeware License, version 2
-- (see forum.txt)
-----------------------------------------------------------
