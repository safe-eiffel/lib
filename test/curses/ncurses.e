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

creation
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
			
			standard_window.set_background(Blank, 0 ,0)

			--escape from curses mode

			from
				command := '0'
			until
				command = 'q'
			loop
				curses.save_terminal_state
				curses.escape_to_shell
				io.put_string ("*************************************%N%N");
				io.put_string ("a = keyboard and mouse (N/A) input test%N")
				io.put_string ("b = character attribute test%N")
				io.put_string ("c = color test pattern%N")
				--io.put_string ("d = edit RGB color values(N/A)%N")
				--io.put_string ("e = exercice soft keys%N")
				io.put_string ("f = display ACS characters%N")		
				io.put_string ("g = display windows and scrolling%N")
				--io.put_string ("i = test of flushinp()%N")
				io.put_string ("k = display character attributes%N")
				--io.put_string ("m = menu code test (N/A)%N")
				--io.put_string ("o = exercise panels library%N")	
				--io.put_string ("p = exercise pad features%N")
				io.put_string ("q = quit%N")
				--io.put_string ("r = exercise forms code (N/A)%N")
				--io.put_string ("s = overlapping-refresh test%N")
				--io.put_string ("t = set trace level%N")
				io.put_string ("? = repeat this command summary%N")
				io.put_string ("> ")
				io.output.flush
				io.read_character
				command := io.last_character

				curses.resume_from_shell
				curses.restore_terminal_state
				do_single_test (command)


				if (command = '?') then
					io.put_string ("This is the ecurses capability tester. %N")
					io.put_string ("You may select a test from the main menu by typing the%N")
					io.put_string ("key letter of the choice (the letter to the left of the = )%N")
					io.put_string ("at the > prompt. The commands 'x' or 'q' will exit.")
				end
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
				!GETCH_TEST!test.make_from_window (standard_window)					
			when 'b' then
				!ATTR_TEST!test.make_from_window(standard_window)
			when 'c' then
				if curses.has_colors then
					!COLOR_TEST!test.make_from_window(standard_window)
				else
					cannot (standard_window, "does not support color.")
					valid := False
				end
			when 'f' then
				!ACS_TEST!test.make_from_window(standard_window)
			when 'g' then
				!ACS_AND_SCROLL_TEST!test.make_from_window(standard_window)
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
-- Copyright (C) 1999 Paul G. Crismer, Eric Fafchamps
-- Licensed under Eiffel Forum Freeware License, version 1
-- (see forum.txt)
-----------------------------------------------------------
