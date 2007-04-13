indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PDF_EXPLICIT_DESTINATION

inherit
	PDF_DESTINATION

feature -- Access

	page : PDF_PAGE

	type : PDF_NAME is
		deferred
		end

feature -- Status report

	fits (area : PDF_RECTANGLE) : BOOLEAN is
			-- does the destination fit within `area' ?
		require
			area_exists: area /= Void
		deferred
		end

feature  -- Basic operations	

	put_pdf (medium: PDF_OUTPUT_MEDIUM)	is
		do
			medium.put_string (array_begin)
			medium.put_string (page.indirect_reference)
			medium.put_string (array_element_separator)
			medium.put_string (type.to_pdf)
			put_content (medium)
			medium.put_string (array_end)
		end

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

invariant
	type_exists: type /= Void
	page_exists: page /= Void
	fits_page_mediabox: fits (page.mediabox)

end
