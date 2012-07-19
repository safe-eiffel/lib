indexing
	description: "Rough (raw?) translation of 'ncurses' test";

class NCURSES

inherit
	CURSES_APPLICATION

	CURSES_TEST_CONSTANTS
		export 
			{NONE}
				all;
		end;

	CURSES_TEST_SUPPORT
		export
			{NONE}
				all;
		end;

create
	make

feature

	make is
		local
			command: CHARACTER
		do
			-- We must initialise the curses data structure only once
			initialize

			if curses.has_colors then
				curses.use_colors
			end
			
			--standard_window.set_background(Blank, 0 ,0)

			from
				command := '0'
			until
				command = 'q'
			loop
				standard_window.clear
				standard_window.move (0, 0); standard_window.put_string ("This is the ecurses capability tester.")
				standard_window.move (1, 0); standard_window.put_string ("You may select a test from the main menu by typing the")
				standard_window.move (2, 0); standard_window.put_string ("key letter of the choice (the letter to the left of the = )")
				standard_window.move (3, 0); standard_window.put_string ("at the > prompt. The commands 'x' or 'q' will exit.")
				standard_window.move (4, 0); standard_window.put_string ("*************************************");
				standard_window.move (5, 0); standard_window.put_string ("a = keyboard and mouse (N/A) input test")
				standard_window.move (6, 0); standard_window.put_string ("b = character attribute test")
				standard_window.move (7, 0); standard_window.put_string ("c = color test pattern")
				--standard_window.put_string ("d = edit RGB color values(N/A)")
				--standard_window.put_string ("e = exercice soft keys")
				standard_window.move (8, 0); standard_window.put_string ("f = display ACS characters")		
				standard_window.move (9, 0); standard_window.put_string ("g = display windows and scrolling")
				--standard_window.put_string ("i = test of flushinp()")
				--standard_window.move (10, 0); standard_window.put_string ("k = display character attributes")
				--standard_window.put_string ("m = menu code test (N/A)")
				--standard_window.put_string ("o = exercise panels library")	
				--standard_window.put_string ("p = exercise pad features")
				standard_window.move (10, 0); standard_window.put_string ("q = quit")
				--standard_window.put_string ("r = exercise forms code (N/A)")
				--standard_window.put_string ("s = overlapping-refresh test")
				--standard_window.put_string ("t = set trace level")
				standard_window.move (12, 0); standard_window.put_string ("> ")

				standard_window.read_character

				command := standard_window.last_character

				do_single_test (command)
			end			
	end


feature {NONE} -- Implementation

	do_single_test (a_command: CHARACTER) is
			-- Do a single test
		local
			test: SINGLE_TEST
			finish: BOOLEAN
			valid: BOOLEAN
		do	
			valid := True
			inspect 
				a_command	
			when 'a' then
				create {GETCH_TEST} test.make_from_window (standard_window)					
			when 'b' then
				create {ATTR_TEST} test.make_from_window(standard_window)
			when 'c' then
				if curses.has_colors then
					create {COLOR_TEST} test.make_from_window(standard_window)
				else
					cannot (standard_window, "does not support color.")
					valid := False
				end
			when 'f' then
				create {ACS_TEST} test.make_from_window(standard_window)
			when 'g' then
				create {ACS_AND_SCROLL_TEST} test.make_from_window(standard_window)
			when 'q', '?' then
				finish := True
			else
				valid := False	
			end
			if not finish and valid then
				test.execute
			end
				
		end


end -- class TEST_SCREEN

-----------------------------------------------------------
-- Copyright (C) 1999-2009 Paul G. Crismer, Eric Fafchamps
-- Licensed under Eiffel Forum Freeware License, version 2
-- (see forum.txt)
-----------------------------------------------------------
