indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ZLIB_FORMAT

feature -- Access

feature -- Measurement

	last_encoded_count : INTEGER
	
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

	encode (s : STRING) : STRING is
			-- 
		local
			input, output : XS_C_STRING
			encoded_length : XS_C_INT32
			res : INTEGER
		do
			create input.make_from_string (s)
			create output.make ((s.count * 1.1).truncated_to_integer + 12)
			create encoded_length.make
			encoded_length.put (output.capacity)
			res := zlib_compress (output.handle, encoded_length.handle, input.handle, input.capacity)
			last_encoded_count := encoded_length.item
			Result := output.substring (1, last_encoded_count)
		end
		
feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

	zlib_compress (dest, dest_len, src : POINTER; src_len : INTEGER) : INTEGER is
		external "C"
		end
		
invariant
	invariant_clause: True -- Your invariant here

end -- class ZLIB_FORMAT
