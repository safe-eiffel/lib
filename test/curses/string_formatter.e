indexing
	description: "Formatter for strings";
	date: "$Date$";
	revision: "$Revision$"

class 
	STRING_FORMATTER

feature -- Formatting commands

	format (a_format_string: STRING; a_string: STRING): STRING is
			-- Format 'a_string with `a_format_string,
			-- the format string must follow the directives of the
			-- 'C' standard sprintf function. Only one argument is supported.
		require
			a_format_string_exists: a_format_string /= Void
			a_string_exists: a_string /= Void
		local
			lptr : POINTER
			rc : INTEGER
		do
			!!Result.make(1024)
			lptr := pointer(Result.to_c)
			rc := sprintf (lptr, pointer(a_format_string.to_c), pointer(a_string.to_c))			
			Result.from_c (lptr)
		ensure
			not_void: Result /= Void
		end

	format_2 (a_format_string: STRING; an_integer: INTEGER; a_string: STRING; ): STRING is
			-- Format 'a_string with `a_format_string and `an_integer,
			-- the format string must follow the directives of the
			-- 'C' standard sprintf function. Only one * flag and one % is supported.
		require
			a_format_string_exists: a_format_string /= Void
			a_string_exists: a_string /= Void
		local
			lptr : POINTER
			rc : INTEGER
		do
			!!Result.make(1024)
			lptr := pointer(Result.to_c)
			rc := sprintf2 (lptr, pointer(a_format_string.to_c), an_integer, pointer(a_string.to_c))			
			Result.from_c (lptr)
		ensure
			not_void: Result /= Void
		end

feature {NONE} -- Implementation

	sprintf (the_result, a_format_string: POINTER; a_string: POINTER): INTEGER is
		external 
			"C (char*, const char*, char *) : EIF_INTEGER | %"stdio.h%""
	end

	sprintf2 (the_result, a_format_string: POINTER; an_integer: INTEGER; a_string: POINTER): INTEGER is
		external 
			"C (char*, const char*, int, char*) : EIF_INTEGER | %"stdio.h%""
		alias
			"sprintf"
	end

	pointer (a : ANY) : POINTER is
		do
			Result := pointer_dummy($a)
		end

    	pointer_dummy (p : POINTER) : POINTER is
		do
			Result := p
		end




end -- class STRING_FORMATTER
-----------------------------------------------------------
-- Copyright (C) 1999 Paul G. Crismer, Eric Fafchamps
-- Licensed under Eiffel Forum Freeware License, version 1
-- (see forum.txt)
-----------------------------------------------------------
