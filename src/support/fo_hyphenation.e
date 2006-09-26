indexing

	description:

		"Objects that provide features for hyphenating a word."

	library: "FO - Formatting Objects in Eiffel. Project SAFE."
	copyright: "Copyright (c) 2006 - , Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

class FO_HYPHENATION

create
	make

feature {NONE} -- Initialization

	make (hyphen_character : CHARACTER; min_begin, min_end : INTEGER; tex_hyphen_file : FO_TEX_HYPHEN_FILE) is
			-- Make hyphenation with `hyphen_caracter', keeping `min_begin' and `min_end' characters at the start and at then
			-- end of words respectively and using `tex_hyphen_file' as input.
		require
			tex_hyphen_file_not_void: tex_hyphen_file /= Void
			tex_hyphen_file_not_open: not tex_hyphen_file.is_open_read
		local
			tester : KL_EQUALITY_TESTER[STRING]
		do
			hyphen := hyphen_character
			create dictionary.make
			minimum_begin := min_begin
			minimum_end := min_end
			from
				tex_hyphen_file.open_read
			until
				tex_hyphen_file.end_of_patterns
			loop
				tex_hyphen_file.read_pattern
				if not tex_hyphen_file.end_of_input then
					dictionary.put (clone (tex_hyphen_file.last_hyph), clone (tex_hyphen_file.last_pattern))
				end
			end
			from
				create exceptions.make (50)
				create tester
				exceptions.set_key_equality_tester (tester)
			until
				tex_hyphen_file.end_of_hyphenation
			loop
				add_hyphenation (clone (tex_hyphen_file.last_string))
				tex_hyphen_file.read_hyphenation
			end
		ensure
			minimum_begin_set: minimum_begin = min_begin
			minimum_end: minimum_end = min_end
		end

feature -- Access

	word : STRING

	lower_case_word : STRING

	hyphenated_word : STRING

	hyphenation_points : DS_LIST[INTEGER]
			-- List of substring ends for hyphenation.

	hyphen : CHARACTER

	hyphenation_position_vector : STRING

feature -- Measurement

	minimum_begin : INTEGER
			-- Minimum number of characters at word begin, without hyphenation.

	minimum_end : INTEGER
			-- Minimum number of characters at word end, without hyphenation.

feature -- Basic operations

	hyphenate (a_word : STRING) is
			-- Hyphenate `a_word'.
		require
			a_word_not_void: a_word /= Void
		local
			substring_begin, substring_end : INTEGER
			done_substring : BOOLEAN
		do
			word := a_word
			lower_case_word := word.as_lower
			exceptions.search (lower_case_word)
			if not exceptions.found then
				setup_hyphenation
				from
					substring_begin := 1
				until
					substring_begin > hword.count
				loop
					from
						substring_end := substring_begin
						done_substring := False
					until
						done_substring or else substring_end > hword.count
					loop
						dictionary.search_key (hword.substring (substring_begin, substring_end))
						if dictionary.found_key then
							if dictionary.found_item /= Void then
								handle_vector (dictionary.found_item, substring_begin, substring_end)
							end
						else
							done_substring := True
						end
						substring_end := substring_end + 1
					end
					substring_begin := substring_begin + 1
				end
				setup_hyphenated_word
			else
				hyphenated_word := exceptions.found_item
			end
			setup_hyphenation_points
		ensure
			word_set: word = a_word
			hyphenated_word_not_void: hyphenated_word /= Void
			hyphenation_points_not_void: hyphenation_points /= Void
		end

feature {NONE} -- Implementation

	dictionary : DS_TRIE [STRING]

	hyphenation : DS_HASH_TABLE [STRING, STRING]

	exceptions : DS_HASH_TABLE [STRING, STRING]
			-- Hyphenation exceptions.

	hword : STRING
			-- Word to be hyphenated, w_indexth begin and end marks '.'

	add_hyphenation (string : STRING) is
		local
			key : STRING
			i : INTEGER
			c : CHARACTER
		do
			create key.make (string.count)
			from
				i := 1
			until
				i > string.count
			loop
				c := string.item (i)
				if c /= hyphen then
					key.append_character (c)
				end
				i := i + 1
			end
			exceptions.force (string, key)
		end

	word_mark : CHARACTER is '.'

	setup_hyphenation is
		require
			word_not_void: word /= Void
		do
			create hword.make (lower_case_word.count + 2)
			hword.append_character (word_mark)
			hword.append_string (lower_case_word)
			hword.append_character (word_mark)
			create hyphenation_position_vector.make_filled ('0', lower_case_word.count + 3)
		ensure
			hyphenation_position_vector_setup: hyphenation_position_vector /= Void and hyphenation_position_vector.occurrences ('0') = hyphenation_position_vector.count
			hyphenation_position_vector_count: hyphenation_position_vector.count = lower_case_word.count + 3
		end

	setup_hyphenated_word is
		local
			h_index, w_index : INTEGER
			end_index : INTEGER
		do
			create hyphenated_word.make (hword.count + 2)
			--| copy minimum substring
			hyphenated_word.append_string (word.substring (1, minimum_begin))
			from
				w_index := minimum_begin + 1
				h_index := w_index + 1
				end_index := hword.count - minimum_end + 1
			until
				h_index = hword.count
			loop
				if (hyphenation_position_vector.item (h_index).code - ('0').code) \\ 2 > 0 then
					hyphenated_word.append_character (hyphen)
				end
				hyphenated_word.append_character (word.item (w_index))
				h_index := h_index + 1
				w_index := w_index + 1
			end
			if (hyphenation_position_vector.item (h_index).code - ('0').code) \\ 2 > 0 then
				hyphenated_word.append_character (hyphen)
			end
			hyphenated_word.append_string (word.substring (end_index, word.count))
		end

	setup_hyphenation_points is
		require
			hyphenated_word_not_void: hyphenated_word /= Void
		local
			point, i : INTEGER
		do
			create {DS_LINKED_LIST[INTEGER]}hyphenation_points.make
			from
				i := 1
				point := 1
			until
				i > hyphenated_word.count
			loop
				if hyphenated_word.item (i) = hyphen then
					hyphenation_points.put_last (point-1)
				else
					point := point + 1
				end
				i := i + 1
			end
		end

	handle_vector (vector : STRING; substring_start, substring_end : INTEGER) is
		local
			index : INTEGER
			k : INTEGER
		do
			from
				index := 1
--				d := substring_start - 1
			until
--				index > vector.count
				index > vector.count
			loop
--				if hyphenation_position_vector.item (index + d) < vector.item (index) then
--					hyphenation_position_vector.put (vector.item (index), index + d)
--				end
				k := substring_start - 1 + index
				if hyphenation_position_vector.item (k) < vector.item (index) then
					hyphenation_position_vector.put (vector.item (index), k)
				end
				index := index + 1
			end
		end

invariant

	minimum_begin_positive: minimum_begin > 0
	minimum_end_positive: minimum_end > 0
end

