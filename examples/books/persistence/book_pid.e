indexing
	description: "PIDs of BOOKs"
	author: "Paul G. Crismer"
	date: "$Date$"
	revision: "$Revision$"

class
	BOOK_PID
	
inherit
	PO_PID

creation
	--{BOOK_ADAPTER} 
	make_from_isbn
	
feature -- Initialization

	make_from_isbn (an_isbn : STRING) is
			-- make from `an_isbn'
		require
			an_isbn_exists: an_isbn /= Void
		do
			isbn := an_isbn
		ensure
			isbn_set: isbn = an_isbn
		end
		
	
feature -- Access

	class_name : BOOK_PERSISTENT_CLASS_NAME is once create Result.make end
	
	isbn : STRING
	
feature -- Basic operations

	to_string : STRING is
			-- 
		do
			create Result.make_from_string (class_name)
			Result.append_character(',')
			Result.append_string (isbn)
		end
		
feature {NONE} -- Implementation

invariant
	isbn_exists: isbn /= Void
	
end -- class BOOK_PID
