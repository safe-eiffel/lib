indexing
	description: "Formatter for integer values";
	date: "$Date$";
	revision: "$Revision$"

class 
	INTEGER_FORMATTER

feature -- Formatting commands

	format (a_format_string: STRING; an_integer: INTEGER): STRING is
			-- Format 'an_integer with `a_format_string,
			-- the format string must follow the directives of the
			-- 'C' standard sprintf function. Only one argument is supported.
		require
			a_format_string_exists: a_format_string /= Void
		local
			lptr : POINTER
			rc : INTEGER
		do
			!!Result.make(1024)
			lptr := pointer(Result.to_c)
			rc := sprintf (lptr, pointer(a_format_string.to_c), an_integer)			
			Result.from_c (lptr)
		ensure
			not_void: Result /= Void
		end

feature {NONE} -- Implementation

	sprintf (the_result, a_format_string: POINTER; an_integer: INTEGER): INTEGER is
		external "C (char*, const char*, int) : EIF_INTEGER | %"stdio.h%""
	end

	pointer (a : ANY) : POINTER is
		do
			Result := pointer_dummy($a)
		end

    	pointer_dummy (p : POINTER) : POINTER is
		do
			Result := p
		end





end -- class INTEGER_FORMATTER
-----------------------------------------------------------
-- Copyright (C) 1999 Paul G. Crismer, Eric Fafchamps
-- Licensed under Eiffel Forum Freeware License, version 1
-- (see forum.txt)
-----------------------------------------------------------
