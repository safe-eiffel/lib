indexing

	description:

		"Objects that provide an EiffelBase implementation for PO_ADAPTERs"

	copyright: "Copyright (c) 2004, Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

deferred class PO_ADAPTER_IMPL[G->PO_PERSISTENT]

inherit

	PO_ADAPTER[PO_PERSISTENT]

feature -- Access
	
	datastore: PO_DATASTORE

	last_cursor: PO_CURSOR [G]
	
	last_object: G

	last_pid: PO_PID

feature -- Status report

--	is_error: BOOLEAN
--	is_pid_valid (p: like last_pid): BOOLEAN is do  end

	
feature -- Measurement

	count: INTEGER

feature {PO_LAUNCHER} -- Element change

	set_datastore (a_datastore: PO_DATASTORE) is
		do
			datastore := a_datastore
		end
		
feature -- Basic operations

	exists (p: like last_pid): BOOLEAN  is do  end
	create_pid_from_object (an_object: G) is do  end
	read (pid: like last_pid) is do  end
	delete (object: like last_object) is do  end
	refresh (object: like last_object) is do  end
	update (object: like last_object) is do  end
	write (object: like last_object) is do  end
	
invariant

	invariant_clause: True -- Your invariant here

end
