indexing

	description: "Dictionary.  Array of (key,value) pairs."
	author: "Paul G. Crismer"
	licence: "Release under the Eiffel Forum licence.  See file 'forum.txt'."
	
class
	PDF_DICTIONARY

inherit
	PDF_SERIALIZABLE


creation
	make

feature -- Initialization

	make is
			-- 
		do
			!!impl_keys.make (1, 0)
			!!impl_values.make (1, 0)
			count := 0
		end
		
feature -- Access

	key (index : INTEGER) : STRING is
			-- 
		require
			good_index: index > 0 and index <= count
		do
			Result := impl_keys.item (index)
		end
		
	value (index : INTEGER) : PDF_SERIALIZABLE is
			--
		require
			good_index: index > 0 and index <= count
		do
			Result := impl_values.item (index)
		end
		
feature -- Measurement

	count : INTEGER
			-- count of dictionary entries
			
feature -- Status report

	has_key (a_key : STRING) : BOOLEAN is
			-- 
		require
			a_key /= Void
		local
			index : INTEGER
		do
			from 
				index := 1
			until
				index > count or else impl_keys.item (index).is_equal (a_key)
			loop				
				index := index + 1
			end
			Result := index <= count
		end

feature -- Element change

	add_entry (a_key : STRING; a_value : PDF_SERIALIZABLE) is
			-- 
		require
			a_key_valid: a_key /= Void
			a_value_valid: a_value /= Void
			not_duplicated: not has_key (a_key)
		do
			count := count + 1
			impl_keys.force (a_key, count)
			impl_values.force (a_value, count)
		ensure
			count = old count + 1
			key (count) = a_key
			value (count) = a_value
		end

feature -- Conversion

	to_pdf : STRING is
			-- 
		local
			index : INTEGER
		do
			!!Result.make (0)
			Result.append_string ("<< ")
			from 
				index := 1
			until
				index > count
			loop
				Result.append_character ('/')
				Result.append_string (key (index))
				Result.append_character (' ')
				Result.append_string (value (index).indirect_reference)
				Result.append_character ('%N')
				index := index + 1
			end
			Result.append_string (">> ") 
		end
		
feature {NONE} -- Implementation

	impl_keys : ARRAY[STRING]
	impl_values : ARRAY[PDF_SERIALIZABLE]
	
invariant
	invariant_clause: True -- Your invariant here

end -- class PDF_DICTIONARY
