indexing
	description: "Objects that know the ASCII 85 format"
	author: "Paul G. Crismer"
	date: "$Date$"
	revision: "$Revision$"

class
	ASCII_85_FORMAT

inherit
	XS_IMPORTED_UINT32_ROUTINES
	KL_IMPORTED_INTEGER_ROUTINES
	KL_IMPORTED_STRING_ROUTINES
	
feature -- Access

	last_encoded : STRING
	
feature -- Measurement

	last_encoded_count (medium : PDF_OUTPUT_MEDIUM) : INTEGER is
		do
			Result := 	last_encoded.count - 2 + last_encoded.occurrences ('%N') * (medium.eol_count - 1)
		end
		
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

	encode (data : STRING) : STRING is
			-- encode  `data' in ASCII85 format
		local
			hex : STRING
			index : INTEGER
			nibble : INTEGER
			remaining : INTEGER
			line_count : INTEGER
			s : STRING
		do
			from
				create Result.make (data.count * 5 // 4 + data.count // 40 + 1)
				index := 1
			until
				index > data.count
			loop
				nibble := UINT32_.add (data.item (index).code, UINT32_.multiply (nibble, 256))
				if index \\ 4 = 0 then
					s := as_ascii_85(nibble, 4)
					line_count := line_count + s.count
					Result.append_string (s)
					if line_count >= 80 then
						Result.append_character ('%N')
						line_count := 0
					end
				end	
				index := index + 1
			end
			remaining := (index - 1) \\ 4
			if remaining /= 0 then
				nibble := UINT32_.left_shift (nibble, remaining * 8)
				Result.append_string (as_ascii_85 (nibble, 4 - remaining)) 
			end
			Result.append_string ("~>")
			last_encoded := Result
		end

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

	as_ascii_85 (nibble : INTEGER; count : INTEGER) : STRING is
			-- 32 bits `nibble' as ascii85 for `count' bytes of information
		require
			count >= 1 and count <= 4
		local
			remainder, dividend, divisor, index, bang : INTEGER
		do
			if nibble = 0 and count = 4 then
				Result := "z"
			else
				from
					Result := STRING_.make_filled ('%/0/',5)
					index := 1
					dividend := nibble
					divisor := 85
					bang := ('!').code
				until
					index > 5
				loop
					remainder := UINT32_.remainder (dividend , divisor)
					dividend := UINT32_.divide (dividend, divisor)
					Result.put (INTEGER_.to_character (remainder + bang), 5 - index + 1)
					index := index + 1
				end
			end
			if count < 4 then
				Result.keep_head (count + 1)
			end				
		end

end -- class ASCII_85_FORMAT
