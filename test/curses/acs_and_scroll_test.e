indexing
	description: "ACS and scroll test";
	date: "$Date$";
	revision: "$Revision$"
	
class 
	ACS_AND_SCROLL_TEST
inherit
	SINGLE_TEST
		rename window as stdwin
		end

	CURSES_TEST_SUPPORT
		export
			{NONE}
				all
		end

	CURSES_KEY_CONSTANTS
		export
			{NONE}
				all
		end

creation
	make_from_window

feature -- Commandes

	execute is
			-- Execute le test.
		local
			c: INTEGER
		do
			!!windows.make

			stdwin.clear
			show_help
			curses.enable_raw_reading_mode
			curses.disable_echo
			stdwin.disable_leave_cursor

			from stdwin.read_character
			until
			     stdwin.last_character = 'q' or stdwin.last_character = 'Q'
			loop	
				if stdwin.last_character = 'w' or stdwin.last_character = 'W' then
					-- create window
					create_window
				elseif stdwin.last_character = 'n' or stdwin.last_character = 'N' then
					-- next window
					if current_window_index = windows.count then
						current_window_index := 1
					else
						current_window_index := current_window_index + 1
					end
					windows.go_i_th (current_window_index)
					windows.item.bring_to_front
					windows.item.redraw
					stdwin.refresh
				elseif stdwin.last_character = 'p' or stdwin.last_character = 'P' then
					--previous window
					if current_window_index = 1 then
						current_window_index := windows.count
					else
						current_window_index := current_window_index - 1
					end
					windows.go_i_th (current_window_index)
					windows.item.bring_to_front
					windows.item.redraw
					stdwin.refresh
				elseif stdwin.last_character = 'f' or stdwin.last_character = 'F' then
					-- scroll forward
					if current_window_index > 0 then
						windows.go_i_th (current_window_index)
						scroll_forward (windows.item)
					end
				elseif stdwin.last_character = 'b' or stdwin.last_character = 'B' then
					-- scroll backward
					if current_window_index > 0 then
						windows.go_i_th (current_window_index)
						scroll_backward (windows.item)
					end
				elseif stdwin.last_character = 'q' or stdwin.last_character = 'Q' then
					-- exit			
				elseif stdwin.last_key = Key_up then
				elseif stdwin.last_key = Key_down then
				elseif stdwin.last_key = Key_left then	
				elseif stdwin.last_key = Key_right then
				elseif stdwin.last_key = Key_backspace or stdwin.last_key = Key_DC then
				end
				stdwin.read_character
			end
		end

	show_help is
			-- show  help
		do
			stdwin.move(stdwin.height-3,0)
			stdwin.put_string (help_string);
			stdwin.refresh
			stdwin.refresh
		end

	windows : LINKED_LIST [CURSES_PANEL]
		
	help_string : STRING is " W = create window   N = next window      P = previous window%N%
				% F = scroll forward  B = scroll backward  Q = exit";

	create_window is
		local
			ul_y, ul_x, lr_y, lr_x : INTEGER
			p : CURSES_PANEL
		do
			stdwin.move (stdwin.height-1, 0)
			stdwin.put_string ("Upper left corner : move cursor and press a key");
			stdwin.move (0,0)
			stdwin.refresh
			get_point
			ul_y := last_y
			ul_x := last_x
			stdwin.move (last_y, last_x)
			stdwin.put_character ('*')
			stdwin.move (stdwin.height-1, 0)
			stdwin.put_string ("Lower right corner : move cursor and press a key");
			stdwin.move (last_y, last_x)
			stdwin.refresh
			get_point
			lr_y := last_y
			lr_x := last_x
			-- 
			if lr_y > ul_y and ul_x < lr_x then
				!!p.make (lr_y - ul_y +1 , lr_x - ul_x +1 , ul_y, ul_x)
				windows.extend (p)
				current_window_index := windows.count
				p.set_standard_border
				--p.set_border (('|').code, ('|').code, ('-').code, ('-').code,
				--	      ('*').code, ('*').code, ('*').code, ('*').code)
				p.refresh
				stdwin.move (stdwin.height-1, 0)
				stdwin.clear_to_end
				stdwin.refresh
			else
				stdwin.move (stdwin.height-1, 0)
				stdwin.put_string ("upper left corner not upper or lef than lower right !")
				stdwin.refresh
			end	
		end			

	last_x, last_y : INTEGER

	get_point is
		do
			from 
				stdwin.read_character
			until
				not stdwin.is_last_key_special
			loop
				if stdwin.last_key = Key_up and stdwin.cursor_y > 0 then
				   	stdwin.move (stdwin.cursor_y - 1, stdwin.cursor_x)
				elseif stdwin.last_key = Key_down and stdwin.cursor_y < stdwin.height-4 then
					stdwin.move (stdwin.cursor_y + 1, stdwin.cursor_x)
				elseif stdwin.last_key = Key_left and stdwin.cursor_x > 0 then
					stdwin.move (stdwin.cursor_y, stdwin.cursor_x - 1) 
				elseif stdwin.last_key = Key_right and stdwin.cursor_x < stdwin.width -1 then
					stdwin.move (stdwin.cursor_y, stdwin.cursor_x + 1)
				end
				stdwin.refresh
				stdwin.read_character
			end
			last_x := stdwin.cursor_x
			last_y := stdwin.cursor_y
		end

	scroll_forward (w : CURSES_WINDOW) is
		local
			i : INTEGER
		do
			w.enable_scrolling
			w.move (0,0)
			from i := 1 until i > w.height * 2
			loop
			    w.put_string ("The quick brown fox jumps over the lazy dog");
			    w.refresh
			    i := i + 1
			end
		end

	scroll_backward (w : CURSES_WINDOW) is
		local
			i : INTEGER
		do
			w.enable_scrolling
			from i := 1 until i > w.height * 2
			loop
			    w.move (0,0)
			    w.insert_n_string ("The quick brown fox jumps over the lazy dog", i);
			    w.scroll_down (1)
			    w.refresh
			    i := i + 1
			end
			
		end
	current_window_index : INTEGER

end -- class ACS_AND_SCROLL_TEST
-----------------------------------------------------------
-- Copyright (C) 1999 Paul G. Crismer, Eric Fafchamps
-- Licensed under Eiffel Forum Freeware License, version 1
-- (see forum.txt)
-----------------------------------------------------------
