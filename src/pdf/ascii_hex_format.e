indexing
	description: "Objects that know the ASCII Hexadecimal format."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ASCII_HEX_FORMAT

inherit
	KL_IMPORTED_INTEGER_ROUTINES

feature -- Access
	
feature -- Measurement

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
			-- encode `data' 
		local
			hex : STRING
			index : INTEGER
		do
			from
				create Result.make (data.count * 2 + data.count // 40 + 1)
				index := 1
			until
				index > data.count
			loop
				hex := INTEGER_.to_hexadecimal (data.item (index).code,True)
				if hex.count < 2 then
					Result.append_character ('0')
				end
				Result.append_string (hex)
				if index \\ 40 = 0 then
					Result.append_character ('%N')
				end
				index := index + 1
			end
			Result.append_character ('>')
		end

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

end -- class ASCII_HEX_FORMAT
