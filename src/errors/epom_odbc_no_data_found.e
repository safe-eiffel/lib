indexing
	description: "ODBC NO DATA FOUND error after a database operation"
	author: "Fafchamps Eric"
	date: "$Date$"
	revision: "$Revision$"

class
	EPOM_ODBC_NO_DATA_FOUND

inherit
	UT_ERROR

creation
	make

feature {NONE} -- Initialization

	make (a_string: STRING) is
			-- Create a new error reporting an ODBC NO DATA FOUND ERROR.
		require
			a_string_not_void: a_string /= Void
		do
			!!parameters.make (1,1)
			parameters.put (a_string, 1)
		end
	

feature -- Access

	default_template: STRING is
			-- Default template used to built the error message
		do
			Result := "$0: An ODBC error occurs : %"$1%" ."
		end

	code: STRING is
			-- Error code
			-- (Might be useful to identify user-defined templates.)
		do
			Result := "EPOM_ODBC_NO_DATA_FOUND"
		end

invariant

	-- dollar0: $0 = program name
	-- dollar1: $1 = a_string

end -- class EPOM_ODBC_NO_DATA_FOUND



--
-- Copyright: 2001, Eric Fafchamps, <eric.fafchamps@belgacom.net>
-- Released under the Eiffel Forum License <www.eiffel-forum.org>
-- See file <forum.txt>
--
