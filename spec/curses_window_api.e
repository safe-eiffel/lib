indexing
    description: "Curses window API"
    cluster: 	"ecurses, spec"
    interface: 	"mixin"
    status: 	"See notice at end of class"
    date: 	"$Date$"
    revision: 	"$Revision$"
    author: 	"Paul G. Crismer, Eric Fafchamps"

class 
	CURSES_WINDOW_API

feature  -- initialization

    endwin: INTEGER is
	    -- Deallocate curses screen structure.
	external "C"
	alias "c_ecurses_endwin"
	end

    initscr: POINTER is
	    -- Initialize curses screen.
	external "C"
	alias "c_ecurses_initscr"
	end
    
    --filter is
	--external "C"
	--alias "c_ecurses_filter"
	--end


feature  --  input options

    cbreak : INTEGER is
	external "C"
	alias "c_ecurses_cbreak"
	end
    
    echo : INTEGER is
	external "C"
	alias "c_ecurses_echo"
	end
    
    halfdelay( tenths: INTEGER; ): INTEGER is
	external "C"
	alias "c_ecurses_halfdelay"
	end
    
    nocbreak : INTEGER is
	external "C"
	alias "c_ecurses_nocbreak"
	end
    
    noecho : INTEGER is
	external "C"
	alias "c_ecurses_noecho"
	end
    
    noraw : INTEGER is
	external "C"
	alias "c_ecurses_noraw"
	end
    
    raw : INTEGER is
	external "C"
	alias "c_ecurses_raw"
	end
    
    nl: INTEGER is
	external "C"
	alias "c_ecurses_nl"
	end

    nonl: INTEGER is
	external "C"
	alias "c_ecurses_nonl"
	end

    erasechar: CHARACTER is
	    -- erase character.
	external "C"
	alias "c_ecurses_erasechar"
	end
    
    killchar: CHARACTER is
	    -- kill (clear typed input) character.
	external "C"
	alias "c_ecurses_killchar"
	end

    typeahead( fd: INTEGER; ): INTEGER is
	external "C"
	alias "c_ecurses_typeahead"
	end

    flushinp: INTEGER is
	    -- Throw away any characters not read yet.
	external "C"
	alias "c_ecurses_flushinp"
	end

    --qiflush is
	--    -- Flush input and output queues on receipt of
	--    -- INTR, QUIT or SUSP characters.
	--    external "C"
	--alias "c_ecurses_qiflush"
	--end;
    
    --noqiflush is
	--    -- Flush input and output queues on receipt of
	--    -- INTR, QUIT or SUSP characters.
	--    external "C"
	--alias "c_ecurses_noqiflush"
	--end;

    intrflush (w: POINTER; b: BOOLEAN): INTEGER is
	external "C"
	alias "c_ecurses_intrflush"
	end

    keypad (w: POINTER; b: BOOLEAN): INTEGER is
	external "C"
	alias "c_ecurses_keypad"
	end

    meta (w: POINTER; b: BOOLEAN): INTEGER is
	external "C"
	alias "c_ecurses_meta"
	end

    nodelay (w: POINTER; b: BOOLEAN): INTEGER is
 		-- b = TRUE  : causes getch to be a non-blocking call, returning ERR if  no input is ready	
		-- b = FALSE : getch waits until a key is pressed.
	external "C"
	alias "c_ecurses_nodelay"
	end

    notimeout (w: POINTER; b: BOOLEAN): INTEGER is
		-- b = FALSE : wgetch sets a timer when receiving an ESC,
		-- The  purpose  of  the timeout is to differentiate between sequences
		-- received from a function key  and  those typed by a user.
		-- b = TRUE :  wgetch  does  not set a timer.
	external "C"
	alias "c_ecurses_notimeout"
	end

    wtimeout (w: POINTER; delay: INTEGER) is
		-- set  blocking  or  non blocking  read  for a given window.
		-- delay < 0 : blocking  read  is  used  (i.e.,  waits  indefinitely  for input).
   		-- delay = 0 : non-blocking read is used (i.e., read returns ERR if no input is waiting).
		-- delay  > 0 : read blocks for delay milliseconds, and returns ERR if there is still no input.
		-- Provides the same functionality as 'nodelay', plus the
       		-- additional capability of being  able  to  block  for  only
       		-- delay milliseconds (where delay is positive).
	external "C"
	alias "c_ecurses_wtimeout"
	end

feature -- misc operations

    api_beep : INTEGER is
	external "C"
	alias "c_ecurses_api_beep"
	end

    api_flash: INTEGER is
	external "C"
	alias "c_ecurses_api_flash"
	end
    

feature -- output Options

    clearok (p: POINTER; b : BOOLEAN): INTEGER is
	    -- Next wrefresh clears and completely redraws window.
	external "C"
	alias "c_ecurses_clearok"
	end
    
    idlok (p: POINTER; b : BOOLEAN): INTEGER is
	    -- Use hardware insert/delete line capability if present.
	external "C"
	alias "c_ecurses_idlok"
	end
    
    idcok (p: POINTER; b : BOOLEAN) is
	    -- Use hardware insert/delete character capability if present.
	external "C"
	alias "c_ecurses_idcok"
	end
    
    leaveok (p: POINTER; b: BOOLEAN) : INTEGER is
	    -- allows the cursor to be left wherever the update happens to leave it
	external "C"
	alias "c_ecurses_leaveok"
	end
     

	immedok (p: POINTER; b : BOOLEAN) is
	    -- Redraw screen (i.e. call wrefresh) after every insert/delete.
	external "C"
	alias "c_ecurses_immedok"
	end
    
    wsetscrreg (p: POINTER; top, bottom: INTEGER): INTEGER is
	    -- Set software scrolling region (in lines) for window.
	external "C"
	alias "c_ecurses_wsetscrreg"
	end
    
feature  -- global queries

    api_lines: INTEGER is
	external "C"
	alias "c_ecurses_api_lines"
	end

    api_columns : INTEGER is
	external "C"
	alias "c_ecurses_api_columns"
	end

    api_tab_size : INTEGER is
	external "C"
	alias "c_ecurses_api_tab_size"
	end

    api_colors : INTEGER is
	external "C"
	alias "c_ecurses_api_colors"
	end

    api_color_pairs : INTEGER is
	external "C"
	alias "c_ecurses_api_color_pairs"
	end

    api_stdscr : POINTER is
	external "C"
	alias "c_ecurses_api_stdscr"
	end

    api_has_colors : BOOLEAN is
	external "C"
	alias "c_ecurses_api_has_colors"
	end

    start_color : INTEGER is
	external "C"
	alias "c_ecurses_start_color"
	end

    color_pair (n : INTEGER) : INTEGER is
	require
		n > 0
	external "C"
	alias "c_ecurses_color_pair"
	end

    init_pair ( pair_nr, fore_col, back_col : INTEGER) : INTEGER is
	external "C"
	alias "c_ecurses_init_pair"
	end

    pair_number(n : INTEGER) : INTEGER is
	external "C"
	alias "c_ecurses_pair_number"
	end

    pair_content (n : INTEGER; f, g : POINTER) is
	external "C"
	alias "c_ecurses_pair_content"
	end
 
feature -- window management

    newwin (nlines, ncols, begin_y, begin_x: INTEGER): POINTER is
	external "C"
	alias "c_ecurses_newwin"
	end

    delwin (w: POINTER): INTEGER is
	external "C"
	alias "c_ecurses_delwin"
	end

    mvwin (w: POINTER; y, x: INTEGER): INTEGER is
	external "C"
	alias "c_ecurses_mvwin"
	end

    subwin (orig: POINTER; lns, cols, begin_y, begin_x: INTEGER): POINTER is
	external "C"
	alias "c_ecurses_subwin"
	end

    derwin (orig: POINTER; lns, cols, begin_y, begin_x: INTEGER): POINTER is
	external "C"
	alias "c_ecurses_derwin"
	end

    mvderwin (w: POINTER; par_y, par_x: INTEGER): INTEGER is
	external "C"
	alias "c_ecurses_mvderwin"
	end

    dupwin (w: POINTER): POINTER is
	external "C"
	alias "c_ecurses_dupwin"
	end

    wsyncup (w: POINTER) is
	external "C"
	alias "c_ecurses_wsyncup"
	end

    wcursyncup (w: POINTER) is
	external "C"
	alias "c_ecurses_wcursyncup"
	end

    wsyncdown (w: POINTER) is
	external "C"
	alias "c_ecurses_wsyncdown"
	end

    syncok (w: POINTER; b : BOOLEAN): INTEGER is
	external "C"
	alias "c_ecurses_syncok"
	end


feature  -- single character operations

    waddch (w: POINTER; ch: INTEGER): INTEGER is
	-- add a character
	-- ncurses : implemented
	-- pdcurses: macro
	-- ncurses= external "C"
	external "C"
	alias "c_ecurses_waddch"
	end

    wechochar (w: POINTER; ch: INTEGER): INTEGER is
	external "C"
	alias "c_ecurses_wechochar"
	end

    mvwaddch (w: POINTER; y, x: INTEGER; ch: INTEGER): INTEGER is
	external "C"
	alias "c_ecurses_mvwaddch"
	end
    
    winsch (w: POINTER; ch: INTEGER): INTEGER is
	    -- insert character with attribs before cursor.
	external "C"
	alias "c_ecurses_winsch"
	end

    wdelch (w: POINTER): INTEGER is
	external "C"
	alias "c_ecurses_wdelch"
	end

    mvwdelch (w: POINTER; y, x: INTEGER): INTEGER is
	external "C"
	alias "c_ecurses_mvwdelch"
	end

    wgetch (w: POINTER): INTEGER is
	external "C"
	alias "c_ecurses_wgetch"
	end

    mvwgetch (w: POINTER; y, x: INTEGER): INTEGER is
	external "C"
	alias "c_ecurses_mvwgetch"
	end


    winch (w: POINTER): INTEGER is
	external "C"
	alias "c_ecurses_winch"
	end


feature -- string operations

    wgetstr (w, str: POINTER): INTEGER is
	external "C"
	alias "c_ecurses_wgetstr"
	end

    wgetnstr (w, str: POINTER; n: INTEGER): INTEGER is
	    -- read at most n characters into the string.
	external "C"
	alias "c_ecurses_wgetnstr"
	end

    winchstr (w, chrstr: POINTER): INTEGER is
	external "C"
	alias "c_ecurses_winchstr"
	end

    winchnstr (w, chrstr: POINTER; n: INTEGER): INTEGER is
	external "C"
	alias "c_ecurses_winchnstr"
	end

    winstr (w, chrstr: POINTER): INTEGER is
	external "C"
	alias "c_ecurses_winstr"
	end

    winnstr (w, chrstr: POINTER; n: INTEGER): INTEGER is
	external "C"
	alias "c_ecurses_winnstr"
	end

    waddstr (w, s: POINTER): INTEGER is
	    -- Add a C string to the current cursor position.
	external "C"
	alias "c_ecurses_waddstr"
	end
    
    waddnstr (w, s: POINTER; n: INTEGER): INTEGER is
	    -- Add at most n characters from a C string to the current 
	    -- cursor position.
	external "C"
	alias "c_ecurses_waddnstr"
	end
    
    waddchstr (w, s: POINTER): INTEGER is
	    -- Add an attributed C string to the current cursor position.
	external "C"
	alias "c_ecurses_waddchstr"
	end
    
    waddchnstr (w, s: POINTER; n: INTEGER): INTEGER is
	    -- Add at most n characters from an attributed C string to 
	    -- the current cursor position.
	external "C"
	alias "c_ecurses_waddchnstr"
	end
    
    winsstr (w,s : POINTER): INTEGER is
	    -- Insert a C string to the current cursor position.
		-- ncurses, pdcurses : macro
	external "C"
	alias "c_ecurses_winsstr"
	end
    
    winsnstr (w, s: POINTER; n: INTEGER): INTEGER is
	    -- Insert at most n characters from a C string to the current 
	    -- cursor position.
	external "C"
	alias "c_ecurses_winsnstr"
	end

feature -- attribute management

    wattroff (w: POINTER; attrs: INTEGER): INTEGER is
		-- attribute off
		-- ncurses : macro
		-- pdcurses: implemented
	external "C"
	alias "c_ecurses_wattroff"
	end
    
    wattron (w: POINTER; attrs: INTEGER): INTEGER is
		-- attribute off
		-- ncurses : macro
		-- pdcurses: implemented
	external "C"
	alias "c_ecurses_wattron"
	end
    
    wattrset (w: POINTER; attrs: INTEGER): INTEGER is
		-- attribute off
		-- ncurses : macro
		-- pdcurses: implemented
	external "C"
	alias "c_ecurses_wattrset"
	end

    wbkgdset (p: POINTER; ch : INTEGER) is
	external "C"
	alias "c_ecurses_wbkgdset"
	end
    
    wbkgd (p: POINTER; ch : INTEGER): INTEGER is
	external "C"
	alias "c_ecurses_wbkgd"
	end     

    wchgat (w: POINTER; n, attr, color : INTEGER; opt:POINTER) : INTEGER is
		--require
		--opt_null : opt = default_pointer
	external "C"
	alias "c_ecurses_wchgat"
	end 

    getattrs (w: POINTER) : INTEGER is
	external "C"
	alias "c_ecurses_getattrs"
	end

    getbkgd (w: POINTER) : INTEGER is
	external "C"
	alias "c_ecurses_getbkgd"
	end
feature -- line drawing

    wborder (w: POINTER; ls, rs, ts, bs, tl, tr, bl, br: INTEGER): INTEGER is
	external "C"
	alias "c_ecurses_wborder"
	end
    
    whline (w: POINTER; ch, n: INTEGER): INTEGER is
	external "C"
	alias "c_ecurses_whline"
	end
    
    wvline (w: POINTER; ch, n: INTEGER): INTEGER is
	external "C"
	alias "c_ecurses_wvline"
	end

    box (w: POINTER; vert_ch, horz_ch : INTEGER) : INTEGER is
	external "C"
	alias "c_ecurses_box"
	end     

feature -- window refresh

    wrefresh (w: POINTER): INTEGER is
	external "C"
	alias "c_ecurses_wrefresh"
	end
    
    wnoutrefresh (w: POINTER): INTEGER is
	external "C"
	alias "c_ecurses_wnoutrefresh"
	end
    
    doupdate: INTEGER is
	external "C"
	alias "c_ecurses_doupdate"
	end
    
    redrawwin (w: POINTER): INTEGER is
	external "C"
	alias "c_ecurses_redrawwin"
	end
    
    wredrawln (w: POINTER; x, y : INTEGER): INTEGER is
	external "C"
	alias "c_ecurses_wredrawln"
	end

    wtouchln (w: POINTER; y, x : INTEGER; changed: BOOLEAN): INTEGER is
	external "C"
	alias "c_ecurses_wtouchln"
	end

    touchwin (w: POINTER): INTEGER is
	external "C"
	alias "c_ecurses_touchwin"
	end

    is_wintouched (w: POINTER): INTEGER is
	external "C"
	alias "c_ecurses_is_wintouched"
	end

    is_linetouched (w: POINTER; line: INTEGER): INTEGER is
	external "C"
	alias "c_ecurses_is_linetouched"
	end


feature -- line/window deletion
    
    werase (w: POINTER): INTEGER is
	external "C"
	alias "c_ecurses_werase"
	end

    wclear (w: POINTER): INTEGER is
	external "C"
	alias "c_ecurses_wclear"
	end

    wclrtobot (w: POINTER): INTEGER is
	external "C"
	alias "c_ecurses_wclrtobot"
	end

    wclrtoeol (w: POINTER): INTEGER is
	external "C"
	alias "c_ecurses_wclrtoeol"
	end

    wdeleteln (w: POINTER; ): INTEGER is
	    -- Delete line at current cursor position, move lines up,
	    -- blank line at bottom of window.
	external "C"
	alias "c_ecurses_wdeleteln"
	end
	
    winsdelln (w: POINTER; n: INTEGER): INTEGER is
	    -- n > 0 : insert n blank lines above current cursor
	    --	 position, bottom n lines are lost
	    -- n < 0 : delete abs (n) lines starting at current cursor
	    --	 position, move remaining lines up, leave abs (n)
	    --	 blank lines at bottom of window
	external "C"
	alias "c_ecurses_winsdelln"
	end
	
    winsertln (p: POINTER): INTEGER is
	    -- Insert a blank line above current cursor position, 
	    -- bottom line is lost.
	external "C"
	alias "c_ecurses_winsertln"
	end

feature -- cursor movement

    wmove (w: POINTER; y, x: INTEGER): INTEGER is    
	external "C"
	alias "c_ecurses_wmove"
	end    

feature -- window scrolling

    scrollok (w: POINTER; b : BOOLEAN): INTEGER is
	external "C"
	alias "c_ecurses_scrollok"
	end
    
    wscrl (w: POINTER; n: INTEGER): INTEGER is
	    -- Scroll window n lines.
	    --    n > 0 : up
	    --    n < 0 : down
	external "C"
	alias "c_ecurses_wscrl"
	end  

feature -- overlaying

    overlay (win1, win2: POINTER): INTEGER is
	    -- overlay win1 with win2
	external "C"
	alias "c_ecurses_overlay"
	end
    
    overwrite (win1, win2: POINTER): INTEGER is
	    -- overlay win1 with win2
	external "C"
	alias "c_ecurses_overwrite"
	end
    
    copywin (win1, win2: POINTER; 
	     sminrow, smincol, dminrow, dmincol, dmaxrow, dmaxcol, overlay_num: INTEGER): INTEGER is
	    -- copy win1 with win2
	external "C"
	alias "c_ecurses_copywin"
	end

feature -- window queries

    getmaxx (w: POINTER) : INTEGER is
	external "C"
	alias "c_ecurses_getmaxx"
	end

    getmaxy (w: POINTER) : INTEGER is
	external "C"
	alias "c_ecurses_getmaxy"
	end

    --getmaxyx (w: POINTER; y, x : INTEGER) is
	--external "C"
	--alias "c_ecurses_getmaxyx"
	--end

    getbegx(w: POINTER) : INTEGER is
	external "C"
	alias "c_ecurses_getbegx"
	end


    getbegy (w: POINTER) : INTEGER is
	external "C"
	alias "c_ecurses_getbegy"
	end	-- getbegy

    c_cursor_x  (w : POINTER) : INTEGER is
	external "C"
	alias "c_ecurses_cursor_x"
    end

    c_cursor_y (w : POINTER) : INTEGER is
	external "C"
	alias "c_ecurses_cursor_y"
	end

    

end -- class CURSES_WINDOW_API
-----------------------------------------------------------
-- Copyright (C) 1999 Paul G. Crismer, Eric Fafchamps
-- Licensed under Eiffel Forum Freeware License, version 1
-- (see forum.txt)
-----------------------------------------------------------



