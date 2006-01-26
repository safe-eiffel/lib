indexing
	description: "Objects that..."

	usage: ""
	quality: ""
	refactoring: ""

	status: "see notice at end of class";
	date: "$Date$";
	revision: "$Revision$";
	author: ""

class FO_PAGE

create

	make
		
feature {NONE} -- Initialization

	make (a_page : PDF_PAGE; a_section : FO_SECTION) is
		require
			a_page_not_void: a_page /= Void
			a_section_not_void: a_section /= Void
		do
			page := a_page
			section := a_section
		ensure
			page_set: page = a_page
			section_set: section = a_section
		end
		
feature -- Access

	page : PDF_PAGE
			-- Page.
			
	rendered_region : FO_RECTANGLE
			-- Rendered region in page.
		
	section : FO_SECTION
			-- Related section
			
feature -- Measurement

feature -- Comparison

feature -- Status report

feature -- Status setting

feature -- Cursor movement

feature -- Element change

	set_rendered_region (a_region : FO_RECTANGLE) is
		require
			a_region_not_void: a_region /= Void
		do
			rendered_region := a_region
		ensure
			rendered_region_set: rendered_region = a_region
		end
		
feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

feature -- Obsolete

feature -- Inapplicable

feature -- Constants

feature {NONE} -- Implementation

invariant

	

end


