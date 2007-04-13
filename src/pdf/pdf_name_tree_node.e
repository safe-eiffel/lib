indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PDF_NAME_TREE_NODE

inherit
	PDF_OBJECT
		redefine
			put_pdf
		end

feature -- Access

	lower_key : STRING is
		deferred
		end


	upper_key : STRING is
		deferred
		end

feature -- Measurement

	count : INTEGER is deferred end

	capacity : INTEGER is 10

feature -- Status report

feature -- Status setting

feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

feature -- Obsolete

feature -- Conversion

	to_pdf : STRING is
		do
			Result := to_pdf_using_put_pdf
		end

	put_pdf (medium : PDF_OUTPUT_MEDIUM) is
		do
			medium.put_string (object_header)
			medium.put_string (begin_dictionary)
			medium.put_string (dictionary_entry (names.limits, limits_array))
			medium.put_string (dictionary_entry (content_name, content_array))
			medium.put_string (end_dictionary)
			medium.put_string (object_footer)
		end

feature {NONE} -- Implementation

	limits_array : STRING is
		do
			create Result.make (100)
			Result.append_character ('[')
			Result.append_character ('(')
			Result.append_string (lower_key)
			Result.append_string (") (")
			Result.append_string (upper_key)
			Result.append_character (')')
			Result.append_character (']')
		ensure
			result_not_void: Result /= Void
		end

	content_array : STRING is
		deferred
		ensure
			result_not_void: Result /= Void
		end

	content_name : PDF_NAME is
		deferred
		end

	is_array_string (s : STRING) : BOOLEAN is
		require
			s_not_void: s /= Void
		do
			if s.count > 2 then
				Result := s.item (1) = '[' and then s.item (s.count) = ']'
			end
		ensure
			definition: s.count > 2 implies Result = (s.item (1) = '[' and then s.item (s.count) = ']')
		end

invariant
	invariant_clause: True -- Your invariant here

end
