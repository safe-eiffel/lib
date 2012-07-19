indexing

	description:

		"Adapters for BORROWER objects."

	copyright: "Copyright (c) 2004, Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

deferred class BORROWER_ADAPTER

inherit

	PO_ADAPTER[BORROWER]
	
	BORROWER_PERSISTENT_CLASS_NAME
	
	PO_CACHE_USE[BORROWER]
	
feature -- Access
			
feature -- Basic operations

	read_by_name_pattern (name_pattern : STRING) is
			-- Read by name like `name_pattern'.
		require
			name_pattern_not_void:  name_pattern /= Void
		deferred
		end

	read_by_id (id : INTEGER) is
			-- Read by `id'.
		require
			id_gt0: id > 0
		deferred
		end

feature {PO_ADAPTER} -- Factory

	create_pid_from_id (id : INTEGER) is
			-- Create PO_PID from `id'.
		require
			id_gt0: id > 0
		deferred
		ensure
			last_pid_created: last_pid /= Void
		end
		
end
