indexing

	description:

		"Adapters for COPY objects."

	copyright: "Copyright (c) 2004, Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

deferred class COPY_ADAPTER

inherit

	PO_ADAPTER[COPY]

	COPY_PERSISTENT_CLASS_NAME
	
feature -- Access
			
feature -- Basic operations
		
	read_from_isbn_and_number (isbn : STRING; number : INTEGER) is
			--  read from  `isbn', `serial_number'
		require
			isbn_not_void:  isbn /= Void
			valid_number: number > 0
		deferred
		end
	
	read_from_isbn (isbn : STRING) is
			-- read copies identified by `isbn'
		require
			isbn_not_void:  isbn /= Void
		deferred
		end
		
	read_borrowed is
			-- Read all borrowed copies.
		deferred
		end
				
end
