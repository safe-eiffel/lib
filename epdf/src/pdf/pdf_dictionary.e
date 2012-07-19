indexing

	description: "Dictionary.  Array of (key,value) pairs."
	author: "Paul G. Crismer"
	licence: "Release under the Eiffel Forum licence.  See file 'forum.txt'."

class
	PDF_DICTIONARY

inherit
	PDF_SERIALIZABLE

create
	make

feature -- Initialization

	make is
			--
		do
			create impl_keys.make (1, 0)
			create impl_values.make (1, 0)
			count := 0
		end

feature -- Access

	key (index : INTEGER) : STRING is
			-- key at `index'-th item
		require
			good_index: index > 0 and index <= count
		do
			Result := impl_keys.item (index)
		end

	value (index : INTEGER) : PDF_SERIALIZABLE is
			-- value at `index-th' item
		require
			good_index: index > 0 and index <= count
		do
			Result := impl_values.item (index)
		end

	index_of_value (object : like value) : INTEGER is
			-- index of `object', if present; zero if not present
		require
			object_exists: object /= Void
		do
			Result := 1
			if count > 0 then
				from
				until
					Result > count or else value (Result).number = object.number
				loop
					Result := Result + 1
				end
			end
			if Result > count then
				Result := 0
			end
		ensure
			Result_not_zero: Result > 0 implies value (Result) = object
			result_zero: Result = 0 implies not has_value (object)
		end

	index_of_key (a_key : like key) : INTEGER is
			-- index of `a_key', if present; zero if absent.
		require
			a_key_not_void: a_key /= Void
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
			if Result = count then
				Result := 0
			end
		ensure
			Result_not_zero: Result > 0 implies  key (Result).is_equal (a_key)
			result_zero: Result = 0 implies not has_key (a_key)
		end

feature -- Measurement

	count : INTEGER
			-- count of dictionary entries

feature -- Status report

	has_key (a_key : STRING) : BOOLEAN is
			-- Does Current have `a_key' as key ?
		require
			a_key /= Void
		do
			Result := index_of_key (a_key) > 0
		end

	has_value (a_value : like value) : BOOLEAN is
			-- Does Current have `a_value' as value ?
		require
			a_value_not_void: a_value /= Void
		local
			index : INTEGER
		do
			index := index_of_value (a_value)
			Result := (index >= 1 and then index <= count)
		end

feature -- Element change

	add_entry (a_key : STRING; a_value : PDF_SERIALIZABLE) is
			-- add entry (`a_key', `a_value')
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

	replace_entry (a_key : STRING; a_value : PDF_SERIALIZABLE) is
			-- replace entry at `a_key' by `a_value'.
		require
			a_key_not_void: a_key /= Void
			has_a_key: has_key (a_key)
			a_value_not_void: a_value /= Void
		local
			index : INTEGER
		do
			index := index_of_key (a_key)
			impl_values.put (a_value, index)
		ensure
			entry_replaced: value (index_of_key(a_key)) = a_value
		end

feature -- Conversion

	to_pdf : STRING is
			-- PDF representation
		local
			index : INTEGER
		do
			create Result.make (0)
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
--				if index \\ 10 = 0 then
					Result.append_character ('%N')
--				else
--					Result.append_character ('%N')
--				end
				index := index + 1
			end
			Result.append_string (">> ")
		end

feature {NONE} -- Implementation

	impl_keys : ARRAY[STRING]
	impl_values : ARRAY[PDF_SERIALIZABLE]

	number : INTEGER is do  end

invariant
	invariant_clause: True -- Your invariant here

end -- class PDF_DICTIONARY
