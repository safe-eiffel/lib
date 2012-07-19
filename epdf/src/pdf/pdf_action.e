indexing
	description: "PDF Actions."
	author: "Paul G. Crismer"
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
			-- Action Goto `a_destination'.
		require
			a_destination_not_void: a_destination /= Void
		do
			make
			add_entry (names.s.value, names.goto)
			add_entry (names.d.value, a_destination)
		end

	make_uri (a_uri : UT_URI) is
			-- Actuion URI `a_uri'
		require
			a_uri_not_void: a_uri /= Void
		do
			make
			add_entry (names.s.value, names.uri)
			add_entry (names.uri.value, create {PDF_STRING}.make (a_uri.full_uri))
		end


end
