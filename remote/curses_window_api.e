indexing
    description: "Curses window API for a remote access"
    cluster: 	"ecurses, spec, remote_access"
    interface: 	"mixin"
    status: 	"See notice at do end of class"
    date: 	"$Date$"
    revision: 	"$Revision$"
    author: 	"Paul G. Crismer, Eric Fafchamps"

class 
	CURSES_WINDOW_API

inherit
	
	RCURSES_WINDOW_API_IDS
		export
			{NONE} all
		end

	RCURSES_CLIENT_API
		export
			{NONE} all
		end
		
feature  -- initialization

    endwin: INTEGER is
	    -- Deallocate curses screen structure.
		do
			remote_curses.send_request (Id_endwin, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    initscr: POINTER is
	    	-- Initialize curses screen.
		do 
			remote_curses.send_request (Id_initscr, <<>>)
			Result := new_pointer_for_identifier (remote_curses.last_results.item (1))
		end

feature  --  input options

    cbreak : INTEGER is
		do
			remote_curses.send_request (Id_cbreak, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end
    
    echo : INTEGER is
		do
			remote_curses.send_request (Id_echo, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end
    
    halfdelay( tenths: INTEGER; ): INTEGER is
		do
			remote_curses.send_request (Id_halfdelay, <<tenths>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end
    
    nocbreak : INTEGER is
		do
			remote_curses.send_request (Id_nocbreak, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end
    
    noecho : INTEGER is
		do
			remote_curses.send_request (Id_noecho, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end
    
    noraw : INTEGER is
		do
			remote_curses.send_request (Id_noraw, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end
    
    raw : INTEGER is
		do
			remote_curses.send_request (Id_raw, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end
    
    nl: INTEGER is
		do
			remote_curses.send_request (Id_nl, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    nonl: INTEGER is
		do
			remote_curses.send_request (Id_nonl, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    erasechar: CHARACTER is
	    -- erase character.
		do
			remote_curses.send_request (Id_erasechar, <<>>)
			Result := remote_curses.last_results.item (1).item (1)
		end
    
    killchar: CHARACTER is
	    -- kill (clear typed input) character.
		do
			remote_curses.send_request (Id_killchar, <<>>)
			Result := remote_curses.last_results.item (1).item (1)
		end

    typeahead( fd: INTEGER; ): INTEGER is
		do
			remote_curses.send_request (Id_typeahead, <<fd>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    flushinp: INTEGER is
	    -- Throw away any characters not read yet.
		do
			remote_curses.send_request (Id_flushinp, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end


    intrflush (w: POINTER; b: BOOLEAN): INTEGER is
    	local
    		an_identifier: STRING
		do
			an_identifier := identifier_from_pointer (w)
			remote_curses.send_request (Id_intrflush, <<an_identifier, b>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end	

    keypad (w: POINTER; b: BOOLEAN): INTEGER is
    	local
    		an_identifier: STRING
		do
			an_identifier := identifier_from_pointer (w)    		
			remote_curses.send_request (Id_keypad, <<an_identifier, b>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end	

    meta (w: POINTER; b: BOOLEAN): INTEGER is
    	local
    		an_identifier: STRING
		do
			an_identifier := identifier_from_pointer (w)
			remote_curses.send_request (Id_meta, <<an_identifier, b>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end	

    nodelay (w: POINTER; b: BOOLEAN): INTEGER is
 		-- b = TRUE  : causes getch to be a non-blocking call, returning ERR if  no input is ready	
		-- b = FALSE : getch waits until a key is pressed.
    	local
    		an_identifier: STRING
		do
			an_identifier := identifier_from_pointer (w)
			remote_curses.send_request (Id_nodelay, <<an_identifier, b>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end	

    notimeout (w: POINTER; b: BOOLEAN): INTEGER is
		-- b = FALSE : wgetch sets a timer when receiving an ESC,
		-- The  purpose  of  the timeout is to differentiate between sequences
		-- received from a function key  and  those typed by a user.
		-- b = TRUE :  wgetch  does  not set a timer.
    	local
    		an_identifier: STRING
		do
			an_identifier := identifier_from_pointer (w)
			remote_curses.send_request (Id_notimeout, <<an_identifier, b>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end	

    wtimeout (w: POINTER; delay: INTEGER) is
		-- set  blocking  or  non blocking  read  for a given window.
		-- delay < 0 : blocking  read  is  used  (i.e.,  waits  indefinitely  for input).
   		-- delay = 0 : non-blocking read is used (i.e., read returns ERR if no input is waiting).
		-- delay  > 0 : read blocks for delay milliseconds, and returns ERR if there is still no input.
		-- Provides the same functionality as 'nodelay', plus the
       		-- additional capability of being  able  to  block  for  only
       		-- delay milliseconds (where delay is positive).
    	local
    		an_identifier: STRING
		do
			an_identifier := identifier_from_pointer (w)
			remote_curses.send_request (Id_wtimeout, <<an_identifier, delay>>)
		end	

feature -- misc operations

    api_beep : INTEGER is
		do
			remote_curses.send_request (Id_api_beep, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    api_flash: INTEGER is
		do
			remote_curses.send_request (Id_api_flash, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end
    

feature -- output Options

    clearok (p: POINTER; b : BOOLEAN): INTEGER is
	    -- Next wrefresh clears and completely redraws window.
    	local
    		an_identifier: STRING
		do
			an_identifier := identifier_from_pointer (p)
			remote_curses.send_request (Id_clearok, <<an_identifier, b>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end	
    
    idlok (p: POINTER; b : BOOLEAN): INTEGER is
	    -- Use hardware insert/delete line capability if present.
    	local
    		an_identifier: STRING
		do
			an_identifier := identifier_from_pointer (p)
			remote_curses.send_request (Id_idlok, <<an_identifier, b>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end	
    
    idcok (p: POINTER; b : BOOLEAN) is
	    -- Use hardware insert/delete character capability if present.
    	local
    		an_identifier: STRING
		do
			an_identifier := identifier_from_pointer (p)
			remote_curses.send_request (Id_idcok, <<an_identifier, b>>)
		end	
    
    leaveok (p: POINTER; b: BOOLEAN) : INTEGER is
	    -- allows the cursor to be left wherever the update happens to leave it
    	local
    		an_identifier: STRING
		do
			an_identifier := identifier_from_pointer (p)
			remote_curses.send_request (Id_leaveok, <<an_identifier, b>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end	
     

	immedok (p: POINTER; b : BOOLEAN) is
	    -- Redraw screen (i.e. call wrefresh) after every insert/delete.
    	local
    		an_identifier: STRING
		do
			an_identifier := identifier_from_pointer (p)
			remote_curses.send_request (Id_immedok, <<an_identifier, b>>)
		end	
    
    wsetscrreg (p: POINTER; top, bottom: INTEGER): INTEGER is
	    -- Set software scrolling region (in lines) for window.
    	local
    		an_identifier: STRING
		do
			an_identifier := identifier_from_pointer (p)
			remote_curses.send_request (Id_wsetscrreg, <<an_identifier, top, bottom>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end	
    
feature  -- global queries

    api_lines: INTEGER is
		do
			remote_curses.send_request (Id_api_lines, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    api_columns : INTEGER is
		do
			remote_curses.send_request (Id_api_columns, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    api_tab_size : INTEGER is
		do
			remote_curses.send_request (Id_api_tab_size, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    api_colors : INTEGER is
		do
			remote_curses.send_request (Id_api_colors, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    api_color_pairs : INTEGER is
		do
			remote_curses.send_request (Id_api_color_pairs, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    api_stdscr : POINTER is
		do
			remote_curses.send_request (Id_api_stdscr, <<>>)
			Result := pointer_from_identifier (remote_curses.last_results.item (1))
		end	

    api_has_colors : BOOLEAN is
		do
			remote_curses.send_request (Id_api_has_colors, <<>>)
			Result := remote_curses.last_results.item (1).to_boolean
		end	

    start_color : INTEGER is
		do
			remote_curses.send_request (Id_start_color, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    color_pair (n : INTEGER) : INTEGER is
		require
			n > 0
		do
			remote_curses.send_request (Id_color_pair, <<n>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end	

    init_pair ( pair_nr, fore_col, back_col : INTEGER) : INTEGER is
		do
			remote_curses.send_request (Id_init_pair, <<pair_nr, fore_col, back_col>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end	

    pair_number(n : INTEGER) : INTEGER is
		do
			remote_curses.send_request (Id_pair_number, <<n>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end	

    pair_content (n : INTEGER; f, g : POINTER) is
		local
			i1: INTEGER
			i2: INTEGER
		do
			remote_curses.send_request (Id_pair_content, <<n>>)
			i1 := remote_curses.last_results.item (1).to_integer	
			f.set_item ($i1)
			i2 := remote_curses.last_results.item (1).to_integer	
			g.set_item ($i2)
		end
 
feature -- window management

    newwin (nlines, ncols, begin_y, begin_x: INTEGER): POINTER is
			do
				remote_curses.send_request (Id_newwin, <<nlines, ncols, begin_y, begin_x>>)
				
				Result := new_pointer_for_identifier (remote_curses.last_results.item (1))
			end	

    delwin (w: POINTER): INTEGER is
    	local
    		an_identifier: STRING
		do
			an_identifier := identifier_from_pointer (w)
			remote_curses.send_request (Id_delwin, <<an_identifier>>)
			Result := remote_curses.last_results.item (1).to_integer	
			release_identifier (w)
		end	

    mvwin (w: POINTER; y, x: INTEGER): INTEGER is
    	local
    		an_identifier: STRING
		do
			an_identifier := identifier_from_pointer (w)
			remote_curses.send_request (Id_mvwin, <<an_identifier, y, x>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end	

    subwin (orig: POINTER; lns, cols, begin_y, begin_x: INTEGER): POINTER is
    	local
    		an_identifier: STRING
		do
			an_identifier := identifier_from_pointer (orig)
			remote_curses.send_request (Id_subwin, <<an_identifier, lns, cols, begin_y, begin_x>>)
			Result := new_pointer_for_identifier (remote_curses.last_results.item (1))
		end	

    derwin (orig: POINTER; lns, cols, begin_y, begin_x: INTEGER): POINTER is
    	local
    		an_identifier: STRING
		do
			an_identifier := identifier_from_pointer (orig)
			remote_curses.send_request (Id_derwin, <<an_identifier, lns, cols, begin_y, begin_x>>)
			Result := new_pointer_for_identifier (remote_curses.last_results.item (1))
		end	

    mvderwin (w: POINTER; par_y, par_x: INTEGER): INTEGER is
    	local
    		an_identifier: STRING
		do
			an_identifier := identifier_from_pointer (w)
			remote_curses.send_request (Id_mvderwin, <<an_identifier, par_y, par_x>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end	

    dupwin (w: POINTER): POINTER is
    	local
    		an_identifier: STRING
		do
			an_identifier := identifier_from_pointer (w)
			remote_curses.send_request (Id_dupwin, <<an_identifier>>)
			Result := new_pointer_for_identifier (remote_curses.last_results.item (1))
		end	

    wsyncup (w: POINTER) is
    	local
    		an_identifier: STRING
		do
			an_identifier := identifier_from_pointer (w)
			remote_curses.send_request (Id_wsyncup, <<an_identifier>>)
		end	

    wcursyncup (w: POINTER) is
    	local
    		an_identifier: STRING
		do
			an_identifier := identifier_from_pointer (w)
			remote_curses.send_request (Id_wcursyncup, <<an_identifier>>)
		end	

    wsyncdown (w: POINTER) is
    	local
    		an_identifier: STRING
		do
			an_identifier := identifier_from_pointer (w)
			remote_curses.send_request (Id_wsyncdown, <<an_identifier>>)
		end	

    syncok (w: POINTER; b : BOOLEAN): INTEGER is
    	local
    		an_identifier: STRING
		do
			an_identifier := identifier_from_pointer (w)
			remote_curses.send_request (Id_syncok, <<an_identifier, b>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end	


feature  -- single character operations

    waddch (w: POINTER; ch: INTEGER): INTEGER is
	-- add a character
	-- ncurses : implemented
	-- pdcurses: macro
	-- ncurses= external "C"
    	local
    		an_identifier: STRING
		do
			an_identifier := identifier_from_pointer (w)
			remote_curses.send_request (Id_waddch, <<an_identifier, ch>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end	

    wechochar (w: POINTER; ch: INTEGER): INTEGER is
    	local
    		an_identifier: STRING
		do
			an_identifier := identifier_from_pointer (w)
			remote_curses.send_request (Id_wechochar, <<an_identifier, ch>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end	

    mvwaddch (w: POINTER; y, x: INTEGER; ch: INTEGER): INTEGER is
    	local
    		an_identifier: STRING
		do
			an_identifier := identifier_from_pointer (w)
			remote_curses.send_request (Id_mvwaddch, <<an_identifier, y, x, ch>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end	
    
    winsch (w: POINTER; ch: INTEGER): INTEGER is
	    -- insert character with attribs before cursor.
    	local
    		an_identifier: STRING
		do
			an_identifier := identifier_from_pointer (w)
			remote_curses.send_request (Id_winsch, <<an_identifier, ch>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end	

    wdelch (w: POINTER): INTEGER is
    	local
    		an_identifier: STRING
		do
			an_identifier := identifier_from_pointer (w)
			remote_curses.send_request (Id_wdelch, <<an_identifier>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end	

    mvwdelch (w: POINTER; y, x: INTEGER): INTEGER is
    	local
    		an_identifier: STRING
		do
			an_identifier := identifier_from_pointer (w)
			remote_curses.send_request (Id_mvwdelch, <<an_identifier, y, x>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end	

    wgetch (w: POINTER): INTEGER is
    	local
    		an_identifier: STRING
		do
			an_identifier := identifier_from_pointer (w)
			remote_curses.send_request (Id_wgetch, <<an_identifier>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end	

    mvwgetch (w: POINTER; y, x: INTEGER): INTEGER is
    	local
    		an_identifier: STRING
		do
			an_identifier := identifier_from_pointer (w)
			remote_curses.send_request (Id_mvwgetch, <<an_identifier, y, x>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end	


    winch (w: POINTER): INTEGER is
    	local
    		an_identifier: STRING
		do
			an_identifier := identifier_from_pointer (w)
			remote_curses.send_request (Id_winch, <<an_identifier>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end	


feature -- string operations

    wgetstr (w, str: POINTER): INTEGER is
    	local
    		an_identifier: STRING
			curses_external_tools: CURSES_EXTERNAL_TOOLS
		do
			an_identifier := identifier_from_pointer (w)
			remote_curses.send_request (Id_wgetstr, <<an_identifier>>)

			str.set_item (curses_external_tools.string_to_pointer (remote_curses.last_results.item(1)))

			Result := remote_curses.last_results.item (2).to_integer	
		end	

    wgetnstr (w, str: POINTER; n: INTEGER): INTEGER is
	    -- read at most n characters into the string.
    	local
    		an_identifier: STRING
			curses_external_tools: CURSES_EXTERNAL_TOOLS
		do
			an_identifier := identifier_from_pointer (w)
			remote_curses.send_request (Id_wgetnstr, <<an_identifier, n>>)

			str.set_item (curses_external_tools.string_to_pointer (remote_curses.last_results.item (1)))
			Result := remote_curses.last_results.item (2).to_integer	
		end	

    winchstr (w, chrstr: POINTER): INTEGER is
    	local
    		an_identifier: STRING
			a_string: STRING
    		converter: CURSES_EXTERNAL_TOOLS
		do
			an_identifier := identifier_from_pointer (w)
			a_string := converter.pointer_to_string (chrstr)
			remote_curses.send_request (Id_winchstr, <<an_identifier, a_string >>)

			Result := remote_curses.last_results.item (1).to_integer	
		end	

    winchnstr (w, chrstr: POINTER; n: INTEGER): INTEGER is
    	local
    		an_identifier: STRING
			a_string: STRING
    		converter: CURSES_EXTERNAL_TOOLS
		do
			an_identifier := identifier_from_pointer (w)
			a_string := converter.pointer_to_string (chrstr)
			remote_curses.send_request (Id_winchnstr, <<an_identifier, a_string, n >>)

			Result := remote_curses.last_results.item (1).to_integer	
		end	

    winstr (w, chrstr: POINTER): INTEGER is
    	local
    		an_identifier: STRING
			a_string: STRING
    		converter: CURSES_EXTERNAL_TOOLS
		do
			an_identifier := identifier_from_pointer (w)
			a_string := converter.pointer_to_string (chrstr)
			remote_curses.send_request (Id_winstr, <<an_identifier, a_string >>)

			Result := remote_curses.last_results.item (1).to_integer	
		end	

    winnstr (w, chrstr: POINTER; n: INTEGER): INTEGER is
    	local
    		an_identifier: STRING
			a_string: STRING
    		converter: CURSES_EXTERNAL_TOOLS
		do
			an_identifier := identifier_from_pointer (w)
			a_string := converter.pointer_to_string (chrstr)
			remote_curses.send_request (Id_winnstr, <<an_identifier, a_string, n >>)

			Result := remote_curses.last_results.item (1).to_integer	
		end	

    waddstr (w, s: POINTER): INTEGER is
	    -- Add a C string to the current cursor position.
    	local
    		an_identifier: STRING
			a_string: STRING
    		converter: CURSES_EXTERNAL_TOOLS
		do
			an_identifier := identifier_from_pointer (w)
			a_string := converter.pointer_to_string (s)
			remote_curses.send_request (Id_waddstr, <<an_identifier, a_string >>)

			Result := remote_curses.last_results.item (1).to_integer	
		end	
    
    waddnstr (w, s: POINTER; n: INTEGER): INTEGER is
	    -- Add at most n characters from a C string to the current 
	    -- cursor position.
    	local
    		an_identifier: STRING
			a_string: STRING
    		converter: CURSES_EXTERNAL_TOOLS
		do
			an_identifier := identifier_from_pointer (w)
			a_string := converter.pointer_to_string (s)
			remote_curses.send_request (Id_waddnstr, <<an_identifier, a_string, n >>)

			Result := remote_curses.last_results.item (1).to_integer	
		end	
    
    waddchstr (w, s: POINTER): INTEGER is
	    -- Add an attributed C string to the current cursor position.
    	local
    		an_identifier: STRING
			a_string: STRING
    		converter: CURSES_EXTERNAL_TOOLS
		do
			an_identifier := identifier_from_pointer (w)
			a_string := converter.pointer_to_string (s)
			remote_curses.send_request (Id_waddchstr, <<an_identifier, a_string >>)

			Result := remote_curses.last_results.item (1).to_integer	
		end	
    
    waddchnstr (w, s: POINTER; n: INTEGER): INTEGER is
	    -- Add at most n characters from an attributed C string to 
	    -- the current cursor position.
    	local
    		an_identifier: STRING
			a_string: STRING
    		converter: CURSES_EXTERNAL_TOOLS
		do
			an_identifier := identifier_from_pointer (w)
			a_string := converter.pointer_to_string (s)
			remote_curses.send_request (Id_waddchnstr, <<an_identifier, a_string, n >>)

			Result := remote_curses.last_results.item (1).to_integer	
		end	
    
    winsstr (w,s : POINTER): INTEGER is
	    -- Insert a C string to the current cursor position.
		-- ncurses, pdcurses : macro
    	local
    		an_identifier: STRING
			a_string: STRING
    		converter: CURSES_EXTERNAL_TOOLS
		do
			an_identifier := identifier_from_pointer (w)
			a_string := converter.pointer_to_string (s)
			remote_curses.send_request (Id_winsstr, <<an_identifier, a_string >>)

			Result := remote_curses.last_results.item (1).to_integer	
		end	
    
    winsnstr (w, s: POINTER; n: INTEGER): INTEGER is
	    -- Insert at most n characters from a C string to the current 
	    -- cursor position.
    	local
    		an_identifier: STRING
			a_string: STRING
    		converter: CURSES_EXTERNAL_TOOLS
		do
			an_identifier := identifier_from_pointer (w)
			a_string := converter.pointer_to_string (s)
			remote_curses.send_request (Id_winsnstr, <<an_identifier, a_string, n >>)

			Result := remote_curses.last_results.item (1).to_integer	
		end	

feature -- attribute management

    wattroff (w: POINTER; attrs: INTEGER): INTEGER is
		-- attribute off
		-- ncurses : macro
		-- pdcurses: implemented
    	local
    		an_identifier: STRING
		do
			an_identifier := identifier_from_pointer (w)
			remote_curses.send_request (Id_wattroff, <<an_identifier, attrs>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end	
    
    wattron (w: POINTER; attrs: INTEGER): INTEGER is
		-- attribute off
		-- ncurses : macro
		-- pdcurses: implemented
    	local
    		an_identifier: STRING
		do
			an_identifier := identifier_from_pointer (w)
			remote_curses.send_request (Id_wattron, <<an_identifier, attrs>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end	
    
    wattrset (w: POINTER; attrs: INTEGER): INTEGER is
		-- attribute off
		-- ncurses : macro
		-- pdcurses: implemented
    	local
    		an_identifier: STRING
		do
			an_identifier := identifier_from_pointer (w)
			remote_curses.send_request (Id_wattrset, <<an_identifier, attrs>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end	

    wbkgdset (p: POINTER; ch : INTEGER) is
    	local
    		an_identifier: STRING
		do
			an_identifier := identifier_from_pointer (p)
			remote_curses.send_request (Id_wbkgdset, <<an_identifier, ch>>)
		end	
    
    wbkgd (p: POINTER; ch : INTEGER): INTEGER is
    	local
    		an_identifier: STRING
		do
			an_identifier := identifier_from_pointer (p)
			remote_curses.send_request (Id_wbkgd, <<an_identifier, ch>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end	

    wchgat (w: POINTER; n, attr, color : INTEGER; opt:POINTER) : INTEGER is
		--require
		--opt_null : opt = default_pointer
    	local
    		an_identifier: STRING
		do
			an_identifier := identifier_from_pointer (w)
			remote_curses.send_request (Id_wchgat, <<an_identifier, n, attr, color, Void>>)

			Result := remote_curses.last_results.item (1).to_integer	
		end	

    getattrs (w: POINTER) : INTEGER is
    	local
    		an_identifier: STRING
		do
			an_identifier := identifier_from_pointer (w)
			remote_curses.send_request (Id_getattrs, <<an_identifier>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end	

    getbkgd (w: POINTER) : INTEGER is
    	local
    		an_identifier: STRING
		do
			an_identifier := identifier_from_pointer (w)
			remote_curses.send_request (Id_getbkgd, <<an_identifier>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end	
	
feature -- line drawing

    wborder (w: POINTER; ls, rs, ts, bs, tl, tr, bl, br: INTEGER): INTEGER is
	    local
	    	an_identifier: STRING
		do
			an_identifier := identifier_from_pointer (w)
			remote_curses.send_request (Id_wborder, <<an_identifier, ls, rs, ts, bs, tl, tr, bl, br>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end	

    
    whline (w: POINTER; ch, n: INTEGER): INTEGER is
    	local
    		an_identifier: STRING
		do
			an_identifier := identifier_from_pointer (w)
			remote_curses.send_request (Id_whline, <<an_identifier, ch, n>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end	
    
    wvline (w: POINTER; ch, n: INTEGER): INTEGER is
    	local
    		an_identifier: STRING
		do
			an_identifier := identifier_from_pointer (w)
			remote_curses.send_request (Id_wvline, <<an_identifier, ch, n>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end	

    box (w: POINTER; vert_ch, horz_ch : INTEGER) : INTEGER is
    	local
    		an_identifier: STRING
		do
			an_identifier := identifier_from_pointer (w)
			remote_curses.send_request (Id_box, <<an_identifier, vert_ch, horz_ch>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end	
     

feature -- window refresh

    wrefresh (w: POINTER): INTEGER is
    	local
    		an_identifier: STRING
		do
			an_identifier := identifier_from_pointer (w)
			remote_curses.send_request (Id_wrefresh, <<an_identifier>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end	
    
    wnoutrefresh (w: POINTER): INTEGER is
    	local
    		an_identifier: STRING
		do
			an_identifier := identifier_from_pointer (w)
			remote_curses.send_request (Id_wnoutrefresh, <<an_identifier>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end	
    
    doupdate: INTEGER is
		do
			remote_curses.send_request (Id_doupdate, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    redrawwin (w: POINTER): INTEGER is
    	local
    		an_identifier: STRING
		do
			an_identifier := identifier_from_pointer (w)
			remote_curses.send_request (Id_redrawwin, <<an_identifier>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end
    
    wredrawln (w: POINTER; x, y : INTEGER): INTEGER is
    	local
    		an_identifier: STRING
		do
			an_identifier := identifier_from_pointer (w)
			remote_curses.send_request (Id_wredrawln, <<an_identifier, x, y>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    wtouchln (w: POINTER; y, x : INTEGER; changed: BOOLEAN): INTEGER is
    	local
    		an_identifier: STRING
		do
			an_identifier := identifier_from_pointer (w)
			remote_curses.send_request (Id_wtouchln, <<an_identifier, y, x, changed>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end	

    touchwin (w: POINTER): INTEGER is
    	local
    		an_identifier: STRING
		do
			an_identifier := identifier_from_pointer (w)
			remote_curses.send_request (Id_touchwin, <<an_identifier>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    is_wintouched (w: POINTER): INTEGER is
    	local
    		an_identifier: STRING
    		converter: CURSES_EXTERNAL_TOOLS
		do
			an_identifier := identifier_from_pointer (w)
			remote_curses.send_request (Id_is_wintouched, <<an_identifier>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    is_linetouched (w: POINTER; line: INTEGER): INTEGER is
    	local
    		an_identifier: STRING
    		converter: CURSES_EXTERNAL_TOOLS
		do
			an_identifier := identifier_from_pointer (w)
			remote_curses.send_request (Id_is_linetouched, <<an_identifier, line>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end


feature -- line/window deletion
    
    werase (w: POINTER): INTEGER is
    	local
    		an_identifier: STRING
		do
			an_identifier := identifier_from_pointer (w)
			remote_curses.send_request (Id_werase, <<an_identifier>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    wclear (w: POINTER): INTEGER is
    	local
    		an_identifier: STRING
		do
			an_identifier := identifier_from_pointer (w)
			remote_curses.send_request (Id_wclear, <<an_identifier>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    wclrtobot (w: POINTER): INTEGER is
    	local
    		an_identifier: STRING
		do
			an_identifier := identifier_from_pointer (w)
			remote_curses.send_request (Id_wclrtobot, <<an_identifier>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    wclrtoeol (w: POINTER): INTEGER is
    	local
    		an_identifier: STRING
		do
			an_identifier := identifier_from_pointer (w)
			remote_curses.send_request (Id_wclrtoeol, <<an_identifier>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    wdeleteln (w: POINTER; ): INTEGER is
	    -- Delete line at current cursor position, move lines up,
	    -- blank line at bottom of window.
    	local
    		an_identifier: STRING
		do
			an_identifier := identifier_from_pointer (w)
			remote_curses.send_request (Id_wdeleteln, <<an_identifier>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end
	
    winsdelln (w: POINTER; n: INTEGER): INTEGER is
	    -- n > 0 : insert n blank lines above current cursor
	    --	 position, bottom n lines are lost
	    -- n < 0 : delete abs (n) lines starting at current cursor
	    --	 position, move remaining lines up, leave abs (n)
	    --	 blank lines at bottom of window
    	local
    		an_identifier: STRING
		do
			an_identifier := identifier_from_pointer (w)
			remote_curses.send_request (Id_winsdelln, <<an_identifier, n>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end
	
    winsertln (p: POINTER): INTEGER is
	    -- Insert a blank line above current cursor position, 
	    -- bottom line is lost.
    	local
    		an_identifier: STRING
		do
			an_identifier := identifier_from_pointer (p)
			remote_curses.send_request (Id_winsertln, <<an_identifier>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

feature -- cursor movement

    wmove (w: POINTER; y, x: INTEGER): INTEGER is    
    	local
    		an_identifier: STRING
		do
			an_identifier := identifier_from_pointer (w)
			remote_curses.send_request (Id_wmove, <<an_identifier, y, x>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end	

feature -- window scrolling

    scrollok (w: POINTER; b : BOOLEAN): INTEGER is
    	local
    		an_identifier: STRING
		do
			an_identifier := identifier_from_pointer (w)
			remote_curses.send_request (Id_scrollok, <<an_identifier, b>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end
    
    wscrl (w: POINTER; n: INTEGER): INTEGER is
	    -- Scroll window n lines.
	    --    n > 0 : up
	    --    n < 0 : down
    	local
    		an_identifier: STRING
		do
			an_identifier := identifier_from_pointer (w)
			remote_curses.send_request (Id_wscrl, <<an_identifier, n>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

feature -- overlaying

    overlay (win1, win2: POINTER): INTEGER is
	    -- overlay win1 with win2
    	local
    		win1_identifier: STRING
			win2_identifier: STRING
		do
			win1_identifier := identifier_from_pointer (win1)
			win2_identifier := identifier_from_pointer (win2)

			remote_curses.send_request (Id_overlay, <<win1_identifier, win2_identifier>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end
    
    overwrite (win1, win2: POINTER): INTEGER is
	    -- overlay win1 with win2
    	local
    		win1_identifier: STRING
			win2_identifier: STRING
		do
			win1_identifier := identifier_from_pointer (win1)
			win2_identifier := identifier_from_pointer (win2)
			remote_curses.send_request (Id_overwrite, <<win1_identifier, win2_identifier>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end
    
    copywin (win1, win2: POINTER; 
	     sminrow, smincol, dminrow, dmincol, dmaxrow, dmaxcol, overlay_num: INTEGER): INTEGER is
	    -- copy win1 with win2
    	local
    		win1_identifier: STRING
			win2_identifier: STRING
		do
			win1_identifier := identifier_from_pointer (win1)
			win2_identifier := identifier_from_pointer (win2)
			remote_curses.send_request (Id_copywin, <<win1_identifier, win2_identifier, sminrow, smincol, dminrow, dmincol, dmaxrow, dmaxcol, overlay_num>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end
    

feature -- window queries

    getmaxx (w: POINTER) : INTEGER is
    	local
    		an_identifier: STRING
		do
			an_identifier := identifier_from_pointer (w)
			remote_curses.send_request (Id_getmaxx, <<an_identifier>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    getmaxy (w: POINTER) : INTEGER is
    	local
    		an_identifier: STRING
		do
			an_identifier := identifier_from_pointer (w)
			remote_curses.send_request (Id_getmaxy, <<an_identifier>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    getbegx(w: POINTER) : INTEGER is
    	local
    		an_identifier: STRING
		do
			an_identifier := identifier_from_pointer (w)
			remote_curses.send_request (Id_getbegx, <<an_identifier>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end	


    getbegy (w: POINTER) : INTEGER is
    	local
    		an_identifier: STRING
		do
			an_identifier := identifier_from_pointer (w)
			remote_curses.send_request (Id_getbegy, <<an_identifier>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end	

    c_cursor_x  (w : POINTER) : INTEGER is
    	local
    		an_identifier: STRING
		do
			an_identifier := identifier_from_pointer (w)
			remote_curses.send_request (Id_c_cursor_x, <<an_identifier>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end	

    c_cursor_y (w : POINTER) : INTEGER is
    	local
    		an_identifier: STRING
		do
			an_identifier := identifier_from_pointer (w)
			remote_curses.send_request (Id_c_cursor_y, <<an_identifier>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end	


end -- class CURSES_WINDOW_API

-----------------------------------------------------------
-- Copyright (C) 2001 Paul G. Crismer, Eric Fafchamps
-- Licensed under Eiffel Forum Freeware License, version 1
-- (see forum.txt)
-----------------------------------------------------------




