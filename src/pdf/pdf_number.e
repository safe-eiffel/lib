indexing
	description: "PDF Number."
	author: "Paul G. Crismer"
	date: "$Date$"
	revision: "$Revision$"

class
	PDF_NUMBER

inherit
	PDF_SERIALIZABLE

	PDF_NUMBER_OPERATORS

create
	from_double, from_integer

feature {NONE} -- Initialization

	from_double (initial_value: DOUBLE) is
		do
			value := initial_value
		ensure
			value_set: equal_numbers (value, initial_value)
		end

	from_integer (initial_value: INTEGER) is
		do
			value := initial_value
		ensure
			value_set: equal_numbers (value, initial_value)
		end

feature -- Access

	value : DOUBLE

	number : INTEGER is do end

feature -- Conversion

	to_pdf : STRING is
		do
			create Result.make (10)
			Result.append_string (formatted (value))
		end

end
