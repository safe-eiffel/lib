indexing
	description: "Test the keypad feature";
	date: "$Date$";
	revision: "$Revision$"

class 
	GETCH_TEST
inherit
	SINGLE_TEST

	UT_CHARACTER_CODES
		export
			{NONE}
				all
		end

	CURSES_KEY_CONSTANTS
		export
			{NONE}
				all
		end		

	KL_IMPORTED_INTEGER_ROUTINES
		export
			{NONE}
				all
		end


create
	make_from_window

feature -- Commands

	execute is
			-- Execute the test
		local
			line: STRING
			blocking: BOOLEAN
			stopreading: BOOLEAN
			firsttime: BOOLEAN
			exit: BOOLEAN
			c: INTEGER
			incount: INTEGER
			q1 : CURSES_FRAME_PANEL
			q2 : CURSES_PAD
			q3 : CURSES_EVENT_MANAGER
		do
			window.clear
			window.enable_metacharacters
			window.enable_keypad

			blocking := True

			window.put_string ("Delay in 10ths of a second (<CR> for blocking input)? ")
			curses.enable_echo
			window.read_line
			line := clone(window.last_string)
			curses.disable_echo
			curses.disable_cr_nl_translation

			if line.is_integer then
				window.set_blocking_input_timeout(line.to_integer)
				blocking := False
			end
			
			c := ('?').code
			from
				firsttime := True
			until
				exit
			loop
				if not firsttime then
					window.put_string ("Key pressed: ")
					-- N/A : octal output
					window.put_string (c.out)
					window.put_string (" ")
					if c >= Key_min then
						-- N/A keyname
						window.put_string (curses.key_name (c))
						window.put_string ("%N")
					else 
						if c > 128 then
						-- c2 = c & 0x7f
						-- ...
						else
							if c >= Space_code and c <= Right_brace_code then
								window.put_character (INTEGER_.to_character (c \\ 256))
								window.put_string (" (ASCII printable character)%N")
							else
								window.put_string (curses.printable_representation(c))
								window.put_string ("%N")
							end								
						end					
					end
					if window.cursor_y >= curses.maximum_height - 1 then
						window.move (0,0)
					end
					window.clear_to_bottom
				else
					firsttime := False
				end

				if INTEGER_.to_character (c \\ 256) = 'g' then
					window.put_string ("getstr test: ")
					curses.enable_echo
					window.read_line
					curses.disable_echo
					window.put_string ("I saw ")
					window.put_string (window.last_string)
					window.put_string (".%N")
				end

				if INTEGER_.to_character (c \\ 256) = 's' then
					shellout (window, True)
				end

				if INTEGER_.to_character (c \\ 256) = 'x' or INTEGER_.to_character(c \\ 256) = 'q' or (c = curses_error_value and blocking) then
					exit := True
				end

				if INTEGER_.to_character (c \\ 256) = '?' then
					window.put_string ("Type any key to see its keypad value.  Also:%N")
					window.put_string ("g -- triggers getstr test%N")
					window.put_string ("s -- shell out (bash) ... return from shell by typing 'exit'%N")
					window.put_string ("q -- quit%N")
					window.put_string ("? -- repeats this help message%N")
				end

				from
					stopreading := False
				until
					stopreading or exit
				loop
					window.read_character
					c := window.last_key
					if c /= curses_error_value then
						stopreading := True
					else
						if not blocking then
							window.put_string (incount.out)
							window.put_string (": input timed out%N")
						else
							window.put_string (incount.out)
							window.put_string (": input error%N")
							stopreading := True
						end
						incount := incount + 1
					end
				end
				window.refresh
			end
			
			window.enable_blocking_input					

		end

end -- class GETCH_TEST
-----------------------------------------------------------
-- Copyright (C) 1999 Paul G. Crismer, Eric Fafchamps
-- Licensed under Eiffel Forum Freeware License, version 1
-- (see forum.txt)
-----------------------------------------------------------
