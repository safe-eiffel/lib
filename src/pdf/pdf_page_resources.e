indexing
	description: "Page resources."
	author: "Paul G. Crismer"
	date: "$Date$"
	revision: "$Revision$"

class
	PDF_PAGE_RESOURCES

inherit
	PDF_DICTIONARY
	
feature -- Initialization

feature -- Access

	fonts : PDF_DICTIONARY
	
	procset : ARRAY[STRING]
	
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

end -- class PDF_PAGE_RESOURCES
