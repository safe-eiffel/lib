indexing
	description: 
	
	"Destinations to page designated by page, with the horizontal coordinate left positioned %
 % at the left edge of the window and the contents of the page magnified %
 % just enough to fit the entire height of the page within the window."
 
	author: "Paul G. Crismer"
	
	date: "$Date$"
	revision: "$Revision$"

class
	PDF_DESTINATION_FIT_HORIZONTAL

inherit
	PDF_DESTINATION_FIT_VERTICAL
		rename
			top as left
		redefine
			type
		end
		
creation 
	make
	
feature -- Access

	type : PDF_NAME is do Result := names.fith end
	
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

end -- class PDF_DESTINATION_FIT_HORIZONTAL
