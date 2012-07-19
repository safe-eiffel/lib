indexing
	description: "PDF String."
	author: "Paul G. Crismer"
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

feature -- Conversion

	to_pdf : STRING is
		do
			create Result.make (value.count+2)
			Result.append_character ('(')
			Result.append_string (value)
			Result.append_character (')')
		end

invariant
	value_not_void: value /= Void

end
