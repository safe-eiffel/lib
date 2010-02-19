indexing
	description: "[
	OpenType font files.

Offset Table
Type	Name	Description
Fixed	sfnt version	0x00010000 for version 1.0.
USHORT	numTables	Number of tables.
USHORT	searchRange	(Maximum power of 2 <= numTables) x 16.
USHORT	entrySelector	Log2(maximum power of 2 <= numTables).
USHORT	rangeShift	NumTables x 16-searchRange.

	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	OPEN_TYPE_FONT_FILE

inherit
	KL_BINARY_INPUT_FILE
		export {ANY}
			last_natural_8,
			last_natural_16,
			last_natural_32,
			last_natural_64,
			read_natural_8,
			read_integer_8,
			read_integer_16,
			read_integer_32,
			read_integer_64,
			last_integer_8,
			last_integer_16,
			last_integer_32,
			last_integer_64,
			readable
		redefine
			open_read,
			read_natural_16,
			read_natural_32,
			read_natural_64
		end

create
	make

feature -- Access

	sfnt_version : NATURAL_32

	num_tables : NATURAL_16
	search_range : NATURAL_16
	entry_selector : NATURAL_16
	range_shift : NATURAL_16

	tables : DS_HASH_TABLE[TTF_TABLE_RECORD, STRING]

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

feature -- Element change

	read_natural_16
		local
			lo, hi: NATURAL_16
		do
			read_natural_8
			hi := last_natural_8
			read_natural_8
			lo := last_natural_8
			last_natural_16 := lo + hi.bit_shift_left (8)
		end

	read_natural_32
		local
			lo : NATURAL_32
			hi : NATURAL_32
		do
			read_natural_16
			hi := last_natural_16
			read_natural_16
			lo := last_natural_16
			last_natural := lo + hi.bit_shift_left (16)
		end

	read_natural_64
		local
			lo, hi : NATURAL_64
		do
			read_natural_32
			lo := last_natural_32
			read_natural_32
			hi := last_natural_32
			last_natural_64 := lo + hi.bit_shift_left (32)
		end

feature -- Miscellaneous

feature -- Basic operations

	open_read
		do
			Precursor
			if is_open_read then
				read_natural_32
				sfnt_version := last_natural_32
				read_natural_16
				num_tables := last_natural_16
				read_natural_16
				search_range := last_natural_16
				read_natural_16
				entry_selector := last_natural_16
				read_natural_16
				range_shift := last_natural_16
				read_tables (num_tables)
				read_ttf_wm
				read_names
			end
		end

	read_tables (n : INTEGER)
		local
			i : INTEGER
			l_name : STRING
			l_checksum, l_offset, l_length : NATURAL_32
		do
			create tables.make (n)
			from
				i := 1
			until
				i > n
			loop
				read_string (4)
				l_name := last_string.twin
				read_natural_32
				l_checksum := last_natural_32
				read_natural_32
				l_offset := last_natural_32
				read_natural_32
				l_length := last_natural_32
				tables.force (create {TTF_TABLE_RECORD}.make (l_name, l_checksum, l_offset, l_length), l_name)
				i := i + 1
			end
		end

	wm : TTF_WINDOWS_METRICS

	names: TTF_NAMES

	read_ttf_wm
		do
			go ((tables.item(c_os2)).offset.as_integer_32)
			create wm.make_from_file (Current)
		end

	read_names
		do
			go ((tables.item(c_name)).offset.as_integer_32)
			create names.make_from_file (Current)
		end

feature -- Obsolete

feature -- constants

	c_os2 : STRING = "OS/2"
	c_name : STRING = "name"

feature {NONE} -- Implementation

	read_fixed
		do

		end

invariant
	invariant_clause: True -- Your invariant here

end
