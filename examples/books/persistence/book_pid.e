indexing

	description:

		"PIDs of BOOKs"

	copyright: "Copyright (c) 2004, Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

class BOOK_PID
	
inherit

	PO_PID
	
	BOOK_PERSISTENT_CLASS_NAME
		undefine
			is_equal
		end

creation

	--{BOOK_ADAPTER} 
	make_from_isbn
	
feature -- Initialization

	make_from_isbn (an_isbn : STRING) is
			-- Make from `an_isbn'.
		require
			an_isbn_not_void:  an_isbn /= Void
		do
			isbn := an_isbn
		ensure
			isbn_set: isbn = an_isbn
		end
		
	
feature -- Access

	isbn : STRING
	
feature -- Basic operations

	as_string : STRING is
		do
			create Result.make_from_string (persistent_class_name)
			Result.append_character(',')
			Result.append_string (isbn)
		end
		
feature {NONE} -- Implementation

invariant

	isbn_not_void:  isbn /= Void
	
end
