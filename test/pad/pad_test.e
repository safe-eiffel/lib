indexing
	description: "eCurses Hello World'"
	version: "$Revision$"
	date:	"$Date$"
	Author: "Paul G. Crismer"
class
	PAD_TEST	

inherit
	CURSES_APPLICATION

creation
	make

feature
	make is
		local
			i, j, grid_count : INTEGER
			k : expanded CURSES_KEY_CONSTANTS
		do
			initialize
			!!p.make_pad (200,200)
			p.enable_metacharacters
			p.enable_keypad
			curses.disable_echo
			curses.set_cursor_visibility (0)
			p.enable_leave_cursor
			from i:= 0
			until i = 200
			loop
				from j := 0
				until j = 200
				loop
					if i \\ 20 = 0 and j \\ 20 = 0 then
						if i = 0 or j = 0 then
							p.put_character ('+')
						else
							p.put( (('A').code + (grid_count \\ 26)) )
						end
					elseif i \\ 20 = 0 then
						p.put_character ('-')
					elseif j \\ 20 = 0 then
						p.put_character ('|')
					else
						p.put_character (' ')
					end
					grid_count := grid_count + 1
					j := j + 1
				end
				i := i + 1
			end
			p.set_view (0, 0, 0, 0, 20, 50);
			p.memory_refresh
			p.beep
			standard_window.memory_refresh
			standard_window.do_update
			from
				p.read_character
			until
				p.last_character = 'q'
			loop
				if p.last_key = k.key_down then
					if p.first_y < p.height - (20) then
						p.set_view (p.first_y+1, p.first_x, p.view_upper_y, p.view_upper_x, p.view_lower_y, p.view_lower_x)
					end
				elseif p.last_key = k.key_up then
					if p.first_y > 0 then
						p.set_view (p.first_y-1, p.first_x, p.view_upper_y, p.view_upper_x, p.view_lower_y, p.view_lower_x)
					end
				elseif p.last_key = k.key_left then
					if p.first_x > 0 then
						p.set_view (p.first_y, p.first_x-1, p.view_upper_y, p.view_upper_x, p.view_lower_y, p.view_lower_x)
					end
				elseif p.last_key = k.key_right then
					if p.first_x < p.width - (50) then
						p.set_view (p.first_y, p.first_x+1, p.view_upper_y, p.view_upper_x, p.view_lower_y, p.view_lower_x)
					end
				elseif p.last_key = k.key_npage then
					if p.first_y < p.height - (20) then
						p.set_view (p.first_y+20, p.first_x, p.view_upper_y, p.view_upper_x, p.view_lower_y, p.view_lower_x)
					end
				elseif p.last_key = k.key_ppage then
					if p.first_y > 20 then
						p.set_view (p.first_y-20, p.first_x, p.view_upper_y, p.view_upper_x, p.view_lower_y, p.view_lower_x)
					end
				end
				p.memory_refresh
				standard_window.refresh
				p.read_character
			end

		end


	p : CURSES_PAD
		
end -- class PAD_TEST
-------------------------------------------------------
-- Copyright 1999 Paul G. Crismer, Eric Fafchamps
-- Released under the Eiffel Forum free license
-------------------------------------------------------
-- $Log$
-- Revision 1.1.1.1  2000/01/07 11:33:35  pgcrism
-- Initial checkin
--
--
	
