indexing
	description: "Page mode constants. PDF Reference 3.6.1."
	author: "Paul G. Crismer"
	date: "$Date$"
	revision: "$Revision$"

class
	PDF_PAGE_MODE_CONSTANTS

feature -- Constants

	mode_use_none : STRING is "UseNone"
		-- Mode where Neither document outline nor thumbnail images visible

	mode_use_outlines : STRING is "UseOutlines"
		-- Mode where Document outline visible

	mode_use_thumbs : STRING is "UseThumbs"
		--  Mode where Thumbnail images visible
		
	mode_full_screen : STRING is "FullScreen"
		-- Full-screen mode, with no menu bar, window controls, or any other window visible

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

end -- class PDF_PAGE_MODE_CONSTANTS
