indexing
	description: "[
		Summary description for {TTF_TABLE_RECORD}.

Type	Name	Description
ULONG	tag	4 -byte identifier.
ULONG	checkSum	CheckSum for this table.
ULONG	offset	Offset from beginning of TrueType font file.
ULONG	length	Length of this table.

	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TTF_TABLE_RECORD

create
	make

feature {NONE} -- Initialization

	make (a_name : STRING; a_checksum, an_offset, a_length : NATURAL_32)
		do
			name := a_name
			checksum := a_checksum
			offset := an_offset
			length := a_length
		end

feature -- Access

	name : STRING
			-- Table name

	checksum : NATURAL_32
	offset : NATURAL_32
	length: NATURAL_32

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
