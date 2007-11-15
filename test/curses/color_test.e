indexing
	description: "Color test pattern";
	date: "$Date$";
	revision: "$Revision$"

class 
	COLOR_TEST
inherit
	SINGLE_TEST

	CURSES_ATTRIBUTE_CONSTANTS
		export 
			{NONE} all
		end

create
	make_from_window

feature -- Commands

	execute is
			-- Execute the test
		local
			hello : STRING
			i : INTEGER
			base : INTEGER
			top : INTEGER
			width : INTEGER
		do
			!!hello.make(5)

			window.refresh
			window.put_string ("There are ")
			window.put_string (curses.maximum_color_pairs.out)
			window.put_string ("color pairs%N")
			
			if curses.maximum_colors > 8 then
				width := 4
				hello := "Test"
			else
				width := 8
				hello := "Hello"
			end

			from
				base := 0
			until 
				base >= 2
			loop
				if curses.maximum_colors > 8 then
					top := 0
				else
					top := base * (curses.maximum_colors + 3)
				end
				window.clear_to_bottom
				window.move (top + 1, 0)
				window.put_string (curses.maximum_colors.out)
				window.put_string ("x")
				window.put_string (curses.maximum_colors.out)
				window.put_string (" foreground/background colors, bright ")
				if base /= 0 then
					window.put_string ("*on*%N")
				else
					window.put_string ("*off*%N")
				end
				window.put_string ("%N")
			
				from
					i := 0
				until
					i >= curses.maximum_colors
				loop
					show_color_name (top + 2, (i + 1) * width, i)
					i := i + 1
				end

				from
					i := 0
				until
					i >= curses.maximum_colors
				loop
					show_color_name (top + 3 + i, 0, i)
					i := i + 1
				end

				from
					i := 1
				until
					i >= curses.maximum_color_pairs
				loop
					window.define_color_pair (i, i \\ curses.maximum_colors, i // curses.maximum_colors)
					window.use_color_pair (i)
					if base /= 0 then
						window.enable_attribute(Attribute_bold)
					end
					window.move (top + 3 + (i // curses.maximum_colors), (i \\ curses.maximum_colors + 1) * width)
					window.put_string (hello)
					window.set_attribute(Attribute_normal)
					i := i + 1
				end
				if curses.maximum_colors > 8 or base /= 0 then
					pause (window)
				end
				base := base + 1		
			end
			window.clear
		end

feature {NONE} -- Implementation

	show_color_name (y,x,color: INTEGER) is
		do
			window.move (y, x)
			if curses.maximum_colors > 8 then
				window.put_string (color.out)
			else
				window.put_string (color_name(color))
			end	
		end

end -- class COLOR_TEST
-----------------------------------------------------------
-- Copyright (C) 1999 Paul G. Crismer, Eric Fafchamps
-- Licensed under Eiffel Forum Freeware License, version 1
-- (see forum.txt)
-----------------------------------------------------------
