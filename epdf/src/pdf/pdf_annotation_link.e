indexing
	description: "PDF Link annotations."
	author: "Paul G. Crismer"
	date: "$Date$"
	revision: "$Revision$"

class
	PDF_ANNOTATION_LINK

inherit
	PDF_ANNOTATION
		rename
			make as make_object
		end

create
	make_destination, make_uri

feature {NONE} -- Initialization

	make_destination (a_document : PDF_DOCUMENT; a_rectangle: PDF_RECTANGLE; a_destination : PDF_DESTINATION) is
			-- Link to 
		local
			action : PDF_ACTION
		do
			create action.make_goto_destination (a_destination)
			make (a_document, a_rectangle, action)
			destination := a_destination
		ensure
			registered: a_document.xref.last_object = Current
			destination_set: destination = a_destination
		end

	make (a_document : PDF_DOCUMENT; a_rectangle : PDF_RECTANGLE; an_action : PDF_ACTION) is
		do
			make_object (a_document.xref.count)
			a_document.xref.add_entry (Current)
			rect := a_rectangle
			setup_dictionary
			dictionary.add_entry (names.a.value, an_action)
		ensure
			registered: a_document.xref.last_object = Current
		end

	make_uri (a_document : PDF_DOCUMENT; a_rectangle : PDF_RECTANGLE; an_uri : UT_URI) is
		do
			make (a_document, a_rectangle, create {PDF_ACTION}.make_uri (an_uri))
			uri := an_uri
		ensure
			registered: a_document.xref.last_object = Current
			uri_set: uri = an_uri
		end

feature -- Access

	subtype : PDF_NAME is
		once
			Result := names.link
		end

	destination : PDF_DESTINATION

	uri : UT_URI

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

feature -- Conversion

feature {NONE} -- Implementation

end
