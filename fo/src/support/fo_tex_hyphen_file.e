indexing

	description:

		"Tex hyphenation files."

	library: "FO - Formatting Objects in Eiffel. Project SAFE."
	copyright: "Copyright (c) 2006 - , Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

class FO_TEX_HYPHEN_FILE

inherit
	KL_TEXT_INPUT_FILE
		redefine
			open_read
		end

create
	make

feature -- Access

	last_pattern : STRING

	last_hyph : STRING

feature -- Status report

	end_of_patterns : BOOLEAN

	end_of_hyphenation : BOOLEAN

feature -- Basic operations

	open_read is
		local
			done : BOOLEAN
		do
			Precursor
			if is_open_read then
				from

				until
					end_of_input or else done
				loop
					read_tex_word
					if not end_of_input and then last_tex_word.substring_index("\patterns{",1)=1 then
						done := True
					end
				end
				if end_of_input then
					close
				end
			end
			create last_pattern.make (10)
			create last_hyph.make (10)
		end

	read_pattern is
		do
			read_tex_word
			if last_tex_word.is_equal("}") then
				end_of_patterns := True
				search_for_hyphenation
			end
			if (not end_of_file or not end_of_patterns) and then last_string.count > 0 then
				analyze_pattern (last_tex_word)
			end
		end

	read_hyphenation is
		do
			read_tex_word
			if last_tex_word.is_equal ("}") then
				end_of_hyphenation := True
			end
		end

feature {NONE} -- Implementation

	last_tex_word : STRING

	read_tex_word is
			-- Read tex word, skip comments
		do
			from
				read_word
			until
				end_of_input or else (last_string.count > 0 and then last_string.item(1)/='%%')
			loop
				read_line
				if not end_of_input then
					read_word
				end
			end
			last_tex_word := last_string.twin
		end

	hyphenation_regex : RX_PCRE_REGULAR_EXPRESSION is
		once
			create Result.make
			Result.compile ("\\hyphenation\{")
		end

	patterns_regex: RX_PCRE_REGULAR_EXPRESSION is
		once
			create Result.make
			Result.compile ("\\patterns\{")
		end

	search_for_hyphenation is
		do
			from
				do_nothing
			until
				end_of_file or else hyphenation_regex.matches (last_tex_word)
			loop
				hyphenation_regex.wipe_out
				read_tex_word
			end
			if end_of_file then
				end_of_hyphenation := True
			end
		end

	analyze_pattern (a_pattern : STRING)  is
		local
			pattern_index : INTEGER
			i : INTEGER
			c : CHARACTER
			c1, c2 : CHARACTER
			k, n : CHARACTER
		do
			from
				last_pattern.wipe_out
				last_hyph.wipe_out
				i := 1
				pattern_index := 1
				n := '0'
			until
				i > a_pattern.count
			loop
				c := a_pattern.item (i)
				inspect c
				when '0'..'9' then
					n := c
					i := i + 1
				when '\' then
					c1 := a_pattern.item (i + 1)
					c2 := a_pattern.item (i + 2)
					k := translate_character (c1,c2)
					i := i + 3
				else
					k := c
					i := i + 1
				end
				if k /= '%U' then
					last_pattern.append_character (k)
					last_hyph.append_character (n)
					k := '%U'
					n := '0'
				end
			end
			last_hyph.append_character (n)
		ensure
			one_more:last_hyph.count-last_pattern.count = 1
		end

	translate_character (c1,c2 : CHARACTER) : CHARACTER is
		do
			inspect c1
			when '%'' then
				inspect c2
				when 'a' then
					Result := 'á'
				when 'e' then
					Result := 'é'
				when 'i' then
					Result := 'í'
				when 'o' then
					Result := 'ó'
				when 'u' then
					Result := 'ú'
				else

				end
			when '`' then
				inspect c2
				when 'a' then
					Result := 'à'
				when 'e' then
					Result := 'è'
				when 'i' then
					Result := 'ì'
				when 'o' then
					Result := 'ò'
				when 'u' then
					Result := 'ù'
				else

				end
			when '^' then
				inspect c2
				when 'a' then
					Result := 'â'
				when 'e' then
					Result := 'ê'
				when 'i' then
					Result := 'î'
				when 'o' then
					Result := 'ô'
				when 'u' then
					Result := 'û'
				else

				end
			when '¨' then
				inspect c2
				when 'a' then
					Result := 'ä'
				when 'e' then
					Result := 'ë'
				when 'i' then
					Result := 'ï'
				when 'o' then
					Result := 'ö'
				when 'u' then
					Result := 'ü'
				else

				end
			when 'o' then
				inspect c2
				when 'e'  then
					Result := 'œ'
				else

				end
			else

			end
		end

end
