indexing
	description: "ACS test";
	date: "$Date$";
	revision: "$Revision$"

class 
	ACS_TEST
inherit
	SINGLE_TEST

	KL_IMPORTED_INTEGER_ROUTINES
		export
			{NONE}
				all
		end
	
	CURSES_CHARACTER_CONSTANTS
		export
			{NONE}
				all
		end

	CURSES_ATTRIBUTE_CONSTANTS
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
			c: CHARACTER
			zero: CHARACTER
		do
			from
				c:= 'a'
				zero := '0'
			until
				c = 'x' or c = 'q'
			loop
				inspect c
				when 'a' then
					show_acs_chars
				when '0', '1', '2', '3' then
					
					show_upper_chars ((c.code - zero.code) * 32 + 128)
				else
				
				end
				window.move (curses.maximum_height - 3, 0)
				window.put_string ("Note: ANSI terminals may not display C1")
				window.move (curses.maximum_height - 2, 0)
				window.put_string ("Select: a=ACS, 0=C1, 1,2,3=GR characters, q=quit")
				window.refresh
				window.read_character
				c := window.last_character
			end
			pause (window)
			window.clear
		end


feature -- {NONE}

	show_acs_chars is
		local
			n: INTEGER	
		do
			window.clear
			window.enable_attribute (Attribute_bold)
			window.move (n, 20)
			window.put_string ("Display of the ACS Character Set")
			window.disable_attribute (Attribute_bold)
			window.refresh

			n := show_1_acs(0, "ACS_ULCORNER", Character_ulcorner)
			n := show_1_acs(n, "ACS_LLCORNER", Character_llcorner)
			n := show_1_acs(n, "ACS_URCORNER", Character_urcorner)
			n := show_1_acs(n, "ACS_LRCORNER", Character_lrcorner)
			n := show_1_acs(n, "    ACS_RTEE", Character_rtee)
			n := show_1_acs(n, "    ACS_LTEE", Character_ltee)
			n := show_1_acs(n, "    ACS_BTEE", Character_btee)
			n := show_1_acs(n, "    ACS_TTEE", Character_ttee)
			n := show_1_acs(n, "   ACS_HLINE", Character_hline)
			n := show_1_acs(n, "   ACS_VLINE", Character_vline)
			n := show_1_acs(n, "    ACS_PLUS", Character_plus)
			n := show_1_acs(n, "      ACS_S1", Character_s1)
			n := show_1_acs(n, "      ACS_S9", Character_s9)
			n := show_1_acs(n, " ACS_DIAMOND", Character_diamond)
			n := show_1_acs(n, " ACS_CKBOARD", Character_ckboard)
			n := show_1_acs(n, "  ACS_DEGREE", Character_degree)
			n := show_1_acs(n, " ACS_PLMINUS", Character_plminus)
			n := show_1_acs(n, "  ACS_BULLET", Character_bullet)
			n := show_1_acs(n, "  ACS_LARROW", Character_larrow)
			n := show_1_acs(n, "  ACS_RARROW", Character_rarrow)
			n := show_1_acs(n, "  ACS_DARROW", Character_darrow)
			n := show_1_acs(n, "  ACS_UARROW", Character_uarrow)
			n := show_1_acs(n, "   ACS_BOARD", Character_board)
			n := show_1_acs(n, " ACS_LANTERN", Character_lantern)
			n := show_1_acs(n, "   ACS_BLOCK", Character_block)
-- N/A			n := show_1_acs(n, "      ACS_S3", Character_s3)
-- N/A			n := show_1_acs(n, "      ACS_S7", Character_s7)
-- N/A			n := show_1_acs(n, "  ACS_LEQUAL", Character_lequal)
-- N/A			n := show_1_acs(n, "  ACS_GEQUAL", Character_gequal)
-- N/A			n := show_1_acs(n, "      ACS_PI", Character_pi)
-- N/A			n := show_1_acs(n, "  ACS_NEQUAL", Character_nequal)
-- N/A			n := show_1_acs(n, "ACS_STERLING", Character_sterling)

									
		end


	show_upper_chars (first: INTEGER) is
		local
			last: INTEGER
			code: INTEGER
			row: INTEGER
			col: INTEGER
			temp_string: STRING
			ut_integer_formatter: UT_INTEGER_FORMATTER
		do
			!!ut_integer_formatter
			last := first + 31
			window.clear
			window.enable_attribute (Attribute_bold)
			window.move (0, 20)
			window.put_string ("Display of ")
			if first = 128 then
				window.put_string ("C1")
			else
				window.put_string ("GR")
			end
			window.put_string (" Character Codes ")
			window.put_string (first.out)
			window.put_string (" of ")
			window.put_string (last.out)
			window.disable_attribute (Attribute_bold)
			window.refresh
			
			from
				code := first
			until
				code > last
			loop
				row := 4 + ((code - first) \\ 16)
				col := ((code - first) // 16) * curses.maximum_width // 2
				temp_string := ut_integer_formatter.decimal_integer_out (code)
				temp_string.append_string (" ")						
				ut_integer_formatter.append_octal_integer (temp_string, code)
				temp_string.append_string (" ")
				window.move (row, col)
				window.put_string (temp_string)
				if first = 128 then
					-- N/A nodelay

					window.disable_blocking_input
				end
				window.put (code)
				-- N/A echochar	
				if first = 128 then
					from
						window.read_character
					until
						window.last_key /= -1
					loop
						window.read_character
					end
					window.enable_blocking_input
				end
						
				code := code + 1		
			end
				
		end


	show_1_acs (n: INTEGER; name: STRING; code: INTEGER): INTEGER is
		local
			height, row, col : INTEGER
		do
			height := 16
			row := 4 + (n \\ height)
			col := (n // height) * curses.maximum_width // 2
			window.move (row, col)
			-- N/A %*s in vprintw
			window.put_string (name)
			window.put_string (" : ")
			window.put (code)
			Result := n + 1
		end

end -- class ACS_TEST
-----------------------------------------------------------
-- Copyright (C) 1999 Paul G. Crismer, Eric Fafchamps
-- Licensed under Eiffel Forum Freeware License, version 1
-- (see forum.txt)
-----------------------------------------------------------
