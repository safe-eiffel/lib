note

	description:

			"SQL LONGVARCHAR (n) arrayed values."

	library: "ECLI : Eiffel Call Level Interface (ODBC) Library. Project SAFE."
	Copyright: "Copyright (c) 2001-2012, Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

class ECLI_ARRAYED_LONGVARCHAR

inherit

	ECLI_ARRAYED_STRING_VALUE

create

	make

feature -- Access

	sql_type_code : INTEGER
		do
			Result := Sql_longvarchar
		end

feature {NONE} -- Implementation

	default_maximum_capacity : INTEGER = 1_000_000

end
