indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PDF_STRING

inherit
	PDF_SERIALIZABLE

create
	make

feature {NONE} -- Initialization

	make (a_string : STRING) is
		do
			value := a_string
		ensure
			value_set: value = a_string
		end

feature -- Access

	value : STRING

	number : INTEGER is do  end

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

	to_pdf : STRING is
		do
			create Result.make (value.count+2)
			Result.append_character ('(')
			Result.append_string (value)
			Result.append_character (')')
		end


feature {NONE} -- Implementation

invariant
	value_not_void: value /= Void

end
