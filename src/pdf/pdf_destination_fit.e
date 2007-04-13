indexing
	description:

	"Destinations to page designated by page, with its contents magnified just enough %
 % to fit the entire page within the window both horizontally and vertically. If %
 % the required horizontal and vertical magnification factors are different, use %
 % the smaller of the two, centering the page within the window in the other dimension."

	author: "Paul G. Crismer"
	date: "$Date$"
	revision: "$Revision$"

class
	PDF_DESTINATION_FIT

inherit
	PDF_EXPLICIT_DESTINATION

creation
	make

feature {NONE} -- Initialization

	make (destination : PDF_PAGE) is
		require
			destination_exists: destination /= Void
		do
			page := destination
		ensure
			page_set: page = destination
		end

feature -- Access

	type : PDF_NAME is
		do
			Result := names.fit
		end

feature -- Measurement

feature -- Status report

	fits (area : PDF_RECTANGLE) : BOOLEAN is
		do
			Result := True
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

	put_content (medium : PDF_OUTPUT_MEDIUM) is do  end

invariant
	invariant_clause: True -- Your invariant here

end -- class PDF_DESTINATION_FIT
