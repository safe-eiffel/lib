indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PDF_ACTION

inherit
	PDF_DICTIONARY
		redefine
			make
		end

create
	make_goto_destination,
	make_uri

feature {NONE} -- Initialization

	make is
		do
			Precursor
			add_entry (names.type.value, names.action)
		end

	make_goto_destination (a_destination : PDF_DESTINATION) is
		do
			make
			add_entry (names.s.value, names.goto)
			add_entry (names.d.value, a_destination)
		end

	make_uri (a_uri : UT_URI) is
		do
			make
			add_entry (names.s.value, names.uri)
			add_entry (names.uri.value, create {PDF_STRING}.make (a_uri.full_uri))
		end

feature -- Access

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

end
