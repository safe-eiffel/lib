indexing
	description: 	"Curses PAD abstraction.  A pad is a rectangular section %
		    	% on which one has a view through a window; this window usually%
		    	% is smaller than the pad";
	cluster: 	"ecurses, base"
    	interface: 	"client, classification"
    	status: 	"See notice at end of class"
    	date: 		"$Date$"
    	revision: 	"$Revision$"
    	author: 	"Paul G. Crismer, Eric Fafchamps"

class 
	CURSES_PAD

inherit
	CURSES_PAD_API
		export {NONE} all
		end

	CURSES_WINDOW
		redefine refresh, memory_refresh, height, width, origin_y, origin_x
		end

create
	make_pad, make_subpad

feature


	make_pad (p_height, p_width : INTEGER) is
		-- make a pad with a 'p_height' x 'p_width' capacity
	    do
		wptr := newpad (p_height, p_width)
		height := p_height
		width := p_width
		create subwindows.make
		post_creation_command		
	    ensure
		height = p_height
		width = p_width
		exists
	    end


	make_subpad (p_parent : CURSES_PAD; p_height, p_width, begin_y, begin_x : INTEGER) is
		-- make a subpad of 'p_parent', whose height and width are 'p_height' an 'p_widht'
		-- respectively.  Subpad upper left corner is at coordinates
		-- [begin_y, begin_x] of 'p_parent' pad.
	    do
		wptr := subpad (p_parent.wptr, p_height, p_width, begin_y, begin_x)
		height := p_height
		width := p_width
		create subwindows.make
		parent_window := p_parent;
		parent_window.attach_subwindow (Current)
		parent_window.touch (begin_y, p_height)
		post_creation_command
	    ensure
		height = p_height
		width = p_width
		exists
	    end

	refresh is
	    do
		refresh_pad (first_y, first_x,
			 view_upper_y, view_upper_x, view_lower_y, view_lower_x)
	    end

	memory_refresh is
	    do
		memory_refresh_pad (first_y, first_x,
			 view_upper_y, view_upper_x, view_lower_y, view_lower_x)
	    end

	set_view (pfirst_y, pfirst_x, pvupper_y, pvupper_x, pvlower_y, pvlower_x : INTEGER) is
			-- view pad content, with first character as [pfirst_y,pfirst_x]
			-- in a rectangle whose screen corners are 
			-- upper left = [pvupper_y, pvupper_x]; lower right = [pvlower_y, pvlower_x]
		do
			first_y := pfirst_y
			first_x := pfirst_x
			view_upper_y := pvupper_y
			view_upper_x := pvupper_x
			view_lower_y := pvlower_y
			view_lower_x := pvlower_x
		ensure
			first_y = pfirst_y
			first_x = pfirst_x
			view_upper_y = pvupper_y
			view_upper_x = pvupper_x
			view_lower_y = pvlower_y
			view_lower_x = pvlower_x			
		end


feature -- Status Report

	view_upper_y : INTEGER
		-- upper_left row index of view

	view_upper_x : INTEGER
		-- upper left column index of view

	view_lower_y : INTEGER
		-- lower right row index of view

	view_lower_x : INTEGER
		-- lower right column index of view

	first_y : INTEGER
		-- upper left row of first displayed elements

	first_x : INTEGER
		-- upper left column of first displayed elements

	height : INTEGER
		-- pad height

	width : INTEGER
		-- pad width

	origin_y : INTEGER
		-- origin relative to parent pad

	origin_x : INTEGER
		-- origin relative to parent pad
 
--   	subwindows : DS_LINKED_LIST[CURSES_PAD]
	
feature {NONE}
	refresh_pad (pad_row, pad_col,
		     s_minrow, s_mincol, s_maxrow, s_maxcol : INTEGER) is
		-- refresh the screen rectangle defined by [s_minrow, s_mincol],[s_maxrow, s_maxcol] by
		-- copying a pad's rectangle content whose upper left corner starts at pad_row, pad_col
		-- and update screen
	    do
		handle_curses_call (prefresh(wptr, pad_row, pad_col, s_minrow, s_mincol, s_maxrow, s_maxcol),
				    "prefresh")
	    end

	memory_refresh_pad (pad_row, pad_col,
		     s_minrow, s_mincol, s_maxrow, s_maxcol : INTEGER) is
		-- refresh the screen rectangle defined by [s_minrow, s_mincol],[s_maxrow, s_maxcol] by
		-- copying a pad's rectangle content whose upper left corner starts at pad_row, pad_col
		-- and update screen
	    do
		handle_curses_call (pnoutrefresh(wptr, pad_row, pad_col, s_minrow, s_mincol, s_maxrow, s_maxcol),
				    "prefresh")
	    end


end -- class CURSES_PAD
-----------------------------------------------------------
-- Copyright (C) 1999-2009 Paul G. Crismer, Eric Fafchamps
-- Licensed under Eiffel Forum Freeware License, version 2
-- (see forum.txt)
-----------------------------------------------------------


