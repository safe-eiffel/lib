indexing
	description: "Character attribute test";
	date: "$Date$";
	revision: "$Revision$"

class 
	ATTR_TEST
inherit
	SINGLE_TEST

	CURSES_TEST_CONSTANTS
		export
			{NONE} 
				all
		end

	CURSES_ATTRIBUTE_CONSTANTS
		export
			{NONE} 
				all
		end

	CURSES_COLOR_CONSTANTS
		export 
			{NONE} 
				all
		end
	
creation
	make_from_window

feature -- Commands

	execute is
			-- Execute the test
		local
			
		do
			from
				n := 0
				foreground := Color_white
				background := Color_black			
				do_test
			until
				not attr_getc 
			loop
				do_test
			end
			
			window.set_current_background (Attribute_normal + Blank.code)
			window.clear						
		end


feature {NONE} -- Implementation
	
	n : INTEGER

	foreground : INTEGER

	background : INTEGER

	do_test  is
		local
			row : INTEGER
			pair : INTEGER
		do
			row := 2
			if curses.is_color_used then
				pair := foreground * curses.maximum_colors + background
				if pair /= 0 then
					window.define_color_pair (pair, foreground, background)
					window.use_color_pair (pair)
				end	
			end
			if (pair /= 0) then
				window.set_background (' ', Attribute_normal, pair)
			end

			window.clear	

			window.move (0, 20)
			window.put_string ("Character attribute test display")
		
			row := show_attr (row, n, Attribute_standout, "STANDOUT", True)
			row := show_attr (row, n, Attribute_reverse, "REVERSE", True)
			row := show_attr (row, n, Attribute_bold, "BOLD", True)
			row := show_attr (row, n, Attribute_underline, "UNDERLINE", True)
			row := show_attr (row, n, Attribute_dim, "DIM", True)
			row := show_attr (row, n, Attribute_blink, "BLINK", True)
			row := show_attr (row, n, Attribute_protected, "PROTECT", True)
			row := show_attr (row, n, Attribute_invisible, "INVIS", True)
			row := show_attr (row, n, Attribute_normal, "NORMAL", False)
			
			window.move (row + 1, 8)
			window.put_string ("Enter a digit to set gaps on each side of displayed attributes")
			window.move (row + 2, 8)
			window.put_string ("^L = repaint")
			if curses.is_color_used then
				window.put_string (".  f/F/b/B toggle colors (now ")
				window.put_string (foreground.out)
				window.put_string ("/")
				window.put_string (background.out)
				window.put_string (")")
			end
		
			window.refresh
		
		end

	show_attr (row, skip, attr: INTEGER; name: STRING; only_once: BOOLEAN): INTEGER is
		do
			window.move (row, 8)
			window.put_string (name)
			window.put_string (" mode:")
			window.move (row, 24)
			window.put_string ("|")
			if skip /= 0 then
				window.put_n_string ("          ", skip)
			end
			if only_once then
				window.enable_attribute (attr)
			else
				window.set_attribute (attr)
			end
			window.put_string ("abcde fghij klmno pqrst uvwxy z")
			if only_once then
				window.disable_attribute (attr)
			end
			if skip /= 0 then
				window.put_n_string ("          ", skip)
			end
			window.put_string ("|")
			
			-- N/A : termattrs is not available

			Result := row + 2
		end


	attr_getc :BOOLEAN is
		local
			ch : CHARACTER
			
			zero_character: CHARACTER
		do
			zero_character := '0'
			window.read_character
			ch := window.last_character
			if ch.is_digit then
				n := ch.code - (zero_character.code)
				Result := True
			else if window.last_key = ctrl('L') then
				window.touch (0, curses.maximum_height)
				Result := True
				else if curses.is_color_used then
					inspect 
						ch
					when 'f' then
						foreground := foreground + 1
						Result := True
					when 'F' then
						foreground := foreground - 1
						Result := True
					when 'b' then
						background := background + 1
						Result := True
					when 'B' then
						background := background - 1
						Result := True
					else
						Result := False
					end
			
					if foreground >= curses.maximum_colors then
						foreground := 0
					end	
					if foreground < 0 then
						foreground := curses.maximum_colors - 1
					end
					if background >= curses.maximum_colors then
						background := 0
					end
					if background < 0 then
						background := curses.maximum_colors - 1
					end
				end
			    end
			end
		end
	
end -- class ATTR_TEST
-----------------------------------------------------------
-- Copyright (C) 1999 Paul G. Crismer, Eric Fafchamps
-- Licensed under Eiffel Forum Freeware License, version 1
-- (see forum.txt)
-----------------------------------------------------------
