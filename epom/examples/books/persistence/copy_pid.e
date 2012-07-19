indexing
	description: "Persitent identifiers for COPY objects"
	author: "Paul G. Crismer"
	date: "$Date$"
	revision: "$Revision$"

class
	COPY_PID
	
inherit
	PO_PID
	
	COPY_PERSISTENT_CLASS_NAME
		undefine
			is_equal
		end

create

	make
	
feature -- Initialization

	make (an_isbn : STRING; a_serial : INTEGER) is
			-- Make pid by `an_isbn', `a_serial'.
		require
			an_isbn_not_void:  an_isbn /= Void
			a_serial_gt0: a_serial > 0
		do
			isbn := an_isbn
			serial := a_serial
		ensure
			isbn_set: isbn = an_isbn
			serial_set: serial = a_serial
		end
	
feature -- Access

	isbn : STRING
	
	serial : INTEGER
	
feature -- Conversion

	as_string : STRING is
		do
			create Result.make_from_string (persistent_class_name)
			Result.append_character(',')
			Result.append_string (isbn)
			Result.append_character (',')
			Result.append_string (serial.out)
		end
		
invariant

	isbn_not_void:  isbn /= Void
	serial_greater_zero: serial > 0
	
end
