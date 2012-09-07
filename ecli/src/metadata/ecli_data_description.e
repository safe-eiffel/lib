note

	description:

			"Objects that describe SQL properties of data items; Usually got from catalog queries."

	library: "ECLI : Eiffel Call Level Interface (ODBC) Library. Project SAFE."
	Copyright: "Copyright (c) 2001-2012, Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

deferred class ECLI_DATA_DESCRIPTION

inherit

	ANY
		redefine
			is_equal
		end

feature -- Status report

	sql_type_code : INTEGER
			-- (redefine in descendant classes)
		deferred
		end

	column_precision : INTEGER_64
		obsolete "Use 'size' instead"
		do
			Result := size
		end

	size : INTEGER_64
			-- maximum number of 'digits' used by the data type
			-- for character and binary data : number of bytes or characters
			-- for numeric data : number of sigificant digits
			-- (redefine in descendant classes)
		deferred
		end

	decimal_digits : INTEGER
			-- decimal digits or scale
			-- (redefine in descendant classes)
		deferred
		end

feature -- Comparison

	is_equal (other : like Current) : BOOLEAN
			-- is Current equal to `other' ?
		do
			Result := same_description (other)
		ensure then
			same_code: Result implies (sql_type_code = other.sql_type_code)
			same_size: Result implies (size = other.size)
			same_decimal_digits: Result implies (decimal_digits = other.decimal_digits)
		end

	same_description (other : like Current) : BOOLEAN
		require
			other_not_void: other /= Void
		do
			Result := (sql_type_code = other.sql_type_code
								and then size = other.size
								and then decimal_digits = other.decimal_digits)
		ensure
			symmetry: Result implies other.same_description (Current)
		end

end
