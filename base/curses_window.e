indexing
	description: 	"Curses Window abstraction";
	cluster: 	"ecurses, base"
    	interface: 	"client, classification"
    	status: 	"See notice at end of class"
    	date: 		"$Date$"
    	revision: 	"$Revision$"
    	author: 	"Paul G. Crismer, Eric Fafchamps"

class 
	CURSES_WINDOW

inherit
	CURSES_WINDOW_API
		export {NONE} all
		end

	SHARED_CURSES_SYSTEM

	CURSES_CHARACTER_CONSTANTS
		export {NONE} all
		end

	CURSES_ATTRIBUTE_CONSTANTS
		export {NONE} all
		end

	CURSES_KEY_CONSTANTS
		export {NONE} all
		end

	CURSES_COLOR_CONSTANTS
		export {NONE} all
		end

	CURSES_ERROR_HANDLING


	MEMORY
		export {NONE} all
		redefine
			dispose
		end

	KL_IMPORTED_INTEGER_ROUTINES --mixin
		export {NONE} all
		end

creation
	make , make_from_pointer, make_subwindow_absolute, make_subwindow_relative

feature {NONE} -- construction

    make_from_pointer (w : POINTER) is
		-- make from existing pointer (useful only for stdscr)
	require
	    window_exists: w /= default_pointer
	do
		wptr := w
		parent_window := Void
		!!subwindows.make
		post_creation_command
	ensure
	    exists: exists
	end -- make_from_pointer

    make (a_height, a_width, y, x : INTEGER) is
		-- make independent window
	require
	    positive_size: a_width >= 0 and a_height >= 0
	    positive_origin: y >= 0 and x >= 0
	    width_in_screen : curses.maximum_width >= a_width + x
	    height_in_screen: curses.maximum_height >= a_height + y
	do
	    parent_window := Void
	    !!subwindows.make
	    wptr := newwin(a_height, a_width, y, x)
	    post_creation_command          
	ensure
	    origin_set: origin_x = x and then origin_y = y
 	    size_set: width = a_width and then height = a_height
	    exists: exists
	end -- make

    make_subwindow_absolute ( parent : CURSES_WINDOW;
		a_height, a_width, y, x : INTEGER) is
		-- make subwindow with absolute origin coordinates
		-- the subwindow shares the output memory of the parent
	require
	    window_exists: parent /= Void
	    positive_size: a_width >= 0 and a_height >= 0
	    positive_origin: x >= 0 and y >= 0
	    inside_parent_origin : y >= parent.origin_y and x >= parent.origin_x
	    inside_parent_size: parent.width >= a_width and parent.height >= a_height
	    width_in_screen : curses.maximum_width >= a_width + x
	    height_in_screen: curses.maximum_height >= a_height + y
	do
	    parent_window := parent
	    wptr := subwin(parent.wptr, a_height, a_width, y, x)
	    !!subwindows.make
	    parent.attach_subwindow (Current)
	    parent.touch(y - parent.origin_y, a_height)
	    post_creation_command
	ensure
	    parent_set: parent_window = parent
	    origin_set: origin_x = x and then origin_y = y
 	    size_set: width = a_width and then height = a_height
	    exists: exists
	end -- make_subwindow_absolute

    make_subwindow_relative ( parent : CURSES_WINDOW;
		a_height, a_width, y, x : INTEGER) is
		-- make subwindow with origin coordinates relative to parent window
		-- the subwindow shares the output memory of the parent
	require
	    window_exists: parent /= Void
	    positive_size: a_width >= 0 and a_height >= 0
	    positive_origin: x >= 0 and y >= 0
	    inside_parent_size : parent.width >= a_width and parent.height >= a_height
	    width_in_parent : parent.width >= a_width + x
	    height_in_parent: parent.height >= a_height + y
	do
	    parent_window := parent
	    wptr := derwin(parent.wptr, a_height, a_width, y, x)
	    !!subwindows.make
	    parent.attach_subwindow (Current)
	    parent.touch(y, a_height)
	    post_creation_command
	ensure
	    parent_set: parent_window = parent
	    origin_set: origin_x = x + parent_window.origin_x and then origin_y = y + parent_window.origin_y
 	    size_set: width = a_width and then height = a_height
	    exists: exists
	end -- make_subwindow_relative

    post_creation_command is
	    do
		on_create
	    end

feature -- events processing

    on_create is
	    -- automatically called after window has been created
	do 
		enable_metacharacters
		enable_keypad
		enable_leave_cursor		
	end

    on_close is
	    -- automatically called before window is closed		
	do
	end
			
feature -- destruction

    close is
	    -- closes this window
	require
	    exists: exists
	do
	    -- first, delete all subwindows
	    from subwindows.start
	    until subwindows.off
	    loop
			if subwindows.item_for_iteration /= Void then 
				if subwindows.item_for_iteration.exists then
				       subwindows.item_for_iteration.close
		    	    end 
			end
			subwindows.forth
	    end
	    subwindows.wipe_out
 
		-- touch parent window (for refreshing purpose)
	    if parent_window /= Void then
		parent_window.touch(origin_y, height)
	    end

	    -- event processing
	    on_close
 
	    -- actually delete the Curses window
	    delete_window

		-- !!! from this point, do not execute any query or command on Current object !!!
		-- since the wptr is invalidated


	    -- ensure postcondition
	    closed := True
	ensure
		closed
	end

feature -- window positioning

    move_window (y, x: INTEGER) is
	    -- Move the current window to specific `x, y' position.
	require
	    exists: exists
	    not_a_subwindow: parent_window = Void
	    width_in_screen : curses.maximum_width >= width + x
	    height_in_screen: curses.maximum_height >= height + y
	do
	    handle_curses_call(mvwin (wptr , y, x), "mvwin")
	ensure
	    origin_set: origin_x = x and then origin_y = y
	end

feature -- screen control


    refresh is
	    	-- refresh the display (copy 'curses memory' to display)
		-- similar to 'memory_refresh' followed by 'do_update'
	require
	    exists: exists
	do
	    handle_curses_call(wrefresh (wptr),"wrefresh")
	end


    memory_refresh is
		-- refresh window in 'curses memory', nothing happens on display
	require
	    exists: exists
	do
	    handle_curses_call (wnoutrefresh(wptr), "wnoutrefresh")
	end


    do_update is
		-- apply all 'curses memory' changes on display
	require
	    exists: exists
	do
	    handle_curses_call(doupdate, "dopudate")
	end


    touch(y, n : INTEGER) is
	    -- touch window lines [y, y+n-1] those lines will be
	    -- redrawn when the next 'refresh' occurs
	require
	    exists: exists
	do
		handle_curses_call(wtouchln(wptr, y, n, True),"wtouchln")
	end

    untouch(y, n : INTEGER) is
		-- consider lines [y, y+n-1] as untouched
	require
	    exists: exists
	do
		handle_curses_call(wtouchln(wptr, y, n, False), "wtouchln")
	end

    is_line_touched (y : INTEGER) : BOOLEAN is
		-- is line 'y' touched ?
	require
		exists: exists
		y_valid: y >= 0 and y <= height
	do
		handle_curses_call (is_linetouched (wptr, y), "is_linetouched")
		Result := last_error = 1
	end

     is_touched : BOOLEAN is
		-- is entire window touched ?
	require
		exists: exists
	do
		handle_curses_call (is_wintouched (wptr), "is_touched")
		Result := last_error = 1
	end

feature -- general status

    keypad_enabled : BOOLEAN

    leave_cursor_enabled : BOOLEAN

    metacharacters_enabled : BOOLEAN

    auto_update : BOOLEAN


feature -- general status setting

    enable_keypad is
	    -- Turn on the terminal keypad.
	require
	    exists: exists
	do
	    handle_curses_call(keypad (wptr, True),"keypad")
	    keypad_enabled := True
	ensure
	    enabled_keypad: keypad_enabled
	end

    disable_keypad is
	    -- Turn off the terminal keypad.
	require
	    exists: exists
	do
	    handle_curses_call(keypad (wptr, False),"keypad")
	    keypad_enabled := False
	ensure
	    enabled_keypad: not keypad_enabled
	end

    enable_leave_cursor is
		-- cursor is left where it is
	require
		exists: exists
	do
		handle_curses_call (leaveok(wptr, True),"leaveok")
		leave_cursor_enabled := True
	ensure
		leave_cursor_enabled
	end

    disable_leave_cursor is
		-- cursor follows window output operations
	require
		exists: exists
	do
		handle_curses_call (leaveok(wptr, False),"leaveok")
		leave_cursor_enabled := False
	ensure
		not leave_cursor_enabled
	end

    enable_metacharacters is
		-- do translate escape sequences to characters like function keys, etc...
	require
		exists: exists
	do
		handle_curses_call (meta(wptr, True),"meta")
	end

    disable_metacharacters is
		-- does not translate escape sequences to metacharacters
	require
		exists: exists
	do
		handle_curses_call (meta(wptr, False),"meta")
	end

    enable_auto_update is
	    -- enable automatic screen update
	require
	    exists: exists
	do
	    immedok (wptr, True)
	    auto_update := True
	ensure
	    enabled_auto_update : auto_update
	end

    disable_auto_update is
	    -- disable automatic screen update
	require
	    exists: exists
	do
	    immedok (wptr, False)
	    auto_update := False
	ensure
	    disabled_auto_update: not auto_update
	end

    enable_blocking_input is
	    -- block on input operations
	    -- can be
	require
	    exists: exists
	do
		handle_curses_call(nodelay (wptr, False), "nodelay")
	end

    disable_blocking_input is
	   -- do not block on input operations
	require
	    exists: exists
	do
		handle_curses_call (nodelay (wptr, True), "nodelay")
	end

    set_blocking_input_timeout( t : INTEGER) is
		-- set blocking timeout as 't' milliseconds
		-- '-1' = illimited
		-- '0'  = no blocking 
	require
	    exists: exists
	    valid_timeout : t >= -1
	do
		wtimeout(wptr, t)
	end
		

feature -- cursor positioning

    move (y, x: INTEGER) is
	    -- Move cursor to line y and column x
	require
	    x_in_bounds: x >= 0 and x < width;
	    y_in_bounds: y >= 0 and y < height;
	    exists: exists
	do
	    handle_curses_call(wmove (wptr, y, x), "wmove")
	ensure
		cursor_x = x and cursor_y = y
	end


    cursor_x : INTEGER is
		-- current x cursor position
	require
	    exists: exists
	do
		Result := c_cursor_x (wptr)
	end

    cursor_y : INTEGER is
		-- current y cursor position
	require
	    exists: exists
	do
		Result := c_cursor_y (wptr)
	end

feature -- color handling

    is_color_used : BOOLEAN is
	do
		Result := curses.is_color_used
	end

    define_color_pair ( pair_nr, fore_col, back_col : INTEGER) is
	require
		color_used: is_color_used
		pair_number_ok: pair_nr > 0 and pair_nr <= curses.maximum_color_pairs
		fore_color_ok: fore_col >= 0 and fore_col <= curses.maximum_colors
		back_color_ok: back_col >= 0 and back_col <= curses.maximum_colors
	do
	      curses.define_color_pair ( pair_nr, fore_col, back_col)
	end 

    use_color_pair (n: INTEGER) is
	    -- use color pair 'n' as current one
	require
	    exists: exists
	    is_color_used: is_color_used
	    color_pair_ok: n >= 0 and n <= curses.maximum_color_pairs
	do
	    disable_attribute (current_color_pair)
	    enable_attribute(color_pair(n));
	end


feature -- window status

    width : INTEGER is
	require
	    exists: exists
	do
	    Result := getmaxx(wptr)
	end

    height : INTEGER   is
	require
	    exists: exists
	do
	    Result := getmaxy(wptr)
	end

    origin_x : INTEGER   is
		-- column coordinate of upper left corner
	require
	    exists: exists
	do
	    Result := getbegx(wptr)

	end

    origin_y : INTEGER   is
		-- row coordinate of upper left corner
	require
	    exists: exists
	do
	    Result := getbegy(wptr)

	end

    parent_window : CURSES_WINDOW

    subwindows : DS_LINKED_LIST[like Current]
	
    last_character : CHARACTER is
	do
		Result := INTEGER_.to_character(last_key \\ 256)
	end 

    last_key : INTEGER

    last_string : STRING

    is_last_key_special : BOOLEAN is
		-- is last_key a special one ?
	do
		Result := last_key >= key_min and last_key <= key_max
	end

    exists : BOOLEAN is
		-- does the window exist ?
	do
		Result := (wptr /= default_pointer)
	end

    closed : BOOLEAN
		-- is the window closed?

    current_attributes : INTEGER is
		-- Current attributes applied to every character written
	require
	    exists: exists
	do
	    Result := getattrs(wptr)
	end

    current_attribute : INTEGER is
		-- Current attribute applied to every character written
	obsolete "Use 'current_attributes' (plural) instead"
	require
	    exists: exists
	do
	    Result := getattrs(wptr)
	end

    current_background : INTEGER is
		-- Current background (character + attributes + color_pair)
	do
	    Result := getbkgd (wptr)    
	ensure
	    Result = current_background_character.code + current_background_attributes
	end

    current_background_character : CHARACTER is
		-- Current background character
	do
	    Result := INTEGER_.to_character(current_background \\ 256)
	end

    current_background_attributes : INTEGER is
		-- Current background attribute + color_pair
	do
	    Result := current_background - current_background_character.code
	end

    set_current_background (n : INTEGER) is
		-- Set current background with 'n' (character + attributes + color_pair)
	do
		wbkgdset(wptr, n)
	end

    apply_current_background is
		-- Apply current background to the whole window
	do
		handle_curses_call (wbkgd (wptr, current_background),"wbkgd")	    
	end 

    set_background (c : CHARACTER; attr, pair : INTEGER) is
		-- Set background character as 'c' decorated with
		-- 'attr' attributes and 'pair_number' color_pair
		-- and applies it to the whole window
	require
		pair_strict_positif: pair > 0
	do
		set_current_background ( c.code + attr + color_pair (pair) )
		apply_current_background
	end
 
feature  -- window output

    put_character (ch: CHARACTER) is
	    -- put character at current cursor position.
	require
	    exists: exists
	do
	    handle_curses_call(waddch(wptr, ch.code),"waddch")
	end

    put (attchar : INTEGER) is
			-- put attributed character 'attchar' at current cursor position
	require
	    exists: exists
	do
	    handle_curses_call(waddch(wptr, attchar),"waddch")
	end


    put_string (str: STRING) is
	    -- put string at current cursor position
	require
	    string_exists: str /= Void;
	    exists: exists
	local
		tools: CURSES_EXTERNAL_TOOLS
	do
		handle_curses_call(waddstr (wptr, tools.string_to_pointer(str)),"waddstr")
	end

    put_n_string (str: STRING; n: INTEGER) is
	    -- put at most n characters from string at current cursor position
	require
	    exists: exists
	    string_exists: str /= Void;
	    valid_range: n >= 0 
	local
		tools: CURSES_EXTERNAL_TOOLS
	do
		handle_curses_call(waddnstr (wptr, tools.string_to_pointer(str),n),"waddnstr")
	end

    insert_character (ch: CHARACTER) is
	    -- insert 'ch' at the current cursor position, shifting characters
	    -- right of current cursor position to the right (no line wrapping)
	    -- cursor position does not change
	require
	    exists: exists
	do
	    handle_curses_call(winsch(wptr, ch.code),"winsch")
	end

    insert (attchar : INTEGER) is
	    -- insert attributed character 'attchar' at the current cursor position, shifting characters
	    -- right of current cursor position to the right (no line wrapping)
	    -- cursor position does not change	require
	require
	    exists: exists
	do
	    handle_curses_call(winsch(wptr, attchar),"winsch")
	end
		
    insert_string (str: STRING) is
	    -- insert 'str' at the current cursor position, shifting characters
	    -- right of current cursor position to the right (no line wrapping)
	    -- cursor position does not change
	require
	    string_exists: str /= Void;
	    exists: exists
	local
		tools: CURSES_EXTERNAL_TOOLS
	do
	    handle_curses_call(winsstr (wptr, tools.string_to_pointer(str)), "winsstr")
	end
	
    insert_n_string (str: STRING; n: INTEGER) is
	    -- insert at most 'n' characters of 'str' at the current cursor position, shifting characters
	    -- right of current cursor position to the right (no line wrapping)
	    -- cursor position does not change
	require
	    exists: exists
	    string_exists: str /= Void;
	    valid_range: n >= 0
	local
		tools: CURSES_EXTERNAL_TOOLS
	do
	    handle_curses_call(winsnstr (wptr, tools.string_to_pointer(str), n), "winsnstr")
	end
	
    delete_character is
	    -- delete one character at current cursor position.
	require
	    exists: exists
	do
	    handle_curses_call(wdelch (wptr), "wdelch")
	end

    delete_line is
	    -- delete line at current cursor position
	    -- the following lines are moved up,
	    -- line at bottom of window is blanked.
	require
	    exists: exists
	do
	    handle_curses_call(wdeleteln (wptr), "wdeleteln")

	end

    insert_line is
	    -- insert a blank line above the line at current cursor position,
	    -- scrolling down the following lines
	require
	    exists: exists
	do
	    handle_curses_call(winsertln (wptr), "winserltn")
	end

    insert_multiple_lines (n: INTEGER) is
	    -- insert 'n' blank lines above the line at cursor position, scrolling down the following lines.
	    -- 'n' bottom lines are lost. cursor does not move
	require
	    exists: exists
	    within_bounds: n >= 0 and then n <= height
	do
	    if n /= 0 then
		handle_curses_call(winsdelln (wptr, n), "winsdelln")
	    end
	end

    delete_multiple_lines (n: INTEGER) is
	    -- delete 'n' lines starting at current cursor position,
	    -- moving the remaining lines up.  bottopm 'n' lines are cleared
	    -- cursor does not move
	require
	    exists: exists
	    within_bounds: n >= 0 and then n <= height
	do
	    if n /= 0 then
		handle_curses_call(winsdelln (wptr, -n), "winsdelln")
	    end
	end
	    
    clear_to_end is
	    -- clear window from current cursor position to end of line.
	require
	    exists: exists
	do
	    handle_curses_call(wclrtoeol (wptr), "wclrtoeol")
	end

    clear is
	    -- clear the entire window by putting blank (background) characters
	    -- in every character cell
	    -- (curses equivalent : 'werase')
	require
	    exists: exists
	do
	    handle_curses_call(werase (wptr), "werase")
	end

    clear_and_redraw_screen is
	    -- clears the entire window and redraws the entire screen
	    -- from scratch when the next call to 'refresh' occurs
	    -- (curses equivalent :'wclear')
	require
	    exists: exists
	do
	    handle_curses_call(wclear (wptr), "wclear")
	end


    clear_to_bottom is
	    -- clear the window from the current cursor position to bottom of window.
	require
	    exists: exists
	do
	    handle_curses_call(wclrtobot (wptr), "wclrtobot")
	end

feature -- window scrolling

    set_scroll_region (top, bottom: INTEGER) is
	    -- Set software scrolling region (in lines) for window.
	require
	    exists: exists
	    top_in_bounds: top >= 0 and top < height;
	    bottom_in_bounds: bottom >= 0 and bottom < height;
	    order: top < bottom;
	do
	    handle_curses_call(wsetscrreg (wptr, top, bottom) , "wsetscrreg")
	end

   enable_scrolling is
	    -- Enable vertical scrolling.
	require
	    exists: exists
	do
	    handle_curses_call(scrollok (wptr, True), "scrollok")
	    scrolling_enabled := true;
	end

    disable_scrolling is
	    -- Disable vertical scrolling.
	require
	    exists: exists
	do
	    handle_curses_call(scrollok (wptr, False), "scrollok")
	    scrolling_enabled := false
	end
    	    
    scrolling_enabled: BOOLEAN;
	    -- Is vertical scrolling enabled?


    scroll_up (n : INTEGER) is
	    -- scroll up 'n' lines
	require
	    exists: exists
 	    positive_n: n >= 0
	do
		handle_curses_call(wscrl(wptr,n), "wscrl")
	end

    scroll_down (n : INTEGER) is
	    -- scroll down 'n' lines
	require
	    exists: exists
	    positive_n: n >= 0
	do
		handle_curses_call(wscrl(wptr,-n), "wscrl")
	end

feature -- window input

    read_character is
	    -- Read a character (with attributes) from standard input.
	require
	    exists: exists
	do
	    last_key := wgetch (wptr);
	    handle_curses_call(last_key, "wgetch")
	end;

    read_line is
	    -- Read a line up to carriage return and/or linefeed
	    -- echoing at current cursor position
	require
	    exists : exists
	local
		line : STRING
		lptr : POINTER
		tools: CURSES_EXTERNAL_TOOLS
	do
		if last_string = Void then
			!!last_string.make (0)
		end
		!!line.make(256)
		lptr := tools.string_to_pointer (line)
		handle_curses_call (wgetnstr (wptr, lptr, 255), "wgetnstr")
		last_string := tools.pointer_to_string (lptr)
	end
       
feature -- color status

    current_color_pair : INTEGER is
	do
		Result := pair_number (current_attributes)		
	end -- current_color_pair

    foreground_color : INTEGER is
		-- foreground color number (to test with one of the CURSES_COLOR_CONSTANTS)
	do
		if is_color_used then
			pair_content (current_color_pair, $f, $g)
			Result := f
		else
			Result := COLOR_WHITE
		end
	end

    background_color : INTEGER is
		-- background color number (to test with one of the CURSES_COLOR_CONSTANTS)
	do
		if is_color_used then
			pair_content (current_color_pair, $f, $g)
			Result := g
		else
			Result := COLOR_BLACK
		end
	end


feature -- Line and border drawing


    set_standard_border is
		-- draw a border, trying to find 'nice' characters
	require
	    exists: exists
	do
		set_border (0,0,0,0,0,0,0,0)
	end

    set_border (ls, rs, ts, bs, tl, tr, bl, br: INTEGER) is
		-- draw border around the edges of window using character and attribute combinations
		-- for sides (left, right, top, bottom) : 'ls', 'rs', 'ts', 'bs'
		-- for corners (top left, top right, bottom left, bottom right) : 'tl', 'tr', 'bl', 'br'
		-- if 0, tries to find a nice character
	require
	    exists: exists
	do
		handle_curses_call(wborder(wptr, ls, rs, ts, bs, tl, tr, bl, br), "wborder")
	end

    draw_h_line (ch, n : INTEGER) is
		-- draw horizontal line from current cursor position,
		-- 'n' characters long, using 'ch' as symbol (character and attribute combination) 
	require
	    exists: exists
	    positive_length: n > 0
	do
		handle_curses_call(whline(wptr, ch, n), "whline")
	end

    draw_v_line (ch, n : INTEGER) is
		-- draw vertical line from current cursor position,
		-- 'n' characters long, using 'ch' as symbol (character and attribute combination) 
	require
	    	exists: exists
		positive_length: n > 0
	do
		handle_curses_call(wvline(wptr, ch, n), "wvline")
	end
	
feature --  Attribute setting

    enable_attribute ( a : INTEGER ) is
		-- set current window attribute with 'a' without affecting other attributes
	require
	    exists: exists
	do
		handle_curses_call(wattron(wptr, a), "wattron")
	end

    disable_attribute ( a : INTEGER ) is
		-- disable attribute 'a' from current window attribute without affecting other attributes
	require
	    exists: exists
	do
		handle_curses_call(wattroff(wptr, a), "wattroff")
	end

    set_attribute ( attrs : INTEGER) is
		-- set current attributes to 'attrs', losing previous attributes
	obsolete "Use 'set_attributes' instead"
	require
	    exists: exists
	do
		set_attributes (attrs)
	end 

    set_attributes ( attrs : INTEGER) is
		-- set current attributes to 'attrs', losing previous attributes
	require
	    exists: exists
	do
		handle_curses_call(wattrset(wptr, attrs), "wattrset")
	end

    change_n_attribute_and_color (n, attr, color : INTEGER) is
		-- from current cursor position, change aspect of 'n' characters by
		-- applying attributes 'attr' and 'color'
	require
	    	exists: exists
		n_positive: n >= 0
	do
		handle_curses_call(wchgat(wptr,  n, attr, color, default_pointer), "wchgat")
	end

feature -- Operations

    beep is
	    -- Beep the bell, or if not possible flash the screen.
	do
	    handle_curses_call(api_beep,"beep")
	end
		
    flash is
	    -- Flash the screen, or if not possible beep the bell.
	do
	    handle_curses_call(api_flash , "flash")
	end

feature {CURSES_WINDOW} -- protected

    detach_subwindow (w : like Current) is
	require
	    	exists: exists
		window_ok : w /= Void
		is_subwindow : subwindows.has (w)
	do
	    subwindows.delete(w)
	end

    attach_subwindow (w : like Current) is
	require
	    exists: exists
	    window_ok : w /= Void
	    new_subwindow : not subwindows.has (w)
	do
	    subwindows.force_last(w)
	ensure
	    subwindow_attached: subwindows.has (w)
	end

    wptr : POINTER
	    -- Curses window pointer

    dispose is
		-- free up memory
	do
	    if exists then
		close
	    end
	end

   delete_window is
		-- delete curses window
	require
	    exists: exists
	do
	    	handle_curses_call (delwin(wptr), "delwin")
		wptr := default_pointer
	ensure
		not exists
	end

    f, g : INTEGER
		-- Temporary attributes used as $f and $g in features (SmallEiffel does not allow to use $ on local variable)

invariant

	window_exists : exists implies not closed

end -- class CURSES_WINDOW
-----------------------------------------------------------
-- Copyright (C) 1999 Paul G. Crismer, Eric Fafchamps
-- Licensed under Eiffel Forum Freeware License, version 1
-- (see forum.txt)
-----------------------------------------------------------


