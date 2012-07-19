indexing

	description:

		"Persistent identifiers for BORROWER objects"

	copyright: "Copyright (c) 2004, Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

class BORROWER_PID
	
inherit

	PO_PID
	
	BORROWER_PERSISTENT_CLASS_NAME
		undefine
			is_equal
		end
		
create

	{BORROWER_ADAPTER} make
	
feature -- Initialization

	make (an_id : INTEGER) is
			-- Make for `an_id'.
		require
			an_id_gt0: an_id > 0
		do
			id := an_id
		ensure
			id_set: id = an_id
		end
		
feature -- Access
	
	id : INTEGER
	
feature -- Conversion

	as_string : STRING is
		do
			create Result.make_from_string (persistent_class_name)
			Result.append_character(',')
			Result.append_string (id.out)
		end
		
invariant

	id_gt0: id > 0
	
end
