indexing
	description: "Virtual row on COPY Table."
	author: "Paul G. Crismer"
	date: "$Date$"
	revision: "$Revision$"

class
	COPY_ROW

feature -- Access

	isbn : STRING
	
	serial_number : INTEGER
	
	loc_store : INTEGER
	loc_shelf : INTEGER
	loc_row : INTEGER
	borrower : INTEGER
	
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

end -- class COPY_ROW
