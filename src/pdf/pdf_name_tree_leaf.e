indexing
	description: "PDF name tree leafs."
	author: "Paul G. Crismer"
	date: "$Date$"
	revision: "$Revision$"

class
	PDF_NAME_TREE_LEAF

inherit
	PDF_NAME_TREE_NODE
		redefine
			make
		end

create
	make

feature {NONE} -- Initialization

	make (object_number : INTEGER) is
		do
			precursor (object_number)
			create keys.make (1, capacity)
			create objects.make (1, capacity)
			count := 0
		ensure then
			count_zero: count = 0
		end

feature -- Access

	count : INTEGER

	lower_key : STRING is do if count > 0 then Result := keys.item (keys.lower) end
		ensure then
			void_if_count_zero: count = 0 implies Result = Void
			non_void: count > 0 implies Result /= Void
		end

	upper_key : STRING is do if count > 0 then Result := keys.item (count) end end

	key (index: INTEGER) : STRING is
		require
			valid_index: index > 0 and index <= count
		do
			Result := keys.item (index)
		ensure
			result_not_void: Result /= Void
		end

	value (index : INTEGER) : PDF_SERIALIZABLE is
		require
			valid_index: index > 0 and index <= count
		do
			Result := objects.item (index)
		ensure
			result_not_void: Result /= Void
		end

feature -- Measurement

	feature -- Status report

	valid_key (a_string : STRING) : BOOLEAN is
		do
			if a_string /= Void then
				if count > 0 then
					Result := a_string > lower_key
				else
					Result := True
				end
			end
		ensure
			definition0: Result implies a_string /= Void
			definition1: count > 0 implies (Result = (a_string > lower_key))
		end

feature -- Status setting

feature -- Cursor movement

feature -- Element change

	add (a_key : STRING; a_value : PDF_SERIALIZABLE) is
		require
			valid_key: valid_key (a_key)
			a_value_not_void: a_value /= Void
			count_lt_capacity: count < capacity
		do
			count := count + 1
			keys.put (a_key, count)
			objects.put (a_value, count)
		ensure
			one_more: count = old count + 1
			inserted: key (count) = a_key and then value (count) = a_value
		end

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

feature -- Obsolete

feature {PDF_NAME_TREE} -- Conversion

	content_array : STRING is
		local
			index : INTEGER
		do
			create Result.make (200)
			Result.append_string ("[%N")
			from
				index := 1
			until
				index > count
			loop
				Result.append_character ('(')
				Result.append_string (key (index))
				Result.append_string (") ")
				Result.append_string (value (index).to_pdf)
				Result.append_character ('%N')
				index := index + 1
			end
			Result.append_string ("]%N")
		end

feature {NONE} -- Implementation

	keys : ARRAY[STRING]
	objects : ARRAY[PDF_SERIALIZABLE]


	content_name : PDF_NAME is do Result := names.names end

invariant
	keys_not_void: keys /= Void
	objects_not_void: objects /= Void
	key_relation0: count = 1 implies upper_key = lower_key
	key_relation1: count > 1 implies upper_key > lower_key
end
