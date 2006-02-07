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

	make (hyphen_character : CHARACTER; tex_hyphen_file : FO_TEX_HYPHEN_FILE) is
		require
			tex_hyphen_file_not_void: tex_hyphen_file /= Void
			tex_hyphen_file_not_open: not tex_hyphen_file.is_open_read
		do
			hyphen := hyphen_character
			create dictionary.make
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
			until
				tex_hyphen_file.end_of_hyphenation
			loop
				add_hyphenation (clone (tex_hyphen_file.last_string))
				tex_hyphen_file.read_hyphenation
			end
		end
		
feature -- Access

	word : STRING
	
	hyphenated_word : STRING
	
	hyphen : CHARACTER

	hyphenation_position_vector : STRING
		
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
					if dictionary.found then
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
		ensure
			word_set: word = a_word
			hyphenated_word_not_void: hyphenated_word /= Void
		end

feature {NONE} -- Implementation

	dictionary : DS_TRIE [STRING]

	hyphenation : DS_HASH_TABLE [STRING, STRING]
		
	hword : STRING
			-- Word to be hyphenated, with begin and end marks '.'

	add_hyphenation (string : STRING) is			
		do
			
		end
		
	word_mark : CHARACTER is '.'

	setup_hyphenation is		
		require
			word_not_void: word /= Void
		do
			create hword.make (word.count + 2)
			hword.append_character (word_mark)
			hword.append_string (word)
			hword.append_character (word_mark)
			create hyphenation_position_vector.make_filled ('0', hword.count + 2)
		ensure
			hyphenation_position_vector_setup: hyphenation_position_vector /= Void and hyphenation_position_vector.occurrences (' ') = hyphenation_position_vector.count
		end
		
	setup_hyphenated_word is
		local
			hi, wi : INTEGER
		do
			create hyphenated_word.make (hword.count + 2)
			from
				hi := 2
				wi := 1
			until
				hi = hword.count
			loop
				if (hyphenation_position_vector.item (hi).code - ('0').code) \\ 2 > 0 then
					hyphenated_word.append_character (hyphen)
				end
				hyphenated_word.append_character (hword.item (hi))
				hi := hi + 1
			end
			if (hyphenation_position_vector.item (hi).code - ('0').code) \\ 2 > 0 then
				hyphenated_word.append_character (hyphen)
			end
		end
		
	handle_vector (vector : STRING; substring_start, substring_end : INTEGER) is
		local
			index : INTEGER
			d : INTEGER
		do
			from
				index := 1
				d := substring_start - 1
			until
				index > vector.count
			loop
				if hyphenation_position_vector.item (index + d) < vector.item (index) then
					hyphenation_position_vector.put (vector.item (index), index + d)					
				end
				index := index + 1
			end
		end
		
end

