indexing
	description: 
	
	"Destinations to page designated by page, with its contents magnified just enough %
 % to fit the rectangle specified by the coordinates left, bottom, right, and top %
 % entirely within the window both horizontally and vertically. If the required %
 % horizontal and vertical magnification factors are different, use the smaller of %
 % the two, centering the rectangle within the window in the other dimension."

	author: "Paul G. Crismer"
	
	date: "$Date$"
	revision: "$Revision$"

class
	PDF_DESTINATION_FIT_RECTANGLE

inherit
	PDF_DESTINATION

creation
	make

feature {NONE} -- Initialization

	make (destination : PDF_PAGE; area : PDF_RECTANGLE) is
		require
			destination_exists: destination /= Void
			area_exists: area /= Void
		do
			page := destination
			rectangle := area
		ensure
			page_set: page /= Void
			rectangle_set: rectangle /= Void
		end
		
feature -- Access

	rectangle : PDF_RECTANGLE
	
	type : PDF_NAME is do Result := names.fitr end
	
feature -- Measurement

feature -- Status report

	fits (area : PDF_RECTANGLE) : BOOLEAN is
		do
			Result := area.contains (rectangle)
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
			medium.put_string (Array_element_separator)
			medium.put_double (rectangle.llx)
			medium.put_string (Array_element_separator)
			medium.put_double (rectangle.lly)
			medium.put_string (Array_element_separator)
			medium.put_double (rectangle.urx)
			medium.put_string (Array_element_separator)
			medium.put_double (rectangle.ury)			
		end
		
invariant
	invariant_clause: True -- Your invariant here

end -- class PDF_DESTINATION_FIT_RECTANGLE
