indexing
	description: "PDF Destinations"
	author: "Paul G. Crismer"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PDF_DESTINATION

inherit
	PDF_SERIALIZABLE
		redefine
			put_pdf
		end
		
feature -- Access

	page : PDF_PAGE

	type : PDF_NAME is 
		deferred
		end
		
feature -- Measurement

feature -- Status report

	fits (area : PDF_RECTANGLE) : BOOLEAN is
			-- does the destination fit within `area' ?
		require
			area_exists: area /= Void
		deferred
		end
		
feature -- Status setting

feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

	to_pdf : STRING is
		do
			Result := to_pdf_using_put_pdf
		end

	put_pdf (medium: PDF_OUTPUT_MEDIUM)	is
		do
			medium.put_string (array_begin)
			medium.put_string (page.indirect_reference)
			medium.put_string (array_element_separator)
			medium.put_string (type.to_pdf)
			put_content (medium)
			medium.put_string (array_end)
		end

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

feature -- Obsolete

feature -- Inapplicable

	number : INTEGER is do  end
	
feature {NONE} -- Implementation

	put_content (medium : PDF_OUTPUT_MEDIUM) is
			-- put additional content to `medium'
		require
			medium_exists: medium /= Void
		deferred			
		end

	array_begin : STRING is "[ "
	array_end : STRING is " ]"
	array_element_separator : STRING is " "

		
	names : PDF_NAME_CONSTANTS is
		once create Result end
	
invariant
	page_exists: page /= Void
	type_exists: type /= Void
	fits_page_mediabox: fits (page.mediabox)
	
end -- class PDF_DESTINATION
