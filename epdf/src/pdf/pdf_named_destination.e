indexing
	description: "Objects that give a name to a destination."
	author: "Paul G. Crismer"
	date: "$Date$"
	revision: "$Revision$"

class
	PDF_NAMED_DESTINATION

inherit
	PDF_DESTINATION
		redefine
			put_pdf
		end

create
	make

feature {NONE} -- Initialization

	make (a_name : STRING) is
		require
			a_name_not_void: a_name /= Void
		do
			name := a_name
		ensure
			name_set: name = a_name
		end

feature -- Access

	name : STRING

	type : PDF_NAME is do create result.make ("") end

feature -- Inapplicable

	fits (area : PDF_RECTANGLE) : BOOLEAN is
		do
			Result := True
		end

feature -- Basic operations

	put_pdf (medium : PDF_OUTPUT_MEDIUM) is
		do
			medium.put_string ("(")
			medium.put_string (name)
			medium.put_string (")")
		end

	put_content (medium : PDF_OUTPUT_MEDIUM) is
		do

		end

end
