indexing
	description: 
	
	"Destinations to page designated by page, with the vertical coordinate top positioned %
 % at the top edge of the window and the contents of the page magnified %
 % just enough to fit the entire width of the page within the window."
	
	author: "Paul G. Crismer"
	date: "$Date$"
	revision: "$Revision$"

class
	PDF_DESTINATION_FIT_VERTICAL

inherit
	PDF_DESTINATION

creation
	make
	
feature {NONE} -- Initialization

	make (destination : PDF_PAGE; location : DOUBLE) is
		require
			destination_exists: destination /= Void
			location_positive: location >= 0
		do
			page := destination
			top := location
		ensure
			page_set: page = destination
			put_location: top = location
		end
		
feature -- Access

	type : PDF_NAME is do Result := names.fitv end
	
	top : DOUBLE
	
feature -- Measurement

feature -- Status report

	fits (area : PDF_RECTANGLE) : BOOLEAN is
		do
			Result := area.has_point (area.llx,top.truncated_to_integer)
		end
		
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

	put_content (medium : PDF_OUTPUT_MEDIUM) is
		do
			medium.put_string (array_element_separator)
			medium.put_double (top)
		end
		
invariant
	invariant_clause: True -- Your invariant here

end -- class PDF_DESTINATION_FIT_VERTICAL
