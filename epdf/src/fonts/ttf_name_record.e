indexing
	description: "Summary description for {TTF_NAME_RECORD}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TTF_NAME_RECORD

create
	make_from_file

feature {NONE} -- Initialization

	make_from_file (otf : OPEN_TYPE_FONT_FILE)
		do
			otf.read_natural_16
			platform_id := otf.last_natural_16
			otf.read_natural_16
			platform_encoding_id := otf.last_natural_16
			otf.read_natural_16
			language_id := otf.last_natural_16
			otf.read_natural_16
			name_id := otf.last_natural_16
			otf.read_natural_16
			name_count := otf.last_natural_16
			otf.read_natural_16
			name_offset := otf.last_natural_16
		end

feature -- Access

	platform_id : NATURAL_16
			--USHORT	Platform ID.

	platform_encoding_id: NATURAL_16
			--USHORT	Platform-specific encoding ID.

	language_id: NATURAL_16
			--USHORT	Language ID.

	name_id: NATURAL_16
			--USHORT	Name ID.

	name_count: NATURAL_16
		--USHORT	String length (in bytes).

	name_offset: NATURAL_16
		--USHORT	String offset from start of storage area (in bytes).

	key : STRING_8
		do
			create Result.make(10)
			result.append_integer (platform_id)
			Result.append_character (',')
			Result.append_integer (platform_encoding_id)
			Result.append_character (',')
			Result.append_integer (language_id)
			Result.append_character (',')
			Result.append_integer (name_id)
		end

	name (storage : STRING) : UC_STRING
		do
			if platform_id = 0 or else platform_id = 3 then
				create Result.make_from_utf16 ( storage.substring (name_offset + 1, name_offset + name_count))
			else
				create Result.make_from_string ( storage.substring (name_offset + 1, name_offset + name_count))
			end
		end

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

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

invariant
	invariant_clause: True -- Your invariant here

end
